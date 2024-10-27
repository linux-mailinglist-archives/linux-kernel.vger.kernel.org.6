Return-Path: <linux-kernel+bounces-383483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47439B1C5E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 08:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9961C20BBF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 07:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4AB3BBC5;
	Sun, 27 Oct 2024 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4+4KWol"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1A9217F3B
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730015478; cv=none; b=R8ukpkPvsfnjGQuwVyJFvj5A3tQdjQOVCzNJDAvSgSqd5kNeS1ADKwj28kAtawhEJ0/INrqjKY9CMRQL7+ZzwLIHJV8dDzRyWakVR+Mc7s++0wbAIXw0U3tPmQQSntwkiKjVltH9ISnpuFj9Eh3WG5A6aFzzJeL5BybpvUY8KhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730015478; c=relaxed/simple;
	bh=Uj8YHb20tEKiaPZtqNM+ZMy4m7dhNd739ojRiFbpwso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ueXGNRMgbQwiqNH49oeGCrc5bdb7gLebTgzqMlmlHotaOyc08mMDTLTfpClSzvQMR1ZQs9wspRnn6BtrmZgf+TKLo4V9o0k0jDymACoyUtq0z+tHF4jG24R6XaNFRjSn3Pv+thSzFfb9fdxZGy1OPoZe0WUun7mCStgFwt2OpBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4+4KWol; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7205646f9ebso1496766b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 00:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730015476; x=1730620276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgDp36psN/SPpIChNCHkaKRgeI9cFdiVtOP6OhBH41M=;
        b=Y4+4KWolkjSivtuFJ95NvjFMBHQUuPmiX37qm9ZSX/Fh+MM2BkLqxhrYMvR1IdmUNg
         JWsQL/KGE0eAmOEGmUWcAV1C4dprhGjOOXxbGlJTszUWY3D2Trm39fkDDzZmuttKp3Jb
         iCk9RseQBUnBPxx99TJtIj7nkhNwEkQpUbP7igNDxZ2ZRC56gwkOG8yg2jN5kCw+pH4I
         h7HNkMRk0Ac05VKvHXFvH8j+wx05fPaVP6KazX30ur6QvBFySrtVh+2bnTnztkce8h3S
         Wt0h/NTF9axdoUErdWBYagmO3yp4dL+2+6ufxOpzE97LbBjOfSqLpcK+NwMPeHZuG9pU
         7TqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730015476; x=1730620276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgDp36psN/SPpIChNCHkaKRgeI9cFdiVtOP6OhBH41M=;
        b=sC6cQfB4okxEVNq2zXHnt2D+cbg62vKyET7rfwQYi64qWcu0GYFusVcoqTJ0Q62jpo
         +VrQt2iNUtWGlnL876cOPBmE8ahlv8TVJkiH7APEjzwTG3u/faBspGvWkIdGJXRJM8eF
         KyacbMLbbfEljx0rOGUYAMW7onmTmQLhoGYpFLFJTy7CdV/mg3dOG3zHxfkotmP3FSqU
         xBYTGzT6G13ZJ9J73WrBC9RmE0hkZ15N0eogYhH7L2ZLV/yNGE0Y1iQCvbKXmeW2Xcbo
         iPG8dEGJJdQ4siwiN/qEZsKEyqxupRR3tX8wtOCWmdEBhX42RDvG4LvvCwtkJfqKS/OY
         0VAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGPekMBH+Jw92q09+ID0OsSqq8tp0Oqz1evoPhG2j528rNa/r4ewwWzU43XErVxpJm/21i+AmQ0VxloIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze5tULRKnbpwygCH2SL2gLUnXQvlxb27a/HlPKre/4R4TA1WW6
	nOz6HttPT4OpFqRqJ9KA0InVmiHioGEPxhW0qBdh895hhXSIjAyb
X-Google-Smtp-Source: AGHT+IGG3uZixxU7sLN89Y597B3CDnwHKYItbJPzYAlgedEPwGnEtMW8LACscypW5C35KUqgByz4Ew==
X-Received: by 2002:a05:6a00:2451:b0:71e:4dc5:259e with SMTP id d2e1a72fcca58-7206306f53dmr7211710b3a.17.1730015475827;
        Sun, 27 Oct 2024 00:51:15 -0700 (PDT)
Received: from fedora.. ([2405:201:d007:50c2:b7e7:6df3:9958:a45d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205794f9a1sm3785551b3a.90.2024.10.27.00.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 00:51:15 -0700 (PDT)
From: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jani.nikula@linux.intel.com
Cc: skhan@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] drm/edid: Convert cea_ext parsers to use struct cea_db *
Date: Sun, 27 Oct 2024 13:21:03 +0530
Message-ID: <20241027075108.14273-1-vamsikrishna.brahmajosyula@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Address the following
	FIXME: convert parsers to use struct cea_db
in the drm_edid cea_ext parsers.
1) drm_parse_hdmi_vsdb_video
2) drm_parse_hdmi_forum_scds
3) drm_parse_microsoft_vsdb
4) drm_parse_vcdb
5) drm_parse_hdr_metadata_block

These patches are pre-requisite to address another FIXME
/* FIXME: Transition to passing struct cea_db * everywhere. */
based on feedback from
https://lore.kernel.org/all/20241011152929.10145-1-vamsikrishna.brahmajosyula@gmail.com/
which will be sent in subsequent patch series.

In all the patches in this series,
db[n] has changed to data[n-1] since db={u8 len, u8 *data}.

Vamsi Krishna Brahmajosyula (5):
  drm/edid: convert drm_parse_hdmi_vsdb_video to use struct cea_db *
  drm/edid: convert drm_parse_hdmi_forum_scds to use struct cea_db *
  drm/edid: convert drm_parse_microsoft_vsdb to use struct cea_db *
  drm/edid: convert drm_parse_vcdb to use struct cea_db *
  drm/edid: convert drm_parse_hdr_metadata_block to use struct cea_db *

 drivers/gpu/drm/drm_edid.c | 126 +++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 60 deletions(-)


base-commit: 850925a8133c73c4a2453c360b2c3beb3bab67c9
-- 
2.47.0



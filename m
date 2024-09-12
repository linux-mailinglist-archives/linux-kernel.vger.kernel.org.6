Return-Path: <linux-kernel+bounces-326546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9355E9769CD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FC4284634
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0324B1A7265;
	Thu, 12 Sep 2024 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGwUs6O6"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C369E1A42DA;
	Thu, 12 Sep 2024 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145864; cv=none; b=Etn0wWGvGFuIr1y6g2TT4+/RT4hHvdDWW0Yc9suXp8k3ZAlSjZnoQ6LBkpfX54qq49Xt4zgNVtHvNrN0XBo8PYastjc4nKS4/VfLlu+LX7K6J4gvnIi12zmiIsl1E7hkX3fSh3FX0xTT1hQShPgp2OqgmEf2Oh1i25DvDSTdAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145864; c=relaxed/simple;
	bh=GHdrrCPZBSpx1b6Iq3VDSPGBIaEiUJ/gvyMfyBioWZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eM7F2FJhntE+ByF2wN8ED2dM6uWxJrZKeSNemhdmVRo3lvODGJbYt0xiuwsI5JFVwyKBY95AAfNtVUfhrek7YL2pjGPNW+QA0YLjpmF4yMGooUE6WgMaLurD8PPev9VBXDpMwRO8gnvwRDzrKwQAcB9l5U6DAeZC7r1SGBDUmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGwUs6O6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cd46f3ac9so8633945e9.3;
        Thu, 12 Sep 2024 05:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726145861; x=1726750661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=radmw+TmBlscrRZxkZ+tHMrAuVzmASyCuq4LLVLeMxk=;
        b=kGwUs6O6AwRYRJzvqLsqoN1drJn8AFTHDdjq586LmqjO16iHyg4Xzda7npeSRbHXqR
         u+u+Tkcn+3MPcmaVtyCiG0IKCqfAet/qgaKW8aNvcTTp9vAne/xZnYBwu8SimGMd2BbN
         3CBX46yNcZit1O9ML2JQSmimLxvJe//EjVdxQIaesW5Q2IP5XMq4Roa8mz2cgMvwXIcY
         9MBJl4sg+7Zj7vhZOlb7FioiwjfDIihddtL5ceNWnmpuwDNw2J/OlCRjBTkvMY5w4qXz
         nDHpBDDJ+T3pAdnpk/lkfwvI2+/jQafbjb997nsHVWoyeooEuo+0cT7vP7HTyA8xlhey
         +yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726145861; x=1726750661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=radmw+TmBlscrRZxkZ+tHMrAuVzmASyCuq4LLVLeMxk=;
        b=PaQC0KLFLmgWYgj34Tin0sGP4lJVFTGilW1bvjBUGwGqsyJd7+UucolXnyUely2EsQ
         D1Oq3MPFsTUwnexmpsyjEoeVEu0v/OxcvDZJy9cBD9y8vuKfwF/Fh2BeTT1NEy98wZll
         Q1xJzDX4E+CFFo+GudWJ8ww0PXOUWQPgW1qzhbpkMPROB5XRxEFpuCul+8O9gCwHR2XA
         7qtQhQCwhzWd2exnFESgaz5sDgrIzMRzwhLn0cBhz0XsgLLQ4TtBdvH/ClcryOGkKEVg
         0uh8t331ul2Yqq0fzSwVR7bKk10qXcPEubl/RNaXFjjvsKSNbpyci2lqIkLwcVgbjPQu
         AN8g==
X-Forwarded-Encrypted: i=1; AJvYcCUgfWQHzAVRZhidHOt+YZqqkGSLTxQ0bcz84qBTaA9kXHCSdyqWYS5MY+8CmXZw7rtwAUPtiRNkk6pIHnp6@vger.kernel.org, AJvYcCXjFandc2G3FDzFSDrPmiPGCWyXsTDRtnZsC6J7yy0dWTe6ylrSGZoN3ZTyClPYOXmCleWjOkJW7X9tYT1s13M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxdY8ajuzLIVCzfnNpOzt0k6FisUrh2VsWC8wn42OBKDfEowOu
	UmKejzrsXjvTqo+j7lpRAVrE0deK79T9uCwt8+mQXgYcBURpmWO4
X-Google-Smtp-Source: AGHT+IH4upBG1YMo8IZ9xkFa7vwnLeVv89WopCWiWfGSfCazpwQKdz/gbnuU8tS0Sds2dPgrxjO7cw==
X-Received: by 2002:a5d:6183:0:b0:374:c454:dbb3 with SMTP id ffacd0b85a97d-378c2d620femr1414942f8f.55.1726145860209;
        Thu, 12 Sep 2024 05:57:40 -0700 (PDT)
Received: from void.void ([141.226.9.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956653c6sm14313315f8f.32.2024.09.12.05.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 05:57:39 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Jyri Sarha <jyri.sarha@iki.fi>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] drm/tidss: Fix typos
Date: Thu, 12 Sep 2024 15:57:24 +0300
Message-ID: <20240912125735.45114-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/gpu/drm/tidss/tidss_dispc_regs.h | 2 +-
 drivers/gpu/drm/tidss/tidss_plane.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc_regs.h b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
index 13feedfe5d6d..e88148e44937 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc_regs.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
@@ -49,7 +49,7 @@ enum dispc_common_regs {
 /*
  * dispc_common_regmap should be defined as const u16 * and pointing
  * to a valid dss common register map for the platform, before the
- * macros bellow can be used.
+ * macros below can be used.
  */
 
 #define REG(r) (dispc_common_regmap[r ## _OFF])
diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
index a5d86822c9e3..1396bbf9616f 100644
--- a/drivers/gpu/drm/tidss/tidss_plane.c
+++ b/drivers/gpu/drm/tidss/tidss_plane.c
@@ -59,7 +59,7 @@ static int tidss_plane_atomic_check(struct drm_plane *plane,
 
 	/*
 	 * The HW is only able to start drawing at subpixel boundary
-	 * (the two first checks bellow). At the end of a row the HW
+	 * (the two first checks below). At the end of a row the HW
 	 * can only jump integer number of subpixels forward to the
 	 * beginning of the next row. So we can only show picture with
 	 * integer subpixel width (the third check). However, after
-- 
2.46.0



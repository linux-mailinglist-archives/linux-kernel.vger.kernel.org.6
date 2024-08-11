Return-Path: <linux-kernel+bounces-282421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B454F94E3BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 00:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C1B1F213C6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 22:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3141E160796;
	Sun, 11 Aug 2024 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqQATEL+"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365981804F
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723416599; cv=none; b=djnl9a1Cu5SWqVKaP+8dppwQ0eotFS2os8qv3SYZs9oURQ7NKBrX9TUnUKfeqfbx1iwFgDQKpx+6mAgMbJM9AQgCWS+TEDACa7M27mt7/WF1Gg1/iOGfph93D+Eag7PUL2KEFUAMFE2TVgfWBv2l8hSlOoHzh02rxFFmmtBkXeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723416599; c=relaxed/simple;
	bh=FXBKjlLXTrlcrzCbYbm+iDcthuQwykQo7gX43y48ECA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hHEcCyzFwbkRPz0KJKj7uWWG/lIdZf5bK5J94cRG/bRjzkA+ZevDxViJsseoHwtj8Kcq4EU0zQvW1A3COxb3eU7+rI/CqAajxWh5yMaiCW8FhMy0kdFJH0oti6nk9zNPHPNp1Dr9xcuF5Q/3v7Z44HirUTshBsBJLupJKlaefjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqQATEL+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-710ec581999so1090513b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 15:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723416597; x=1724021397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JGMkurdIhUlG4lZOHHU4BXtHWTQSg+0p8cfOF2uLcpg=;
        b=CqQATEL++YddpsldkgQYbgmSRFrNyXbkeHDRRH2UXOGll6HcJAB0rhssftHxJpA8uL
         X19/ulRGbK7W3QC3/e+fpe7QkmAx0Rzl07ltS12KNEGaEyXPnQGf239loFrjTJ90NY8y
         qZ7gSTEdGh4wK9UF9s32BcoWzJw5mEbszOPLOC9kxkt0xBMVjZTZxadFKAgR5/IFSwvJ
         hCxjkKQ1uX26SdO49WmYTHPnY5NVT2n7NoWekUKy+s1GG2gccAjx+R3A44NULa+89wKG
         2sEsn4pPzud2QgiSEJovFwAzn1SxbtdjXwwcHPkYNf68mBCa08Q4YckmNJCQU5qDVRb1
         GPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723416597; x=1724021397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGMkurdIhUlG4lZOHHU4BXtHWTQSg+0p8cfOF2uLcpg=;
        b=eVVRiIHRS8r4YwQ4IuW2wJ9cJeJirO7/YeqbulVqFX2FHSnM6fVAjLpSIk62hpWZyh
         Q8W6042xZzRyzS9i6efE0uqClndSjF1VstJIrJQt2t6R8vPg4xvVVWMRFD9ft9ZxHcFs
         yz5epePnWnQoXNrCwEZF+t4ZwYi8bEywx/rAeyjyzV31vGiLQF+TJAjo8F0P4vX85Ayo
         Id0FaBhOnsqLxGAlMpbVdWA4DlO40ioz1k2+0o0jz06mgeXmAZJM9AYTK5eqbSxpNuqJ
         hHQ036NOF97jrxFVHgbWY9CkXvcwyoFw/cX0GDoTX3ASh65AAp7iVhCa9Un9PT3iEQGv
         /zow==
X-Forwarded-Encrypted: i=1; AJvYcCVOdPt/qjQbT0ywCrnWDs3WQkCnU+2wY6iE7BlpQXqKIcc1xP7IpsasX8J3otg3E4yU7qg5wg6e/Cg3GuIzt+3hywWS9J54rakG/M0g
X-Gm-Message-State: AOJu0YzRqxkvh8GCQ39xgw1pceyKwrDSaO5zb061qd43nSDap3MwyVay
	N7v8t+9uuW/uDQnOWvWHATQNAhap6LYRWQ71ye+T080NzzgGWqdA
X-Google-Smtp-Source: AGHT+IE/NMsRaG0XrFEak/CPAmXm4dEMC0wESUuveUkRXgmeJd7QfDPnDY4/S2yQdmMUorWYFCVxUQ==
X-Received: by 2002:a05:6a00:3d43:b0:70d:2a5d:867f with SMTP id d2e1a72fcca58-710dcae83bemr10627333b3a.21.1723416597346;
        Sun, 11 Aug 2024 15:49:57 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5874ddcsm2822993b3a.28.2024.08.11.15.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 15:49:56 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	ioworker0@gmail.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	ziy@nvidia.com,
	yuanshuai@oppo.com
Subject: [PATCH v2 0/2] mm: collect the number of anon mTHP
Date: Mon, 12 Aug 2024 10:49:38 +1200
Message-Id: <20240811224940.39876-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Knowing the number of anon mTHPs in the system is crucial for performance
analysis. It helps in understanding the ratio and distribution of
mTHPs versus small folios throughout the system.

Additionally, partial unmapping by userspace can lead to significant waste
of mTHPs over time and increase memory reclamation pressure. We need this
information for comprehensive system tuning.

-v2:
 * don't rely on rmap to implement - 1, uses folio_free, split etc.
   Thanks for David's comment;
 * rename sys counters and refine doc. Thanks for Ryan's comment;

-v1:
 https://lore.kernel.org/all/20240808010457.228753-1-21cnbao@gmail.com/

Barry Song (2):
  mm: collect the number of anon large folios
  mm: collect the number of anon large folios on split_deferred list

 Documentation/admin-guide/mm/transhuge.rst | 10 ++++++++++
 include/linux/huge_mm.h                    | 16 ++++++++++++++--
 mm/huge_memory.c                           | 19 ++++++++++++++++---
 mm/migrate.c                               |  4 ++++
 mm/page_alloc.c                            |  5 ++++-
 mm/rmap.c                                  |  1 +
 6 files changed, 49 insertions(+), 6 deletions(-)

-- 
2.34.1



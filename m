Return-Path: <linux-kernel+bounces-417491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34DB9D54AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280651F23001
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903CA1CB331;
	Thu, 21 Nov 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdgf7X6T"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2199B199FC9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224238; cv=none; b=aBg6K51/AOQf1wycN74JVl1pzheB8ZdxXOnBMk5bHwa96gGZ5KifaJCR9LuMVueCoV3iRwyz4RcL0yGC0t30xkCVnv/YWzcoWeybsEE7eGkM6YIF8GpBtkBCja9jO1iPsH1MgBjmQzk8gEt1kTQS+gq+LvKHER8PN4VIJdMpOh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224238; c=relaxed/simple;
	bh=yRp7dDhIXH/IWg7+vMjMogStUG07cpKbBH7AhFAAGrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lNlXOLK6SxD1S5uNJUlYh5e2gvBgud+P7V+MsQtfiI0L4tQav8iDrR1dKUZq76wnfbbR5gb5Elk6gwgcyeVLdkeYUn46zXlFzeAytcG4UfKp3QI3Q/ay51aGP7KN7wRMVdd5pox4O7fAVho0rUIaTcVr8sH5hho+8hFpo5OM8mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdgf7X6T; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfaeed515bso1808804a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732224235; x=1732829035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vH5eEx92Lr2Szoo+88xQFIoldvHAb3MxjigQ5AJgHzY=;
        b=jdgf7X6TRsne12RnlK+8+Ufa184268Gn+xsmm3bB90HZk/Za4R7tvIA2OWAh6C27pV
         JNO93pZSsnEzaeO4gUk0Ox8ZCJy89ksSrn3qBeGaK3c3b8rVgBWiHoZEEn09OgQCvoaW
         yZeIKvSCGMIG2s6XfrS+wGHdZB4PBCTq179UfD4pb5IjaRz/rWN3JH8pY6U0bUGkUVOO
         syJLd7rAD2PFqsrNTFChDqe0yxGR8Ee+drLjuyO4/w8mHTI0dbbHzo0HSdVT+p6UQLZf
         zCS6dIIjd/znN2hlF6bfAf6uUqyLW0020iMOpEAUthv+3YZnGbu1yktY7cique0+qvdX
         gKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732224235; x=1732829035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vH5eEx92Lr2Szoo+88xQFIoldvHAb3MxjigQ5AJgHzY=;
        b=QSqf8jDbSFSoGgTtLOAbw4zudApdMtmBd/mN1gJlepivcG03W9t62A1iGHJR7jUtHY
         AdoDu7w7mIc9E+5HQd3+yD0GM2m6ugYaqLWhBTGyEKxkIROyqzHU6JaI0H7MSftA8CYq
         eHDdyDapJkp37kqkgjJxd5t4Ga2C2c1svUjfIJeIOVf3HccI1pjORIiqbLDS2Ft+XR6P
         9VLvWFcTj4s6QSRBcpIPfgI4Q+rUg0tBTbpH+ru5XurgOkqFd3XtWYfuWTGuKzHpCGek
         ANSzr4wBLPsxaflhaffUjcdrdFQ+6JEBBxQ5pBpzboo4vd+UGSRrtdtisrICH8qdQvNv
         GLLA==
X-Forwarded-Encrypted: i=1; AJvYcCVJhHugRK72JdVBadRJSicQuqbYkcej1O8IY63lactbDA9GyAP2tkQc6SyVjkPgp6WgSChIg8LFrrcR43k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ELXPucnXKANesVRcN11KIM+9Rk3NKYW1sAnFYVw+3Qq/MPS9
	+iF1A5V4CBpMrwI+r530BFDrYV2IL4gWpB9WsHOci8KyiWhf0flt
X-Gm-Gg: ASbGncug/BoJNbIsYIM2HT5jLE5nMly3W9t7fh2ccQdYYk09K3M/uypBrgmxt6Rixn+
	BpvAd8R85V43xIQvx5FTGN4CZZ1EPtpxW6Sg9XyFPgrSS5lMOh+yzegCNcKGHsIcBWSqY48pHKd
	CIrx8JMC1nNPsw5X6VyVLe7uiMiHCUZSKYciaH2fwM8CC5VcrA/b0lCx+wjxPO+4q5eo9pe3ALF
	o8LswVGibP9tN7ROl5DR6p+QGR4mxdJn9eMnLLQHlFaAgJk+tF/jaXn/lby2nU=
X-Google-Smtp-Source: AGHT+IEyyQ6mC5ziSyd6ZZ6fw2BVBUM7eBI02Y1PnnCrHrXI1brGl+EFb5EWLAKg2rV0EEkGts+4ew==
X-Received: by 2002:a05:6402:5201:b0:5cf:eaf7:2776 with SMTP id 4fb4d7f45d1cf-5d0205c6025mr149140a12.7.1732224235157;
        Thu, 21 Nov 2024 13:23:55 -0800 (PST)
Received: from localhost (dh207-40-8.xnet.hr. [88.207.40.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3fc94asm184056a12.58.2024.11.21.13.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 13:23:53 -0800 (PST)
From: Mirsad Todorovac <mtodorovac69@gmail.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Mirsad Todorovac <mtodorovac69@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Francois Dugast <francois.dugast@intel.com>,
	Philippe Lecluse <philippe.lecluse@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Akshata Jahagirdar <akshata.jahagirdar@intel.com>,
	David Kershner <david.kershner@intel.com>
Subject: [PATCH v1 1/1] drm/xe: fix the ERR_PTR() returned on failure to allocate tiny pt
Date: Thu, 21 Nov 2024 22:20:58 +0100
Message-ID: <20241121212057.1526634-2-mtodorovac69@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Running coccinelle spatch gave the following warning:

./drivers/gpu/drm/xe/tests/xe_migrate.c:226:5-11: inconsistent IS_ERR and PTR_ERR on line 228.

The code reports PTR_ERR(pt) when IS_ERR(tiny) is checked:

→ 211         pt = xe_bo_create_pin_map(xe, tile, m->q->vm, XE_PAGE_SIZE,
  212                                   ttm_bo_type_kernel,
  213                                   XE_BO_FLAG_VRAM_IF_DGFX(tile) |
  214                                   XE_BO_FLAG_PINNED);
  215         if (IS_ERR(pt)) {
  216                 KUNIT_FAIL(test, "Failed to allocate fake pt: %li\n",
  217                            PTR_ERR(pt));
  218                 goto free_big;
  219         }
  220
  221         tiny = xe_bo_create_pin_map(xe, tile, m->q->vm,
→ 222                                     2 * SZ_4K,
  223                                     ttm_bo_type_kernel,
  224                                     XE_BO_FLAG_VRAM_IF_DGFX(tile) |
  225                                     XE_BO_FLAG_PINNED);
→ 226         if (IS_ERR(tiny)) {
→ 227                 KUNIT_FAIL(test, "Failed to allocate fake pt: %li\n",
→ 228                            PTR_ERR(pt));
  229                 goto free_pt;
  230         }

Now, the IS_ERR(tiny) and the corresponding PTR_ERR(pt) do not match.

Returning PTR_ERR(tiny), as the last failed function call, seems logical.

Fixes: dd08ebf6c3525 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Francois Dugast <francois.dugast@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Philippe Lecluse <philippe.lecluse@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: José Roberto de Souza <jose.souza@intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Faith Ekstrand <faith.ekstrand@collabora.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
Cc: David Kershner <david.kershner@intel.com>
Cc: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
---
 v1:
	There is also the logical problem which this patch developer is not qualified to fix:
	first the fake pt tries to allocate size of (1 << (XE_PT_SHIFT=12)) = 4096 bytes,
	then "tiny pt" tries to allocate 2 * SZ_4K, twice as much. Is this what was meant
	to accomplish?

	drivers/gpu/drm/xe/xe_bo.h#L46:
	#define XE_PTE_SHIFT			12
	#define XE_PAGE_SIZE			(1 << XE_PTE_SHIFT)

	include/linux/sizes.h#L23:
	#define SZ_4K				0x00001000

 drivers/gpu/drm/xe/tests/xe_migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
index 1a192a2a941b..3bbdb362d6f0 100644
--- a/drivers/gpu/drm/xe/tests/xe_migrate.c
+++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
@@ -224,8 +224,8 @@ static void xe_migrate_sanity_test(struct xe_migrate *m, struct kunit *test)
 				    XE_BO_FLAG_VRAM_IF_DGFX(tile) |
 				    XE_BO_FLAG_PINNED);
 	if (IS_ERR(tiny)) {
-		KUNIT_FAIL(test, "Failed to allocate fake pt: %li\n",
-			   PTR_ERR(pt));
+		KUNIT_FAIL(test, "Failed to allocate tiny fake pt: %li\n",
+			   PTR_ERR(tiny));
 		goto free_pt;
 	}
 
-- 
2.43.0



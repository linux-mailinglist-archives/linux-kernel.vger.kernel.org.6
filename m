Return-Path: <linux-kernel+bounces-355818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BA6995786
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258A928A0D0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E97212EFD;
	Tue,  8 Oct 2024 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMsor15u"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5BA1F472B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728414998; cv=none; b=jRatHa1mvOpRYoxaOIJ69HLRxST7n2z/omK+7UKNA6zRANzAnLmgrTDHCwAU5elThGyv0BMKpTC8CJD4oZlCIgKJVK2xsHV/rpVbBTHoEZcl2mbJ06yEYFlsJbdmpU5kkRgHoz7v1R32JMCGuP3uw0aZ4A9Q1RjLU7jZ+RKB2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728414998; c=relaxed/simple;
	bh=YceFv62VB2PaAbJZ3O8Mb0rPDwzm/Q3npZBYOgM2RxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PkovC8DVDu8HJiJ9qULpXAOOKjTbtc3CzzT2Qxuf/4tSeVDn+y4RFKImX0PLqh+h8RbJTMSq+q2gQmvB8EQDPeSosv1AQzwCiQPYxiXuKC7bEEQzfNnYBb6RFE/5sGZjVmx8ra/AjyIEQakQklV+tsktizsUFq+WbwVeikb9a5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMsor15u; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71dfccba177so126874b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 12:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728414996; x=1729019796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7qu86Ysicdsx9sM/yuAIgyD1+rSLH54SdSYbKdh/+U=;
        b=NMsor15usH6mhHdSybffmkmgUrGsowI7c3IpsfwUfpxynaB420g7yprxIIsbPe44wk
         g9XRDJsYb0zuSmIpBcAdi26TXNBnCSIAULszFUt8nxUARJ+zZ4pzlwhikE8fEKL+V8BC
         ThY9n5ARIWFesvtOoHW4z7JkJeWHnPsA+bEgZuAr7OUFzl8wtx0j1PmYSm2aY1MWs5bI
         aXo9ZFeiAv/2WjtyHzXYDzgDVk97qW5DCIwGmgVzb/9Q50cWNfSZv7qdyCatAWDildon
         7jLOg2gHiRQkZUVggYcZAmJ9uQIIq7ik4JJPrp+eenKXie51DjC2n8jy04dcKHJ4zZlW
         nFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728414996; x=1729019796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7qu86Ysicdsx9sM/yuAIgyD1+rSLH54SdSYbKdh/+U=;
        b=GoQxtpv4vkrvZQkn8vTYyefa1+nRSYXpC0HKhjra3hchgruU+vAPj2qxFOp6ZLd+mo
         70/MXYPq2TJp0qRMcSrkVkFsY97oEQHCG2sVqgbSszHYXUSEXnK065NLW/tGBvi6c3y1
         wYaTrl6UKas/jGXwzM/RaYFX6CDjiI+CYIWNQ9+nvltQm6vSz273AD1uGcgQPVFoNce2
         Hmjch8YxK9dzsvGZO8kzFZpNx/pIOqNh+iphLUDaqt+t0Iuo9abHY75G7kwtiKwcSBek
         M5LA7HH34vHagvsO/CPrbYkA1jcW9oW6AmMg9dVCZw/uflgn+VIuRDIAo/Yc0FUYEHj2
         I4lA==
X-Forwarded-Encrypted: i=1; AJvYcCVP/XG4zSqKrj765RjYzqDY/8ih1mgQpNF0D2ZFmisTE9GfSdf/RVroyQUsLfnGq1dtwqr4w/zS6nmBRxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymyLqqlQJ+ZMENXb+04vuBreo6/KLPNzBtz7iFPPkbXRMBQEh1
	WiBXqKlwwRI0MI0YtiXulZdIyQJVDFopwGH2RE2g4MPL7Co6MU7X
X-Google-Smtp-Source: AGHT+IG11rsBrtdL3pEggLyoVCWr0nW6/pa+HBU7JaoO06ddPz9+dy2vVAYCq5o1iTlk25NJF+qmtw==
X-Received: by 2002:a05:6a00:c94:b0:71d:fbc9:e5b2 with SMTP id d2e1a72fcca58-71e1d6d2014mr169431b3a.14.1728414995947;
        Tue, 08 Oct 2024 12:16:35 -0700 (PDT)
Received: from advait-kdeneon.. ([2405:201:1e:f1d5:c7a7:6c1f:8104:8963])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dfea52097sm4650939b3a.103.2024.10.08.12.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 12:16:35 -0700 (PDT)
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	leo.liu@amd.com,
	sathishkumar.sundararaju@amd.com,
	saleemkhan.jamadar@amd.com,
	sonny.jiang@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com,
	Advait Dhamorikar <advaitdhamorikar@gmail.com>
Subject: [PATCH-next v3] drm/amdgpu: Cleanup shift coding style
Date: Wed,  9 Oct 2024 00:46:23 +0530
Message-Id: <20241008191623.8171-1-advaitdhamorikar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improves the coding style by updating bit-shift
operations in the amdgpu_jpeg.c driver file.
It ensures consistency and avoids potential issues
by explicitly using 1U and 1ULL for unsigned
and unsigned long long shifts in all relevant instances.


Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
---
v1->v2: address review comments
https://lore.kernel.org/lkml/CAJ7bepJrm9tJJMSZXz0B_94y8817X4oFpwnrTmUHeagOFgVL7g@mail.gmail.com/
v2->v3: update changelog and add additional 1U cleanups
https://lore.kernel.org/lkml/CADnq5_OgZvTgUDvDqDikoUh28jTRm2mOAVV6zAEtWE9RHTFkyA@mail.gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 95e2796919fc..995bc28b4fe6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -47,7 +47,7 @@ int amdgpu_jpeg_sw_init(struct amdgpu_device *adev)
 		adev->jpeg.indirect_sram = true;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
-		if (adev->jpeg.harvest_config & (1 << i))
+		if (adev->jpeg.harvest_config & (1U << i))
 			continue;
 
 		if (adev->jpeg.indirect_sram) {
@@ -73,7 +73,7 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
 	int i, j;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-		if (adev->jpeg.harvest_config & (1 << i))
+		if (adev->jpeg.harvest_config & (1U << i))
 			continue;
 
 		amdgpu_bo_free_kernel(
@@ -110,7 +110,7 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 	unsigned int i, j;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-		if (adev->jpeg.harvest_config & (1 << i))
+		if (adev->jpeg.harvest_config & (1U << i))
 			continue;
 
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j)
@@ -357,7 +357,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_set(void *data, u64 val)
 	if (!adev)
 		return -ENODEV;
 
-	mask = (1 << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings)) - 1;
+	mask = (1ULL << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings)) - 1;
 	if ((val & mask) == 0)
 		return -EINVAL;
 
@@ -388,7 +388,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_get(void *data, u64 *val)
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 			ring = &adev->jpeg.inst[i].ring_dec[j];
 			if (ring->sched.ready)
-				mask |= 1 << ((i * adev->jpeg.num_jpeg_rings) + j);
+				mask |= 1ULL << ((i * adev->jpeg.num_jpeg_rings) + j);
 		}
 	}
 	*val = mask;
-- 
2.34.1



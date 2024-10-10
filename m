Return-Path: <linux-kernel+bounces-358861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5EE9984D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D441F25BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D148D1C245D;
	Thu, 10 Oct 2024 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktta9DT/"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB1333CD2;
	Thu, 10 Oct 2024 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728559329; cv=none; b=ckK8+gGX1GK8HHBSF/FRBestU3QD1Q7voaJdBHEHGBr4RqWlPBTG678dkKeGG1+4uTVb7UHbwopcsBvL2b6OF6LuCvgVLR8ArN7HmpDyTH2voyjleBWkGYgzHb+OJ+qpEmuT9A9N6tMDsiB5MEfz8mdI2SZryVRTmHgc4tqK2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728559329; c=relaxed/simple;
	bh=xBOiaZ6QpT8eVqruUMXNPd/eR72qjUQHCYtEiemiRCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=P+Lnz2516vOmX01vq5kIU2BNoTA2WaY1x4sVfDs6CzGhmXm7mIH7Uaw+bI+SLxGi9u/3T4FI8w1wJQjl/Trl0fhb4L0huqK4sJch9yrPpIhA/UrhCLU4zX6+UXbIASFHF9Epxk+Oe8xg3QmFlCWsojqLdR1CkLE0HyoRwy3f/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktta9DT/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c883459b19so862645a12.2;
        Thu, 10 Oct 2024 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728559326; x=1729164126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JckSSufIviovUZkUcMEHSF3a41RUVzp568xffw5Iahs=;
        b=ktta9DT/XQk7fTlA3UjAg470IcLLuwX4dG+Sea6MoKkItpXMiS3e6mh84z6mPQBhlG
         LGTZR8sTstn/qUNUhc0ZTD8/emjhdr86Me3PHLzwzwVvRXIURzgZIRrQQB60GI0Xg5Pg
         LxQIu40l0ZUgzE+AuxGhlcbJHgV221l1Dz/+NTbsYfCHikU94kbjfaSQ7o169exn4/ux
         ndgz3fhoJZBm+cA141R3PEowDL/AkvSJwJLW9zRrrz9iDPiFyTR5kMJj7W1ZmziIkJz2
         wrdSQQnILBtAfHZwnMhklFFECQ8mxlueL8SwoR3yD0V8aqopMOQcwigkeSWH2/Hgcp35
         0jNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728559326; x=1729164126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JckSSufIviovUZkUcMEHSF3a41RUVzp568xffw5Iahs=;
        b=ghNW7qHVHmYtU+gXA5FzZJ4wBY7cIsRw+ijzZb8c/NjwtbLs4SgX73Vruhfo17dv82
         5bHGZ1zYr/rWAZLW9dnnBSGr6VWnapUYAImeAD5eoRTkvtJi1UxSq1BGxr/8W3wDac3Q
         OZe1SfRmfGSo4RwEOXBapbLKo5ayZ3jpAdGK3Uj/4G8T1SiH3f08PP/ZOBjxTyqRyobC
         JcDR90GVlJgCoPtf6bzrLP3wiQN7ZDqj9lB4siJrptzCU9bLySqbGyLf6ebrUOQD0PrM
         53rnjm951UVbtDFosschId1Yx2NSj50bUsZhPBNabljqH2ilwP/628Fn0+uuGzeWI5i/
         uMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ1m27wUytHF6lUQss+H3GSyDnTqEwe/r+wvDAHo4GJDyuQ3L+o9QelS+7vw3H8ztj/DHlxyfSNPsauZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1Ie5pwmXlCvqSx1kcL4lwJi1qZ44SdZYKPKd/lNmAlEMzVkq
	qx515IQneLZyxDd+R2+3eLIauEi2fxyGg26AGKTka9Y9eN2qPDXheTQuIpnD
X-Google-Smtp-Source: AGHT+IE9jQYtbc132fpV9cXJCTAdP6bxnOpxNEz+fnN/RwAvvgCjaaXajnFV2/oUWVMdVi2FqZHy0g==
X-Received: by 2002:a05:6402:548a:b0:5c8:9f3d:d906 with SMTP id 4fb4d7f45d1cf-5c91d5bd0b8mr3492737a12.18.1728559325850;
        Thu, 10 Oct 2024 04:22:05 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9370d22fesm640154a12.19.2024.10.10.04.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 04:22:05 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Leo Liu <leo.liu@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu: Fix potential integer overflow on shift of a int
Date: Thu, 10 Oct 2024 12:22:04 +0100
Message-Id: <20241010112204.636188-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The left shift of int 32 bit integer constant 1 is evaluated using 32 bit
arithmetic and then assigned to and operated upon using a 64 bit unsigned
integer. In the case where the shift is 32 or more this can lead to an
overflow. Avoid this by shifting using the BIT_ULL macro instead.

Fixes: f0b19b84d391 ("drm/amdgpu: add amdgpu_jpeg_sched_mask debugfs")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 95e2796919fc..136a0c8d8c7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -357,14 +357,14 @@ static int amdgpu_debugfs_jpeg_sched_mask_set(void *data, u64 val)
 	if (!adev)
 		return -ENODEV;
 
-	mask = (1 << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings)) - 1;
+	mask = (BIT_ULL(adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings)) - 1;
 	if ((val & mask) == 0)
 		return -EINVAL;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 			ring = &adev->jpeg.inst[i].ring_dec[j];
-			if (val & (1 << ((i * adev->jpeg.num_jpeg_rings) + j)))
+			if (val & BIT_ULL((i * adev->jpeg.num_jpeg_rings) + j))
 				ring->sched.ready = true;
 			else
 				ring->sched.ready = false;
@@ -388,7 +388,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_get(void *data, u64 *val)
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 			ring = &adev->jpeg.inst[i].ring_dec[j];
 			if (ring->sched.ready)
-				mask |= 1 << ((i * adev->jpeg.num_jpeg_rings) + j);
+				mask |= BIT_ULL((i * adev->jpeg.num_jpeg_rings) + j);
 		}
 	}
 	*val = mask;
-- 
2.39.5



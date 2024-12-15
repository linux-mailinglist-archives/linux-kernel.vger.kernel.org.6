Return-Path: <linux-kernel+bounces-446388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43829F23B9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336F27A1100
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554D9183098;
	Sun, 15 Dec 2024 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gU01JShZ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191CC374FF
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734265743; cv=none; b=W3VeXRV3wLwuBAAqPC68O8Pg83WSwKOq8WNbHwFADi6271GVKPQ/y1SLeh9w3LkIfyesCfhPEfLoYZvyVHOpAL43aY4Nwk8QIxyqdNr4bkkgN4lZRpQJVBQ0JRw7hffwkaTgEYIi9LhWn740Rilal1GltO1oi8Bygl8lNdTwPE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734265743; c=relaxed/simple;
	bh=5X80d57jg2IFKmnuuhkK8v4YFcp19duqGS7KS9kggWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p47Xt0Egf4KH6vPPFvBbYlqxqeRDH6navOUpzYs5g/mlRiFgG5RLjY7Txan7DnnHPqiobauFNYF40nQk35pR2WQojTJ0934aA3pdAr0PZxQYTZ1z2YNPk6T74Jx9HcV9oQVo/TZLaSx6xjFhno98KM8qHY4yG7S/6AD8xx6/pIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gU01JShZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso5271666a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734265740; x=1734870540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bHWJV/LD4gPHZZNcXt29U0PATFI+oJ17IUeLcy4IdyI=;
        b=gU01JShZPSHs33iJ4yPvC+dO0KDoACAOJM2GoTgW9vWziAEtcEOeIYz/83dYUTwqVR
         XgRWG7vEVy/+0j9MU1ru7jSEXSa28XlRwAN6Mam627WwTmTg0V1+lzPQ9yihOAYdeCe0
         aCTdG3MSin3y1fUlJKJM+JqrjyzdmtHN4fgvHwXgm/xiFuhC46WKq9rSAlKF0tY0He1P
         /8w1K41ptN+5evW9rIyZo3bR1blXRjDvmDWh4nAPmmwfHTpxmmLMAhh/xH6I0kEbYLL5
         Z/wZziOu81P5tL+eMyi1DEFWXq94gD3Fp/PwoQTtb6WHV8vCz7sKGhM1lsqBgZMVb1qm
         wmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734265740; x=1734870540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHWJV/LD4gPHZZNcXt29U0PATFI+oJ17IUeLcy4IdyI=;
        b=E5QYx48bSCB7OAoBW1ZmoRVJsEiwOamD+ZDeP8IO+a147mxi08ZfEAR3DDJQlsqzNX
         vFrRw3z6C4XWBTsEcv5PtNaxHXhqc0ZVPirk34gLXUD+HJn246cUSFYiMo5ff/JKN1M2
         pb8t1JMndpICRh0phPvTBbP7wBBYYM44uWBPVeDTF0Lnvr0uCNDQ67sCmyHDK619Q9/u
         GUa4Z5yLuMHTwGpqaG+xpp9+31YQN08xzKGL1nt3iF7gub6mDqIfURYS3Ql4a2My0FIK
         P6m2v5I8hoanXeGrn4sVga8tpiRtuFYbnWpJdPd7fDAyec3HYwekQQ+lYrk/RQuYpjh7
         0sCw==
X-Forwarded-Encrypted: i=1; AJvYcCVp0/w5jdS0wz6DLWe7Q8Bn6go9KCY4BOKA3+KZGwn4ZXPSmYWOuQARB09LynHza7p7DR/+s76Fq9fn0PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEHQptlo7Nw1dnOoNac/YZqaMggHRh7GNd4hzFFW+rWnjmXKKv
	X07ALEfs3WHObuD4/eYvlUoll5TLucb/CjhFz5tOci5syfSk5Gkx
X-Gm-Gg: ASbGncvOXK8SCzggIQjYC0jsr/sD5ttuoUzE3k9/LjXPucw4rr4NR6KXj5k0yIhSb6E
	yOmNDJUJxKgfYYoW8kM90z8TZxqV0yQoed2cwBB+IQHmCjQ6eNVV94RGmn3ZDB0b1coyBsu218Q
	JFMtz5AaP1e/46/PnFB+ataLDjFOlO3yFVjRmE1OJPW7nU5vPsyFon0xSA7NIfexGzIJAGUCLLH
	a4MjSHF01sw/WnuzitZjQbuFu8AnppQ0PlkkARVesH7LIFISFei6+/uskmo47kYPSU=
X-Google-Smtp-Source: AGHT+IFs4h7kFQ1tBETm2pZSMvLI9Eb//palqWRPKxDQoSymF7Pdlu6jW09S5JdbUeT9M+3q91Focw==
X-Received: by 2002:a05:6402:348b:b0:5d0:8197:7ab3 with SMTP id 4fb4d7f45d1cf-5d63c2e5275mr7998238a12.3.1734265740122;
        Sun, 15 Dec 2024 04:29:00 -0800 (PST)
Received: from localhost.localdomain ([83.168.79.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ad187dsm2055327a12.28.2024.12.15.04.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 04:28:59 -0800 (PST)
From: Karol Przybylski <karprzy7@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	srinivasan.shanmugam@amd.com,
	Hawking.Zhang@amd.com,
	Jack.Xiao@amd.com,
	lijo.lazar@amd.com,
	Jesse.zhang@amd.com,
	tao.zhou1@amd.com
Cc: Karol Przybylski <karprzy7@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix potential integer overflow in scheduler mask calculations
Date: Sun, 15 Dec 2024 13:28:57 +0100
Message-Id: <20241215122857.927606-1-karprzy7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of 1 << i in scheduler mask calculations can result in an
unintentional integer overflow due to the expression being
evaluated as a 32-bit signed integer.

This patch replaces 1 << i with 1ULL << i to ensure the operation
is performed as a 64-bit unsigned integer, preventing overflow

Discovered in coverity scan, CID 1636393, 1636175, 1636007, 1635853

Fixes: c5c63d9cb5d3b drm/amdgpu: add amdgpu_gfx_sched_mask and amdgpu_compute_sched_mask debugfs
Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 69a6b6dba0a5..8fb6c5f6a060 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2050,7 +2050,7 @@ static int amdgpu_debugfs_gfx_sched_mask_set(void *data, u64 val)
 	if (!adev)
 		return -ENODEV;
 
-	mask = (1 << adev->gfx.num_gfx_rings) - 1;
+	mask = (1ULL << adev->gfx.num_gfx_rings) - 1;
 	if ((val & mask) == 0)
 		return -EINVAL;
 
@@ -2078,7 +2078,7 @@ static int amdgpu_debugfs_gfx_sched_mask_get(void *data, u64 *val)
 	for (i = 0; i < adev->gfx.num_gfx_rings; ++i) {
 		ring = &adev->gfx.gfx_ring[i];
 		if (ring->sched.ready)
-			mask |= 1 << i;
+			mask |= 1ULL << i;
 	}
 
 	*val = mask;
@@ -2120,7 +2120,7 @@ static int amdgpu_debugfs_compute_sched_mask_set(void *data, u64 val)
 	if (!adev)
 		return -ENODEV;
 
-	mask = (1 << adev->gfx.num_compute_rings) - 1;
+	mask = (1ULL << adev->gfx.num_compute_rings) - 1;
 	if ((val & mask) == 0)
 		return -EINVAL;
 
@@ -2149,7 +2149,7 @@ static int amdgpu_debugfs_compute_sched_mask_get(void *data, u64 *val)
 	for (i = 0; i < adev->gfx.num_compute_rings; ++i) {
 		ring = &adev->gfx.compute_ring[i];
 		if (ring->sched.ready)
-			mask |= 1 << i;
+			mask |= 1ULL << i;
 	}
 
 	*val = mask;
-- 
2.34.1



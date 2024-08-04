Return-Path: <linux-kernel+bounces-273885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FAC946F32
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 16:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32B47B20C5F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22F65589A;
	Sun,  4 Aug 2024 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="Lb3av0c5"
Received: from smtp2.math.uni-bielefeld.de (smtp2.math.uni-bielefeld.de [129.70.45.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCD66BFB5
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722779975; cv=none; b=kOVJGiHDGIKdE41CXmIhVHPG6DsNdOZdYge1g1rV80jGAanGchbU3FaArDn4CMOC7JUui3YsSykDb98V98eRmb6yl5Z3YKVhPXeiENciRRZj7kojnfRc9cq9YZbdh9oN8ptQqZzd04VAVMCfZgYrbN7fFVweHfbPDM8qghM1q5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722779975; c=relaxed/simple;
	bh=ricJaOpwguMV/eqHdvuZbbkftQ+RBPZjBXgBbOHVmzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y71dA81l0wWJmrtzis3QcrcJEjyxUGylfBipDqFJmjaTLELwGHMNLLHkly+Fd46Wg4GiInU7MmzN1nxsG/6zojyeAT3wcDAlkWDpiOnzC9zMaqJTlgj9xiTQK41+SnNUI8HdGYaCtA8z5QvjmJcw7iizh/cj+w9TfR3qd5delqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=Lb3av0c5; arc=none smtp.client-ip=129.70.45.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1722779966;
	bh=ricJaOpwguMV/eqHdvuZbbkftQ+RBPZjBXgBbOHVmzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lb3av0c5WijER/d6En96BoOLhshFin23KIXWGzAwCHvixjwSWcAmrlnzvy/46h3sv
	 h1qW19TaBFFZDzX8XC6r1OVoNcDGukllll3zN1BkV42kj8O9Na1+Px0eSZi+24yJye
	 xmSI/lNMhb7yaV1MVgPkNtSi7x1Hxg/2aMuUGtGzUzQmTyRGS0jISJgxpXACwe7r3M
	 P9NCUGPAS90qoflpw2xE/s+LTOJiJO3kHtl/LaW1YF3hI2mPuCkFmgdx7v++jHji9n
	 kltq3tOP07v+L73KCqaTAszzwsRf48AgDRG/CHaYSpEc7kUnZzd089g2o/1TMlfX4p
	 LCOwg+n6stXsw==
Received: from localhost (dslb-088-074-203-146.088.074.pools.vodafone-ip.de [88.74.203.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp2.math.uni-bielefeld.de (Postfix) with ESMTPSA id E189E20F4B;
	Sun,  4 Aug 2024 15:59:25 +0200 (CEST)
From: tjakobi@math.uni-bielefeld.de
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm/amd: Make amd_ip_funcs static for SDMA v5.2
Date: Sun,  4 Aug 2024 15:56:28 +0200
Message-ID: <76780ac4164e7e86f45d8673a7e91ad77e26b1c0.1722778722.git.tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <cover.1722778722.git.tjakobi@math.uni-bielefeld.de>
References: <cover.1722778722.git.tjakobi@math.uni-bielefeld.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

The struct can be static, as it is only used in this
translation unit.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index af1e90159ce3..3196663dd4f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1674,7 +1674,7 @@ static void sdma_v5_2_ring_end_use(struct amdgpu_ring *ring)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
-const struct amd_ip_funcs sdma_v5_2_ip_funcs = {
+static const struct amd_ip_funcs sdma_v5_2_ip_funcs = {
 	.name = "sdma_v5_2",
 	.early_init = sdma_v5_2_early_init,
 	.late_init = NULL,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.h b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.h
index b70414fef2a1..863145b3a77e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.h
@@ -24,7 +24,6 @@
 #ifndef __SDMA_V5_2_H__
 #define __SDMA_V5_2_H__
 
-extern const struct amd_ip_funcs sdma_v5_2_ip_funcs;
 extern const struct amdgpu_ip_block_version sdma_v5_2_ip_block;
 
 #endif /* __SDMA_V5_2_H__ */
-- 
2.44.2



Return-Path: <linux-kernel+bounces-335361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A1997E49B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8C31C2102B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7238BE5;
	Mon, 23 Sep 2024 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="HQvEo2ER"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B7635
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727054706; cv=none; b=NKrHwN7LMSK0iCdtu9nJ9q2+02s3ysW376h149OenYljmNc701olQX87V2ww2A58DMs1swuFQseGJY+kyzsKm5ckfvPeEj45jEDBAEivTRS/9fAR0ugiu73hfcy6DOzvuehLXEH1dkTDv2GpoYiV+N8USs6ENlMyfCXxX5wlMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727054706; c=relaxed/simple;
	bh=LB5rWp/18DUdrsxMn0BG3uhy90Wlc4jDkfAMDs09Srs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIlZ4jHPHaRy4k4/2PDiUwUuMkF4A5JVTQalpO7n3MTxicsZpOwnwa85MO8YPnPqoaxwEiLcPF/YBJ8tRMFEaG0l1UwzCQ1pVyfWK4V/ktf71DGkmHVvk+52mMy8r0fmxVUZypTjaUa6K9XSIfkl1mQEK5UhmD3FiqT9IeiXJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=HQvEo2ER; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=55Nb5AnSiTpPJhse4SS8idw+5d/f+IiBGFBN3Nv8730=; b=HQvEo2ER4bfHmAEy
	09EZG1516ULKSO4q2DZ1yqxtraHnmIqob7x18XJqHT8laCaba1d5XBG7n/iSBTZaP8UAoFVADESqJ
	7Qs/qDxjbdYd7smmr9m4gsTAGdLqvAffYWbNgCTgWDdNhTXKBfRew7K1H6km+MXtbrzkRdeQfc4BD
	TXKJalG/+2jrKVBNPtiPqJyOkEdr6ojLG7FrksQy1imdtL7OJmPJQWn8kpMWe2sP2LZAWJwdLqB03
	T4j3SZHecJ9tZMBfDc8q/XdMeUpSdzeY4E/EExKEswF1zpHBKkdKsn1M3dYy50E103asO+nxsWb9c
	lk4Ei4M5jNb2miULMw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1ssXoy-006k2k-02;
	Mon, 23 Sep 2024 01:25:00 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/5] drm/amdgpu: Remove unused amdgpu_gmc_vram_cpu_pa
Date: Mon, 23 Sep 2024 02:24:44 +0100
Message-ID: <20240923012446.4965-4-linux@treblig.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923012446.4965-1-linux@treblig.org>
References: <20240923012446.4965-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

amdgpu_gmc_vram_cpu_pa has been unused since commit
087451f372bf ("drm/amdgpu: use generic fb helpers instead of setting up AMD own's.")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 12 ------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 17a19d49d30a..58b5c436ad15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1065,18 +1065,6 @@ uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo)
 	return amdgpu_gmc_vram_mc2pa(adev, amdgpu_bo_gpu_offset(bo));
 }
 
-/**
- * amdgpu_gmc_vram_cpu_pa - calculate vram buffer object's physical address
- * from CPU's view
- *
- * @adev: amdgpu_device pointer
- * @bo: amdgpu buffer object
- */
-uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo)
-{
-	return amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start + adev->gmc.aper_base;
-}
-
 int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
 {
 	struct amdgpu_bo *vram_bo = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 4d951a1baefa..e0bed91dd5a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -447,7 +447,6 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev);
 void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev);
 uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
 uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
-uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
 int amdgpu_gmc_vram_checking(struct amdgpu_device *adev);
 int amdgpu_gmc_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_gmc_sysfs_fini(struct amdgpu_device *adev);
-- 
2.46.1



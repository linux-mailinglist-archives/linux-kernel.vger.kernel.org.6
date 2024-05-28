Return-Path: <linux-kernel+bounces-192220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EF08D1A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF5028413E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8553316C86F;
	Tue, 28 May 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4iXVa2X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4AF16C698
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897057; cv=none; b=ai5ABfC5/XepLqi/JpiIsXGsK7lTqEbpKribGaNmz2nrPD2R/YBkO3og3Sz9pgGHM3/EcBNT2ushAAq39rh1KRXvC6UBnxSB8tu/obMKKYj7hzz/4J14yJirR268+X5pA08WPwOxRPpzYHV1gNkxRwvmwkqtcAJbPEzo+WT6g2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897057; c=relaxed/simple;
	bh=vCzcWUNmvMUlvI8YURG3Btky8bNrSZU0/30kwieKgRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A1s7oTjmwEVYUdnT3sqiagJqZ1q6T+yyaGfA1TBiKHjoxItEe0L6rdK1TYssoMWjhRD+3PS3Dx1C68UUGsHLiGyeEWc6uyJCo5cbMZLxoWA/UHd/J4cb7MN3eHkwFXE84dxbtV5KlWGxJYPLZiL1+LhxSl5IMMA1NVGofpsEJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4iXVa2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF2DC3277B;
	Tue, 28 May 2024 11:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716897057;
	bh=vCzcWUNmvMUlvI8YURG3Btky8bNrSZU0/30kwieKgRM=;
	h=From:To:Cc:Subject:Date:From;
	b=H4iXVa2XTb/BQ48DrxGjyEW4dPitPx8+zyptgCLF6aB5RzX/wgbW6GRYFlcZWatZU
	 Av27wYkwultkGf236L2YZlx3kpABD8fWJNHzCf3PDx3WrqjfHHYOwkqK8YrRRCXZWJ
	 vUY9esizWwtQvPkTvLsYfowh0+SrDpH0iCwQrddaKn5iZHdCWMDDVtyVE1Js5223PK
	 RUCU16pKRMyY7syvM9rXuESlPMwJChch3lRQHkzy829CYpIzruGSPho2OGHhFT7FdG
	 YdbIu2IxrS1n1SEnCYiPNAIkKdyLAnd0lkVYbYyWJc60j8k8rLJO2GpdxPf+Ljl6Pk
	 7JO5opD9IOYxQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdkfd: select CONFIG_CRC16
Date: Tue, 28 May 2024 13:50:32 +0200
Message-Id: <20240528115050.2831206-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The amdkfd support fails to link when CONFIG_CRC16 is disabled:

aarch64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_topology.o: in function `kfd_topology_add_device':
kfd_topology.c:(.text+0x3a4c): undefined reference to `crc16'

This is a library module that needs to be selected from every user.

Fixes: 3ed181b8ff43 ("drm/amdkfd: Ensure gpu_id is unique")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdkfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
index d3c3d3ab7225..f82595af34bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -6,6 +6,7 @@
 config HSA_AMD
 	bool "HSA kernel driver for AMD GPU devices"
 	depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64)
+	select CRC16
 	select HMM_MIRROR
 	select MMU_NOTIFIER
 	select DRM_AMDGPU_USERPTR
-- 
2.39.2



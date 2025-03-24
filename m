Return-Path: <linux-kernel+bounces-574274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3040FA6E2F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8827A6F34
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58F7266F1C;
	Mon, 24 Mar 2025 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="N/hCGrSm"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7BF267709
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842794; cv=pass; b=GAWpcHRWhK/jflJZSPrwZOBS3fmeOpHL65PBg2nM5WuI3m3Tsm4fYW/cxfi6uxbSOjA1gHlvA6TMcipI5kGz1Y3ncVjgXJTaIUfTP0Hxkf1CvlW2eIy3b2jeIJrS3BRAyxBsi+3iz3bhfhC1XQHNmKpA8OMVzzQRTLztdzSBfd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842794; c=relaxed/simple;
	bh=YkSyPXy0FDhL9kKjmA/CCDkeAo/PQN6nTet3SHPAiko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FloLWYbHcgQtM7b86vHIlwd4NdiQ/AmAiuRNqbF6NNagAc0ewptln1GbjGJ2EusG/UJxTymwLHPNtXOkuU4TQnImzGbBbdjjAKhct/lSIeWeb4LfPLiNuWekHuigurWfi7TZy9sCpkSg4Qja4gR5uk/ky88N2PVgDCgDxJbat5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=N/hCGrSm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742842768; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cD3WUrOIAcXNg8o2fxPX4FwP488rTUSmr9Aibn68YIXoATCrVgqjdvKgFp/UoPRmwFVOgyr6Bq9NH8J8PTubSW2hmygoMPPpgvlxvFNOq5Cq7qXDHERc5QTL1Q5bSRH2l9FCJx1iV+CTEYH3eRaj3C0/dpSExAUB23jB9FWjVOk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742842768; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+0Qpm6G3dM4dW12QfuflWvN7JYPYS0esNhImh/Wdovw=; 
	b=ekbSviQbbytGTSDHn80ZVfPLX/vvOGosbGnzcVWAJGt5pGI2i+c8MlL5g4Bnvwj8pTTiVu6QTR6E2aV7q20R6blcz3ML9RSCTVOhkPc+MHrAiDYoOsLg8Mt1d3FLlAQfNa2juR360iRl1ZH8nktMy/t+BVJ6Dr2GV8B2Hz0lRg0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742842768;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+0Qpm6G3dM4dW12QfuflWvN7JYPYS0esNhImh/Wdovw=;
	b=N/hCGrSmQ61/H8DLOm5U+0nwLvb3NgJlV2YylG+F8zg2HJysYxJxqSi5xFASS6BY
	Rl9G2tiq/HCVQz2f2a+IbnOy3B0fY+iBlfnc2cFmNnpRXPUXNolp4POEoSoZmDQIXuO
	NN9qExbkTdleRagvUI+MFZVzLBzHuaTNuKdcgET4=
Received: by mx.zohomail.com with SMTPS id 1742842766824425.22107114928986;
	Mon, 24 Mar 2025 11:59:26 -0700 (PDT)
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com,
	robh@kernel.org,
	steven.price@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	kernel@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	sjoerd@collabora.com,
	angelogioacchino.delregno@collabora.com,
	Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [PATCH v5 0/6] drm/panfrost: Add support for AARCH64_4K page table format
Date: Mon, 24 Mar 2025 15:57:55 -0300
Message-ID: <20250324185801.168664-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi all,

This is a new iteration on Panfrost support for AARCH64_4K page table
format. The main reason behind this patchset is that MediaTek MT8188 SoC
(ARM Mali-G57 MC3 GPU) constantly faults due to the actual Panfrost cache
configuration.

Currently, Panfrost only supports MMU configuration in "LEGACY" (as Bifrost
calls it) mode, a (modified) version of LPAE "Large Physical Address
Extension", which in Linux we've called "mali_lpae".

This patchset adds support for conditionally enabling AARCH64_4K page table
format. To achieve that, a "GPU optional quirks" field was added to
`struct panfrost_features` with the related flag.

Note that, in order to enable AARCH64_4K mode, the GPU variant must have
the HW_FEATURE_AARCH64_MMU feature flag present.

The patchset only enables the new format on Mediatek MT8188 and MT8192,
which have been tested on a Mediatek Genio 700 EVK (MT8390) and Mediatek
Genio 1200 EVK (MT8395) boards respectively.

Thanks!

Changes in v5:
* Fixed drm_WARN() in panfrost_mmu_cfg_init().

Changes in v4:
* Fixed panfrost_mmu_cfg_init() return value on warning.

Changes in v3:
* Fixed error handling in panfrost_mmu_ctx_create().

Changes in v2:
* Dropped panfrost_mmu_enable/disable unification.
* Rename gpu_configs as gpu_quirks.
* Added error handling on page table not properly aligned.
* Enabled AARCH64_4K format on MediaTek MT8192 as well.
* Minor fixes.

Changes in v1:
* Added "Set IOMMU_CACHE flag" patch.
* Replaced `panfrost_mmu->enable()` function pointer by `cfg` struct
prepared during init time.
* Made mali_lpae/aarch64_4k name more clear.
* Added GPU_CONFIG_AARCH64_4K flag to enable AARCH64_4K page table
  format.
* Enabled AARCH64_4K mode only on mediatek-mt8188.

Ariel D'Alessandro (6):
  drm/panfrost: Set IOMMU_CACHE flag
  drm/panfrost: Use GPU_MMU_FEATURES_VA_BITS/PA_BITS macros
  drm/panfrost: Set HW_FEATURE_AARCH64_MMU feature flag on Bifrost
    models
  drm/panfrost: Add support for AARCH64_4K page table format
  drm/panfrost: Force AARCH64_4K page table format on MediaTek MT8188
  drm/panfrost: Force AARCH64_4K page table format on MediaTek MT8192

 drivers/gpu/drm/panfrost/panfrost_device.h   |  16 ++
 drivers/gpu/drm/panfrost/panfrost_drv.c      |   2 +
 drivers/gpu/drm/panfrost/panfrost_features.h |   3 +
 drivers/gpu/drm/panfrost/panfrost_mmu.c      | 150 +++++++++++++++++--
 drivers/gpu/drm/panfrost/panfrost_regs.h     |  36 +++++
 5 files changed, 196 insertions(+), 11 deletions(-)

-- 
2.49.0



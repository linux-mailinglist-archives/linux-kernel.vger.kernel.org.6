Return-Path: <linux-kernel+bounces-561894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374D2A6183E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EA9171B61
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE24204874;
	Fri, 14 Mar 2025 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="GwW191Fk"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5982046A8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974014; cv=pass; b=b9DHYGSYgekMh98C+1+zqsJegcp58rHssotGuDQOGj6ilXofkOUilfmMWarnrtXrkxw0Ypt7+BTv+IXdLcBbVZzwupWtPaoQufTJv0Z31Nh5qR/YzM8gjx1rGHghFKIHgvMZ7eVkqUX4boI4IfSOawflsiIYT1xQZ1BcY2/C5oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974014; c=relaxed/simple;
	bh=ZEVkdYrZwuWDGFv0lxYx4H3FofUcP30vDBDEBlAeG+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=trIfg9PRBiqqmRgjfcnLUKZTrs3dQbJs33xjPaqMUAyDj4bbs3swTzQndBA32N94bCgfJ99PZTDhOEjVyzxz8gQm35Cui8HnijG7fLg6jEHj4oc/cFEA0nRad1rPAPxZLq8IifscOc1URUjdNldQmv3IZS/20HZ9bQupZQxJaV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=GwW191Fk; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741973991; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=STn2tLoFAdxKHSniACbfPt88Ezw71Kcqv5Cn28jOMxbLErTGx0ec0YFqqSZbTMiGVkV8e9qgqOY8MOF+p0lL79vBZ0+jbLFs8Q9VSthG2CjXOQeo45LfR5TyvXjaHFPRIy9f8u8ayx0xe+dOX+DNAEZOrHUXHm7ZCRso8wx1qcU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741973991; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sQDIjMkW0zXePkXBZSAjC5u5Y+90v6jS96tmTnVEAJ8=; 
	b=IioC4ycvst7nqIW3iD3Q8ec/vur57V8l+baRxNtoDQFVs2FRZ1QLxmd6CJcipe9pT1BrotaFVVlDt8N1sGfmzCK3+Sxioz/hCbAayMDRPUnKKmwP3rIbejysNqCUmMOBICbSLf9gQnPkD1xTXXskQVOKSQa1JbqW9ExTKAsT4F4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741973991;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sQDIjMkW0zXePkXBZSAjC5u5Y+90v6jS96tmTnVEAJ8=;
	b=GwW191FkLl0RTBQBdFngMyoWExCYnpTyigYl7VPQyBSKciqWmX08BEiU4ZQ7Ggmn
	utAxfcs6UtYu64NIUS1ds7pkTZxFigl/igbWmvZ+6s+xnw+txI6+2FBzvZYtY5+WXlG
	Zkt4VhObOfq9CV/kCMZJzODwhsAk2ByCrFTITgds=
Received: by mx.zohomail.com with SMTPS id 1741973988175634.4562131256724;
	Fri, 14 Mar 2025 10:39:48 -0700 (PDT)
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
Subject: [PATCH v2 0/6] drm/panfrost: Add support for AARCH64_4K page table format
Date: Fri, 14 Mar 2025 14:38:52 -0300
Message-ID: <20250314173858.212264-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
 drivers/gpu/drm/panfrost/panfrost_mmu.c      | 146 +++++++++++++++++--
 drivers/gpu/drm/panfrost/panfrost_regs.h     |  36 +++++
 5 files changed, 190 insertions(+), 13 deletions(-)

-- 
2.47.2



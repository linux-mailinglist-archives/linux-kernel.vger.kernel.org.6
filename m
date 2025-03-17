Return-Path: <linux-kernel+bounces-564410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B591A6546C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3140F189251E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6175F2441A0;
	Mon, 17 Mar 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="Lm6le1K+"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E62376E1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223301; cv=pass; b=k5RvjwIxJOAAjeEVrCA+0fQ3ERd6oXLJrNTQxl6Iw/YzzJM9DhkeFslJEa/2GRhQUGQpqRe52G2elUKGz0DJJdTs9fo1cElWkYd5U30m5iabsPj8jcUVIq31xpAbSCG2Q6Lny28dp9A9qt4LRu7DDFfgwNPF5Rweo9mSzT+Qlfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223301; c=relaxed/simple;
	bh=I7SPIDuGDVKXROXsemVE5DnJzPU2t7HAIQGxFjieTvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=or+lDM3RZ2nIuRQaHazG5u+mtch0N0ImUttdD04Ew+eJ3+OBdhVN7wIUXgzAhHcI0PIsO/P3TLjQzG/NrS5x5QI8DGv2FOBs6zgmhQe2aCzO6ZJf7gGZh9+NIE5vi09d2np9y8/4FNY56QQaDkMQbQo738Pau72hf9d+oldwpDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=Lm6le1K+; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742223275; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M1VNdrAj5oc9FpRE6pFNkZ4u0JB4zbIPDuYhAuq7Ix2zKDlpOp3dHgrw4FiBPhcnOGf6Wz9GzkA9s5IyFOpjIuyBGac6DFi5cVGptceqMa0lUmHB7++DlPY6md3ac12/C2P0kLpRtju91o7KeRL835xWGQQffDODqIcTiichgpE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742223275; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=w2PUHcSecse+pehFOqz8LoEZY+5oNJsWhoVGSb9IYhM=; 
	b=kTrKYomtic4qkvQ27g5u/wSJv60IzY8NWyZisxqxCo1s5gXeo7Lz7maGNq2oAQKDwqnB0VvNPV2V8+bpERJozMwQOwbKjs0PfPkuVpsIqozq7Odt7+LhdTopGZaBPVJXIynr9dva9sZcoh3DjkeOI9qpFVoZKA1Yz2nS/rRVHVE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742223275;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=w2PUHcSecse+pehFOqz8LoEZY+5oNJsWhoVGSb9IYhM=;
	b=Lm6le1K+gNlNVDiix2eq3N357e3nBMmoZy+how0rlLpqnYfRfCoJDavOZAnZZUWI
	P0oFPC9Ko0Xui9Y5iY3KGnbCso3xn85Do5l+e4UsBMFZ3dFNFZ4opzuhTFOWSTLwwMR
	1pL9gYJ1bM9PHh89QsdFkMpCbcU9J1a+ek+8Vv3g=
Received: by mx.zohomail.com with SMTPS id 1742223273794544.7426387763203;
	Mon, 17 Mar 2025 07:54:33 -0700 (PDT)
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
Subject: [PATCH v4 0/6] drm/panfrost: Add support for AARCH64_4K page table format
Date: Mon, 17 Mar 2025 11:52:39 -0300
Message-ID: <20250317145245.910566-1-ariel.dalessandro@collabora.com>
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
2.47.2



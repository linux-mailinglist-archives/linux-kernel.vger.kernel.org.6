Return-Path: <linux-kernel+bounces-564172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8404AA64F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177923ADE4B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3087023AE96;
	Mon, 17 Mar 2025 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="Ze6ZGo/p"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86C1DF990
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215384; cv=pass; b=PUoiBsDVPHbiZ2kEbE2JDTLvAMZ+iYSuEiM+bu1o8qHL781jzkDrSa6tmQpdO60V5nCrHOLUITJoSA4HEHUQ3FH26OyBwjixmVZ5b6Kxs/2ezsHJM+SsajIpzlYposzD/w/Nrajgci76Q6A88NyHSQsglaNcREkJkbZiCWk/OfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215384; c=relaxed/simple;
	bh=Wt7AqxUenelm5qPa1EYM+sI2pCjCYbczsEiZ8E0ZBlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TldZ+L2kMPx7T2lmPHCtwICYVT5zDvHCMd7rRIXORIzhrh9xqm1Cy0ok42iN/cWMHh7oCZysptMYIGR4Gu3g3iZFHx7DUSh/sQfa5+iVZy3k6TJJ4UoCl7u2VyiTRjDEHm74soOgrrNTdfWax5DsluwcuvfELg5CYZto2sfpilU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=Ze6ZGo/p; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742215361; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cLG0gX3qkhY04f6ELwnN4x5YxcG7ZYzXCBCwayDVHS9QTZxAlsRdkc4AEWwyMFdslVcWSXoyfEjTOGX+T/V/H76MpRXsT25DAHtB3TMt/L4W7NFCYfQ4JamhA+qISzR3LsTp6U/1MElHmZ2es8MQt95RJKmcmcQAn9sQWq7NWwo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742215361; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=o7Ke/PtTF507QOYDaffaUn8HJGoCZ9xCEB7AZ16IaAs=; 
	b=Vx5bZjIPgr+xXXJt3VT5svjFY8IZRJZtdJ0Tbk/Nb+rKb21EaulpdAB0lplLQZ387lAMaNeokX6nTwDVl8U3ihwZCg1cLt4ssDI74npPFYwMoZzJKURDWHXazYlIfvlGhrDi7y/A+bMACxHVY8EF28x0lG/p2ozTlQp+nvY0ju0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742215361;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=o7Ke/PtTF507QOYDaffaUn8HJGoCZ9xCEB7AZ16IaAs=;
	b=Ze6ZGo/pFBeOjCvyS1Q5SSjVxWO3tYp2hoG2Awmv3Ryk6cTBbwIT6QSlmWRol2vT
	8QMnozxuhyiU+fruB4/FounajJrunZXdOcUINlLpzUkwQMpcvBvLdcSjvF22mzdMW9T
	PQY98f6J0QP+TM8Yr7ae/1eAy7sTuIPMc4hLHbL4=
Received: by mx.zohomail.com with SMTPS id 1742215358157185.8146892272224;
	Mon, 17 Mar 2025 05:42:38 -0700 (PDT)
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
Subject: [PATCH v3 0/6] drm/panfrost: Add support for AARCH64_4K page table format
Date: Mon, 17 Mar 2025 09:40:38 -0300
Message-ID: <20250317124044.16257-1-ariel.dalessandro@collabora.com>
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
 drivers/gpu/drm/panfrost/panfrost_mmu.c      | 149 +++++++++++++++++--
 drivers/gpu/drm/panfrost/panfrost_regs.h     |  36 +++++
 5 files changed, 195 insertions(+), 11 deletions(-)

-- 
2.47.2



Return-Path: <linux-kernel+bounces-511602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63AAA32D25
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0AA3A77D9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45FC255E42;
	Wed, 12 Feb 2025 17:14:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366A3271838
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380479; cv=none; b=TiwdSY/LdGRtga/PN/By6Ln68mcjNn/qje4yCEXiPrykj2a6E5t6xKqOvdoTBcvUTiop/i2q67WGP2h+yk+ot/GvnaimBEp+mYt5ssthkiRbkv/Lj6LgK0ROxXqym3WH+oArFS4WhDbbCHu37/zYnoWjds+DNjMyp/pJtGcT/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380479; c=relaxed/simple;
	bh=OYAbwmAHuFGes2BMrOgIi9tDNTdjmXIYwJOOO2WevAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cz3lK5c1ikMwkHEeIRy+2j6fDmhSYWeVVHaisQnwMV0TU3lmaci4imtQ1mYP52wy15TWe7p58WFw6VzFq3XuCtOQ5svAE0Hqd5+JiyG1GV3kNuNVbzJBh3Gcm9mVgMbLO7/Elf/a+VZA1dNHbfJp/+WyIbos+akrSwo2XYRqKBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3981A12FC;
	Wed, 12 Feb 2025 09:14:57 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A45F53F5A1;
	Wed, 12 Feb 2025 09:14:34 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: will@kernel.org,
	maz@kernel.org,
	catalin.marinas@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	aneesh.kumar@kernel.org,
	steven.price@arm.com,
	suzuki.poulose@arm.com,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 0/1] arm64: realm: Fix DMA address for devices
Date: Wed, 12 Feb 2025 17:14:10 +0000
Message-ID: <20250212171411.951874-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux can be run as a Confidential Guest in Arm CCA from Linux v6.13. The address
space (GPA or IPA) of a Realm VM is split into two halves, with private bottom
half and shared top half. In Linux we treat the "top" bit of the IPA space as
an attribute, to indicate whether it is shared or not (MSB == 1 implies shared).
Stage2 (GPA to PA) translations used by the CPU accesses, cover the full IPA space,
and are managed by RMM. The "top" bit as attribute is only a software construct.

At present any device passed through to a Realm is treated as untrusted and the
Realm uses bounce buffering for any DMA, using the "decrypted" (shared) DMA
buffers (i.e., IPA with top bit set). In Linux, we only send the "DMA" address
masking the "top" bit. In Arm CCA, SMMU for untrusted devices are managed by the
non-secure Host and thus it can be confusing for the host/device when an unmasked
address is provided. Given there could be other hypervisors than Linux/KVM
running Arm CCA guests, the Realm Guest must adhere to a single convention for
the DMA address. This gets further complicated when we add support for trusted
devices, which can DMA into the full Realm memory space, once accepted. Thus,
a DMA masked address (with "top" bit lost) will prevent a trusted device from
accessing a shared buffer.

Thus Arm has decided to standardise the DMA address used by the Realm to include
the full IPA address bits (including the "top" bit, which Linux uses as as attribute).

This patch implements this in Linux by hooking into the phys_to_dma and vice versa
for providing the appropriate address. This also implies that the VMMs must
take care to :
 1. Create the S2-SMMU mappings for VFIO at the "unprotected" alias.
 2. Always mask the "top" bit off any IPA it receives from the Realm for DMA.

KVM is not affected. A kvmtool branch with the changes above is available here [1].
There are two patches [2] & [3], that are really required on top of the Arm CCA
support. 

Ideally it would be good to get this backported to stable kernel releases to make
sure that they are compliant.

[1] git@git.gitlab.arm.com:linux-arm/kvmtool-cca.git cca/guest-dma-alias/v1
[2] https://gitlab.arm.com/linux-arm/kvmtool-cca/-/commit/ea37a6eb968abe4c75be4a8a90808714657c2ef7
[3] https://gitlab.arm.com/linux-arm/kvmtool-cca/-/commit/8afd0d5e6a7ee444dd0c1565fe94ecd831054a29

Cc: Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>

Suzuki K Poulose (1):
  arm64: realm: Use aliased addresses for device DMA to shared buffers

 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/dma-direct.h | 38 +++++++++++++++++++++++++++++
 include/linux/dma-direct.h          | 35 +++++++++++++++++---------
 3 files changed, 62 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm64/include/asm/dma-direct.h

-- 
2.43.0



Return-Path: <linux-kernel+bounces-536617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4AAA481D5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FFB3A4532
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349A223BF9A;
	Thu, 27 Feb 2025 14:42:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBB2236430
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667327; cv=none; b=llMO0kU4/70KnotrC48nxw/WoQHmo2q7k+PmWDEySxPtiXildAxN6TYUL595hJEvHC5b8ibPxKoK7U2bT5aKxr2uXDK2LzCZU/HeEaHn7mBsmvwVeBEg08uglt7vtG1+lYWnWD6S32KutT8fJdQbHaLoDZ5T9ZmLu/E/6dR6GrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667327; c=relaxed/simple;
	bh=o+EOrruqKu0KKeck//QLLC0wRLaIlDz/2CoijozD7rY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNbKepQ6/5Upc5/m/n6+UEPJkgwNErD3+16vAbfQ2HWFP89Av2++itdh9kUC+dPQ6ANDXd0pH5xwL5hhgNiXu7AyA1OsLVQ99ZdFQIlm4CWe809uvkcRC3lxp6DqAMR8STnEHHUJ+lTfeNjUKcemdNBzJRaWx9M6Zb7Uj2v9nFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6868B2BCA;
	Thu, 27 Feb 2025 06:42:20 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3179D3F673;
	Thu, 27 Feb 2025 06:42:03 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-kernel@vger.kernel.org
Cc: will@kernel.org,
	catalin.marinas@arm.com,
	maz@kernel.org,
	steven.price@arm.com,
	aneesh.kumar@kernel.org,
	gshan@redhat.com,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v3 0/3] arm64: realm: Fix DMA address for devices
Date: Thu, 27 Feb 2025 14:41:47 +0000
Message-ID: <20250227144150.1667735-1-suzuki.poulose@arm.com>
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

To resolve this Arm has decided to standardise the DMA address used by the Realm
to include the full IPA address bits (including the "top" bit, which Linux uses
as an attribute). This implies, any DMA to a shared buffer must have the top bit
of the IPA space set.

There is already a provision to do this in phys_to_dma* and dma_to_phys(), but
that is specific to AMD SME and is quite the opposite of what we need for Arm CCA.
i.e., For Arm CCA we need to set the bit for "decrypted" DMA and clear the bit
for "encrypted".

This series converts the existing __sme_* helpers to a bit more generalised versions :
dma_addr_decrypted() and dma_encrypted(). Also, while converting a DMA address back
to CPU physical address requires clearing off any "encryption/decryption" bits.
I have named this "dma_addr_canonical()". (The other options are :
  * dma_addr_clear_encryption - Well, not just for encryption, but we clear decryption
    too, so not ideal.
  * dma_addr_normal
  * dma_addr_clear
  * dma_addr_default

This also implies that the VMMs must take care to :

 1. Create the S2-SMMU mappings for VFIO at the "unprotected" alias.
 2. Always mask the "top" bit off any IPA it receives from the Realm for DMA.
    KVM already does that today and no changes are required.

A kvmtool branch with the changes above is available here [1]. There are two
patches [2] & [3], that are really required on top of the Arm CCA support.

Ideally it would be good to get this backported to v6.13 stable kernel releases
to make sure that they are compliant with this change.

Changes since v2:
 Link: https://lkml.kernel.org/r/20250219220751.1276854-1-suzuki.poulose@arm.com
  - Collect Acks & Reviews for Patch 1
  - Rename helpers
  	dma_encrypted		=> dma_addr_encrypted
	dma_decrypted		=> dma_addr_unencrypted
	dma_clear_encryption	=> dma_addr_canonical
  - For Arm CCA, use PROT_NS_SHARED, set/clear only the top IPA bit.
  - Drop dma_addr_encrypted() helper for Arm CCA as it is a NOP

Changes since v1
 Link: https://lkml.kernel.org/r/20250212171411.951874-1-suzuki.poulose@arm.com
 - Follow Robin's suggestion to generalise the DMA address conversion helpers
   to provide dma_{encrypte,decrypted,clear_encryption}. See PATCH 2 for more
   details.
 - Add a fix to the ordering of "__sme_clr" for dma_to_phys (PATCH 1)

[1] git@git.gitlab.arm.com:linux-arm/kvmtool-cca.git cca/guest-dma-alias/v1
[2] https://gitlab.arm.com/linux-arm/kvmtool-cca/-/commit/ea37a6eb968abe4c75be4a8a90808714657c2ef7
[3] https://gitlab.arm.com/linux-arm/kvmtool-cca/-/commit/8afd0d5e6a7ee444dd0c1565fe94ecd831054a29

Cc: Will Deacon <will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Gavin Shan <gshan@redhat.com>

Suzuki K Poulose (3):
  dma: Fix encryption bit clearing for dma_to_phys
  dma: Introduce generic dma_addr_*crypted helpers
  arm64: realm: Use aliased addresses for device DMA to shared buffers

 arch/arm64/include/asm/mem_encrypt.h | 11 +++++++++++
 include/linux/dma-direct.h           | 13 +++++++++----
 include/linux/mem_encrypt.h          | 23 +++++++++++++++++++++++
 3 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.43.0



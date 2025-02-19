Return-Path: <linux-kernel+bounces-522587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AABA3CC19
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180F6189C4FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D689C2580F6;
	Wed, 19 Feb 2025 22:09:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C69235341
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002976; cv=none; b=BITy06W39RDRcjzxA4HIokYpwyfZmonYkveDjGvnXxzs5/efeTxQ/lExRYHcJHTZb/J599wuVZd6/TxnPrwBPGPtl6NWW8FsxiGE4slFSOGbisDId3qbcQlFWIhjAter3PjJ4mm2ubT3QQC30+9qerrGqdVSt/+wrpr+fe7m8/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002976; c=relaxed/simple;
	bh=MRH30j5IiBYWbvzrjYEPEsXvT0uNc4g8bV6YC1ZIHoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BXvoPuatAFgM5X24jOaUfCKvuK1hUary0QkzFWPjTw5WcnwCpK1ffsU1Ul+O1coeOMTkBBDZ0204w2iOrNu+GHRnZhgEkJg3CObp86KuHDHxU5MZYreGbnuae1dNiEMwEm2tDrbl/tSSWNkqtf6C5nPSXXsgeC85OUZshba8JLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD67A153B;
	Wed, 19 Feb 2025 14:09:50 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 002073F6A8;
	Wed, 19 Feb 2025 14:09:30 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: will@kernel.org,
	robin.murphy@arm.com,
	catalin.marinas@arm.com
Cc: maz@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	aneesh.kumar@kernel.org,
	steven.price@arm.com,
	suzuki.poulose@arm.com,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Christoph Hellwig <hch@lst.de>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 0/3] arm64: realm: Fix DMA address for devices
Date: Wed, 19 Feb 2025 22:07:48 +0000
Message-ID: <20250219220751.1276854-1-suzuki.poulose@arm.com>
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
dma_decrypted() and dma_encrypted(). Also, while converting a DMA address back
to CPU physical address requires clearing off any "encryption/decryption" bits.
I have named this "dma_clear_encryption()", while this should be applied for
both encrypted/decrypted addresses. The better choice of names are already 
taken (dma_to_phys() ;-) and dma_clear()). Suggestions welcome. Please see Patch 2
for more details.

This also implies that the VMMs must take care to :

 1. Create the S2-SMMU mappings for VFIO at the "unprotected" alias.
 2. Always mask the "top" bit off any IPA it receives from the Realm for DMA.
    KVM already does that today and no changes are required.

A kvmtool branch with the changes above is available here [1]. There are two
patches [2] & [3], that are really required on top of the Arm CCA support.

Ideally it would be good to get this backported to v6.13 stable kernel releases
to make sure that they are compliant with this change.

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
Cc: Tom Lendacky <thomas.lendacky@amd.com>


Suzuki K Poulose (3):
  dma: Fix encryption bit clearing for dma_to_phys
  dma: Introduce generic dma_decrypted/dma_encrypted helpers
  arm64: realm: Use aliased addresses for device DMA to shared buffers

 arch/arm64/include/asm/mem_encrypt.h | 22 ++++++++++++++++++++++
 include/linux/dma-direct.h           | 13 +++++++++----
 include/linux/mem_encrypt.h          | 23 +++++++++++++++++++++++
 3 files changed, 54 insertions(+), 4 deletions(-)

-- 
2.43.0



Return-Path: <linux-kernel+bounces-528707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9726A41B20
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A203C3A9BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B302F2441AF;
	Mon, 24 Feb 2025 10:32:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84E43FB3B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393126; cv=none; b=VHjJZI12xEaDngvKNiVAKwA/URPRYWbwUb1lS7MO3nwgDoofi+sUmHVNVvullVih2QWdB7WDb+XGWA0w4LPlTjx88iocWT+9XQAfRWAS7SE+7Zhwca1JEy/Z2lZspYlev0Rt9YUSpRxJ5k1WcJDjcMpkY/ZXO+VOsTX7ZFJ+SDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393126; c=relaxed/simple;
	bh=6tyQWc2CeJw7tkGbXx5b3xfCRev7BAC0QTu71HcFiJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxrIgzyGtC8zTTpJkaBivgaXcKCH8gdmzEYbxR44eeNvRC6LTSKzID3BkGqleWAqyB+YI3GdHyvrCjCzR7jE9ZWg+gejw+MlB7DuP3CDq5CjfXlgBiblyWzz/qGZRNzC2IHqVANp9FcMDuGPK6u42dVGmtep1CUOe7G7/8C2O0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12ECE1E7D;
	Mon, 24 Feb 2025 02:32:21 -0800 (PST)
Received: from [10.57.36.38] (unknown [10.57.36.38])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A0AC73F673;
	Mon, 24 Feb 2025 02:32:02 -0800 (PST)
Message-ID: <a8ceea52-e34a-4edb-bd54-ca30ec030432@arm.com>
Date: Mon, 24 Feb 2025 10:32:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: arm64: Drop mte_allowed check during memslot
 creation
Content-Language: en-GB
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Joey Gouly <joey.gouly@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Steven Price <steven.price@arm.com>
References: <20250224093938.3934386-1-aneesh.kumar@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250224093938.3934386-1-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/02/2025 09:39, Aneesh Kumar K.V (Arm) wrote:
> Before commit d89585fbb308 ("KVM: arm64: unify the tests for VMAs in
> memslots when MTE is enabled"), kvm_arch_prepare_memory_region() only
> rejected a memory slot if VM_SHARED was set. This commit unified the
> checking with user_mem_abort(), with slots being rejected if either
> VM_MTE_ALLOWED is not set or VM_SHARED set. A subsequent commit
> c911f0d46879 ("KVM: arm64: permit all VM_MTE_ALLOWED mappings with MTE
> enabled") dropped the VM_SHARED check, so we ended up with memory slots
> being rejected if VM_MTE_ALLOWED is not set. This wasn't the case before
> the commit d89585fbb308. The rejection of the memory slot with VM_SHARED
> set was done to avoid a race condition with the test/set of the
> PG_mte_tagged flag. Before Commit d77e59a8fccd ("arm64: mte: Lock a page
> for MTE tag initialization") the kernel avoided allowing MTE with shared
> pages, thereby preventing two tasks sharing a page from setting up the
> PG_mte_tagged flag racily.
> 
> Commit d77e59a8fccd ("arm64: mte: Lock a page for MTE tag
> initialization") further updated the locking so that the kernel
> allows VM_SHARED mapping with MTE. With this commit, we can enable
> memslot creation with VM_SHARED VMA mapping.
> 
> This patch results in a minor tweak to the ABI. We now allow creating
> memslots that don't have the VM_MTE_ALLOWED flag set. If the guest uses
> such a memslot with Allocation Tags, the kernel will generate -EFAULT.
> ie, instead of failing early, we now fail later during KVM_RUN.
> 
> This change is needed because, without it, users are not able to use MTE
> with VFIO passthrough (currently the mapping is either Device or
> NonCacheable for which tag access check is not applied.), as shown
> below (kvmtool VMM).
> 
> [  617.921030] vfio-pci 0000:01:00.0: resetting
> [  618.024719] vfio-pci 0000:01:00.0: reset done
>    Error: 0000:01:00.0: failed to register region with KVM
>    Warning: [0abc:aced] Error activating emulation for BAR 0
>    Error: 0000:01:00.0: failed to configure regions
>    Warning: Failed init: vfio__init
> 
>    Fatal: Initialisation failed
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>



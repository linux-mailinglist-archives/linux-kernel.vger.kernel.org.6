Return-Path: <linux-kernel+bounces-403448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BF19C35DA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC90AB2159C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FABEAF9;
	Mon, 11 Nov 2024 01:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGUU+gPt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E779CD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731287924; cv=none; b=KWsIe50maFOF+wZATM6GkcvJzhu+VFDjrq5ZIfGwmRAsTax4ZNzzsTVSwEaSmGRlht1IC03Kb4UONZCVhiDVRxZ/tV12mt75VWzGfAqDXSsPdausDTGKas1+uifr7oL4Xl0mSWcpIMkAiV7NVXJ0RT66AD1IFa7LR0hzfOVKdas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731287924; c=relaxed/simple;
	bh=k+zYKvZtccWCCR7nyPdyVzSewpU58C/nG5kCkTh4o4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpCxl+1Yy7eo4QfdyFPURu+hKpPF76yc1uwyWJFuRkos+NXnDP2TbLc+GsDkAULFS/3KYV3BE2afNI0lPfSXFI3MVIe1mIE7eu9sonKQTO0rETktRiUqwx8hvcGf8uzMREFRdd8DuaMmjrNwcQXlHAE0tGF2PCMkSFexI87CCts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGUU+gPt; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731287922; x=1762823922;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k+zYKvZtccWCCR7nyPdyVzSewpU58C/nG5kCkTh4o4k=;
  b=EGUU+gPtfBp0rwtyIaUH6Mnfnsy8TsH8n5UnDx90f1cvO/RKpmi6dHY8
   4zHS4LH3VLre+R3e/rUXZ41chlzeFNleHLpuK5btvQlNPD7oeS5nUFUqg
   1Bu5qhxTEIz7fNM5B8J+asO2q4jQXfQ32l/qdxxBczXpPLxwwNzupNPXB
   +uEoMD6T6wnNlNl3oPLUkFNV9wBWPq+DTaGjrvyxVvwKs4Q6HrEdgDq/1
   P+gQIe+sXN/dE8S/l/NqiK2x19ViqfQcdkF9EGSkilVnBEoxGN6hB46fn
   xPem4XAfrPKtFaxs4JtoGed6i3afVuB+7poRpLUFcQ5LXIehFpPGnl2P7
   w==;
X-CSE-ConnectionGUID: 53nIl8jLT1Ob9d7ydVi0Yg==
X-CSE-MsgGUID: I56mvAZTSi2axvswO14CZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="41713914"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="41713914"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 17:18:41 -0800
X-CSE-ConnectionGUID: 6eW+UiEnSSCtCAi537p7WQ==
X-CSE-MsgGUID: 4D64gkvNSRqcIizxj4oMKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="86761864"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 17:18:39 -0800
Message-ID: <05969b08-6c84-46b8-b795-85980ef15269@linux.intel.com>
Date: Mon, 11 Nov 2024 09:17:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iommu: intel: apply quirk_iommu_igfx for 8086:0044
 (QM57/QS57)
To: Mingcong Bai <jeffbai@aosc.io>
Cc: kexybiscuit@aosc.io, weiguangtwk@outlook.com,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
References: <20241108120838.495931-1-jeffbai@aosc.io>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241108120838.495931-1-jeffbai@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/24 20:08, Mingcong Bai wrote:
> (I'm not very confident about the approach of this patch but I failed to
> find a better way to address the issue I have on hand, so please consider
> this patch as an RFC...)
> 
> On the Lenovo ThinkPad X201, when Intel VT-d is enabled in the BIOS, the
> kernel boots with errors related to DMAR, the graphical interface appeared
> quite choppy, and the system resets erratically within a minute after it
> booted:
> 
> DMAR: DRHD: handling fault status reg 3
> DMAR: [DMA Write NO_PASID] Request device [00:02.0] fault addr 0xb97ff000
> [fault reason 0x05] PTE Write access is not set
> 
> Upon comparing boot logs with VT-d on/off, I found that the Intel Calpella
> quirk (`quirk_calpella_no_shadow_gtt()') correctly applied the igfx IOMMU
> disable/quirk correctly:
> 
> pci 0000:00:00.0: DMAR: BIOS has allocated no shadow GTT; disabling IOMMU
> for graphics
> 
> Whereas with VT-d on, it went into the "else" branch, which then
> triggered the DMAR handling fault above:
> 
> ... else if (!disable_igfx_iommu) {
> 	/* we have to ensure the gfx device is idle before we flush */
> 	pci_info(dev, "Disabling batched IOTLB flush on Ironlake\n");
> 	iommu_set_dma_strict();
> }
> 
> Now, this is not exactly scientific, but moving 0x0044 to quirk_iommu_igfx
> seems to have fixed the aforementioned issue. Running a few `git blame'
> runs on the function, I have found that the quirk was originally
> introduced as a fix specific to ThinkPad X201:
> 
> commit 9eecabcb9a92 ("intel-iommu: Abort IOMMU setup for igfx if BIOS gave
> no shadow GTT space")
> 
> Which was later revised twice to the "else" branch we saw above:
> 
> - 2011: commit 6fbcfb3e467a ("intel-iommu: Workaround IOTLB hang on
>    Ironlake GPU")
> - 2024: commit ba00196ca41c ("iommu/vt-d: Decouple igfx_off from graphic
>    identity mapping")
> 
> I'm uncertain whether further testings on this particular laptops were
> done in 2011 and (honestly I'm not sure) 2024, but I would be happy to do
> some distro-specific testing if that's what would be required to verify
> this patch.
> 
> P.S., I also see IDs 0x0040, 0x0062, and 0x006a listed under the same
> `quirk_calpella_no_shadow_gtt()' quirk, but I'm not sure how similar these
> chipsets are (if they share the same issue with VT-d or even, indeed, if
> this issue is specific to a bug in the Lenovo BIOS). With regards to
> 0x0062, it seems to be a Centrino wireless card, but not a chipset?
> 
> I have also listed a couple (distro and kernel) bug reports below as
> references (some of them are from 7-8 years ago!), as they seem to be
> similar issue found on different Westmere/Ironlake, Haswell, and Broadwell
> hardware setups.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=197029
> Link: https://groups.google.com/g/qubes-users/c/4NP4goUds2c?pli=1
> Link: https://bugs.archlinux.org/task/65362
> Link: https://bbs.archlinux.org/viewtopic.php?id=230323
> Reported-by: Wenhao Sun <weiguangtwk@outlook.com>
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> ---
>   drivers/iommu/intel/iommu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index e860bc9439a2..1ccea83c2c95 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4646,6 +4646,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e30, quirk_iommu_igfx);
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e40, quirk_iommu_igfx);
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e90, quirk_iommu_igfx);
>   
> +/* QM57/QS57 integrated gfx malfunctions with dmar */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_iommu_igfx);
> +
>   /* Broadwell igfx malfunctions with dmar */
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x1606, quirk_iommu_igfx);
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x160B, quirk_iommu_igfx);
> @@ -4723,7 +4726,6 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
>   	}
>   }
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0040, quirk_calpella_no_shadow_gtt);
> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0044, quirk_calpella_no_shadow_gtt);
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0062, quirk_calpella_no_shadow_gtt);
>   DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x006a, quirk_calpella_no_shadow_gtt);
>   

Cc: intel-gfx@lists.freedesktop.org

--
baolu


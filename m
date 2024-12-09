Return-Path: <linux-kernel+bounces-438520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CB69EA228
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0B6282CC4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282D719D075;
	Mon,  9 Dec 2024 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGjCgRHH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D32C9A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733784878; cv=none; b=WpxEazf4Cup9rfbtgn8JojYr43KRHLiMVnI8rSBQioS7FJ3pPRfTwj8Jw74IvE6X95cXlU1siTc+eKXoKMfrifWe4X9CyK6ZYMhZWDaEsxCbrQ/rd0Z+2QO1fDPHY1EpwPGAEzWzDZ6dArMkFWQFqjW9fCmkxFgS0Hl/4T8dCx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733784878; c=relaxed/simple;
	bh=zMM76qU1Xm2ZpMH3PV9zRviHqG13LkKbvLJjy4Ecofo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aq2Cr6QUVdzG6oNMeyZahUcBg0g9ItTqKj8aV4iDyyRgmLJ+ctEvnPxIek++ZMUQ4sOtA0Av63hbEE8qssdndVYtc69T1k48cV9elwREZo9b7bbv8ejfpCX82Hl8jkIf7r2QuwC0aUsLGomBtKi77/2pays4Jrqj8eJtbyoZ3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGjCgRHH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733784876; x=1765320876;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zMM76qU1Xm2ZpMH3PV9zRviHqG13LkKbvLJjy4Ecofo=;
  b=QGjCgRHHh8+71hsbNg/QREFoKzbqn8hqxQe6QnKRdopVRzlus88HeKvu
   mQm5FYPoNjJ1+QQSyivBlmdPAJ7kPQSPEj7GMxJZgwfmwoadaSCxf60zt
   DqYeM3sxiSTQBsYPq/PVoHcIBv27qhzj0db2oz7mDBKDIte3bLP4+kRxY
   hCBIRlI9AUy/75xYvfJLr9zz5s+ifogca6ZmAYQwA41WGQsbK6wgmqi7I
   qYFm+XPyaziJrmg3p9kBuE0za+bn0fFf5iqf03lEUS0szlaOnM2WK3rU4
   kbzzUy/7CgmumeNel/MAteayan7saBSFANhoHNuLQK2IZHVNdodmTCMFH
   w==;
X-CSE-ConnectionGUID: uO2Cm+9OSbqupADI/MKaMA==
X-CSE-MsgGUID: nyhcaoFVTRq6Ok1ouLOSqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="51519592"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="51519592"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 14:54:35 -0800
X-CSE-ConnectionGUID: iuVYF4pXSEGIsSLvplIK6Q==
X-CSE-MsgGUID: 2EoXfcIBQHGjAZLWLy532g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="118455839"
Received: from philliph-desk.amr.corp.intel.com (HELO [10.124.221.227]) ([10.124.221.227])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 14:54:35 -0800
Message-ID: <78a359f8-5a0c-463c-b886-ff4165b395d2@intel.com>
Date: Mon, 9 Dec 2024 14:54:34 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8.2/9] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
To: Kai Huang <kai.huang@intel.com>, kirill.shutemov@linux.intel.com,
 tglx@linutronix.de, bp@alien8.de, peterz@infradead.org, mingo@redhat.com,
 hpa@zytor.com, dan.j.williams@intel.com, seanjc@google.com,
 pbonzini@redhat.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com,
 isaku.yamahata@intel.com, adrian.hunter@intel.com, nik.borisov@suse.com
References: <23bb421e9bf5443a823e163fb2d899760d9f14a3.1731498635.git.kai.huang@intel.com>
 <20241209065016.242359-1-kai.huang@intel.com>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20241209065016.242359-1-kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/24 22:50, Kai Huang wrote:
> A TDX module initialization failure was reported on an Emerald Rapids
> platform [*]:
> 
>   virt/tdx: initialization failed: TDMR [0x0, 0x80000000): reserved areas exhausted.
>   virt/tdx: module initialization failed (-28)
> 
> The kernel informs the TDX module of "TDX-usable memory regions" via the
> structure "TD Memory Region" (TDMR).  Each TDMR contains a limited
> number of "reserved areas" to inform the TDX module of the regions that
> cannot be used by TDX.
> 
> The kernel builds the list of "TDX-usable memory regions" from memblock
> (which reflects e820) and marks all memory holes as "reserved areas" in
> TDMRs.  It turns out on some large systems the holes in memblock can be
> too fine-grained [1] and exceed the number of reserved areas that the
> module can track per TDMR, resulting in the failure mentioned above.
> 
> The TDX module also reports TDX-capable memory as "Convertible Memory
> Regions" (CMRs).  CMRs tend to be coarser-grained [2] than the e820.
> Use CMRs to find memory holes when populating reserved areas to reduce
> their consumption.
> 
> Note the kernel does not prevent non-CMR memory from being added to
> "TDX-usable memory regions" but depends on the TDX module to catch in
> the TDH.SYS.CONFIG.  After switching to using CMRs to populate reserved
> areas this will no longer work.  To ensure no non-CMR memory is included
> in the TDMRs, verify that the memory region is truly TDX convertible
> before adding it as a TDX-usable memory region at early stage.

Thanks for trimming the changelog down.  But this changelog never
actually says what the fix is. It's also quite heavy on the "what" and
very light on the "why".

I think the "why" boils down to the fact that the kernel is treating RAM
-- as defined by the platform and TDX module -- as non-RAM.

> -	ret = tdmrs_populate_rsvd_areas_all(tdmr_list, tmb_list,
> +	/*
> +	 * On some large systems, the TDX memory blocks (which reflects
> +	 * e820) in the first 1GB can be too fine-grained.  Using them
> +	 * to populate reserved areas may result in reserved areas being
> +	 * exhausted.  CMRs are coarser-grained than e820.  Use CMRs to
> +	 * populate reserved areas to reduce their consumption.
> +	 */

I think there are still too many details here for a comment. This
comment is describing *highly* implementation and platform-specific
details particular to this bug you are fixing today. They will be
irrelevant to anyone reading this code tomorrow.

So in the end, I buy that the CMR's have something to offer here. But I
think that "why" I mentioned above casts doubt on whether
for_each_mem_pfn_range() is the right primitive on which to build the
TDX memblocks in the first place.

I suspect there's a much simpler solution that will emerge when
considering a deeper fix as opposed to adding CMRs as a band-aid.


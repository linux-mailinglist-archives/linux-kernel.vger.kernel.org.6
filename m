Return-Path: <linux-kernel+bounces-323116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D727973823
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155DC288850
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D7D191F96;
	Tue, 10 Sep 2024 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I89ndTGN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC74191F73
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973103; cv=none; b=dxHs1wsM7mmvDVeEduOERkuEpoQDVvtv7m6hWGb/3AOzPn+ERpFgn+W2Ci5Fi9PHQzy9j2WafaxEOOsc9DBTOXHzaT5F87dVkmudI67b00XoyFALddA0PoYaqmDfu9sQU6/BoiTotPQD25CVps6D/+85zEU1cbTb+FmqaykOvL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973103; c=relaxed/simple;
	bh=LJ48zepfU2WM5mSgvbrHvfKAvy/xuXzmrP7tuJvztUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKC+5hEQAKhOQhiKP3DGcvvIyuG0Xq44GNBcvI+Iq9bzjXW8z6jX4Kcor8AIVvl9SH4xqgAB3v5D2aoP1ikW0d/0FExU7l8QfkhsXCBl0nZOX4hUTtUC25MzuI0/dQZqpxudzWFxpkv8lVIfCBZ8AMiUpLQgiRvv96iR4IPjohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I89ndTGN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725973102; x=1757509102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LJ48zepfU2WM5mSgvbrHvfKAvy/xuXzmrP7tuJvztUI=;
  b=I89ndTGNttEG8veMLNfsbMMeqqeZhBiNHfByouXm69oynyL7m/X2/vSt
   dq4ah9e1ypj4MVmInhiVLS6dDnghujtoWrD5RbvJDg9WCc/bpRVvj08zE
   dRSHD6PSvJ9BzCs3np3r8Cuv9eBpMs1LgjHauxeBAXNjwvsj8fzhpM3ca
   ZrZ4rpHfR15Mmg9QHad11MdtuCsTCVpzPv8Mdi+ckr7Az86toBRBF9sim
   2I6Go8iW62/3LqVU+J/TL5RjmjgzJClmwsLxPEQAO7H3AjQ50KCdiWNLq
   7JCgLibsJnPTDGP2FGEYrXjntrYf74J11OJiAqRafESbFoQKOnZzZGAtP
   w==;
X-CSE-ConnectionGUID: JoIXumLNQReR2JVg6DbZ+A==
X-CSE-MsgGUID: bYNdnk1dRo6WrTk8MlAkng==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24215374"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="24215374"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 05:58:21 -0700
X-CSE-ConnectionGUID: RP14yenjRPywpUO5lCy9RQ==
X-CSE-MsgGUID: ptATUNVmSxy17Lv7KHXulQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="71145076"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 10 Sep 2024 05:58:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 38CDB326; Tue, 10 Sep 2024 15:58:16 +0300 (EEST)
Date: Tue, 10 Sep 2024 15:58:16 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Subject: Re: [PATCH] x86/tdx: Fix crash on kexec with CONFIG_EISA
Message-ID: <uwr4a2pgvv45xfzvbceghdkm6kgb25y7c2wdkxquphmq2e7rxq@tr5dud4khhl5>
References: <20240822095122.736522-1-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.2408240952080.30766@angie.orcam.me.uk>
 <g3tswlyhrnuzfqf2upq6h23manyrzhnxttnay66nycy2moi4es@5n4oblzpzcjc>
 <c2ef105b-c42c-e0f4-6bf3-761dafc8e92e@amd.com>
 <02949473-328f-4dae-b778-d939dc9bba6c@amd.com>
 <npjx2z3adipvsxngnsoj6hsgk7rxta6ojdomm4tcd42maakuuz@rij273zia5ek>
 <e13df309-457a-41fa-9406-22476f9f4e72@amd.com>
 <gnxxp3bzk7cc5eidwvqvqb5hz2ojgjdadujpthweufxms2gjsc@ibcbkjst3pzf>
 <fe39a04d-2b3a-476f-9505-b874e3ad93b4@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe39a04d-2b3a-476f-9505-b874e3ad93b4@amd.com>

On Fri, Aug 30, 2024 at 03:47:50PM -0500, Kalra, Ashish wrote:
> Hello Kirill,
> 
> On 8/29/2024 7:53 AM, Kirill A. Shutemov wrote:
> > On Wed, Aug 28, 2024 at 02:43:23PM -0500, Kalra, Ashish wrote:
> >> Hello Kirill,
> >>
> >> On 8/28/2024 1:21 AM, Kirill A. Shutemov wrote:
> >>>>>> memremap()
> >>>>>>   arch_memremap_wb()
> >>>>>>     ioremap_cache()
> >>>>>>       __ioremap_caller(.encrytped = false)
> >>>>>>
> >>>>>> I think arch_memremap_wb() should be mapped ioremap_encrypted() in x86
> >>>>>> case. See the patch below.
> >>>>>>
> >>>>>> It seems to be working fine on TDX, but I am not sure about SEV.
> >>>>>>
> >>>>>> Tom, any comments?
> >>>>> I haven't dug through the code that thoroughly, but I don't think making
> >>>>> arch_memremap_wb() be ioremap_encrypted() will work for SME, where some
> >>>>> data, e.g. setup data, is unencrypted and needs to be mapped shared.
> >>>>>
> >>>>> Let me add @Ashish to the thread and have him investigate this since he
> >>>>> has been working on the kexec support under SNP. Can someone provide the
> >>>>> specific kernel options that need to be in place?
> >>>> As Tom asked for, please provide the specific kernel options to test
> >>>> with this configuration.
> >>> It is not about testing a specific configuration. The question is if it
> >>> safe for memremap() to map all WB memory as encrypted by default.
> >>>
> >>> Looks like it is safe for TDX, but I am not sure about SME/SEV.
> >> For SEV it may make sense, but for SME we don't want memremap() to map
> >> all WB memory as encrypted by default.
> > Could you elaborate why?
> >
> > I mean if it is specific memory ranges that can be identified as such we
> > could make exception for them.
> Looks like that the exception is already made for some of these memory ranges with MEMREMAP_DEC flag set along with MEMREMAP_WB.
> >>> Maybe we want a specific flag to make memremap() map WB memory as
> >>> decrypted/shared. Make everything encrypted by default seems like a sane
> >>> default.
> >> What are MEMREMAP_ENC, MEMREMAP_DEC flags being used for currently ?
> > Good question.
> >
> > I see zero use of MEMREMAP_ENC in the kernel. And MEMREMAP_DEC only used
> > for setup data which I believe AMD thing.
> >
> > If it is the only memory that must be decrypted, I guess we can make it
> > work with encrypted by default.
> 
> Yes, and this looks pretty much covered with:
> 
> arch_memremap_can_ram_remap(..)
> 
> -> if (CC_ATTR_HOST_MEM_REMAP)
> 
> --> memremap_is_setup_data()
> 
> ---> memremap(.., MEMREMAP_WB | MEMREMAP_DEC);
> 
> It does look like that it can work with encrypted by default and any memory ranges which need special handling and need to be setup as decrypted can use MEMREMAP_WB | MEMREMAP_DEC flag.
> 

Could you actually test the patch that makes memremap() map WB memory as
encrypted by default:

https://lore.kernel.org/all/g3tswlyhrnuzfqf2upq6h23manyrzhnxttnay66nycy2moi4es@5n4oblzpzcjc/

?

If it works, I will submit a proper patch.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov


Return-Path: <linux-kernel+bounces-412872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E83EC9D1074
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6607FB22C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CCF1991C8;
	Mon, 18 Nov 2024 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FU7qFXCl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22355198A35
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731932077; cv=none; b=KGx+fNWQI6xD1YxjfRwwK+jTYOQQtbCxPMgppZ8vT/SDFKj2eo6i4B+dEFn/gUs7Z6B1f018tg791dUIikYbNnDPwOUTaEI11lLf2Fiw0iMNDT/7B2nTV6LHU9SJu3kCHXAXUqWQ+xxY70nZ2m1h9T6BFiPMgi17sAWB+u8/3JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731932077; c=relaxed/simple;
	bh=EiiG1OYFiM264BUD590kDMC4+EsgRNZ1XnqziSSQoC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9Vs8b17xYQUhiHzYnMrOzOB5vazAu42QkQY0dLnmzsLpF1TBCuCULVjEPp3NOowSD+3juj6BN8zA7ksrO1OYQY7YssJDHH+CNcPVeSXZ54bUg7k31j3OKsi4/BTlIy6kvob4wmwf+9ralzzAwZ8ym2mfgzOcpsbsX1t+uDt2Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FU7qFXCl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731932076; x=1763468076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EiiG1OYFiM264BUD590kDMC4+EsgRNZ1XnqziSSQoC8=;
  b=FU7qFXClm2fI7Xi9m1MdGpHFtOV0WTXon4BgebpTcW71ZarLkHxypXxk
   BPj+S2Paan/S7riN6+yxQ6RBCfez1vSVo3iWEneR43pK8iJ/pFTbn1HYk
   jLiH9riwC/CSDOa7II6dIfFqGsUJa3DmmaJU16LEnDdbLOJBwnIurzzrB
   Vlrsh7PWXsIPtdWpXfjKWuLNAueYUp6V5oEenuXDaZ/vLV5SnE9mnrRwi
   Zl5ZKqBpPoon4TBEBbzfvdqwjSIBwvQQfGlGKyTjuLDJleBlvGqUUgfDe
   /XuGUg4YzreWIyvCHT33r737RwV93rcb0FBtDVUCxSV/UGckCH7GbBY+v
   Q==;
X-CSE-ConnectionGUID: vIK338PNRtWiOwr8FW/oRQ==
X-CSE-MsgGUID: 0GqNtJ+kSqOJTcJG5PZN/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="43281784"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="43281784"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 04:14:35 -0800
X-CSE-ConnectionGUID: XbvVhdfeTrOnBECuMbsWnQ==
X-CSE-MsgGUID: L4NYPEHgSSelCortqBt2JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="94025518"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 04:14:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tD0eE-0000000FzuA-2TDL;
	Mon, 18 Nov 2024 14:14:30 +0200
Date: Mon, 18 Nov 2024 14:14:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"Daniel Walker (danielwa)" <danielwa@cisco.com>,
	Ilpo =?utf-8?Q?J=EF=BF=BDrvinen?= <ilpo.jarvinen@linux.intel.com>,
	Klara Modin <klarasmodin@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danil Rybakov <danilrybakov249@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Message-ID: <Zzsvphcxy-70Uz7E@smile.fi.intel.com>
References: <ZzTI+biIUTvFT6NC@goliath>
 <cd1cedcc-c9b8-4f3c-ac83-4b0c0ba52a82@redhat.com>
 <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
 <2c828592-dbdd-4cd4-b366-70797d63329d@redhat.com>
 <ZzTk5kyPa5kUxA+f@goliath>
 <a5bafe87-e8f6-40d9-a5d8-34cf6aa576a4@redhat.com>
 <wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7li@pdvthto4jf47>
 <ZzdhTsuRNk1YWg8p@goliath>
 <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
 <afdb6114-07ef-4e25-91f0-9fb9be192153@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afdb6114-07ef-4e25-91f0-9fb9be192153@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 18, 2024 at 12:42:18PM +0100, Hans de Goede wrote:
> On 18-Nov-24 12:30 PM, Shinichiro Kawasaki wrote:
> > On Nov 15, 2024 / 14:57, Daniel Walker (danielwa) wrote:
> >> On Fri, Nov 15, 2024 at 11:35:46AM +0000, Shinichiro Kawasaki wrote:
> >>> On Nov 13, 2024 / 19:34, Hans de Goede wrote:
> >>>> On 13-Nov-24 6:41 PM, Daniel Walker (danielwa) wrote:
> >>>>> On Wed, Nov 13, 2024 at 06:04:44PM +0100, Hans de Goede wrote:
> >>>>>> On 13-Nov-24 5:33 PM, Hans de Goede wrote:
> >>>>>>> On 13-Nov-24 5:24 PM, Hans de Goede wrote:

[...]

> >>>>>>> It probably has something to do with these 2 messages:
> >>>>>>>
> >>>>>>> pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]: can't claim; no compatible bridge window
> >>>>>>> pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned
> >>>>>>>
> >>>>>>> I'm guessing that this re-assignment is messing up
> >>>>>>> the p2sb BAR caching, after which things go wrong.
> >>>>>>
> >>>>>> Hmm, but that should be fixed by 2c6370e66076 ("platform/x86: p2sb: Don't init until unassigned resources have been assigned")
> >>>>>>
> >>>>>> and you are seeing this with 6.12, which has that.
> >>>>>>
> >>>>>> Can you try adding a pr_info() to the top of p2sb_cache_resources()
> >>>>>> with 6.12 and then collec a new dmesg ?
> >>>>>>
> >>>>>> If that pr_info() is done after the:
> >>>>>>
> >>>>>> pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned
> >>>>>>
> >>>>>> message then that does not explain things.
> >>>>>
> >>>>> I haven't testing adding a pr_info() but the messages seem to happen in the same
> >>>>> order in both working and non-working cases.
> >>>>>
> >>>>> Does that matter?
> >>>>
> >>>> The working case does not do the bar caching, we want to know if the
> >>>> bar caching in the non working case happens before or after the assignment:
> >>>>
> >>>> pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned
> >>>>
> >>>> It should happen after the assignment.
> >>>
> >>> Hello Daniel,
> >>>
> >>> It's my sorrow that the change cause this trouble. I have created a debug patch
> >>> for the kernel and attached to this e-mail. It adds some pr_info() to answer
> >>> the question from Hans. It will also show us a bit more things. Could you try it
> >>> on your system? It should apply to v6.12-rcX kernels without conflicts.
> >>
> >> Ok.. The dmesg with the patch applied is attached.
> > 
> > Thank you. Here I quote the relevant part of the debug log.
> > 
> > --------------------------------------------------------------------------------
> > ...
> > pci 0000:00:1f.0: [8086:19dc] type 00 class 0x060100 conventional PCI endpoint
> > pci 0000:00:1f.1: [8086:19dd] type 00 class 0x058000 conventional PCI endpoint ... [A]
> > pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]
> > pci 0000:00:1f.2: [8086:19de] type 00 class 0x058000 conventional PCI endpoint
> > pci 0000:00:1f.2: BAR 0 [mem 0x88c00000-0x88c03fff]
> > ...
> > PCI: Using ACPI for IRQ routing
> > pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]: can't claim; no compatible bridge window ... [B]
> > hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> > ...
> > NET: Registered PF_XDP protocol family
> > pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned ... [C]
> > pci 0000:00:09.0: PCI bridge to [bus 01-06]
> > ...
> > PCI: CLS 64 bytes, default 64
> > p2sb_cache_resources
> > p2sb_cache_resources: P2SBC_HIDE=0  ... [D]
> > p2sb_scan_and_cache_devfn: devfn=1f.1
> > p2sb_scan_and_cache_devfn: 280000000-280ffffff: 140204 ... [E]
> > PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> > ...
> > --------------------------------------------------------------------------------
> > 
> > Also, here I list my observations.
> > 
> > [A] The P2SB device was detected with DEVFN 1f.1, and device id 8086:19dd
> > [B] Failed to claim its resource
> > [C] Assigned new resource
> > [D] p2sb_cache_resource() was called after the new resource assignment.
> >     P2SBC_HIDE bit is not set.
> > [E] The new resource was cached. IORESOURCE flags: MEM_64,SIZE_ALIGN,MEM.
> > 
> > So it was confirmed that the p2sb_cache_resource() was called after the new
> > resource assignment, but Hans and Andy discuss that this order is not the
> > problem cause, probably.
> > 
> > One thing I noticed is that p2sb_bar() call is not recorded in the log. My
> > understanding is that all device drivers which use P2SB resource shouled call
> > p2sb_bar(). Daniel, you noted that "a custom gpio device" disappeared. Does its
> > device driver call p2sb_bar()?

FYI: if we are talking about on-die GPIO (that's usually covered by
the drivers/intel/pinctrl-denverton.c), the new kernels have the piece
of the code to enumerate it via p2sb (the code is located in the
drivers/mfd/lpc_ich.c).

> > On the other hand, Daniel noted that,
> > 
> >   "The vendor and device details for the pci device are 8086:19dd."
> > 
> > I think 8086:19dd is the P2SB device itself. When p2sb_cache_resource() is
> > called, pci_stop_and_remove_bus_device() is called for it, so I guess it is
> > expected the device 8086:19dd disappears. Before applying the commit
> > 5913320eb0b3, this pci_stop_and_remove_bus_device() call happened when
> > p2sb_bar() was called. So, my mere guess is that Daniel's system's drivers do
> > not call p2sb_bar() during the boot process, then the 8086:19dd P2SB device was
> > still visible after boot.
> 
> Thank you that is a great analysis.

+1 here, indeed a great analysis!

> It sounds to me like calling pci_stop_and_remove_bus_device() on an unhidden
> PCI device is the real problem here. And that we were not hitting that before
> was more or less luck.
> 
> I wonder if we can cache the bar in some other way, or even delay retrieving
> it till p2sb_bar() call time in the case when it is not hidden ?

-- 
With Best Regards,
Andy Shevchenko




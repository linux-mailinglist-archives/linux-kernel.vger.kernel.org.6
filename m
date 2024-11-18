Return-Path: <linux-kernel+bounces-412964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBDC9D11C9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0A6283F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C910719413C;
	Mon, 18 Nov 2024 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqAJRwE5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B811881E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936279; cv=none; b=mlHMVsm7zm0XFhW6PwatB9FWG0R8BYJuo1LLOWcgv0C+vo3rqLB38BEczWwHhnNnSCRPDGMP3wKdcYF25c43u/+QMI6+KkSwX+0+UD8DloGv64HTiwwMYV8pPTbRpPxwBtIOZvlVNgF5MfiM+f6+6+2YqW1NyI/qVJjU2ZqaS1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936279; c=relaxed/simple;
	bh=Ba/F3f/IbTADSSnKsNrbNTGAcAFmjmGznrrv7Q3DLIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tb9S+9CH4HH68KUTMV3t8rb8yjhsWozTxmOzgqKrhDIfwkTCwpDuK1R/HuX5P7X/dCn+ZFJ/PppoDQR6jB/5uyXIm3rt4+146g0VgpfO8U2P4crSISuNd8EYT1gYrmjZJaRQYm5gtSFoy07RfZiZjrRnrQcCY7YOZm3SKAbqiV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqAJRwE5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731936278; x=1763472278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ba/F3f/IbTADSSnKsNrbNTGAcAFmjmGznrrv7Q3DLIk=;
  b=VqAJRwE5ndmTgLJfpTbm5Qd6/ztA/2lyQq5DvJpPeaLrA/RSoHpXWKhG
   NBaZ4O9cjU8+6Cfep+igS+Gf/QGTnwcNNcvyJACoKHVIUdEpPBPj7Fn8z
   ubzNKJABZp6uVvAmkNE3TTkjn8g6mJy0rpYSrsaPVobDlt1OLed2hXdRV
   2BNCPC3YihuE5DtotRiXuiP/vFiNFHQLU+km1D+MmllLbwXf9lbJ2RTri
   jAA4YmV6vuNX+5FR6ifkg2vFuqcTyujH6lCjVO9LPwtQLGKNuf7nxQZVb
   8/M9VPH3aAYLl0FcEY0KtkOWJMRx9k5LN2Vh5iPSES7hJQi0UDsBWOKXP
   Q==;
X-CSE-ConnectionGUID: 0EYtjDbvQZKziiux46nGgA==
X-CSE-MsgGUID: 6hqylF29Qz6vXwES0oR+Rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="31816379"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="31816379"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 05:24:27 -0800
X-CSE-ConnectionGUID: N+24GyTFSZ6PMKfKM8keiQ==
X-CSE-MsgGUID: 2T7mujaNQ7mYBlVallOCZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="90013365"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 05:24:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tD1jo-0000000G0zB-41po;
	Mon, 18 Nov 2024 15:24:20 +0200
Date: Mon, 18 Nov 2024 15:24:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?Q?J=EF=BF=BDrvinen?= <ilpo.jarvinen@linux.intel.com>,
	Klara Modin <klarasmodin@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danil Rybakov <danilrybakov249@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Message-ID: <ZztABO3TyJBekZRs@smile.fi.intel.com>
References: <ZzTI+biIUTvFT6NC@goliath>
 <cd1cedcc-c9b8-4f3c-ac83-4b0c0ba52a82@redhat.com>
 <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
 <2c828592-dbdd-4cd4-b366-70797d63329d@redhat.com>
 <ZzTk5kyPa5kUxA+f@goliath>
 <a5bafe87-e8f6-40d9-a5d8-34cf6aa576a4@redhat.com>
 <wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7li@pdvthto4jf47>
 <ZzdhTsuRNk1YWg8p@goliath>
 <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
 <Zzs1rw1YcoEEeW7+@goliath>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zzs1rw1YcoEEeW7+@goliath>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 18, 2024 at 12:40:16PM +0000, Daniel Walker (danielwa) wrote:
> On Mon, Nov 18, 2024 at 11:30:59AM +0000, Shinichiro Kawasaki wrote:
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
> 
> No calls to p2sb_bar(). It maybe an Intel GPIO device actually. 0x8086 is Intel's vendor code.
> I suspect it's something standard on Denverton.

Are you referring to LPC GPIO?

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
> The method I used for the bisect was to check lspci for 19dd. I find it odd that
> the device which does exist was not in lspci. Also pci_get_device() fails for
> this device and gpio operations can't happen.

So, it seems like we have avoid removing PCI devices if the P2SB has been
unhidden during the cache call. Still wondering if we simply unhide it early
(if it was hidden) and assume the p2sb device is always present. In this case
p2sb_bar() will become almost an equivalent to the pci_resource_start().

-- 
With Best Regards,
Andy Shevchenko




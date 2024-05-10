Return-Path: <linux-kernel+bounces-175920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FA88C2726
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3BA1C22A10
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A0F171093;
	Fri, 10 May 2024 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqgElacR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C033EAC0;
	Fri, 10 May 2024 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715352655; cv=none; b=lwQHzzQ9xIog5lBMKInK0cO1cdwiWlJp11nlcAlGiFSjewDeGQ5DEm1D3H02SdTvwfMc+VOzXos9R9BKQBrzNK6GtalM3MK6aiLZdaxKyGzDZPoVlSiFmHN9I12GVoPfT4xcX/I/dLfl/SN5ZGeUVvRI4RUTsSFVqSDwUbjwQrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715352655; c=relaxed/simple;
	bh=fyvpNv67G/1TXLVLJpNT2RU8QZLRTMZI02XA5sDLFgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB2XfnZGmSJVdP7oMp3qlD6Gx49a2xZ7zJyChyulU/JHBNkeYD21au4C3b1LfG1T9Kn2tTAfwCtvDkxrrdABptLv3LJNbyl3vnVSVA1uQkDY+vyRVBjbZdINShkCqh0S1YWhUuy0b81Rf1k26nRYjE+G+KJAFrFklKNRFy4Py/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqgElacR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715352653; x=1746888653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fyvpNv67G/1TXLVLJpNT2RU8QZLRTMZI02XA5sDLFgU=;
  b=HqgElacRjE5/zhXFIE5lr1YxU70XV6JNOYXnN82xnG+/oZa4e7GL9Rhc
   AZerexj3Md379Ik3dmKG6dAjeT/Y+sKnsMLZzj2C8lX9NYAW1QAgq0vkA
   PMolDENTycrFXW3rsc2hL8zmftCkbRFHI68RQ5WR1C/CCueHdpBBwDmKp
   2veTnPNe6zBK9RHkb9qAF2a8ZRNcbRSjbskIe5+lZ+emTEjVgCucrqzKc
   hSStwrrgMNgOhgWaH1lEjtgQhDwhPR9u4N0bghHaKE2IeahyC+m7fHBv7
   fqOzYRL0k41wqule2X0PRtkgb7S85/+JI1jZLFiLlLDLa0mbzevB/wcBP
   w==;
X-CSE-ConnectionGUID: YnWBPlvFSw+XGiwcPBWxVQ==
X-CSE-MsgGUID: d3aoLrU4QWSaT5EGg2hYNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11187646"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11187646"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:50:53 -0700
X-CSE-ConnectionGUID: xFwi5WDETv2lQkpwF7DG5w==
X-CSE-MsgGUID: eXObE9V5Ra+05BkRPN5D5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="34151256"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:50:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s5RaA-000000068MS-1U6b;
	Fri, 10 May 2024 17:50:46 +0300
Date: Fri, 10 May 2024 17:50:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: bcfradella@proton.me, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Klara Modin <klarasmodin@gmail.com>,
	Danil Rybakov <danilrybakov249@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ben Fradella <bfradell@netapp.com>,
	Ranjan Dutta <ranjan.dutta@intel.com>,
	Yifan2 Li <yifan2.li@intel.com>,
	Jonathan Yong <jonathan.yong@intel.com>
Subject: Re: [PATCH] p2sb: Don't init until unassigned resources have been
 assigned.
Message-ID: <Zj40RnWnNqpr4Nom@smile.fi.intel.com>
References: <20240509164905.41016-1-bcfradella@proton.me>
 <Zj0CIPR5djf0-hHb@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj0CIPR5djf0-hHb@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 09, 2024 at 07:04:32PM +0200, Lukas Wunner wrote:
> [cc += Shin'ichiro, Klara, Andy, Danil]

Thank you!

> On Thu, May 09, 2024 at 04:49:34PM +0000, bcfradella@proton.me wrote:
> > From: Ben Fradella <bfradell@netapp.com>
> > 
> > The P2SB could get an invalid BAR from the BIOS, and that won't be fixed
> > up until pcibios_assign_resources(), which is an fs_initcall().
> > 
> > - Move p2sb_fs_init() to an fs_initcall_sync(). This is still early
> >   enough to avoid a race with any dependent drivers.
> > 
> > - Add a check for IORESOURCE_UNSET in p2sb_valid_resource() to catch
> >   unset BARs going forward.
> > 
> > - Return error values from p2sb_fs_init() so that the 'initcall_debug'
> >   cmdline arg provides useful data.

..

> >  /*
> > - * pci_rescan_remove_lock to avoid access to unhidden P2SB devices can
> > - * not be locked in sysfs pci bus rescan path because of deadlock. To
> > - * avoid the deadlock, access to P2SB devices with the lock at an early
> > - * step in kernel initialization and cache required resources. This
> > - * should happen after subsys_initcall which initializes PCI subsystem
> > - * and before device_initcall which requires P2SB resources.
> > + * pci_rescan_remove_lock() can not be locked in sysfs pci bus rescan path

PCI bus

> > + * because of deadlock. To avoid the deadlock, access P2SB devices with the lock
> > + * at an early step in kernel initialization and cache required resources.
> > + *
> > + * We want to run as early as possible. If the P2SB was assigned a bad BAR,
> > + * we'll need to wait on pcibios_assign_resources() to fix it. So, our list of
> > + * initcall dependencies looks something like this:
> > + *
> > + * ...
> > + * subsys_initcall (pci_subsys_init)
> > + * fs_initcall     (pcibios_assign_resources)
> >   */

This makes sense to me
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I assume others will conduct the proper review and testing.

-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-kernel+bounces-303456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F460960C46
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA671C22EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB281C0DD0;
	Tue, 27 Aug 2024 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RbeZEGD8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF71BFDFA
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765890; cv=none; b=GaLOsJLP9qgI8+G67L2SaY2ZVGGHS9kHD4vwjX5ceucOtxPWOemgW/03kAaZut5bbA6l2vPhaomyWfQmwDdDgwM9ITFQDTfDbaZNKnordA6tb90jAmr9pjipe+Y3zlazzAyS/fC0aD0yW8BAu9VJQTDNTSIiXbV6+LI1iNfeZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765890; c=relaxed/simple;
	bh=HXxQ+vJ7BgAZV22IWqfP7WqB/wDeHf708osHJycfDtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stlhAKX4Z17zpWGBIR2nzZ4U1JjPhxMv7TcmT/rrS2LnCnmBtQDiI2+bI0uzH3qrUaMyaxmDw9SxMHerDVHcvrNZ7+2Nh7Uyg88vIk3UlKKUT8kDWwT2amrcE4uXlVkKxp4cN4JHsueyH0urpcdBj7O0yUJ6z/mZy/y9cSjJ+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RbeZEGD8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724765889; x=1756301889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HXxQ+vJ7BgAZV22IWqfP7WqB/wDeHf708osHJycfDtE=;
  b=RbeZEGD8j2Tuubwhdl1JK0h4MsBSSgFpDzEJSomu1OnGGYbJrPipecf6
   jQv5TrFUFtIDC37PK4tzyjfDL3hNxkGAaaFe1T2dnlaQ1w6ptdrmB2aS7
   H/Rex1XLTCqaMl36TGg6zKBPjZ/dagPzUezCn0kMPx/A5m7JPW0z1E3Pn
   /4H34DLoop/nlz5gPSLHDF4e6foA6e8jZC/YHRbsGFR0KGZF31olpU+dE
   okbVeTieBqUJXDFF/0dIsv8diNhfYujWtNa0Mpj89MR0i6gFYum507CH0
   J3sdP5B6O3Sk92j8sZ0J+/1GQZHrHRfBhbCW52FNmHC2+JP3/jNmUXypm
   Q==;
X-CSE-ConnectionGUID: AQ/IVAylRCqqemnSp9FFBw==
X-CSE-MsgGUID: cO5A7MDuRhanhQFDmfqvBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="26140218"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="26140218"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:38:06 -0700
X-CSE-ConnectionGUID: 4WKF/VYbSXKe2ZOOzSojYA==
X-CSE-MsgGUID: FOrtBcEJT8G6rgFDuLd7tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="93608627"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:38:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1siwOW-00000002HDN-0d9X;
	Tue, 27 Aug 2024 16:38:00 +0300
Date: Tue, 27 Aug 2024 16:37:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: linux@armlinux.org.uk, krzk@kernel.org, andi.shyti@kernel.org,
	robh@kernel.org, gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
	rmk+kernel@armlinux.org.uk, linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] amba: make amba_bustype constant
Message-ID: <Zs3Wt5xkFOiuH-iP@smile.fi.intel.com>
References: <20240823064203.119284-1-kunwu.chan@linux.dev>
 <ZsiTPjtnZZIW-K4k@smile.fi.intel.com>
 <56e29159-3ebb-425a-9bd6-cb66484d7738@linux.dev>
 <ZsxbjnMa8teJ5_Pg@smile.fi.intel.com>
 <5b4987e3-af8a-413f-bbbe-d493d6c371f6@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b4987e3-af8a-413f-bbbe-d493d6c371f6@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 27, 2024 at 03:45:31PM +0800, Kunwu Chan wrote:
> On 2024/8/26 18:40, Andy Shevchenko wrote:
> > On Mon, Aug 26, 2024 at 06:08:11PM +0800, Kunwu Chan wrote:
> > > On 2024/8/23 21:48, Andy Shevchenko wrote:
> > > > On Fri, Aug 23, 2024 at 02:42:03PM +0800, Kunwu Chan wrote:

...

> > > > > -extern struct bus_type amba_bustype;
> > > > > +extern const struct bus_type amba_bustype;
> > > > Can we actually hide this from the outside, i.e. make it static in the C file,
> > > > and introduce the dev_is_amba() helper instead?
> > > > 
> > > > P.S. You may look at the PNP bus case (some of the latest patches there)
> > > I found it problematic in the process of making changes.
> > > 
> > > There have some usage of amba_bustype outside the AMBA code ,i.e:
> > > https://elixir.bootlin.com/linux/v6.10.4/source/drivers/iommu/iommu.c#L155
> > > 
> > > So, If we make the amba_bustype inside the AMBA code, the outside cannot
> > > access.
> > Yes, that's the idea.
> > 
> > > If only internal access is allowed, it will compile and report an error, how
> > > should I modify it next, and any suggestions?

(1) vvv

> > Make it patch series:
> > 1) patch that introduces exported function called dev_is_amba() (1 patch);
> > 2) convert user-by-user (N patches);
> > 3) hide the bus type and make it constant.

(1) ^^^

> Here[1] have many use of  amba_bustype directly outside the drivers/amba

Yes.

> When I try to hide the amba_bustype by move the extern from
> include/linux/amba to drivers/amba,
> 
> we find some errors: "error: use of undeclared identifier amba_bustype".

Yes, that's why I put (1) to how solve this as we usually do in the Linux
kernel.

-- 
With Best Regards,
Andy Shevchenko




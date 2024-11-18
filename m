Return-Path: <linux-kernel+bounces-413206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3B09D1511
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5ECD282F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1BE1BBBC0;
	Mon, 18 Nov 2024 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTaA7nWQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C47E12EBE7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731946140; cv=none; b=lauGiCdc6I1aPWuiy2kjuQJDSih/CNJnsYEa8ZgHSrbCQpN7YaN5ZhnXJPM8AcOWytDg1ONpyyxyRb5cLYwGv9swKpkSqP8SVIM3QrP7WRyBhaFKknk+vdAW2O0r+vr8NrxurINuwDAI4JLt/QRkEMX8sJ7ucYlOQVoDg116830=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731946140; c=relaxed/simple;
	bh=dpcUP27lHj3PyqCPUoa/ZaYzHTvW96yFn5G9sQB2O3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gS6t9Wa2a9hzgVTHUOpnDHqtUjrsLaX2o5jUWrZInAhIwuyIHesSJ5WQdw8YZdFDWftsVPspqfBywVxhSsBXNWQMkxnp7Bzs02EDhRtvk3NKyeNTIl58A/dO4aKtCFQQIycA6nRACt13kEQ02JevxLIFNcsEZXwObsFSt9ikvAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTaA7nWQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731946139; x=1763482139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dpcUP27lHj3PyqCPUoa/ZaYzHTvW96yFn5G9sQB2O3M=;
  b=LTaA7nWQzKWLETGbXbwNE6EaMIGay9BiaTCQX6ISe5fSyC2g6lDjR3mu
   oLJKnVGzqHD+8Dl32Pajj/xFXTRK8RCmpTLbe4qVv6f6V+0z1baumA6Di
   5n3unJ6+GbXe4GNtjM8brbKwOPNqpP/KinCwfTVSAN0NYCNLM7P5QtxQo
   eMZZl3Gthhy2CzqB1NYMBJLecUXAav4GC6e78lD4sF/OQYwcKU7Ez03re
   ww9pZ9Q1DWLjRJK8YOxDY4JplTMDCHPbHz5jJl2VIxuDR3VSMFg2yIN1c
   WDlYzz0+UXuldy+rva2AjzcT2T0WG5xAm2YNiZAynZeKu6isvEtnBKdyz
   A==;
X-CSE-ConnectionGUID: NOVWLd77Q4qg+vFxpnJasQ==
X-CSE-MsgGUID: eTrDH7MaTI2VZWUyusAoJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="19520588"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="19520588"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 08:08:58 -0800
X-CSE-ConnectionGUID: b1IU0MSZR3moiW/4x/F3pg==
X-CSE-MsgGUID: uLG/rejDQGmWmKUL1aAs/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="89672760"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 08:08:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tD4J3-0000000G4IJ-3USU;
	Mon, 18 Nov 2024 18:08:53 +0200
Date: Mon, 18 Nov 2024 18:08:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Daniel Walker (danielwa)" <danielwa@cisco.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ilpo =?utf-8?Q?J=EF=BF=BDrvinen?= <ilpo.jarvinen@linux.intel.com>,
	Klara Modin <klarasmodin@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danil Rybakov <danilrybakov249@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
Message-ID: <ZztmlT8mBb2NIJ1z@smile.fi.intel.com>
References: <wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7li@pdvthto4jf47>
 <ZzdhTsuRNk1YWg8p@goliath>
 <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
 <Zzs1rw1YcoEEeW7+@goliath>
 <ZztABO3TyJBekZRs@smile.fi.intel.com>
 <ZztCB5hN2NBnPgiR@goliath>
 <ZztF7FKaBwZKs5dk@smile.fi.intel.com>
 <ZztQwLpoZDZzbi6O@goliath>
 <ZztjcntEj5Eo0Rw9@smile.fi.intel.com>
 <df1fa47f-7efb-4b0c-8ef6-100b12ab1523@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df1fa47f-7efb-4b0c-8ef6-100b12ab1523@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 18, 2024 at 05:00:52PM +0100, Hans de Goede wrote:
> On 18-Nov-24 4:55 PM, Andy Shevchenko wrote:

...

> Agreed, still I'm not sure how I feel about us hiding the previously unhidden P2SB.
> 
> OTOH I guess it may have only been unhidden in the BIOS to make the hack they
> are using possible in the first place.

Yeah, sounds like this, because the whole dance with this hiding-unhiding
is due to the Windows yellow bang, due to no driver for the thingy, and
scared users. Reference BIOS should hide it by default when giving a control
to the bootloader and OS.

-- 
With Best Regards,
Andy Shevchenko




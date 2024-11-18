Return-Path: <linux-kernel+bounces-413026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEEB9D1275
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268DC285D60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E6F1991C6;
	Mon, 18 Nov 2024 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="itwDru48"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046C53A7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731937780; cv=none; b=YaDirRKTWk5cpXCE351uI/EFFHj9En9Ue32E0W4BDwRDzJ2OFRu6Schq4IFiqTiAx4QIYD1JUzz8JvpEuH1tXH3ZSoxrJwETQWfZNwctrrtNP2WxtbvG85RCjPl9fHKQQ5vX4fonJFN6RBAfr5ARfd8cvCCHqHeCPwUtUoHjOeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731937780; c=relaxed/simple;
	bh=kl79S75CaXlok1IbLXVpl77WjapkySkJcg40z6VxxtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6uBKkAlNF3mk5WA09ghDTwTmFNGQEuJ/EBIxIJGF9P/xQW8B6rQgIdpObSTScrpuHIHYEPkIxt9Dhz8C90bMJAf27czjJYSfhOfHbViINhJ6i0YsEuj5u7Kl+X3r9pFeNkViO78sw5TJw4aaU6Lc2/geOGtUt8A/melvXlZkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=itwDru48; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731937779; x=1763473779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kl79S75CaXlok1IbLXVpl77WjapkySkJcg40z6VxxtA=;
  b=itwDru48FSos0YCq4p50MBuAlq6q8lWNo8NC7XoG3zdZVKVoGACYi5pc
   QGPJHMKaQoO54u+16PF7tcIEcvFYz6TJKjn48bSmom2apfz2CIF1cKi40
   IOk18miarORN71aoHM+r9Zxyf8DAd7nuLfLHrB9qOZPpQp6zZIbZDmMay
   uRiCmEgWW5lR38pXu+IXzc7ZB6d8SLeBbyMKBtd04iV8637zVagIgW/BW
   aA49SeIVIo2JI4B5mhY6Jp53TUbfTpCHr0x+IZPqUKNYwK9lWWhxJICMZ
   kxKgTjGStREkKySiIap4J2bY9CRSmCHcNcL9HP+sD+cFLqzLpiSOTDnc/
   Q==;
X-CSE-ConnectionGUID: XFpZrOKBSdqT2sUOa/lVog==
X-CSE-MsgGUID: Y3kXC/8dSECkUYHXiI1WjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="32045631"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="32045631"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 05:49:38 -0800
X-CSE-ConnectionGUID: /9NddsHMSm2UaSSKW2Pwcg==
X-CSE-MsgGUID: BPhde0HHQ5avM7aFUSTghA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="89150202"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 05:49:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tD28C-0000000G1Nl-39EU;
	Mon, 18 Nov 2024 15:49:32 +0200
Date: Mon, 18 Nov 2024 15:49:32 +0200
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
Message-ID: <ZztF7FKaBwZKs5dk@smile.fi.intel.com>
References: <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
 <2c828592-dbdd-4cd4-b366-70797d63329d@redhat.com>
 <ZzTk5kyPa5kUxA+f@goliath>
 <a5bafe87-e8f6-40d9-a5d8-34cf6aa576a4@redhat.com>
 <wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7li@pdvthto4jf47>
 <ZzdhTsuRNk1YWg8p@goliath>
 <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
 <Zzs1rw1YcoEEeW7+@goliath>
 <ZztABO3TyJBekZRs@smile.fi.intel.com>
 <ZztCB5hN2NBnPgiR@goliath>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZztCB5hN2NBnPgiR@goliath>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 18, 2024 at 01:32:55PM +0000, Daniel Walker (danielwa) wrote:
> On Mon, Nov 18, 2024 at 03:24:20PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 18, 2024 at 12:40:16PM +0000, Daniel Walker (danielwa) wrote:

...

> > Are you referring to LPC GPIO?
>  
>  I don't know the hardware well enough to say for certain. It's whatever device 8086:19dd is.

This is device which represents p2sb. It's not a GPIO device you are talking
about for sure. You can send privately more detailed info in case this is shouldn't
be on public to me to understand what would be the best approach to fix your issue.

-- 
With Best Regards,
Andy Shevchenko




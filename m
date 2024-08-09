Return-Path: <linux-kernel+bounces-281027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA2394D205
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE29F1C216E8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFDD19754D;
	Fri,  9 Aug 2024 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXXBerKX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17801183CD5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213121; cv=none; b=qQN8Mlyx04X7YUzZB+ZQDP5uFwFsxVTtc39E7mC6m5r66WXpyXFoqaK8KqLlU343L7f8W/oALgLWuA3qdgqI5zvmAg0IjpbT2qaRBz1YpXc9837ipKNEFGerVGPZOeB40AgfuqNbgevO1BsgmrxaEzk8yxn1YiKpotE2CY/axG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213121; c=relaxed/simple;
	bh=jR8DUHypHhaZJ2U/6q5+nM49Nrsd6Q8QBOaKaMTM9T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1cKiXkiLakSMN5rZuPdIk5Ytcr6rsk4P2HuWmYVli762XcIalHRJEkCA2jeUEOvQgdA/zkALwWcIr8u3Km9JKNfeHHGNhhhaJp3aDMd6UtAWb5yu6ihuMuy8lj8QzMaJxgCz4gOFIgfGRVT5m5kP8W4EvnQlJDTYAd0EeHc/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXXBerKX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723213121; x=1754749121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jR8DUHypHhaZJ2U/6q5+nM49Nrsd6Q8QBOaKaMTM9T4=;
  b=QXXBerKXyp1dBoHRvTsOc97ZSIxc/nbK20qtxtaUP1M1yXDcGALugzLV
   a7X4BEX6LV6DT/94CdFzJdAHFyns8POOmIVerVuOF3gM+ogNynsBrbb7Z
   gXljzkR+CyMgGG7/kCQosNwxC/KgPhwqs2IGCUpniX1057EWJr9AM5lzW
   DmQxWU3NHsNU39APPCFWGflZ5tEZ7jNzp2/BZJgbLX5SazPxEJ8TPPKek
   0TAqLjtnrvJrmTMLjbtOxi9HIMg0F110bPCmsbnlJN71+J1CToP4flHhQ
   OsseShPp6cLO4n7s7b2HdNuWnJ7nfvxPp2/3TT3QPG4Mf3NctkJTledyb
   g==;
X-CSE-ConnectionGUID: jkvwOLijQN2va6BtwXu17A==
X-CSE-MsgGUID: cPAIVGokRkS4bZhcXMY/uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21362754"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21362754"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 07:18:40 -0700
X-CSE-ConnectionGUID: s4KZTVdLSVyVEDRtoS1eqA==
X-CSE-MsgGUID: +rmy6afXTn+mfvua97pYDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="80812388"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 07:18:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1scQRo-0000000DRKO-3Dyo;
	Fri, 09 Aug 2024 17:18:28 +0300
Date: Fri, 9 Aug 2024 17:18:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RESEND v3 1/6] i3c: mipi-i3c-hci: Add MIPI0100 ACPI ID to
 the I3C Support List
Message-ID: <ZrYlNOjFQE9dHsVV@smile.fi.intel.com>
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
 <20240807052359.290046-2-Shyam-sundar.S-k@amd.com>
 <e94efd42-bc3f-4003-8ad8-2da6500f0f13@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e94efd42-bc3f-4003-8ad8-2da6500f0f13@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 09, 2024 at 04:54:18PM +0300, Jarkko Nikula wrote:
> Hi
> 
> I Cc'ed Andy and Rafael because of ACPI ID allocation question that came to
> my mind below which I'm not expert enough to answer.
> 
> On 8/7/24 8:23 AM, Shyam Sundar S K wrote:
> > The current driver code lacks the necessary plumbing for ACPI IDs,
> > preventing the mipi-i3c-hci driver from being loaded on x86
> > platforms that advertise I3C ACPI support.
> > 
> > This update adds the MIPI0100 ACPI ID to the list of supported IDs.

When adding a new ACPI ID, always provide the following information:

1) link (in some form) to the official confirmation / documentation for
the allocated ID by the vendor (MIPI in this case) _OR_ (very exceptional!)
why the bad ID had been allocated;

2) are there devices in the wild (on the market) that use the being added ID(s)?

3) excerpt from the device (independently if it's public already, see above,
or not) DSDT ACPI table.

With the given patch it looks to me that you most likely need a local, AMD
specific ID as well.

So, in my ideal world the DSDT should be like

	Device (I3CC)
	{
		Name (_HID, "...") // AMD specific _HID
		Name (_CID, "MIPI0100") // Compatible ID for generic I3C controller
		...
	}

Is this the case? Why not?

P.S. Make sure you Cc me on ACPI ID matters in the future.

-- 
With Best Regards,
Andy Shevchenko




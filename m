Return-Path: <linux-kernel+bounces-295617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDF3959F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CC0282102
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2AD1AF4F8;
	Wed, 21 Aug 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/vlvRAR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E021AF4E0
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248613; cv=none; b=KDQZf2gUg4qtSkbcIeFYVak3SUvb68qcVru84DuJEWJXNeyBS9FADpRGUaYnTqOzb0tZ5+5MYCcuRb2kJ/XwQm8Xx/E1wcoJ0f4RSm6XAiyRnZ+ixeuPraUBGuRlstPjhdDQBqQPXNXjqdJcg/kLCnPvvMu5jAQk2OXrTvp7toE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248613; c=relaxed/simple;
	bh=tu0TnCrkCWoRLS38XXnu3gUicmftHm/PcZVfj4gnrrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLyRdh9wMyJ2x6fg70EkazVwfwagtFpK3sqbjIcoZukqPC3vsLA3ezCA0NCQ2Q84YAVw+zLHfBZn/AHumxHyY39KDa5sy1MyyMvDft0CSlCdbeEDSqumJceCNsI262mmEEhRd/B7aIHAX0drKLR1FQtfIYQ9YJoudY40hGlJTlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/vlvRAR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724248612; x=1755784612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tu0TnCrkCWoRLS38XXnu3gUicmftHm/PcZVfj4gnrrg=;
  b=f/vlvRARIINAdu5DGf4+gZ2II6hoaUaqbpcWP4K/JsRJWreiT2vLGDi6
   UxizZXr3fsNa6jagsEGKtamfpoo8FUBc6QNk7h9yugWzmiivB/QeV2cOQ
   4X7rzv0zpGYttNP1uZ1o+O/ZTmdNcaw4WIcct4T4MNGdRMdk0YSnwVkJJ
   8iOw5ED+crfis/2lvTX7RPb0uLsfIB2bwfY4qg7NDhWkqrqz/fkpQ0emD
   uhoUbyqpedhVkCJAC1TDLi0i4WaWVEBn5o/4qZBLK6vehkdp3o4BG7zNt
   n40ga9RY5nCYJr+D/3grxYc5wosuh4RWGsXvBR+tCBqs+H6lXbvGpMprY
   g==;
X-CSE-ConnectionGUID: gdQ/2rSvSUWJ1+w7RX45PA==
X-CSE-MsgGUID: 2BnbR8nqRueGy7bdT6GPgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22221400"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22221400"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:56:51 -0700
X-CSE-ConnectionGUID: zJ0Wy885SOym5WxJCCGkzw==
X-CSE-MsgGUID: JVA/9GUdRv6pSxjVrKSL0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61077347"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:56:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sglpO-0000000066B-1674;
	Wed, 21 Aug 2024 16:56:46 +0300
Date: Wed, 21 Aug 2024 16:56:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] i3c: mipi-i3c-hci: Add AMDI5017 ACPI ID to the
 I3C Support List
Message-ID: <ZsXyHfLJ8SJOW0RF@smile.fi.intel.com>
References: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
 <20240821133554.391937-2-Shyam-sundar.S-k@amd.com>
 <9584ddb0-6e39-4d04-9242-a68eb4b86eba@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9584ddb0-6e39-4d04-9242-a68eb4b86eba@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Aug 21, 2024 at 07:07:45PM +0530, Shyam Sundar S K wrote:
> + Andy

Thank you!

> On 8/21/2024 19:05, Shyam Sundar S K wrote:
> > The current driver code lacks the necessary plumbing for ACPI IDs,
> > preventing the mipi-i3c-hci driver from being loaded on x86
> > platforms that advertise I3C ACPI support.
> > 
> > This update adds the AMDI5017 ACPI ID to the list of supported IDs.

Please, provide a DSDT excerpt to show how it will look like in the ACPI
tables.

...

> > +static const struct acpi_device_id i3c_hci_acpi_match[] = {
> > +	{"AMDI5017"},

Spaces are missing

	{ "AMDI5017" },

> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(acpi, i3c_hci_acpi_match);

...

Otherwise LGTM, thanks!

-- 
With Best Regards,
Andy Shevchenko




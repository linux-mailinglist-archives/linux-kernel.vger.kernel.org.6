Return-Path: <linux-kernel+bounces-306723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5AE964292
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56107B252CB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1679F190471;
	Thu, 29 Aug 2024 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GAprF7WR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C28647
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929497; cv=none; b=Q10+EnQbVrWHR63vYcmORgm1xjIW6c5rsm7gtAoPvWvMo4uM3hbyvAi8tbIzQheh+9XiqFZBuPDo+ZKUkeaLDcptTh5IeXAVKms32p5BoZ4mMb92hRiPRHuKBemVs6XcSU6lHBT7a1FnNKAdkWXsCTtjVx8FQZCdmbZSysv6aNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929497; c=relaxed/simple;
	bh=J6fvJlJc/Ob8k1M+y/Rml88PewDlhA9IfR+J4mDzajQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEZrdzP46vEV7PR8+fj3Prn/HIwd1jA0iERQy0bQbrmY7K6A8rxO8/LSf09aGRl81GspebNZEPUY5ol3SzBajO4aaLbfkShH7u7bgAdikAtUmjfjTEaxcOEFTJqaHIBSsAX9vuGND68dBSmKa6LVnArgqG968gia89jOZwQSSjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GAprF7WR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724929486; x=1756465486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J6fvJlJc/Ob8k1M+y/Rml88PewDlhA9IfR+J4mDzajQ=;
  b=GAprF7WRhaEuGW96Z9bcuYzRF4gnUWxQfHjLtVtXjjVDpO0RPJ+3afNa
   vsZo+cIVUq9cjWGNviZFNN9blXE6zwQ+5+KIX25XGNphmJPJP9xqsy59F
   A+RF11vUfyHbbGoX+d30+okMZXZoBztV44topazJ1s9oXKQf9gPDrAVCq
   3ZfF1kejnk8vrJkFIdIhGBJG6DQpCr79vdnnPN3UYP3xTZNV9B5PUJSQX
   JkE9BXdHyXSpmxcwOG9au4dj2QwvafFkgfxRqsVfIyDVt/PZdWHYOzwmQ
   MpR+58q9JpecEimNrkXjV7+JdaDvAGf1Hw5ypM0+cHEb1nhurdhQmUI9U
   g==;
X-CSE-ConnectionGUID: LNguGdhxTVGA7J6Du8lTvQ==
X-CSE-MsgGUID: G4oobcafSIuml4AX8VQG6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23088381"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23088381"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 04:04:45 -0700
X-CSE-ConnectionGUID: u7l1uVU4SdCcFyOucV3HEA==
X-CSE-MsgGUID: MCF9pKvkTJa3Qep55W5U1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63224001"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 04:04:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjcxE-00000002yKA-2tDH;
	Thu, 29 Aug 2024 14:04:40 +0300
Date: Thu, 29 Aug 2024 14:04:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/6] i3c: mipi-i3c-hci: Add AMDI5017 ACPI ID to the
 I3C Support List
Message-ID: <ZtBVyJZc03EixpPT@smile.fi.intel.com>
References: <20240829091713.736217-1-Shyam-sundar.S-k@amd.com>
 <20240829091713.736217-2-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829091713.736217-2-Shyam-sundar.S-k@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 29, 2024 at 02:47:08PM +0530, Shyam Sundar S K wrote:
> The current driver code lacks the necessary plumbing for ACPI IDs,
> preventing the mipi-i3c-hci driver from being loaded on x86
> platforms that advertise I3C ACPI support.
> 
> Add the AMDI5017 ACPI ID to the list of supported IDs.

...

>  static struct platform_driver i3c_hci_driver = {
>  	.probe = i3c_hci_probe,
>  	.remove_new = i3c_hci_remove,
>  	.driver = {
>  		.name = "mipi-i3c-hci",

>  		.of_match_table = of_match_ptr(i3c_hci_of_match),

A side note (not sure if it anyhow might be related to your kernel
configurations and builds): There is an ongoing activity to kill
of_match_ptr() for good (as it's more harmful than useful). It _might_ be
that in ACPI only kernel configurations dangling i3c_hci_of_match appears
which compiler will warn about.

> +		.acpi_match_table = i3c_hci_acpi_match,
>  	},
>  };

-- 
With Best Regards,
Andy Shevchenko




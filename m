Return-Path: <linux-kernel+bounces-539214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E54A4A212
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE382166D65
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C17917A308;
	Fri, 28 Feb 2025 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIM4SHUF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA6277005;
	Fri, 28 Feb 2025 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768481; cv=none; b=WA18uRwKqXLQmU6uVSbJ6Jea6Dw3UO1rbWuCWMWJqdXnPkGFV/cnuvNY0QJgqu/ViY0AOYsyWa3K73bR/Nx85RqHYe0EcVT8abgoFIf/UuO/FChbw/HZYk1eBnsuK0gM0Cmh3E2QJ5/YbZ20cX9SZvS2Nt0ueWNoJ6khD9rctkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768481; c=relaxed/simple;
	bh=sjccjNRDhW5cSMFd28Q8pm//au0XHsNKas9BxsXZWSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffYCyVeBNH1NLyjUwOptGaiCpLtLvu0R3SLcZTjhG4L1QNLDzWNj+6OeeKP9HOeT14W5+j5Zsi0vDbswgVPbbaYSpFXZXBNIOIY1IIPYw1tTW39TiTldZB7kbNQOIqEqCiDoa3gzYGbviTOGVOBcAi+1f8DHDczV6bXLRiA0s2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AIM4SHUF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740768480; x=1772304480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sjccjNRDhW5cSMFd28Q8pm//au0XHsNKas9BxsXZWSk=;
  b=AIM4SHUFh3kZciOi4zgsZOu/6B0GkxrtMXiBQRVPM2+lKvFPmzV34Kes
   LzLJmL/6jIxcOEjV0qIawUyrIqgQ3ag+zFnCIHy4tuVDcTY64J8A+AIKS
   iRCggY7TLTJPTuYOMmcGyHrlMMbIy0GlMJHpx/sTXtv1ZFJwCdRR80no5
   VJw0XjB4ouDA5yO07TlNYbhi/6rTjbuknb078SedWmHckulrRoGenTYZm
   kMk/azmeMiQUhxUBIftJsX9QNNW6I+peBgSkdYAzwYrmNH9fEIo5HRaGv
   aWFrnXXIfA7JeN4PeGE7kkAJidClLOR7tE4tOFMogGW+kN+NcqGCwEq6M
   Q==;
X-CSE-ConnectionGUID: fIKk2cM1QmmP00gpnmB4cw==
X-CSE-MsgGUID: cPvOTjwNS7ufPLi85bjXuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="52349871"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="52349871"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:47:59 -0800
X-CSE-ConnectionGUID: jbTsohC5QoqbJW5f0yiN5Q==
X-CSE-MsgGUID: Qg72W58CSCq/VdtSuV77hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117934373"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 10:47:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1to5Oo-0000000G3kA-3NNX;
	Fri, 28 Feb 2025 20:47:50 +0200
Date: Fri, 28 Feb 2025 20:47:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	"apw@canonical.com" <apw@canonical.com>,
	"joe@perches.com" <joe@perches.com>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Asahi Linux Mailing List <asahi@lists.linux.dev>
Subject: Re: [PATCH v5] lib/vsprintf: Add support for generic FourCCs by
 extending %p4cc
Message-ID: <Z8IE1jIni50OeKaE@smile.fi.intel.com>
References: <2C9622E6-A2DB-4681-A971-604C79F9955E@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2C9622E6-A2DB-4681-A971-604C79F9955E@live.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 28, 2025 at 04:29:12PM +0000, Aditya Garg wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> %p4cc is designed for DRM/V4L2 FourCCs with their specific quirks, but
> it's useful to be able to print generic 4-character codes formatted as
> an integer. Extend it to add format specifiers for printing generic
> 32-bit FourCCs with various endian semantics:

> %p4ch	Host-endian
> %p4cn	Reverse-endian

Call them Host order, Network order as they are very established endianesses.


> %p4cl   Little-endian

You have extra spaces here

> %p4cb	Big-endian
> 
> The endianness determines how bytes are interpreted as a u32, and the
> FourCC is then always printed MSByte-first (this is the opposite of
> V4L/DRM FourCCs). This covers most practical cases, e.g. %p4cn would
> allow printing LSByte-first FourCCs stored in host endian order
> (other than the hex form being in character order, not the integer
> value).

...

> +Generic FourCC code
> +-------------------
> +
> +::
> +	%p4c[hnlb]	gP00 (0x67503030)
> +
> +Print a generic FourCC code, as both ASCII characters and its numerical
> +value as hexadecimal.
> +
> +The generic FourCC code is always printed in the big-endian format,
> +the most significant byte first. This is the opposite of V4L/DRM FourCCs.
> +
> +The additional ``h``, ``n``, ``l``, and ``b`` specifiers define what
> +endianness is used to load the stored bytes. The data might be interpreted
> +using the host-endian, reverse-host-endian, little-endian, or big-endian.

host order, network order

> +Passed by reference.
> +
> +Examples for a little-endian machine, given &(u32)0x67503030::
> +
> +	%p4ch	gP00 (0x67503030)
> +	%p4cn	00Pg (0x30305067)
> +	%p4cl	gP00 (0x67503030)
> +	%p4cb	00Pg (0x30305067)
> +
> +Examples for a big-endian machine, given &(u32)0x67503030::
> +
> +	%p4ch	gP00 (0x67503030)
> +	%p4cn	00Pg (0x30305067)
> +	%p4cl	00Pg (0x30305067)
> +	%p4cb	gP00 (0x67503030)


For the reference on the terms:
https://www.ibm.com/docs/ja/zvm/7.2?topic=domains-network-byte-order-host-byte-order

Otherwise LGTM. With the above addressed, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko




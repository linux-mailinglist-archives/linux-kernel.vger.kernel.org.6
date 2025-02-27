Return-Path: <linux-kernel+bounces-536624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14271A4822C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6105F188A2B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F8F23C8AD;
	Thu, 27 Feb 2025 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHRuQi8y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E069223A9BA;
	Thu, 27 Feb 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667423; cv=none; b=hYr1ccT62A2GFLshX5zpaz6WUALFnUQknDihkgxi2WlGWXwDMuGsiBJWwkcc76NCSTugiKuEtWp7w1u5sDtQg644f3Kf52DLjq+6yPRaeAi2HG0tVanY+U0FklcWwz05fyJgxtv/kgbqPi0IyXlIvi2E71Rjqcsvgtu48YWpVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667423; c=relaxed/simple;
	bh=PKuqM641cYDMmskSgB/xhgz4dLSt0mry+F0+ufVbEKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSFppLP9/ntOFApbqrGIF2goqfruz3P8+9+WQL0/ZtPgERQWE1cgOr/rRSvlr7ECgGu7UIv3teW3kzMuf4+q0s85yRqMmR6Su/ogwHU95+1vNvlKmBvkIjImDcJLKQXAl9sZd2oBqyTIjbAIGSW3Kyv6Phl6mjKFa2K8zBNQ1tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHRuQi8y; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740667422; x=1772203422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PKuqM641cYDMmskSgB/xhgz4dLSt0mry+F0+ufVbEKM=;
  b=IHRuQi8yjDU5/HnMMB7WMUKabPu68IbOzH7f5m/qL96v2egKIphZfWQD
   gn8Ng8c0+SMoRLPuGBEWCCS701et9K5tUy30GPxcsm6tfHonJGgmjXZTo
   tGeAufYPub1ROJ/MuT6SmrQZ+lxew2laAAWGj9yy2T9nPXKSNpDRmw8X0
   PW+pVRkxUl6GILSfHcIlC+YX92DxsR0WlH9WJgmeV9SbmB+af1XUV5E5w
   oXbMZH9W0qecGC8FUwqzpNnXmo2Me4J0SmCxMyJO7f3U4AOxz4SMRiaJ6
   Ryg2U33UOoS+GCuxY26rIgsJf24oTEhGLiNT/5nDdHXb48qJim5Pky1kl
   Q==;
X-CSE-ConnectionGUID: UkQq+PJSSJ+8Z4gbpkHh3w==
X-CSE-MsgGUID: Z0lYpalQQkWiTwfVIFYcMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="44384154"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="44384154"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:43:38 -0800
X-CSE-ConnectionGUID: kzNVvKU3RTmfNsZxGFknug==
X-CSE-MsgGUID: ImErlco9RJ6Ujqi/CBDfqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117558281"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:43:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnf6l-0000000FcjH-3wGS;
	Thu, 27 Feb 2025 16:43:27 +0200
Date: Thu, 27 Feb 2025 16:43:27 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "pmladek@suse.com" <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"apw@canonical.com" <apw@canonical.com>,
	"joe@perches.com" <joe@perches.com>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hector Martin <marcan@marcan.st>,
	"sven@svenpeter.dev" <sven@svenpeter.dev>,
	Janne Grunau <j@jannau.net>,
	"alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
	Asahi Linux Mailing List <asahi@lists.linux.dev>
Subject: Re: [PATCH v4] lib/vsprintf: Add support for generic FOURCCs by
 extending %p4cc
Message-ID: <Z8B6DwcRbV-8D8GB@smile.fi.intel.com>
References: <DB7F502D-1477-49C9-A36D-1DEE408ED23C@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7F502D-1477-49C9-A36D-1DEE408ED23C@live.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 27, 2025 at 06:30:48AM +0000, Aditya Garg wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> %p4cc is designed for DRM/V4L2 FOURCCs with their specific quirks, but

FourCC (as Four is not an acronym itself).

> it's useful to be able to print generic 4-character codes formatted as
> an integer. Extend it to add format specifiers for printing generic
> 32-bit FOURCCs with various endian semantics:
> 
> %p4ch   Host-endian

Too many spaces :-)

> %p4cl	Little-endian
> %p4cb	Big-endian
> %p4cr	Reverse-endian

> The endianness determines how bytes are interpreted as a u32, and the
> FOURCC is then always printed MSByte-first (this is the opposite of
> V4L/DRM FOURCCs). This covers most practical cases, e.g. %p4cr would
> allow printing LSByte-first FOURCCs stored in host endian order
> (other than the hex form being in character order, not the integer
> value).

...

> +Generic FourCC code
> +-------------------
> +
> +::
> +	%p4c[hrbl]	gP00 (0x67503030)
> +
> +Print a generic FourCC code, as both ASCII characters and its numerical
> +value as hexadecimal.
> +
> +The additional ``h``, ``r``, ``b``, and ``l`` specifiers are used to specify
> +host, reversed, big or little endian order data respectively. Host endian
> +order means the data is interpreted as a 32-bit integer and the most
> +significant byte is printed first; that is, the character code as printed
> +matches the byte order stored in memory on big-endian systems, and is reversed
> +on little-endian systems.

Btw, this sounds to me that 'h' should be accompanied with 'n', otherwise it's
confusing why BE is the host order out of the blue.
so, it needs more information that this mimics htonl() / ntohl() for networking.

Does 'r' actually should be 'n'?

> +Passed by reference.
> +
> +Examples for a little-endian machine, given &(u32)0x67503030::
> +
> +	%p4ch	gP00 (0x67503030)
> +	%p4cr	00Pg (0x30305067)
> +	%p4cb	00Pg (0x30305067)
> +	%p4cl	gP00 (0x67503030)
> +
> +Examples for a big-endian machine, given &(u32)0x67503030::
> +
> +	%p4ch	gP00 (0x67503030)
> +	%p4cr	00Pg (0x30305067)
> +	%p4cb	gP00 (0x67503030)
> +	%p4cl	00Pg (0x30305067)
> +

...

> +	switch (fmt[2]) {
> +	case 'h':
> +		val = orig;
> +		break;
> +	case 'r':
> +		orig = swab32(orig);
> +		val = orig;
> +		break;
> +	case 'l':
> +		orig = (__force u32)cpu_to_le32(orig);
> +		val = orig;
> +		break;
> +	case 'b':
> +		orig = (__force u32)cpu_to_be32(orig);
> +		val = orig;
> +		break;
> +	case 'c':
> +		/* Pixel formats are printed LSB-first */
> +		val = swab32(orig & ~BIT(31));
> +		pixel_fmt = true;
> +		break;
> +	default:
> +		return error_string(buf, end, "(%p4?)", spec);
> +	}

Actually you can replace all these orig copies by introducing a new boolean, pixel_be.

Will become

	switch (fmt[2]) {
	case 'h':
		val = orig;
		break;
	case 'r': // or 'n' ?
		val = swab32(orig);
		break;
	case 'l':
		val = (__force u32)cpu_to_le32(orig);
		break;
	case 'b':
		val = (__force u32)cpu_to_be32(orig);
		break;
	case 'c':
		pixel_fmt = true;
		pixel_be = orig & BIT(31);
		/* Pixel formats are printed LSB-first */
		val = swab32(orig & ~BIT(31));
		break;
	default:
		return error_string(buf, end, "(%p4?)", spec);
	}

And with this the existence of 'val' now becomes doubtful, we may reuse 'orig',
just name it 'val' everywhere, no?

-- 
With Best Regards,
Andy Shevchenko




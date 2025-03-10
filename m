Return-Path: <linux-kernel+bounces-553800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7ECA58EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BB9188632D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C98C2248AC;
	Mon, 10 Mar 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNPsVcXQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD182248A4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597520; cv=none; b=HDAU2rVznjV/z7Y5ywccstlR8IJJmJyXgjoyNRomPyBLemKK1A5Rj52V+qRCG8sHo/uG4GYt1Pjsdk7qGuRfGuqKKJKqO0WCIYL7WiWef9kOR2XraEPyE536+lcNMIcTBNPgT+NHUXMhwWaSKkzd3xYNyWL/jCe87/5yeJ+rFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597520; c=relaxed/simple;
	bh=H9aOs02SWLngIIsgj7aqOszYNTxcOhjqxOo2HstY74s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AW+rEP42HdpSZbXZZrmyUN46hxer5NIgDTneNN8GfxRO/+HPfOGRLC3raeusON6By+NcYySqjpoWgt3BHz1IaEiS1n6ew+vS3NN9EThJTmfjloaLfawVyd9om35qS+j4vNP6JwiWCXxa5GU5DsOrXzKcD6bVAT908RrOyP+85y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNPsVcXQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741597519; x=1773133519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H9aOs02SWLngIIsgj7aqOszYNTxcOhjqxOo2HstY74s=;
  b=hNPsVcXQe2xudNSr0AFSGzhm+uVQIPaePWi5N1fW6Z18AP3Civ8oN3ND
   yPxxgxDKI4QTgRgzA0z9ruTA4gBKPjazaGGFQGlDRWMc76TyCOQ7GHod3
   ineUoqcTCQ4g1TZi67aZWINkTeHEYRdvscg+QXdMNXASzJMYmiD1MUr3D
   nsZYxI/LnmrcF7NJ/fzJ2plUTcUT5t2DlcudExOazeAVSooPheIgFhyqH
   bfs6ayhw60rNGiruyALRPvBQDyB0+CEnRbMwMfNal3uT7Eo1BLB0ct2l7
   5Ehd2J3yYSOgceq3HmxOj6IJQgGQKmeiHGDdGFpxEPIDaLnyshpbfqfzI
   A==;
X-CSE-ConnectionGUID: OhGm3AZJTmaCqHK7Flifrg==
X-CSE-MsgGUID: NWYhuMISS5WtuTpaFlBfig==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="53222277"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="53222277"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 02:05:19 -0700
X-CSE-ConnectionGUID: uqIzASqnTs+E+NJozEbXxw==
X-CSE-MsgGUID: TW0nVdEzR9SOfmZS0hTRgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="120642449"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 02:05:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1trZ4T-00000001CMU-3nZO;
	Mon, 10 Mar 2025 11:05:13 +0200
Date: Mon, 10 Mar 2025 11:05:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, nnac123@linux.ibm.com,
	horms@kernel.org
Subject: Re: [PATCH v2 1/1] lib: Optimise hex_dump_to_buffer()
Message-ID: <Z86rSd88eSiJxV-M@smile.fi.intel.com>
References: <20250308093421.3724-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308093421.3724-1-david.laight.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Mar 08, 2025 at 09:34:21AM +0000, David Laight wrote:
> Fastpath the normal case of single byte output that fits in the buffer.
> Output byte groups (byteswapped on little-endian) without calling snprintf().
> Remove the restriction that rowsize must be 16 or 32.
> (All callers currently pass 16 or 32.)
> Remove the restriction that groupsize must be 8 or less.
> If groupsize isn't a power of 2 or doesn't divide into both len and
>   rowsize it is set to 1 (otherwise byteswapping is hard).
> Change the types of the rowsize and groupsize parameters to be unsigned types.
> 
> Fix the return value (should be zero) when both len and linebuflen are zero.
> 
> All the updated tests in lib/test_hexdump.c pass.
> Code size (x86-64) approximately halved.

...

> -extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
> -			      int groupsize, char *linebuf, size_t linebuflen,
> -			      bool ascii);
> +extern size_t hex_dump_to_buffer(const void *buf, size_t len, size_t rowsize,

Why is extern still here?

> +				 size_t groupsize, char *linebuf,
> +				 size_t linebuflen, bool ascii);

int - > size_t in the returned value is incorrect change.
This is explained in the comments to the test cases patch series.

-- 
With Best Regards,
Andy Shevchenko




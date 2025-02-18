Return-Path: <linux-kernel+bounces-519293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CACA39B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6521887F85
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E6223DE85;
	Tue, 18 Feb 2025 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3j1GjpD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15588233155
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878689; cv=none; b=jPfQIU/Ohn7GZNaexDKkC1V71d07gytZar/Qz/o38SPBX7qjABeKQH9EmbkE9vqVZvWIurXZytYLSs4fn25Qbgej47sP05MF2q0K+XaJAkaIoSgACyhxZsT9KWfcohPAYh14Z61IQV9RqzIivBYo7eNmBoMkdpPeN/KCul1DLDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878689; c=relaxed/simple;
	bh=6q1iXsSRhhA5iraUx9/TlIOcuAXc4FlVkywxBcBWo7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARc1h9uS9MbmoYCmMd04cpTL/xgtarv5+uJX+uczY34mkuicc/PfTW6aSCBXeaUwbP4hZBOLcCaAL7shZKAUp1RSkoFliOOV4/wdLVSwu0u1HB80Q4Bd2/Dgy0pqIyi4GQUVTHbnm6hznPpOhjVTYljBXePu7RSXVfedEVFwhEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3j1GjpD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739878688; x=1771414688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6q1iXsSRhhA5iraUx9/TlIOcuAXc4FlVkywxBcBWo7A=;
  b=I3j1GjpDcD2CkCBASPmEwxxiROQds5ve0bd8/DuTEN8xEku1/VbHXgir
   pkDeNlm2Lcn4WkGwvuH4Wf5mhH3UaICeK1FM2DZHP/85Vynt6/C17zKEg
   0RlEnAo2NrGpVZm44ev5xGSazwNGBv1p8etI20kWXt6yWffRWJZUqjUbM
   OAajp7wdqx0nkI9I8IMNSxayFWyhdJNNHk1nnoGRtnhi99VVTkA6C17A2
   0ZvtSVG4pIcSJrHq5tTx7vB3fX2iAydkQ/IZr05H/57mvoU9WVhPhlzjp
   FuLttcgk2qwvXHS0CIuvbe1fgmDCbBRRyJM6O2kWtbEWUFyv5iNBbB9MJ
   Q==;
X-CSE-ConnectionGUID: GQ4jMjCpQZqG4zFQwEp/GA==
X-CSE-MsgGUID: mGlVdeZiRCGt1X5rm1X2Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52000405"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52000405"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 03:38:07 -0800
X-CSE-ConnectionGUID: 1PPprSuYTq+skJ95hig4nQ==
X-CSE-MsgGUID: oX3/9mneSNWk1zRt4ot+YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119298528"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 03:38:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tkLvO-0000000ChkY-3myE;
	Tue, 18 Feb 2025 13:38:02 +0200
Date: Tue, 18 Feb 2025 13:38:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH next 1/1] lib: Optimise hex_dump_to_buffer()
Message-ID: <Z7RxGlCkQG9M4AeM@smile.fi.intel.com>
References: <20250216201901.161781-1-david.laight.linux@gmail.com>
 <Z7JO9eutvu3KBEbc@smile.fi.intel.com>
 <20250216223715.734fedc8@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216223715.734fedc8@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 16, 2025 at 10:37:15PM +0000, David Laight wrote:
> On Sun, 16 Feb 2025 22:47:49 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, Feb 16, 2025 at 08:19:01PM +0000, David Laight wrote:

...

> > > +extern size_t hex_dump_to_buffer(const void *buf, size_t len, size_t rowsize,
> > > +			      size_t groupsize, char *linebuf,
> > > +			      size_t linebuflen, bool ascii);  
> > 
> > Looking at another thread where upper layer function wants to have unsigned
> > long flags instead of bool ascii, I would also do the new API, that takes flags
> > and leave the old one as a simple wrapper with all restrictions being applied.
> 
> I can't imagine any code relying on the rowsize being converted to 16.
> And (elsewhere) I've definitely needed to do hexdumps with strange numbers
> of bytes/line.

I didn't get how this is related to my comment.

...

> > > +			dst[0] = hex_asc_hi(ch);
> > > +			dst[1] = hex_asc_lo(ch);  
> > 
> > We have hex_pack_byte() or so
> 
> At least some versions of gcc have generated better code if you don't
> use *ptr++ but do the increment afterwards.
> It is also what the old version used.

Do we really care? What versions, btw, are you talk about?

> Not to mention being another wrapper you need to look up to work out
> what the code is doing.

That's not an issue. We use a lot of wrappers in the Linux kernel.
Without a skill to quickly find this information it would be very
hard to develop the kernel code without reinventing a wheel.

...

> > > -		linebuf[lx++] = (isascii(ch) && isprint(ch)) ? ch : '.';
> > > +		*dst++ = ch >= ' ' && ch < 0x7f ? ch : '.';  
> > 
> > Please also add a test case for this to make sure it has no changes.
> 
> Well isascii() usually checks for the 0x80 bit being clear and isprint()
> rejects control characters and 'del' (0x7f).
> I'm not sure what isascii() does for EBCDIC type charsets - but I don't
> expect Linux runs on any of those so who cares.

Still, it's good to have a test cases for this change.

> Oh, and isprint() seems to be based on a memory lookup in an _ctype[] array.
> Very 1970s.

With enough CPU (data) caches it's quite effective.

-- 
With Best Regards,
Andy Shevchenko




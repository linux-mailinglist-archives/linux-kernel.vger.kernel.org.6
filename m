Return-Path: <linux-kernel+bounces-538462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955BCA49901
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE39D3B68C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46562356D1;
	Fri, 28 Feb 2025 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2S4+9ai"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE1423315A;
	Fri, 28 Feb 2025 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745006; cv=none; b=LASPF3LkVjj6Rke9HuiirWqA4ZmykhJJJqTjMSUmua716LKHWxc3dYXhnsFEQh1c0kscvK0/4zkAyf53/f/tGQM3RAgh8Bv95gI1k51EawqurKBIYSZcLvbsZ2taaNV6D5vbMCygk8POs12op0b98NcnMF7elmMCdvvT+FW0PbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745006; c=relaxed/simple;
	bh=Imv45Fvq22xNgZhJykuszyMaW/DiQ2hopybitukhTTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqTYIf1Y5T70R6dVX1Vq0+ncr5xRgDFFUTrsCsk/8nV0z8RO5hFvPUktwIbm4hyUvgRWXbUDGCIJdUt/lVQZP0qI9afFpZr3ChyQ4B94QueifdtT4+qtamq45ZbmpUUfjmlcYm+82+MhCrixTtWKqH9m1yXKMXKZt14QgqvEeyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2S4+9ai; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740745004; x=1772281004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Imv45Fvq22xNgZhJykuszyMaW/DiQ2hopybitukhTTw=;
  b=F2S4+9aiBLQsTtpvWdNfvq/Rx5eI+WVP+ICccKHX6fJRwc7vFcyqzGCr
   6kzEWib1csPKxZ7pR18FGzE+qo3Ivrvi9LZmghLyiQhxUptuWaW1bDob4
   3nrgB/gttWgQyMNdJ1F0kSddM5yiJinmlApd3O2UoRQ0myo7Hp6Gj4I9/
   NY+qX7htf33f4RtHq9JLvwncLZOOV6IknIsQb3KcI1ra0a6AXBDgIQhqJ
   wiCx8ysROzv/siuW1aVx9Zn6JrPI04PSRcPo8JAecKR2gIGSivGwYAqBu
   3qCQbOy/dARujyJiTDe3K5rAkFqc8B8745Vb52obGNHEnn2LQbeB0Rzwh
   w==;
X-CSE-ConnectionGUID: PjKNm9exRLWJ2+tRC/eZpQ==
X-CSE-MsgGUID: xRSgc5E8QF6n6VLpeLixFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="59209245"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="59209245"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:16:43 -0800
X-CSE-ConnectionGUID: kYvVF8i1R3O7LxR6R+sejg==
X-CSE-MsgGUID: kb9H8yrsTbKd+EIxCKSNeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="121931592"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:16:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnzIC-0000000FwOX-1qG2;
	Fri, 28 Feb 2025 14:16:36 +0200
Date: Fri, 28 Feb 2025 14:16:36 +0200
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
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>
Subject: Re: [PATCH v4] lib/vsprintf: Add support for generic FOURCCs by
 extending %p4cc
Message-ID: <Z8GpJDGeJVHbIy8X@smile.fi.intel.com>
References: <DB7F502D-1477-49C9-A36D-1DEE408ED23C@live.com>
 <Z8B6DwcRbV-8D8GB@smile.fi.intel.com>
 <PN3PR01MB9597916417D398179C55BD98B8CD2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PN3PR01MB9597916417D398179C55BD98B8CD2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 27, 2025 at 05:10:52PM +0000, Aditya Garg wrote:
> > On 27 Feb 2025, at 8:13 PM, andriy.shevchenko@linux.intel.com wrote:
> > On Thu, Feb 27, 2025 at 06:30:48AM +0000, Aditya Garg wrote:

...

> >> +Generic FourCC code
> >> +-------------------
> >> +
> >> +::
> >> +    %p4c[hrbl]    gP00 (0x67503030)
> >> +
> >> +Print a generic FourCC code, as both ASCII characters and its numerical
> >> +value as hexadecimal.
> >> +
> >> +The additional ``h``, ``r``, ``b``, and ``l`` specifiers are used to specify
> >> +host, reversed, big or little endian order data respectively. Host endian
> >> +order means the data is interpreted as a 32-bit integer and the most
> >> +significant byte is printed first; that is, the character code as printed
> >> +matches the byte order stored in memory on big-endian systems, and is reversed
> >> +on little-endian systems.
> > 
> > Btw, this sounds to me that 'h' should be accompanied with 'n', otherwise it's
> > confusing why BE is the host order out of the blue.
> > so, it needs more information that this mimics htonl() / ntohl() for networking.
> > 
> > Does 'r' actually should be 'n'?
> 
> I believe you mean negative endian? Can be done.

No, 'network order' / 'host order'. That's where BE comes from, but you may ask
the original author about this. h/r pair makes little sense to me as it
inconsistent.

> >> +Passed by reference.
> >> +
> >> +Examples for a little-endian machine, given &(u32)0x67503030::
> >> +
> >> +    %p4ch    gP00 (0x67503030)
> >> +    %p4cr    00Pg (0x30305067)
> >> +    %p4cb    00Pg (0x30305067)
> >> +    %p4cl    gP00 (0x67503030)
> >> +
> >> +Examples for a big-endian machine, given &(u32)0x67503030::
> >> +
> >> +    %p4ch    gP00 (0x67503030)
> >> +    %p4cr    00Pg (0x30305067)
> >> +    %p4cb    gP00 (0x67503030)
> >> +    %p4cl    00Pg (0x30305067)
> >> +

...

> >> +    switch (fmt[2]) {
> >> +    case 'h':
> >> +        val = orig;
> >> +        break;
> >> +    case 'r':
> >> +        orig = swab32(orig);
> >> +        val = orig;
> >> +        break;
> >> +    case 'l':
> >> +        orig = (__force u32)cpu_to_le32(orig);
> >> +        val = orig;
> >> +        break;
> >> +    case 'b':
> >> +        orig = (__force u32)cpu_to_be32(orig);
> >> +        val = orig;
> >> +        break;
> >> +    case 'c':
> >> +        /* Pixel formats are printed LSB-first */
> >> +        val = swab32(orig & ~BIT(31));
> >> +        pixel_fmt = true;
> >> +        break;
> >> +    default:
> >> +        return error_string(buf, end, "(%p4?)", spec);
> >> +    }
> > 
> > Actually you can replace all these orig copies by introducing a new boolean, pixel_be.
> > 
> > Will become
> > 
> >    switch (fmt[2]) {
> >    case 'h':
> >        val = orig;
> >        break;
> >    case 'r': // or 'n' ?
> >        val = swab32(orig);
> >        break;
> >    case 'l':
> >        val = (__force u32)cpu_to_le32(orig);
> >        break;
> >    case 'b':
> >        val = (__force u32)cpu_to_be32(orig);
> >        break;
> >    case 'c':
> >        pixel_fmt = true;
> >        pixel_be = orig & BIT(31);
> >        /* Pixel formats are printed LSB-first */
> >        val = swab32(orig & ~BIT(31));
> >        break;
> >    default:
> >        return error_string(buf, end, "(%p4?)", spec);
> >    }
> > 
> > And with this the existence of 'val' now becomes doubtful, we may reuse 'orig',
> > just name it 'val' everywhere, no?
> 
> In case c, val != orig, in rest it is. We can just use pixel_fmt to check
> this condition, but places where we use orig, and not val will need an if
> statement or something similar. Tbh, it's an unecessary complication. You
> might want to see this part of the code:

Fair enough.

> 	if (pixel_fmt) {
> 		*p++ = ' ';
> 		strcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
> 		p += strlen(p);
> 	}
> 
> 	*p++ = ' ';
> 	*p++ = '(';
> 	p = special_hex_number(p, output + sizeof(output) - 2, orig, sizeof(u32));
> 	*p++ = ')';
> 	*p = '\0';
> 
> Here, special_hex_number is common to all cases.

I see, thanks for pointing this out.

-- 
With Best Regards,
Andy Shevchenko




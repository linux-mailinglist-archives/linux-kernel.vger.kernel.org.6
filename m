Return-Path: <linux-kernel+bounces-558330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE40A5E470
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9066B189C87C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C213724BBEF;
	Wed, 12 Mar 2025 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcYuYqVH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51FB1D54E2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807925; cv=none; b=gzm8EaAnumYdUy3hi8AotxtVHEvNpotdpUD6Ni8hINq09ikWqoMHas7DgqHHf1AyoD/tQAv6u6QowQYv7DDoReam0JmNAZjhAJlZvQ8shyKZYLFEX2B0QZgjHF+28fp3ZZXlyJ4TC0QGnNSDuemjI6nY5Z97WwIzE6g0P7jqCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807925; c=relaxed/simple;
	bh=+dCne89JQx2xtyCKFWmsaYgOYiF0MTzY20fbpBlJqyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/+Jtk7Lep+pFVhQykSYqKJZ/dHfyToNtg64ZaMMAyXDpjvRdMQCF9tK04xE4oXU4LHl1fH87FJd670GBLDmGhaK7AgnDl7bl0lP8RPOsdB69oCk7K/M+3TGGzpSj0rG4AgvxGxHu4GKPpp7AjDRW5W2fx2/86t6Wwmcok4gglk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcYuYqVH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741807923; x=1773343923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+dCne89JQx2xtyCKFWmsaYgOYiF0MTzY20fbpBlJqyo=;
  b=KcYuYqVHzOdNvsoK00ewo3Us6938PBc93A++BeV1IXLi5sOAxtBHFJAn
   WIQdOpMeMt0K3NrTqc+b1GNM/IZIt5VWENWUccWquaBLtKe+FmwXBRt1P
   hhjsX8pT2TGbPytZ64XaBGSvJB5PIBRHW8vcTc6gUDuo6ZdVzJ9vU+W/u
   mwjagETdLW5cjcKfHQirX5nDGYTSNjG6vLLrSe8bbv7fSf1PcbO03GSfQ
   Utqg8RE5B37m/roOFEdxC4NSyrZyy3oEOUyVAENJEJDxjyU3xxB1jHPJ3
   V4Fkn61r00VLC1cdUE3BoF2TP+d89WPsiBimG/gatJAhipLNYbHNlVMiu
   w==;
X-CSE-ConnectionGUID: nnET8Qb9SMCaGZvlOXqJsw==
X-CSE-MsgGUID: SMpymiURTMSN5ZnJsDI0Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53535541"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="53535541"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:32:03 -0700
X-CSE-ConnectionGUID: rXbvqQ/1TlqLrlsqiWj8Cw==
X-CSE-MsgGUID: 9DuMib0mTm2OtHnfHUP1Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="124893270"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 12:32:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tsRo6-00000001xtk-1xuJ;
	Wed, 12 Mar 2025 21:31:58 +0200
Date: Wed, 12 Mar 2025 21:31:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, nnac123@linux.ibm.com,
	horms@kernel.org
Subject: Re: [PATCH v2 1/1] lib: Optimise hex_dump_to_buffer()
Message-ID: <Z9HhLr8zD5M1tdGw@smile.fi.intel.com>
References: <20250308093421.3724-1-david.laight.linux@gmail.com>
 <Z86rSd88eSiJxV-M@smile.fi.intel.com>
 <20250312191816.68de7194@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312191816.68de7194@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 12, 2025 at 07:18:16PM +0000, David Laight wrote:
> On Mon, 10 Mar 2025 11:05:13 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, Mar 08, 2025 at 09:34:21AM +0000, David Laight wrote:

...

> > > -extern int hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
> > > -			      int groupsize, char *linebuf, size_t linebuflen,
> > > -			      bool ascii);
> > > +extern size_t hex_dump_to_buffer(const void *buf, size_t len, size_t rowsize,  
> > > +				 size_t groupsize, char *linebuf,
> > > +				 size_t linebuflen, bool ascii);  
> > 
> > int - > size_t in the returned value is incorrect change.
> > This is explained in the comments to the test cases patch series.
> 
> I don't see you mentioning why.
> The return value is 'the number of bytes that would be output if the buffer
> were large enough' - it is never negative.

True...

> Although given 'a large enough buffer' length is trivially calculable
> it would have been safer to return the actual number of bytes added
> (excluding the '\0').

...but the functions keep the snprintf() semantics, which returns an int.
This makes it more-or-less 1:1 snprintf() substitute in cases where it can
be done in general.

> There were no tests for 'len == 0 && linebuflen == 0', with !ascii the
> existing hex_dump_to_buffer() even manages to return -1.
> (and the function than generates the 'test compare data' is also broken.)

Then you can start with fixes of those?

> Note that libc snprintf() has the same return type as fprintf() which can
> be -1, but any code the looks at is probably broken!
> 
> So an unsigned return type it better.

Maybe, but this will deviate from the prototype and use cases.

-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-kernel+bounces-303453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89324960C40
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1353BB255EB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0320D1C2DBB;
	Tue, 27 Aug 2024 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XC1fSUzL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6856E1BFDF3;
	Tue, 27 Aug 2024 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765830; cv=none; b=XIsLOo4c5WV+3tlhrRdj5Bf+/C26h6Ir1PS7Re4vu/nxi8ml6C5nTQB4BK4zk2SiZK8PAOANfDNeprDIyy2bEQZQKTcuDYOi02nwLjz8I0FBvHgIuUxbHiL5TI96uZuayuFHQuBkbLnxYMnwBqc7+snJTjb6BzIXMFphn4Y+wWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765830; c=relaxed/simple;
	bh=F7uwwE8fWUXezGAg782tjWqtQAIrRqH0usOHJInnYUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYiSLsP5/KMSC6h/jTy+PCSi6VHMZajeWpv6DxJNncuYfWdJV/ngO+y8n/HYqkEgiMU9ayQNraQGKH6Z2hVGCHnNHnXi37pgKbGWdjjJdtAM3vuCk55ttGliBjZ9ejP7d+CX+l8Ebfdg0aoYwFCFxR66goEjCKTKl4tUyYsn84s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XC1fSUzL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724765828; x=1756301828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F7uwwE8fWUXezGAg782tjWqtQAIrRqH0usOHJInnYUM=;
  b=XC1fSUzLIeLL4uY69seqfC98xLTodAkR+XIdXGGdK8za+prNpEbJ5BW6
   LF7ntldvU+xmi4Of28bu6/AridNyMqQDPL+0iJ5g/IvCMHT55A2NlKFHR
   i8RKxCKSe3/yH9SLGd7fJHBKFeomq69ARfYns6gNKomV4wZB49nDb9Vhr
   rCiJXSK+IlNRQXyddkGsI4XQyEE1xAjjdX6Hf/SV+KW1qZzQUtntSttDU
   10s5rfMx3Bk3El7iXTc41bqW2idVLVT5jEG/9QeuUL3U/Z+gWywquDCrD
   MLxeqzDP1ytjaujyUl7r6wcttiga0liEK5FP5QvlTuYfBsI+xwWMq4dRV
   g==;
X-CSE-ConnectionGUID: bd6A78AAQA6lonvWkRSv+w==
X-CSE-MsgGUID: 5kl5DMgsQjeSA64xnwgbGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23418976"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23418976"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:37:07 -0700
X-CSE-ConnectionGUID: Bz6r6OChQHqZieZ/aNQnAA==
X-CSE-MsgGUID: RgBshjT6R36pYYBbEpG8mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62916912"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:37:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1siwMs-00000002HBP-1qOb;
	Tue, 27 Aug 2024 16:36:18 +0300
Date: Tue, 27 Aug 2024 16:36:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Ogness <john.ogness@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hexdump: Allow skipping identical lines
Message-ID: <Zs3WRKOgsvhIP8Es@smile.fi.intel.com>
References: <20240826162416.74501-1-miquel.raynal@bootlin.com>
 <20240826162416.74501-3-miquel.raynal@bootlin.com>
 <Zsy86HZ7uew9-Ef6@smile.fi.intel.com>
 <20240827111353.0341c571@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827111353.0341c571@xps-13>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 27, 2024 at 11:13:53AM +0200, Miquel Raynal wrote:
> andriy.shevchenko@linux.intel.com wrote on Mon, 26 Aug 2024 20:35:36
> +0300:
> > On Mon, Aug 26, 2024 at 06:24:16PM +0200, Miquel Raynal wrote:
> > > When dumping long buffers (especially for debug purposes) it may be very
> > > convenient to sometimes avoid spitting all the lines of the buffer if
> > > the lines are identical. Typically on embedded devices, the console
> > > would be wired to a UART running at 115200 bauds, which makes the dumps
> > > very (very) slow. In this case, having a flag to avoid printing
> > > duplicated lines is handy.
> > > 
> > > Example of a made up repetitive output:
> > > 0f 53 63 47 56 55 78 7a aa b7 8c ff ff ff ff ff
> > > ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > ff ff ff ff ff ff ff ff ff ff ff ff 01 2a 39 eb
> > > 
> > > Same but with the flag enabled:
> > > 0f 53 63 47 56 55 78 7a aa b7 8c ff ff ff ff ff
> > > ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > *
> > > ff ff ff ff ff ff ff ff ff ff ff ff 01 2a 39 eb  
> > 
> > The problem here is that without offset we can't see how many lines were
> > skipped.
> 
> Yes, this is intended, I prefer to mimic userspace tools behavior.
> 
> > Two ways to solve (that come to my mind immediately, maybe more and better):
> > 1) make sure that new flag implies or expects (otherwise BUILD_BUG_ON() or so)
> >   the OFFSET to be set;
> 
> It depends what you are looking for. When I print a 2kiB page and want
> to compare the output with some other dump, I will immediately see if
> there are more or less skipped lines in the diff. When I want to just
> grab the UBI header and skip all the ff's following while asking a full
> buffer to be dumped (for kernel development reasons), the amount of
> skipped lines is not of interest to me either. Of course this is my own
> use case, but I guess there are others.
> 
> However this is true it is sometimes also useful to know where we are in
> the dump, but the hexdump helpers already include all the interesting
> bits for that through the 'prefix_type' parameter :
> 
> enum {
> 	DUMP_PREFIX_NONE,
> 	DUMP_PREFIX_ADDRESS,
> 	DUMP_PREFIX_OFFSET
> };
> 
> See https://elixir.bootlin.com/linux/v4.20.17/source/include/linux/printk.h
> 
> I anyway understand the request and will change the example with
> something more common, probably, by using one of the two other
> prefixes.
> 
> > 2) [OR] add number of lines skipped in that * line.
> 
> As mentioned above, this is not the intended output.
> 
> > Personally I prefer the 1) as I think that you tried to follow the existing
> > format of user space tools and there is a chance that there are other tools or
> > scripts that parse the dump to restore the binary contents.
> 
> Exactly. Also, just simply using the diff command over two dumps
> without being polluted by any additions on one side or the other is very
> convenient.

I got it, then provide a good examples in the cover letter / commit message,
documentation, and test cases.

After thinking more about this, if the caller asked for DUMP_PREFIX_NONE,
that's what they get if they add also SKIP flag. So, maybe here is no
problem after all :-)

-- 
With Best Regards,
Andy Shevchenko




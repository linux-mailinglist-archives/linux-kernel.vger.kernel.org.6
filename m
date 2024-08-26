Return-Path: <linux-kernel+bounces-301981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3744895F83B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAD40B21C95
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3642A198851;
	Mon, 26 Aug 2024 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjXHhz8r"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154F5166F13;
	Mon, 26 Aug 2024 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693744; cv=none; b=DbnL5DE7RA4tMTHHGOJIRhTn+RS0J/6LhSl3NihMso43v+nnUZukfevV5kX+I+SapAqDqEhN9VZqtRanHjXG8e45oTSD1Op3yuFXo2qsx4Tz25NDzBviZzBVDCtmq2CA6SWgk8/ZOQa964nqgnOk2YMq/9dKs11gOuw+h9rkWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693744; c=relaxed/simple;
	bh=0sWVcw96T8tSLQcwGgeWLTWjxATb/PQPdf28mrheZsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFqke2afeDcxyAEgZkld+UYUJjKcbrc5+HRhYnOVhWblXIJA28nsuQ+7twoy/PjgIBkA8T2doP7v3KrrJFQTHWfJE1TNztX8GR2fnAqzHgendMlrpS48LNPTXcEKdtBEC5/MNtv6PxP1nmFFFd+lVZcWKP9m5W67hHlGZ7APMqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjXHhz8r; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724693743; x=1756229743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0sWVcw96T8tSLQcwGgeWLTWjxATb/PQPdf28mrheZsE=;
  b=TjXHhz8rUxraygpm9YxyTkswHaPz9LC0OdZkzHEMfAttyHahmxyiy//n
   xuakahtEv4lW9ZLvrw1KHVdkurh0zuvB2r6BerPsrN2GGz0QPMksY9ZCB
   eH4fbHka+L3haVaTZId4mhyoSEDybwiNGx1U6xUN8oPr4qb0Z2NO3fcDh
   QCllJcqFLNBhJ/Vlo2iwwCclbqxs47IvG8mO0cjAyuPf+WxU7XG4fPVku
   3wE2kl3fCNw77ZmmGYl6DUc+zhS5fACQC/puIRaQV/cI7thU8P1VwazCx
   jkekBKFtChzCKVQGSOBRNiKkVvEpFsflEwT9G1aTKIfZtb3rYEtQNB9rE
   A==;
X-CSE-ConnectionGUID: bUoBmjBySR+91cI7s0GTWg==
X-CSE-MsgGUID: hrcPCJ3sQEe0gN/7bYbuig==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33760645"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="33760645"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 10:35:42 -0700
X-CSE-ConnectionGUID: 3ZaPV8csSDq9Lp5rfbTY1Q==
X-CSE-MsgGUID: CFx360prSKeBQzT6tXDZBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="63110120"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 10:35:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sidcu-000000021fS-2HAa;
	Mon, 26 Aug 2024 20:35:36 +0300
Date: Mon, 26 Aug 2024 20:35:36 +0300
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
Message-ID: <Zsy86HZ7uew9-Ef6@smile.fi.intel.com>
References: <20240826162416.74501-1-miquel.raynal@bootlin.com>
 <20240826162416.74501-3-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826162416.74501-3-miquel.raynal@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 26, 2024 at 06:24:16PM +0200, Miquel Raynal wrote:
> When dumping long buffers (especially for debug purposes) it may be very
> convenient to sometimes avoid spitting all the lines of the buffer if
> the lines are identical. Typically on embedded devices, the console
> would be wired to a UART running at 115200 bauds, which makes the dumps
> very (very) slow. In this case, having a flag to avoid printing
> duplicated lines is handy.
> 
> Example of a made up repetitive output:
> 0f 53 63 47 56 55 78 7a aa b7 8c ff ff ff ff ff
> ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff ff ff ff ff ff ff ff ff ff ff 01 2a 39 eb
> 
> Same but with the flag enabled:
> 0f 53 63 47 56 55 78 7a aa b7 8c ff ff ff ff ff
> ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> *
> ff ff ff ff ff ff ff ff ff ff ff ff 01 2a 39 eb

The problem here is that without offset we can't see how many lines were
skipped.

Two ways to solve (that come to my mind immediately, maybe more and better):
1) make sure that new flag implies or expects (otherwise BUILD_BUG_ON() or so)
  the OFFSET to be set;
2) [OR] add number of lines skipped in that * line.

Personally I prefer the 1) as I think that you tried to follow the existing
format of user space tools and there is a chance that there are other tools or
scripts that parse the dump to restore the binary contents.

-- 
With Best Regards,
Andy Shevchenko




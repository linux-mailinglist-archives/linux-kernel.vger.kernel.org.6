Return-Path: <linux-kernel+bounces-301978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ED995F834
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB141F237A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEBD198E6F;
	Mon, 26 Aug 2024 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ONQ1Imkt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB39E198E6C;
	Mon, 26 Aug 2024 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693548; cv=none; b=DCZ6T3KQj46az54jNIucG87GSa3nx2fwAnRZ1t0waU8iDg7C8Bkg0w5EMwgbsa2I5pHhlsV6VBL8MO6AG4bRKzNez3OkKHCTtzWOp3Sb04ngMUCWV5irHVhpjF+uzF61k9EaXkYDZTlvYlvGH77KSiy96k73Jz2mU52i+5b8lcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693548; c=relaxed/simple;
	bh=GKu6PcQakwK1O4e1iKW9EO7fBcMdUG9TXO2Vb1A5eBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PahI0rk43CHMWDmASc4YXjQqaOYA+QgeUGEJeLcww+5x9N/9C+BA3rhd4G6POAHkt4EdxsiADRbC58U9z89D88R87lbyo5HXT+kBpNOCZ5SpaxfejkJZGTlKXc8LnCHNoUXvvcRvRpbg6uccJO14pZy1cC6g9dlYo2R/aadAYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ONQ1Imkt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724693547; x=1756229547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GKu6PcQakwK1O4e1iKW9EO7fBcMdUG9TXO2Vb1A5eBE=;
  b=ONQ1ImktxLDSg4tvTmHBFii90bXCM+Islhbo9YNrI1W9oiQjqG1w7Nsj
   uwnMkCNh0qiZwn8KvY9gltZdE+WbiskgDkDl6+CaXdgOtw5NxcmsWn4EX
   q+WKQ+yFlEEIVWsykt3HiRDByJnylevoNew90XSh4r2ZUrlgS3PB7mUJP
   BWvOAUnXc553j5tXxtcF/Knu1mEpgr5RpVeVYZruqtdEsOSdd9zyz4iAK
   2pWgwizqbtlCRbyfePa6IXQwrD88dnH4IfMhr3VE59jiwSaWov5N8ZphT
   gFCxis77hHxpF3lONvZl4W8I5i83PQFsBunxsYAlhxCpxctmPeriqXWZO
   Q==;
X-CSE-ConnectionGUID: tyCEtCCIQoish7Q4MhaD/A==
X-CSE-MsgGUID: mK5AoCZ+TDiQjNelR8VLZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33796602"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="33796602"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 10:32:26 -0700
X-CSE-ConnectionGUID: GLGqFkZFT3yq5g9gL/Wr4w==
X-CSE-MsgGUID: RVUL4LFHSrCFHfcDGqoI8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="93307910"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 10:32:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sidZk-000000021c9-1Ozc;
	Mon, 26 Aug 2024 20:32:20 +0300
Date: Mon, 26 Aug 2024 20:32:20 +0300
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
Subject: Re: [PATCH 0/2] hexdump: Allow skipping identical lines
Message-ID: <Zsy8JPaiGknBypw9@smile.fi.intel.com>
References: <20240826162416.74501-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826162416.74501-1-miquel.raynal@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 26, 2024 at 06:24:14PM +0200, Miquel Raynal wrote:
> Hello!
> 
> While working on NAND issues, I used print_hex_dump() a lot to compare
> data. But I am mostly working on embedded systems where the kernel
> messages go through a serial console. Sometimes network support is an
> option, sometimes not. Anyway, I often print buffers both in kernel
> space and user space to compare them, and they may be full of 0's or
> 1's, which means lines are repeated a lot in the output and this is slow
> *and* hard to compare.
> 
> I initially hacked into lib/hexdump.c for my own purpose and just
> discarded all the other users, but it felt like this might be a useful
> feature for others and decided to make it a public patch.
> 
> * First patch changes the "ascii" parameter into a "flags" variable now
>   accepting the value: DUMP_FLAG_ASCII.
> * Second patch adds a new flag to skip the identical lines, because this
>   must be an opt-in parameter, I guess.

This is quite a long to look into, can you please add a summary here which
includes (but not limited to) the following:
1) examples before and after (ah, I see you have that in the patch 2,
   but would be still good to have in the cover letter);
2) excerpts of the code for before and after (since the type of the ascii
   parameter had been changed).

Also here is the formal NAK till the series gains the test cases.

-- 
With Best Regards,
Andy Shevchenko




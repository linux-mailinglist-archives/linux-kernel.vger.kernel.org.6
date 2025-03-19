Return-Path: <linux-kernel+bounces-568428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3160A6953F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCAD19C745C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1B71E0E05;
	Wed, 19 Mar 2025 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPne12O9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA6317A30D;
	Wed, 19 Mar 2025 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402652; cv=none; b=EeZWEIhUsHzklPqGotn1kEP7FW6xUJ9JH4/+m1Zmt7a7ukM/wlG2K0dOLkIO5zGxr0KsMLFktFVSzc33kviBQlgnPJHm6wqKPxvYXV5DO8SK1b9go/UcZ2+lcfBGAHGrkRctgoiVZf4P2g8Sxs2leoq15ZvxWsGNfF+i1xrH67s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402652; c=relaxed/simple;
	bh=MgC6KIkhRulGWyzDh9vBNNGSn98JHjLmbQe8mh6lxKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGCRCt1Gad1L5UiCvJRHT5EzOcYznhVCZWSmvZLiyxa9zrH2N+nARWLLHGk2wfP38W1SReuvfRIW2fkonu0NX/EzQJRpPReBOg5B2kAekKZF9rWOxe4RJEK9IqqK7TMQHZZSivmkdQnoy/FsZ7emowzbOoYyaiPhj4+CkOhXalA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPne12O9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742402651; x=1773938651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MgC6KIkhRulGWyzDh9vBNNGSn98JHjLmbQe8mh6lxKA=;
  b=YPne12O9grN4C6BzjJQPiNGa64ackxORc2mk0hfv4GMegEDhD4WVDPvm
   vEF/YSg9h9TcPN/PQ7jeXU9jLMU3SckbT3My9wqkLTj42RfRDuBA3ysqL
   6DVTEBEaIBHoHHRmN/3iTEPGa8aAepRiaRMBtMPrkTd0OrJ+MI29hyySc
   BxFImhvVIO/B3uyDTAYTH/jawrW6Yd0JOgswlkifJQt2BKb9cMV/VX5kx
   GipZoOW+k7VUzJozdbvqdEuYC1AZrQWI77fL9wgLx6iXuYd+dpl26a+em
   4iKoHxpmQfMgF2T45Ot0o2TTsAJK4TVOe+gACAyY1UVYj7o6qYj2s7tus
   g==;
X-CSE-ConnectionGUID: +/s5H6NMQb6w7R1lwCfubw==
X-CSE-MsgGUID: Ujqg0kBdRk290bQU7SnS7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43775421"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43775421"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:44:10 -0700
X-CSE-ConnectionGUID: Znr+WZzhT8GW+DH2DUg5sw==
X-CSE-MsgGUID: +qSQgF6xSfyao05sIZW9yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127518020"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:44:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuwWS-00000003zpN-1bc1;
	Wed, 19 Mar 2025 18:44:04 +0200
Date: Wed, 19 Mar 2025 18:44:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Petr Mladek <pmladek@suse.com>,
	David Laight <david.laight.linux@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Ogness <john.ogness@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] hexdump: Print the prefix after the last line to
 show the dump is over
Message-ID: <Z9r0VK0UWF1-mco9@smile.fi.intel.com>
References: <20250319-perso-hexdump-v3-0-a6ba3a9f3742@bootlin.com>
 <20250319-perso-hexdump-v3-3-a6ba3a9f3742@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-perso-hexdump-v3-3-a6ba3a9f3742@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 19, 2025 at 05:08:12PM +0100, Miquel Raynal wrote:
> When skipping duplicated lines, the end of the log can just be a
> star ("*") which may be confusing (?), so in order to clarify the end of
> the log, tell the user how many lines where skipped and mimic the
> userspace hexdump output, let's add in this case a new line with the
> next offset.
> 
> With the following data:
> 
> 00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 00000010: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 00000020: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 00000030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 00000040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 00000050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 00000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 00000070: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 
> When skipping identical lines we were seeing:
> 
> 00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> *
> 
> And now we will have:
> 
> 00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> *
> 00000080
> 
> However if the output was (first bit of first byte on last line changed):
> 
> 00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 00000010: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 00000020: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 00000030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 00000040: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 00000050: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 00000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 00000070: fe ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>            ^
> 
> When skipping identical lines we would see:
> 
> 00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> *
> 00000070: fe ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 
> And in this case the output would not change with this patch.

Thanks!

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> This change is not related to the two first patches and is just an
> addition that was requested by Andy who felt like it was not clear where
> the dump was ending with the 'SKIP_DUPLICATE' flag when the last line
> was skipped. Honestly this never bothered me, so depending on the
> maintainers wishes, this can either be applied or skipped.

I was also referring to userpsace `hexdump` behaviour. And I find it logical.

-- 
With Best Regards,
Andy Shevchenko




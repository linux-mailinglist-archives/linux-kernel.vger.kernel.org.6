Return-Path: <linux-kernel+bounces-568418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1A7A69519
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1690B16BC54
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800BF1DED58;
	Wed, 19 Mar 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SduuOS+a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308C41DE4FB;
	Wed, 19 Mar 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402256; cv=none; b=jJH/f3jY1p9fWi++L5nTV2CNBhpSyD8KtnQEFsghezXp9/eAZB5O4VLyy3XicxAmfRQMzWnbLoul1pTUIfzxGNtjLQrpYeBrz1IZJOw/LClQIfeJnTpihjvDmUFfgDQGkhstlhQ1LvVQGZVE5w/hDnSyMWdsSwcWnPpkqA4nU78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402256; c=relaxed/simple;
	bh=8G/z31/q5kWS5bgcAjtvlmbdptmnjmHrb9v6vjvIYsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mp/nPT3mA27Mfei+GJO2/FGZMaWK6udipDPd/3LTtwskPdhCWbJReuBKx36mwIJjDE+TYdmwGCl6cId4PBOQDAcZz6C+4rl9DjLUtN5nkNyy/Aj+LXKxIaMJ7D8P5zPPE38m6AEuIOf4LiTvXQY3YDbB6r8QBng4KRbChYzKy/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SduuOS+a; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742402254; x=1773938254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8G/z31/q5kWS5bgcAjtvlmbdptmnjmHrb9v6vjvIYsY=;
  b=SduuOS+a6bpACQfkXGcMOxjIVVRH9xY72c16dpgYwSKGrqDnofyykWSD
   eyHLqPA/P2SxOlPjmLUdqpXiJZm6aL7rFp25jWQ+xj+op9qxbdXDEaSiH
   /bqoZUtqgHt97PSGDApqCxkNrzG03jh+DqDsZF85ueb/8KyDLBLCE0pjH
   3ixt7tdLQNrt/p2wFKLIJmJQN8QNx9YpMpIm3zsRD17XVm8InNt+l9e7l
   5rf3vV+l1tg8N9dGMoMAL4L8ksyddkG4LN2vapwyRGU91lzhnvmDYYlOW
   S+pI4xgAqOvRmF7SN6Z49HYH7bi7yb5tczYXTh+7fHPoc08QKjTV9A8Xl
   w==;
X-CSE-ConnectionGUID: Hv6x3USzRcW+W2Ot35U3HQ==
X-CSE-MsgGUID: LWpXkw6VRQGAYz3yHOEE9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43788989"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43788989"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:37:33 -0700
X-CSE-ConnectionGUID: jgwfxtrJR6Oigg/TsPy8Gg==
X-CSE-MsgGUID: YeW6mT/STKOKwNHXkanPMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127388829"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:37:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuwQ3-00000003zk5-0hhl;
	Wed, 19 Mar 2025 18:37:27 +0200
Date: Wed, 19 Mar 2025 18:37:26 +0200
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
Subject: Re: [PATCH v3 1/3] hexdump: Simplify print_hex_dump()
Message-ID: <Z9ryxqRd0u4cZJoL@smile.fi.intel.com>
References: <20250319-perso-hexdump-v3-0-a6ba3a9f3742@bootlin.com>
 <20250319-perso-hexdump-v3-1-a6ba3a9f3742@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-perso-hexdump-v3-1-a6ba3a9f3742@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 19, 2025 at 05:08:10PM +0100, Miquel Raynal wrote:
> print_hex_dump() already has numerous parameters, and could be extended
> with a new one. Adding new parameters is super painful due to the number
> of users, and it makes the function calls even longer.
> 
> Create a print_hex() to replace print_hex_dump(), with 'prefix_type' and
> 'ascii' being merged into a 'dump_flags' parameter. This way extending
> the list of dump flags will be much easier.
> 
> For convenience, a print_hex_dump macro is created to fallback on the

print_hex_dump()

> print_hex() implementation. A tree-wide change to remove its use could
> be done in the future.
> 
> No functional change intended.

...

>  For printing small buffers (up to 64 bytes long) as a hex string with a
>  certain separator. For larger buffers consider using
> -:c:func:`print_hex_dump`.
> +:c:func:`print_hex`.

Why replacement? I would rather expect

:c:func:`print_hex_dump` or :c:func:`print_hex` depending on your needs.

...

> +/*
> + * Dump flags for print_hex().
> + * DUMP_PREFIX_{NONE,ADDRESS,OFFSET} are mutually exclusive.

This is confusing, taking into account two definitions to 0.
> + */
>  enum {
> +	DUMP_HEX_DATA = 0,
> +	DUMP_ASCII = BIT(0),
> +	DUMP_PREFIX_NONE = 0, /* Legacy definition for print_hex_dump() */
> +	DUMP_PREFIX_ADDRESS = BIT(1),
> +	DUMP_PREFIX_OFFSET = BIT(2),
>  };

Can we rather add a new enum and leave this untouched?

Also you can use bit mask and two bits for the value:

	DUMP_PREFIX_MASK = GENMASK(1, 0)

and no need to have the above comment about exclusiveness and no need to change
the values.

...

> +extern void print_hex(const char *level, const char *prefix_str,
> +		      int rowsize, int groupsize,
> +		      const void *buf, size_t len,
> +		      unsigned int dump_flags);

> +static inline void print_hex(const char *level, const char *prefix_str,
> +			     int rowsize, int groupsize,
> +			     const void *buf, size_t len,
> +			     unsigned int dump_flags)

Hmm... Wouldn't you want to have a enum as a last parameter?

-- 
With Best Regards,
Andy Shevchenko




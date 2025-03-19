Return-Path: <linux-kernel+bounces-568424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6761FA69535
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138EC3BF53F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38F91E0E05;
	Wed, 19 Mar 2025 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqv04CTN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9421DF738;
	Wed, 19 Mar 2025 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402516; cv=none; b=dcMHy6eMbLwjKVbAaG4uXRspevsJaEO01HJkVAsIKp1PGJ9KFLg3KRHZ7Rk+aAHac+K694pAqBvy43UrqdBmy8f7EjaY2n6Ibp+uegs4J+q6t9HlnaxU5S1ZUGNhPNhNYXsxwltBg95UFET1CIi4LFy6R7gF+DGw4l4kCXQyZas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402516; c=relaxed/simple;
	bh=pYFdC7QHrsjHkhlfpl90vesiJ+GuncsBzi61ofPfKt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WG14HMfQcENeX1J6CqDQ9luiWcko96ZAs4iNtLr/a6hQXWOwcUJlqnqPt+5kstSdeuWjXZUovcuvfkNZ2rCty4KRnZD9AcOYrs0PAWS4TvNqVaQv+lKqHOlVXFjvXQSrqKVPhAaJaaIqHjqMlBnWevSYWnxf2NeSnjvo12v1M0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqv04CTN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742402515; x=1773938515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pYFdC7QHrsjHkhlfpl90vesiJ+GuncsBzi61ofPfKt4=;
  b=kqv04CTNTFELfQCMeq5P9Bm8pCVMrSjfErFtWid+N9upwMdXubTi7USA
   rTxP8AwanAVjonxiZ1NtqiZNkR31Asmk4Bab4+NL1lWf6/7A4QQStItef
   4xYxhiBcv4jNyZviYs9Gh2Vg8mItXnknG9tkk4XjMfaz7ti7+PkFf3aHd
   296jVtEp/WgjIKjwsOZ823Y+2dDoFaebAxunE6wptCbZDbXriEoj7UXn1
   K1fV837e9K1LLKCI7XSYOGelZ1mH7SeezjC2+e797lD8k3/mneFxLXI/D
   MDxoMU5UXV0Bklh6v7RTcsXp6tTxnNOvu3pzYDCy/wzEio9Ki/EfKKyXL
   w==;
X-CSE-ConnectionGUID: zZ42Br/0QqugsDD+fau9Pw==
X-CSE-MsgGUID: VMSeIsPTReSxnk6FrFcKEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="54984937"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="54984937"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:41:54 -0700
X-CSE-ConnectionGUID: Hv56SFCQQXmgCqgitfioZA==
X-CSE-MsgGUID: H/NE9r2RT368+Twm+i9TLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122718071"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:41:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuwUF-00000003znV-3Xlr;
	Wed, 19 Mar 2025 18:41:47 +0200
Date: Wed, 19 Mar 2025 18:41:47 +0200
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
Subject: Re: [PATCH v3 2/3] hexdump: Allow skipping identical lines
Message-ID: <Z9rzy9WQcy_MgH9v@smile.fi.intel.com>
References: <20250319-perso-hexdump-v3-0-a6ba3a9f3742@bootlin.com>
 <20250319-perso-hexdump-v3-2-a6ba3a9f3742@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-perso-hexdump-v3-2-a6ba3a9f3742@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 19, 2025 at 05:08:11PM +0100, Miquel Raynal wrote:
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

...

>  For printing small buffers (up to 64 bytes long) as a hex string with a
>  certain separator. For larger buffers consider using
> -:c:func:`print_hex`.

Instead of fixing this (see also comment in previous patch), just add the text
like

:c:func:`print_hex` is  especially useful since duplicated lines can be skipped
automatically to reduce the overhead with the ``DUMP_SKIP_IDENTICAL_LINES`` flag.

> +:c:func:`print_hex`, especially since duplicated lines can be
> +skipped automatically to reduce the overhead with the
> +``DUMP_SKIP_IDENTICAL_LINES`` flag.

Also, can  we also put a sub name spaces to the flags, like for HEX/ASCII

DUMP_DATA_HEX
DUMP_DATA_ASCII

This SKIP  will start a new sub name space.

...

>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/minmax.h>

> +#include <linux/string.h>
>  #include <linux/export.h>

It's more natural to put it here, with given context it makes more order
(speaking of alphabetical one).

-- 
With Best Regards,
Andy Shevchenko




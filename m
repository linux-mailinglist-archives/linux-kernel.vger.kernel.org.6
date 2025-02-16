Return-Path: <linux-kernel+bounces-516799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8C2A37789
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 21:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122701890C1C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F6C1A0714;
	Sun, 16 Feb 2025 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuoauS4d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47F5148318
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739738876; cv=none; b=fzx8aP7FYPv/DLFx1MRQvgUqatlAiZDyseYWXCmQ8xVNfTigycfg47xiRneFLCg5do6yzaS2LyR5f8BBk/5n3Im7QQNo2M00ZZ6W3FJqrtw1bUPeEfS6Eo84lTrjW3ZDvBLXgm/3n57a30+sE5pilZSf55A2ci+0NLevJ2g7jtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739738876; c=relaxed/simple;
	bh=+oLoW/FaZO+GU6fiuszEaH+9DEPI3jmeLRBCH7iPm6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjHtfDo8soJp14Nt8s8kQMRQaS7UxNj1vakNsqiMBptJhmh1ExpDHerWod04KzV+HirwKF+jgQYmSvJEHCYkUuz5KDRx0isixPwz2Fa551g4opyQTjtvFOgGhxwKAw/vs1ldWhUXUV7HkSdBmTn0lkBeRqcYQtVSZp9CM0MsEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuoauS4d; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739738875; x=1771274875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+oLoW/FaZO+GU6fiuszEaH+9DEPI3jmeLRBCH7iPm6A=;
  b=iuoauS4dFrPV+FGP/0Htt8WWObY2MqwP5eOnfteEUmKXabAFOrjwgrnW
   0cGvM14XV9abF3oxDWpkR2AYPNRzWTchpcFdIeulJNItEMQ+nO3h3YjXP
   +YTdRBjR1PVmYAWJNxi5vEfgpbVClspt0nmsRfVrFSY/3uv8F7IqQwyQe
   BJOdWh0/Or6zND8YrYsQAur09keFqguzWF1WSTD8F2Pp81ViLpTPQbFIR
   vrDIGtwCPOyXmsZJD+75KS/YUBjkpSb+qFyQ4nFeVUxG94+aReH+6iWc3
   JQiEcMQlW/UyyMD5xlpUOD/8iKhOxTVAJA33BweOFlYW/m44wVMSRTstM
   w==;
X-CSE-ConnectionGUID: 15vmxKwBQHqoaw6gMZXaOw==
X-CSE-MsgGUID: ZYV2ydvwRtKFiwQeqOI+Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="57829477"
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="57829477"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 12:47:54 -0800
X-CSE-ConnectionGUID: j7/kSmOaTCSCz4/rdDvLaA==
X-CSE-MsgGUID: sWdTBn14QCa1uAI52MPw2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113804888"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 12:47:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tjlYL-0000000CDD3-3d5s;
	Sun, 16 Feb 2025 22:47:49 +0200
Date: Sun, 16 Feb 2025 22:47:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH next 1/1] lib: Optimise hex_dump_to_buffer()
Message-ID: <Z7JO9eutvu3KBEbc@smile.fi.intel.com>
References: <20250216201901.161781-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216201901.161781-1-david.laight.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 16, 2025 at 08:19:01PM +0000, David Laight wrote:
> Fastpath the normal case of single byte output that fits in the buffer.
> Output byte groups (byteswapped on little-endian) without calling snprintf().
> Remove the restriction that rowsize must be 16 or 32.
> Remove the restriction that groupsize must be 8 or less.
> If groupsize isn't a power of 2 or doesn't divide into both len and
>   rowsize it is set to 1 (otherwise byteswapping is hard).
> Change the types of the rowsize and groupsize parameters to be unsigned types.

> Tested in a userspace harness, code size (x86-64) halved to 723 bytes.

Does it imply running the respective test cases we have?
Do you need to add more test cases? I believe so.
Without test cases added it's a no go.

> +extern size_t hex_dump_to_buffer(const void *buf, size_t len, size_t rowsize,
> +			      size_t groupsize, char *linebuf,
> +			      size_t linebuflen, bool ascii);

Looking at another thread where upper layer function wants to have unsigned
long flags instead of bool ascii, I would also do the new API, that takes flags
and leave the old one as a simple wrapper with all restrictions being applied.

And again, provide it together with a bunch of test cases.

...

> +			dst[0] = hex_asc_hi(ch);
> +			dst[1] = hex_asc_lo(ch);

We have hex_pack_byte() or so

...

> +			ch = ptr[j ^ byteswap];
> +			dst[0] = hex_asc_hi(ch);
> +			dst[1] = hex_asc_lo(ch);
> +			dst += 2;

Ditto.

...

> -		linebuf[lx++] = (isascii(ch) && isprint(ch)) ? ch : '.';
> +		*dst++ = ch >= ' ' && ch < 0x7f ? ch : '.';

Please also add a test case for this to make sure it has no changes.

-- 
With Best Regards,
Andy Shevchenko




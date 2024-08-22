Return-Path: <linux-kernel+bounces-297183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E242B95B439
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3912839B5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740451C945E;
	Thu, 22 Aug 2024 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcLRxDqB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386581C93D3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327406; cv=none; b=Ak1Qiw3jF2EeKgZf6IVjIrOlFok97lfnAhXfPlYdHl96WC5AiHKdsRV116PkC9P1DOLY2j3PwJ9qSuEuskV1FsmmwP2lV71qFMM0npLtwLXS08Y5VgN9+UMCNPcRK1QUOLf2AK3XPbk6jbfHkGRhTbF0/t5/dxSHFsptc8pNn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327406; c=relaxed/simple;
	bh=ZjfICjdygkafhwqXwqFKmZoelO4IcMB/uKcSschNJvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMyKFd3J0WXt3JOT2HtNaoa97IWOymunfvG3uDyzojTolOBKRucm/UlagBX5J6300O5uTfRblyzIW/bFHX4Th9KIzuFxKKHAZjZphA3T6UaPQ7/0UpqquSJZlpn5U9fgEBUhhd/e2PbiPY6CB3TMP8R/YOWlk/8J+q7BIw7NThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcLRxDqB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724327405; x=1755863405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZjfICjdygkafhwqXwqFKmZoelO4IcMB/uKcSschNJvk=;
  b=AcLRxDqB46A9CjSVRcUK/ELi2Z8pBq3P0OHpPk3u/HXpsQ7uwrdB/9dV
   oBY0NlR9eJBEQSBTYoGCy11kk7XfQF4zJYhyhjxwj0GHzpTr7Ktig+zfY
   m3rQwMbt2tbCwcySGKJj5OndjKQTdG5OnzU/Q0lIRpURAFvSt9u4GK2pw
   ZYEVVTvsmlAxiu42wAWF9hpkdkYSwqrfgmjTCtGHOzppU9Pfc8jAayWOr
   qRb1xbIDO84t0r2B4wvdknv2jWO4Iy72L+j2nWc3Lj1iHAyswBpcJwW/4
   jX5lw/gIyvm8yeqhF9K97hFclHorxCKKCNeorDhPtswu5D7ZEaSQ5iIv9
   Q==;
X-CSE-ConnectionGUID: 8XIah60rQY+F6XpPB89/6g==
X-CSE-MsgGUID: JQgCT81NQECaMSRcS80upg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="40198218"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="40198218"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 04:50:04 -0700
X-CSE-ConnectionGUID: Uix08maDS6uaLmyLNfZvIA==
X-CSE-MsgGUID: aJnraHPxT+uXt+PJPirdkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="84587182"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 04:50:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sh6KG-00000000RDB-42SQ;
	Thu, 22 Aug 2024 14:50:00 +0300
Date: Thu, 22 Aug 2024 14:50:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/5] driver core: Sort headers
Message-ID: <Zscl6G82YY1c-Lb3@smile.fi.intel.com>
References: <20240821154839.604259-1-andriy.shevchenko@linux.intel.com>
 <20240821154839.604259-2-andriy.shevchenko@linux.intel.com>
 <36bc2da3-80c2-467d-bcdd-0797809ace72@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36bc2da3-80c2-467d-bcdd-0797809ace72@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 22, 2024 at 11:30:07AM +0800, quic_zijuhu wrote:
> On 8/21/2024 11:48 PM, Andy Shevchenko wrote:
> > Sort the headers in alphabetic order in order to ease
> > the maintenance for this part.

...

> i don't think it is good idea to sort headers by alphabetic order.

I strongly disagree on this on several points:

- the header dependencies has to be resolved on each header by applying IWYU
  (Include What You Use) principle:

    in this case we don't care what is needed for each header in question

- the end developer shouldn't care about header dependencies changes as
  the project is evolving:

    it's way out of human being capacity to follow _all_ the changes in the Linux
    kernel headers

- it's much easier to maintain the inclusion block when it's sorted (to avoid
  dups, or to see in a fast manner what's already included):

    we are writing code for humans, and not for the machines (leave the
    optimisation task to the compiler in many cases)

- overall it makes the development process much easier as a whole:

    I do not believe there is a single person in the world who may tell you
    the correct order of inclusion to any, even simple, Linux kernel driver

> why ?
> 
> 1) header's dependency is not related to its file (name|path), their
> dependency are related to # includes order.

That's not true. More precisely we are working hard to make it not true (and
it's not a Plan 9 OS where as far as I know the idea was that developer knows
the exact order).

> 2) it maybe be easy to cause build error.

Yes, and again we are trying to avoid this by enforcing IWYU principle.

> 3) header's path or name maybe be related to subsystem, it is not good
> to sort one subsystem's headers before the other.

There is a grouping approach which makes this easier to get. See IIO subsystem
as a prime example for IWYU implementation in the Linux kernel.

> For header's order, my points is that:
> 
> 1) sort by their dependency.

See above. No way, it's completely impractical.

>    #include <b_header.h>
>    #include <a_header.h>
>    if
>    a_header.h:
>    #include <b_header.h>
> 
> 2) all #include <> block before all #include "" block.
> 
> 3) sort headers related to source file at the last.
> 
>    prefix_xyz.c:
> 
>    #include <>
>    .....
>    #include <prefix_xyz.h>   // it is the last if it is exposed.
> 
>    #include "internal_header.h"
>    ....
> 
> 4)
> sort relevant header together as far as possible, for example, they
> belong to the same subsystem.

-- 
With Best Regards,
Andy Shevchenko




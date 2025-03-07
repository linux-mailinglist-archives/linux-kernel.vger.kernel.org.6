Return-Path: <linux-kernel+bounces-551793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6BCA57102
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96217189A6B1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFCA23FC54;
	Fri,  7 Mar 2025 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqs4qHkr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3141C17B500
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374068; cv=none; b=bEtDw9VLXYdYiT6x8YPkM44P9YqnEJkwyRvM5oP0bAA8Yc5nLCnPrNDRCIMKQGWFI4W2Z8U0Wm1KbbzEdrxTWxETJrSFvghctMfLZ5wkb0Q4zJPF14WlQj0YS4jC3VEq9xJi0bLZcmiaqJf5qwZseU3OW3IKpfsjsFwsV0A6mgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374068; c=relaxed/simple;
	bh=rFoUxa2PsbbG5AGKVNYCXSIQhP9ClmJMnEp9PjdsSaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHW9qJd5w83/SzRTHVQdtZbvrEMPme6P9KuFwibe/RskRt2PCk5+F1E/AGHR/qOmEASgPNVeE08M18y06e/k9aTd86UOxOg/x9IROeOcL9WG23h4pKeY6+uRWJgVytshZkMbmvay9MZ+vHi21xBwU5t0Ta/Ihr2LlmgN8eqBsDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqs4qHkr; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741374067; x=1772910067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rFoUxa2PsbbG5AGKVNYCXSIQhP9ClmJMnEp9PjdsSaE=;
  b=bqs4qHkrppNJhmLPoCT+45TtrM3la8PlAMFEPqVSJQFINyQ1OLURIqF+
   V70VaaOWleyK/4bFD+wVJ0l35OSjc2c8gLdIytnBNXwhUMz2ZJCrNrWCo
   OqZwZRMfDrNU5h3TekNcWfTqB70WHRRPLOm8+SENROAIQMMGEuLdVIbcz
   6dxElLPH16+0C4WfG5zLB+4crQOQDr8D3DrdIikRUkcXr1vcHMSDqBS40
   wgV0cbg9tImqfQtn/2s1twryLu5OKm6d5GlL/CSVihpK1PR2kzpFEcnhl
   PkQ9/+zLGzGgLgtZx9oS1XTVwrZQfDlJulsMAp+2yNDG5LQbkTZcJnwed
   A==;
X-CSE-ConnectionGUID: KgLPx9z6SC6JuHytCDTdtw==
X-CSE-MsgGUID: OGJyvCCxS2WdD1bj6ZgVwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="30012394"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="30012394"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 11:01:06 -0800
X-CSE-ConnectionGUID: GFeiGgMfRW6w/0nLAjrQow==
X-CSE-MsgGUID: HRP2dsjbQoqzzP/Htprsnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119224220"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 11:01:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqcwR-00000000UnL-0EZy;
	Fri, 07 Mar 2025 21:01:03 +0200
Date: Fri, 7 Mar 2025 21:01:02 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v1 6/7] auxdisplay: hd44780: Call charlcd_alloc() from
 hd44780_common_alloc()
Message-ID: <Z8tCbjJk24ryV0DJ@smile.fi.intel.com>
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
 <20250224173010.219024-7-andriy.shevchenko@linux.intel.com>
 <CAMuHMdXP1=7YJzYp=_WJsqx2mtBYcwAjpOGK2_9SH+r4w6v2Ug@mail.gmail.com>
 <Z8soDV0U2LG2KX9J@smile.fi.intel.com>
 <CAMuHMdV1+ftjpEcg4xYjBLH1BRJHkZcYB5W+p8WUWWLXT3DnUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV1+ftjpEcg4xYjBLH1BRJHkZcYB5W+p8WUWWLXT3DnUQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 07, 2025 at 07:19:57PM +0100, Geert Uytterhoeven wrote:
> On Fri, 7 Mar 2025 at 18:08, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Mar 07, 2025 at 10:14:48AM +0100, Geert Uytterhoeven wrote:
> > > On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > While I like the general idea, there are two things in the API I do
> > > not like:
> > >   1. The function is called "hd44780_common_alloc()", but returns
> > >      a pointer to a different struct type than the name suggests,
> > >   2. The real "struct hd44780_common" must be obtained by the caller
> > >      from charlcd.drvdata, which is of type "void *", i.e. unsafe.
> > >
> > > What about changing it to e.g.?
> > >
> > >     struct hd44780_common *hd44780_common_alloc(struct charlcd **lcd)
> > >
> > > so you can return pointers to both structs?
> >
> > I don't like this prototype as it seems and feels confusing. Also note,
> > the APIs are using struct charlcd while being in the hd44780 namespace.
> > perhaps better to rename the function to hd44780_common_and_lcd_alloc()?
> 
> That is one option.
> 
> Another option would be to add a "charlcd *lcd" member to
> struct hd44780_common.
> 
> That would allow to fix the other odd part in the API:
> 
>     -void hd44780_common_free(struct charlcd *lcd)
>     +void hd44780_common_free(struct hd4480_common *hd)

This I like better. In a separate patch I think?

-- 
With Best Regards,
Andy Shevchenko




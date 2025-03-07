Return-Path: <linux-kernel+bounces-551620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9A1A56EBF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD761784A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0FF23F40E;
	Fri,  7 Mar 2025 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UofD/Yor"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7923F296
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367330; cv=none; b=f4BdRGPFebgfvtpWNZITa3+9mkCy1WcL/FQ3n8kAKsF1yj5++rJf7snTcGI1Wi888AZu78uSVFbzLX+yZne9RcCH5iqLqbE7FRqL6Nqw8uZk8+bDYXZaHYRbnV905TbM3BG36De3nVPkrhcS3YTz6H6aZYPwqRq8HhLec8EzSkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367330; c=relaxed/simple;
	bh=SgC1G2rgGhFPge6rJs+RnqahXw9tJ3WgcDvbjDF2Jlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxSEQIvZOST38fN+icu8YvJ6GeLRXCZsTbpiKOFc+VewYKzfs2AEll9qD2YefRETJz1WnHUtJbI1KIJKVXjMFOZWS8Msy3cnzkmW9W+kYxqXOKgUKKY7weh8+IUkw+G64jya32xPqef9sGcTmz1sGRaBay140HtyP3GD0IhX7MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UofD/Yor; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741367330; x=1772903330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SgC1G2rgGhFPge6rJs+RnqahXw9tJ3WgcDvbjDF2Jlw=;
  b=UofD/YoruiC50M10vFXd39aZLBLSn9QMvgWzANLz9JRFyiua6yDSyLYw
   uJ9x8s1jxpTbMh/IUa/6x2of/SumdmGVwv79wjtVSD6YNSp/RhlEsTbwF
   2cvk3jpskDbxD6Rqgvbaoqx0LyteoNeYd/CiGNIoOIPO3XYEdd3AJm3b6
   vsxQtocoPfzMdsf/Upi+Vzql1G5DbDH+bLKndWuNINyDecH7lMNeCak75
   c0px460r5K1SFqDJh2ti49nvijUjCXJA+k5v8RO3k5dFNp6ocQsQfTbBT
   0IbkldKLz2WqGs8dtQqw2+/pQd9iwqca2sABKboHizZ7lBoncYLqdDmyi
   A==;
X-CSE-ConnectionGUID: CEs4xFnTTz69gPdaOOESKQ==
X-CSE-MsgGUID: gzZ1waemRC+eTQAlc6LLgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46202768"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="46202768"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:08:35 -0800
X-CSE-ConnectionGUID: IeKRue+KQ3CCF2ZY6U8kRQ==
X-CSE-MsgGUID: kNaOZSoKQwybA4GABZblOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="123967263"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 09:08:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqbBV-00000000T0N-1sCo;
	Fri, 07 Mar 2025 19:08:29 +0200
Date: Fri, 7 Mar 2025 19:08:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v1 6/7] auxdisplay: hd44780: Call charlcd_alloc() from
 hd44780_common_alloc()
Message-ID: <Z8soDV0U2LG2KX9J@smile.fi.intel.com>
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
 <20250224173010.219024-7-andriy.shevchenko@linux.intel.com>
 <CAMuHMdXP1=7YJzYp=_WJsqx2mtBYcwAjpOGK2_9SH+r4w6v2Ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXP1=7YJzYp=_WJsqx2mtBYcwAjpOGK2_9SH+r4w6v2Ug@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 07, 2025 at 10:14:48AM +0100, Geert Uytterhoeven wrote:
> On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > HD44780 APIs are operate on struct charlcd object. Moreover, the current users
> 
> s/are/all/
> s/object/objects/
> 
> > always call charlcd_alloc() and hd44780_common_alloc(). Make the latter call
> > the former, so eliminate the additional allocation, make it consistent with
> 
> either s/make/making/, or s/make/to make/
> 
> > the rest of API and avoid duplication.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> As the code looks correct to me:
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks I have corrected all grammar issues in the commit messages except one in
the first patch which I do not understand.

...

> While I like the general idea, there are two things in the API I do
> not like:
>   1. The function is called "hd44780_common_alloc()", but returns
>      a pointer to a different struct type than the name suggests,
>   2. The real "struct hd44780_common" must be obtained by the caller
>      from charlcd.drvdata, which is of type "void *", i.e. unsafe.
> 
> What about changing it to e.g.?
> 
>     struct hd44780_common *hd44780_common_alloc(struct charlcd **lcd)
> 
> so you can return pointers to both structs?

I don't like this prototype as it seems and feels confusing. Also note,
the APIs are using struct charlcd while being in the hd44780 namespace.
perhaps better to rename the function to hd44780_common_and_lcd_alloc()?

-- 
With Best Regards,
Andy Shevchenko




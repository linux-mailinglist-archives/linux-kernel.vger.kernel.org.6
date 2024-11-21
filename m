Return-Path: <linux-kernel+bounces-417065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342A49D4E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E2EB25CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AB41D89FE;
	Thu, 21 Nov 2024 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QnHV29lO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14621CD1EE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732198589; cv=none; b=YJ3fwKHM8fr/ZVs0yJAL15pwwgGoctnix3bod1nTd8qjr085zqnM5aSjUE55FkGLekOoMGENdLGUve0DUv/ZNjvr4PPBXNGCMrw4jf/83R4qs/Y8gNSNOFb+CFph+xGmdW2hS1SfmUWTIXsAfYMH6hJalGvDeavjxF8Au+G9/hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732198589; c=relaxed/simple;
	bh=Zf0ckhvMDzyegzJkvpWfNHi1jR+3a6yBisD5pHDxhoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpoEhcqKr0nNbcRM7fqfL+BJi28EpTJtK1xPR/JeYA4shIH1dmtcJYgVvBLykZoCmum4pmr614omJ3/PVedyVvFwiXbhm7JUfhgrCqSL12AATT6hnMUXlagoLQh6yfBCSC4asAd2g3qiQqkvSI7tgeuZcCxnKQ9K71GoSJ5SKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QnHV29lO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732198588; x=1763734588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zf0ckhvMDzyegzJkvpWfNHi1jR+3a6yBisD5pHDxhoQ=;
  b=QnHV29lOo2DwE5KS80c0zPC2AQ3FJeQ6q0tY/yp2rlsqzQoZWC8KnTFt
   v1xEpthRemYr6DDak0J1ykPCj3pUGjpEu+2HgAbdTfnvoly3SptleNTUE
   q4liReKNCf7dUuI6XZKzWHW3411ei7D+lndtayxDb9472COE6T7heD/J3
   P4oYSfafk7Dwz5/qbPJGUNRVilJi8c/mToDv1pa8SydiVMtMkzEegoDKi
   RnFCsz/dT9j4ASoFW7hCELKHctRQn6uh0b8h5Ur7T6XCEPl9ZPvGDi+PC
   fcAttVUlM4zuwHdb06rWYksSezvAtCEPIzOkhc59BmkDMY2o6MMMot8Vu
   Q==;
X-CSE-ConnectionGUID: UtBPxUhaT52i77pBI8ZURA==
X-CSE-MsgGUID: 8mYZnK+lQS+BscMMQDdncA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="43707502"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="43707502"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 06:16:27 -0800
X-CSE-ConnectionGUID: RG/0PXksS8iaVe+KoV/OYQ==
X-CSE-MsgGUID: GULi1l89RdmpX9kQbRWt+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="89867856"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 06:16:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tE7yq-0000000H5L8-0pAz;
	Thu, 21 Nov 2024 16:16:24 +0200
Date: Thu, 21 Nov 2024 16:16:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marco Elver <elver@google.com>
Cc: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v1 1/1] kcsan: debugfs: Use krealloc_array() to replace
 krealloc()
Message-ID: <Zz9AtzWWXW_mgjR6@smile.fi.intel.com>
References: <20241121135834.103015-1-andriy.shevchenko@linux.intel.com>
 <CANpmjNNzFykVmjM+P_1JWc=39cf7LPuYsp0ds0_HQBCzR+xOvQ@mail.gmail.com>
 <CANpmjNO8CRXPxBDFVa5XLYpPuU8Zof=7uvUam9ZFVPP9j8+TEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNO8CRXPxBDFVa5XLYpPuU8Zof=7uvUam9ZFVPP9j8+TEQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 21, 2024 at 03:11:41PM +0100, Marco Elver wrote:
> On Thu, 21 Nov 2024 at 15:04, Marco Elver <elver@google.com> wrote:
> > On Thu, 21 Nov 2024 at 14:58, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Use krealloc_array() to replace krealloc() with multiplication.
> > > krealloc_array() has multiply overflow check, which will be safer.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Reviewed-by: Marco Elver <elver@google.com>
> 
> Unreview.
> 
> > Do you have a tree to take this through? Otherwise I'll take it.
> 
> Whoops. We got rid of that krealloc() in 59458fa4ddb4 ("kcsan: Turn
> report_filterlist_lock into a raw_spinlock"). And the replacement
> kmalloc() is already a kmalloc_array(). I suppose this patch is
> therefore obsolete.

Ah, I made this on top of v6.12 + something most likely unrelated.

-- 
With Best Regards,
Andy Shevchenko




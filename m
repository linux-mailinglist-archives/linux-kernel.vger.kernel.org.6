Return-Path: <linux-kernel+bounces-417056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA159D4E5C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D913EB23B09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100311D9587;
	Thu, 21 Nov 2024 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcmDtIa4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013191D0B8B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732198333; cv=none; b=BLf85mBArn+1c/PyOVTnBAtWmjlJnHBc+TehO/N5d5NKdQxkkuK+T4oFfqEB3hIiWJ46/GweO9pSO2nZ/chCSlPmGb1xrc880ul4d5korUX6yHUQYdykxDVcNfsWXCesPIRNsSkPxsHeetkuqxJIjSDQ9ZL18/2Gl2QiNfXZyQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732198333; c=relaxed/simple;
	bh=JgHeIYXjzz4ilaITYDtLadzcLOhLqsptz8uzjN1y7fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubmyb2mrFySJwVy22vHaBx8jv6WXk5hunHHhNAX/Q4rOaa0y8I/VzXGsg7gL0af/cMxMD+DlHO4YWugiBnwu233guqxme3Js7JWzXPUE9VBL7HKv71csSk8hLzLhPArtKvwDlIFHz/CKYMWXogJ7+7eLToMWs0m9fAHqJtE7aKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcmDtIa4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732198333; x=1763734333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JgHeIYXjzz4ilaITYDtLadzcLOhLqsptz8uzjN1y7fM=;
  b=BcmDtIa4eVuWRNc9edLBdUaHQPdhw2JD0P3QBsKY75Ej1RKYgESFxtXt
   0FE+ppIbDc381AkbMsQrCsvRu+8czZTFMlvGX0cYV/FMWdC1CI76tghQ0
   QMh5ERkTWIhquKNFujA8pYoLGa/vihFCYmxwoDMX9IE+0Km1O23DFlmCZ
   lqsDaFvtt5M/JD6P4HPVvbUcU9dubu5PiUur8I+j/rbEt0gLyEYw+Nq0V
   /LNgxVCSeB6lrND5eI4gW0YPIleY56ztQGS1PDJsCC7u3Xbkq8H0tLJyK
   /TmnJvZqM66pdwVZg6/x4mPgObVsXLg08actw88wge/Yl3B4aC/9WiHlN
   A==;
X-CSE-ConnectionGUID: zNdw2rvBS6ecUcsTlkDQMQ==
X-CSE-MsgGUID: 9BdBH5TPQxGqJBsTZI58cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32456643"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32456643"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 06:12:12 -0800
X-CSE-ConnectionGUID: NE3iqxIcT+28S9Ztl1Q9/g==
X-CSE-MsgGUID: wC1j1mVuS02DgIto8YIOlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="90674871"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 06:12:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tE7uh-0000000H5G4-296C;
	Thu, 21 Nov 2024 16:12:07 +0200
Date: Thu, 21 Nov 2024 16:12:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marco Elver <elver@google.com>
Cc: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v1 1/1] kcsan: debugfs: Use krealloc_array() to replace
 krealloc()
Message-ID: <Zz8_t3vn4SXTNHH3@smile.fi.intel.com>
References: <20241121135834.103015-1-andriy.shevchenko@linux.intel.com>
 <CANpmjNNzFykVmjM+P_1JWc=39cf7LPuYsp0ds0_HQBCzR+xOvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNzFykVmjM+P_1JWc=39cf7LPuYsp0ds0_HQBCzR+xOvQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 21, 2024 at 03:04:04PM +0100, Marco Elver wrote:
> On Thu, 21 Nov 2024 at 14:58, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Use krealloc_array() to replace krealloc() with multiplication.
> > krealloc_array() has multiply overflow check, which will be safer.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Marco Elver <elver@google.com>

Thank you!

> Do you have a tree to take this through? Otherwise I'll take it.

No, but please, wait a bit, I have a sequential dependent patch.
I'll send a v2 soon.

-- 
With Best Regards,
Andy Shevchenko




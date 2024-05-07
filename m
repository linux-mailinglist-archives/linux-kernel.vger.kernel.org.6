Return-Path: <linux-kernel+bounces-172067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917B38BECAE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F65282300
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE6C16E862;
	Tue,  7 May 2024 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZetxhbR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C921607A7
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715110543; cv=none; b=qlTJ5ZozroYcbT1KNLBlupvn3q9Lb5AZskagLGqt8dKerNl+CKdKm6CsIFsti2W4qIDg7ZPUuDGXGL21b3wUYrsNi7aA8QvaTpB4wSMzorvpg74q0iL0wL8JZpY+Zqwccz6E7Or/pYqR0YZIypKPKzngqVh1ods08dzDc2qnnTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715110543; c=relaxed/simple;
	bh=ZyhnfErNm1NGDYSA+GkugdsUWS5ykO66m8OHGEF0Bow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioJTA8a4SLs5Ihj9wtXEsWcklejNAc0krhz32Kqbz2AYgZn48R4gI4FnMp8d70lDS7m4IgS7kM36nhVJ1QoqIIRqglFg2fNci4JTkIv8AY1p+Y52C/7tVrHPbamWT8Xtl4doy/N2FtXUbIbpjggMPHAXKrJxbPNPs9Ipjar50ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZetxhbR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715110542; x=1746646542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZyhnfErNm1NGDYSA+GkugdsUWS5ykO66m8OHGEF0Bow=;
  b=WZetxhbRX0wpXrXvFFmoFD6aN+hOKhdg23lY2kfoEtZ2V6jI0j6Uv7Ym
   a4nq7NGgLV6SFVp0vrX8Fcv05zQFv+2L0fVsc3J8ES5icY10f0jb5PDaj
   9tbBqlqNe//MSXpy8ZHFfqkFP1Ah/CNdVLo3g+tiDkAa2E2JjkO143ioM
   8SyG0BJKMk1yUO5m2edAayJVbL0KzskQSIrscSVoYyNaDaOAHi/E7Clkv
   nMqnm4ghGdX1DV0I6Dkck28xJ09Di5Upl7XiHQttpn2B9W+rrcRDBbWXS
   t0mjQNUFew3dx3KUjZVcLv+DwT3aFN1WRETSWNqlxReYHsTdTtNx9qjIh
   A==;
X-CSE-ConnectionGUID: K08g0m7xTc2D1IFrX3dJyQ==
X-CSE-MsgGUID: yQoZn9f9RGSOc15hiNFTOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11415120"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11415120"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 12:35:41 -0700
X-CSE-ConnectionGUID: QiDb3KwaRS27gdm2Jd6QHg==
X-CSE-MsgGUID: //Ac4Q6wSkCh+hvNtY40ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="51844262"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 12:35:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s4QbC-00000005BI4-0YJN;
	Tue, 07 May 2024 22:35:38 +0300
Date: Tue, 7 May 2024 22:35:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] bitops: Move aligned_byte_mask() to wordpart.h
Message-ID: <ZjqCiXADLDSfP2U9@smile.fi.intel.com>
References: <20240507140155.197304-1-andriy.shevchenko@linux.intel.com>
 <Zjp9sm8s50rb9N/+@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjp9sm8s50rb9N/+@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 07, 2024 at 12:14:58PM -0700, Yury Norov wrote:
> On Tue, May 07, 2024 at 05:01:54PM +0300, Andy Shevchenko wrote:
> > The bitops.h is for bit related operations. The aligned_byte_mask()
> > is about byte (or part of the machine word) operations, for which
> > we have a separate header, move the mentioned macro to wordpart.h
> > to consolidate similar operations.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Hi Andy,
> 
> I see the macro is used in lib/strnlen_user.c and in lib/usercopy.c.
> In case of strnlen_user, the wordpart.h is included via linux/kernel.h,
> which is OK to me. But In case of usercopy.c, I can't find how the
> header is included. 
> 
> I'm sure there is some inclusion path, but it's always better to have
> the dependencies listed explicitly.
> 
> Can you please send a 2nd version with the lib/usercopy.c including
> wordpart.h?

I think it's unrelated right now. The inclusions in usercopy is a mess.
It should be cleaned up in a separate patch for all inclusions.

But okay, making slightly more mess there won't harm :-)

-- 
With Best Regards,
Andy Shevchenko




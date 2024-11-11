Return-Path: <linux-kernel+bounces-404550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E819C453D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BADEAB256E6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253181A9B33;
	Mon, 11 Nov 2024 18:33:21 +0000 (UTC)
Received: from yyz.mikelr.com (yyz.mikelr.com [170.75.163.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10D414F117
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.75.163.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350000; cv=none; b=ableAse/Xrf3XfclLOcAsnWxNjYpFKmxkynwTKZ8jVz7XLpWdr/GEGQDar1IeT1wWxn2sCQldCZUujqt7A5SXB2OJHWJojnUvCEGl2ZtUbXr8eYGsLdqaIX2cKkTBJp5+/rOtr2LVT8Mr7IyayLyBWQiGuwWtgOEvjlqGHQAPyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350000; c=relaxed/simple;
	bh=WtRh060pFXnEbb1RL5Llocr/Ie55dloclFd1qlV9uO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVEYyN0Un+8QdDfRGXEUa2acOOmxsiPhwzX/36+uiSQN0QuajUrZYDYFNdP/9Dx0snU1EPcINSjj9zoz7r/NFhbUH8aHGORm2CrqU06zwSDpVeUqhTB9SoC2rDMZohSGyPb98ewV3bOBuoN07Cp2APFDsCPhMWgcONe7bs5eqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com; spf=pass smtp.mailfrom=mikelr.com; arc=none smtp.client-ip=170.75.163.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mikelr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mikelr.com
Received: from basin.localnet (unknown [IPv6:2607:f2c0:e554:1200:4b8f:795f:f483:85bf])
	by yyz.mikelr.com (Postfix) with ESMTPA id 65B77727AD;
	Mon, 11 Nov 2024 13:33:11 -0500 (EST)
From: Mikel Rychliski <mikel@mikelr.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Fix off-by-one error in __access_ok
Date: Mon, 11 Nov 2024 13:33:10 -0500
Message-ID: <2987600.vYhyI6sBWr@basin>
In-Reply-To: <382372a83d1644f8b3a701ff7e14d5f1@AcuMS.aculab.com>
References:
 <20241109210313.440495-1-mikel@mikelr.com>
 <382372a83d1644f8b3a701ff7e14d5f1@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi David,

Thanks for the review:

On Sunday, November 10, 2024 2:36:49 P.M. EST David Laight wrote:
> From: Mikel Rychliski
> 
> > Sent: 09 November 2024 21:03
> > 
> > We were checking one byte beyond the actual range that would be accessed.
> > Originally, valid_user_address would consider the user guard page to be
> > valid, so checks including the final accessible byte would still succeed.
> 
> Did it allow the entire page or just the first byte?
> The test for ignoring small constant sizes rather assumes that accesses
> to the guard page are errored (or transfers start with the first byte).
> 

valid_user_address() allowed the whole guard page. __access_ok() was 
inconsistent about ranges including the guard page (and, as you mention, would 
continue to be with this change).

The problem is before 86e6b1547b3d, the off-by-one calculation just lead to 
another harmless inconsistency in checks including the guard page. Now it 
prohibits reads of the last mapped userspace byte.

> > diff --git a/arch/x86/include/asm/uaccess_64.h
> > b/arch/x86/include/asm/uaccess_64.h index b0a887209400..3e0eb72c036f
> > 100644
> > --- a/arch/x86/include/asm/uaccess_64.h
> > +++ b/arch/x86/include/asm/uaccess_64.h
> > @@ -100,9 +100,11 @@ static inline bool __access_ok(const void __user
> > *ptr, unsigned long size)> 
> >  	if (__builtin_constant_p(size <= PAGE_SIZE) && size <= PAGE_SIZE) 
{
> >  	
> >  		return valid_user_address(ptr);
> >  	
> >  	} else {
> > 
> > -		unsigned long sum = size + (__force unsigned long)ptr;
> > +		unsigned long end = (__force unsigned long)ptr;
> > 
> > -		return valid_user_address(sum) && sum >= (__force 
unsigned long)ptr;
> > +		if (size)
> > +			end += size - 1;
> > +		return valid_user_address(end) && end >= (__force 
unsigned long)ptr;
> 
> Why not:
> 	if (statically_true(size <= PAGE_SIZE) || !size)
> 		return vaid_user_address(ptr);
> 	end = ptr + size - 1;
> 	return ptr <= end && valid_user_address(end);

Sure, agree this works as well.

> Although it is questionable whether a zero size should be allowed.
> Also, if you assume that the actual copies are 'reasonably sequential',
> it is valid to just ignore the length completely.
> 
> It also ought to be possible to get the 'size == 0' check out of the common
> path. Maybe something like:
> 	if (statically_true(size <= PAGE_SIZE)
> 		return vaid_user_address(ptr);
> 	end = ptr + size - 1;
> 	return (ptr <= end || (end++, !size)) && valid_user_address(end);

The first issue I ran into with the size==0 is that __import_iovec() is 
checking access for vectors with io_len==0 (and the check needs to succeed, 
otherwise userspace will get a -EFAULT). Not sure if there are others.

Similarly, the iovec case is depending on access_ok(0, 0) succeeding. So with 
the example here, end underflows and gets rejected.





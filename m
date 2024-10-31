Return-Path: <linux-kernel+bounces-390268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E150A9B77BA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BEBBB251D5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8D7197A72;
	Thu, 31 Oct 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2q/BaCs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CAD194C8F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367600; cv=none; b=FryidfcBoZVbGWyEnVsf6Cw/fNwlQQXkdpqpwMtAz/WmvtCIYuyXNpwPL3as3qEnuoUc5Senh02jojicoVXZK6Fxg8DoOxmNqb0V3F2fd+brRUer63wFGfpIn73ffh83r1j62d3/G8T/g1EBaftZvGmL9CriZXEvFYltOmxWCDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367600; c=relaxed/simple;
	bh=vKIaj0aijU4XjLmVObUic0stD9F+UK51qt/abR2zG+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhLnC7ND+QCIdFKOGqDL6l83ZL0PLg59oLBPir5+HHbXFgaUh/UEjMab3UnqoQwPrCUr86uQ6E94CGKzq8MQ7gUv7/ECG620AJW33w6V7JugwkwF7x/UJH18UXJ7lTjo18iLmjGiLuEVq8K47HGAzXw9MxG8yEG7wABqHMPOmMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2q/BaCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC37C4CEC3;
	Thu, 31 Oct 2024 09:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730367599;
	bh=vKIaj0aijU4XjLmVObUic0stD9F+UK51qt/abR2zG+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2q/BaCsSHZEiLE7uSZkWaRfCOHJchAnY9ZLmMdHjWG+6VN/dIuBZliWhON+hEBtl
	 oq4Ia5pqNj2gSIvHrXvS0IcIAjm8q8tK1dJ2qpHu4BfH6B6viobG5nGteM9yXKw3Zn
	 uXzIwAZPXul6S1mXD5z3+v6QovD7F//OlLSlR5e/LfZLh8/qXouXyWZV1oejC2LbFr
	 i25vm95aKr/4vOunLDfS5CbYvLqfy2u4Xo0H8FSg9BMhHS/3AdcXw3YuS+Ut1K2GZi
	 nF+bg3AGaM27o52XRtxERTmc3hiPIjXLL/4VqOu+co/Cjg2+utyqpEPp4a7idRINw2
	 s05r/mqtpq1ag==
Date: Thu, 31 Oct 2024 10:39:39 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Joel Granados <j.granados@samsung.com>, Christian Brauner <brauner@kernel.org>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Re: [RESEND PATCH v3] sysctl: simplify the min/max boundary check
Message-ID: <4rrwkbj5sh4anblrxzhehcir2z2w5qhrdxfu4gc4irfg4ubb7q@hjt3e6agz42i>
References: <20240905134818.4104-1-wen.yang@linux.dev>
 <5yfnu64fqsuahcmifvqdaynvdesqvaehhikhjff46ndoaacxyd@jvjrd3ivdpyz>
 <4cce154a-1115-4371-a9f2-8bdb4879ea16@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cce154a-1115-4371-a9f2-8bdb4879ea16@linux.dev>

On Wed, Oct 30, 2024 at 12:26:17AM +0800, Wen Yang wrote:
> 
> 
> On 2024/10/23 03:12, Joel Granados wrote:
> > On Thu, Sep 05, 2024 at 09:48:18PM +0800, Wen Yang wrote:
...

> >> @@ -936,10 +921,10 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
> >>   int proc_douintvec_minmax(const struct ctl_table *table, int write,
> >>   			  void *buffer, size_t *lenp, loff_t *ppos)
> >>   {
> >> -	struct do_proc_douintvec_minmax_conv_param param = {
> >> -		.min = (unsigned int *) table->extra1,
> >> -		.max = (unsigned int *) table->extra2,
> >> -	};
> >> +	struct proc_minmax_conv_param param;
> >> +
> >> +	param.min = (table->extra1) ? *(unsigned int *) table->extra1 : 0;
> >> +	param.max = (table->extra2) ? *(unsigned int *) table->extra2 : UINT_MAX;
> > This is one of the cases where there is potential issues. Here, if the
> >  value of table->extra{1,2}'s value is greater than when
> > the maximum value of a signed long, then the value assigned would be
> > incorrect. Note that the problem does not go away if you remove the
> > "unsigned" qualifier; it remains if table->extra{1,2} are originally
> > unsigned.
> > 
> 
> I set up a CentOS 7.9 32-bit VM on Virtuanbox:
> # uname  -a
> Linux osboxes.org 3.10.0-1160.2.2.el7.centos.plus.i686 #1 SMP Mon Oct 26 
> 11:56:29 UTC 2020 i686 i686 i386 GNU/Linux
> 
> And the following test code:
> 
> #include <stdio.h>
> #include <stdlib.h>
> 
> int main()
> {
> 	unsigned int i = 4294967294;
> 	long j = i;
> 
> 	printf("original hex(i) = 0x%x\n", i);
> 	printf("unsigned int(i) = %lu\n", i);
> 	printf("---------------------\n");
> 	printf("hex(j) = 0x%x\n", j);
> 	printf("long(j) = %ld\n", j);
> 	printf("unsigned long(j) = %lu\n", j);
> 	printf("int(j) = %d\n", j);
> 	printf("unsigned int(j) = %lu\n", j);
> 	return 0;
> }
> 
> 
> ./a.out
> 
> original hex(i) = 0xfffffffe
> unsigned int(i) = 4294967294
> ---------------------
> hex(j) = 0xfffffffe
> long(j) = -2
This ^^^^^ is exactly what I expected. Thx for the test!

When you transfer that to your patch, it means that for certain cases
[1] the value resulting from the interpretation of param.{min,max}
(signed long) is going to be different than the value resulting from the
interpretation of table-extra{1,2} (unsigned int).

Here is another way of thinking about it:
We are avoiding bugs where a developer thinks they are handling longs,
when in reality they are handling unsinged ints; The result of
subtracting 1 from (-2) is very different from subtracting 1 from
4294967294.

> unsigned long(j) = 4294967294
> int(j) = -2
> unsigned int(j) = 4294967294
> 
> 
> The original hexadecimal values are the same, using unsigned int, int, 
> unsigned long, or long is just interpreted in different ways.
Exactly. Hex remains the same but the interpretation changes. And it is
there where pain lies.

Please re-work the patch without merging everything into
do_proc_douintvec_minmax_conv_param

> 
> We also ensure consistency in numerical writing and type conversion in 
> the patch. For example, in proc_rointvec_jiffies, convert to int; And in 
> proc_rouintvec_minmax, it is converted to unsigned int.
> 
> 
> --
> Best wishes,
> Wen
> 
> 
> > I'm not sure if there are more, but just having one of these things
> > around make me uncomfortable. Please re-work the patch in order to
> > remove this issue in order to continue review.
> > 
> > best
> > 
Best

[1] This is one case that I can imagine
  1. On 32 bit architectures
  2. Where UINT_MAX > LONG_MAX
  3. The value being assigned is greater LONG_MAX

-- 

Joel Granados


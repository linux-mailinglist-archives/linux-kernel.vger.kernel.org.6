Return-Path: <linux-kernel+bounces-169099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2AF8BC31A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 20:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61D71F2147C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 18:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A09B6A352;
	Sun,  5 May 2024 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLKPgr9H"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228FE25569
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714934900; cv=none; b=LY5yLFpiIHNq4VGe57JO90dZawtrRL3VeOQmO5TklhiTthB3HTSTLeXeT5Ig0QuvZwzswSBRQDP0BtJ4OJGRmNsku/6rwui0Q8F5zvLuOFiWNquRbg9/0ZGLDww7ViLxUdGZRIMZKw9CJrK5dcazOIo0r14VUoeIefp+hXTOsXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714934900; c=relaxed/simple;
	bh=QxhzbNsRiNMUQMFtXTN4kszLn9kkPo43+nXx4v5748k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5tZ7uqlBg82pz74GOJvGDQuM/h8VRpFzqYB5ZORcDDvyOkH3M1FsMg8pj1DZMaoatAmV3SppsteyT73QnexYA9Qv3pNQkSEjO6PLw3kV3p1yf1Rv96ycUypS/pCK+jKAru6ER5H6OOBTBdIxFw+L3Grl0KDuUKe7MC+6oiX+3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLKPgr9H; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ec400f9afdso3576565ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714934898; x=1715539698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOBQiovYsR7pgoDHIpFSRml5Sx5Ypxbw0sx4ZwZtbNM=;
        b=FLKPgr9HvV7EoX58BVswOFC2Qf3lXMiQw7LP/nMWu095f8N4htUKSZZrdb/3teNSCH
         r6ZRuSC4+xYBf/xbKwt+WTHUXO2AGtcecXnRkXbPLMYQI21fQRcnKBJIcawUYwsfmL1y
         jhfXhB6eDfEx031Utsqg2Z7wuSzQDT6d5NI5jjQ97vL+YaztfqbHP6u/613ZbdNcyAeL
         wpAU7Q+79mXXSSi4xVLSSDByN/7yMiiMObFnrdT0yUEEJnn5oZYN+NNtmYSnW5NuC64p
         NGscmopMP2sF7OsbXXKuJ3KK2Sj1mlyOgrXj+B0WGxOC0Lnmc7J/fY+lq9AjtZSegFyi
         QTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714934898; x=1715539698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOBQiovYsR7pgoDHIpFSRml5Sx5Ypxbw0sx4ZwZtbNM=;
        b=JxINKjSMQxY/qr8Qm9ZnLciGWVDzw5UD6tsc2oQGfzsorFhV5nbpR+oYe2t3P5nhnE
         lAcDoxEcQ6y/Fl0UnOJYlm+ifuPwkmdoFGqoM5Ewiwx2MyzQWHlSqqNPgNXgQBFbgLOu
         ToewBwguJjRf/0zz/dSwoUZ5SiKHhI1Z3V0Sg0//8gzLFAPMJTnNxCPVjJiZFLj4Y5aH
         OUdBboIwi54xwtvCFIzYTuFimcQIU5PiZIOdsgDkXv0JjJQIXpKf8sRiPFZE6430eT91
         9cQVc4II7ZH6wqaDtaCXla5PhYP/Zgy4d1QAx0tE5BGu6hH0l4phl6wHsKLuf2RyF3dt
         xYCg==
X-Forwarded-Encrypted: i=1; AJvYcCWNAk1arRk2Pi4AblA0iQf8nOXmdMLy292FJGWegvOlV+FlubNhl+z3aUuRzDLaFRwe2beVwVoWVQ7WUFTwj6YVp2B0ahjPEEkYiWxz
X-Gm-Message-State: AOJu0Yxk5HNC+EspgzuPzHxZB7e/X9LruO24hFHvLFLM8e0Fbco5VC88
	1E05dcC5neHnMCXfNgzWB+yO4C9Z++3Epqi7e+wbaU9Ml3qp0qrU
X-Google-Smtp-Source: AGHT+IEOSO/tVV6aBxRpwD/blz+ybsVWfSjHil6yrGUPM9gIKqFXE3l5SBUj9CoeAC24HTTXB9pFaw==
X-Received: by 2002:a17:902:d2d0:b0:1e8:4063:6ded with SMTP id n16-20020a170902d2d000b001e840636dedmr11372211plc.1.1714934898144;
        Sun, 05 May 2024 11:48:18 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b001ed8886e794sm3144614plb.165.2024.05.05.11.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 11:48:17 -0700 (PDT)
Date: Mon, 6 May 2024 02:48:14 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: David Laight <David.Laight@aculab.com>
Cc: 'Yury Norov' <yury.norov@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
	"n26122115@gs.ncku.edu.tw" <n26122115@gs.ncku.edu.tw>,
	"jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] lib/test_bitops: Add benchmark test for fns()
Message-ID: <ZjfUbqyYTrVR8E6p@visitorckw-System-Product-Name>
References: <20240501132047.14536-1-visitorckw@gmail.com>
 <20240501132047.14536-2-visitorckw@gmail.com>
 <ZjJt9w2mvdm2P+dM@yury-ThinkPad>
 <62fdb348791949c08e53936e3bc442b5@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62fdb348791949c08e53936e3bc442b5@AcuMS.aculab.com>

On Sun, May 05, 2024 at 01:11:53PM +0000, David Laight wrote:
> From: Yury Norov
> > Sent: 01 May 2024 17:30
> > 
> > On Wed, May 01, 2024 at 09:20:46PM +0800, Kuan-Wei Chiu wrote:
> > > Introduce a benchmark test for the fns(). It measures the total time
> > > taken by fns() to process 1,000,000 test data generated using
> > > get_random_bytes() for each n in the range [0, BITS_PER_LONG).
> > >
> > > example:
> > > test_bitops: fns:          5876762553 ns, 64000000 iterations
> > 
> > So... 5 seconds for a test sounds too much. I see the following patch
> > improves it dramatically, but in general let's stay in a range of
> > milliseconds. On other machines it may run much slower and trigger
> > a stall watchdog.
> > 
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > 
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > 
> > > ---
> > >
> > > Changes in v4:
> > > - Correct get_random_long() -> get_random_bytes() in the commit
> > >   message.
> > >
> > >  lib/test_bitops.c | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >
> > > diff --git a/lib/test_bitops.c b/lib/test_bitops.c
> > > index 3b7bcbee84db..ed939f124417 100644
> > > --- a/lib/test_bitops.c
> > > +++ b/lib/test_bitops.c
> > > @@ -50,6 +50,26 @@ static unsigned long order_comb_long[][2] = {
> > >  };
> > >  #endif
> > >
> > > +static unsigned long buf[1000000];
> > 
> > Can you make it __init, or allocate with kmalloc_array(), so that 64M
> > of memory will not last forever in the kernel?
> > 
> > > +static int __init test_fns(void)
> > > +{
> > > +	unsigned int i, n;
> > > +	ktime_t time;
> > > +
> > > +	get_random_bytes(buf, sizeof(buf));
> > > +	time = ktime_get();
> > > +
> > > +	for (n = 0; n < BITS_PER_LONG; n++)
> > > +		for (i = 0; i < 1000000; i++)
> > > +			fns(buf[i], n);
> > 
> > What concerns me here is that fns() is a in fact a const function, and
> > the whole loop may be eliminated. Can you make sure it's not your case
> > because 450x performance boost sounds a bit too much to me.
> > 
> > You can declare a "static volatile __used __init" variable to assign
> > the result of fns(), and ensure that the code is not eliminated
> 
> Yep, without 'c' this compiler to 'return 0'.
> 
> static inline unsigned long fns(unsigned long word, unsigned int n)
> {
> 	while (word && n--)
> 		word &= word - 1;
> 	return word ? __builtin_ffs(word) : 8 * sizeof (long);
> }
> 
> unsigned long buf[1000000];
> 
> volatile int c;
> 
> int  test_fns(void)
> {
> 	unsigned int i, n;
> 
> 	for (n = 0; n < 8*sizeof (long); n++)
> 		for (i = 0; i < 1000000; i++)
> 			c = fns(buf[i], n);
> 	return 0;
> }
> 
> You are also hitting the random number generator.
> It would be better to use a predictable sequence.
> Then you could, for instance, add up all the fns() results
> and check you get the expected value.
> 
> With a really trivial 'RNG' (like step a CRC one bit) you
> could do it inside the loop and not nee a buffer at all.
> 
Hi David,

I do think that conducting correctness testing here is a good idea.
However, we are about to change the return value of fns() from return
BITS_PER_LONG to return >= BITS_PER_LONG [1][2] when the nth bit is not
found. Therefore, using a fixed input series here and checking the sum
of return values may not accurately test it. Do you know if there are
any other more suitable testing methods?

[1]: https://lore.kernel.org/all/20240502233204.2255158-3-yury.norov@gmail.com/
[2]: https://lore.kernel.org/all/20240502233204.2255158-4-yury.norov@gmail.com/

Regards,
Kuan-Wei

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 


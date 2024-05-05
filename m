Return-Path: <linux-kernel+bounces-169143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0DC8BC3BA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8653B282808
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 20:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68836D1B5;
	Sun,  5 May 2024 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJYSZsP1"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C06D1E53F
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714941598; cv=none; b=UkLm7tC2iLVEbhYvxLDsgwFLaGz7V/UoK7MpzSWKRb5rR0BbO61bdLBUqj2AHMtJMkBlRcHuFjzKze7skV2OO7bSvx0fsIJ768XKqtJJz3iB6fhhqatfpjqlrBy+6WuPihcVX0DfcrQymyxoAhaDcZRuji5OMAlr6bc00Whspk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714941598; c=relaxed/simple;
	bh=WJ36CpdnMaqwAwBMdGgMh56b7TDkI+iDOUfj/+/mGUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4cN0H6QZV1KNjOn3+yL46t0aPi4BbTiBZWi00cU1pLi3aGOml1BI+Sorsg6leb9+dgWLbgiFfxsP26eVpdmgZIETP6ScCTmSVyQp9dB8wVBPZa+YluHuG7JY2YoMvn45nYmb38a+PI71OikKDQvIR6WVM2JlSWUdjSzKZ8N3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJYSZsP1; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61b62005f38so13768217b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 13:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714941595; x=1715546395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h4190wFlaC7hakQ0Bwz/VlBkmfvmM0vYvN9SYNIjFmM=;
        b=nJYSZsP1e8yIBdBZkyj916dETnVagmXU1r1qYHSZQ/3W7lhkGmJXNG86PnvVkisFVq
         GQK3R6+0moozG19GdqEbojnTYnx+/pZ6Kd8QYf3OUbnpVaqfhRer/jVrrKs+WNlqpATS
         Tsi9seXZGtrfs34NXO2F1dxeEBzDYJof7Q4A7uIwBwzdsgMzu9tKE7CQNgm1Eyrzs1TE
         Jw9VOCG11ofz0X2H0y/PnIrXtd7eNXkjSrZ2y69LMx2kaKsfc9JrOwslt/GQMW8SXmXe
         wfg/od1szJTgewtfufJTOHBbIOowVGCvU18HXQtTKCcHuTa0ceWSvJgzjBrFgnDbq4Oe
         FnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714941595; x=1715546395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4190wFlaC7hakQ0Bwz/VlBkmfvmM0vYvN9SYNIjFmM=;
        b=mi0frIzA4Xt1Vs8sTsykgzSCw7Eb2nByKr1HOyJkeZl10w1Hl2JbcuLGYryPi0CA77
         R3m14GAzVeivIGiN3BllevpfBWFzZ8CiHUUF1h7Se4UUxsz5zzbloSNanzWLsKyP/2fh
         mTfRijLWkXB3zZe8+3E5Z6vQaqf8zFwGGb9yTyc6csTORx/bm4ZAXltMUB8pQsCNXdtb
         7QpD/foyIqVj5ENdI2xanIrt5Ua+3jcCXrr0Ptr4AfOOjsrWhAT1BkNmOgvY4flhE7j/
         aXEg8/uhg8wVOv1wofF3687KNE9c6jJl4Qya5Sq4mlUPXSgQb8LdtaKIQ/f2c7DDwQh4
         wKYg==
X-Forwarded-Encrypted: i=1; AJvYcCV+o5Heq4BSfL0EFzReETRqvaMdP0znF/ouT1tjDajhH66CoBSmfP0tmoCsubzqxlmWu8Zjh6xw6LZ7Of9S4YVQWOQRt42SJBL7F56x
X-Gm-Message-State: AOJu0YwQdqzA0Lvf6qHbzqfhdIFjOz341jZvIYlw4Twio3T7HoT0Ymz6
	ayvIKJ46OLgmohl9v5glfDSLeORo7w84ZUuRP8T6MQlU2TJKhphI
X-Google-Smtp-Source: AGHT+IFoB8TnJPWCm9GqP4Rcy53sdt+qxltrHiqFAY5aXDGP+SHV1pk4DhY4O8unV8HU5iR3ZSHSIA==
X-Received: by 2002:a0d:db51:0:b0:61a:b5cd:ee95 with SMTP id d78-20020a0ddb51000000b0061ab5cdee95mr8399645ywe.32.1714941595244;
        Sun, 05 May 2024 13:39:55 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:265f:1d31:26d2:a214])
        by smtp.gmail.com with ESMTPSA id g21-20020a0ddd15000000b0061be5fe1e80sm1771239ywe.80.2024.05.05.13.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 13:39:54 -0700 (PDT)
Date: Sun, 5 May 2024 13:39:53 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: David Laight <David.Laight@aculab.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
	"n26122115@gs.ncku.edu.tw" <n26122115@gs.ncku.edu.tw>,
	"jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] lib/test_bitops: Add benchmark test for fns()
Message-ID: <ZjfumT3gv9rzFBxw@yury-ThinkPad>
References: <20240501132047.14536-1-visitorckw@gmail.com>
 <20240501132047.14536-2-visitorckw@gmail.com>
 <ZjJt9w2mvdm2P+dM@yury-ThinkPad>
 <62fdb348791949c08e53936e3bc442b5@AcuMS.aculab.com>
 <ZjfUbqyYTrVR8E6p@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjfUbqyYTrVR8E6p@visitorckw-System-Product-Name>

On Mon, May 06, 2024 at 02:48:14AM +0800, Kuan-Wei Chiu wrote:
> On Sun, May 05, 2024 at 01:11:53PM +0000, David Laight wrote:
> > From: Yury Norov
> > > Sent: 01 May 2024 17:30
> > > 
> > > On Wed, May 01, 2024 at 09:20:46PM +0800, Kuan-Wei Chiu wrote:
> > > > Introduce a benchmark test for the fns(). It measures the total time
> > > > taken by fns() to process 1,000,000 test data generated using
> > > > get_random_bytes() for each n in the range [0, BITS_PER_LONG).
> > > >
> > > > example:
> > > > test_bitops: fns:          5876762553 ns, 64000000 iterations
> > > 
> > > So... 5 seconds for a test sounds too much. I see the following patch
> > > improves it dramatically, but in general let's stay in a range of
> > > milliseconds. On other machines it may run much slower and trigger
> > > a stall watchdog.
> > > 
> > > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > 
> > > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > > 
> > > > ---
> > > >
> > > > Changes in v4:
> > > > - Correct get_random_long() -> get_random_bytes() in the commit
> > > >   message.
> > > >
> > > >  lib/test_bitops.c | 22 ++++++++++++++++++++++
> > > >  1 file changed, 22 insertions(+)
> > > >
> > > > diff --git a/lib/test_bitops.c b/lib/test_bitops.c
> > > > index 3b7bcbee84db..ed939f124417 100644
> > > > --- a/lib/test_bitops.c
> > > > +++ b/lib/test_bitops.c
> > > > @@ -50,6 +50,26 @@ static unsigned long order_comb_long[][2] = {
> > > >  };
> > > >  #endif
> > > >
> > > > +static unsigned long buf[1000000];
> > > 
> > > Can you make it __init, or allocate with kmalloc_array(), so that 64M
> > > of memory will not last forever in the kernel?
> > > 
> > > > +static int __init test_fns(void)
> > > > +{
> > > > +	unsigned int i, n;
> > > > +	ktime_t time;
> > > > +
> > > > +	get_random_bytes(buf, sizeof(buf));
> > > > +	time = ktime_get();
> > > > +
> > > > +	for (n = 0; n < BITS_PER_LONG; n++)
> > > > +		for (i = 0; i < 1000000; i++)
> > > > +			fns(buf[i], n);
> > > 
> > > What concerns me here is that fns() is a in fact a const function, and
> > > the whole loop may be eliminated. Can you make sure it's not your case
> > > because 450x performance boost sounds a bit too much to me.
> > > 
> > > You can declare a "static volatile __used __init" variable to assign
> > > the result of fns(), and ensure that the code is not eliminated
> > 
> > Yep, without 'c' this compiler to 'return 0'.
> > 
> > static inline unsigned long fns(unsigned long word, unsigned int n)
> > {
> > 	while (word && n--)
> > 		word &= word - 1;
> > 	return word ? __builtin_ffs(word) : 8 * sizeof (long);
> > }
> > 
> > unsigned long buf[1000000];
> > 
> > volatile int c;
> > 
> > int  test_fns(void)
> > {
> > 	unsigned int i, n;
> > 
> > 	for (n = 0; n < 8*sizeof (long); n++)
> > 		for (i = 0; i < 1000000; i++)
> > 			c = fns(buf[i], n);
> > 	return 0;
> > }
> > 
> > You are also hitting the random number generator.
> > It would be better to use a predictable sequence.
> > Then you could, for instance, add up all the fns() results
> > and check you get the expected value.
> > 
> > With a really trivial 'RNG' (like step a CRC one bit) you
> > could do it inside the loop and not nee a buffer at all.
> > 
> Hi David,
> 
> I do think that conducting correctness testing here is a good idea.
> However, we are about to change the return value of fns() from return
> BITS_PER_LONG to return >= BITS_PER_LONG [1][2] when the nth bit is not
> found. Therefore, using a fixed input series here and checking the sum
> of return values may not accurately test it. Do you know if there are
> any other more suitable testing methods?

Hi David,

Let's do one thing in a time. test_fns() is about performance testing,
and that's it. Kuan-Wei wrote it specifically for that.

He also chose to use random numbers to feed the fns(), and that's a
reasonable choice. I see nothing wrong in his approach with the array,
as well as what you proposed. But the test is done, and it works. If
you think it's worth testing the function with your approach, feel
free to submit your test, I'll take it just as well, and we'll have
even better coverage.

Regarding summing up all the fns() returns to check correctness - I
think it's a wrong idea. At first because current behavior when we
return BITS_PER_LONG is not a contract, just implementation detail.
And even now, on 64- and 32-bit arches fns() will sum up to different
numbers.

Second, this summing up doesn't sound reliable. Imagine a case when
the function fails one time returning a less-by-one number, and in the
following run - a greater-by-one. So the sum will be correct, and the
test will not catch the error.

We're running a test_find_nth_bit(), and to me it's enough for testing
fns(). But if you'd like, please send a more specific test.

Thanks,
Yury


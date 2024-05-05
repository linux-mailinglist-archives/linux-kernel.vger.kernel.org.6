Return-Path: <linux-kernel+bounces-169081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578068BC2D2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 19:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CA21C20E0D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 17:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8C153E16;
	Sun,  5 May 2024 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8OVTqJ6"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4571E861
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714930164; cv=none; b=jcWoKnlMsYkYxPtgfUQ6nP7BZNQXJnBjNg8WisHc+On+JHYPwUbVZQanEsJIDPxMdpS/T00Rbg5PDgxXDByHSh6OMOTB1xZRywlnJ1s+aLCXksbyYqz/ft9xCGYTEM7H4m0o2OTtXHQUZkvMP+xDEhEPSH35ImXCYkjy7Orp/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714930164; c=relaxed/simple;
	bh=V78LFVlUDneq9UmLjB6oxD2QC57zLMoM9j+jwK6P9Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWaCvgyDPz47aCsEGyMEhv4NHzPgvjY11m2csSOs22mv1Un2miltn7U72GayGPKvM5LbGjYMTl6SO0FI0lfRYngieC0uVlGqGe1qqThUvLmADOWO2iDLoPAVmk6SaekPploOAyh4O8bDdvaBs2n1p3ttfvgqctmjTxxSGYW5Xjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8OVTqJ6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b370e63d96so353854a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714930162; x=1715534962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvDbV6AO5TwPhUqCkiDvAp5iYLy3S0SId5y94yCn9JU=;
        b=S8OVTqJ6UlhrWWcXoq2VgFAYk5mTDqGB0AQeAGycvGoKdEO0t7nerNLuw62JsgdoQB
         kVV4qM7inGbEFrBnMwUbV5kfwi8yif8bEDCcglZt3jwIEKyvfb8Bxx1Y9mhUTvFz3Je3
         RWl8/riI+cX44VIO6aU87P+D+WGQxcPgBHEpUgFYr03ef7Rk8pGczckX4Dryc0zMiTc8
         04G4Qn5xlpx+RfLC+GMfe1GT++SbB1ollZu8cYC8l9qPahSKlMqi2y2z9b3G51+kGLXA
         ptb0UHNrjaqspfUXJhmfcdGmIntCb0dnvJ8TVyPyhBid5mJEwT3Wakdu/nWpIBJcLeaw
         K9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714930162; x=1715534962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvDbV6AO5TwPhUqCkiDvAp5iYLy3S0SId5y94yCn9JU=;
        b=i7BHyuCujRu5+TK9xKB1Liid/IJypH/m59B0X09g9KV9YwyEe0cFGkcbAoMNoaDKUV
         zuSqyk0U/0MUlRNeymvwsA4sv4LokMYEIfGyYF8hrr51L8tfhO4ovSVeeIzUp5mtF3oM
         o8ACkLecWBSyun4+zHWeO2qtwCzzPYQ3OI4320bPMCEvi4KXJu5ZnRFNhMBOJBLIdNrH
         /b+tp0DIV5X5TwLFt9U02ZZs1JVU31Sz4uLmdN4vLVUJcms0bd0uCJxSp3sinWTNqsMI
         FRwtpT8kIsTGn7bnFmFaDepbO4B+6194F0K/Gx9nTE5PYZo7/gwvA7qMcsnae39BqY78
         Qrlw==
X-Forwarded-Encrypted: i=1; AJvYcCUsQUP64peYmmxWixhcFRtNgyAJtk9MIvoMJpFP9Ku1CJG3Gz13L1gPUgU1OcbWSV3bYZbRl8IEpT1vrIrTjCSGIUkVZV6eHxwh/Q4B
X-Gm-Message-State: AOJu0YxKf/oM6//90oQ2g4iV9O8ngWMz0AXzPf/3k6w9AtlnpA9hvm5V
	XiO4kngXO4fOwKMNde0WdjwlH/zf4mJcwCDxNmnyTkqITi22zkkj
X-Google-Smtp-Source: AGHT+IG//QOvSTwN6qrCuFg/+XAFJZ24X/iKGdlMiXevVnJdhQt2Ld+BUebUTjG7UC6LrVgIhaY92w==
X-Received: by 2002:a05:6a21:8185:b0:1ad:455e:4ae4 with SMTP id pd5-20020a056a21818500b001ad455e4ae4mr9193605pzb.6.1714930162412;
        Sun, 05 May 2024 10:29:22 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id ff3-20020a056a002f4300b006f0ba1c8ddesm6248458pfb.184.2024.05.05.10.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 10:29:21 -0700 (PDT)
Date: Mon, 6 May 2024 01:29:18 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: David Laight <David.Laight@aculab.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"yury.norov@gmail.com" <yury.norov@gmail.com>,
	"linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
	"n26122115@gs.ncku.edu.tw" <n26122115@gs.ncku.edu.tw>,
	"jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] lib/test_bitops: Add benchmark test for fns()
Message-ID: <ZjfB7j16fcsOZyQI@visitorckw-System-Product-Name>
References: <20240501071647.10228-1-visitorckw@gmail.com>
 <20240501071647.10228-2-visitorckw@gmail.com>
 <44e9ab62e0f543439eb7566a9f134af6@AcuMS.aculab.com>
 <ZjfBeUJDRMHJKQMX@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjfBeUJDRMHJKQMX@visitorckw-System-Product-Name>

On Mon, May 06, 2024 at 01:27:25AM +0800, Kuan-Wei Chiu wrote:
> Hi David,
> 
> On Sun, May 05, 2024 at 01:03:23PM +0000, David Laight wrote:
> > From: Kuan-Wei Chiu
> > > Sent: 01 May 2024 08:17
> > > 
> > > Introduce a benchmark test for the fns(). It measures the total time
> > > taken by fns() to process 1,000,000 test data generated using
> > > get_random_long() for each n in the range [0, BITS_PER_LONG).
> > > 
> > > example:
> > > test_bitops: fns:          5876762553 ns, 64000000 iterations
> > 
> > Great benchmark....
> > 
> > The compiler almost certainly optimises it all away.
> > 
> > Assigning the result of fns() to a file scope (global) volatile int
> > should stop that happening.
> > 
> Thank you for your review. There is an updated v5 of this patch [1],
> which has already been accepted and included in Yury's bitmap-for-next
> branch of the bitmap tree. In the v5 patch, we have addressed the issue
> you mentioned regarding the use of volatile variables to avoid compiler
> optimizations.
>
[1]: https://lore.kernel.org/lkml/20240502092443.6845-2-visitorckw@gmail.com/

> > And a real test would actually check the result - just in case
> > someone does something silly.
> >
> The fns() function is mainly a helper for find_nth_bit(), so its
> accuracy should have been checked in find_nth_bit()'s tests. If you
> want unit tests for fns() here too, that sounds good to me, but it
> would likely be a separate patch. I'm happy to do it if you'd like.
> 
> Regards,
> Kuan-Wei
> 
> > 	David
> > 
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > Registration No: 1397386 (Wales)
> > 


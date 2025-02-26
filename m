Return-Path: <linux-kernel+bounces-534493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EB8A46766
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9410B7A9FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59D72236E0;
	Wed, 26 Feb 2025 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="sc7elpqN"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B92222CF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589528; cv=none; b=ldl90UxktX2XfIZAYU20yUF2WTjeK1s+eZJWq0oVCXupvucnD5Y0i3LuMVKYLIK3HFIEV4Qby7x3QfRn7C4Xkwy9Ud0mpSbbEJSzAfQ/3qA+tHdUGRQCBCT7fU7HvyyudGKUgZA9tJPzUvMOjPqSRGAxnXAMaYEj6tdW/juPOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589528; c=relaxed/simple;
	bh=Wk0YWZOUZv5kpZHp/iUsznrpW1N4cbTlGmF9LQZpze4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8oJ2EOcujqv7IlmUcmiMhI8gQUyyEwRU+UW3IENryc4T3X0n9thOkcRvWwbv6ZUGp8QAYTQHrd0VlApjRbDsNVYenaHeswmYO3j9ioLT5YEGMT4jZGoR9CvQEhswAJfCu49px8pflbzwFJpsLsadBhbJDe+RetJoFPnJBQ9gd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=sc7elpqN; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Wed, 26 Feb 2025 12:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1740589520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+DFvEhuZpUCM6lOpRG/AFVq+EwIoa9bUMBQFUnLqng0=;
	b=sc7elpqNNJvAnZnVGvSLjMwVznTy184QqQhcH8XqsjNzZDb5qZCQLL82P8XaYD0lowgdcN
	SFD5WKpmY4j/KKfMM5pNLNWC7yAg5YrYCGtBYUtNb/td+HprbMg1+akXRaNNRlr8XH3bjL
	3yMM7nIKNXFlgtVUIOlPIUqeiKFNCAYhI0HPd0TXgo+ol7UVCozBfAeZTCEDCX8YrLhuRW
	/yC4+SLGKEVUdCUKoDif1+SAlNe4KZIynfWBUJhC4POmZFtDe0KX8o/ySaPEzKWLfpm9VC
	lRie38LV26T/kRZedroALuS5WMVELZrUKw9JbAbMSjIMZ/WBFffHjjXmDqDbvA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Sven Peter <sven@svenpeter.dev>
Cc: Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 2/4] soc: apple: rtkit: Implement OSLog buffers properly
Message-ID: <Z79JyhOQUI_LV4oV@blossom>
References: <20250222-apple-soc-misc-v1-0-1a3af494a48a@svenpeter.dev>
 <20250222-apple-soc-misc-v1-2-1a3af494a48a@svenpeter.dev>
 <Z7y14Q3ifu7U1tHI@blossom>
 <63c5cbfe-4751-4409-9be7-2fda21b09503@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63c5cbfe-4751-4409-9be7-2fda21b09503@app.fastmail.com>
X-Migadu-Flow: FLOW_OUT

> >> +	if (ep == APPLE_RTKIT_EP_OSLOG) {
> >> +		buffer->size = FIELD_GET(APPLE_RTKIT_OSLOG_SIZE, msg);
> >> +		buffer->iova = FIELD_GET(APPLE_RTKIT_OSLOG_IOVA, msg) << 12;
> >> +	} else {
> >> +		buffer->size = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_SIZE, msg) << 12;
> >> +		buffer->iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
> >> +	}
> >
> > The shifts are suspiciously asymmetric. Are we really sure this is
> > correct? My guess is that both size & iova for both oslog & buffer need
> > to be page-aligned, so all 4 lines should be shifted, and the bit
> > offsets should be adjusted in turn, and the lower 12-bits in oslog_size
> > and buffer_iova are reserved. But that's just a guess.
> >
> > Anyway if this logic is really what we want it deserves a comment
> > because it looks like a typo.
> 
> That guess can't be true for syslog since there's no change in behavior here
> and the syslog endpoint has been working fine so far. This common code is
> also used for other endpoints that request buffers and there haven't been
> any issues there either. The size is just passed in "number of 4k chunks"
> and the IOVA needs no additional fixups.
> 
> 
> The entire reason for this commit is because this common logic just didn't
> work for oslog. Our u-boot fork uses the same logic as used here [1]. We're stealing
> a chunk of MTP's SRAM to make hand-off to Linux easier there. If either size or
> IOVA was off by a factor 0x4000 this would've never worked in the first
> place.

I'm not suggesting things are off by a factor of 4k. Rather I'm
questioning what the behaviour is when we're not 4k aligned. (I.e.
the syslog or oslog buffer does not both start and end at 4k
boundaries.)

If we're aligned, all our bottom bits are 0, and hypothetically we're
putting 0 into "reserved-must be zero" bits.

I guess it's inconsequential if everything is 4k aligned in practice.
But .. is it? I don't know.


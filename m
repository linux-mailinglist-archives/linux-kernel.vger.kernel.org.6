Return-Path: <linux-kernel+bounces-333079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E21D097C330
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 05:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC921F21FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F621865C;
	Thu, 19 Sep 2024 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IHzOdL0z"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840BF12E4A
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726717130; cv=none; b=HYSyRY6JGAa2L4LEGQq1KYDV8UIYftsCn3XUBWLymmDtQs/tfxmdgKOsomAEkm1jy2MBsPRseH4j6jytlTR0AlshRqjaGhjLxrLNN9DlDd0zX+Io4BvQz/JyD/ekC5BGteCI82DNtAEnKftPMo7/GljmsrnVb/qyd7oPZVcMPuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726717130; c=relaxed/simple;
	bh=LoMi13A4AfE43GdKZNtf5scV3hXW2dBvlxD8UDU1VWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWU5NlhLj5Y6nkEM+PSRCxzxEtr3mJ/bDyXjKFCVAnni8YXvcOqJ8wo3uPZDEA1w9hubUkCRTDvkC3Ii5T1Lzujq2QYovEUAVsKUgDHa2c/+xEf2B7Ii/7iK2IbfJAp7C5BVBG0AaHNbbShvzHy43/oLVnbuNdX/w5gagHZ9WEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IHzOdL0z; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so258114566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 20:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726717126; x=1727321926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ip2Z9ZN8QnSQEWnaDGGUtbvLzJ9Kl1C8B/3QvjgaEU=;
        b=IHzOdL0ziPLBBqO2t+zRmtnE/yrtmkqD9LiWh0z93E+ZUW17YSGzOaMpm1ii+zzkfY
         dj1wMECQjOXkIm7nswPVJ55vS11ASWcAL0jzRGULO47JXgVSzbdUNVo6i9cdVxKLKAhI
         9DCJToJG0LbKVlDjId8sayrJ142cbV1YnwlI8kHgl2J8EPcSs2lM7IZMI6+zJYG9jfOr
         3UrR/EieI+O/3m0Hh+28ewlPaYKTomHdmUHHQlbdOEUUypBlzYXAz90IBlX99rnvzOtn
         dY8g4SXKmgNKkXhvuz7H/vg6W7WGoIFXIE0pPoeYHI6XsADDLLWYMjeBEbJ9nLUiPk7b
         wmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726717126; x=1727321926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ip2Z9ZN8QnSQEWnaDGGUtbvLzJ9Kl1C8B/3QvjgaEU=;
        b=GBQlWDWbUlp8NRkCzpgcdE1TUu0tplg3CF/6SptbauvkewxatbvyoL9MV9v486dvd0
         MGaciAYTMT7vNf3YK7jLHy/m143PbAud3JynfgS5Yu7FYhQhqrxlbFy3LpsZWtNzIJ/P
         2AP/jtkvDHUH6nBmHT/sC2WCuYUiEgLrhVoqmW1Y0BwphUMFr2gsQwbiB1NOqPe1mdFV
         QuM6mCBkAkr+urOmsYe+4ArT2/LY67259fz7IkqTQRmYms9LU307Tmi7eJ90/jmN/zPE
         A5P2DvHMpfh+AnKQ2eAdxYoPfSnaLSo9u+Ve9D/aSzVQj9I/ZMma/XOhUs03x+Z0J8eC
         SQuw==
X-Forwarded-Encrypted: i=1; AJvYcCXShspR0Oey4ftXPTm3ULqYLAKN61wsBWTXNBNJx5VuIlHtMqX89dSf+rUuaDvMYwYqQpxo2W6/CHAWWWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHT0zubB6WggWMLLczYm+a/zBfr14e9L9w9qIykb/JySeuoiqO
	5BRtsV+OckV/uBKetKNCV5ZevTn3V4RQRJmaxWRFZqP71Xh5cbWxRaThTnfoyRk=
X-Google-Smtp-Source: AGHT+IEoH3Dhv73LGspYMYEfg6SjReNg6iDMuoDHAeKmrMPg6QH84CSbwClYlsxjJrTcrRMZ7RzAJg==
X-Received: by 2002:a17:907:3f88:b0:a8d:6372:2d38 with SMTP id a640c23a62f3a-a90c1cba61emr142785266b.18.1726717125742;
        Wed, 18 Sep 2024 20:38:45 -0700 (PDT)
Received: from [192.168.0.216] ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4375sm666457166b.73.2024.09.18.20.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 20:38:43 -0700 (PDT)
Message-ID: <8697e349-d22f-43a0-8469-beb857eb44a1@kernel.dk>
Date: Wed, 18 Sep 2024 21:38:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@meta.com>,
 Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
 regressions@leemhuis.info
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
 <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
 <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/24 9:12 PM, Linus Torvalds wrote:
> On Thu, 19 Sept 2024 at 05:03, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I think we should just do the simple one-liner of adding a
>> "xas_reset()" to after doing xas_split_alloc() (or do it inside the
>> xas_split_alloc()).
> 
> .. and obviously that should be actually *verified* to fix the issue
> not just with the test-case that Chris and Jens have been using, but
> on Christian's real PostgreSQL load.
> 
> Christian?
> 
> Note that the xas_reset() needs to be done after the check for errors
> - or like Willy suggested, xas_split_alloc() needs to be re-organized.
> 
> So the simplest fix is probably to just add a
> 
>                         if (xas_error(&xas))
>                                 goto error;
>                 }
> +               xas_reset(&xas);
>                 xas_lock_irq(&xas);
>                 xas_for_each_conflict(&xas, entry) {
>                         old = entry;
> 
> in __filemap_add_folio() in mm/filemap.c
> 
> (The above is obviously a whitespace-damaged pseudo-patch for the
> pre-6758c1128ceb state. I don't actually carry a stable tree around on
> my laptop, but I hope it's clear enough what I'm rambling about)

I kicked off a quick run with this on 6.9 with my debug patch as well,
and it still fails for me... I'll double check everything is sane. For
reference, below is the 6.9 filemap patch.

diff --git a/mm/filemap.c b/mm/filemap.c
index 30de18c4fd28..88093e2b7256 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -883,6 +883,7 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 		if (order > folio_order(folio))
 			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
 					order, gfp);
+		xas_reset(&xas);
 		xas_lock_irq(&xas);
 		xas_for_each_conflict(&xas, entry) {
 			old = entry;

-- 
Jens Axboe


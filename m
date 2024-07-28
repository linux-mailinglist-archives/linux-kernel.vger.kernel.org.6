Return-Path: <linux-kernel+bounces-264871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC3293E97F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 23:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65616B21252
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 21:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE92B74429;
	Sun, 28 Jul 2024 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VygX92ex"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14158203
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722200495; cv=none; b=QAMOTdDUu3J5mtPZUjJ+2fiSuraEyKqdBV6uwUNuztwnuMCBSR9mcdt3n0Ljn/TPkEayTIrDJ973CZuHOKW8EQEWKd8Lx0h7sQWqTDooot7dHabu7M0j6pyC8xIWoRuU5y+ig2oLBHP0gKdFF0jMe+L0eSWAOAPuVfPA9em4/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722200495; c=relaxed/simple;
	bh=m17yncH3ZPJSTeA1pt4vvn5OQyenyHkuvPrVcdyjTMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmWWTRwYr6Kd1T1z6Ap+62NL5nn65Mo3vSp3l3eutwHACcwlm4I499wsblftE0FCpSxdl7grKpILzWjPVyqYFEw9UM23guzZIxE8ShorqiMrLHQRp7hiLxg3xdBtIs69bYddYdPNhsX8WOTP/n3vEaLz+EkReQRUz8HCTUQhtRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VygX92ex; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52fc4388a64so4664983e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722200492; x=1722805292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hYdIiiGBVvGk8kUk5DIY8kS1X5q82rzPw5nWwBId3k8=;
        b=VygX92exCCarJj83tClSlE1qmnq6r7JZAIsrM8WKXH3+5TIzH9KUxUGwQU/xRDMS3N
         AtdqsD92Hy7M2tfzp1RJObcZQtk1FjXRsceGYWwdEWlpsT6aBmiX7GxnzF46BhIH3yzz
         MF2ljHFyvaZRDqucm4QGeVVCVMWTBGWb636t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722200492; x=1722805292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYdIiiGBVvGk8kUk5DIY8kS1X5q82rzPw5nWwBId3k8=;
        b=RIonoPvSmwQn9SIVd6xkgPHTgeTLVo0vp81f6jTC/LPscsXT6+3GGEvQ92DiaZYedm
         oxq1M5oCzA9anBtoKrPZPG2ixFAOKAFndf6ttrpXWbbmLCFrr2ssc7wu/D/9mswSdezL
         vreXl3A7f79lsZsSLWVq1SlDFwhuctP7E55vC1vckIUJKfXTMjjyaMrnknvgX23hQvdf
         //lz3i+dJnKebu9wN4791wQlyB2Ds9YFLVLZ4bkSj1+u/tNFT9Ddh5/IFsx8K3Tn4adq
         ZRVdROqZ2+90bFTu0+H83lhidAWnZlX4gqDX1x2TSu6h04rV+Ll7O/AdNd6+XE9JUJM/
         YIqA==
X-Gm-Message-State: AOJu0Yw8uoBRjaYl7YMBY5PXdN3c8ny1B/UO0VNHMiHdLcGeY3dWzcD7
	OCzPNPUihAi9RBa/BXWjX2ZV5wWUsu64es7WDJMZOsILvlIFzqACV2Qo467KKhhI9S7HqyHo5tN
	9nPEZEA==
X-Google-Smtp-Source: AGHT+IGO1Vi5ABUUOcDJ+BjOaFRwHYuqevxlG7uFYs9RFiMBeN9DqPkzyzyLuq+NNFeZP138KVjgBQ==
X-Received: by 2002:a05:6512:308d:b0:52f:154:661b with SMTP id 2adb3069b0e04-5309b27053bmr4412443e87.11.1722200491823;
        Sun, 28 Jul 2024 14:01:31 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2cc4csm1238285e87.261.2024.07.28.14.01.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 14:01:30 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f032cb782dso30116771fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 14:01:30 -0700 (PDT)
X-Received: by 2002:a2e:3013:0:b0:2ef:2c20:e061 with SMTP id
 38308e7fff4ca-2f12ee1933amr34604311fa.22.1722200490156; Sun, 28 Jul 2024
 14:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com> <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com> <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com> <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
 <d949045abc78462ab443b38340ce5c20@AcuMS.aculab.com>
In-Reply-To: <d949045abc78462ab443b38340ce5c20@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 28 Jul 2024 14:01:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJCCrErtSbH42mx32kHMrwm2xxpZU-9fAHNJFR30G1rw@mail.gmail.com>
Message-ID: <CAHk-=wjJCCrErtSbH42mx32kHMrwm2xxpZU-9fAHNJFR30G1rw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
To: David Laight <David.Laight@aculab.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jul 2024 at 13:23, David Laight <David.Laight@aculab.com> wrote:
>
> At least you can 'just do it' :-)

I decided to use my powers for good. Or at least goodish.

I went through a lot of 'min_t()' and 'max_t()' users, and I think I
found them all. There's a possibility that some driver that I can't
easily build-test has issues, but I tried to manually check all the
architecture ones, and did an allmodconfig build on arm64 and x86-64.

And by visual inspection I found a 32-bit x86 PAE case. Which makes me
think my visual inspection was not entirely broken.

Anyway, I don't love the timing, since I'm going to cut 6.11-rc1 asap,
but I also don't want to unnecessarily leave this pending for later,
so I just committed the simplifications for min_t/max_t.

Doing the same for min/max (no more C constant expression worries!)
would be very good, but I think that's going to be for later.

                Linus


Return-Path: <linux-kernel+bounces-266641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACAB9403FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98BF1F2249E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA51D268;
	Tue, 30 Jul 2024 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q5xftTyA"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEB8BE5D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722304347; cv=none; b=tsVQmNIzczVh5DA9Nx1lZre32DK8C7AkgZkkTmuQ9ytryaUyeHFXcNBjlT30FGUkX4AIk4/v2PdSWCaJfNQJPrtdBqBzVV/X0D6UsaSviPSc220lQ0mcptL8BetlykPLUOD/ANCiTkhuB7m4tw0GA2FG1gv+9hkl6LUVRDQ+ctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722304347; c=relaxed/simple;
	bh=gf/GDI6z8l6UshEUMugdA1PqOjxDdam6KyY6KT43zFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngePBXAXrMJfPvOC2kZV7TcbAEnw0IRrpwHSjBMjkcO79M+ssqs/99IqCTt/jjOdymJcnvCYJEGfhfcyXmoGdk6NWUcARt7/kCg2BqsfmBLwhcCe576OaMYkfOvq6dsBthXjMoz2H3s7tDMrSbXINnx5fd0ZZBe4Sou8ZTUIwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q5xftTyA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so6261744a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722304343; x=1722909143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iXIPbaTCS5ZLwFvLSTc3lM2kcdvwengf9gnEid7wlG4=;
        b=Q5xftTyAAOt39IhXDNZu6BExVqi3g5OiUKnATG9kCiUPjmXER/sdJsZMrxrPsaecQG
         SEn6TYvUvzgKoTTepcfXLHln/QyGgQkhOw/YiSQV+aDZ2s3dqaKeY/yfJOWqT2WarMTc
         8K9GIlrzBUHWYiFn0+hlCF7EkSBJmmAIQH5hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722304343; x=1722909143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXIPbaTCS5ZLwFvLSTc3lM2kcdvwengf9gnEid7wlG4=;
        b=wIyV6/rH2/ioIvyKjrSHnMZCWTTuHLBHDRNu8fmEsucDnnsdmUw9ZwS6KFHm9PU9kQ
         DAdIAq8kSKrfodFlwTzyJuQdmLfvyYn5UyZHo99C2wj4kaRZmM9gu9Ak/BJ8JfpX0K8V
         XrynlKLzAPGuQo1fUnZnJq69O9tQv5y6MYTPOU47hGMY1jGqU9BWerhD0YXEYBLUNBEP
         IlomSzGYZgC2edthmq41UbL/mQMLLZMEcBiV6cviYkM9G1wl+M/4Rg0qf1PjDNQ8hBQ2
         AwCaHXbPTVBbff2D3InJMqtvIWAZE4Po4KSvLT680IZoUW8tAH6jzAtVC62kon4p6j+8
         XBkA==
X-Forwarded-Encrypted: i=1; AJvYcCXZK3QqRNVvRxMo/ON9SBnAAOpRQQ+4bdTQdsBWBlgOFCDE+pwMpvRazkHmxQI/87oVm/bzpXk5ShAddYclNNE0ElVam6CDzTjvFNxv
X-Gm-Message-State: AOJu0YzcWrTdM+maQl5UA31BY+pB6cR2MKlsJIJN6B7UTzEjyTZmnjuw
	CbRiwEfjkiSM4xSbt1/E85TxYCEFrUukTwkGwbMNc/r+IBfquCgHeDQdWZU2ZTw/gMIf/9wZDBB
	RX09ggQ==
X-Google-Smtp-Source: AGHT+IHUrCt5rA0M5d3lFAUKJNEaiGBOczWhHzqZTHO2hYRE8f/8ccyXs6HZHViweGUZHS9GW37O7A==
X-Received: by 2002:a50:aacf:0:b0:5a8:2f2b:d2c9 with SMTP id 4fb4d7f45d1cf-5b020cba661mr5706278a12.21.1722304343367;
        Mon, 29 Jul 2024 18:52:23 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b033fsm6538378a12.1.2024.07.29.18.52.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 18:52:21 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so6261696a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:52:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnQoUhTcePeaBoKt5PkQtmdzO32pGPIOva1Mr9/5koLiCHfblTpRfZOjyR8tJxJJKjYqrMMKTbCSehNvuvkhj4gZk+J7eQ/1syhkhd
X-Received: by 2002:a50:9318:0:b0:5a1:c43:82ca with SMTP id
 4fb4d7f45d1cf-5b021f0d87bmr4930298a12.26.1722304340583; Mon, 29 Jul 2024
 18:52:20 -0700 (PDT)
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
 <e946e002-8ca8-4a09-a800-d117c89b39d3@app.fastmail.com> <CAHk-=whCvSUpbOawsbj4A6EUT7jO8562FG+vqiLQvW0CBBZZzA@mail.gmail.com>
In-Reply-To: <CAHk-=whCvSUpbOawsbj4A6EUT7jO8562FG+vqiLQvW0CBBZZzA@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 29 Jul 2024 18:52:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiuTQRE6nWbmrhgCQKhA6+L5=y7kcrG0QHpvehasz2osw@mail.gmail.com>
Message-ID: <CAHk-=wiuTQRE6nWbmrhgCQKhA6+L5=y7kcrG0QHpvehasz2osw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
To: Arnd Bergmann <arnd@kernel.org>
Cc: David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 16:21, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> What we actually care about is not "constant", but "no side effects".

Ho humm..

We actually could do something like this:

   #define no_side_effects(x) __builtin_constant_p((x,0))

because __builtin_constant_p() doesn't actually look at just the value
of the expression, but is defined to return 0 even if the value is
constant but the expression has side effects.

So no_side_effects(variable) returns true, but
no_side_effects(variable++) returns false.

Note that this is also why _static_assert() and
__builtin_choose_expr() are generally very dubiously useful. Because
they are limited to a "C constant expression", they fundamentally
cannot take advantage of trivial optimization things, and fall flat on
their face in many real life situations.

In contrast, __builtin_constant_p() works for arbitrary expressions,
and just says "I can easily turn this expression into a constant".

Which makes it much more powerful than the nasty syntactic "C constant
expression" thing that is very limited.

Things like __builtin_choose_expr() are ok with very simple and direct
conditionals like "is this a double", and they have their place, but
in something like min() that by definition takes many different types
- including pointer types - it's been a huge pain.

              Linus


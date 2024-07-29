Return-Path: <linux-kernel+bounces-265095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA0893EC7D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DE31F21CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1583380026;
	Mon, 29 Jul 2024 04:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LfnSNidx"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A272F5A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 04:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722226569; cv=none; b=LRMvdNfqgwWrFRvCZKeGIzp8KTqOptTpYLuH2Arq0AuSEdBPEMqSU7J0Bi/o8OBqzccUvy1hqnBA3M3CBYdwitv7W4QEiqt8g6V7DMywl8FaPDgz9W8943xG9Svc2G6XMtIVrUvVi8Ee3i6PHWe+t7cvDfzlwe7E2F/P9zK7/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722226569; c=relaxed/simple;
	bh=WyfaI8CV+5Tb78ycJrcBES2CK1Jb0ygUkgPWwUfuYlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itHCIsMiLyhr61ne6jVNPtkP0ThfmeS+aE8KUrP1FZeqw6S7IZxQpnO1CLFahUvnYn0q2NYMcvEEwPJrxSGVtgXrrttDclQOAp+ULF+E2RDOWpM99c1gU/xY6aZS15ixr3SFxYdZWnXh1PKRKXVC5dsNitagaF0Z6E+m9B8xjC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LfnSNidx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f04c1e58eso3682120e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722226561; x=1722831361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aPpSoUYQzK4Ugfo0RmMvFIq3EIurRgBU1J1pSRDpYRU=;
        b=LfnSNidx1bBWkZhsGTpVdQOIPchrXAX53pE8b9g8KyQKy3P1SXsa/gCK6txbbsJcXg
         +hxfkO7VpueQuRBYew51V+Qb8aNgQ2OmJfqCYEFnjv/rYqlebEdrJD0KqApUp/K9/ntU
         N9g5Zw4VGr3X9whqgFtXO5ZqmOEPsY5NSUsYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722226561; x=1722831361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPpSoUYQzK4Ugfo0RmMvFIq3EIurRgBU1J1pSRDpYRU=;
        b=kEJIl6CmLRDU3WN9be8GR7yfc0mirEapVnO82J7fR0rleffEjeGrejt3/i4725f60z
         4E2x3qT0f3XebU5DGSu61Hg4hSr8NYnbv+j/pqCmfPz0JKiW3MtfV6Qr0/X5U2s/ZbM8
         idKGXdMIOebzfGK1bfcAeJftM9tEtSAY0bNmUdS/x7lVjf8beOx7cvPxWSlgJg/liC3T
         e5p8wxHdxQaUpbY5fb3YIi5pIBJfuOL/A2XxGSNyTCPnkZGC/JtLWKz2nvMHkR7IktvR
         SX2sr12FbgievZRe5gj6LDqXKbWrVlZ70Kkf9HwZbn2mbNkb/jCKJq4GxpLP8iYKQQ3v
         m/lw==
X-Gm-Message-State: AOJu0YwmOmWskrXvheCs4DHTMPKj70FrHLyro3JfqJr5HL80zDjvvjV8
	oEOi+bX38tLHuKKUX6WWCMqzjgAfnKpi7UZAjWskqg09eBLZdN9/TWFNdanTz4xcU8G6Py5Fznv
	GwJ4D8w==
X-Google-Smtp-Source: AGHT+IHckqiy5qc8oE4wG/eJLgOgAZ0l2Fxx6+ZQLnYSYoOzHPz3swg129LYTUDmzNNfgdq9m66uLA==
X-Received: by 2002:a05:6512:1296:b0:52e:933f:f1fa with SMTP id 2adb3069b0e04-5309b2e0b62mr5331000e87.61.1722226561234;
        Sun, 28 Jul 2024 21:16:01 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab5945esm448761866b.81.2024.07.28.21.15.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 21:15:59 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a1c496335aso2912139a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:15:59 -0700 (PDT)
X-Received: by 2002:a05:6402:354a:b0:5a3:619:949f with SMTP id
 4fb4d7f45d1cf-5b02375e97dmr5500322a12.32.1722226559123; Sun, 28 Jul 2024
 21:15:59 -0700 (PDT)
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
 <d949045abc78462ab443b38340ce5c20@AcuMS.aculab.com> <CAHk-=wjJCCrErtSbH42mx32kHMrwm2xxpZU-9fAHNJFR30G1rw@mail.gmail.com>
In-Reply-To: <CAHk-=wjJCCrErtSbH42mx32kHMrwm2xxpZU-9fAHNJFR30G1rw@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 28 Jul 2024 21:15:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOQ=jrxNmVt5mFYkXSyxPwEmJ6L7Fvh58Z=7soBjb9Yg@mail.gmail.com>
Message-ID: <CAHk-=wgOQ=jrxNmVt5mFYkXSyxPwEmJ6L7Fvh58Z=7soBjb9Yg@mail.gmail.com>
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

On Sun, 28 Jul 2024 at 14:01, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> Doing the same for min/max (no more C constant expression worries!)
> would be very good, but I think that's going to be for later.

Bah. It's like picking at a scab. Later is now. It's out.

I hate how that is_signed_type() isn't a C constant expression for
pointer types. The simplifications get rid of a lot of crap, but sadly
the pointer-induced stuff is still problematic.

Oh well. For that one file, even the partial simplification ended up
shrinking the expansion from 23MB to 1.4MB. It's admittedly a pretty
abnormal case, but still..

           Linus


Return-Path: <linux-kernel+bounces-264852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC5A93E932
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 22:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9331F211ED
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386C5770E1;
	Sun, 28 Jul 2024 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eVqkEUVS"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E4A757FD
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722197643; cv=none; b=Hjjd6cxrbtq5JPTTaUULoFH/oyRNYEKoTYn+BMRnErTih3nlaWtkGp8wT00gEvLNdnwwPUbDYV5JOnSlCyat8r0hPxDS1RpFG8HGWWG/DYAkWLlVzFB3VxnFLJDd0Fr5WM0IC55b3UU3hKse/LhJdlMd0qD5KmmSdVQhglaYz40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722197643; c=relaxed/simple;
	bh=NnQH7QxP2xw0o8Re7ZR0WmSzKIm2/lpki2GUUZDMIV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RM/5AEiq038ABNsZEMM4EExFrVf+CHRhjnNYJ0vs7wJ2uTQ/9fzW9kGDUiZyu6e9VP09HpLtG8v71D1aQ5q1+oWimszVn944igz7lZlrszTMxIwktVP4+BUeVnPFWiq4G/ear+YkFYxWXZCr1MusH0g4BZVZTI1mIhQ+ECppcxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eVqkEUVS; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef2c109eabso36699051fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 13:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722197639; x=1722802439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M1Snvl7BN/K7T+WhjV4Uh5adO9d93A8cd3uOzQBMOH8=;
        b=eVqkEUVSy4YT3EPoCRzPX8Tnwwqoiy3ZjhH5q6g0UXS1HxtV2B7/QzUqJRoZtZk2fu
         nkEvQPUvdd9EEd730PdNnWABN48kPcDtEWaBRAcA+1RA3eJ36TmPlhOByzmrLfWFRRhK
         UIYUPIOUHsOFgUq+GOjz337nqC9u4rfKbEijU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722197639; x=1722802439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1Snvl7BN/K7T+WhjV4Uh5adO9d93A8cd3uOzQBMOH8=;
        b=gVVRaF/Z4UOoKZ3wJES2VYTC9216V1BMrwd93Ls0Y1S1xuSQY2pmr9HFSQo6moUIZ8
         x3f1dEV3pr/zEpe4Q32jTPgXYRuUNuzYl3G2QGwWkW22ny6zU4ZBHscS4Dt43wEL0pvl
         hTm8GtcKt+hdm5KYf1LOEq7fWuOy2khrE9Sm8WPE3um6+471KniUZNMRoB4Py5dwRqLi
         +t+QqR1vM6dAnN/w63AjNxRWg0FuyeWHIEp9MT+ZPFL67fSY+/6FexkMIgpndJlD7Ndc
         RQ4uQ4XnykdTIhpBrwnt+zW3DpcOWUrzTO1CUM4FNIh8YgozqDhJtP74vJBjj40Zqd5i
         AuwA==
X-Gm-Message-State: AOJu0YzvHEmEJZOuIjgHXF7nsfJdBhULbPN0Y6s0y0ubK5tAiG0c5y7O
	U0RleH/yEM/zkgejkVhxd902O0/6BG0cPRx8ggXIqEvQiRIu4Dh1NNyT28YnDXGA748z6i5fAao
	jXvMGqQ==
X-Google-Smtp-Source: AGHT+IGcZEoaG97ZNthkAw7xTqB9yn2D5oFexS+/tGOPqexEoaCHRu3BS5OJeWP576j8E5H2KlxoYQ==
X-Received: by 2002:a2e:3013:0:b0:2f0:32f1:896d with SMTP id 38308e7fff4ca-2f12edd6f6cmr32226921fa.23.1722197639055;
        Sun, 28 Jul 2024 13:13:59 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf30aacsm10758361fa.48.2024.07.28.13.13.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 13:13:57 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f035ae0fe0so33074231fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 13:13:57 -0700 (PDT)
X-Received: by 2002:a2e:b536:0:b0:2ef:564c:a590 with SMTP id
 38308e7fff4ca-2f12edd97e0mr32563421fa.29.1722197637311; Sun, 28 Jul 2024
 13:13:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com> <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com> <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com>
In-Reply-To: <e718056c1999497ebf8726af49475701@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 28 Jul 2024 13:13:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
Message-ID: <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
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

On Sun, 28 Jul 2024 at 13:10, David Laight <David.Laight@aculab.com> wrote:
>
> I think they just need to be MIN_CONST() (without the casts).

I'll just convert the existing cases of min_t/max_t to MIN_T/MAX_T,
which I already added for other reasons anyway.

That makes min_t/max_t not have to care about the nasty special cases
(really just array sizes in these cases, and they all wanted MAX_T).

> But (as you said earlier in the year) that should just be MIN().
> Except there are a few places that is used that need changing first.

Yeah, we should just do this for MIN/MAX too, but that's slightly more
annoying because those names are in use and defined by several
drivers.

Which makes it more of a clean-up.

But I'm inclined to just do that too. Bite the bullet, get rid of the
whole "has to be a C constant expression" pain.

          Linus


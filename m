Return-Path: <linux-kernel+bounces-268324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A67942331
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F275B284FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A343618EFE3;
	Tue, 30 Jul 2024 23:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HJlGMVGl"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25DC18DF62
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722380638; cv=none; b=E0PdtDUWodT+2o0dv4oa2mlxlnMacdyUcFUSzFQdxX5ukiV0otN6PL9/c0BigmOteXv6lcuzqb8q0w63zE4nD9BPPi9L1eCBzTupDLL3QIxCiJGkREW2ngF4BCd0t3wj16cdoDG+fWeCB0VLXtK87S0sQSuzAfRQKqytiw5ROuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722380638; c=relaxed/simple;
	bh=rg4g0iik6v5bQ4EVpSm3SkiVdB6Agkt2OoFHSsXibV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxckUYs6uV/iY6hvzPaUR4/baK+f07vp1EEGwCC2za7GOrAwmCGdd5+bWJ+pXjgBu4ChxVhPte0hoJBFDXep5eUizl+lcj1LjlvAjKCrPVWyTV0UvtiuNDAW6HUoq+Q7pDLEcqSSbFPKmTYmH5yAMsZKNoyHaB8T5CMOnbFhVtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HJlGMVGl; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a167b9df7eso8234342a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722380635; x=1722985435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=98QulGKZlowdI8LQPwLNFOLBD5wJiQYd69148ZBTs3k=;
        b=HJlGMVGl0TMYS8V66BIIPTDlPQAM7vGJxfi1GEtiMtI6JVRxhMiO0Dp43juYkir3xq
         tXE4wsowmDc+kF8Wyq8CzPWUUVUNPAQ6LBfA1gMqKoS1rOIfH++oeT8TIHoKJsuB26FT
         bN8KRAYvXHRIpoArmjJL40tgO12F3DfQEROXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722380635; x=1722985435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98QulGKZlowdI8LQPwLNFOLBD5wJiQYd69148ZBTs3k=;
        b=l20usvKNukGbCW8++zVN+y0X0Si1UFSVpmu+Xqa88Fi5huYZLstYtCQlnW26oqbhKM
         FyrPJh/4hA2vHOxOIEP71aCscT4KzB2Q0oGXWEULqFsRf8BH4ErU6CS7qsTx4+a2HFz7
         L6Vmr/Qjg3/jyuVt0Sa5KNZ0k5DkpwiSZnCExJGZHzTzKL5cc1P71H9bWDtW8BiICZdS
         YvWdI2cFASbGryO57Ti++HeKTKhU6JQ1p3HOcqvpaehEymGgsrXMBzGF+VItHIrwAeWd
         J/jssX6L4CImkFz77xVBJl+zrxKl3JQTqTGE/iTEXL2acZiB4r/R4ShDSmKAOHCCzvS6
         RXFA==
X-Forwarded-Encrypted: i=1; AJvYcCW82razOByyzQncw8vhLeTG41kPMgPCMQxfw5sg4gqG3iYIuvbN0uudgRpGRqgR9Mv0m5exRQbjIL56Iu/TBtRiXvuUTdSxQM1QyVS6
X-Gm-Message-State: AOJu0YzPYScWV21Qu4B10KjWgUYsaOYWr6YozeR1dCaIVd0cUogSva7s
	HR1HRrQWq3J8+shO6/FDh3kU33/2RqiI7PrpImVElRLjoUL6wZUTRCNao0AF690R6BB85nVuu5c
	89H25Ww==
X-Google-Smtp-Source: AGHT+IFqyR6A9yrI0ZRw6g9zGvcGPOtPIvleHMyvxp3xvF4oEB/WcjPGStP9aEyC9zWKeYcGEfEr3Q==
X-Received: by 2002:a50:c050:0:b0:5a0:f39a:b371 with SMTP id 4fb4d7f45d1cf-5b0205d6d81mr7201110a12.10.1722380634794;
        Tue, 30 Jul 2024 16:03:54 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5af959990c9sm6405444a12.47.2024.07.30.16.03.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 16:03:53 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a167b9df7eso8234316a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:03:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULWaYaPhgCvksCmGdkgeWYexNuSz0YGL1YHZ/a57w7FhLqcKRhVPTjG+GdkvAYNXLlIhRsaGLPVa5GelVCcxh6R1IAZ8uLfN8aKhwg
X-Received: by 2002:a50:d55c:0:b0:5af:a605:cd84 with SMTP id
 4fb4d7f45d1cf-5b0221f0b78mr7711590a12.33.1722380632870; Tue, 30 Jul 2024
 16:03:52 -0700 (PDT)
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
 <CAHk-=wgRDupSBzUX_N_Qo_eaYyDfOH=VTihhikN36cGxCc+jvg@mail.gmail.com>
 <f88a19d1-c374-43d1-a905-1e973fb6ce5a@app.fastmail.com> <8111159a-c571-4c71-b731-184af56b5cb1@app.fastmail.com>
 <CAHk-=wgLsFdNert_OfCmRon7Y9+ETnjxkz_UA5mv0=1RB71kww@mail.gmail.com>
 <CAHk-=widciTZs3CCoi7X2+4SnVWrKu1Jv2uOV9+oewXGen7Q9A@mail.gmail.com>
 <73d65e2553e543069f9969ccec4ea9b3@AcuMS.aculab.com> <CAHk-=wgP+Fm=O2tYtS=3fDB7Vh+=rSYCC1mjqxcTQ=024G0qYw@mail.gmail.com>
In-Reply-To: <CAHk-=wgP+Fm=O2tYtS=3fDB7Vh+=rSYCC1mjqxcTQ=024G0qYw@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 30 Jul 2024 16:03:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNTuPVeOSB6bG7YRXeYym9anS2QawRHEKRJe2MQuOPPA@mail.gmail.com>
Message-ID: <CAHk-=whNTuPVeOSB6bG7YRXeYym9anS2QawRHEKRJe2MQuOPPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
To: David Laight <David.Laight@aculab.com>
Cc: Arnd Bergmann <arnd@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 15:44, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> Does this work for you?

It seems to at least build cleanly here, but I'm not claiming it's all
that great.

The nested __cmp() is still rather less than optimal from an expansion
standpoint, but at least it expands only those unique temporaries.

[ Side note: having not looked at a lot of the resulting pre-processed
mess, I'm not convinced it really helps to make those unique names so
long.

  The whole "__UNIQUE_ID_" prefix looks good once, but to some degree
it actually hides the important part, which is the actual prefix and
the unique number.

  But honestly, nobody ever looks at this part normally, so it
probably doesn't matter ]

It might be possible to cut down on that by doing them in series
instead of nested, but I think that would require something like
generating a fourth unique name, and something along the lines of

    __auto_type u4 = __cmp(op, ux, uy); __cmp(op, u4, uz);

as that last line.

And no, I did *not* try that, and there might be something I'm missing.

        Linus


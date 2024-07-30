Return-Path: <linux-kernel+bounces-267997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823FC941F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33148283912
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF594189539;
	Tue, 30 Jul 2024 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QqmNlXnD"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B558B17D8BB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722362587; cv=none; b=AZ37nVqK+CI/N7Xal9S9YJR/3NWlgeOGEmzDK1ln6k+w0wRPVAeJNlD8aQ2O8r3bMHvNvlQZPCN+OSjgNXue572uwjUhj0+67Jjc8oiyaU6Q0qzzsJU4Sjm9dQQrTKb751fwTc7GGib79gbU2Nm78b5VgSYVfLCyiU2jRxBTJhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722362587; c=relaxed/simple;
	bh=i4Dqet1jLnoMxIBZnbCE57uEmtX0iir9WGZD4HSuagU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiOzsXyDhweeidBoP6ihElJv5k0in5Wm0jZpk5JcGGL470U6h8qPv28EL+E9IR2gwlSzSW24BaCIBRYpUT2+Lkq7bP7sWaSAlquhXN3nhJwiDUIGyeur+X/7ba6WX9nri2vWAOz/dkUxfFtYhVqFTT0HWlmXN1VBRUxybksbFc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QqmNlXnD; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efd8807aaso7598512e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722362584; x=1722967384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UjIcoWgZMymHKeItOzctBU0IZctaxNgeUikf+u5SGlA=;
        b=QqmNlXnDdEICUsaqXeL7WMluXuE0mE0HOO4RlkuuhN5vGCQxg3QRyD6diezVA/Qn/m
         QQKeT+8j9RjqwEuJxuPQjN28IA7WX64VxUUX7YVagLSKI9GFbVCZ91cCSPi96ZmOPBB4
         laaeFptzYaFqOF3NR7YZ41HcbK4a9xOcYhLSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722362584; x=1722967384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UjIcoWgZMymHKeItOzctBU0IZctaxNgeUikf+u5SGlA=;
        b=vIfxCw9fs85wapbOXRsROSbFxl96MQwm+KOoUgmiXRPGuSb6W4UGSBmKeNKP5avFVU
         46Js+hwzKlo1Shg1yTeCnxR+RUGaxqtP4TSTEoXJFl0koWNd3Lzs7cyB0+tAodcxtrkX
         2TOXtdyB0C/i8a91knws8shIX/8qLjaxVU/wv25S9Cf58kKqpSZuVcOU2pSdxpz/Xktb
         OR1OC/yEptYv3LmIRiX1NbK/C+1jLsh0uCZi9SoIiVwUY0wCCEki3lioIrUeZLEBJ6IA
         n7KrSaZiUmyTTH6SDM6fGcESpjNghhXbfQu9Yn8VG4rSKZto6ck9V3l6Z7M9wJ1Wht1T
         3Kvw==
X-Forwarded-Encrypted: i=1; AJvYcCVD6e+1yWHk74GLkDNNETvGl8RFnXVqU/tB474grOPmwBdo5Eyf9/w6QRXFRqJk9elAAJbehIYVODdygANA89FDdWEbGpdxIciiD629
X-Gm-Message-State: AOJu0YyXpAtbM9VmJv58lNDX95ZzcRisFise5ND5iWKmV0NPZ2mJUK2K
	OXK6Z0V/vtAg9FgT3vVhDpWgeB0fWvH69sAJstuV9ialg799Gc+tcwTrePyMyaq3vu9wVF0rIlX
	EXHGbBQ==
X-Google-Smtp-Source: AGHT+IGeUduLVi2kdqHU/kilWCG06Sv206lOqKp4IPaaXfgELb/pEjaEUYA0yRTL5ulm/0BbW3QIBQ==
X-Received: by 2002:a05:6512:2c90:b0:52c:8b03:99d6 with SMTP id 2adb3069b0e04-5309b259b94mr8613750e87.6.1722362583615;
        Tue, 30 Jul 2024 11:03:03 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd0d2csm1969835e87.69.2024.07.30.11.03.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 11:03:02 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so59881551fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:03:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYWbLF2Hqd8JXKwwFR0PBS5Fvcyfl6d/kUKTDLrtmzsfanD3/+mDiHL8wNte0OtXcanKVNPd5uT4o6FoPggKjVMWbNXnI9Bb3hyo36
X-Received: by 2002:a05:651c:155:b0:2ef:2575:de11 with SMTP id
 38308e7fff4ca-2f12ee0424fmr69853461fa.15.1722362581295; Tue, 30 Jul 2024
 11:03:01 -0700 (PDT)
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
In-Reply-To: <8111159a-c571-4c71-b731-184af56b5cb1@app.fastmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:02:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLsFdNert_OfCmRon7Y9+ETnjxkz_UA5mv0=1RB71kww@mail.gmail.com>
Message-ID: <CAHk-=wgLsFdNert_OfCmRon7Y9+ETnjxkz_UA5mv0=1RB71kww@mail.gmail.com>
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

On Tue, 30 Jul 2024 at 07:15, Arnd Bergmann <arnd@kernel.org> wrote:
>
> There is another one that I see with gcc-8 randconfigs (arm64):

So I ended up undoing that part of my patch, so it's a non-issue, but
I wanted to figure out what went wrong.

It's actually quite funny.

> net/netfilter/ipvs/ip_vs_conn.c:1498:8: note: in expansion of macro 'clamp'
>  1498 |  max = clamp(max, min, max_avail);

So it turns out that min is seen by the compiler to be constant (8).
And max_avail() uses order_base_2(), which expands to this huge
comparison table for the constant case.

Now, in the end all of those comparisons will go away, but I think
what happens is that because they exist at the source level, the
compiler ends up expanding them, and then - for exactly the same
reason as before - the compiler can find a path in that tree of
conditionals where "max_avail" does indeed end up being a constant
smaller than 8.

The fact that that path is then never taken, and pruned away later,
doesn't help us, and the compiletime_assert happens because in one
intermediate form the compiler had folded the now trivial 'clamp()' of
two constants in with the conditionals that get thrown away, and the
warning happens even when it's not reachable.

Anyway, it does mean that yeah, the much more stupid static_assert()
that will never try to follow any chain of expressions si the way to
go.

For the type checking, this isn't as much of an issue.

The whole "is that a non-negative expression" also uses the same
machinery, but if the expression could be negative in some situation
(that goes away in the end) at worst it just means that the new rules
won't be as relaxed as they could be when the expressions get
sufficiently complicated.

                Linus


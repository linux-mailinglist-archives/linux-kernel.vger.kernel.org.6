Return-Path: <linux-kernel+bounces-269497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79A594337F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB69286C01
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8561B5810;
	Wed, 31 Jul 2024 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RXrLfcy5"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E451B5816
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440323; cv=none; b=r0TshZstLIQ0UzAIWQAdXWSPX3V3oH1aF1tiV7w7abdzxoAkOWxCxKVOmiuEwRe1ct0xp5XGPj4NZ2W9khZOK2QY7mQoGSwrK1mGCWlt6+KVMgRIYi4txHVa0yu+DUcQs0LfsDZRcp6BImj7zooCQclzzsSYZS0j9NbbBzHXm00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440323; c=relaxed/simple;
	bh=FvmMs8DP050nNeG3/2PG6cue5mHmkVhAqrhHnxcfwdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0+ISj1Zu09RUvYyVRg++/HfhGK+85H8VrV+voCoqmpX/MS9/i060WOHfkynJLwSxSM9iF+VhPyT8DlKTaDMyRj11nOWIQjELp+sdCKQ8NBAnOS2dBfQwJT4qzHpXFhguDKrG4JM0kKF236N5ByU4e6JvEDXZoBqsdd7VcDuHP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RXrLfcy5; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso9311286e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722440319; x=1723045119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nqxYY02XSCW5aR/b6Hv6+wQ/epmOGp5dhlBbrSTUONA=;
        b=RXrLfcy5k0jSUiiuTZ7cRjWBnz99V+1GJmvymgTBgMTag6Z9xri7VnsxL9MkgBZZI6
         cVOZQdpIJR+AGawCcuYKzbDi9pPMV1uCo9JR1TgFT/o33vqKFYZZ+gPT/sr5gOcuEAGN
         qW96JBUVEs7GTzBzXvPT+htNfU0gNwC23lmUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722440319; x=1723045119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqxYY02XSCW5aR/b6Hv6+wQ/epmOGp5dhlBbrSTUONA=;
        b=FF3Q/BkMcsdq2pjyG6zkbcvXcZjmJRIcYMA+n8vraaUclrc6XwsvL3ApxOb0+akIlU
         ePpfxRulbNqmBV869gRSz55Ml2I5MX149eb5ZY+aRgQBnmBBk2Wlh+myWC8VMs+mPucx
         SifXINmIOeMXgtBirXwwy7W+RYmnIEifXdr3RjXjyuZ9cfx+IxrRN1t4bXMj8XngGVt9
         m6+/q2d1GnzfRNmIZW06uCjJ6Mqvm23cCZNaeYIJ9/nJ6LlCEkRTytJl3DRge7DyY7/Y
         i4qgB+wqr87+x81VWQ6GeGt6BaWD1soO5ZFerBHOcg+Toxjj1e7mGGNGOLoT1tgiiW7Q
         Q1cg==
X-Forwarded-Encrypted: i=1; AJvYcCXZIpekRjS55bgShXHUDfe9IBPqXuOBYqWuqL/GmSwUjrtHhtb2qKIoyrEf/VwD5VjMvdjsvb7dQpy+AH6458p6hkOfZLbwiuDnOznu
X-Gm-Message-State: AOJu0YzRsBMiDWCYyogPM5BY1Elrt/y5xgao3i5K/6hBMWTAqPPJzuwQ
	MqCF9jUwVG0bpUL2bvKNz6dDZO9beHqqWlKUb2Owtosgf+cE5V5+9yN8EGiq0xvxzAk6G2zEDXL
	WbJ9h3Q==
X-Google-Smtp-Source: AGHT+IHUHRFHyyYjmaS+zHqed7tt0QYpRZa8HtqpcJYg+RPxwdJQ4JKKM4eHTehJCmtRJWZSjjGEsA==
X-Received: by 2002:a05:6512:2c8c:b0:52e:9fe0:bee8 with SMTP id 2adb3069b0e04-5309b269b9dmr10351916e87.8.1722440319072;
        Wed, 31 Jul 2024 08:38:39 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590585sm8820677a12.22.2024.07.31.08.38.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 08:38:38 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a167b9df7eso9445748a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:38:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtGbfSE4lXawvfLnzIIDYVFTzk8Rh+py5SOHL0ZjDFXkri9dlaWbdcf3Oi0q8kdQyAxjR6FPqGf89ahVFy8M9Hc0l2RSqMJrX5trbU
X-Received: by 2002:a05:6402:35d6:b0:59e:686b:1874 with SMTP id
 4fb4d7f45d1cf-5b02000c768mr11557176a12.6.1722440317614; Wed, 31 Jul 2024
 08:38:37 -0700 (PDT)
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
 <CAHk-=whNTuPVeOSB6bG7YRXeYym9anS2QawRHEKRJe2MQuOPPA@mail.gmail.com> <0549691a6a3d4f7a9e77003b70fcf6fe@AcuMS.aculab.com>
In-Reply-To: <0549691a6a3d4f7a9e77003b70fcf6fe@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 31 Jul 2024 08:38:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwrXgtOrr6AKQTSYSG5V820cSsMcUjRhapnoqCh+Ciog@mail.gmail.com>
Message-ID: <CAHk-=whwrXgtOrr6AKQTSYSG5V820cSsMcUjRhapnoqCh+Ciog@mail.gmail.com>
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

On Wed, 31 Jul 2024 at 01:10, David Laight <David.Laight@aculab.com> wrote:
>
> The __UNIQUE_ID_() define just seemed excessive - especially
> since all compiler versions support __COUNTER__.

Yes, we could probably just simplify it.

The thing is, "all compiler versions support __COUNTER__" wasn't
historically true.

We used to have this:

  /* Not-quite-unique ID. */
  #ifndef __UNIQUE_ID
  # define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
  #endif

because __COUNTER__ is such a new-fangled thing and only got
introduced in gcc-4 or something like that.

So that "prefix" literally exists because it literally wasn't unique
enough without it.

And the "__UNIQUE_ID_" thing is probably because that way it was
clearer what was going on when something went wrong.

But together they really end up being a somewhat unreadable mess.

That said, I did end up liking the "prefix" part when looking at
expansions, because it helps show "which" expansion it is (ie "x_123"
and "y_124" were clearer than just some pure counter value that
doesn't have any relationship to the origin at all in the name).

But I did change it to "x_" from "__x", because that way it was
minimal, yet clearly separate from the counter number (ie "x_123" was
better than "__x123").

It was the repeated useless "__UNIQUE_ID_" part of the expansion that
ended up annoying. Not quite annoying enough to change it to just
"___" or something, but I was close.

           Linus


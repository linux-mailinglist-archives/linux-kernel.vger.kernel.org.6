Return-Path: <linux-kernel+bounces-268168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9250C942116
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B49B25C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0432F18CBE6;
	Tue, 30 Jul 2024 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iH1h78YH"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430218991F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369197; cv=none; b=YfTKDp2cwjpq1ILM6nlgS3X/E55hHNzVuMoHTTYFc9p1uMN4mXk0kCWRwzJBwtgCyFx0J/YvBzp9Y+6dvBtm+Qxv1zJjHVpedbjwyT3IzESZwHZipcVbjio6I0xncklApWUkLzu4ibi5Gx/8UI/OXqv2nYqConrX8M/C2oM/DkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369197; c=relaxed/simple;
	bh=oevsQwDj6XVBeWlMUH50bEE/9aNZuedibV28ZLPiWPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbhV33uzK/QGcKEEWnzSjT91R1ngqQfU6qWWq7PBzg6S7m67xXs0iTwo33ElzS4ShPz/1RBhXPR3an75yNjnbdJpcjYIs2kPvuxe6OxnbDkWmER48jifsA53DSi7MTl+FHifA1BCocZfwQfROIbrIFPYoeWdB/15JD7cfQ4G1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iH1h78YH; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef2d582e31so60778201fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722369193; x=1722973993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yFu4HTcE9bWeCuqJQEUkt2GhygASU11Sz6kOZ+oYCII=;
        b=iH1h78YH3u9KRoy6KhQ7ucsmoqa6Sut4RTUtFwW7iD0y8fE/y10+UeTnA5AvvqQj3s
         dQ8OHsNiUYdskWzdjgd2CPKOYG1ZllUfpcdR0nNN08/K+QPet3cNHSN8lYd7/8j72fNq
         MFAVDbPGe9WdJkp3SWPS8nXHVUPZ8vwNnQMCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722369193; x=1722973993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFu4HTcE9bWeCuqJQEUkt2GhygASU11Sz6kOZ+oYCII=;
        b=ThqWVWYc3vTaGCx2AT3p+QFUsMNubwapSrgALxEJ/ZsF+W4x8ZX/BpSQty76HIDCwD
         dPD0ZLbbCsemeRRa7Ad/IFNHTsFiOI8ijLi6QXWVNWFpC9G0/L4vWq6yp/9Sxf+4BExr
         VPA8zKUOGkqJVpdTIbnxdn6aa/V0izaUwpSdqFeysHMK7OmApESZYfV2cAfuJVZF2IQl
         Id6p5VD9IdQUOx2W8ENvYmzvknEnakwSsfKBCSsNMykbnoiqRu4rQp/Xih88xCBPy/id
         M/tgIL3D+00q59Qn4LJo7y84f10Yuk0mX7rkbXRI4hLsK0VendOBqmKu/nLmvaRFWeU7
         JGTA==
X-Forwarded-Encrypted: i=1; AJvYcCXhhrIr7kKRe8xEoAz9+fgyYdYtMPnz6L8nkb+XwsTGKBlN+txfP6c/el9wulrYD5E0YH7z3jFe272Y2S/PmbYZPHHinRdlMQSDny7S
X-Gm-Message-State: AOJu0YzaP80xniNThtEmQNORxb/L5sLzbYGuOC1MTr5P3xEj4ynaLzs0
	yiXfBH1rVh+DkW0IE7V3VZusXRf29XZRuzANq745+0F12n2Bc63CfuyZ5RyC2RBYcD8i4RFgrMC
	SUQxd+Q==
X-Google-Smtp-Source: AGHT+IEMz8r9bQixI46rLakha0AhHgG+Jxotje5q9o6UgMG+Jr7DDOy+m4qvO+Br9smikNjDeB+qsA==
X-Received: by 2002:a2e:b52a:0:b0:2ef:243b:6dce with SMTP id 38308e7fff4ca-2f12edfb5aemr72094911fa.10.1722369192901;
        Tue, 30 Jul 2024 12:53:12 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf326ecsm17516061fa.54.2024.07.30.12.53.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 12:53:11 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f008aa351so7473907e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:53:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLmdh4uWxY+pGiAR3s2C4lW0E9YQMRVAw4RenbPAB23riM6VW18aoOWL95WXYb5HgOR7D/gMeanybn9JA3AWi7X8SytumXf8fn30jl
X-Received: by 2002:a19:ca48:0:b0:52c:e030:144e with SMTP id
 2adb3069b0e04-5309b2bb5c0mr6180087e87.47.1722369191053; Tue, 30 Jul 2024
 12:53:11 -0700 (PDT)
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
In-Reply-To: <CAHk-=wgLsFdNert_OfCmRon7Y9+ETnjxkz_UA5mv0=1RB71kww@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 30 Jul 2024 12:52:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=widciTZs3CCoi7X2+4SnVWrKu1Jv2uOV9+oewXGen7Q9A@mail.gmail.com>
Message-ID: <CAHk-=widciTZs3CCoi7X2+4SnVWrKu1Jv2uOV9+oewXGen7Q9A@mail.gmail.com>
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

On Tue, 30 Jul 2024 at 11:02, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> On Tue, 30 Jul 2024 at 07:15, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > There is another one that I see with gcc-8 randconfigs (arm64):
>
> So I ended up undoing that part of my patch, so it's a non-issue [..]

I pushed out my current one.

It keeps the old semantics wrt the clamp() static_assert, and it
obviously has the "allow small unsigned types to promote to 'int'"
that I already did earlier.

I still suspect we shouldn't do that relaxed integer promotion rule,
but it's what we used to do, and it's easy to get rid of if we decide
to, and it's a separate issue from the whole "make minmax expansion
more reasonable".

              Linus


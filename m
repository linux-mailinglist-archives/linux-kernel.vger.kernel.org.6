Return-Path: <linux-kernel+bounces-267894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1CE9419C3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC031C20CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374B91A6192;
	Tue, 30 Jul 2024 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aM03wjTM"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE2C8BE8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357367; cv=none; b=d1HutJnh3WZUEFg35JiD8cVmKT7DUBDkQlYuxi0XwaSgfiONexAMwlFNfSRYA5kvYEMoXoSYweFdXkHewwcTW5b1Tm6Iev+XMyW7YXChK0Poh3LiSmWxp3YtK+aUlgIUHbJ9JGbjaP5YjYIKbZlqP+S9g4DcaTV5yILE/EOU/bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357367; c=relaxed/simple;
	bh=M71YWmDfwUPDQ/xFbYOO023UBNW5/d3iHZwZLBQ9j2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8+BD3pwSPoE/k+RtVLsTsarhs924P+wfqJcKDvN+GF+3d8sr4Q36Aezw8tZgbz1DdVcPa+6JYeq+uuyad1RwAUyckady8aH9IYfwQiGMAclfp/fAywey3T8wlBEIHJ2W5TrOKeVgzFQ24krfmqu8vzTNSsKeQ+F2jNyBM47nm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aM03wjTM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so7473067a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722357363; x=1722962163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KLHg6Rt8hE2c6f9s+Hk5e7EMcF8gl1hqD8o20b3cA+8=;
        b=aM03wjTMCnALbCzLg1enVlVfUb7lVXzXz9wmi60gRR3BDmCPeyOoVOBH9zceHPZzGM
         k9cPMmqv/s5uCe1iJg02CinZgu3aww+u+ciQfpPY2F9Jc/Pn0r58xjCHNTETBLxD1OtI
         DgY01dgLIImoL1ADctYl25RjPm9H4+V8t7jxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722357363; x=1722962163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLHg6Rt8hE2c6f9s+Hk5e7EMcF8gl1hqD8o20b3cA+8=;
        b=eZ6JFqoy02gdMPFFp2DhA4c4UC4bx6xt+MVpxpjNtKQTXSib4KjsFVVGwDJlj6+b/j
         kE+rSWPdojA0BKQNmAOiSkbxlAB8OXoBlz9luu/dcPQeiNGwJREb5rorrih+p/aBXcIY
         mYB/3zoVJPJEbZuyhrSL7a/ERiIbSOdew34LPN3LSdW2F3UGlOlGaHuPMnxECRujR5uO
         2jVcI7hfL42eOjAVAmeYOpi5ddXJFExfBps38fQI5glHS6WaeIHOBsayDmG435oK6lkW
         tPDtixNuVXRTkOVao7ixOyClecglpmMHFEQvq/V/C8vAzzY+8tCPKcc/OCtQuGFcgVqL
         vO9A==
X-Forwarded-Encrypted: i=1; AJvYcCVCOftRV4KGUkwwy1VdDWxCfvdueyuk3EqUCsmWxOGY+LiAM3yxvflxE382KIvve7o08KUm9JHEtqctgHtXWye2/Li92Ynq08tK3gwx
X-Gm-Message-State: AOJu0Ywg8zsjtbDcsfDGLFQkG1afZMvXjvfzNwZ2ky4rZslJaRrivLEV
	8RceMEl5w1V5daWoQZuxfX5odaiSpsYgVOoyUQAJJYupeYTm++5FGgwEC4dzb5UkoxitEG1YtbV
	kIbWqqA==
X-Google-Smtp-Source: AGHT+IF3jKWJUfCO2NRW+D3BabcPkarXfrMy8zDb7H9DHDGOVL+Buok4ht+fUp/vDYFEUtjruneivw==
X-Received: by 2002:a50:8d58:0:b0:5a3:f5c6:7cd5 with SMTP id 4fb4d7f45d1cf-5b021d21f18mr6415812a12.26.1722357363498;
        Tue, 30 Jul 2024 09:36:03 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b033fsm7472607a12.1.2024.07.30.09.36.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 09:36:02 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so6693681a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:36:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWazetDxQmNS9/+8rSjeQb8uBPfE/Na8UqEb3m/cnIp70+BNtbnfPYnn0N21VYU3frpWQnmMhML4SWlTdQ0QlX5WVXYxhIg8UXfnosW
X-Received: by 2002:a50:d55c:0:b0:57c:78fb:1a32 with SMTP id
 4fb4d7f45d1cf-5b020ba8220mr7207696a12.19.1722357362359; Tue, 30 Jul 2024
 09:36:02 -0700 (PDT)
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
 <CAHk-=wgRDupSBzUX_N_Qo_eaYyDfOH=VTihhikN36cGxCc+jvg@mail.gmail.com> <f88a19d1-c374-43d1-a905-1e973fb6ce5a@app.fastmail.com>
In-Reply-To: <f88a19d1-c374-43d1-a905-1e973fb6ce5a@app.fastmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 30 Jul 2024 09:35:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4ETks+pGUco4gDrRxT+1UBbFGQtpOqSxLSzvVAWpm5w@mail.gmail.com>
Message-ID: <CAHk-=wg4ETks+pGUco4gDrRxT+1UBbFGQtpOqSxLSzvVAWpm5w@mail.gmail.com>
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

On Tue, 30 Jul 2024 at 03:11, Arnd Bergmann <arnd@kernel.org> wrote:
>
> I'm giving this a spin on the randconfig test setup now to see
> if there are some other cases like the bcachefs one. So far I've
> seen one failure, but I can't make sense of it yet:

So the new checks are actually a lot smarter, since unlike the old
ones they don't require a C constant expression, and will find cases
where the compiler can see expressions that turn out statically
optimizable.

This is a great example of that, although "great" in this case is
sadly not what we want:

> drivers/gpu/drm/i915/display/intel_backlight.c: In function 'scale':
> include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_905' declared with attribute error: clamp() low limit source_min greater than high limit source_max
> include/linux/minmax.h:107:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>   107 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),                            \
> drivers/gpu/drm/i915/display/intel_backlight.c:47:22: note: in expansion of macro 'clamp'
>    47 |         source_val = clamp(source_val, source_min, source_max);

So here *locally*, source_min and source_max can't be ordered, but
what I think has happened is that we had that earlier

        WARN_ON(source_min > source_max);

and then gcc sees the "statically_true(ulo > uhi)" test, and will do
CSE on the variables and on the test condition and the conditional,
and basically have turned all of this into

        if (source_min > source_max) {
                WARN(..)
                source_val = clamp(source_val, source_min, source_max);
        } else {
                source_val = clamp(source_val, source_min, source_max);
        }

and now the case with the WARN() will statically obviously be bad.

I don't see the failure, so it clearly depends on some config default,
and I suspect with my allmodconfig build, for example, there is so
much else going on that gcc won't have done the above trivial
conversion.

The old code never saw any of this, because the old code was using the
terminally stupid _static_assert(), and within the much more limited
scope of a "C constant expression", that "source_min < source_max"
could never be true, even if there are code paths where it *is* true.

But here I think we were bitten by excessive cleverness.

> That's still a typo in the 32-bit case, right?
> I've changed
>
>  __builtin_choose_expr(sizeof(ux)>32,1LL,1L))
>
> to check for sizeof(ux)>4 for my testing.

Bah yes. I had that fix locally, and sent the old patch.

            Linus


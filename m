Return-Path: <linux-kernel+bounces-418945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666119D67A3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 06:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D219416133F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 05:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1424515CD78;
	Sat, 23 Nov 2024 05:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ns4roqSj"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFAC23BE
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 05:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732339340; cv=none; b=pIkTbaE0QBZr5J5+nizY+rTU/DrSjVs//LHTaxP5GdbuEOD0tNCmsOJQPu2FKBKQ4GB1cEUKMhizoNzb03EsiVlnE1+U1jW/cbHTITojrCqrxJNMhyeDSz1zovhbU0qOAZLn1Ib6yyHAPLwXFn6LETayBrrbEgbkszzSTCnweRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732339340; c=relaxed/simple;
	bh=7tU5ALD6dT/GscddLn0cfJ213h8MSmkYT/S9vdeLi4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+5CrzIG5pJcbEKubr1qY9nLrIueADKG+Lf5nd1Fv5wqvH9orp+uK7iSJC0QgwGM/QNIQ1QGaWB6Z5YklRIazyEh8NEdmTEJ1opHUE413SUsPV4azgvggx8sBy5wdP7xsamoYpAsbIUyYU1CImjMCbLMn/STX27QjZnNxGjmQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ns4roqSj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d036963a6eso419931a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 21:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732339336; x=1732944136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bz/Cem8L1Zly4fm6PMZZr9K2nmFFTd5Yiu7PpEQWHQQ=;
        b=Ns4roqSj/PgcITPoBIrA7VyIQQAr4f6ACmYvOe3AubSlqNhrXIVkl2YXWFhd5fzanw
         znu1r8R47HU8DR5q1/6xmNu3k2uQLRa9NqeSrok7ni5gJpRc2GE1gdzjwcJooy0adm3O
         ULhyiicjGO/eoHK4zx6NvFYZw2y5r2692PyhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732339336; x=1732944136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bz/Cem8L1Zly4fm6PMZZr9K2nmFFTd5Yiu7PpEQWHQQ=;
        b=EtDsX4j5i5BzW56q10rpBG3usNLExP2VM2lKpKLME+P7pO+hc1UbbzCTa2VHWxGMyn
         vRnXtN+aminu7JHXMRiBUNEZzSviwHHKIWHP35p/ntTSbrs4pkr6daqxbqfZBu2wccvK
         byEGa0zOPtzoe1AFeSjf/l/8dYvOPoj08kcHpiaE46ikEGGjD1wt9kka5utYAl/KiNJ9
         zcDnV0FQrYWFJJ5ObbG4JJqyCX5QM8g6NWEBShAtzXSfuS5FYvQ9ivQcccmqw8j4Hsc9
         S6Cc9QJQ2TXZ1AdLgxGgNUfpUWj/+/FQA8dwcqy2iLDyvzVNYXv+jgyWuV+MRfoBeYMg
         v+Hw==
X-Forwarded-Encrypted: i=1; AJvYcCU6mBME3dKt5TZeEgkdPAc31vaHu6w8UwC4KXFTroy+wSdz2gSdmGXVrWKS/sBYZl7XczgESwFnDaNfg6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/DOyfMZxyWOxycBuIZgs6l4sbVf1jYfxT+WIzFBMdH8oYaWyl
	+eQzwm7gQqKJz/+DuzZgDW4AGg7QQmAlz6J7Ld15s0aj6qHl1sQqylzxldpbRDEfr4DBWompBLf
	202V9YQ==
X-Gm-Gg: ASbGncsoC3okfAXi3ZgNTkw2p/QOEgK3Wwt7a9SHbONFB2sXt1tkt69SpfrSGXYrqSo
	9dOuzzLV6PlXC7tpL//PwBGgXOwOUx+QlHvzMIQ7PMV1wlSvAnFIJhZQWZIkpJXzQ1S72B3rtCp
	LwL4HfeuLxKYzF0RpMZEWNI/kGk9HOMCi2/qwuDBjv2ptXiJ9+DS273YIqPUeFF741Rrp9Ti6Be
	BAJb+CGAsXWO+uoNfvbBd5yduwxx4qQJ3kEmBrCODkTmFiriPuxitm+HZ3oEJFsUyWHifl1Qnk0
	uKofBYEq/pfRAaTX8Rzkfhch
X-Google-Smtp-Source: AGHT+IFft2FHAW23iWf0EWdskjCLxEavkJHXngCyJ8KA3GV2BE+FgdlEfN4+l9tZPj7dqlrLOvhbIg==
X-Received: by 2002:aa7:dcc4:0:b0:5d0:225b:f4fd with SMTP id 4fb4d7f45d1cf-5d0225bf514mr3503541a12.30.1732339336253;
        Fri, 22 Nov 2024 21:22:16 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa539214685sm3923366b.199.2024.11.22.21.22.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 21:22:14 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa520699becso158887066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 21:22:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXY/G5GAB2ca1LkKg/7arR25mm3fuZroHxzg2X50zdr8cqgJf8lgroCI7vbmfOuFaPRoxCKZ9CTTVVIp/E=@vger.kernel.org
X-Received: by 2002:a17:906:18b2:b0:aa5:14a8:f6d9 with SMTP id
 a640c23a62f3a-aa514a8fdacmr332444066b.14.1732339334425; Fri, 22 Nov 2024
 21:22:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122095746.198762-1-amir73il@gmail.com>
In-Reply-To: <20241122095746.198762-1-amir73il@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Nov 2024 21:21:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
Message-ID: <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs updates for 6.13
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 01:57, Amir Goldstein <amir73il@gmail.com> wrote:
>
> - Introduction and use of revert/override_creds_light() helpers, that were
>   suggested by Christian as a mitigation to cache line bouncing and false
>   sharing of fields in overlayfs creator_cred long lived struct cred copy.

So I don't actively hate this, but I do wonder if this shouldn't have
been done differently.

In particular, I suspect *most* users of override_creds() actually
wants this "light" version, because they all already hold a ref to the
cred that they want to use as the override.

We did it that safe way with the extra refcount not because most
people would need it, but it was expected to not be a big deal.

Now you found that it *is* a big deal, and instead of just fixing the
old interface, you create a whole new interface and the mental burden
of having to know the difference between the two.

So may I ask that you look at perhaps just converting the (not very
many) users of the non-light cred override to the "light" version?

Because I suspect you will find that they basically *all* convert. I
wouldn't be surprised if some of them could convert automatically with
a coccinelle script.

Because we actually have several users that have a pattern line

        old_cred = override_creds(override_cred);

        /* override_cred() gets its own ref */
        put_cred(override_cred);

because it *didn't* want the new cred, because it's literally a
temporary cred that already had the single ref it needed, and the code
actually it wants it to go away when it does

        revert_creds(old_cred);

End result: I suspect what it *really* would have wanted is basically
to have 'override_creds()' not do the refcount at all, and at revert
time, it would want "revert_creds()" to return the creds that got
reverted, and then it would just do

        old_cred = override_creds(override_cred);
        ...
        put_cred(revert_creds(old_cred));

instead - which would not change the refcount on 'old_cred' at all at
any time (and does it for the override case only at the end when it
actually wants it free'd).

And the above is very annoyingly *almost* exactly what your "light"
interface does, except your interface is bad too: it doesn't return
the reverted creds.

So then users have to remember the override_creds *and* the old creds,
just to do their own cred refcounting outside of this all.

In other words, what I really dislike about this all is that

 (a) we had a flawed interface

 (b) you added *another* flawed interface for one special case you cared about

 (c) now we have *two* flawed interfaces instead of one better one

Hmm?

                  Linus


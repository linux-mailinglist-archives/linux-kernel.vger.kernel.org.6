Return-Path: <linux-kernel+bounces-350165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8329900BB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD2E1F241B0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA0414B972;
	Fri,  4 Oct 2024 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2BGGZMmN"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D807714A08E
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037178; cv=none; b=PFIuqjzzU55hThz3g9K21jIlMrEtEnBCNTo2wE3fQZD/xM+6asvCSF4FtZkK5y0U9KifrqvmlRUh50keXT1fRD9nJMZEhETzQAz97z8bRRP+Df7j4RIYtcEyLgniRxLJQnRdNvaRgQGEepOABM/4hWYHBtj5UVsRk2JMSusdHaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037178; c=relaxed/simple;
	bh=ABL3wmDqqTNBkhLkQetuoOuvCA417zI/wRviczcrQXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7EYJzjQLKs3V+BkaVLnvQ84yIvYpgC94nLbZe62k0GItX/ipz3JO3ic5TkUcKcD03W5Katj+5qR4tH1vtNJi/saNlfv1iq63xTIa4YKAuBsdYDM5iRu7q1nm5aiRRKrZktoQm88gnz72czVknkPInsiohWY2m1l8nwBGC6zvoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2BGGZMmN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c87ab540b3so5477348a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728037175; x=1728641975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/rcmFBYidoCiljefYKdEWXPO8lL88kIKj0tKbLJLyY=;
        b=2BGGZMmNtp0UofABcZ8f4t6myddTEFkcXdvPqKvJ5LbDJxZcTU7EzRYCdZ5sOE+4I+
         IMUEPioqReuLnOmSGKMQCaYaZ+DAXTzn5lEbglknhfgli4kh3mtfk2w8Ce/rSJ3nfiti
         AS6ganj6A+FpHBiKEmMkxMOktiEgzr4pfFKfxFcwezex8veIOMhxMamuE3UxZReaugtG
         QJGLOg8Z76B0b0r9fTRtzxnjwm+KKaQi/x6qXLaZ4RnfcdMROxJ5YeN6vPm9+w9fPdag
         ObRQJ163M0p0ZS83kgMm0aCKjcdZKP5IqBKqfb+UNXD2CLdFZP8qZaH0PFZXREJrE6aL
         YDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728037175; x=1728641975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/rcmFBYidoCiljefYKdEWXPO8lL88kIKj0tKbLJLyY=;
        b=jGIyEVMeklz9hSnovlPwhhe76nHJtvL61vhyX8/S1jZJIasG43OMfncJMN0Mzibf4x
         nzF/o5saAZLyUTYKWSzSPDAzcMUysh3izxXfOh86QMPNLyk1ST8t6fWGsyzdDpArXDBy
         C/1hVj1OU+oDYthKdRKRu7YC7FNaE9UGvjFcKoT8ZeWZUxTBTW3wWcAD4wxouXNjgGum
         yOGJx0FrxooiEQTaYvfGOusXV7sSYrfGPEfNxEkrza2qMFm/+nCIi1EKgeJhprf+D4u7
         Wwf4KwcuAbgaZNqUPKkfk8N8/WM35YzAFkXyTeyLBtaReSgDBCScBDWMAtYg16fgrr4r
         maFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhfQg4k/HC1lWxwk4uJ6f9NxtGKqpxR2x3Rs4v2d8lEfE9RQ4mlQG3XCJ/pyA7LGIlswMMJImokkYZa5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVFk1QIZzmHf3FkLyX2NJ4CBTR04C2QZxT5Wtodl4XVEEPUDPz
	ilzqsvz7LQQOL1ie499Xi4+mhyAmq/PqWd9QwLFAe9Li5i+tkaScQa04Lyf+tMPUr6axsSsJVxv
	Rg6aafKN0rKLwt4I8Z2kdyM1SLIqPKqwd/mi3
X-Google-Smtp-Source: AGHT+IG2ylqDlHlpj6CludCqdF4jAiPwztB1MV/DHQjdD8kLzIL2saD55CdWhKN78Hfp28hLSalNMkp00XhcQDxqEsc=
X-Received: by 2002:a05:6402:5250:b0:5c5:c444:4e3a with SMTP id
 4fb4d7f45d1cf-5c8d2e5523bmr2145135a12.0.1728037174770; Fri, 04 Oct 2024
 03:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003170151.69445-1-ignat@cloudflare.com> <20241003215038.11611-1-kuniyu@amazon.com>
 <CANn89iKtKOx47OW90f-uUWcuF-kcEZ-WBvuPszc5eoU-aC6Z0w@mail.gmail.com> <CALrw=nEV5KXwU6yyPgHBouF1pDxXBVZA0hMEGY3S6bOE_5U_dg@mail.gmail.com>
In-Reply-To: <CALrw=nEV5KXwU6yyPgHBouF1pDxXBVZA0hMEGY3S6bOE_5U_dg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Oct 2024 12:19:20 +0200
Message-ID: <CANn89i+BNfpKY_qCRLFyGSgtzNeVGuPKudw2nWTF7=r0+P9jUg@mail.gmail.com>
Subject: Re: [PATCH] net: explicitly clear the sk pointer, when pf->create fails
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alibuda@linux.alibaba.com, davem@davemloft.net, 
	kernel-team@cloudflare.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 12:05=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
> On Fri, Oct 4, 2024 at 9:55=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Thu, Oct 3, 2024 at 11:50=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > From: Ignat Korchagin <ignat@cloudflare.com>
> > > Date: Thu,  3 Oct 2024 18:01:51 +0100
> > > > We have recently noticed the exact same KASAN splat as in commit
> > > > 6cd4a78d962b ("net: do not leave a dangling sk pointer, when socket
> > > > creation fails"). The problem is that commit did not fully address =
the
> > > > problem, as some pf->create implementations do not use sk_common_re=
lease
> > > > in their error paths.
> > > >
> > > > For example, we can use the same reproducer as in the above commit,=
 but
> > > > changing ping to arping. arping uses AF_PACKET socket and if packet=
_create
> > > > fails, it will just sk_free the allocated sk object.
> > > >
> > > > While we could chase all the pf->create implementations and make su=
re they
> > > > NULL the freed sk object on error from the socket, we can't guarant=
ee
> > > > future protocols will not make the same mistake.
> > > >
> > > > So it is easier to just explicitly NULL the sk pointer upon return =
from
> > > > pf->create in __sock_create. We do know that pf->create always rele=
ases the
> > > > allocated sk object on error, so if the pointer is not NULL, it is
> > > > definitely dangling.
> > >
> > > Sounds good to me.
> > >
> > > Let's remove the change by 6cd4a78d962b that should be unnecessary
> > > with this patch.
> > >
> >
> > Reviewed-by: Eric Dumazet <edumazet@google.com>
> >
> > Even if not strictly needed we also could fix af_packet to avoid a
> > dangling pointer.
>
> af_packet was just one example - I reviewed every pf->create function
> and there are others. It would not be fair to fix this, but not the
> others, right?

I have not said your patch was not correct, I gave a +2 on it.

In general, leaving pointers to a freed piece of memory (and possibly reuse=
d)
can confuse things like kmemleak.

I have not said _you_ had to review all pf->create() functions.


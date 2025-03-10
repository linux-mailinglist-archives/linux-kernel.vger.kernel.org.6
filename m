Return-Path: <linux-kernel+bounces-554099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC8A592F1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A43C168E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC5D221711;
	Mon, 10 Mar 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ssDbcpOK"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF1B18FDAB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607068; cv=none; b=Nhw9/89ULUzseSbFnKm1M5gUTxbi4nj7AnydoIdvom4d7PuYc1I7zMCXF/FVCUH0geU+Xa1Wp663WRu/Per1azdhcP2DhU02K/is3U5vIpIf88mNJOBuNcA03AjRg36zjBWk4cgXBM83tCQuWVVG4VEZhDn72DC+18v3I6I405o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607068; c=relaxed/simple;
	bh=0IrI9FdaopGtKLOIXX1VUbBx9Fs7ebXPM1YkORinNVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxFDSEKxbKlRK7YfrQYDlaYdiNTHMaw56+YzxIwEjM3AxjgkP+LOeSP/8y0brIXdij1X7vlw9UUw/lIB4+LTTVL8T/v8Tlm6OZ0ea2jk1A5vAfxM3JUvG722zMIDlfRGVcTtfnFpvbWk4z1hzAep/IBgVzk5QTaX4r4iYU5GiwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ssDbcpOK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfe574976so2169205e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 04:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741607065; x=1742211865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IrI9FdaopGtKLOIXX1VUbBx9Fs7ebXPM1YkORinNVg=;
        b=ssDbcpOKw2Svsx5osKAkflwtEvh16vn5iXyIJXZQ3a+pKrhXiy9Nfng5y71PgM32g7
         6fyGLNEgOY4hyXXqvu+K5Y3y1cdU+vQR6AeHyKiJCXrAk25UTYlesg+PijcCya4k7O5/
         PFjgswoosbYnaHd7u7IdrN83BUozlNbgFV/EdvoVDRzYVOzScjPiZARz8VyJoLwz+XtX
         uyyUVN5rGPqn/ZuiN73GwdZ4OoXbwGqE8TrqpFvUWYUDN5GwgiLvNM+C6QlzSuSndE3k
         /GdNrqxmECAXwQd3rohn/Cw/K7RmwPkQcQuj+WmZUun0NXevagXy4AKA45jIx3gIGPm0
         /TJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741607065; x=1742211865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IrI9FdaopGtKLOIXX1VUbBx9Fs7ebXPM1YkORinNVg=;
        b=vzmTXplv5Y87A3FhNmghSSm9naIwYHuu911cyec+NmnzqR3HhDvx+EWmllqFIQU6Rh
         KFqu5dat34vhDUZ5+uRRvxv1OK11mR5O+QvBfAtTp/8Sgp5zPiLbov7Z89Yemt/qZqOk
         xMDEKy8vB/aSAmLW781KJXO3DaQaXciPy2rF9V0AJLySSin2dyl+1aSEJDhjd244NEVp
         UxhSHZhW/p9gKg92G5qOsUNSKDW0qzjX6Rn1uL1vKT75Q7+W0H7pX2/TKtIIIFQszUTg
         /QjevyysbYYh6oQFrWvEmU9jfrE9YdNPSfwK3hoVBoussq1bywXP36uUJ+ihPDKkVUX/
         SFLw==
X-Forwarded-Encrypted: i=1; AJvYcCWLKRg9RqggN7BOaQnqOYPvvbQbPfKsTGgbF7BTS8W0E4Ka2zeHQt21q8G+1iB9J+iOMuAR/6LG2JEb750=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMx+ZwNMiz9EwlRrmOxN02+xQNNffwSA+OQMQEfmuOddeSkaub
	Rq27teReI5veQsPhkoR12mZTHZOqb/JQt0Zh8KjdNRp9DL92276ZsFiFe8+hqVI0xBzJee1fA8/
	3GuGQ9gmOR5vZh+9UBATKfI86mCKcCxtJFfoA
X-Gm-Gg: ASbGncvAijls5197WQC5AxcqLW/v4731PrFumeI1UT3lM7j/9qrIFJ8puBu+H2+oZtn
	ziGTwHmikGESJW4cOZa89cKoJzQQte024+FT6BS7v8Z6uiLcEnSk+Xvpd5xtefmcv/3BQa1hfuX
	zQ61io1N2gjJ+WCh6lTcITTcPN8YWoeKgTm8806myH7+oZtFw2y39jqw==
X-Google-Smtp-Source: AGHT+IE7B1UYHeaXlm+Rs1PUlDtw0KdbyXU2RKfDQAGpxGR6ZJC6Lkc9/sArkb3lz0K5BFbuAd57jS8ndRkY2yPVbGI=
X-Received: by 2002:a05:6000:1849:b0:391:3fd2:610f with SMTP id
 ffacd0b85a97d-3913fd26306mr4676571f8f.13.1741607064635; Mon, 10 Mar 2025
 04:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310073040.423383-1-richard120310@gmail.com>
 <20250310073040.423383-2-richard120310@gmail.com> <Z860iWGtaEFMD2hj@google.com>
 <Z87JpNJU5gxN0YgS@vaxr-BM6660-BM6360>
In-Reply-To: <Z87JpNJU5gxN0YgS@vaxr-BM6660-BM6360>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 10 Mar 2025 12:44:12 +0100
X-Gm-Features: AQ5f1JpNF9ypxpEOLJQP_OHzmzJH77QM5OOCwzuX8EZKFBAaIB9z1lOqXLa0UJA
Message-ID: <CAH5fLgiUj7R4SvKYT3HGxqSDnjs4T6EKB91bX1JFe-a9a=fHsg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] rust: list: Implement normal initializer for ListLinks
To: I Hsin Cheng <richard120310@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, jserv@ccns.ncku.edu.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 12:14=E2=80=AFPM I Hsin Cheng <richard120310@gmail.=
com> wrote:
>
> On Mon, Mar 10, 2025 at 09:44:41AM +0000, Alice Ryhl wrote:
> > On Mon, Mar 10, 2025 at 03:30:39PM +0800, I Hsin Cheng wrote:
> > > Currently ListLinks only supports to create an initializer through
> > > "new()", which will need further initialization because the return ty=
pe
> > > of "new()" is "impl Pininit<Self>". Not even "ListLinksSlefPtr" use t=
he
> > > method to create a new instance of "ListLinks".
> > >
> > > Implement a normal method to create a new instance of type "ListLinks=
".
> > > This may be redundant as long as there exist a convenient and proper =
way
> > > to deal with "ListLinks::new()".
> > >
> > > For now it's introduce for the simplicity of examples in the followin=
g
> > > patches.
> > >
> > > Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> >
> > This change is not good. The ListLinks type has an invariant about when
> > the pointers are null. The existing constructor argues that the
> > invariant is satisfied because pin-init initializers can't be used in a=
n
> > existing Arc. Why is that satisfied here?
> >
> > Alice
>
> Hi Alice,
>
> Thanks for your kindly review. Indeed , I was trying to find a way to
> cope with "ListLinks::new()", wondering if there's any macros like
> "ListLinks::try_pin_init!()" to help us deal with "impl PinInit", so I
> try to send a RFC patch for it.
>
> Sorry I overlooked "commit 52ae96f"[1], it demonstrate a good way to
> handle the basic structure for "List", I'll fix the patch and send a v2
> as soon as possible.
>
> Still I would love to ask why don't we provide "ListLinks::pin_init" or
> "ListLinks::try_pin_init" to support for the pin-init initializer
> returned by "ListLink::new()" ? Maybe there're special reasons behind
> the pin-init initializer here ? I would love to learn if that's
> possible.
>
> I tried "Kbox::pint_init" but it
> wouldn't give variable of type "ListLinks".

Please see the examples from:
https://lore.kernel.org/rust-for-linux/20250210-cursor-between-v7-2-36f0215=
181ed@google.com/

Alice


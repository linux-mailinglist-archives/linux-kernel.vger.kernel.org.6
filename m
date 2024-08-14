Return-Path: <linux-kernel+bounces-286432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF688951AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8595D1F235B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC7E1B1410;
	Wed, 14 Aug 2024 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpUpmfq0"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250081B0123
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638579; cv=none; b=YqneBXZWC5S8O6QotZQewBK1uXuYvqVaaR6dBW87IaAN1cPQweFdXhWSEAORzrVIiRWPDYjfWezw/Ba1c2/TkuvliLGVQZ0ZVuajhtDD83rnGO6JRXdxJmr5OcjZavSSrOTwgxGjonIkw6zcVY/Suu+iqtxdFM5cHvMjsPIRY3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638579; c=relaxed/simple;
	bh=VrU7+CmKVckiMKyZb2WVhNioB0kDz6sNPDPH+MoDmIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qd3TWCO4AgKHdkASAxevfE8qBtpxj3hfeKe7BpCtdR7U76gE8DP5FuNjAftEZ4TlMq+b//DtPtle6sBiEE/C2OsYXTmMvg2dsw9cME013kCvRxgQO5puxuItVLSDtNGXuFnIggjVGzC+PKuNZs/b2F4dzrwFWElTD4uNV/L5MY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vpUpmfq0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso64581475e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 05:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723638576; x=1724243376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf2tkvvyZih6R0nwaVIvzZFNfg/HB3eJ1DSI7qHSEuo=;
        b=vpUpmfq0tF9ig2h82WwsnzHDCS0jrljtFXRwVqD34lC+MCMbNWWLcRGV+LEnTIcOQe
         pT2K7zBB/7LjtDrXtKbpLYq+WamIxPQo1TYwCAB7gm8ej9JBZuyheC5qItuARUOeXbnN
         JNr6ktzbKTsZWui3A8vIHtdoJBjXS1TVLIP59S6ZDEXpERHCUtZ/zUCDL8SsWaCLqQ5b
         Jpi2AFVf9v19zIG6hk4fYS2m5VA272TTqY1wXcp0lgODh6RZ//iPjrpl7EJWDKUPJTO5
         YgS8n//9CGyHs9QWAxw+fJV+dns2Up9yKOdF+0iTvnBiaPYQop18CkUraOSPd7jhqkRz
         4FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723638576; x=1724243376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uf2tkvvyZih6R0nwaVIvzZFNfg/HB3eJ1DSI7qHSEuo=;
        b=u22Y0xNr9IyXYqqVlJOefQ14acHwtwfcdaCIuWg3lD2+QHR2LMr2kKV6htLpat+anU
         5ocZlWOSD15idonfWq1BrNoRXQgek/T9a9bwWN9CFwrKZvtCA+pkYHQJaT17RxzHSW33
         PNxW+pC+um20IUyKoz2XKMI59rBREPTjj4zwibKuGnK+Hhzsyrot0A5V9Wo/X3f/msRw
         q29IvijI4V00LCiqmfJZhf7gDTSHKJiDWXNUblp8Asx5ycl7gW5V96zHGgZ2tWszb7r4
         1Lh4wjdvVAnm0XIUvddsfzrz5VFL+Qwlwo1e/bDuOgr1NYJd9yQaMbX/pUgqw69j8VAw
         k7aA==
X-Forwarded-Encrypted: i=1; AJvYcCVXpZeaMrGYBBruH/pTDzPPtI4RS9jM4qsG9usHR77+rCSlEjaE9waLbxzn8hecE+foddD489j+PTnyxtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzabFY3Xjf7YuPUlRmuthPbvNU77dBo6wcEDFhoUA+UHRfZozP2
	o+Vj3NrnqLGgvJmyfJoZSELmk40RHxfo7edKsQHQR0uZY1TTxrLA11OCLT2L6zKHfecaM3vt2ME
	PH1qRXmWwDpW6tOZY88QdLZKhIW23pxUvD0h+
X-Google-Smtp-Source: AGHT+IE9nY3XVZlrx8o5ajRMuNRQyh6zpuaj6qDiq2GVDhymdwbZCe9WDOdgICrWuBgmkldoDg7QxMKEsOyqXjmPOl0=
X-Received: by 2002:a05:600c:3b88:b0:426:5520:b835 with SMTP id
 5b1f17b1804b1-429dd22f28cmr23055905e9.5.1723638576134; Wed, 14 Aug 2024
 05:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-10-dakr@kernel.org>
 <CAH5fLgiyDtMWKe0db+uvKGPoPRepjiSxddSrBh8jF1N1COpdDg@mail.gmail.com> <Zryhae9OXD_dqfR8@pollux>
In-Reply-To: <Zryhae9OXD_dqfR8@pollux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 14 Aug 2024 14:29:23 +0200
Message-ID: <CAH5fLghWj1zjaoZpxs+9Gf8jZ0Qm_PcK6GUQz9c7=jVbRO2_dA@mail.gmail.com>
Subject: Re: [PATCH v5 09/26] rust: alloc: implement kernel `Box`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 2:22=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Wed, Aug 14, 2024 at 10:26:10AM +0200, Alice Ryhl wrote:
> > On Mon, Aug 12, 2024 at 8:25=E2=80=AFPM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> > > +impl<T, A> From<Box<T, A>> for Pin<Box<T, A>>
> > > +where
> > > +    T: ?Sized,
> > > +    A: Allocator,
> > > +{
> > > +    /// Converts a `Box<T, A>` into a `Pin<Box<T, A>>`. If `T` does =
not implement [`Unpin`], then
> > > +    /// `*b` will be pinned in memory and can't be moved.
> > > +    ///
> > > +    /// See [`Box::into_pin`] for more details.
> > > +    fn from(b: Box<T, A>) -> Self {
> > > +        Box::into_pin(b)
> >
> > I still think it makes more sense to match std and only provide From
> > and not an into_pin, but it's not a blocker.
>
> Yeah, I just kept it since I'm not (yet) entirely sure what to think of t=
he
> `From` and `Into` stuff in some cases.
>
> I don't really like that, depending on the context, it may hide relevant
> details.
>
> In the kernel, no matter how well documented an API is, I think it's rath=
er
> common to look at the code for some implementation details before using i=
t.
>
> Sometimes it might not be super trivial for the "occasional" reader to fi=
gure
> out what's the type of some variable. Calling `into_pin` vs. just `into`
> immediately tells the reader that things need to be pinned from there on.
>
> However, I had no specific example in my mind and I'm also not overly con=
cerned
> to remove `into_pin`, but I want to at least share the reason why I kept =
it in
> the first place.

You can write `Pin::from` to convert the box. I think that reads
reasonably well.

But like I said, not a blocker for me.

Alice


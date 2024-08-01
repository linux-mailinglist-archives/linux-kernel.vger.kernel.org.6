Return-Path: <linux-kernel+bounces-271030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF4D9448A4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864871F26937
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ACC170A2C;
	Thu,  1 Aug 2024 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NgaoTjZD"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C3E16F8EB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505273; cv=none; b=hKGYf5GP19xEOVUt3Zhu58WEAHTYr9aFVog4GFjRnGN2bQLKv4xwoBUyXOsUMUijkuI3qvosoLFDbpuc+iP4pGNsE8xwC512OL3n60WI+P/HQofK+t/JhIDMsTkYWsRuV82apa0b27IZIBGXIahwL8Ny5V12wcRPhTx3/NLLjC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505273; c=relaxed/simple;
	bh=/BLAB4f9eTGSa53jMgdMY4/Br/ckgAGBrPgFlO0KA0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V499LInu6oB4YCZf2I20lLR1RW0AEWvqmll9ZXTx3OzSZHJp1IGkimLnPLLr/7nzgxuIBrOD68YVgRXrZzq9S2YGQLuEV/RKtbHkvWLjathluaBgEQjrk+rKJgtgz85j0pHeeynpQgcVgtVfp1oLy6xVDXJ9V1TMwTEwBgJa/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NgaoTjZD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428035c0bb2so10909265e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722505270; x=1723110070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPveitWmO+N9kxLc1dzekrzbMSrfwutxH91QWfQ7YZs=;
        b=NgaoTjZDSY/ETCdLKrFZDJbefMvbpVH7qjxDleJFrOvZCRc4uDERZsLD7kH65QvnTe
         5sogg6D96dVvku2jkGJR50ve2FKpSjlG5vB4PIWIgq2jn+t0n9BK1xhvjZjbvza+Lrwa
         mdkqvUagQz56CxU3wxME5TqzLTLqlJUL2eQ0amClgiFfmCa40Wz38g/nNRmFIY5y41Qu
         2H5E4QEk/CDq47IyxCTcGEqXndeqlmA/8FLQ5zyeRG+Wm74d0AMbAFoY8MBF3iuwj+yb
         QngroSk0UvPVUV+80s+CaqktYHKRX2xEIks9S7x0SnsAaBIk6lR6JHsRNfeHjkRIF/O1
         KBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722505270; x=1723110070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPveitWmO+N9kxLc1dzekrzbMSrfwutxH91QWfQ7YZs=;
        b=m3aLEUf8PTbclKv9dMaDj/iZO+dmKATUlSCdzEFv6/klsCRxISKc3/shhgKQcVfwPP
         sbYUf0YielDY9RzhsKVU01LDeG3PPPa97c5hvl8xW2e1z8u5yz3Gn//IWw1ihUJklUg7
         qYzSk0rRRJJnyumos2Uxy5BqkjO6iTiG4Fic3/xvGkJlXNAuPBj4s5G9lcWQb3X64YfK
         mwMJUvm6l+l9xFX8rS6zcc6Z1ihVET4337bPOmW1GHTq2LczWVdr+F6nilHQ4Wq0A41T
         OCZJ6AwgMTVSmZ3WzVV6S9eHLLzB5UNxuNd65HIo4Plu+Q+5m3vKKt/PtMUIhrqiOcz7
         P2Kg==
X-Forwarded-Encrypted: i=1; AJvYcCU/IW69cNoC7unxA6u5Oe24ya8rQJNU7IffJ8vvJWy0oyVq96SwTUAz6RWY0coTjjJhdaXhv3vVE3FsCRUFtq75MV7NWewtRQwHRNZd
X-Gm-Message-State: AOJu0YyzHfqpUCSvr1bB5MfgYaTlW67XFqeQq9M0HN8Ve57OXbUjoG1/
	YequcD3yQG/E4IaqfoWQOlsSyoJbeMzgan2Aw+7gukhTe630s6totuAuyTZG/yi4XHAQmflvpLu
	oJCDN2KYZc1i3ZQFOapT54jpVywA6p8dgq1Xw
X-Google-Smtp-Source: AGHT+IHevME7fVU8JPQJHDQK9jpt4f9SROzwQ5aKvKTPVW39ErLfAxPLIwpt/iHyRAOUUmZVH0hc474krn4woZMuhSA=
X-Received: by 2002:a05:600c:3b21:b0:428:6ac:426e with SMTP id
 5b1f17b1804b1-428e4713fe7mr8632005e9.5.1722505269467; Thu, 01 Aug 2024
 02:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
 <20240723-linked-list-v3-6-89db92c7dbf4@google.com> <3e6a37d1-2460-42ce-8bc3-0b210759efa8@proton.me>
In-Reply-To: <3e6a37d1-2460-42ce-8bc3-0b210759efa8@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 11:40:57 +0200
Message-ID: <CAH5fLgjNCXwhUaHh7dxm-5LmFe-TtiizK2cWscSp9bkdknRywQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] rust: list: add List
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, 
	Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 11:11=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 23.07.24 10:22, Alice Ryhl wrote:
> > +    /// Add the provided item to the back of the list.
> > +    pub fn push_back(&mut self, item: ListArc<T, ID>) {
> > +        let raw_item =3D ListArc::into_raw(item);
> > +        // SAFETY:
> > +        // * We just got `raw_item` from a `ListArc`, so it's in an `A=
rc`.
> > +        // * If this requirement is violated, then the previous caller=
 of `prepare_to_insert`
> > +        //   violated the safety requirement that they can't give up o=
wnership of the `ListArc`
> > +        //   until they call `post_remove`.
>
> I don't like this negative phrasing, what about "Since we have ownership
> of the `ListArc`, `post_remove` must have been called after each
> previous call to `prepare_to_insert`."?

I think we just need to argue about the most recent call to
prepare_to_insert but ok.

> > +        // * We own the `ListArc`.
> > +        // * Removing items from this list is always done using `remov=
e_internal_inner`, which
> > +        //   calls `post_remove` before giving up ownership.
> > +        let list_links =3D unsafe { T::prepare_to_insert(raw_item) };
> > +        // SAFETY: We have not yet called `post_remove`, so `list_link=
s` is still valid.
> > +        let item =3D unsafe { ListLinks::fields(list_links) };
> > +
> > +        if self.first.is_null() {
> > +            self.first =3D item;
> > +            // SAFETY: The caller just gave us ownership of these fiel=
ds.
> > +            // INVARIANT: A linked list with one item should be cyclic=
.
> > +            unsafe {
> > +                (*item).next =3D item;
> > +                (*item).prev =3D item;
> > +            }
> > +        } else {
> > +            let next =3D self.first;
> > +            // SAFETY: By the type invariant, this pointer is valid or=
 null. We just checked that
> > +            // it's not null, so it must be valid.
> > +            let prev =3D unsafe { (*next).prev };
> > +            // SAFETY: Pointers in a linked list are never dangling, a=
nd the caller just gave us
> > +            // ownership of the fields on `item`.
> > +            // INVARIANT: This correctly inserts `item` between `prev`=
 and `next`.
> > +            unsafe {
> > +                (*item).next =3D next;
> > +                (*item).prev =3D prev;
> > +                (*prev).next =3D item;
> > +                (*next).prev =3D item;
> > +            }
>
> You have this pattern several times, maybe make a function for this?

It's just two times. I think it's fine.

> > +        if !next.is_null() {
> > +            // This is really a no-op, but this ensures that `item` is=
 a raw pointer that was
> > +            // obtained without going through a pointer->reference->po=
inter conversion rountrip.
> > +            // This ensures that the list is valid under the more rest=
rictive strict provenance
> > +            // ruleset.
> > +            //
> > +            // SAFETY: We just checked that `next` is not null, and it=
's not dangling by the
> > +            // list invariants.
> > +            unsafe {
> > +                debug_assert_eq!(item, (*next).prev);
> > +                item =3D (*next).prev;
> > +            }
>
> How bad do you reckon is this for performance?

I don't think it's a problem at all.

Alice


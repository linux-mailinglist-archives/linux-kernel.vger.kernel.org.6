Return-Path: <linux-kernel+bounces-547127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C38A50340
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 079B37A74C8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674F924EF9E;
	Wed,  5 Mar 2025 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2X6tnJO"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6738635D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187665; cv=none; b=qIrAMTLercrNlHlRVOWHcjqvunB0tIZ00gj3mSIddHUOsX2CG59w4IYvxEKZ0UD08sPOTcrWU0Fy5dl8QUFghYSJL0x/bu4xPyoHjE18XVEET6OfMlp96OiqUlGIanoIb0JH/IcL9k6DTLaFWmH23gqVenzvDT80ci7rDHuptgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187665; c=relaxed/simple;
	bh=u+MmNU5cYsqecXTGaOd49fcR+qNB9ijTR8fhCcnqgkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8EAi86DsoEwK9Yk6modxU6U4yqdUa2jal+MVPzfQSbGyLTITm+m0QrYO3hoxxZbqjS+wXRQQaJD4R3Zkgsogl/ruZUIiGHDYurk3lDYrlXx4i5AnIkHwH8xtoc11aYBJZALL2lL+xRp8XMPp97TUdwAtBTC+52HMdhpuDDongc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2X6tnJO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390effd3e85so5417036f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741187662; x=1741792462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USPDd1qR6qH3mxfI/NByy4u8tquEDn6DJ2yFUkVbl7k=;
        b=q2X6tnJO5pNJ2I5WU+na7HCs79D92reFfLyhqnTIGN0dpF2iyWh1kQLoL8EdqzxZW2
         kqumBeQExVV53bflOOlO+HQiSfiKfyg2RslSPlmb99B1UbAS4ZtJa2CDE988uCiy9lSx
         ek2ELzFWClHGGEkMrUhxiakvErTqgJ6QOdY+dOEpv3EZmvxrlFDuKXq1pVRZpMssIcXY
         EQ3xrCllP2snNl8yydVQKujAihjzLsOxQPayu0B6enpbCqS3B8JwDwUt4mtJwKVC8GQ4
         Rn0GAlis351PYme4BwIV14e0iRDHPgXu+593vRb2M8k9rLiSOBjGpuXNuWWtMHME6G/4
         WGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741187662; x=1741792462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USPDd1qR6qH3mxfI/NByy4u8tquEDn6DJ2yFUkVbl7k=;
        b=nz+PM4GCYnpV7Jqc6ZOHhiN+y0YyLiXztft6/HYgUFlgw6yF08496w9a77uIxuupnn
         UgfnlQrUGXiWEfAYwU99VWkH7VFIz0JLh7Mi36NSjuK99Ie9SMXktjXTOo298aDq90Fo
         8DjkHq8t98C1tpFNfiFPxAldPQZeRpy4m7PoGPNR4jPaZs9bNaBwK0LwGXUrxpCLwnyM
         3yyhSQ1BTTZFxPlP+917eNdmKUONcYuZ0WMD6WCOBfqCImV3iZXSr1kdgFuUSggjsgbW
         3tIdavgcfjU2z2FLeS9R/e7V7Lhs3nB5xe7gMpo0N+LpSHgFzpyQOwRsTCZMq8Rub44S
         NC2A==
X-Forwarded-Encrypted: i=1; AJvYcCUEYbMQFZwf323o6ZUtPZaZLUwQw0Je9nYYChWDwGTaqEXKirC/n8Tj9LoshGvrflE0cyLGyJmrTwQL6xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiA8BXLN4R/4oYvEMc/VeCHMqz+WvOOTWL0VANE6qAQ39dGOKN
	zwDsNfnU/4xlwPQ+ORzP13zY+IqyLty9DOgq6B6CPJoWtFgYhGbv+z92lesqzxB9dSd7CTrW93e
	cWB2tIW3Kvv77ZcySSrYlGwy6NZGJ7ggjQ3E6
X-Gm-Gg: ASbGnctKFAg3KWdbMMWNq44rOq2KvzFRO4m20yfwTfvVuMbQPSW98S6uOk01bd/Kd0m
	n/PDStAMyCVUzEnOchUbXsbRlYx7MIV+yks0iK/8ZpdaDHAK/A1tt9X7lUgW1v2hBud2LFwP8Oy
	bBflK2yRFyCqtTmBX2JKX+lBMsyxFfWIaw9umAyn7sYLVqG+Lfblv23NYo
X-Google-Smtp-Source: AGHT+IFqCXmZxfeWdf6AUeawOXjP06fV+krKTSUdJEOiVcttMtOIN51sUxb5euhwgZAPfdDxI7qE9nMbSSez3B280Go=
X-Received: by 2002:a5d:5f42:0:b0:390:df83:1f5d with SMTP id
 ffacd0b85a97d-3911f7a84fdmr3713711f8f.35.1741187662149; Wed, 05 Mar 2025
 07:14:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305-unique-ref-v4-1-a8fdef7b1c2c@pm.me> <Z8hUIPtE_9P60fAf@google.com>
 <Z8hmCkeZGPwc5MuU@mango>
In-Reply-To: <Z8hmCkeZGPwc5MuU@mango>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 5 Mar 2025 16:13:59 +0100
X-Gm-Features: AQ5f1JrBXGxw1rKdzyIsN_nlrdaRKvKhTO3oHwvMg3FPvBcmlxl8QNPV-S8hcws
Message-ID: <CAH5fLgjFBknTmhxQBPUdB-iNMjEkcyuLiu22-Nj-DGB1Gb7NkA@mail.gmail.com>
Subject: Re: [PATCH v4] rust: adding UniqueRefCounted and UniqueRef types
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 3:56=E2=80=AFPM Oliver Mangold <oliver.mangold@pm.me=
> wrote:
>
> Hi Alice,
>
> On 250305 1339, Alice Ryhl wrote:
> > On Wed, Mar 05, 2025 at 11:31:44AM +0000, Oliver Mangold wrote:
> >
> > > +impl<T: UniqueRefCounted> Deref for UniqueRef<T> {
> > > +    type Target =3D T;
> > > +
> > > +    fn deref(&self) -> &Self::Target {
> > > +        // SAFETY: The type invariants guarantee that the object is =
valid.
> > > +        unsafe { self.ptr.as_ref() }
> > > +    }
> > > +}
> >
> > What stops people from doing this?
> >
> > let my_unique: UniqueRef<T> =3D ...;
> > let my_ref: &T =3D &*my_unique;
> > let my_shared: ARef<T> =3D ARef::from(my_ref);
> >
> > Now it is no longer unique.
> >
> Oh, indeed. That's a serious problem. I see 2 options to deal with that:
>
> 1. remove ARef::From<&T>
>
> I checked the users of this, and it looks to me like there is rather
> a limited number and they are easy to fix by replacing the &T with ARef<T=
>.
> But I assume that wouldn't be welcome as it is intrusive nonetheless
> and of course there is ergonomic value in having the function around.

Definitely not an option. There are many users of this function that
are in the process of being upstreamed. The ability to go &T ->
ARef<T> is pretty fundamental for ARef.

> 2. add some new traits so implementers can opt in/out of that function.
>
> Basically one would have to pick if one wants to ARef::From<&T> or
> UniqueRef<T> for one's type.

I do think that you essentially need two structs to use this at all -
one for the shared and one for the unique case. Sounds pretty
unergonomic.

What is the use-case for these abstractions?

Alice


Return-Path: <linux-kernel+bounces-267983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBDE941F02
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072072823A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C511F189906;
	Tue, 30 Jul 2024 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AMMiqV+S"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAC016A949
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722361817; cv=none; b=sPl6ckeOCiA+OHtkW2+5xTz/evx0TtTHr46cEgC8l706Rrzki5/wgT044E+hb1wx5wwAqGvf9I5nFLlXGPG3Y6RmpCiPC1LSdrnaasKjBaiMQ43shVtlg9jmMg8jxYjwfJ02oAyj7FRY9+cs7L1RHvChFDIaLTj0cJyYsD3tnY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722361817; c=relaxed/simple;
	bh=HnW2Kl+zYUctRJgaoTxa4ZKiXQis0V3yPPsOxmHpVRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fC6Rjt/PZd27qmEDD7/hTMKldNLRNP0wP509VGTiBEaZmfT9vAsLDZSUtJfk35SFPooYDiEFLX0jGUo/TD1+HnYvEQ2gDI4B0ZrfQ9fbbycpxc+vWgbF69A2h1ce/QmrcM+2B3d0QwCCG9X28QXf+EiAb13p36pOMI1MHfkxrIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AMMiqV+S; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3684eb5be64so2525919f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722361814; x=1722966614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaixBjhs4jCi/zylYr7SZw+axaxCC0UI+AlndDH5c6A=;
        b=AMMiqV+Sgl32yCRor+OgrAmc+re5HKEba6j7OvBY5hCWl6+LKcmBYoaDIeQpvO75Ci
         eN65SUCLyk9jsdNWD5Tm2mAIIASPsIYmPtqfXXAt1rRP2JwdeoMhcHatEBfDrULHG3bd
         iFrlZPkflDXTWBYXXLiBv9LWrdAO38Uiivqu7stLCtibKnuji8qDPtZM5J0nNvkD+cKh
         4nGe+cdZ9diHV6HbsbAn6Y5/5Uur8W5x7XzzvQbJEJDCJBXDq8JOBUAlJMXmITR0Cjka
         mtZzWS+kGgcpGkAfcb2g3EtTa2qYJBD67+D8iySqBtYBdkqUMwZn7GeXF3WoAYUUQBTC
         XLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722361814; x=1722966614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaixBjhs4jCi/zylYr7SZw+axaxCC0UI+AlndDH5c6A=;
        b=YUsbbzHZMIU5yD/MkgDykLrhHcgycrvHPQqK1sV6XLLW/aGS/brzNxdklEPbtE40ar
         siJeB0XgK3+oYeIFf//1NYScOqi+Xo+dmUbFf5lo1bUNixBdoyvICAJss3ObIzaFQZhL
         lE5t3nfR/WvDNjPGwDm2muxT7Dceb18gyGmiQ17ZEN0XefV+670oiXKujsHGklTV3AeA
         qLZ8M/JVcCVBpb5YtZpESLau5G/3E5GeAkFOcTPckgmjtDwJoi7Ql06YLbQljBIcjRuW
         bezwibi+SD7DOrEXdZamnDDIb2uuGAhevqN6tBKEfVcOqSv+7J1xwX9qqSbKB46WMqHL
         gcWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW69PSDCkR+WWBJ72JlFUq/SLBKOkQnInUTFfulbik6GCoRjAf4U+iIf/uFHPLEvULf0oxK2RJ/RSrpCefWcrc9WpSuexn3UuxTrn20
X-Gm-Message-State: AOJu0Yzd5iHGlxne+dMV+DOijhTQU+MoMU5i7fAzPlUKV8gtWMGgTg9d
	kGtsGAqt5w/NJJXn7pZ4bqM9UwM6ppvqBNbH9rWIQmIZkOgOMsJqGufo1ibXnqSBmNM6QGS5TSC
	DS20MvcVU19jCAEvQgW24SrA0PsgrjN6SBJga
X-Google-Smtp-Source: AGHT+IE/WqXVNH2NYL9VIjihSbVxG8lSSeijhgIZzc3e3qo0pbHOQ5rnbbgjDeHIZgABFJ/sv4CQsz8A/6GYxBxhxzU=
X-Received: by 2002:adf:ec45:0:b0:368:5a32:f5bc with SMTP id
 ffacd0b85a97d-36b5d08a846mr7272588f8f.38.1722361813353; Tue, 30 Jul 2024
 10:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-foreign-ownable-pin-box-v1-1-b1d70cdae541@google.com> <5c49f604-34c1-414f-bf9a-92837c6e07b3@proton.me>
In-Reply-To: <5c49f604-34c1-414f-bf9a-92837c6e07b3@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 30 Jul 2024 19:50:01 +0200
Message-ID: <CAH5fLghN8L4cJsRuH-eqU4E5GaTJRUhw0cAStjHAj1RNJA-vhg@mail.gmail.com>
Subject: Re: [PATCH] rust: implement ForeignOwnable for Pin<Box<T>>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 7:14=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 30.07.24 15:06, Alice Ryhl wrote:
> > @@ -89,6 +90,32 @@ unsafe fn from_foreign(ptr: *const core::ffi::c_void=
) -> Self {
> >      }
> >  }
> >
> > +impl<T: 'static> ForeignOwnable for Pin<Box<T>> {
> > +    type Borrowed<'a> =3D Pin<&'a T>;
> > +
> > +    fn into_foreign(self) -> *const core::ffi::c_void {
> > +        // SAFETY: We are still treating the box as pinned.
>
> I don't think that we have the guarantee that the pointee at the pointer
> that is returned by `into_foreign` is not moved.

That doesn't seem like the kind of thing we need a guarantee for.
Rather, unless we give anyone a guarantee that dereferencing it is
okay, it seems reasonable to assume that it won't be dereferenced.
Right now, it's just an opaque pointer, so C really shouldn't be
touching it. We already implement the trait for Arc which is also
pinned and also doesn't even point at a value of type T.

> AFAIU `ForeignOwnable` is used to store these pointers in C structures
> and never to actually access the value behind the returned pointer. So
> we could add the requirement to `into_foreign` (thus making it `unsafe`)
> that the pointer should not be dereferenced/used aside from `borrow` and
> `from_foreign`. Otherwise I don't see how the call below can be OK.
> What do you think?

Dereferencing the void pointer is unsafe in itself, so I don't see why
`into_foreign` has to be unsafe too.

Alice


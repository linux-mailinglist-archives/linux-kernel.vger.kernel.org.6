Return-Path: <linux-kernel+bounces-271235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9B5944B64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DB2B25052
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04881A0704;
	Thu,  1 Aug 2024 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D2eX01At"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C471A01D5
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515614; cv=none; b=A/ohD3G9DKi8tVJOCfJUBslSGOMXl0CqdXm1e1RqA0WaBF5RUaK6G16eROOe2G2V7svGgVVH7dkaxqotznjcRn6MT+KDtK5j+dJiuixllrGttaYbmjtryJK548AJDrrW7ORotBllakKRtDdCQqmbSLtFlJUZr1tdVSnKApaEjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515614; c=relaxed/simple;
	bh=6xY5STH7eWH9a4U8sSqLcDaevZ8D3eDsy02tRk6YEVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9b/EsMsvxGZ7SP9QHGERueoLZmVXeNtgDYG7WIRUlJr/vpIgr2nfZ9KwIQHLNYUuklxdp4fOUtMgGP9GVmbOYoFwCPnM8cChCIJjl+BRSiTh+CrwDyTQq+0gZY7+KqtQaYRItACae7/MDw66LQaOnVEO5xEnqi3MTTprRxS998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D2eX01At; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52fc14d6689so7319824e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 05:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722515611; x=1723120411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8m23gCfGpYyuhlXZdyZEdOK2nVX60DO5EEWoQsvedo=;
        b=D2eX01AtU1REBAQhbY03IrGs47qwSVSrs1yK0dXyoUEF3vDobC7tNjJr38lk79sT+J
         hJzrfgXr2D32fbbwdBdoxEC7YgolHiwP3jsgx17SMo3Jj0Z227zEmTGBZt1DzNJHGqgy
         WF4ME/TZmmuQhqA1JYcCxk85KmVQLHlTCcOHK3JCfLsTluUZmG9qZRD7VHayxTR/U+n4
         Gq7+aCJsdBiemom4pEtc5pBRfa+2j8ACR9eIkwjpGBEKAyFFjrCkLPGfuenwGrH3U0XF
         aT+1b2qc/njx8Uee24CBkVoi7+tTuQ7YxcfUlnF3Hi6G2nqVNem03SwxrMxdKeTRY0WJ
         OXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722515611; x=1723120411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8m23gCfGpYyuhlXZdyZEdOK2nVX60DO5EEWoQsvedo=;
        b=trH+Z4N2MchwDu0tBjeUhc1jDzP4tLN9gtq+sqCVt+fmcbMjIuUu8OawUUPEIvL3Aa
         KAUC7+r8cFICkQXhzdjTkSJ8Lh8TpumilOT+ZLFm5t5N+cRuOsQ7ihmsL+mSmajITSGA
         3SDn6OaTFnzHjxw+G88aHYI1BodMuDsC4RltQsh/gwnekoOdupqQOsWqFolmEf3atVTe
         14Cji823T2K62OXbBmxPal1mPJ81Kkmd8p3a6u7FSPfzkFggtL57HGNLS3/k7TY8IjYr
         DOfIucJfdFjgrYuPCSk3lugsI8ogPK+cmeKWaz0Uoj3gnpjVR/IWM6HSfWh0LEO0vJ8W
         zDLg==
X-Forwarded-Encrypted: i=1; AJvYcCUFjFbj+QKZQrUCcRnwKKNtdvlyV2Sgq4OO24SdwMUKNOtOc3JGomwF4i6XD6x3oBAih6F2x6LCa2NYxDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0jsZdcaGMza8+HnkXYZwYQ90J3ilRi5oxiC+ka0QsuxqbJXl
	q3NAY2KhwmlK7KhES5ZMTtWmUqTEYHWkL6+C2ENhZOyyeQ6grsNlXrhHZICyNY2a9Qi6R/yEiCx
	blyMvt39iTFL5vwoiVyHR247rKtWj8LWjpNP9
X-Google-Smtp-Source: AGHT+IEui3NccP3Nyd1+5eWJDMqRcmvKlbT4XKAqqlJpBpTH5c9HdHNpFLDJj6IvKL85z0QegnQzET6zAtpfyQH26rU=
X-Received: by 2002:a19:9147:0:b0:52c:a0b8:4dc0 with SMTP id
 2adb3069b0e04-530b61b7e97mr1267800e87.28.1722515610268; Thu, 01 Aug 2024
 05:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
 <20240723-linked-list-v3-9-89db92c7dbf4@google.com> <2b548226-e323-466d-9f6d-762f6cbb5474@proton.me>
 <CAH5fLghkPgj560a2b_1oRnvuurEugT4TNj+o-fYhGsuSGpywPg@mail.gmail.com> <4af5a8fa-c27c-4ee5-9d2f-67a46bd34635@proton.me>
In-Reply-To: <4af5a8fa-c27c-4ee5-9d2f-67a46bd34635@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 14:33:17 +0200
Message-ID: <CAH5fLghdOYt-an=Scic4g4tYvU8WMdvwqt4nHP0j8QybaPPp6w@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] rust: list: support heterogeneous lists
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

On Thu, Aug 1, 2024 at 12:50=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 01.08.24 11:38, Alice Ryhl wrote:
> > On Thu, Aug 1, 2024 at 11:24=E2=80=AFAM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> On 23.07.24 10:22, Alice Ryhl wrote:
> >>> @@ -181,6 +185,47 @@ unsafe fn from_fields(me: *mut ListLinksFields) =
-> *mut Self {
> >>>      }
> >>>  }
> >>>
> >>> +/// Similar to [`ListLinks`], but also contains a pointer to the ful=
l value.
> >>> +///
> >>> +/// This type can be used instead of [`ListLinks`] to support lists =
with trait objects.
> >>> +#[repr(C)]
> >>> +pub struct ListLinksSelfPtr<T: ?Sized, const ID: u64 =3D 0> {
> >>> +    /// The `ListLinks` field inside this value.
> >>> +    ///
> >>> +    /// This is public so that it can be used with `impl_has_list_li=
nks!`.
> >>> +    pub inner: ListLinks<ID>,
> >>> +    self_ptr: UnsafeCell<MaybeUninit<*const T>>,
> >>
> >> Why do you need `MaybeUninit`?
> >
> > Right now the constructor initializes it to MaybeUninit::zeroed().
> > What would you initialize it to without MaybeUninit? Remember that the
> > vtable pointer in a fat pointer has strict validity requirements.
>
> Oh... I forgot about that, can you add a comment about that? Also why
> not use `Opaque` in that case then?

It used to just be UnsafeCell, but then I tried it in miri and found
out about the issue and added MaybeUninit. But I can make it use
Opaque instead.

Alice


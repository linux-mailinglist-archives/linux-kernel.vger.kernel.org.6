Return-Path: <linux-kernel+bounces-375019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC0A9A8FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032081F21ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E51FBC8D;
	Mon, 21 Oct 2024 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ck6gbZT9"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7271EEE0
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538829; cv=none; b=tyS6bvcLl8Vh4o9SAmwCqFdKQsr/KS5lNrkz8uYtFp92S5kokGElZrYpPKmlWNd9mtjREK9VyZ82BH00LhovaxoOQ06TGNRRqGt3qRAV4Av2cWg8Z9OcDDaXIWzotEL3vZp9k6sDlhxNityhAKesVkHYDcnU9hR0S72ZI0wEA8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538829; c=relaxed/simple;
	bh=BVoOVku44aTl9bVy35c2nUYZcFuN1B+ec5SFemyGpSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzB6hlcsTlQ3N0oiDFaabA3HHElqnaN+D+KK4KPpBAje1+YtYEQGKRpbebUjQtiw/yd+uwpHGRo99RmhOMn4i/oUDtAPBV8cmQ7OVRZRNn0yVxLNjI3xzzszKVNPV93EorM0iu8jZAd28kgAGSMychmWBnZS4U9RXXwCGCN7rw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ck6gbZT9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d5689eea8so3246167f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729538825; x=1730143625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G06bZX4NZYaGTrzKEnb+wzgfWTRjPnCRzAr7/SDwOJg=;
        b=Ck6gbZT9kfn78MxvXol/aFBT45kRypP2IahvRwYASDpvG4Li3n6rfyteQUAiHFTUdq
         kFFVYfZy873Y1Ga5vkI9YM3w5nq/flWjVG7lYrIDtN2OFCQmPQhZAdFUle+esDFfn+ve
         NTvZPAoLFxaVs4b5RJUgaI/0fZjrNc5S+oDKl2al7SrLajiTHl/uxXtFnNrTwiKrrJdN
         rnQqpWxGw5wYDCengUyirf27Rx2OU6BsWvYHz6goMN1ye02W4QC1YjD4l0vu+oFUrInL
         lPQMQw53+7cfmEJHCEKEkl5RlHph3CfdIMNT918C8XlwOOAmv7WA7kzLE7LGu5HXWeRy
         Q1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729538825; x=1730143625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G06bZX4NZYaGTrzKEnb+wzgfWTRjPnCRzAr7/SDwOJg=;
        b=l+cE7ZTqGujjAVqYqycT12EzNG2BIT6fZ0tX3mbGaZN87rRToh8qc/aL65V1B8UEXR
         Gc543cXOH54DO1XulSSKjwWu4p0d6NAe68NDpBloNGfSNrNwWCG91R+jqNwirkqlhMyX
         7/v/CIfRnlphBJOQ/iSlQ5D7Y4ovO+fQdUIxNPIJHN+o4/fLU8wH+8s656SYB8csynWz
         vrWH0TUOmkskHxQfNKn4gYg2K+D9uQ6DXOtNoIhhOsJO6/8hiFuVYQJvQJ+RgESmInKJ
         1zkf1HaVm27Sqq/Rtd11QxWOUB1MFoJltHRdKKpVmcrtdS8T0qb+zrwdOjtmGEuyVoP2
         Zjrg==
X-Forwarded-Encrypted: i=1; AJvYcCXSsD0iacc42rw0nf7A0EW6jgrH3fFWB0vG4cKQ5CYkCsnATpSZ4zDgrKu1UwNzerBJQy/nZ/3i7PKMHvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDa64/Jdl1Zqzra3kV3MYbVUbi3q1NZO9sFC0qlHzmSReP0Bt8
	AmT6+zU5TV5rO/mL1cT18GuFm3JJzYSwOPh/gSyWh9celUBBBnx5Tl+zTd74+QbF+yPMHkGh5fO
	jdcmf4oK8ojrfjyrXoh9SYBoixeePPqtaK56c
X-Google-Smtp-Source: AGHT+IFjCfQpZXB5FfyR7n4mNoSlSW2stfPEZ5HGjgY7Qm6kIHo4Oefe2PJHKlWsVvPnmJG7vYibttMDHPYnP+AWtyg=
X-Received: by 2002:a5d:6e56:0:b0:37d:4aa5:eae5 with SMTP id
 ffacd0b85a97d-37eb48a0ea5mr7193856f8f.55.1729538825298; Mon, 21 Oct 2024
 12:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-page-align-v2-1-e0afe85fc4b4@google.com>
 <81e9b289-b95c-4671-b442-1a0ac3dae466@nvidia.com> <CANiq72mW8seB=938XZM7bwdSU43z0eePXinE5QPYyybvNfbUeA@mail.gmail.com>
 <dc5e7653-8d6d-4822-9c29-702ece830717@nvidia.com> <CANiq72kuQ-fNTYw33czgN3_DYjixzk01+hahFhR4QSkENeDBkw@mail.gmail.com>
 <b93805c1-28a6-4ad9-b0d2-5116ef4b0d83@nvidia.com> <afc139fe-ac03-43e7-a5c0-22410f1acea3@ryhl.io>
 <682c97a0-9877-4e31-b180-c1e38d3bc883@nvidia.com>
In-Reply-To: <682c97a0-9877-4e31-b180-c1e38d3bc883@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 21 Oct 2024 21:26:52 +0200
Message-ID: <CAH5fLghMiNbyD-As40Rz+eRzxMVdX9TXwesxN7cbu-iW2bZJpQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: page: add Rust version of PAGE_ALIGN
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alice Ryhl <alice@ryhl.io>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:09=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> On 10/21/24 11:59 AM, Alice Ryhl wrote:
> > On 10/21/24 8:41 PM, John Hubbard wrote:
> >> On 10/21/24 11:37 AM, Miguel Ojeda wrote:
> >>> On Mon, Oct 21, 2024 at 8:35=E2=80=AFPM John Hubbard <jhubbard@nvidia=
.com> wrote:
> >>>>
> >>>> Is this another case of C and Rust using different words for things?=
?
> >>>> Wow. OK...
> >>>
> >>> I am not sure what you mean -- by BE I meant British English.
> >>>
> >>> See my other reply as well -- I just changed it anyway because Rust
> >>> apparently uses "parentheses".
> >>>
> >>
> >> Right. For spoken languages, that's simply preference, and I would not
> >> try to impose anything on anyone there.
> >>
> >> But in this case, at least for C (and, from reading my Rust book(s), I
> >> thought for Rust also), "parentheses" is a technical specification, an=
d
> >> we should prefer to be accurate:
> >>
> >>      parentheses: ()
> >>      brackets:    []
> >>
> >> Yes?
> > What word would you use to collectively talk about (), [], {}? In my na=
tive language they're all a kind of parenthesis.
> >
>
> Good question. I've never attempted that when discussing programming
> language details, because it hasn't come up, because it would be a
> programming error in C to use one in place of the other. And it is
> rare to refer to both cases in C.
>
> Rust so far seems to have the same distinction, although I am standing
> by to be corrected as necessary, there! :)
>
> At a higher level of abstraction, though, perhaps "grouping" is a good
> word.

Rust macros can use different types of brackets. For example, the
`assert!(1 < 2)` macro uses round parenthesises, the `vec![1,2,3]`
macro uses square parenthesises, and the `thread_local! { ... }` macro
uses curly parenthesies. The round and square brackets are used for
expression-like things, and the curlies are used for things that
expand to top-level items such as global variables or functions.

Macros cannot use any other delimiter than those three. So e.g. <>
wouldn't work.

Alice


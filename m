Return-Path: <linux-kernel+bounces-271259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A18944BB3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFE3288B91
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA011A01DE;
	Thu,  1 Aug 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fDuouXDk"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDD418A6B0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516691; cv=none; b=ZlxJAlFv0sYBOKyi7CuUAldwETvJd4q4xnIB/KDGIoFsPd6z8h9AUCz13QpZ9HCXfWept4PWioAXbjd9PnRBvWdOY7ZbJ694HzglJ88JuRD3DNAOhfk3LPuL29F7TDG7NQXKf08sXH6G0zh808H9DInQ22NiGQqoqslkK21eCnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516691; c=relaxed/simple;
	bh=fSBUkzUUkWt107EAs69kOFAPLO3pyAPRIAczRvrIq5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLK6duQmWXpbuzOkTGRVeMjH+SDBEVnYjPjmeFz7lAaMMGv2UQe7AxP6kTThQ0FwlzSQbOe37vOYgGR9F3ZImjGQ6uiL9LGBZBlaEKN+MHJA6G8qlv6qUZz6gdp18q9w5t/DJIuEJZZvnzVx8CJ9n1eYw758tzE/hrGFNnZ5N6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fDuouXDk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4281faefea9so33824795e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722516688; x=1723121488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QMpYiaUKnQGePeyncUAsOyGyvo4sFuaZoIKakgcqds=;
        b=fDuouXDkFEUNSWEtlelIisa8gBO3deekZ5oIOg2n3ZOVTfZBNtC+ThQ20SzprMx7tZ
         SplvP8QdSfmK1PHCH2tvVO74mJa6/YGBp5zZb+Zt5me4WQWPCGDd6ueJlBvTo9jW91Vd
         nnIOesXV/nTmLx9c2FhbigsBrdqOuLXq92UfkEuKPmD4pTScjzXlOtyxLy8XKO0BL3H2
         NsyMk/kseMN4tAoAr1u/Kfcdq9CSKLo5mAYC8Nbub6pptICtraVonmOtxiHgnh9vG1vS
         GlZU9S8jHg/Qsn96q2R4mrQPFSqgljutl85ur/bM/usw13zyqTogIJ3NQMOLBQIvtZXv
         mQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722516688; x=1723121488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QMpYiaUKnQGePeyncUAsOyGyvo4sFuaZoIKakgcqds=;
        b=Xg4v/vlJBnT5zHZVzvTuQwM56wCMvBQuEj0EWoU5ghKb5Eqkvxp/otU9mkGd2CoGUI
         IHGRgl66vvtkbnhmMJy1SPCK+Hb/KFQwirI/HVmpmJTY3v/h7y/rXJmpEnZmMkMfAg2Z
         Wg0pStx0Pc/YmWSSiF8yW3b2HWOxZ3Q+SVWew13zhqOMfFD//uYXp9WkJTJXKOKPQ5KM
         I5aYeqff8KfIhw8E4gTOKoeRPXjb2QAxbwoBq74MJc1+gwjEuixu1joCZinsJNBd4g1w
         gRKRY+mxZhoHZvewwdFAYM3wEP4A904+zcVvX7CRhCsPAIKtRxCS74ogZ4Xnbx3kuAxW
         hhVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuYKKdbJjFA7XfxQaeq9t4+9z5PSk8c5T+8pRmTppJx/9RCqrgn8R+zIDF/BxfxPlYH/F+bQ0HTZb3PdTjEE3bI9gukBbHmggX7Z1D
X-Gm-Message-State: AOJu0Yyy7d63/xZkgdXaDt7QzF/mZLvfclF//jKzRCj9K3D3EzutTFkG
	HsdiJRpZP1SnzP1BMe4KE8SGvFlOmxJF8ysGVhiqTBAjj2d1vGzhyB03IrFpqJpyeEHGUfvFFVL
	NcDoIm6VvYsvYY7KSB3cHCXORcq7Rx9nrS6lM
X-Google-Smtp-Source: AGHT+IGFMbQ6YBajivuDZ1k5rIS4yW0tNO+NYuNxc00k9ljQGThK75whHTQu91KdxYsCWAj62TVJQLL+OJJJ8D283gQ=
X-Received: by 2002:a05:600c:46d5:b0:428:e140:88c4 with SMTP id
 5b1f17b1804b1-428e14088d2mr12744765e9.33.1722516687702; Thu, 01 Aug 2024
 05:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
 <20240723-linked-list-v3-4-89db92c7dbf4@google.com> <1b2078d8-d93b-4626-a73f-edc5616a2357@proton.me>
 <CAH5fLggKphE3f=Jv+pfXc+_qjsGBVpXw_F4fOJiAi6vNtJ5x+Q@mail.gmail.com> <5b13793c-3ec8-40c2-b0c6-e7b10883d0cb@proton.me>
In-Reply-To: <5b13793c-3ec8-40c2-b0c6-e7b10883d0cb@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 14:51:16 +0200
Message-ID: <CAH5fLgjntr81+OFxzVqvb+zL4RqHCap9LZnNxNvN_gzF8AKrRg@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] rust: list: add struct with prev/next pointers
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

On Thu, Aug 1, 2024 at 12:45=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 01.08.24 11:42, Alice Ryhl wrote:
> > On Wed, Jul 31, 2024 at 8:41=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> On 23.07.24 10:22, Alice Ryhl wrote:
> >>> +/// The prev/next pointers for an item in a linked list.
> >>> +///
> >>> +/// # Invariants
> >>> +///
> >>> +/// The fields are null if and only if this item is not in a list.
> >>> +#[repr(transparent)]
> >>> +pub struct ListLinks<const ID: u64 =3D 0> {
> >>> +    #[allow(dead_code)]
> >>> +    inner: Opaque<ListLinksFields>,
> >>
> >> Do you really need `Opaque`? Or would `UnsafeCell` be enough? (If it i=
s
> >> enough and you change this, be aware that `Opaque` is `!Unpin`, so if
> >> you intend for `ListLinks` to also be `!Unpin`, then you need a
> >> `PhantomPinned`)
> >
> > I need the `!Unpin` part for aliasing.
>
> Oh good point, do you mind adding a comment for that?
>
> >>> +}
> >>> +
> >>> +// SAFETY: The next/prev fields of a ListLinks can be moved across t=
hread boundaries.
> >>
> >> Why? This is not a justification.
> >
> > What would you say?
>
> While trying to come up with a safety comment I thought about the
> following: this impl does not depend on the type that is behind the
> pointer (ie the type containing the `ListLinks`). Thus this `ListLinks`
> will always implement `Send` even if the pointed-to value does not.
> What we could do (and what definitely would be correct) is this:
> `List` can only be used with `Send` types, then we could implement
> `Send` for `ListLinks`. But I haven't actually come up with a problem,
> so there might a more permissive solution.
> Do you have a use-case where you need `!Send` types in a list?
>
> Here is a part of my reasoning: If the pointed-to value is `!Send`, then
> the `List` item type must also be `!Send`. Thus all list operations take
> place on the same thread (since the `List` will be `!Send`). Therefore
> nobody can access the `prev`/`next` pointers from another thread.
>
> But this does not justify that `ListLinks` can be made `Send`. (although
> there isn't actually a problem)

I don't think there's any reason to forbid lists with !Send types. The
List just becomes !Send too.

Alice


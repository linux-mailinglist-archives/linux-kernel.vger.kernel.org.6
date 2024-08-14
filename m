Return-Path: <linux-kernel+bounces-286438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEE1951AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AA6283CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B911B0124;
	Wed, 14 Aug 2024 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YqLVnvZ2"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466B826AFB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639021; cv=none; b=ooMf20TJVUka+WOtvkceM7ZWCNUSUztI2Xr6S0fmZD0CoRNiYKqViTYcyWPCTKjYv7V0CGte/3Uv7OfGLWe5y8oXIyS7sqmAlo+8PFU/MJmMewaLx9Johrk5zNhK1XByuw0H9TdoG578ruIVz/RGfA7xhhsK3dgQSBr9FsPjNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639021; c=relaxed/simple;
	bh=6ZdiB0uP2lP7RHGqOjJcVgCWEGCiLEplGilrezxBb7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPGL1bmUs/hh2tQaLFygOShjPCyqDCwldb+s755fOuRyMWoGA9qL2BiaCnUZt3lWCHWFZ80Fij3GQVvhG+RejPcoPm9FTjPTzHAarGuhT0zi3h5GxlNzUtn0peIzBYmevyJOiAua5rIP4/ehb+lb5myL9jmt0WLCSY1W/tb9wIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YqLVnvZ2; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7c1f480593bso4248366a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 05:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723639019; x=1724243819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsYhBBoNZ/KZiWXtsX/kspAyxbuRsaD4hUI1DCobIk4=;
        b=YqLVnvZ23J5pZuKbwAW/mYb75GCxI4UhUOgGqFA5BxOqGXIL9D73tmLGRdRfueXYcA
         vLIjeohRjeiHLgcVP2idoaf0VNfzzNy3o8/t32TWRoASEZBD3mKXqIeEeGRqNAPtlkoF
         8/ho3fD6QViNlDXci29Rs3ib2zgiPiFVYSMSovoQudaWMg+rlhMpvc6N5eF87MpHV74A
         XMKZXf54i2AnOC8HbpiLJrSuJXLqoQmMHSKn9rmpZHLRB/HCgD6v3aZLpMLK21zEPYS/
         8+K22gKPDQZRFTKua83UDMwJzXRV5Fw0QGBUove+pvXekq9qPjOFX/fPW+DuYHhg+/ii
         I0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723639019; x=1724243819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsYhBBoNZ/KZiWXtsX/kspAyxbuRsaD4hUI1DCobIk4=;
        b=ozs2q/Olyw5qWPjzivLj11Of4iDBa8aqpJMazX9VO95ImF5pvHgeRuaJX3QQdycyKr
         fYVZQlT/ov/Fzz0sFvE3P1R8CV10pNVCjtqyfFM8iAHIAjmiwVpavDQ1nEr9Civl4P6j
         70pGKUaMUESKLDXA8HiUjEbn5JY7WqY0n45vzgojCXkbvH4YbY+vRTBqmVukvgPIyCyt
         8hZGZkT+mz7RdDT4kNrAa0/5WPaUvPKe1cfdPZh0SjI+rod7bCBbZWfVORbZFJ0L8HPm
         BBwWJ2WjKE1YyoGeLGkPYsHUe03OhRUm6dVje+GY9AfFD6e8zY70u2IE+Ut/vXTMCZ1w
         Iuyw==
X-Forwarded-Encrypted: i=1; AJvYcCWkC5mBjX7QEaaKwgRrwIoxktlmCy4GYs/3uHsTmwcL4ZKhMPKV15DVxbL66FRiYAUIKnaA3UblhWb50DpXrC2uvWI7SfZD5d3Pq+qA
X-Gm-Message-State: AOJu0YwiCuwXiAwyLLCukXKZSpDnLbGOGapvIKMDUS7D5W2O89Q59/Nc
	UHBV/owEOhJ4onowpIWc3xHS/5uaenesbjtailGKQ0xA6/pW+5XLvhCoeyAyI1SbyOb0/NixCc4
	nz2JIKZ93396pJk16h50EtsbpVxelcowrzMLh
X-Google-Smtp-Source: AGHT+IEYSU5ADFNMnTBkYUrta1oNabeXl+EYQ1/5DIXMm+1wdj1nohjfWDC+csmmh52avjlQtaYV19D860L/osVg6Yc=
X-Received: by 2002:a17:90a:5d12:b0:2d3:b643:8386 with SMTP id
 98e67ed59e1d1-2d3b64396cbmr788802a91.9.1723639019073; Wed, 14 Aug 2024
 05:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-14-dakr@kernel.org>
 <CAH5fLggchaAzcRK=i=zRm7hTg6qX0yGBAyAHcO45rG-oEh-AMQ@mail.gmail.com> <ZryjN7Rn_vZNwsZU@pollux>
In-Reply-To: <ZryjN7Rn_vZNwsZU@pollux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 14 Aug 2024 14:36:44 +0200
Message-ID: <CAH5fLggbXYYSTKMUR3jRXwWn7WPi8GtZpHqhLPWW9XHieRPQRA@mail.gmail.com>
Subject: Re: [PATCH v5 13/26] rust: alloc: implement kernel `Vec` type
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

On Wed, Aug 14, 2024 at 2:29=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Wed, Aug 14, 2024 at 10:42:28AM +0200, Alice Ryhl wrote:
> > On Mon, Aug 12, 2024 at 8:25=E2=80=AFPM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> > > +#[macro_export]
> > > +macro_rules! kvec {
> > > +    () =3D> (
> > > +        {
> > > +            $crate::alloc::KVec::new()
> > > +        }
> > > +    );
> > > +    ($elem:expr; $n:expr) =3D> (
> > > +        {
> > > +            $crate::alloc::KVec::from_elem($elem, $n, GFP_KERNEL)
> > > +        }
> > > +    );
> > > +    ($($x:expr),+ $(,)?) =3D> (
> > > +        {
> > > +            match $crate::alloc::KBox::new([$($x),+], GFP_KERNEL) {
> > > +                Ok(b) =3D> Ok($crate::alloc::KBox::into_vec(b)),
> > > +                Err(e) =3D> Err(e),
> >
> > Hmm. This currently generates code that:
> >
> > 1. Creates the array.
> > 2. Allocates the memory.
> > 3. Moves the array into the box.
> >
> > Whereas the stdlib macro swaps step 1 and 2. You can do the same by
> > utilizing new_uninit. A sketch:
> >
> > match KBox::<[_; _]>::new_uninit(GFP_KERNEL) {
> >     Ok(b) =3D> Ok(KVec::from(KBox::write(b, [$($x),+]))),
> >     Err(e) =3D> Err(e),
> > }
>
> Generally, I'm fine changing that, but what's the reason for the suggesti=
on? It
> shouldn't make a difference, does it?

The compiler is much more likely to not put the array on the stack
before it is copied to the heap.

In the case where $x constructs new values, it also avoids
create-then-destroy on allocator failure.

Alice


Return-Path: <linux-kernel+bounces-401625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E45AF9C1D04
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D1DB253A5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D431EABA7;
	Fri,  8 Nov 2024 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcG/Ehy4"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195D1E7C36;
	Fri,  8 Nov 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069019; cv=none; b=jPNNmqF5yuKgUP44Ye9Cq2v9Sk55vXIT8WYxt2axGjU1kJYeiT0Sth+hwhf15Vd9G4VDATewQQne78qN2ytFOrq6H5jW7xjMxyMWEus9FxNcEWdyimUUCyLLxYAD6/d8Fm9zLQ1J7WNE25pClKPs02ho20xlc3iEM3FBh5iCjcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069019; c=relaxed/simple;
	bh=JbA7j9iRgDw5N+kjHouOdhD/KtZGez3I+W3DVh+Nkns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2HBQA6fnHvIjq3tFSLBZL67AUViEbI6TAeyfGAmQpgl6oZX3IDsNNXVTzyXHnKbfGi8cso+3V6jspsEuqNdJkPqS+y6qHAeI1IKhDS3dxoCL5v+QYzlDOC9f3illXpJjQu/S7arkV4yrOABi1+z3ZmV80FN0jVby6lav8AOB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcG/Ehy4; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb6110c8faso21400181fa.1;
        Fri, 08 Nov 2024 04:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731069016; x=1731673816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1TfxRT6YrJCzqaJD2FpFr/vppnAry7dWCIlul0kxmA=;
        b=EcG/Ehy4B+ZK3woVHGJ6mfQJIW42A/dJTTCS5G04jMAq/RgeDC5sXIXqfMIrV5XKXk
         aQBVzIql/NN24pLYWgdlHJfeWqLfA98/24df8WzYy/cqgXHbVJPFN7z1YFMvJhesvmnC
         8Yl9mb/9WAOOIZhFCk0GNCyeILIr76Yab2yvPHO0f/mg0JoZWC9vf1AbeuiltLNLfFAa
         cPbu4XloALbU6N+CP5dg6Ekpp4/sJfDe/RNKS7EYbo53sDBZqQfmD9ZOuf5dwoyR0Huv
         aWxli2jbDXpbjNl2YJToEOzRWWcJUiVRGf2lZJMFEB40e3AnzOY0xdPoXqbImuR0YkPJ
         Ltvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731069016; x=1731673816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1TfxRT6YrJCzqaJD2FpFr/vppnAry7dWCIlul0kxmA=;
        b=PlnqbMCxZZ1mwsZHyjEZ5nw81OIWf87mhe5ituyZKzWpYHDypBvgAdAxY022H7O5bc
         8oXlGWqqlp5ZJQzB2yc6yBM9EprfmhwjTD1ybURfFTx7tMmXPOKzHfjM9+cFXsIFUmuT
         gKwrTxAvUJ/RQCoAFEjltiGvvCH+OAvk36OHtaTBnCUN5rgM83cuqLVOJFqTMLIedEzr
         G4Q/DbkM3VHRucW20bgZdbw9wwWn/98F0aXjWmn3faKuF5jpQNYhVxjUHZC6sOGcHiM/
         effkXENZZk4/zpL9igjr03nM0UiftzUl/+JziI7mwNBrrkXzk0NxmveOkJY4fQkj1pUE
         6kpg==
X-Forwarded-Encrypted: i=1; AJvYcCW6VCiq/eyI6tfT5F2ZsRv5/SvaaMVvqWUX8TTNn2OmFa8kmKu8Q93dmXKCllR5sS3l0+Yf/0NQ2FiK+B5hrZE=@vger.kernel.org, AJvYcCXlp+/5bhOSED20fzk/OFqi3x8kOwHw5Rn5pWvZQkn6xgfEGeri1A+uIPIV8LPEwcYpx9rupUsoP8H7OIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9igquRu6JfCBsxnOLbGEEZBTl/ZpggBn/V34QjH5eRPF+zDR5
	TceXy1v3W2JBDBgqz6YqlteC09f0clxSLtl7bKjoCry0GTf+iwL8WBPUnaPLGRzlkHC2cz9yfCK
	Cs/mnS1wl+n3tjCizSANA3zYaca8=
X-Google-Smtp-Source: AGHT+IFf2Tf3HdF46mL3UjwOYi3iO25rXFbd1kX5sxfZ1oHi9QhtoINs0qb8pb/Gk/2u4luNNWhJF590Ii7atv5E3PM=
X-Received: by 2002:a2e:bc13:0:b0:2fa:c0df:3d7b with SMTP id
 38308e7fff4ca-2ff201b730emr13693651fa.22.1731069015664; Fri, 08 Nov 2024
 04:30:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
 <20241104-borrow-mut-v2-3-de650678648d@gmail.com> <CAH5fLgiMHE5GXQv8pSR_KYWsa44zr1o_FNrg1mj8QuTvNQmXhQ@mail.gmail.com>
In-Reply-To: <CAH5fLgiMHE5GXQv8pSR_KYWsa44zr1o_FNrg1mj8QuTvNQmXhQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 8 Nov 2024 07:29:39 -0500
Message-ID: <CAJ-ks9=Ej0St7XnmvTysdnjPHh6O+4XdYFC6LouwEJR9GpUPNQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] rust: arc: split unsafe block, add missing comment
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 6:38=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index af383bcd003e1122ebe1b62a49fe40279458e379..9adea755a5ad1a7b03f7fc3=
0a7abc76c1f966c6c 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -377,10 +377,14 @@ fn as_ref(&self) -> &T {
> >
> >  impl<T: ?Sized> Clone for Arc<T> {
> >      fn clone(&self) -> Self {
> > +        // SAFETY: By the type invariant, there is necessarily a refer=
ence to the object, so it is
> > +        // safe to dereference it.
> > +        let refcount =3D unsafe { self.ptr.as_ref() }.refcount.get();
>
> I would normally prefer to avoid creating a reference to the entire
> ArcInner, but in this particular case it is okay due to the specifics
> of how Arc works.

Note that this particular line appears also in the Drop impl just
below. That said, can you help me understand the concern with creating
a reference to the entire ArcInner?


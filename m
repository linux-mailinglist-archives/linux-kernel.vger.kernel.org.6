Return-Path: <linux-kernel+bounces-542091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F73A4C589
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1583B188C645
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73874214A70;
	Mon,  3 Mar 2025 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1zlH7O0"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C7B2144DC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016708; cv=none; b=pYNCG/L2KMnBjCXJA2fWpUM6YXQNaNnjQyy5m38px3lPFuoVno5CWBai6oGCi/5ZCngq1dgOjZZWZ/XFZO17maP+/uioU6aQDhHfrIQCXy9zdFA4RdUrwb+Og6xHbK6Nhc2pFfAtwe0qgC+rDozLrJ9VElNSr5kNpGNQqtlnf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016708; c=relaxed/simple;
	bh=TvEt7HL2f2+ZiPYpZgA9Wv//CyB2sGr83sClfxce/Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciJO+sPUU0vpN8Zd52Ph4peptJcriERWxWEKwB5JYX8aV4uA4vvC0ILQPbhCh7xHUb8nRCc7Rqc8VDYQAvyGSnE7WQbbHYaYOcRr9rfBjqC3dTMwK7eYjA2R7BDvz64QNTyxAtlzdry4r3YZTaMaIQnFRPc8M+oy8uPfO/aZhvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1zlH7O0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso31762025e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741016704; x=1741621504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kow4xuk+1mNeQ4oexSjSmUNlEIdhe4RIwb0wGDmCC8=;
        b=s1zlH7O0h915hMWBG4aPJ0ZiB9mvsECjZ+YtIAz5FaT00pxSVz9vLtf4tnOISz7YmK
         qP2sFtt76VC2xdOkapqpeGY3RDX9ABhuvnD+K8sSpypE6cDyexjy9yajNNgmAfXJ5i2c
         CvpDFeRW999FXUN6ebuHHw+hA/IIlKZrOvDqN5h2CLee1ZoX+kcA/QjldpIx1Ev2owjy
         dOrfSrtC/9m2lZ6uN1cBDH8tpTm06ymFFmozowsX/yw7VVHmYQ06CvHGFhxFEQU6KaGD
         NM8QCoKGeKNzM5Z64x+LzlZdUpaC9avyb3/FOXCtohL/fdisgyv+9rMQ0V/jxKkF1y5v
         4lBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016704; x=1741621504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kow4xuk+1mNeQ4oexSjSmUNlEIdhe4RIwb0wGDmCC8=;
        b=YM6pLmmHEcv+6EzJf54bCeApfE8bYU+AjzLBJ/ZonctJFGmDOmw7Ope8auNTJ0MFVf
         oIrCcVtXckV/wZfviuZO3qBz4yULSGVrya9FkSLn80E6xxi27jSDGerDjRsoVS9WIwsa
         TodS56RZ6mtBEj0VZNh9uRiHfV59OJ/qzFEtDw66SxWBw9lIq9SHo2kaVcuUussVYwyD
         DHeNRxSgPEkGy56+gpyCErIATIscQPGCfskm32dNDKiMCoj9JvE9eSBA2iOFsMWJoovz
         jerpzwEMZyjLL9gSMIyVTqx3ayeo6IhwsKFitNvG2bFECWWwlE7xBVPbbmu4PFT4nVuC
         fJFw==
X-Forwarded-Encrypted: i=1; AJvYcCUS/mREsE7XASOxko8lf6A+wJxnJZ1VUzzFFgWDhX4T4GyWnfX7XjsmYh9rNwNCTOCmYiG4fJJJ05lZmfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhXZobJC0LFPZVnOiB1Z2l9ZKtPOHM9TC8UFC2P8rXKzc5prTG
	ZJroK4cd5q+0kPnteR5awPoLuKRThnSlcDef8i2PzTTCwFvWw34ndHi8vFvEdELFP/d80VirXX9
	y9zhQJZvZo40bYwvk9iSqsXw292FzWBZRe0k+
X-Gm-Gg: ASbGncs+rYl7VpFThPFGl/I4xoaVQGSWziJSRwbBoRbe4F1SjC7xq6vPQMl7BsFu1rc
	jmf88BzPw8D4x2LmZi4TVjolmGI+7q05jaqdJiOmylal7LukZxKDeuw3pTcvNcYj3MMxr/yjEIL
	LbqEXy3+ewRhbUdZlvxwPYkWJYRhQL59DQh2fY4qTvMg9taU6QL3PTvO7w
X-Google-Smtp-Source: AGHT+IHXXQ7buQBEorS4efQ1j2iNuWmeS1bZKP0/m94hhxiT8OFf6H7yU2EGk9/SwAGsuWxPOOcRN2PU93WYRcIT0a8=
X-Received: by 2002:a05:6000:270f:b0:390:dfe0:1320 with SMTP id
 ffacd0b85a97d-390ec9c1bddmr8951802f8f.33.1741016704234; Mon, 03 Mar 2025
 07:45:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com> <6dea7b6a-1534-47e7-94d2-d67417c3d4c1@proton.me>
 <tnwDK3QN_Xr0Yoa3U8HVxS5OqjvxIhgmmO_ifTGJR_EtIzjoxawOHtnbOJ9yChsUWXyFPcU9beIdrgbpfGZI8w==@protonmail.internalid>
 <3202F69F-397E-4BC4-8DD8-E2D4B0AB056F@collabora.com> <87bjuil15w.fsf@kernel.org>
 <t4HxdvR7WBX_861hiTXo72jqC9F9oRpIzgA_dD2yhcSuLISEkC-shMfSgllrFPpnkSZXGfRcc47keudMooNiIQ==@protonmail.internalid>
 <CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com> <87ikoqjg1n.fsf@kernel.org>
In-Reply-To: <87ikoqjg1n.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Mar 2025 16:44:51 +0100
X-Gm-Features: AQ5f1JpQwVPMNAtyLQEi5zozvB7zbblDDYl0-W2nDZDSA_G1jc6Lh4mO8DNqPys
Message-ID: <CAH5fLgh6ubawHh76wq7JPbcuBCWhm91m7Rc01MVsX-a3C6qaVA@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Benno Lossin <benno.lossin@proton.me>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org, robin.murphy@arm.com, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 4:21=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> "Alice Ryhl" <aliceryhl@google.com> writes:
>
> > On Mon, Mar 3, 2025 at 2:00=E2=80=AFPM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
> >>
> >> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
> >>
> >> > Hi Benno,
> >> >
> >>
> >> [...]
> >>
> >> >>> +    /// Writes data to the region starting from `offset`. `offset=
` is in units of `T`, not the
> >> >>> +    /// number of bytes.
> >> >>> +    ///
> >> >>> +    /// # Examples
> >> >>> +    ///
> >> >>> +    /// ```
> >> >>> +    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8>=
) -> Result {
> >> >>> +    /// let somedata: [u8; 4] =3D [0xf; 4];
> >> >>> +    /// let buf: &[u8] =3D &somedata;
> >> >>> +    /// alloc.write(buf, 0)?;
> >> >>> +    /// # Ok::<(), Error>(()) }
> >> >>> +    /// ```
> >> >>> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
> >> >>> +        let end =3D offset.checked_add(src.len()).ok_or(EOVERFLOW=
)?;
> >> >>> +        if end >=3D self.count {
> >> >>> +            return Err(EINVAL);
> >> >>> +        }
> >> >>> +        // SAFETY:
> >> >>> +        // - The pointer is valid due to type invariant on `Coher=
entAllocation`
> >> >>> +        // and we've just checked that the range and index is wit=
hin bounds.
> >> >>> +        // - `offset` can't overflow since it is smaller than `se=
lfcount` and we've checked
> >> >>> +        // that `self.count` won't overflow early in the construc=
tor.
> >> >>> +        unsafe {
> >> >>> +            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu=
_addr.add(offset), src.len())
> >> >>
> >> >> Why are there no concurrent write or read operations on `cpu_addr`?
> >> >
> >> > Sorry, can you rephrase this question?
> >>
> >> This write is suffering the same complications as discussed here [1].
> >> There are multiple issues with this implementation.
> >>
> >> 1) `write` takes a shared reference and thus may be called concurrentl=
y.
> >> There is no synchronization, so `copy_nonoverlapping` could be called
> >> concurrently on the same address. The safety requirements for
> >> `copy_nonoverlapping` state that the destination must be valid for
> >> write. Alice claims in [1] that any memory area that experience data
> >> races are not valid for writes. So the safety requirement of
> >> `copy_nonoverlapping` is violated and this call is potential UB.
> >>
> >> 2) The destination of this write is DMA memory. It could be concurrent=
ly
> >> modified by hardware, leading to the same issues as 1). Thus the
> >> function cannot be safe if we cannot guarantee hardware will not write
> >> to the region while this function is executing.
> >>
> >> Now, I don't think that these _should_ be issues, but according to our
> >> Rust language experts they _are_.
> >>
> >> I really think that copying data through a raw pointer to or from a
> >> place that experiences data races, should _not_ be UB if the data is n=
ot
> >> interpreted in any way, other than moving it.
> >>
> >>
> >> Best regards,
> >> Andreas Hindborg
> >
> > We need to make progress on this series, and it's starting to get late
> > in the cycle. I suggest we:
>
> There is always another cycle.
>
> >
> > 1. Delete as_slice, as_slice_mut, write, and skip_drop.
> > 2. Change field_read/field_write to use a volatile read/write.
>
> Volatile reads/writes that race are OK?

I will not give a blanket yes to that. If you read their docs, you
will find that they claim to not allow it. But they are the correct
choice for DMA memory, and there's no way in practice to get
miscompilations on memory locations that are only accessed with
volatile operations, and never have references to them created.

In general, this will fall into the exception that we've been given
from the Rust people. In cases such as this where the Rust language
does not give us the operation we want, do it like you do in C. Since
Rust uses LLVM which does not miscompile the C part of the kernel, it
should not miscompile the Rust part either.

> > This will let us make progress now and sidestep this discussion. The
> > deleted methods can happen in a follow-up.
>
> `item_from_index`, the `dma_read` and `dma_write` macros as well, I would=
 think?

Those are necessary to use field_read/field_write, so I think it's
fine to keep those.

Alice


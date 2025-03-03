Return-Path: <linux-kernel+bounces-541776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F134BA4C16B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E2E16DBAB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FCC1CAA71;
	Mon,  3 Mar 2025 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0fEsBOYk"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0964E20C00D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007602; cv=none; b=ZlWNMX+y0oePDVfC27Tx9i04Ctxhh78pjhTQ6SQQzYiKNZ9KlcMtbImtRuiWGf9h0RQWz2W6OV51xT/HTvi/Sze1n2mrTR95iLoKPkiHLwtHw6F/cHwXj8fv/a9TyeXIVYJyEffwdyrrZnEwFwhwNFgWTVhF7GmxB9WzS84u6m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007602; c=relaxed/simple;
	bh=Uto82Mh3sOAP6a14MgLm1RyL/LEhHeHNE37C48rmrFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqgIXyIMtGb2lvN3h1+7qjZp9KBbo3BjXgvJEdbTm4RH67UP5fOo1jQ3XswMVLTKe4nLeR5S/k6ObfLedY6mPHOfR/hZN8b14ovvCRXCtiFrPkA0rLqiEx5ojBaNj4K/gBO+PXKxP7+DRca/+t5ByKhJElhwYD0XrdERR+ggOI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0fEsBOYk; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3910e101d0fso505799f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741007599; x=1741612399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aG+Vwr8bBVGY14HwfhSuMObmhpcIIei119+D2o/DNo=;
        b=0fEsBOYkCTw1BzQucMBf/jDICVy3guTKUI8KU+O4pUOgUNzWgzTzzWBBcAxX3C1HbH
         1k4AYVKc1A4fw/Ll+ETvdEdQ34Jxkvpg21CXO8h4ADgjJ8C9K/F1XJU7KVrJ24sGYIUG
         rQSB8XsewdfLIBQM7vm9ilew/DAS9Nbmh4Bxfm+Tf44pqXUEa5VXIAlBIicLXUYbDxbp
         8IrXEJgi6og6M0HQafUbtUt2Ca1nGqf6sPC0iOgbMLwc0LoLqAByoOsYs0EZrr9t49tO
         ddeBkLRqxY8SlkwFNPaScdBpo/FIrFwmobM1dLtYDAl4FwQxGRC1Ep6oWiRLk8BU7O2l
         i6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007599; x=1741612399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4aG+Vwr8bBVGY14HwfhSuMObmhpcIIei119+D2o/DNo=;
        b=OYuROJhoBNmorGqa6D0r5KToISaDRrzEJDzdm7DCKjpO0osznUankJHlnyz/5U37UX
         DW16O46yg/4kIUiANxnop22j/lKvGEiYNTsJ3fI+DosRsA/KQ1CuTOOCYbJMEIdlTJHi
         P3pn0PFTJ3w7pn85MiYlol3Z/b/lgdAEstptrk8CTJ5rs0WyU3X/p9eFlEoq6ehT/j0K
         12ARWGHFbqrUAFWRavk/rlocCvn+ykro79Ete3pai2tbNQWX9ZudEfWyOeNbqzNAbALd
         IpjhESasNjD5M2PNjWogMDmntadOeJdLIrnrTcuk/dYaY7mEz2hQ/HHeMbHy3m0I1NEQ
         0SXA==
X-Forwarded-Encrypted: i=1; AJvYcCU5HAGvmrX+BGKCzr3/jFYHIYBeVz32H1DGw7fvs6eNbusLt+m9lJsP2BFTBpCIF2y2QkzBnpdcUOC+aIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxndPbPCRZ0P6++GFjMct0TIk0OkGAsxMCXKkx10nFlI86fqJX0
	Nek7SkB0Ug+Q7uZPNYrSl4Jh9fyF3MiGt3sv90KvGduvk/62Zeu6LcVK9IPyF5yQ39FkslxJukx
	lhlaR4M4vwFMzaC0lWhNk3a6zs4bs29ro1+Mz
X-Gm-Gg: ASbGncs1WIw4i72Kvo3OrgA7g6anSJ+Jaa0f7VYC9xhI8iL9as4mhx6MGWIrmTubHPZ
	pzxsfJomgxWBmh8X48e9g0B3Qqna/liIjbvHWwJqxmQA9ulKGGHtzla/6jQYceDi4OJGMZ0sdUL
	AgprMXMP7uTWzrLObi3gAddvMLpoZWph2sQpXjPupbG6mes+ONbWyjBNnZ
X-Google-Smtp-Source: AGHT+IE2IaeBD9f/pD6r/8mI8mW0BTFlxQPSBn+pSqzeGMSocizM1zr/Gfb1GuajIkxQ63TEE079e9IJCjW3eVFxm0M=
X-Received: by 2002:a05:6000:401f:b0:38f:4d40:358 with SMTP id
 ffacd0b85a97d-390ec7ca984mr9945448f8f.9.1741007599225; Mon, 03 Mar 2025
 05:13:19 -0800 (PST)
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
In-Reply-To: <87bjuil15w.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Mar 2025 14:13:07 +0100
X-Gm-Features: AQ5f1JqBfsK9p5NTbyKiOrBd4XG8qnGgG452abK96QmFlhPOGudZDk9CePtYnc4
Message-ID: <CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com>
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

On Mon, Mar 3, 2025 at 2:00=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> "Daniel Almeida" <daniel.almeida@collabora.com> writes:
>
> > Hi Benno,
> >
>
> [...]
>
> >>> +    /// Writes data to the region starting from `offset`. `offset` i=
s in units of `T`, not the
> >>> +    /// number of bytes.
> >>> +    ///
> >>> +    /// # Examples
> >>> +    ///
> >>> +    /// ```
> >>> +    /// # fn test(alloc: &mut kernel::dma::CoherentAllocation<u8>) -=
> Result {
> >>> +    /// let somedata: [u8; 4] =3D [0xf; 4];
> >>> +    /// let buf: &[u8] =3D &somedata;
> >>> +    /// alloc.write(buf, 0)?;
> >>> +    /// # Ok::<(), Error>(()) }
> >>> +    /// ```
> >>> +    pub fn write(&self, src: &[T], offset: usize) -> Result {
> >>> +        let end =3D offset.checked_add(src.len()).ok_or(EOVERFLOW)?;
> >>> +        if end >=3D self.count {
> >>> +            return Err(EINVAL);
> >>> +        }
> >>> +        // SAFETY:
> >>> +        // - The pointer is valid due to type invariant on `Coherent=
Allocation`
> >>> +        // and we've just checked that the range and index is within=
 bounds.
> >>> +        // - `offset` can't overflow since it is smaller than `self.=
count` and we've checked
> >>> +        // that `self.count` won't overflow early in the constructor=
.
> >>> +        unsafe {
> >>> +            core::ptr::copy_nonoverlapping(src.as_ptr(), self.cpu_ad=
dr.add(offset), src.len())
> >>
> >> Why are there no concurrent write or read operations on `cpu_addr`?
> >
> > Sorry, can you rephrase this question?
>
> This write is suffering the same complications as discussed here [1].
> There are multiple issues with this implementation.
>
> 1) `write` takes a shared reference and thus may be called concurrently.
> There is no synchronization, so `copy_nonoverlapping` could be called
> concurrently on the same address. The safety requirements for
> `copy_nonoverlapping` state that the destination must be valid for
> write. Alice claims in [1] that any memory area that experience data
> races are not valid for writes. So the safety requirement of
> `copy_nonoverlapping` is violated and this call is potential UB.
>
> 2) The destination of this write is DMA memory. It could be concurrently
> modified by hardware, leading to the same issues as 1). Thus the
> function cannot be safe if we cannot guarantee hardware will not write
> to the region while this function is executing.
>
> Now, I don't think that these _should_ be issues, but according to our
> Rust language experts they _are_.
>
> I really think that copying data through a raw pointer to or from a
> place that experiences data races, should _not_ be UB if the data is not
> interpreted in any way, other than moving it.
>
>
> Best regards,
> Andreas Hindborg

We need to make progress on this series, and it's starting to get late
in the cycle. I suggest we:

1. Delete as_slice, as_slice_mut, write, and skip_drop.
2. Change field_read/field_write to use a volatile read/write.

This will let us make progress now and sidestep this discussion. The
deleted methods can happen in a follow-up.

Similarly for the dma mask methods, let's either drop them to a
follow-up patch or just put them anywhere and move them later.

Alice


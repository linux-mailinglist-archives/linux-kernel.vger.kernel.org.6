Return-Path: <linux-kernel+bounces-530155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AE6A42FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA4217A581
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972671EF0B4;
	Mon, 24 Feb 2025 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1j3SCYM"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3651DE3AD;
	Mon, 24 Feb 2025 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434754; cv=none; b=DC2CXdr4cthbk8Zlx+qXnGpDlCLdkLr87ioN+bZO8hcOKl0DfOfGTEvb/MkTcWuLITnF32cmezw1xc3SwwERT9wZfEUeSi/s7kacQ5Mq0BhuBoepUs4ankencWoZscQp3Mj/28uR+hkENsV/YV1uvndaDzwNi0kIa31y0/PlE90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434754; c=relaxed/simple;
	bh=BkBtXHdVcPv6/CA4W328niK4o+qOe4q15XUIuFlL33Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzpNAE7IBlhpLNQ5pYmAf5FRTc/JG1AJWqDXe8sgWb9omH1ZP8oMZxYgw7JsYOXhLgox4tj8nF7OBFabokzc+ZlHw0RFQ/Z3LsPfcV/+T6Ny7miup0VCsVfGPZjWztPY5+94avCTIufnQEbSg28BKfcgzrK8iHqfNh3lNMQ0olk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1j3SCYM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fc92215d15so1375054a91.1;
        Mon, 24 Feb 2025 14:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740434753; x=1741039553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHIcNsleTwWKuMXlMG/3febKszSx8ZfGtr3TPtrffRI=;
        b=i1j3SCYMlD/EjGVQc6aaoBsNf2UHMa48V1ym1Rk8cFTAkgCFd57/U5wYT3rOLHgbOJ
         gqMdWwpVdOq9AfJ++FeQoaf7rifTS1CEr0MbuparDYgnFEPQzy4WFHxcLiyB0v06JlLx
         TRdwId/9GWXY5QeeIVLiGRsFbV/vY64fTL7LaCfYu/7Owtwupq7m4EYoJtuZWwSOVxCM
         kaBIak148YF4RefAdXzaYGVj/3x5MQUHOyAIvs2Lddfh9nMK6pmAtXBMvCyCp47abYEC
         pmXZOcl7gUHukvHy5f16DbKzZQs9BIymQJkqIP/0dZNb0OnYm7PpeM4xghWERiDERgQ6
         5pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740434753; x=1741039553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHIcNsleTwWKuMXlMG/3febKszSx8ZfGtr3TPtrffRI=;
        b=BsVPj4WahLAB8R3xgs0WTd8DNSB5gbEJgnihDFmS4zen7XqkNkldJ1G9Q7veJiZdVt
         NlOY5uskmVpwnxhIugM0H14W1shd4Gi/nwr61L6YvoT2OWnfdyX7e1AEWhwhyYBtgR4d
         goEvcmTGCeRgsPbWbjKcpqTHp7XcEsMWV5RZdIDCa7Fq6/X6qjJzSjCWcire0MCgifNP
         LxvaX4/iCG4ylEJhZ+1WISDoR4X3iDk5/5tWg136JJr2KIgHRbbF8nvUXzalr5qPV886
         kke+Wi0X2SiRyISnLiZpMOjVpQtNezuMuzI1/W8CPKdW7gt30PrA6DjJ0/WzrD11oje0
         m16Q==
X-Forwarded-Encrypted: i=1; AJvYcCUECJ6PWAtQGd13lxxUERL8u1hgUJda/nvCnN6m6zBi8ZMXJGQsPOSX4pypuPOcz/j+FmYfP1ZSjPU1skIQWNQ=@vger.kernel.org, AJvYcCXMsGGKMwpDmh/JN44VzmalPvEv0peFxbQ/iwzRvj7ZnVriYqSvJIKSkmQJa3Ilc/B85dbGShS2NPe6gNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOnSCDknpa/uFnar4qW3m4ITn/3t6Jir7OoANHTEQXVMRO0DLx
	L1jhUTX1CfgFI0q5oC71JEAH464nSIfDh4KjJFaVx5tXX1rk+8/3aSLxUjPqiarWzgvbS+7va6E
	V9xFVtDopRdGLkJKb/rRCgg04ldE=
X-Gm-Gg: ASbGncs+Vra7jUDLMLsZ8hHpSMnxll/55EjVgca0G6wc42ppoVSV+UM8fPWcCRGxraQ
	4idoLI0DzdDsvDZRUnz02rqxB26ntzVInRPM8ZkMOYOAZD0LO39Rm+e6QVhjk7qB8NuHhQoK1t+
	nf1GPuDg4=
X-Google-Smtp-Source: AGHT+IEHRJCdPVay7C8B4eRlDOna0GkWz3nnyAQV6jsCpnvpaPryAQnVfEQ0QZ0vR4GuW9WBJTXPkr8gK0uiKNIyLgM=
X-Received: by 2002:a17:90b:3a81:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2fce789cc70mr9658756a91.1.1740434752565; Mon, 24 Feb 2025
 14:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com> <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
In-Reply-To: <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Feb 2025 23:05:40 +0100
X-Gm-Features: AWEUYZl9ZKbchwRuutSwEDDiVUkfsWiO5zHcHT16MwA4Q6ucCw9hz2sOiVVW5cQ
Message-ID: <CANiq72mMKx3kD5KEcT0gOa1zkCt-VXxTEhnDa3feq0H7AttUGw@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: aliceryhl@google.com, dakr@kernel.org, robin.murphy@arm.com, 
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Abdiel,

Some quick doc-related nits -- please take them as a general guide for
potential improvements in newer versions etc., given there are still
other comments that could change the contents.

On Mon, Feb 24, 2025 at 12:50=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> +/// Inform the kernel about the device's DMA addressing capabilities. Th=
is will set the mask for
> +/// both streaming and coherent APIs together.

This comment differs from the C side one -- that is OK, but just
wondering if there was a strong reason for that.

> +pub fn dma_set_mask_and_coherent(dev: &Device, mask: u64) -> i32 {

This returns `i32` -- I have not read the users of this, but should we
take the chance to have a `Result` already here? Same below for the
other one.

> +    // SAFETY: device pointer is guaranteed as valid by invariant on `De=
vice`.

To keep things consistent, please start comments with uppercase, i.e.
"SAFETY: Device pointer ..."

It may also be clearer to say "by the type invariant on".

> +/// Possible attributes associated with a DMA mapping.
> +///
> +/// They can be combined with the operators `|`, `&`, and `!`.

Even if it may be trivial, a small example could be nice here (when I
see a sentence like "This can be used ...", I typically consider
whether it is a good place to show how).

> +/// DMA mapping attrributes.

Typo: attributes.

> +    /// let c: CoherentAllocation<u64> =3D CoherentAllocation::alloc_att=
rs(dev.into(), 4, GFP_KERNEL,
> +    ///                                                                 =
 DMA_ATTR_NO_WARN)?;

Please try to format the code as `rustfmt` would normally do it. I
know it is a pain to do it manually -- hopefully
`format_code_in_doc_comments` will eventually be stable.

> +        // We ensure that we catch the failure on this function and thro=
w an ENOMEM

Apart from what Benno said, please try to use Markdown in all comments.

> +    /// Performs the same functionality as `alloc_attrs`, except the `dm=
a_attrs` is 0 by default.

Intra-doc links (I will mark a few more that I think may work).

> +    /// Create a duplicate of the `CoherentAllocation` object but preven=
t it from being dropped.

Intra-doc link.

> +    /// r/w access or use-cases where the pointer to the live data is ne=
eded, `start_ptr()` or
> +    /// `start_ptr_mut()` could be used instead.

Intra-doc links.

> +    /// Performs the same functionality as `as_slice`, except that a mut=
able slice is returned.

Intra-doc link.

> +    /// Reads the value of `field` and ensures that its type is `FromByt=
es`

Intra-doc link.

> +    /// # Safety:

Typo: no colon. Also another one below.

> +    /// This must be called from the `dma_read` macro which ensures that=
 the `field` pointer is
> +    /// validated beforehand.
> +    ///
> +    /// Public but hidden since it should only be used from `dma_read` m=
acro.

Intra-doc links -- even if they are not rendered because it is hidden
(also even if it were a private item).

> +    #[doc(hidden)]
> +    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F =
{
> +        // SAFETY: By the safety requirements field is valid

Markdown; and please end the sentence with a period for consistency.

> +    /// Writes a value to `field` and ensures that its type is `AsBytes`

Intra-doc link, and period at the end (same below too).

> +/// Reads a field of an item from an allocated region of structs.
> +/// # Examples

Newline between these two lines. Also for the write equivalent one below.

> +/// struct MyStruct { field: u32, }
> +/// // SAFETY: All bit patterns are acceptable values for MyStruct.

Newline between these two, also Markdown. Same below and in the write
equivalent.

I think it is fairly important to have clean examples, since people
will learn from and follow them!

Thanks!

Cheers,
Miguel


Return-Path: <linux-kernel+bounces-556973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8C8A5D1CF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC7817AB09
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28002264634;
	Tue, 11 Mar 2025 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XWjfYWCA"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E10341760;
	Tue, 11 Mar 2025 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728871; cv=none; b=dZnZNyh/VdShpiIcKZTRhlED7XqGY23rOxAI7kjaFTDTdxJ6Oc9J4l0MusMyHcBDxjhYT+ep9s54/zBJJGmpl/RmnaQ6yttqVlJd/wrioTk9VEKZxkeU/r2nTxrymmfwhoXiB/7wtMWsDAiXn/gvRNyWhExLKYueFVty7vGeYpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728871; c=relaxed/simple;
	bh=9MNXeLhvz16YzeT8Tfppvcd8JEIlMvGLPq1LzLedPIE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtLdpupSrAM77MmOTgITER/fUTDsZxAeFaa+4sgnZfLMMcIcN9fMpV5iYCIOE5Y2hYvZvToJ0vInWCqyDa2UYVo0OdKTBj8mJShxzbWqtJBdytYozBo7+rKlLQfk71D3vqqoX1o0KcrjlcNZngPjczHZatj0QDbuVcxkqsrUwgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XWjfYWCA; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741728862; x=1741988062;
	bh=tPA51OnvPJ8yLRyi98bWkUu98ZXaZRiTPa2zMrxODwM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=XWjfYWCAxjAR/oiBt3L1LTF9oiGBki/pg6SbBULd8H8hVM7Llw58fkPQ1s7o54S5u
	 JCsak08KQAZHP0+Kv8gcI293tKaO5W6AYDuYQPq1SvKmDeCpBGXdb/iEfFdyw0uoIA
	 20eJX7TnFNxS6i2LwcTzMiBtudMyMY84sCL6SzMGaN52b5NTlu7mjhDTBRMGJjrMMX
	 +bskZEAEKrBe6F03mEMI6XXHD3cc0IlswMahO/F5dXHNatjRc48oyEfI5NgfSWlFe2
	 4joj1wiN+vtTa73C8VN2dXa1qd83tBzkpZJ5trRR+wWraN6IlPkFqhyMQvGj1xIuTM
	 c70/itz2BY8zA==
Date: Tue, 11 Mar 2025 21:34:19 +0000
To: Boqun Feng <boqun.feng@gmail.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com, dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v14 02/11] rust: add dma coherent allocator abstraction.
Message-ID: <D8DRCM2FOEBN.3IVEVKW9A65AL@proton.me>
In-Reply-To: <Z9B9CNRatBtyAO8Q@boqun-archlinux>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com> <20250311174930.2348813-3-abdiel.janulgue@gmail.com> <Z9B9CNRatBtyAO8Q@boqun-archlinux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 14cd732373dbbd39a2efa712bd5832164c764589
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 11, 2025 at 7:12 PM CET, Boqun Feng wrote:
> On Tue, Mar 11, 2025 at 07:47:58PM +0200, Abdiel Janulgue wrote:
> [...]
>> +    /// Reads the value of `field` and ensures that its type is [`FromB=
ytes`].
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// This must be called from the [`dma_read`] macro which ensures t=
hat the `field` pointer is
>> +    /// validated beforehand.
>> +    ///
>> +    /// Public but hidden since it should only be used from [`dma_read`=
] macro.
>> +    #[doc(hidden)]
>> +    pub unsafe fn field_read<F: FromBytes>(&self, field: *const F) -> F=
 {
>> +        // SAFETY: By the safety requirements field is valid.
>> +        unsafe { field.read_volatile() }
>
> I agree with Andreas that we should document the exception of usage on
> {read,write}_volatile() here. How about:
>
> When dealing with a potential race from a hardware or code outside
> kernel (e.g. user-space program), we need that read and write on a valid
> memory are not UBs. Currently {read,write}_volatile() are used for this,

I would use the singular `UB` here and below.

> and the rationale behind is that they should generate the same code as
> READ_ONCE() and WRITE_ONCE() which kernel already relies on to avoid UBs

s/kernel/the kernel/

> on data races. Note that the usage of {read,write}_volatile() is limited
> to this particular case, they cannot be used to emit the UBs caused by

s/emit/prevent/

> racing between two kernel functions nor do they provide atomicity.
>
> Thoughts? One problem is that I don't know where to put this document
> :-( Any suggestion?

I am a bit out of the loop on this one, but why not put into the safety
comment? I.e. explicitly state that this is *not* sound as per the usual
rules and it is a special exception?



Return-Path: <linux-kernel+bounces-568810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCA1A69AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9954265FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B562153FC;
	Wed, 19 Mar 2025 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="F2Or04t5"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779992046B2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418731; cv=none; b=V7M7dzWsoPfV2KzeQ92SlzFH6sK/+QS3tDulSYkYDtcApn5Ld6rkYpO0VrjnWm0RhI87ZBXKGvT5kjMoh4AwvsNs/fXi9vqrGM7loP1kVbT06GgGEUv2V2lk6/v8jUzYtz8nLXcZyteYoxBHSB3KcXMEYaIUWm1Vd60TjiyjhUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418731; c=relaxed/simple;
	bh=W79Rsy+zd+dgPSnOkEZWD7mS+bvrS3hy8Sfn2T1mSG0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqBo54lZWhW7tavaReiRVteJ1smS55vbCGtXUudZX2Cf5DYEmcr3n68oD3vEIy420u1Y+uIPpgYOY/SXHFBiXtDhNdcEEuZMn82P6qsOb+ZMRcZ63x1qNiAISGWhcFLFh74ffL5bAYTRjmIrPby7svGUDmtQTXo31zFXiWCaFuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=F2Or04t5; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742418726; x=1742677926;
	bh=XehIVCTSzumbYatfExiY6GZ+ddy62vDbZcUJxu968c4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=F2Or04t58U7gkMiwx+rCdLGrhDxEj2uR7c6OXEuxeBjYqK7kKLMYcXFTCw/TbpTNG
	 5ALGid4ZWLaY/QFmoFWt3vy3A0B8MOJE1UjGFGb0RgFhogA72vYC9acxjFZPrDX4nZ
	 qiXYG/mJwiCixedtHT+DjAshv1H8JBzgM83UDINYHsRL6QTz5ew7G3i231StbEMhBS
	 bq6O4EYAa7ouymAGWlHA//8g4X/fWWf7ceBd7X6BrZyhC9AcYgZAVp7aag8Ln1LSzo
	 MCwS2SMOU+Z3EHBomkc/EmBYpCLZXV/JChp+pTb4N0vb+L1tZk7K8r15OlpJeyXmle
	 DTPr7eW+3EeNA==
Date: Wed, 19 Mar 2025 21:12:01 +0000
To: Christian Schrefl <chrisi.schrefl@gmail.com>, Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/5] rust: iov: add iov_iter abstractions for ITER_DEST
Message-ID: <D8KJVUZUHCMQ.1WS0MBO4ZJLLM@proton.me>
In-Reply-To: <52db38f9-427f-4cea-826f-eae5f39480c5@gmail.com>
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com> <20250311-iov-iter-v1-2-f6c9134ea824@google.com> <XR-HMXHiYqCkDupCkyfLz4Rz-ucS6r5sCg1TmHQ7KeqAvf7-4ofJJcSCc2jKmS8WDivMc5oDgAYThptx7X_ExQ==@protonmail.internalid> <439baec2-dba8-4dab-abb5-faa14fbda943@gmail.com> <87v7s4g7ev.fsf@kernel.org> <52db38f9-427f-4cea-826f-eae5f39480c5@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f658f2b0a50a0efdf8e6d6207d32c5d30975fee1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 19, 2025 at 9:01 PM CET, Christian Schrefl wrote:
> On 19.03.25 8:14 PM, Andreas Hindborg wrote:
>> "Christian Schrefl" <chrisi.schrefl@gmail.com> writes:
>>> On 11.03.25 3:25 PM, Alice Ryhl wrote:
>>>> +/// An IO vector that acts as a destination for data.
>>>> +///
>>>> +/// # Invariants
>>>> +///
>>>> +/// Must hold a valid `struct iov_iter` with `data_source` set to `IT=
ER_DEST`. The buffers
>>>> +/// referenced by the IO vector must be valid for writing for the dur=
ation of `'data`.
>>>> +///
>>>> +/// Note that if the IO vector is backed by a userspace pointer, it i=
s always considered valid for
>>>> +/// writing.
>>>> +#[repr(transparent)]
>>>> +pub struct IovIterDest<'data> {
>>>> +    iov: Opaque<bindings::iov_iter>,
>>>> +    /// Represent to the type system that this value contains a point=
er to writable data it does
>>>> +    /// not own.
>>>> +    _source: PhantomData<&'data mut [u8]>,
>>>> +}
>>>
>>> It might be a bit nicer to add a (private) struct 'IovIter' that implem=
ents the common operations.
>>> Then 'IovIterDest' and 'IovIterSource' could store that struct and forw=
ard the implementations to
>>> it.
>>> But I'm not sure if that's really much better.
>>=20
>> Yea, I was thinking the same. Maybe we could have an `IovInner` and a
>> local `AsIovInner` trait that would give all the shared methods?
>>=20
>> I am sure Alice knows the idiomatic way to achieve code sharing here.
>>=20
>
> It would also be possible to use generics here.
>
> Something like (Maybe using types instead of the const-generic):
>
> pub struct IovIter<const DEST: bool> {
>    ...
> }
>
> impl <const DEST: bool> IovIter<DEST> {
>    // Common functions
> }
>
> impl IovIter<false> {
>    // Source functions
> }
>
> impl IovIter<false> {
>    // Dest functions
> }

I would prefer generic types, so `IovIter<Dest>` similar to what Danilo
implemented for `Device<Core>` and `Device<Normal>`. `false` and `true`
aren't descriptive and you also made a typo above :)

---
Cheers,
Benno



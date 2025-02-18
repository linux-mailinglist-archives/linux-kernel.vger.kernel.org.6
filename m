Return-Path: <linux-kernel+bounces-519396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53299A39C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8B6188C086
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C6C2475C6;
	Tue, 18 Feb 2025 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OtwbyIby"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19388246359
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739882505; cv=none; b=JlXZhxqJgjGjgdsU7ydARAyDx7iB8xavJNT5oBrjs4H9DbaUwlZqAfPtyLOpOSl/o8qfeinLr82jQ7x1KFCNGRzswdJBloUhS5Y5gsYrKn3VoLkExq5HHIrjPEnBQlErsSNmRxUqDCslDvNole7cKciOIdJStXsC5RX/8zjbi/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739882505; c=relaxed/simple;
	bh=LzEymOzbsaFCfZbS8DvP7Xa5WpoPyDkfBS8NNNj1zBs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxIk22V1eFHZ8rR5x8aLOp9HGoo85Vpp7fVQARwyh/zTXrSMHnSCutfG9gw0sDzHQOZn/+oKRm79WEvPUq041HO4h3whycKmkD0fUtUvihshDUZNQFYmD/nNSl9m1fr90R18sjUBjhSQ4stAI7pbFfWqF09kcPIhmwNLDtkFS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OtwbyIby; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1739882499; x=1740141699;
	bh=LzEymOzbsaFCfZbS8DvP7Xa5WpoPyDkfBS8NNNj1zBs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=OtwbyIbyZ12RfK0U18KBp0C8/Kw4Q4+weM+sx73BEMPrYwwAR7Rmo+p+yLMRqplCd
	 HSZxuNl/vcP6IJYgR8JqCCD61bFQHywIcEILWZ0qOXljtHL+7yPaIMSfDTy/dg7ei2
	 Ubn8G6mTe+2NBXR5zasSq8VxxB+XnaamstrKpsF+QBRsr8E89xPLDHLfZ+7BlBbcfG
	 DpX1MLvdX2ySI0EHrtHj1qnjfGXH4zPrMgGHxvBMaQd19rtyPz+xkXksb9oN5/x7ny
	 e1+XsnLqvfxTwnQjZVQmd2XzIW4ahjIHC37kApzhp5U6JuXU9GHvVfFYoc0HPZTJJc
	 7au8hbqILgmGA==
Date: Tue, 18 Feb 2025 12:41:35 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Fiona Behrens <me@kloenk.dev>, Charalampos Mitrodimas <charmitro@posteo.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rust: configfs: introduce rust support for configfs
Message-ID: <d76a0453-86d3-40c4-bc39-2ec8a71fbcb6@proton.me>
In-Reply-To: <87ldu3fnwf.fsf@kernel.org>
References: <20250207-configfs-v2-0-f7a60b24d38e@kernel.org> <20250207-configfs-v2-2-f7a60b24d38e@kernel.org> <S6DKlLVx4KKevl_q2zrW69Z7oS0jwyX4DXpDZrFiIy1lKo4VYHM52aDiV82c2yf52Ecr7t9FayuqBUPR9onvZA==@protonmail.internalid> <dd63fcde-ba4c-4a6e-9bde-1af5af37e91b@proton.me> <87h64su8ux.fsf@kernel.org> <Kkrr23DbfvS1nChcwAfhrogDdCOO92FQ2-9JUCab-_6CREP4iBX8k1KuxaJb-yv_ErGv9TbzDWwBZHvaszFS7w==@protonmail.internalid> <bfd79db6-bd79-4187-8577-3ae412f36f35@proton.me> <87bjv0u5j0.fsf@kernel.org> <87ldu3fnwf.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a9d121d1e911990ed26e6657f63e404cfee26057
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.02.25 13:17, Andreas Hindborg wrote:
> Andreas Hindborg <a.hindborg@kernel.org> writes:
>=20
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>
>>> On 17.02.25 12:08, Andreas Hindborg wrote:
>>
>> [...]
>>
>>>>>
>>>>>> +//!
>>>>>> +//! See the [rust_configfs.rs] sample for a full example use of thi=
s module.
>>>>>
>>>>> It could also be useful to just put the example directly here into th=
e
>>>>> docs instead of/additionally to having it as a sample.
>>>>
>>>> I don't think we should duplicate the code. As long as the link works,=
 I
>>>> think having it separately is fine.
>>>
>>> When I'm coding in my editor and read some docs directly in it, it ofte=
n
>>> is annoying to find a link, because then I have to open the docs in my
>>> web-browser.
>>> I understand that you don't want to duplicate the code (and it also is =
a
>>> bit too much for a short example), so how about having a simpler
>>> example? Maybe with only a single operation that has no associated data
>>> (use `()`)?
>>
>> Sure, we can do that.
>=20
> Actually, I am having some problems making the inline example compile.
> `configfs_attrs!` references `THIS_MODULE`, which is not present for
> doctests.

I see. Does KUNIT have a THIS_MODULE that we could use? If so, we might
want to make that accessible in the test harness. Does anyone know more
about this?

> I'll add the example but mark it `ignore` ?

Sounds good. If we end up adding a THIS_MODULE to the test harness, we
can remove the ignore later.

---
Cheers,
Benno



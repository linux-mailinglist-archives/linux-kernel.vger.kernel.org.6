Return-Path: <linux-kernel+bounces-301776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B4C95F571
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DFAA1F22458
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA41A194124;
	Mon, 26 Aug 2024 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="X+7HGJhG"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F37D192D72
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687182; cv=none; b=K+M/kmgkgYF8dgvTWQ6ujYAYEFPYTjd6gEfZsMYleTTIL6BaS2VA/yXjK3otJPPh7ZaaF///71fiRblCn85gcyKRRE270Uhmvr+DMIpLZH5hCXAuKItnY2seE4RzoWOlCoRvmziJ7sJAtlsf4vWuF6lM3rX/92IO4bRmbwmBn80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687182; c=relaxed/simple;
	bh=rijYHIP0Ao4lvCJLZaabkuQiGBKAVts2w69Ma/szZjQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=en3FAVQCuWIogLPoqm2hPsnxTWMIFUYCFGCvdav5zu/lB0uxV8crGFJ5C0tx0fziTNbzTcPoUEoPDrfU4GywTJ8LXxQI4Omj1K9SFGZ38cP1MD3P1MQCf+31VYW/C8HkHCX5LDKrf8MkNSu04JBXUrMhkyj2OqeMlHnESnSQ15Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=X+7HGJhG; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ewcidbvko5enbggt7fhozxovdy.protonmail; t=1724687177; x=1724946377;
	bh=1S2zdt5fhwBL6dRleG9sKZYBdZBYfRqGJChdpr7OXPg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=X+7HGJhGLPHX1+IPTRM1q+GrUynyMCtOkS7+gafxmPJtqPDa9ifCxgOW1Ga4oSGpy
	 leDnLCiFYCgudimQW6MX8lkDHV7KkhUDd8BVB2H06KpgzuQDpt5NHWjuSL89P7lFbw
	 Tvz8IRHhd6IyuNrzpSvX5Nsr92djm9JCIN2aNhD2qGT21FTDVUfw3zh1rZLTYeyhGa
	 /EGaTxdhJBqDFfkk4xKVbxKSD9FE0qpZTqXO0k7W0vurUl8+pEZg8aU9Zg+dzNB37+
	 uS71jDlgpeJDQm3EpNcqtIh1qdaiOts93d6X/iUYETMIilJLT5WupVHdeY37TbIZ2p
	 nW8F4KYQNYdMA==
Date: Mon, 26 Aug 2024 15:46:12 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: add global lock support
Message-ID: <91ce9f9a-5def-4f5a-ab9d-9bde4736cca0@proton.me>
In-Reply-To: <CAH5fLgjtSVMcKL4aMrNT=zJPGvzAPJt3qAUMYdB-+3=s80FNKQ@mail.gmail.com>
References: <20240826-static-mutex-v1-1-a14ee71561f3@google.com> <9feb41cc-cb1c-4d0d-a3df-09298e69af69@proton.me> <CAH5fLgjtSVMcKL4aMrNT=zJPGvzAPJt3qAUMYdB-+3=s80FNKQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 40ae1f2bb1268bc8d502447b32524023b018a751
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.08.24 17:31, Alice Ryhl wrote:
> On Mon, Aug 26, 2024 at 5:30=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>> On 26.08.24 17:27, Alice Ryhl wrote:
>>> +    /// Initialize a global lock.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// * This lock must have been created with [`unsafe_const_new`].
>>> +    /// * This lock must be pinned.
>>
>> You could also ask for `self: Pin<&Self>` and remove this constraint, or
>> is that not possible in your use-case?
>=20
> The value is going to be in a static, and it's inconvenient to have to
> use Pin::new_unchecked when calling this initializer. Not sure much
> value is gained.

Can't you use `Pin::static_ref` [1]?

[1]: https://doc.rust-lang.org/std/pin/struct.Pin.html#method.static_ref

---
Cheers,
Benno



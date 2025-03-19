Return-Path: <linux-kernel+bounces-567129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082AFA681AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44993B8635
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 00:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06ED12A177;
	Wed, 19 Mar 2025 00:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iV4TIxnu"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3C10E0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 00:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742345290; cv=none; b=CCKUprZA0BcU+a4/7JHoHVbq5tXhSM4Ylk63F7s8AFjWFTutusMAxf2Foofsqh0Ia8dyJHUTRt+OMpA02C6DzHDoe4r/NJ8Y+BjtFGwg7+gvOfBfdjIeDYRbHw1YSVWiyzfiVeS4Rx2Ohv5j6iPE1tw0I/PYCNVq3xdWPqxFD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742345290; c=relaxed/simple;
	bh=88RSRJHHBhxMshZ3imHtSjghTe5cGLoqBCcL/vxy7IM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhLmJqpb40rbAot0Nvz0mM5qQfuDCWjr5qkoi4fTEsk0W+rWlcs8Egz6gCmq9ewdnKTrpI52+0FoU/VxBGVDeKve1wwg7LaFfM1Hb2tPGZqyvmpTpindbFl62JZbGMnMGNRZ8STs4kc6gtBmRSWzuedar3CrrOuwrPS6xRjwtSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iV4TIxnu; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742345286; x=1742604486;
	bh=XsYfzUgN4o1yfTiUpKiI5jJ/eisefpfDOqZEdYuY4+A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=iV4TIxnuhmD58RFuM537UJVfxdSHQ4Ao8bQTQPqjDwB1POfPoV57CMLc08S66SF5/
	 qkpQlNjhPU7KDxkZKfByxBVXs5vgsOnebEVzEObc45fnYcNbYzsc9iv5O32or4JtHT
	 PggRnvDQhc2o/2JSHdrAjPJr5d2i9oZFPfvCwWavr8rkCNT27tLS/gB7ugORX1leNG
	 MMfE1ZJFXu7LDu/tsRurQ+hYF3d1TqXls0oA1YBaagKLmamkydZ3p+pvwUFpRRaJDv
	 v/Yms7SHDkz2Tghk3oukzxb8OTqCBa1/bEYGS/Dh24BMMVqAeM2OY+CgR8MF+PMys9
	 HvLxJiVExHvmA==
Date: Wed, 19 Mar 2025 00:48:00 +0000
To: Daniel Almeida <daniel.almeida@collabora.com>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v7 3/3] rust: platform: allow ioremap of platform resources
Message-ID: <D8JTUPQ28758.2SKKTA6IL6Y8E@proton.me>
In-Reply-To: <FF128DEF-28D6-4302-9C53-2DD4D417053A@collabora.com>
References: <20250318-topics-tyr-platform_iomem-v7-0-7438691d9ef7@collabora.com> <20250318-topics-tyr-platform_iomem-v7-3-7438691d9ef7@collabora.com> <Z9mwu-RHwZ8qwcbH@cassiopeiae> <FF128DEF-28D6-4302-9C53-2DD4D417053A@collabora.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 75237889a665dd04e655583ac856311a01bc0291
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 18, 2025 at 7:22 PM CET, Daniel Almeida wrote:
> On 18 Mar 2025, at 14:43, Danilo Krummrich <dakr@kernel.org> wrote:
>> On Tue, Mar 18, 2025 at 02:20:43PM -0300, Daniel Almeida wrote:
>>> +    ///     // Read and write a 32-bit value at `offset`. Calling `try=
_access()` on
>>> +    ///     // the `Devres` makes sure that the resource is still vali=
d.
>>> +    ///     let data =3D iomem.try_access().ok_or(ENODEV)?.readl(offse=
t);
>>> +    ///
>>> +    ///     iomem.try_access().ok_or(ENODEV)?.writel(data, offset);
>>=20
>> I'd probably write this as
>>=20
>> || -> Result {
>> let iomem =3D iomem.try_access().ok_or(ENODEV)?;
>>=20
>> iomem.read32(offset);
>> iomem.write32(data, offset);
>>=20
>> Ok(())
>> }()?;

Why use a closure here?

---
Cheers,
Benno



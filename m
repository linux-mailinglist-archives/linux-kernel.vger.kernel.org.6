Return-Path: <linux-kernel+bounces-566756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C41A67C24
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFC219C0F94
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14B820322;
	Tue, 18 Mar 2025 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CKZkYIQR"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F5211A33
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742323032; cv=none; b=VRuVx7WDYCEIdwSedqVB8m0TaJ5JvWnE0g2thnZPKuPM1g9zwztakaIbrJDt1WpYjxjeHfQxjjXA5EyqkPCBnAKjSpO0P3bGSc6FClUwTsIqfvliu2WpXrP7fydxQujnEKGt1jH3Ps7HICRpndYQFTMsqwqdjSf2G/FvwE75iyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742323032; c=relaxed/simple;
	bh=i7GuafmWBBFxpauQdZaROHEcBUjPAdboz1fmHtgeylA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgahsOBp2MWqnGCnTFLsAIhJesApSGxI9J3uf8/MYLzyiCvkYNsLt9kwfJHsuqDnAzlklsUOdF8OFkLyWhuMqS8+PEq/kZ7ZHYpw2Ng8ipM1vCM6RSG2OyUa6ANfznLL6ZeXaAI2m9omQO3uEdpyTOjRqVGl0qvT5/cbxVM/i+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CKZkYIQR; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742323020; x=1742582220;
	bh=Yqjw4oYBMyP+agQT2xlzF7ZEejJZSYZaTAXHjkwEyvo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=CKZkYIQRmel8zrpAeShCHV6LCC0P/elui7Y3GMW/++qszLvbDeng9caIx05kWj5Yr
	 A+q74S/EgDyd7gCsL3PgS2lV+gjaR5GgZz6GFu0iHzX0H97W3Xk6gBwykbRj+lZP2e
	 4RPoVYtWFIFkQtnwJqor2fLgX8LmsW15HzHeaNy5oioCZnCsIjy3wdY+mJ8M9HOTlf
	 ltvqT37p5z/397VQpODCVK9O8k9Lz6I3Mj2SsVpCizqYGGsAweyPZ4sLI9gjceBR4e
	 PrLQsdrlkfa/SI3rmgAJ4c+2ALZYHsQqFw59/wBwoQDXSCYgU7/Zf3Log2i6I6XYT8
	 dqjiQhroS3ZuA==
Date: Tue, 18 Mar 2025 18:36:52 +0000
To: =?utf-8?Q?Beno=C3=AEt_du_Garreau?= <benoit@dugarreau.fr>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, airlied@gmail.com, acourbot@nvidia.com, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: auxiliary: add auxiliary registration
Message-ID: <D8JLYJIT03KN.25S8FOEO26DOH@proton.me>
In-Reply-To: <20250317204310.7804-1-benoit@dugarreau.fr>
References: <20250317204310.7804-1-benoit@dugarreau.fr>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 52341dd8e7b999e11b7fcbcd4b0fa06e7b6ef2d4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 9:42 PM CET, Beno=C3=AEt du Garreau wrote:
> On Thu, 13 Mar 2025 03:23:52 +0100 Danilo Krummrich <dakr@kernel.org> wro=
te:
>> Implement the `auxiliary::Registration` type, which provides an API to
>> +impl Registration {
>> +    /// Create and register a new auxiliary device.
>> +    pub fn new(parent: &device::Device, name: &CStr, id: u32, modname: =
&CStr) -> Result<Self> {
>> +        let boxed =3D KBox::new(Opaque::<bindings::auxiliary_device>::z=
eroed(), GFP_KERNEL)?;
>
> You can use `KBox::init(kernel::init::zeroed(), GFP_KERNEL)` here. It avo=
ids
> the need for the first patch.

We probably should have the zeroed function on the `Zeroable` trait...

---
Cheers,
Benno




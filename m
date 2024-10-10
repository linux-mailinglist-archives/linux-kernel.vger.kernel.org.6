Return-Path: <linux-kernel+bounces-360132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76329994FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B7B1C22C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555631BE86E;
	Thu, 10 Oct 2024 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="O8cHpUgX"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4297A1ADFFE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598505; cv=none; b=Kv3Dtq9rlw7wdvyC49kPtkosfZa/YhtUXxskTqcopUWL3FRm2OinEArJXVrYyBJIUJRqheO5JJvVeNJ9C31JEvAxARWyS+HEqmGq09He1DPdBvPLILqFbKUd9/WneX9/7W9JOi9dIu0NCTyAGTkLcieELmM/lFDyDj2vgyfcGhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598505; c=relaxed/simple;
	bh=6wuvlwCa6TSt0v332U+6mY0pX9kM6s8vhMYzCkSEeEk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kojPoKg+WIMMzBTzKAkkMlQFiTH8VoPwpf7VwzCcdyaY5CgZYOX1I5M1bPpJH+Pvzsz/Ml87YyWoDI/4eBp8ubZQ5ENtW6NfVTzHqLQjKgV13o7oHqloL8kQkm3+226gxUHrGR3B/UdDm+rEAVS+J0m1ShJL6qhrLeiKqS2ipT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=O8cHpUgX; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1728598497; x=1728857697;
	bh=c2eztCA1e4UB4MlQh9sJYpniTjBOlUpjxUjuhUGTTBM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=O8cHpUgX+pv15xmM7aAjyhLNuYGKog5tKvySd3F4NoAmQFnRlieCKSa2meQA6560M
	 Lu0LsrdwMN17MXdhfJJZl2G3JyoxJkLNGhtXZVBKID61WeN0Zgi+w7AbtvUoa81IGV
	 oxnwf5UeA4v2bRTIZMLOClUUhZrPCKv969NZOF4DZCGy0w9Xm/I3SJ464oXAYL14nb
	 kwCWPywUfbRuYFtaVJT0kB+c2+TfsuhNnNLDWf1qX9LwFS0BdyOaoBhWbkHvamg0gc
	 7x3zqrOS0Gmvb8tiFKqPXPsCNzCIjQvNpFco+O5d4jLLqVtOkj4+O87tmfEav5Z9iF
	 2g3LXWWGALQDA==
Date: Thu, 10 Oct 2024 22:14:52 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rust: add global lock support
Message-ID: <2376e7b3-42a4-4743-a5cd-83251dcc0075@proton.me>
In-Reply-To: <87msjckqfw.fsf@kernel.org>
References: <20240930-static-mutex-v4-1-c59555413127@google.com> <HVPdDHj35lGMPHyA8YvYjO4hhof-vNaVDqo_ILwyCmuY13oskqVKxaIA7OK4wo6fWYeJIV_RMtbPdjVRGJcLvg==@protonmail.internalid> <1f688070-66bd-450b-ba5d-b929de64ecf0@proton.me> <87msjckqfw.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e1ab7e91a78749aba42462da63b16ce6f6adcaba
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.10.24 16:01, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>=20
>>
>> Also,
>>
>>     error: type `__static_lock_ty_VALUE` should have an upper camel case=
 name
>>        --> rust/kernel/sync/lock/global.rs:100:18
>>         |
>>     100 |               type [< __static_lock_ty_ $name >] =3D $valuety;
>>         |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: convert=
 the identifier to upper camel case: `StaticLockTyValue`
>>
>=20
> How did you manage to get these errors?

I added a `global_lock!` invocation to `lib.rs`. Otherwise I also don't
get them (they might also be emitted from the examples, but I didn't
compile those).

---
Cheers,
Benno



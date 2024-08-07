Return-Path: <linux-kernel+bounces-278567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976D894B1EF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2510C282C2A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3699C14F115;
	Wed,  7 Aug 2024 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RsUIVpWU"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE38146000;
	Wed,  7 Aug 2024 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065385; cv=none; b=Y7AoaBnSTL5EYlJCYpA5inzlx/Q65pNWsLY4pwPTWYIXuSoDVIsK9moNGrHwdf+4VqzDhKE++XcY6PPyJOodb6FaoXiS1+kSTPf+gJv2bi8axJ7xUU1NLoRrDMSQu78oPv8H8Km5DhAHANB/7vW3H4nTrAtOd2qaLkbYNueuEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065385; c=relaxed/simple;
	bh=dLOmdfVgvOwOfZUsPQ52Hp/9+a/kWmgAfB1AFx7yfa4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiZ+IZG65mexI/f2skqk0k89+egAs07AGfibYwwH0QqKRFevI3Azt2LdwjdIcF6ZkoSDAPIvOBHsqGfkvztyOpAtxQrG1w1s7QtR75z5A25SprqRJxsF5oFnQKRO6WgiYrxuDilEBg7WAJTARB8Zq2tNpk9bVDrHv0zu2OSASQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RsUIVpWU; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723065380; x=1723324580;
	bh=998UXmzv/ptANrr7bqsCiWLbRf3e/azzoZjmN8b+fjs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RsUIVpWUc46mDvo7Daj0WNeDsiWe1O+UyyginEoteSITvRdCgR/FJ6QXvwN+9Gqo1
	 TuXzwypE9e+9LBd90Y8KPrhK69IPAcg4fRSH89/1LDZZeCmqVVsyzzTTdPlz8Nm5C0
	 /syb956gYvzdy/+3vvkZJWHeWwlSkONTXQKikueUQvgE0+s01dYyILVYObqFQWZ6M0
	 LQhvYsHt0u6YMUBWKOaseZpTyjDaoK+RxRIEhap76ohe928wHllw/+Ptahh2tAFB4V
	 Kwm4qQI6Bjch6nKFxTWS6F+VESgWnS3hIVRM9jLiEDfP116qAgyvNrWXX/nfGM1zlE
	 OTov+hqGrwnKQ==
Date: Wed, 07 Aug 2024 21:16:14 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 10/28] rust: treewide: switch to our kernel `Box` type
Message-ID: <76087268-f557-4920-9798-9969d283dfac@proton.me>
In-Reply-To: <1b17b4b3-69b4-4af1-a816-b401a1bb6ef2@proton.me>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-11-dakr@kernel.org> <1b17b4b3-69b4-4af1-a816-b401a1bb6ef2@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6d96158f694295894b9122ccaff382035247a0ea
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.08.24 22:57, Benno Lossin wrote:
> On 05.08.24 17:19, Danilo Krummrich wrote:
>> Now that we got the kernel `Box` type in place, convert all existing
>> `Box` users to make use of it.
>=20
> You missed a couple usages of `Box`:
> - `rust/macros/lib.rs:{242,251,281}`
> - `drivers/block/rnull.rs:{35,50}`

I also missed some rustdoc links: `rust/kernel/init.rs:{16,746,852}`
(though these should probably link to `Box`)

---
Cheers,
Benno

> or is that intentional? (for me rnull doesn't compile after this patch)
>=20
> ---
> Cheers,
> Benno
>=20
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>>  rust/kernel/init.rs               | 41 ++++++++++++++++---------------
>>  rust/kernel/init/__internal.rs    |  2 +-
>>  rust/kernel/sync/arc.rs           | 17 ++++++-------
>>  rust/kernel/sync/condvar.rs       |  4 +--
>>  rust/kernel/sync/lock/mutex.rs    |  2 +-
>>  rust/kernel/sync/lock/spinlock.rs |  2 +-
>>  rust/kernel/workqueue.rs          | 20 +++++++--------
>>  7 files changed, 44 insertions(+), 44 deletions(-)
>=20
>=20



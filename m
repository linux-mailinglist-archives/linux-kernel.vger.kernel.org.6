Return-Path: <linux-kernel+bounces-286749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D5F951E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1002B253D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1685E1B4C32;
	Wed, 14 Aug 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eyPX261q"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEC11B3F39
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649306; cv=none; b=U0ZTbVfZovfEr3/wGmF5yxe9VBaMVkFjJR1xbTSZqPLDXQ4g7lVryQC/uHMLQnA4F1YBFQZxvLB2ITjHPsVbB23uvZS4Fi6uPKiT3EkD2dSZrND/t2l4SGD3mcfizLji9NHngk7HOjg3hzFMXLvu4QzzY+ZcKeNm56d9pUuiuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649306; c=relaxed/simple;
	bh=MuR0TzKoD/82H6FNhNsVi/6dcgoRuB0EnRcZ5RZ2w38=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fafJn8JKys1VnJjsbXPGY4/ZhJnT63LlAQGzmDiW+aRqWIq5ZKDPi33xUuIrPds8a6ijrXOGl2C9T8amKNA16DptC8R0r/KYeNQSHGcEjSKIC8VLQGEVdnND6AsG3I/2b1JL5Qd3wE0wYVfPrdiS6QjabazcAsGLgbJ5aJZKajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eyPX261q; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723649293; x=1723908493;
	bh=MuR0TzKoD/82H6FNhNsVi/6dcgoRuB0EnRcZ5RZ2w38=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eyPX261q1+gOa00RCdL3H899nPWsg3bAblFMAyKWWTMD84a+INhfR5feerWgyNj21
	 KyB6SZlHj2eGIrCmCmvnWmqBusIYbmmhjLi9mzcpAKaV13pMulyRgXgRa3oSj2p3SC
	 9alhP9UN/h2oZJOBAOPN+vsdxjNdEvbLIOxzRmViDEMbaUYK3mBiiGp4YgpmVljUlE
	 t0HmusHD7/Wiifd/hhmMrCW70tsGBCMcTNjm1SRVV79BzZHrRGNgpgls5W6sy6GhQK
	 8NiixMLXgWB8hA810jwVM7WlxwerE/ida5NKEd3hHa9AljONB5Cqn01YN3j7Tw5dtx
	 3KnFtXGBtdYIA==
Date: Wed, 14 Aug 2024 15:28:10 +0000
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <fae5176a-20bd-4ed4-b61c-5114adc674fc@proton.me>
In-Reply-To: <ZrzLHu5Ey9vLwNJg@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-5-dakr@kernel.org> <CAH5fLgit0hSFWi_Bv4DFK6vvhoLfSz=BMaPDBU0Z0oyZta9U9w@mail.gmail.com> <Zryy04DvEsnxsRCj@pollux> <CAH5fLghsONUtxFPgD6vC139H-Uj5LDju7w5eS0JB+BnDMmfngw@mail.gmail.com> <Zry1qwJnPDUtp2Nw@cassiopeiae> <CAH5fLgjNfJyyZygWzeTyrNi8TQNAquufxFxDgJHzq6dan=b9BQ@mail.gmail.com> <Zry4iOGtR0nd6lNP@cassiopeiae> <CANiq72nsSOaG=WhGP5GUQ=ygCh23iDQBc0kgjRP3B5MoF0CUjg@mail.gmail.com> <ZrzLHu5Ey9vLwNJg@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3b4c5c06824648ccad7be788c21fcae10398f170
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.08.24 17:19, Danilo Krummrich wrote:
> On Wed, Aug 14, 2024 at 05:03:21PM +0200, Miguel Ojeda wrote:
>> On Wed, Aug 14, 2024 at 4:00=E2=80=AFPM Danilo Krummrich <dakr@kernel.or=
g> wrote:
>>>
>>> If we keep them, we'd consequently also need to add them for vrealloc()=
 and
>>> kvrealloc(). But again, they don't do anything for us, and hence are mo=
re
>>> misleading than helpful IMO.
>>
>> In general, they could do something (e.g. `noreturn`), perhaps in the fu=
ture.
>=20
> Indeed, and I think once they're honored we should add them again.

That sounds like it will be a lot of work, going through every function
and checking if it has the given attribute. Especially when the
attributes are enabled one by one. I think we should keep them (and of
course introduce them on new functions).

---
Cheers,
Benno

> It's just that I think as long as compiler attributes aren't honored, we =
should
> not have them in the first place to avoid confusion about whether they do=
 or do
> not have any effect.



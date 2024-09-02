Return-Path: <linux-kernel+bounces-311902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DAE968F2C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 23:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8BC1C22199
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 21:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2B7205E25;
	Mon,  2 Sep 2024 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bbi+2nPC"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F631A4E8D;
	Mon,  2 Sep 2024 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725313089; cv=none; b=ZeZuPkAcRYsM+muWiszDxNgYZg3QZ1bDi6i9R23ZjHZBanOLgEMJAxp4YU9BCchP0mxLOcP6AXnM6L2w1dxplgrg7jUkcP/pSwL0TeuIPSN2jJh+dhk3erORXftkFSsIglWbKMdR5xF2oPQjtUCveck9zJhTS4n0maQNUtLR4DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725313089; c=relaxed/simple;
	bh=vrpGGX2NQaqB57eYvVx4w0vr9yKpbPl3dneG1r9ulYg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUkCzlTvrIVgq9Xs0lwtjp+9matpxHgFU4QnRRMd6UwN8gjTZhnMNr5/zAUMr17NCFx6d2c374+TzRzzitGI/w3IAFQy7seUAZTicUVOCUjHBMbxJluHMsze8awf0lOAomvuCVD4xoAnYJB1flLcN66+f0aNMgyzAKzOvl3hV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bbi+2nPC; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725313078; x=1725572278;
	bh=vrpGGX2NQaqB57eYvVx4w0vr9yKpbPl3dneG1r9ulYg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bbi+2nPCJiC7dzW8V7s6DjzmTt/HNKP6qO/dzWIYHqbnS4lpSmw8wCH7pneT2pIE+
	 te/S8ihHAtqpSzIgwPRsQm6VsinOU08Nn0WKkBS33kZvpcQOk0jzznKpD+iGGZJF35
	 OKmVmTBnyaM4BaV5OZwMCbparlgeZSqpRiT2krcebKDeUd8CBxuArnGr4AAEko7w1W
	 r5hSK5bOVP3Pg1TGi3xGg2T0xmDKSTu0GJ5PFRy4lfpiMs1fWh391vkgT/aBWs6BTe
	 u6uAFFKFo+fjkalNHi9RNvKr3d5jdkA21cGztCurkRdANjRikx+yS/qb2e0KwiYuru
	 Kg+/xgpKVuZXw==
Date: Mon, 02 Sep 2024 21:37:53 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: add global lock support
Message-ID: <8bcd10eb-97ac-4dbf-b59b-b7f12c4e24c6@proton.me>
In-Reply-To: <CAH5fLggE-fWDuZXH_F3ixDSo7sQEFwnUV3cd+9_rpFH+XmnA2Q@mail.gmail.com>
References: <20240827-static-mutex-v2-1-17fc32b20332@google.com> <10453342-d269-4b78-8962-821ef53d3cb5@proton.me> <CAH5fLgh-DYvXobXQVaQ9txYS4Rx8QhjyVvfTphk6vvnUOGzPnw@mail.gmail.com> <3b557f61-cead-4568-b2b4-4a56c4cbff52@proton.me> <CAH5fLggE-fWDuZXH_F3ixDSo7sQEFwnUV3cd+9_rpFH+XmnA2Q@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ca9e744c05ead387e4ea040278402994b57024f5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.09.24 13:37, Alice Ryhl wrote:
> On Fri, Aug 30, 2024 at 3:22=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On 30.08.24 07:34, Alice Ryhl wrote:
>>> On Thu, Aug 29, 2024 at 8:17=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
>>>>
>>>> On 27.08.24 10:41, Alice Ryhl wrote:
>>>>> We don't currently have any support for global locks in Rust, however
>>>>> they are very useful and I have needed to work around this limitation
>>>>> several times. My workarounds generally involve initializing the mute=
x
>>>>> in the module's init function, and this workaround is reflected here.
>>>>
>>>> I would not exactly call this a "workaround". If your use-case is
>>>> covered by putting a `Mutex`, then I would prefer it. Or did you need
>>>> additional ugly code to access it?
>>>
>>> Not sure what you mean by "putting a Mutex" but the workaround is
>>
>> Oh sorry, seems like I forgot to write the rest of that... Let me try
>> again: If your use-case is covered by putting a `Mutex` inside of the
>> type that implements `Module`, then I think you should do that instead
>> of using a global. (you need the inplace module patch for that)
>=20
> I don't think it's possible to access the `Module` struct after `init`
> returns? Even with in-place init.

Oh I see... Maybe if you create it inside of an `Arc` or `Box` and then
pass it to something inside of your module that will then be called by
some other mechanism?

---
Cheers,
Benno



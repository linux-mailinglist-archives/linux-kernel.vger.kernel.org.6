Return-Path: <linux-kernel+bounces-534804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982A5A46B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A596D3A80BE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D293E2566EA;
	Wed, 26 Feb 2025 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARv1ZI1i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C1254B0D;
	Wed, 26 Feb 2025 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599261; cv=none; b=pZWD5WAf07lf2eo6XzvRqhTTd9jDzcqchBlNLGpH7LuqmUdTf7IbvnfBK3VfnNgJEytvqLDgplr5c2uWZzXMDh9WRtpRY7nTawlH1yJF8wUBQ3uOcU2hLf75x5WGPDOWN7G3TjGu0TTjvYvE57KPjJYFmucw0GAshsPLZJjoJps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599261; c=relaxed/simple;
	bh=kSTQh4ZFrGmP0eQD82eB6qaqkRhJbOfdSRo8DWtPJXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oi+WZWrugsAjhVnNkwAlhHXjdiHBDeMxmLMFf1beJbZLBZfHhMhTxGNP9w9kUJS72Btg8k5XqjXCpnGMFFY0cn4UIfN5Wm18ZtO2Cuz+rt6NKRnLCp9dhZ4knz0Vcgp3twDxUl5m4lLd+ule8NlW/rj/Eqwbr/xrXAoTlH+HYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARv1ZI1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D51C4CED6;
	Wed, 26 Feb 2025 19:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740599260;
	bh=kSTQh4ZFrGmP0eQD82eB6qaqkRhJbOfdSRo8DWtPJXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ARv1ZI1iWU+FJN4wd1NHMNnWSE2HLfdqhs2UhZvvlAhE7ok3kR9USW8KWuKX9Y9jW
	 QW0ISZG7qV7vcsiapztWdMz2XTz5tP4M7gWKHV/l0UB8BUoYuzDDKxk7vUs9nLlurV
	 Q5o0tCJDn6b9TxMmqleEqrPxPfXF2kOjaON7tu+jhkkMbxxnohoJvPZRjx8wxJpA1G
	 dYMJgCYDbNSivxfHWFZF77p+NJY7OXeIHnio7KeWgu2x/HrXzBFdl8F0ZOLNyyBmb7
	 cuc8aCsAswYU0+vB5A8+Z3thcNBcMgX0IYpuHyE8uLRdSKeThpk+rIaJoGgb/8GYvD
	 Q6VI7ehdWy+Qg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Frederic Weisbecker" <frederic@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Thomas Gleixner" <tglx@linutronix.de>,
  "Danilo Krummrich" <dakr@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Lyude Paul" <lyude@redhat.com>,  "Guangbo Cui" <2407018371@qq.com>,
  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  "Tamir Duberstein" <tamird@gmail.com>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  "Miguel Ojeda" <ojeda@kernel.org>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
In-Reply-To: <Z79B4brrB_-SBstl@localhost.localdomain> (Frederic Weisbecker's
	message of "Wed, 26 Feb 2025 17:31:29 +0100")
References: <Z7yUTNEg6gMW0G7b@Mac.home>
	<CANiq72kx31exTFohb3+9_=PGUq_JtqpCvG8=oQUc_gZB+De5og@mail.gmail.com>
	<Z7ye0MsACNWe7Mbr@Mac.home>
	<CANiq72=qayfPk+W4BRiXe9xBGcgP2zPf-Q3K6GXTg8MKy-Kg=Q@mail.gmail.com>
	<WlwmQ3r8VXTu77m77jclUgLjPh65ztwxUu_mXaElarFHBBiG2kWi0ZLYWNxKAUF9LK2QYrOWhtlFYhwaaNjYRA==@protonmail.internalid>
	<Z7yl-LsSkVIDAfMF@Mac.home> <87msebyxtv.fsf@kernel.org>
	<4UoaifxB7JgBVKsNQyFR_T8yc3Vtn5TLAEdxdXrojNmOzJSEncopauEyjDpnbqzr8Z74ZWjd_N-bB-BwBS-7aQ==@protonmail.internalid>
	<Z7zF8KF9qTCr_n4l@boqun-archlinux> <87bjuryvb0.fsf@kernel.org>
	<YHV6PAwDnW48w8pF0E79C4QpO8sH_MSXF7-b9H_kxDetoAA3tlCUC7Udr_u0UUoBrelCaFusL4F8HyiOHr9qgw==@protonmail.internalid>
	<Z79B4brrB_-SBstl@localhost.localdomain>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 26 Feb 2025 20:41:27 +0100
Message-ID: <87wmdctrx4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Frederic Weisbecker" <frederic@kernel.org> writes:

> Le Mon, Feb 24, 2025 at 08:52:35PM +0100, Andreas Hindborg a =C3=A9crit :
>> > It's of course up to hrtimer maintainers. But I personally nack this
>> > kconfig, because it's not necessary, and hrtimer API has been stable f=
or
>> > a while.
>>
>> Having the switch is fine for me, removing it is fine as well. It's just
>> an added convenience that might come in handy. But having this kconfig
>> very close to zero overhead, so I do not really understand your
>> objection. I would like to better understand your reasoning.
>
> If you choose to make a such a Kconfig switch, it would only make sense
> in order to spare some bytes when no drivers use it for example. But if
> you're afraid that the Rust binding is on the way while the core is
> changing some API then I guess simply disabling Rust would be enough for
> testing.
>
> I don't think it's necessary (unless it's strictly selected by drivers).
> But it's your call.

I that case, I will drop it. Thanks for chiming in.


Best regards,
Andreas Hindborg




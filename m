Return-Path: <linux-kernel+bounces-336110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 367EC97EF54
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9D31F21FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AE019F10A;
	Mon, 23 Sep 2024 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5AXNdgR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0528E7;
	Mon, 23 Sep 2024 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109345; cv=none; b=ovlnx0fmi/kZ32VqvnqabFreJHBCuXhAw4DjO6TeuUjC6MhctfXoG+WGjtZJSCfaqUdG03iWDDPk7Kv5q1CvFK05A8c0nfwc5NmBZb+FdgikQ/uasKlAusEvT1hdkuUKX+YavB8/+rWD5OJ0G3ml06rbbPcy+q3AT4VuKlSHFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109345; c=relaxed/simple;
	bh=iTOG7Xc5sHlK8i4dyCJeLYXSja/Mymt6V/Va+xmyvYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J6rO4M2FkDnimny6pxadF6RVFBz5vaUscN0OJ3mYRanEZjfgQyKTa7YBDH4CgwgPHNd0LxyjcJx0+gVb1UaN9RjZ+u0HgNiM9IWzmCD1EizoIWVuqC3uKiFrt8Cbh89eND8Z6TH0f8fn0JHqlmnWNgI5P39R7ZBndmPd0D3Hbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5AXNdgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F559C4CEC4;
	Mon, 23 Sep 2024 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727109345;
	bh=iTOG7Xc5sHlK8i4dyCJeLYXSja/Mymt6V/Va+xmyvYE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g5AXNdgRhTN00Flf73ERmDDQt0yuXB0tKlf9uA219Ahy/hPC2678QNnurPzCaZ5Hq
	 nwcQ0VwgxkYH82Ax8rO7qeqXeOf3ei9+0WVV7GjGspQGpr2lD3nyeLy6TN1dO+wrqI
	 OObaT4cOBn7/uxXhd+G6RsRUf1wPEtrkhSl/DX76cwrl7qFU1/O73MYWeuGaxrJA//
	 a/mhynNWoJoA0LRhbL8w2n536Xmy5XJYCdDMbT9VBMgBxoYAZ7wDo2GzdJV374CQqi
	 jMrMDwQoAVPj7lNIqK65aFyGr3G4GaKszrl1oMO5+lxVbuO2v6DmDEXQhFoO7QoLcu
	 L+ioQ6VHgkZ+A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
  "Frederic Weisbecker" <frederic@kernel.org>,  "Thomas Gleixner"
 <tglx@linutronix.de>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/14] rust: hrtimer: introduce hrtimer support
In-Reply-To: <33c65715-3af5-44f9-93c5-149d07a4c503@proton.me> (Benno Lossin's
	message of "Thu, 19 Sep 2024 14:09:58 +0000")
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
	<20240917222739.1298275-3-a.hindborg@kernel.org>
	<Wohby8PLjQeZ47sXKGeWKOxdA2ShTjjvqOM6xWzhJY1aZ-SYk9TCDAnZN2EqiWuJUKwPKoFCsCofDHjtfeG--w==@protonmail.internalid>
	<f502f6c6-40b7-4ec4-8d0c-09adb0df1a30@proton.me>
 <878qvojj0o.fsf@kernel.org>
	<pvhILkKRTj8T2Ks3off5HLMqewNM_X192WV4J5-nnC4Uu0o9G8-Qk5Tl9bQxsqVCw4QHmeJii7mCK2VorN-xcw==@protonmail.internalid>
	<33c65715-3af5-44f9-93c5-149d07a4c503@proton.me>
Date: Mon, 23 Sep 2024 18:35:27 +0200
Message-ID: <87ldziqqeo.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 19.09.24 07:43, Andreas Hindborg wrote:
>> Hi Benno,
>>
>> Thanks for the feedback. I will incorporate all the whitespace
>> suggestions you have =F0=9F=91=8D
>
> There seems to be something wrong with the encoding in this email, is
> that an issue on my side or yours?

It seems to be on my end. It also showed up on lore with errors. I will
check my tools.

[...]

>>>> +    /// until the timer is unarmed and the callback has completed.
>>>> +    ///
>>>> +    /// Note: It must be safe to leak the handle.
>>>> +    type TimerHandle: TimerHandle;
>>>
>>> Why does this need to be an associated type? Couldn't we have a
>>> `TimerHandle<T>` struct? The schedule function below could then return
>>> `TimerHandle<Self>`.
>>
>> At one point, I had some cycles in trait resolution. Moving generics to
>> associated types solved that issue. Maybe this can be changed to a
>> generic. But are generics preferred over associated types for some
>> reason?
>
> The associated type is more complicated IMO, because then every
> implementer of the trait needs to create one. If we can avoid that, I
> would prefer a generic type.

When you say create, you mean specify? Users would not invent their own
type to put here, they would use the types defined by the `hrtimer`
module in later patches.

BR Andreas




Return-Path: <linux-kernel+bounces-525350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E8AA3EEE0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58AFA19C494A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C9F201253;
	Fri, 21 Feb 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYVfyiFm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4923D1FE470;
	Fri, 21 Feb 2025 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127254; cv=none; b=B2ibBlaI/Wc8K2vfvl/7oIpQriuBtjB4kktN9xKjMgSNlLuV2WDl+G3pa20LBuXh+OyXRG+2R1aacPMetwWvkuZfeFREE++iqGi1la0vW/EDehaJgaPCUST6pvk+w2rt0GvLHBJsxuxiiSGDiWmgDIBEnmH3r0O7+gqePG38wqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127254; c=relaxed/simple;
	bh=ksiB2feXfFyAELIxHHK8fCEYWlhK7aI5fAfT5cd0t0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rzxHblYedxX2mX07snz+Xe1uaqpJRuBi/TorV+eBuHoeFJVtaDWal07e9JBrqB2OeGJtVIKkozk0W+Tzrd1KmI0cCs6Sk4csmTVFXENe2TNLzAD1NAu2vGpOHYwBQd0jZgGA/zENQbyfIXeIRFGCe3a3NVb0Vq8cmZrVWTJ3s3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYVfyiFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FB6C4CED6;
	Fri, 21 Feb 2025 08:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740127253;
	bh=ksiB2feXfFyAELIxHHK8fCEYWlhK7aI5fAfT5cd0t0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FYVfyiFmh5QuGh0Vp1hYQumPGGAjAaTaJE7TQ4wiOyLLDp1svjzeIXzKH0oizVoRZ
	 pvwF1Cr1jUUZ3hH+1dHhqIkJ8nQM0hq2y/R+5IA89UXH2YeMGMVTUkjMbxLTxU6fw9
	 OXyt10P6naj5fLTWprcUT0yULsCWNDwkeQymG5y8lb+/I9St/uT+a7p7SvlUhFAbIy
	 9aZVTRqUfYSF5IHV8xUEP2RK725NVhaCam69EmkgEtbMY5dtZdBLoRNxywa9D+u5i8
	 kiw54MSb1Bc69JwJK50E/7O+MWDNoHA8rDdUvI9jFMS2L30IZ56X2Qu4Lzi0uVj/47
	 R6jk3WqmZlBPA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Frederic Weisbecker" <frederic@kernel.org>
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,  "Thomas Gleixner"
 <tglx@linutronix.de>,  "Miguel Ojeda" <ojeda@kernel.org>,  "Danilo
 Krummrich" <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,
  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,  "Benno
 Lossin"
 <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,  "Guangbo
 Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 00/14] hrtimer Rust API
In-Reply-To: <Z7eYp_vZo5yDVOdI@pavilion.home> (Frederic Weisbecker's message
	of "Thu, 20 Feb 2025 22:03:35 +0100")
References: <aIJ0ymzdUceCN05hwJpth4erH5u2SHYzYl52wGeT3uiO9bdk92ZkEmEEq9a9NXsInJYSz9uziwq-1fvdsXoeDA==@protonmail.internalid>
	<20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<877c5mci3p.fsf@kernel.org>
	<5kF-NYTBZbEqnnQud5LKnRXO0lfM0i6I2PoeFrpKDhCYwUuk_bG2Li1T1Nuv82r3VFD8adTcdx7yenXSIfTwmw==@protonmail.internalid>
	<Z7eYp_vZo5yDVOdI@pavilion.home>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Feb 2025 09:40:41 +0100
Message-ID: <87frk7hera.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Frederic Weisbecker" <frederic@kernel.org> writes:

> Le Wed, Feb 19, 2025 at 12:02:50PM +0100, Andreas Hindborg a =C3=A9crit :
>> "Andreas Hindborg" <a.hindborg@kernel.org> writes:
>>
>> > This series adds support for using the `hrtimer` subsystem from Rust c=
ode.
>> >
>> > The series adds support for timer mode and clock source configuration =
during
>> > timer initialization. Examples and functionality to execute closures a=
t timer
>> > expiration has been removed, as these depend on either atomics [3] or
>> > `SpinLockIrq` [4], which are still being worked on.
>> >
>> > This series is a dependency for unmerged features of the Rust null blo=
ck driver
>> > [1], and for rkvms [2].
>> >
>>
>> @ timer subsystem maintainers: did you discuss how you want to set up
>> maintenance for this yet? As mentioned, I'm happy stepping up to
>> maintain this, but if you want to handle it with existing resources that
>> is perfectly fine as well.
>
> You're the best candidate to maintain this code since you wrote it :-)
>
> Also I personally have near zero skills in Rust as of today so all I can =
do
> is to vaguely keep an eye on the binding's interface and keep in touch
> with the changes.
>
> So I suggest you to add a new entry with you as a maintainer (I suggested
> something similar to Fujita for some other timer related things) but plea=
se
> keep us Cc'ed for future changes.

Alright, lets do that.

Do you want to pick future changes to this directly form list or would
you prefer that I send you a PR with changes?

We are probably going to have a new iteration anyway, as discussion
picked up again.


Best regards,
Andreas Hindborg





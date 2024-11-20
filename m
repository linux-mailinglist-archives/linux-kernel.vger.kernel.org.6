Return-Path: <linux-kernel+bounces-416031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98649D3F61
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805021F2369A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27E0149C7A;
	Wed, 20 Nov 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSF/9amC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A039146A68;
	Wed, 20 Nov 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117923; cv=none; b=P/bH8odclHOVUpCDux20RCbBgAKqDplQcCBUgINN3xJdzOzNb8PrYnCGJ8idjZlaAjoh3J/WHquGJkixJrk5z7imQG2xVoO8lmccAodJeeh1ZnqPB3vs9xmUrdZwGBR+cPqgktdtZ0VXqTx87ddXRZrD13RQ00vs1StjJpNRXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117923; c=relaxed/simple;
	bh=6LkBqc0nUGBQIcdov89e7517186sbIo3bG4Iy8nbnzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XfPyadCp2RcJdLkCR+d4X9wywBUyITLAgKGKFvUjh4oc811gu13y45OedtTLq2M2/S0HS97bU1fag4Y6XfWHITs7sdAk5bdIK6CUsOTQl3VZ28/eHTxwIvDEi3uSSwF7lWDBbyEZ/BdH8nNI6OOa4q1RWbihHENNLY7IIChRKNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSF/9amC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F8DC4CED1;
	Wed, 20 Nov 2024 15:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732117922;
	bh=6LkBqc0nUGBQIcdov89e7517186sbIo3bG4Iy8nbnzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QSF/9amC4g0rYYNLTXOsaeKqIl3goWxb238VdwzVsxjxb8eiawh2YMMQ3gXs+7/Sd
	 Phvs4NmmHNQqKkGWUUgcvK3bZpt53TRJwcuUXAnxf23M4VZTlihNYA9pjRLYdqTekN
	 KRyH27U1krAac/M81jnbaN/r7DaKEmz4JMHRsBXIMhXIwWyjl/ej+zcfUE5te1zZlu
	 rsa/MnJdTuo0MXv6E/vcCEyNMMEg6b7HdLbnq9DYbRlkuymVKhkIcGEFoKIMwhHTMp
	 i1BAUmKrAz2UICMTBgjoBgC+yJsr1AVjT2SEePUzAZevIiASJZ0QR1yVRHTzPLFciY
	 wbIjtw3XYATQQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Lyude Paul" <lyude@redhat.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 02/13] rust: hrtimer: introduce hrtimer support
In-Reply-To: <87v7wzoliv.ffs@tglx> (Thomas Gleixner's message of "Thu, 07 Nov
	2024 02:55:20 +0100")
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
	<20241017-hrtimer-v3-v6-12-rc2-v3-2-59a75cbb44da@kernel.org>
	<QA3miMIm4BG2RgY2gQ8ttfBKoFBApRq9bdSsMkMXQ55xrBv-Q27QhFc1Nh7owUyNxM3ZxMr7Jurin6fPvI80qg==@protonmail.internalid>
	<87v7wzoliv.ffs@tglx>
Date: Wed, 20 Nov 2024 12:41:47 +0100
Message-ID: <878qte3zes.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Thomas Gleixner" <tglx@linutronix.de> writes:

> Andreas!
>
> On Thu, Oct 17 2024 at 15:04, Andreas Hindborg wrote:
>> +impl<T> Timer<T> {
>> +    /// Return an initializer for a new timer instance.
>> +    pub fn new() -> impl PinInit<Self>
>> +    where
>> +        T: TimerCallback,
>> +    {
>> +        pin_init!(Self {
>> +            // INVARIANTS: We initialize `timer` with `hrtimer_init` be=
low.
>> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtim=
er| {
>> +                // SAFETY: By design of `pin_init!`, `place` is a point=
er live
>> +                // allocation. hrtimer_init will initialize `place` and=
 does not
>> +                // require `place` to be initialized prior to the call.
>> +                unsafe {
>> +                    bindings::hrtimer_init(
>> +                        place,
>> +                        bindings::CLOCK_MONOTONIC as i32,
>> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
>> +                    );
>> +                }
>> +
>> +                // SAFETY: `place` is pointing to a live allocation, so=
 the deref
>> +                // is safe.
>> +                let function =3D
>> +                    unsafe { core::ptr::addr_of_mut!((*place).function)=
 };
>
> I assume you are sending a new version of this series due to the
> reported build issue.
>
> If so, can you please rebase against
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
>
> It contains the new hrtimer_setup() function, which initializes the
> timer including the callback function pointer.

Yes, I was going to rebase on `hrtimer_setup()`. I'll get it from tip or
upstream if it makes it in before I send the next one =F0=9F=91=8D


Best regards,
Andreas Hindborg





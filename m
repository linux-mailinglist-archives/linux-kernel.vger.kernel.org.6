Return-Path: <linux-kernel+bounces-525464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FE7A3F050
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F2186101C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA5C204F9D;
	Fri, 21 Feb 2025 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClMGxG0S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DDD204F80;
	Fri, 21 Feb 2025 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130211; cv=none; b=WM3V0qmJ5Cd+8Vn6fFFQ5pj2i4DIe4cJ8Z6bXR1Bvde1eQlaDDd417xNFXLAYH1gk084q/MipjCUWVMzXOjX0b6OfK8iJ8o7cmtxhRNAputbD4uUtVOsK15kTRmmqqlrO3jMFizLHWgFmArMhDO0ts3DNncjrSI2Ll+skHX3/m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130211; c=relaxed/simple;
	bh=phdfQPrKfgApIH7mf/yVXltPVQWBUOKvkJ/2k3qSj5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WrOsFh74F2UeGouK2eznIiodLRzDJpzG23mHF/ZIa47YZCHuRFddG7K9JE6kf2FcfB6/jqNCPaJdxs64Z0nhVMMo/hF1XBw7GsLoi5XNaXRN95TiVO/1CYTcR6tzm/mrtpJE+fJxKd3V+Qjg6EXHSbbknakMw+Tuo3K4rKd4zTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClMGxG0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E1AC4CEDD;
	Fri, 21 Feb 2025 09:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740130210;
	bh=phdfQPrKfgApIH7mf/yVXltPVQWBUOKvkJ/2k3qSj5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ClMGxG0SZ6TY8Awe+wewVPlhaplwi16VlAcwbulj5LZALHg3CKfEqtPtcAbSYvLCk
	 tlzFMwVgt/Y4CxNbYKF/ZsVh/Lx+MfUrfZZYK9WcULHszA0iefufHEBaK7vRUeciOm
	 gK+h3WolRo+L0Aq0/abEkxKcoLV2FYq0lIzdTqC6sVVSTtjMqMAGJjljkLbIS3CKWh
	 lywyzcWJbIjr9+yrzjs03Mr5/m+7xy31sogRgoKvhGNtm7TJ41AbAwfHTb4soEkdOx
	 wYUfa+oVyr2kIJz/gh33+L7hMBZUPOSDuykYmH7VTElu0u2ESyvbOcSWcm0o7V2mkG
	 QaXFwRBePGkyw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,  "Guangbo
 Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 10/14] rust: alloc: add `Box::into_pin`
In-Reply-To: <2a7283fb-4c93-42c4-a895-36a6e3d1935d@proton.me> (Benno Lossin's
	message of "Thu, 20 Feb 2025 23:20:03 +0000")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<20250218-hrtimer-v3-v6-12-rc2-v8-10-48dedb015eb3@kernel.org>
	<TykbJwFqJWXaHRmGzNQOcREWm8Avs7MNKSkQUNb93HmcQ5GhrTOvsxN-mkgHi1HtuFyemvajGA2qvFoDhSe4ag==@protonmail.internalid>
	<2a7283fb-4c93-42c4-a895-36a6e3d1935d@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Feb 2025 10:10:40 +0100
Message-ID: <87seo7fysv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 18.02.25 14:27, Andreas Hindborg wrote:
>> Add an associated function to convert a `Box<T>` into a `Pin<Box<T>>`.
>
> Why don't you use `into()` directly where you need it? Do you want the
> function call to be more descriptive?
> (To be clear, I'm not against the addition, just wanting to check if our
> motivation is the same)

Yes, I prefer the explicit name in a line like this:

        // SAFETY: We called `Box::into_raw` when we queued the timer.
        let tbox = ManuallyDrop::new(Box::into_pin(unsafe { Box::<T, A>::from_raw(data_ptr) }));


Best regards,
Andreas Hindborg





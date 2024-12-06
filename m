Return-Path: <linux-kernel+bounces-435681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501B99E7AED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC7D1672E3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4F322C6CE;
	Fri,  6 Dec 2024 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR5iFGTz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1094322C6C3;
	Fri,  6 Dec 2024 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733520314; cv=none; b=WI07oa/kXtmCsh5Ylgxl6t4gF8TyLqQN5A/ni68+j6e3Sgm+JB68vHNV/acAWI2ayXPgeDo0zf4WbFb9qDKSmSFDUFLe4dN0dgoG9pT7Cxc1wKRXugWRrZbgqUX9mb5Vj6ED1SWdDlfRac6XGBPLbdKMfqVSRuCOzX66O0sCqU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733520314; c=relaxed/simple;
	bh=g9kRebP2ubTDbIpBSlEK3ZKvUYraWoniSEh/ikaKw64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=byKh22/ZBZ+b8tdFAUzrQ8jXmc1IFQLS5o3XvyuJobNEqa75jbT//6Y5MBy5l6CLLJoJyeFeTS7Dxk0klStA+PyYjiyQB1U9iQLQdboNGnbsCc88Ksv16ErzfZjNieVS87Oiu80ANQfLPDK2SBLHj6KiWKnu/JCkwujC0b9iJWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR5iFGTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3D4C4CED1;
	Fri,  6 Dec 2024 21:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733520313;
	bh=g9kRebP2ubTDbIpBSlEK3ZKvUYraWoniSEh/ikaKw64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lR5iFGTzzmACNjYMZdIHiE/zfJtkQ03Wl9mhHGv+M5iSYIkTxMpdiHonOd1AxKEV6
	 KPWeSH3cOZz5AcvnpXGqmAI5lPvUm7CXIuCoXAomHEfwBM70rdEKHyQBQDT6nwj6Yd
	 51AaY4JFxJFjTfrI4vXgybcSGT16ddr1za0ds2kYfpEvsAJITA21a1LjY8SJmF0OoH
	 MhKkxV2PYYG7JvHyVky7U2YqmocNfWTjyA5WRD/ss/K8qCDVPB4MR6sTFpHCM0Z64L
	 TkhV2c1waIM7fWwWU0PC6TfTsLI9WW+0D5yZPloMBrT/B777KfJCNUheAsgsKsUDV8
	 +UL12i2aE3o4A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/14] rust: alloc: add `Box::into_pin`
In-Reply-To: <Z1Nb0dQvO0GKlMmb@pollux> (Danilo Krummrich's message of "Fri, 06
	Dec 2024 21:17:21 +0100")
References: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
	<20241206-hrtimer-v3-v6-12-rc2-v4-10-6cb8c3673682@kernel.org>
	<BAT3INRKXEYrKMKrPQO7CCEMcwAUeqxMVpEXTwr0bSEtnG28BQbBs3q8gwhSkpJPFO2yGCqUflc7cCxOfSFsmA==@protonmail.internalid>
	<Z1Nb0dQvO0GKlMmb@pollux>
Date: Fri, 06 Dec 2024 22:25:02 +0100
Message-ID: <87ser0ec7l.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Danilo Krummrich" <dakr@kernel.org> writes:

> On Fri, Dec 06, 2024 at 08:33:02PM +0100, Andreas Hindborg wrote:
>> Add an associated function to convert a `Box<T>` into a `Pin<Box<T>>`.
>
> What do you need this function for?
>
> There is an `impl<T, A> From<Box<T, A>> for Pin<Box<T, A>>` already.
>

I didn't realize, but that could work as well. I was rebasing this
series from before we did our own `Box`, and rust `Box` has this method,
which I was using.

At any rate, I think it would make sense to have `into_pin` as well as
the `From` impl, to match the standard library. We could always
implement one in terms of the other.


Best regards,
Andreas Hindborg




Return-Path: <linux-kernel+bounces-350881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2129990AA8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775DB28767F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBFA21B450;
	Fri,  4 Oct 2024 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jld9Qm7G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8301121B442;
	Fri,  4 Oct 2024 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065175; cv=none; b=PiIweROVi0hBEGCvsfon+QJXkFEGy5OCOp6qlGBl7WtX2UWrX5fT9A5plfq83eRrCfslyd/ze+hL1RQIH6zO97IE7sgoF+Gj8s3xQB1sNrOQOffeFAgJHV0bqKRORjFZYbyzQzuqwGdfqp5gb+FrfO/dxCWA6RLnayRBePqfnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065175; c=relaxed/simple;
	bh=eg8t/p9jyZxuXcFEHcSrJ+NhN9xuZtBa59p6aAnVbJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UCfsZkk5pPeOVEt4CLFIOJbhzshhnCDj4XaJCvZY+ZQiGBVJtQVkIjRnTFhb+nFyDVOkR9E1G61+W7FUujbdhPbjp8wUCT2V8KBeN6h+4311QFsjL7V7mvjf2bivQ+LWhbDy4+hEF6Wh2Din9Y4bbyMoK389uMCjqsN3wy1R9tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jld9Qm7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D764C4CECD;
	Fri,  4 Oct 2024 18:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065175;
	bh=eg8t/p9jyZxuXcFEHcSrJ+NhN9xuZtBa59p6aAnVbJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jld9Qm7GbFVpPVdB9g2FAOiuoEnOtcON7KzZrvvrMoi3e2camgQ2joNLqpabu0KIC
	 NKrOVmAJK0ibeA5cJlD51cHvKNuH1F9FPsyvRpLNeXwrSmmqsQc/i8jaUNil1HfZIl
	 gJpenTgRQS09djXs8KhkfSvgXEIToD1YXrji1MM1FGmdb412qDCaOeJQvMRMsUL6Z8
	 NkOlnzCIVca84bzd4JtvlQtWgunEx450koV4dYw1EJMerKvIheEPsUCFCYDKh5kY/1
	 12+A/fZmjCDFTpme9eDhCwPQbAB+8rrpWm0tq3rbV8CgeTunIC4LRiZIw69B8PEeit
	 Z+hbkJtlwa2xQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Anna-Maria Behnsen" <anna-maria@linutronix.de>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/14] hrtimer Rust API
In-Reply-To: <877cat32kz.fsf@somnus> (Anna-Maria Behnsen's message of "Mon, 30
	Sep 2024 11:36:44 +0200")
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
	<gcOUTgcHudf9-BfIAB74z-RbgjWPvM2Q-kEsSc3omPKVCMyVKf5am5Z5juBE1Qgn6GbhGddhLOPFyIO8BSrevg==@protonmail.internalid>
	<877cat32kz.fsf@somnus>
Date: Fri, 04 Oct 2024 12:47:39 +0200
Message-ID: <87plogp2k4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Anna-Maria Behnsen" <anna-maria@linutronix.de> writes:

> Hi Andreas,
>
> Andreas Hindborg <a.hindborg@kernel.org> writes:
>
>> Hi!
>>
>> This series adds support for using the `hrtimer` subsystem from Rust code.
>>
>> I tried breaking up the code in some smaller patches, hopefully that will
>> ease the review process a bit.
>>
>> The major change in this series is the use of a handle to carry ownership
>> of the callback target. In v1, we used the armed timer to carry ownership
>> of the callback target. This caused issues when the live timer became the
>> last owner of the callback target, because the target would be dropped in
>> timer callback context. That is solved by using a handle instead.
>>
>> A request from Thomas on v1 was to add a more complete API. While I did add
>> more features, we are still missing some. In the interest of getting the
>> patches on list prior to LPC 2024, I am leaving out the following planned
>> features:
>>
>>  - hrtimer_sleeper, schedule_hrtimeout, hrtimer_nanosleep  and friends
>>  - introspection functions:
>>    - try_cancel
>>    - get_remaining
>>    - active
>>    - queued
>>    - callback_running
>>  - hrtimer_forward
>>  - access to timer callback target through timer handle
>
> Regarding the API: I had a closer look at it after the discussion during
> LPC. It's possible to change the API (prevent setting the mode in start
> as well), but it is not as straight forward, as it originally seems to
> be. So this will take some time to be changed completely.
>
> But what we will do in short term is to create htimer_setup(). This will
> do the job of hrtimer_init() but expand it by the argument of the
> hrtimer function callback.
>
> This is just an information update for you. So you can proceed right now
> with the current API and we keep you in the loop for further changes.

Thanks! I think we talked about something similar for v1 as well.

BR Andreas



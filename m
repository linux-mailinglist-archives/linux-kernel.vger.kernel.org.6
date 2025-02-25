Return-Path: <linux-kernel+bounces-530821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937A8A438D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB4A16A533
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226F926388A;
	Tue, 25 Feb 2025 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfNGW/r6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC53262819;
	Tue, 25 Feb 2025 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474304; cv=none; b=EsdDOLEOjiktrKiBQjrzpfKRYmezb5RRHUyY+50Vq8lqAsuztZvWz/I+TVoBqYKN2Syz+i3TjkwSceZAzjMnE/HIXY0f3M8NmF+S62ezhNGrRM9rzw+2DdoN8XpuqaZpPRfg3fBs9FL/DCmDL3mDxO6Lwh44VIEPAs3NgOTH+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474304; c=relaxed/simple;
	bh=QpB2cB+Ah0o7G8Dz7AotytdVXCkzeeV/lQdLbBCTQC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BEPCEbH7/rn3Ji9iAlCCk1qP5FnF6GgcxyduVX6DR721viCDfuG52XD0cv41zsB9h6G2dzPyhuI5CCXSKY/6CliyRXDL09+4ACkQX0OHWZ5GGPi1r1HK3Q1iRjm9QqiISv3X8RR3/kOg+ZZyBa3Ai7Yo2auP0pHXJeJKF/IlyBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfNGW/r6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E08C4CEDD;
	Tue, 25 Feb 2025 09:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740474303;
	bh=QpB2cB+Ah0o7G8Dz7AotytdVXCkzeeV/lQdLbBCTQC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XfNGW/r6cQ5YMvUoWokmMmdLWDlqI2jAjqu/aT3mIiFn+c/G8KjccHhmvYONverHF
	 1hlXqL3SrcYbc2w+Xx/RKA2gykWJU5dQ8U/MUWGcDz3tWO2KpP/S3cW+wCMiWujSig
	 rxwsLajhBJo6yaWqB2yay68h4MVkX+FyiMRTVt4ODCutJEBo/7s5JRnfrTAznwGLXp
	 SNYh9szWGFM5j5hmkV6gWclhjAza8cniSR60Hl8M+5VoQMb4JDumabpbdwwlrzruX0
	 peDO5pEvy36+sSZ85f0zq2ep/OZ+ipQ4y4wQQcd8EAxRfvG+g4MsBrtugYuhvXnXh9
	 xZTaaKB37cHFw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Guangbo Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,
  "Daniel Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 04/13] rust: hrtimer: allow timer restart from timer
 handler
In-Reply-To: <0fb37c2b2d1a28d2096ffdb08df15404d870d68a.camel@redhat.com>
	(Lyude Paul's message of "Mon, 24 Feb 2025 18:23:14 -0500")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
	<20250224-hrtimer-v3-v6-12-rc2-v9-4-5bd3bf0ce6cc@kernel.org>
	<bbtTga1W7J8Ur61sLLE4K8a3B0oe5iDhuHVNs9dTAf8EX2PUf_jloAt7U3xki4WZB3IkWyPHErVMMLx_vwXXlg==@protonmail.internalid>
	<0fb37c2b2d1a28d2096ffdb08df15404d870d68a.camel@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 25 Feb 2025 09:58:41 +0100
Message-ID: <877c5exuwu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> On Mon, 2025-02-24 at 13:03 +0100, Andreas Hindborg wrote:
>> This patch allows timer handlers to report that they want a timer to be
>> restarted after the timer handler has finished executing.
>>
>> Also update the `hrtimer` documentation to showcase the new feature.
>>
>> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/time/hrtimer.rs     | 19 ++++++++++++++++++-
>>  rust/kernel/time/hrtimer/arc.rs |  4 +---
>>  2 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>> index d08fd7de158d..a431c8b728ae 100644
>> --- a/rust/kernel/time/hrtimer.rs
>> +++ b/rust/kernel/time/hrtimer.rs
>> @@ -207,7 +207,7 @@ pub trait HrTimerCallback {
>>      type Pointer<'a>: RawHrTimerCallback;
>>
>>      /// Called by the timer logic when the timer fires.
>> -    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>)
>> +    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>) -> HrTimerRestart
>>      where
>>          Self: Sized;
>>  }
>> @@ -313,6 +313,23 @@ unsafe fn start(self_ptr: *const Self, expires: Ktime) {
>>      }
>>  }
>>
>> +/// Restart policy for timers.
>> +pub enum HrTimerRestart {
>> +    /// Timer should not be restarted.
>> +    NoRestart,
>> +    /// Timer should be restarted.
>> +    Restart,
>> +}
>
> Should we have #[derive(Copy, Clone, PartialEq, Eq)] here?

Yea, lets do that. `Debug` as well?

>
> Also, I feel like I might have asked this a few versions ago so hopefully i'm
> not asking again: but what's the reason for us not just using the
> discriminants of `HrTimerRestart` here:
>
> /// Restart policy for timers.
> #[repr(u32)]
> pub enum HrTimerRestart {
>     /// Timer should not be restarted.
>     NoRestart = bindings::hrtimer_restart_HRTIMER_NORESTART,
>     /// Timer should be restarted.
>     Restart = bindings::hrtimer_restart_HRTIMER_RESTART,
> }

I forget if we discussed this, but it does not make much of a
difference, does it?

With a Rust enum, we get a smaller storage type maybe with better
support for niche optimizations? And then pay a bit more for conversion.
All in all, I don't think it makes much difference.


Best regards,
Andreas Hindborg




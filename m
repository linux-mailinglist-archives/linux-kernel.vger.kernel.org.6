Return-Path: <linux-kernel+bounces-535832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7442BA477D8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF403A25F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A987225412;
	Thu, 27 Feb 2025 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b7D8Z2LG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VUSBblrb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AC713A3F2;
	Thu, 27 Feb 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645104; cv=none; b=SWhp9+EblLQjo3xm6Ud8sBPEcyx2e8t/2MItchiid3UiZHif7raIeaib06iUXOs+ydQauO2LLIa4Mug3WCpdde0K09HAB+IZL3DPILw3nXJ2MbOb12Do3movFcDuAjNxoSojcqr7zW4+O4O1OFrL1X79uPIw+ioxHlAuWuBrvBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645104; c=relaxed/simple;
	bh=wp4NsEbBkp29Slu4Hh3MmzhMSbSRMBd/TNrpeE+tQ2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J84khgBofLB3dZo66pXDon3xCNxqlCj5dG/Vft/boBd8/6/nZcXXbLqIzFUm0HgtNTm5C81NORgcSXIzQma9vyRCcviIZsQjBksyvVNdpvgpmjM9E7f58A/dlYDsz0kvZXlN4kDTRdmR/KbDlWCFAvkNZxl9jCS6TX5dCfTxaF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b7D8Z2LG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VUSBblrb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740645101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GlclozudQH9jhCzVOaVyJdF4+dBg5b/b21AhYtkhsSk=;
	b=b7D8Z2LGhBUaaWS1ZBEfzCfukxxtbxK9nwopB5xk02hNHSlNBn85HsrAFTHSOdY4m41qJk
	QR0Uuvvx+GuXHtjahA9+9jLLQRrN25LATEss5WB+e6kObsMHEY5G7BfLjim330qNA7XTky
	cfTXJDGJbyj5Qrxzi/XJhjQSLklFzCmoKDY/w1jMUnoxTtpT96R0BP06BTN9/GDK+APG7C
	tnS+Q8Snn1p5KM/VsVA1QeQMQYgzah+ObQFMcSFIBjkk2FEcxBULRx3xJw9fIddV4BR/rC
	Tap7/MVuwXiYkY6sbRZrqhIICRfVD/boxzVK+iQzxj4g6hVPvxijziB3i5QvMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740645101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GlclozudQH9jhCzVOaVyJdF4+dBg5b/b21AhYtkhsSk=;
	b=VUSBblrbGKmDw8yvfuVme4IVwm/ou5XR4u5J5H190uDNRc/ocgyAwmc6pLw+mpaiISrit5
	KPeUl6JWEEErC0Bw==
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo
 Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas
 Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
In-Reply-To: <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
 <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
Date: Thu, 27 Feb 2025 09:31:40 +0100
Message-ID: <87o6yneqkz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 24 2025 at 13:03, Andreas Hindborg wrote:
> This patch adds support for intrusive use of the hrtimer system. For
> now,

git grep 'This patch' Documentation/process/

> only one timer can be embedded in a Rust struct.
>
> +//! ## State Diagram
> +//!
> +//! ```text
> +//!                                                   Return NoRestart
> +//!                       +---------------------------------------------------------------------+
> +//!                       |                                                                     |
> +//!                       |                                                                     |
> +//!                       |                                                                     |
> +//!                       |                                         Return Restart              |
> +//!                       |                                      +------------------------+     |
> +//!                       |                                      |                        |     |
> +//!                       |                                      |                        |     |
> +//!                       v                                      v                        |     |
> +//!           +-----------------+      Start      +------------------+           +--------+-----+--+
> +//!           |                 +---------------->|                  |           |                 |
> +//! Init      |                 |                 |                  |  Expire   |                 |
> +//! --------->|    Stopped      |                 |      Started     +---------->|     Running     |
> +//!           |                 |     Cancel      |                  |           |                 |
> +//!           |                 |<----------------+                  |           |                 |
> +//!           +-----------------+                 +---------------+--+           +-----------------+
> +//!                                                     ^         |
> +//!                                                     |         |
> +//!                                                     +---------+
> +//!                                                      Restart
> +//! ```
> +//!
> +//!
> +//! A timer is initialized in the **stopped** state. A stopped timer can be
> +//! **started** by the `start` operation, with an **expiry** time. After the
> +//! `start` operation, the timer is in the **started** state. When the timer
> +//! **expires**, the timer enters the **running** state and the handler is
> +//! executed. After the handler has finished executing, the timer may enter the
> +//! **started* or **stopped** state, depending on the return value of the
> +//! handler. A running timer can be **canceled** by the `cancel` operation. A
> +//! timer that is cancelled enters the **stopped** state.
> +//!
> +//! A `cancel` or `restart` operation on a timer in the **running** state takes
> +//! effect after the handler has finished executing and the timer has transitioned
> +//! out of the **running** state.
> +//!
> +//! A `restart` operation on a timer in the **stopped** state is equivalent to a
> +//! `start` operation.

Nice explanation!

> +    /// Cancel an initialized and potentially running timer.
> +    ///
> +    /// If the timer handler is running, this will block until the handler is
> +    /// finished.
> +    ///
> +    /// Users of the `HrTimer` API would not usually call this method directly.
> +    /// Instead they would use the safe [`HrTimerHandle::cancel`] on the handle
> +    /// returned when the timer was started.
> +    ///
> +    /// This function does not create any references.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `self_ptr` must point to a valid `Self`.
> +    #[allow(dead_code)]
> +    pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
> +        // SAFETY: timer_ptr points to an allocation of at least `HrTimer` size.
> +        let c_timer_ptr = unsafe { HrTimer::raw_get(self_ptr) };
> +
> +        // If the handler is running, this will wait for the handler to finish
> +        // before returning.
> +        // SAFETY: `c_timer_ptr` is initialized and valid. Synchronization is
> +        // handled on C side.

You might want to be more explicit about the provided synchronization.
The hrtimer core only guarantees that operations on the hrtimer object
are strictly serialized. But it does not provide any guarantee about
external concurrency. The following case cannot be handled by the core:

         T0                         T1
         cancel()                   start()
           lock()
           ....                     lock() <- contended
           dequeue()
           unlock()
                                    enqueue()
                                    unlock()

So there is no guarantee for T0 that the timer is actually canceled in
this case. The hrtimer core can do nothing about this, that's a problem
of the call sites.

We've implemented timer_shutdown() for the timer wheel timers, which
prevents that the timer can be started after shutdown() succeeds. It
might be a good thing to implement this for hrtimers as well.

Thanks,

        tglx


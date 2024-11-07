Return-Path: <linux-kernel+bounces-399195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9692B9BFC06
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6251F22658
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB7514A8B;
	Thu,  7 Nov 2024 01:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="beA0IjCq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JwU9kLsU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD61863F;
	Thu,  7 Nov 2024 01:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944523; cv=none; b=us4/pie2nyYjXYE6BPcEz0ByyWCTYzIuQt9EO8gRmNEvkqRAE3/XnfWnyzjXHxWYY0HtLrVO2NVFACjtAz54Dd3Zw+ovt2JtdfsKDjv6/ic2geZuzqnHpXUQJDB9rnRYG7DvpAQsTq/Ie7JLXHYDimx5tbDfxYhmDRHoAOcd66g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944523; c=relaxed/simple;
	bh=kDekRCLr+NF2MQ1qVzVsOMVeBpe9K+eR1IW2MKnj0+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FABj/YQOKuj4+egA/yVyYxswCfef3/tKTlHaIfAGR+5I8KtUxrzgkPaNXl9TlIerDSHrQpOuyGZf4KwIoBMaqxinB4logdmzHSR1+eDW49ZXTgfjXYVo063fCU88dAA8tlrAOuJdh2wlz+GnuxfQhWVFC2eKlECRuZZezzxpgiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=beA0IjCq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JwU9kLsU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yHuhaXluNZvcHKNGAX2RD73UJnUTFKyvNvfGTuAweb8=;
	b=beA0IjCqm47gFCy89nu4n0Dxtzy1E+7+aas/Y1g+KmukfMhBuU71scU80r/XnXFsowGUmJ
	mQ4Wc/NRX13L1JHzW2x4ZR15YEncQ6RnXomxULoxVwN1Icv27k7c3zeG+YC+PnsMsViG6R
	xSrdGyh9E1eX3yYG9znKOTdOiC68l/Ms69DJJj+uRhIZHJYMevBdV9x+ASDJEOyXgbUndV
	iA0OHdABekjjgNKpNKqbTxTaCroKWOam6xFDWJmGL1vyTj3q7m+Q7pv5A0mX64VgC2f5vg
	ShsuvGmKlR9mXV0OATaBsve5RRAnLieUIcOULHFz4NyuNI1T0/FBB3HJ/a2xTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yHuhaXluNZvcHKNGAX2RD73UJnUTFKyvNvfGTuAweb8=;
	b=JwU9kLsUjzScL+bTQAUuqUKzQ6xlhvPWMtjdq2Mqwcmn8FLp2FvxsqqY8B5Y+DihwGO3XY
	or1fNp0fCihjGOCw==
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas
 Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v3 02/13] rust: hrtimer: introduce hrtimer support
In-Reply-To: <20241017-hrtimer-v3-v6-12-rc2-v3-2-59a75cbb44da@kernel.org>
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
 <20241017-hrtimer-v3-v6-12-rc2-v3-2-59a75cbb44da@kernel.org>
Date: Thu, 07 Nov 2024 02:55:20 +0100
Message-ID: <87v7wzoliv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas!

On Thu, Oct 17 2024 at 15:04, Andreas Hindborg wrote:
> +impl<T> Timer<T> {
> +    /// Return an initializer for a new timer instance.
> +    pub fn new() -> impl PinInit<Self>
> +    where
> +        T: TimerCallback,
> +    {
> +        pin_init!(Self {
> +            // INVARIANTS: We initialize `timer` with `hrtimer_init` below.
> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtimer| {
> +                // SAFETY: By design of `pin_init!`, `place` is a pointer live
> +                // allocation. hrtimer_init will initialize `place` and does not
> +                // require `place` to be initialized prior to the call.
> +                unsafe {
> +                    bindings::hrtimer_init(
> +                        place,
> +                        bindings::CLOCK_MONOTONIC as i32,
> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
> +                    );
> +                }
> +
> +                // SAFETY: `place` is pointing to a live allocation, so the deref
> +                // is safe.
> +                let function =
> +                    unsafe { core::ptr::addr_of_mut!((*place).function) };

I assume you are sending a new version of this series due to the
reported build issue.

If so, can you please rebase against

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core

It contains the new hrtimer_setup() function, which initializes the
timer including the callback function pointer.

Thanks,

        tglx


Return-Path: <linux-kernel+bounces-535914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9036A478FD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5BA93AC94E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ED0228386;
	Thu, 27 Feb 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w71EvgTl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dcb2lerc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B5227E92;
	Thu, 27 Feb 2025 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740648252; cv=none; b=sl9r+FdMCSasqlKA0Mgq3nrpJ72cksF/2XA297LwhjljKnqKwz5dGJmf/vlXjyxLYh+viZKuon/Uw31k1H79ZEcJic1jXNIFVBZPIsVx4mqwdHRJ5EqkkSK7kf1iR6JuvUYh6zC7b+sGv2BrYn/HwMdDOhvJzgfjd0paJTdMEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740648252; c=relaxed/simple;
	bh=A0/Rv8pcFQMZQJC8h111DGjqhwFez8qUvd0LPAAS9wg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YVwbsuwUpZ6yGwYF+s6hIWtk1ryggMIL4KZppVvBA2qaFQ0rvwUxe7s9L84Q0vFns+YnnHXOGtVhvXO3ZyckKlS7Tn2jP56trYUfoQ/W9V+dCzjDpF+240GvuW1xbgWgXZgGsjhacAq5e6QwINyVWDcOXc/JDWUJYp0r4ydwm/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w71EvgTl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dcb2lerc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740648249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vj8pxx/HQhJRDBVv70yDd3OqxLOCbUlXX2jRhoVJAn4=;
	b=w71EvgTlmYy/NS0hyYbYNsuJFo7QCJePF/SYxOWxe1WvAMLwviZuGxTZGQi4qzV4OW5woo
	ArhztW6I3m4M4LjRmnqFKJWqzjYg6YsUWLu28AblmAAQeje8njcR6GL3FBMjOsu+7o1OHc
	Aqh8bBrBENYpkF7EV6WKPt64JGsdxs6RUQFCWPbXDHWj7wEg7xlLHDjHXfdOPHJLY/G+QH
	5Fh2N1WovTEHW8Bq+mi4aMJih262AHqDCqPArEQdjt1k5+IjCiuN3B8pnqGqA7AscvMZZB
	tSepG3h48E8mrIlO7zXekn/tJFZ15u3HedxXhSojezsbUnZiXmtOci3tgluxhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740648249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vj8pxx/HQhJRDBVv70yDd3OqxLOCbUlXX2jRhoVJAn4=;
	b=dcb2lerctxfTrY4/jBZoE2WipEVYp0AnCaOPLhh2Ns7g4I517QUo2ZV6u3iMvIXrsRy95x
	7Gd1/Ut/T+qo5HDQ==
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
Subject: Re: [PATCH v9 12/13] rust: hrtimer: add clocksource selection
 through `ClockSource`
In-Reply-To: <87jz9beor7.ffs@tglx>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
 <20250224-hrtimer-v3-v6-12-rc2-v9-12-5bd3bf0ce6cc@kernel.org>
 <87jz9beor7.ffs@tglx>
Date: Thu, 27 Feb 2025 10:24:09 +0100
Message-ID: <87eczjeo5i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 27 2025 at 10:11, Thomas Gleixner wrote:
> On Mon, Feb 24 2025 at 13:03, Andreas Hindborg wrote:
>> +    /// International Atomic Time.
>> +    ///
>> +    /// A nonsettable system-wide clock derived from wall-clock time but
>> +    /// counting leap seconds. This clock does not experience discontinuities or
>> +    /// frequency adjustments caused by inserting leap seconds as CLOCK_REALTIME
>> +    /// does.
>
> Only partially correct.
>
> CLOCK_TAI can be set as CLOCK_TAI is obviously coupled to CLOCK_REALTIME
> and vice versa.

For clarification:

    CLOCK_REALTIME (UTC) = CLOCK_TAI - sum(leap seconds since the epoch)

As of today thats 37 seconds.

Thanks,

        tglx


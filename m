Return-Path: <linux-kernel+bounces-311620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B10968B44
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8027283C8C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AB81A263C;
	Mon,  2 Sep 2024 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rPhc5llT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RP5rxC2g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF9419F11B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725291961; cv=none; b=sUIYui32dz0Z59X2WupwpLVb9kYpDdDGT1stmllADF7rNielBFfOsRhF3gc/mXwGf1JgMMAXBszFwVR0oM5gkh0AhoIjnTnHfvA5qsyf4qISppTaElsTQlidBaa0A/8Or7VSaAsdO65pVHxackc3r3R5kXZXcYx/Puxyzu9KcZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725291961; c=relaxed/simple;
	bh=FQblTQ4fDywVmDq3pnMIepWR9RpKypd4WZtzFZ2r/ng=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=Qaj/C7pd8ZsbyGru8sv/XhTSSCUdNpHFrhsrdt2uQIz/UHrkOLQd2YMP9moDWB049GBf1OlF2G3bpFfY/QLhy72iEJ3HlKw2dKV2wKnyovgB9CHQXYBivNh3C866Bar0KJZ0R3qsUJ83ZvSaSfgmvksQM6pzVSALtcjrFs5Dmrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rPhc5llT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RP5rxC2g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725291957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=kev1oRGrYa+W+VWnc037PvIT4DkU6+C0Y0Ro9XAucIw=;
	b=rPhc5llTmyjbbHF2n8p24XEtat+8mO4HQ6wlGL+QFKFquvfFAwW6yG6XZ4Wbqf7p7lIahS
	mB4IT5yAbHo/jOp5qrOePlLP5Enk+sgHNceZ/uQzgGhTrXXH0SbtHHMiN8nSLhI7rjFTpT
	YhxJPeyxUA0mfd/sCO/qV6qcl4T39VujufV9HHxzNUtAVoqywgrm88NYZiXH2CA1QFbRbC
	JKQJ70KR8dwL2esy++pNlm39dg8EG7zWDbqLgjK0WgD3SIrEV4/IBFnRcxWdB5NgFvNOZf
	PoAZ0OWoj0dDr8ozGD3PFoZ5B110SeQ6EGmidSzBQ8AkK/P0wTnIil7PhZOVzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725291957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=kev1oRGrYa+W+VWnc037PvIT4DkU6+C0Y0Ro9XAucIw=;
	b=RP5rxC2gUqfAQPCUOPD664Nvh2+MlVkw1IxAuk6CMohsx+7jic549RntAmONzJ4S6cQC9m
	YLdN3OBPXF2kElCw==
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>
Subject: Re: [PATCH] time: Rename CLOCK_SET_* as BASEMASK_*_CLOCK_SET
In-Reply-To: <20240815200325.2474604-1-jstultz@google.com>
Date: Mon, 02 Sep 2024 17:45:57 +0200
Message-ID: <87plpm5aa2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 15 2024 at 13:03, John Stultz wrote:
> In commit 5916be8a53de ("timekeeping: Fix bogus clock_was_set()
> invocation in do_adjtimex()"), Thomas fixed a bug where instead
> of passing one of the CLOCK_SET_* values to clock_was_set(),a
> conceptually related clockid (CLOCK_REALTIME) was incorrectly
> passed.
>
> Just to make this type of accident less likely, lets rename the

s/lets//

> base masks used by clock_was_set() to something that doesn't
> resemble a clockid.
>
> Thus:
> CLOCK_SET_WALL -> BASEMASK_WALL_CLOCK_SET
> CLOCK_SET_BOOT -> BASEMASK_BOOT_CLOCK_SET

I don't think that's the actual problem. What's the confusing part is
the function name itself clock_was_set().

Renaming that to at the same time to something unambiguous would be
helpful.

hrtimer_refresh_bases() or something like that should be descriptive
enough.

Thanks,

        tglx




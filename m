Return-Path: <linux-kernel+bounces-393571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6606C9BA274
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 21:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FCF283520
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 20:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66781AB6DD;
	Sat,  2 Nov 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aAMsZeDo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NtmHxILR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8D716C451
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730581041; cv=none; b=Gij3MyRSWNjjesAon76bmT4kVgUG5GzIqSml+4ubjJtRIfjmiuE6Z0pA2Y0lhB0DCAypcpqOwjdXuOnTXZwhDC4ia7o5+BUhkuGi2SIszyVFoWcMv5ML21HvFhMP5BDieKKmbQ+BormbrqSpjF9fQ7iAEK52msjZcVQ7fo3iadA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730581041; c=relaxed/simple;
	bh=fWXaBGy/0ZWWBMKzIa3Roh4oM+kp5yiX86efJ6pqXQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QWGYJp3cyeNLJ2gZvx0NBS/INid75+eNG5wUVcPsjarG9rtOvCDWBqJ37ew4yG9njhT5VUbTpXoTGjQqy3kM3JL2I2jbWqa1+A8DIO4liiqCvNpKlAXK0Hn5/8AgD9nMxUUtHANe3lArXKweJG5dBYza2Q4wk+lq1lbqKRqP3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aAMsZeDo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NtmHxILR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730581037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fWXaBGy/0ZWWBMKzIa3Roh4oM+kp5yiX86efJ6pqXQM=;
	b=aAMsZeDofcuShVyFzOqf7kmhKblSJIvKo3abpWCjk/GhZSZWlJdFfbE3TOdMNCm+7b77yR
	ngyb12/c1wpawoA07KY92hizsTWILws3iK6xDu0EqX+S2ZVcVKwIi8fSriMNQ2SrpKrP1r
	h9xr4QFpnUoYKSYMTwUcVpMSDQhHl1LwTiYHmlekjtIG3kZB/IVuzOj1nXY8F2FQxy5sx6
	qf0TG/o3yFVO30XIa84gvpar4/UJ2UKYkSGlDqJX8gkhoYj8366Pe1bFx9ZpsAH/fFs8KS
	C7aH8AWsFhhk2npZSV8W1T4rg4Xdz2gKy92gSVXFXpj7qSAZqyoRYr6syrBHwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730581037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fWXaBGy/0ZWWBMKzIa3Roh4oM+kp5yiX86efJ6pqXQM=;
	b=NtmHxILRte+fa8fdlE2l2CKGXaPwzZCxrYziclJwHdK1N+deMI7LhRBjzL8yXSKiHStG5s
	raXsm5doz6NNQVBQ==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch v6 17/20] signal: Queue ignored posixtimers on ignore list
In-Reply-To: <87bjyxr8q9.ffs@tglx>
References: <20241031151625.361697424@linutronix.de>
 <20241031154425.624061922@linutronix.de>
 <ZyTj2W8Jndv0nzga@localhost.localdomain> <871pzuvfzg.ffs@tglx>
 <87bjyxr8q9.ffs@tglx>
Date: Sat, 02 Nov 2024 21:57:16 +0100
Message-ID: <875xp5qrpv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Nov 02 2024 at 15:49, Thomas Gleixner wrote:
>> That's what this magic does...
>
> But it does not exclude oneshot timers from this. Their signal has to be
> dropped for real.
>
> Delta patch below.

Which is incomplete. I send a full replacement in a subsequent mail.


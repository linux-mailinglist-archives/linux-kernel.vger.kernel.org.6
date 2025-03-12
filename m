Return-Path: <linux-kernel+bounces-558227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E025A5E2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78AB7ADAFC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC6C1D514C;
	Wed, 12 Mar 2025 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0H0CwTbf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h0b2wuSr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E875D1D618E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741801558; cv=none; b=cYuHytDU69IZMJ/WyYIEVv7T125XvLiI23Z0Swmp9kQGnm8hQOJliWBsDJoZGwprZfOFEPRDLDtv/+dIyIwncX7AZk3I2uSv7pg/pb5LRgCHagyIOGO6nt+aSh9tp69FAHFiXnmDcKUhwr03LaHk1a57BXkhRPdKrE3ZEDceZjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741801558; c=relaxed/simple;
	bh=8ymwvGzTZjzaAnFYMJJjziJPJ/av9ZVcLOF+2I4p0Io=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OjCYZ0MzPQhClN33n0o7qc3qPBVxagJ5VvdVcqLkLCi9OpwM/sfXVVSKjbToSq6CqcmnUVAgzBXFe3K4mid8p2iu6yi1KpCFxrVvFELrbk3a9YMpJMGUSEcNFX0velopB3tFmaznTYwuJepzxF6IHuLcfQYVmi/IR3ADFh1S5A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0H0CwTbf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h0b2wuSr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741801554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3yC+/ZgXrMbcxzIx1KsSviIXmJGEkvJEllPNW+zZ8qQ=;
	b=0H0CwTbfVn7l2hGtbRj9vcq+5HmD5j5XqILQMAkmKhIIJBPoKCs+pIO/tJwIx3C///edRN
	0rJp8kG7fwtxWMKm4cwwlKC2dTPYS3CGT/Po7v3dvpCq6bMzxLzmvAEv1BNqexFV5PR2bp
	MZ+XEV4bgVJ8FPfrjn7aZVh+KTfsNtuzG966z5VcfmbdjkCQ8oMRuAsYlOeSZws5mexAF9
	HQkyw1EYmYBlxZ7gHX2Gy59TRgXKHdtpBhydf6hv30lOLu/TIoJAWc2HDYMV4rn8KyM2MH
	idzpQokcEB8ASboJRFygONZ3MHK7uLAE6VezFBIoHXpTe2nwMwSq5f3IeEQvOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741801554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3yC+/ZgXrMbcxzIx1KsSviIXmJGEkvJEllPNW+zZ8qQ=;
	b=h0b2wuSrm5lyN4+dyZx9RCzaPGq/l8jurb81DlYM3XvAyDMzq0+iN4IP0OppTJtPLyY3ZY
	q+gmpYmtmKQVezAQ==
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Benjamin Segall <bsegall@google.com>, Eric
 Dumazet <edumazet@google.com>, Andrey Vagin <avagin@openvz.org>, Pavel
 Tikhomirov <ptikhomirov@virtuozzo.com>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [patch V3a 17/18] posix-timers: Provide a mechanism to allocate
 a given timer ID
In-Reply-To: <Z9GA35aiPFL1GaXW@grain>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.526740902@linutronix.de> <Z9CsstMf-EVZpsiH@pavilion.home>
 <87msdrz0i9.ffs@tglx> <87jz8vz0en.ffs@tglx>
 <Z9C6GpaB9WvNzvJS@pavilion.home> <Z9E-L1pvl1j_4E3f@grain>
 <87bju6ze2h.ffs@tglx> <Z9GA35aiPFL1GaXW@grain>
Date: Wed, 12 Mar 2025 18:45:53 +0100
Message-ID: <875xkeywfi.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 12 2025 at 15:41, Cyrill Gorcunov wrote:

> On Wed, Mar 12, 2025 at 12:24:54PM +0100, Thomas Gleixner wrote:
>> +	switch (ctrl) {
>> +	case PR_TIMER_CREATE_RESTORE_IDS_OFF:
>> +		current->signal->timer_create_restore_ids = 0;
>> +		return 0;
>> +	case PR_TIMER_CREATE_RESTORE_IDS_ON:
>> +		current->signal->timer_create_restore_ids = 0;
>
> Thanks a huge, Thomas! I suspect this might be a typo, you need "= 1;" here )

Ooops.


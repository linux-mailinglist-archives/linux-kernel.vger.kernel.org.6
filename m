Return-Path: <linux-kernel+bounces-225861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 767E991363A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 23:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9991C2183E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 21:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166D47441E;
	Sat, 22 Jun 2024 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q0sVyc6O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lw3C0hdD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185935EE80
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719093415; cv=none; b=gjBsuVdEIqqtI/buPsrPb9JhldQ8Ab3EMXY798DMxLQRGvPhQBYr6PWj5HYr/AkqdWEXdnSO3TzsVnFgQCerNvOvmP8OjcsQKzDc0XCeSguBAuAu9QsoJm9ytmuffjAadd/389vI0GmWtLJmQH9acSs/Mv4bRBTkLj0gKES/J9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719093415; c=relaxed/simple;
	bh=KfrhjzoPxDsaBX2Oy1WGMRFNLuXBbKwUthXjIkYdpc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B9BuPn9syOrDZunSoHLYuMh/AfipGkawzY/NsfX7fWYn2kF95BGVi9IW2MhyHHJizmuWuugerqYLTd3dO8sv9IzDXD/EF3lo1pF4HBbpw8IXXTuukkhwVn9c9LfS+MuhY9RPloCdsSpH74/zV/PH8MSHsRg/QDvn3HEIYNofu8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q0sVyc6O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lw3C0hdD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719093412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+oHIeLUfNzp8tR8h4rRm++4iy7jX6BMnAMi2dezVOY=;
	b=Q0sVyc6OaPahdxrUSxEy7odFwIcSKazWlBpwlS0L5MxCK4HT4stFqtw37B2rfziWSV7Rak
	DPno6T+tvRcjPWOJ55HjJPD35cAy8scrKWHDGXpPM5cde6CcL3HUCxBHCGYwZQ5nXL8vzt
	kNxNi1MipyKNui0N8mnIXFtIOp3RWghf/bo/bYn0+BzpHCOVNgFtwy1h+xjP3TcG6IankF
	EbtEMVL43Uk+HnQGl8J53gwZbPXbVjDZ64aovz8/Fut+Q7OqPu8pZA1EBcC1WB4Foq5pFD
	zM6SIKKqj0x37GTpELXjeiZ3lNhpm8we6ZyBN2w0QX+lbUH5nGfO+sY2PHk5Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719093412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+oHIeLUfNzp8tR8h4rRm++4iy7jX6BMnAMi2dezVOY=;
	b=lw3C0hdDKBpPvdDuNIbvTtC/0fNgpn31mOWFEqUSk4mVKAtK8NPMFOxF/wPbinFxJ0QvJp
	nAjPPGnqCiMmghDQ==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V3 11/51] posix-cpu-timers: Handle SIGEV_NONE timers
 correctly in timer_set()
In-Reply-To: <ZnbhNF59091n4Xwl@pavilion.home>
References: <20240610163452.591699700@linutronix.de>
 <20240610164026.162380808@linutronix.de> <ZnbhNF59091n4Xwl@pavilion.home>
Date: Sat, 22 Jun 2024 23:56:51 +0200
Message-ID: <87bk3szlng.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22 2024 at 16:35, Frederic Weisbecker wrote:
> Le Mon, Jun 10, 2024 at 06:42:18PM +0200, Thomas Gleixner a =C3=A9crit :
>> +				 */
>> +				if (sigev_none)
>
> Does this patch build? The sigev_none variable doesn't seem to exist.

Bah. I messed that up when splitting it. 13/51 fixes it up.


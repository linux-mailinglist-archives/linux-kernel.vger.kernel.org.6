Return-Path: <linux-kernel+bounces-389298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE809B6B17
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9BC282216
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9B81F706A;
	Wed, 30 Oct 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t1er4DpR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3xZa4Isd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D01F1300
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730309689; cv=none; b=APxs5H5njpJE8SgNJDoBtNblUT1s+Q3uMK/M2nCDHoJBmj7VWkA/1dLwtlaIyi65BY5PR0FRwrl0ZzLZ1Ebg9AXBzmp8fiZKmRH9hEVPs5bNUB8SIcv40bRQxQGx2OnJljTjZL5Yo/6e00Bh3r0IZ/8tA3Y44qzqyTbmDmUKVEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730309689; c=relaxed/simple;
	bh=4KapIRKOHTZMcnPRrI8VYNy681i/iMevTo96HNjKn0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SfmgEkOOamhq8C23jt9mD04ZvMv6RJsNqSrUtRw5M84GwY2vn3us4U3oOXLDPeqh66j+r5t7gmcIWTxUVW4COoWOltPA+t1DXqaJ3vKeHj3JPxug/Ct5pN+pgQscGQuBu0t2cLtSqLNYmnJ03kPIlAXOetCRXTltXbIYFpgVMNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t1er4DpR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3xZa4Isd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730309685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qs5CuuZuCfCz0Zjj661xtaZ52LDe9ywl6xFkhpOu3EQ=;
	b=t1er4DpRQ9RaeJiFrJ6s5iZzH8EJoMR/88A4RGfxJ84hYNVgUAgd0+b2cYCpDCaMbHAF3j
	YzZberoWUXivMOBkiHyILaUlgCGpW9IkoKvMF7DXVKoRgOeOvlghkyKOAmjDZUIUPqGBg2
	D4lxebjEn9X8z15aFaDSxcU+aYnQyARXKxvm+cXNrwpVeVfx4l6nGT2YlA7uu2MHvyUTKH
	Xu0Bj7sRgl/n9ncuN0oNrodlcIyLOxzIbxTnCtrcOWw5h1gd4YUA+cBhHoxyKAZXMeukOU
	AXzXZCdTi5U/r0z/2/3qx6MDc3tiPmHGabHroF22Pzhyeoiwl2b8gMVLBgOFLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730309685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qs5CuuZuCfCz0Zjj661xtaZ52LDe9ywl6xFkhpOu3EQ=;
	b=3xZa4Isd+tnz/igVFDVJsQ+Q0vn/vXMR6EV/iT2Wv288TTQMrq2cz/AHLtU7u9shPDFf9B
	3bRaBEHFEBR2kwAg==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 21/26] posix-timers: Handle ignored list on delete
 and exit
In-Reply-To: <ZyJng49tJutCM62d@localhost.localdomain>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.514196709@linutronix.de>
 <ZyJng49tJutCM62d@localhost.localdomain>
Date: Wed, 30 Oct 2024 18:34:45 +0100
Message-ID: <87ikt9xznu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 30 2024 at 18:06, Frederic Weisbecker wrote:
>> +
>> +	/* Mop up timers which are on the ignored list */
>> +	hlist_move_list(&tsk->signal->ignored_posix_timers, &timers);
>> +	while (!hlist_empty(&timers))
>> +		posix_timer_cleanup_ignored(hlist_entry(timers.first, struct k_itimer, list));
>
> The ignored timers should have all been removed on timer_delete() and
> itimer_delete(), right?
>
> So should it be instead:
>
>    WARN_ON_ONCE(!hlist_empty(&tsk->signal->ignored_posix_timers))

Except for those which have not been removed by the application on
exit() or in a case where the kernel kills the task. Then the exit
cleanup has to mop up for them :)

Thanks,

        tglx


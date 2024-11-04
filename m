Return-Path: <linux-kernel+bounces-395121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D5B9BB8CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4391F22CB8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC551C07C0;
	Mon,  4 Nov 2024 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mO621iyX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lG8eXM9o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8321BD504
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733721; cv=none; b=AtAtqBYIK1O+R+SGgc6mWwdK58cjM/JauCgqj2YX8zaMexgaxOOGQelWsvMGZVlEgQQcror0jkQptRx8usfi3+gAc4waXQ/yj/RYHH/dxCbna/N0YDZEp6VkmuN94sLwdo5I5qq+6bJyP4YvU/ARPnZe6/hslpZtiKO6sFHp4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733721; c=relaxed/simple;
	bh=zJHHSowe6DT8rAVp9ER0WSUnRjFo1X227k6YU4VfUUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fNX8x16zkVKWtcDwnTSSzCXahXjIIWv8ZPM5i8VnawXdBW/ZJm7mh4XdG7Glkfsbz2eUO7KGisduNcuTmlprCRTSjSUqCXeJKAuQBYVm0/Dh5Sc76Rw+1RJvD1uaNn/PR6jlHL/tYHNOI3F/NAV6D2dyrB3PsB8N1h/0TwlukBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mO621iyX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lG8eXM9o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730733717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0CQDTVeTZ4+VNvtDJmzejNEPu2LRSOeRnLHPpe8CCbU=;
	b=mO621iyXP2CgKx821Q38RgiUSmNBRhlKk+9vMT3dpJWKoEPGX6GpnjJnd/2k23sUwhelnT
	HPiyOIlW2e3ggfDWF22jEgJuS7AU2Vi5G14l26T2edlO4JwinBQkjw/b5nR4n1VoUNPKdO
	E1wkkdwTCUi+Nf27x5OuZAcZBhAJB2bBoA8BpHrw27NTcXjGovFwjLW2qID+YBrkzhJ9Qi
	ZtarZPj/kdqZj5vXnxDfmmVD/Y6JY92KeZzQ2J0i2LmIEMKrD3FKHPLMZbBt1yh6FSrVYU
	hOZ3RaVbVvX6vS7X+3Qt7pVz909guaHK5uod/FL0vv9ytL77viQVoMoWDOTaNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730733717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0CQDTVeTZ4+VNvtDJmzejNEPu2LRSOeRnLHPpe8CCbU=;
	b=lG8eXM9oxuIN52mr6VgymZDU4kfu/6HH3XyXVphf6SMnR/X0TsZraVhElqmb5++pLUBOgH
	+lwSI7Go7NzSmRAQ==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch v6.1 17/20] signal: Queue ignored posixtimers on ignore
 list
In-Reply-To: <ZyizGM4-3FmPDtGj@localhost.localdomain>
References: <20241031151625.361697424@linutronix.de>
 <20241031154425.624061922@linutronix.de> <8734k9qrcr.ffs@tglx>
 <ZyizGM4-3FmPDtGj@localhost.localdomain>
Date: Mon, 04 Nov 2024 16:21:57 +0100
Message-ID: <87plnbowh6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 04 2024 at 12:42, Frederic Weisbecker wrote:
> But there is something more problematic against the delete() path:
>                                    
> Thread within                  Signal target             Timer target
> signal target group
> --------------------           -------------             -------------
>                                                          timr->it_status = POSIX_TIMER_REQUEUE_PENDING
>                                                          posixtimer_send_sigqueue();
>                                                          do_exit();
> timer_delete()
>     posix_cpu_timer_del()
>         // return NULL
>         cpu_timer_task_rcu()
>         // timer->it_status NOT set
>         // to POSIX_TIMER_DISARMED
>     hlist_del(&timer->list);
>     posix_timer_cleanup_ignored()
>
>
>                                do_sigaction(SIG_IGN...)
>                                flush_sigqueue_mask()
>                                   sigqueue_free_ignored()
>                                       posixtimer_sig_ignore()
>                                           // Observe POSIX_TIMER_REQUEUE_PENDING
>                                           hlist_add_head(...ignored_posix_timers)
>                                do_exit()
>                                    exit_itimers()
>                                    if (hlist_empty(&tsk->signal->posix_timers))
>                                        return;
>                                    // leaked timer queued to migrate list
>                                    

Duh. Let me stare at that some more.


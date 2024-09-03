Return-Path: <linux-kernel+bounces-312852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFF8969C71
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE9DB23BD7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDD91B984D;
	Tue,  3 Sep 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QFfm+qGp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4foM/D8q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EDE1A42D8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364258; cv=none; b=WzEX9wPD/MYklSZ3zHbPfE0KtnCf2NRpkO4H5c+gFV764c6A4WLIu2cwJrWzSMQHU55oZVR+pYlUQSAKkl9VNAcDq6tvlaf7BaFk5CtvmKq1WQgwoq93ruymXWK8CHUG/sUOteTiq1ukWgD+SLiIYMmyX9iIXmF4Gy+b1qP5zKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364258; c=relaxed/simple;
	bh=CZBsmTZIVXelg9yBz+T49guuUX5vDPDlpK5hF0wRiMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LZQPebnruloWgYS0SRT0I+5bvPVnWkzucwayn/yatWzcN4K6O8sLUbHR9GBaJArQqb8gjObKeEskGN9iYILLRoGVlCN8qTzMS/zWCkkDDGxaQsHOIDDaqOyo8pqf1THNM+XXUlwtfXIaQauI7Ez+KzteVrWdHUCzAQL/adbCO6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QFfm+qGp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4foM/D8q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725364249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M1dwO7EL6YycvwVYVv5JRFzng2Q1LL9OESDppVBBsWQ=;
	b=QFfm+qGptQ2DptZLy9xzzL7Td1rhv4U0Mn7i9rZ8TjBhyF4+INlgb8TUgTz6rg+WyDwzeH
	b7QStz8qFBrF76zAM6us2zfdliUUr69InFhNgd9p7nRbxNv8KH1sIAjW7SXN9zjWwBelCG
	RlFO5JW+JwBI33tp/fE6QFus15jJIYecnkRb/stlFppL+vGJbtkM/Vz1KwISV/GkV6qqo5
	NlsNchzorkQACQrfohQoDdVLc7QjJl0uAgg/Zsf/aK88kKi7o++pW41AZbH3GI11o3lYHa
	usrQzXhwX59EmWAM7qcoeSCxgc3B0iAdbt/59RmmvnUN4knWxswdQRqNm60LsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725364249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M1dwO7EL6YycvwVYVv5JRFzng2Q1LL9OESDppVBBsWQ=;
	b=4foM/D8qtngFSwciSjaLcOIYs77rgcTQEdCjnAVz4/j+e/HMTK9tRHZTcmKtsaTtFJ6RrO
	tgSyok4GNWlA9ICg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 09/17] printk: nbcon: Rely on kthreads for
 normal operation
In-Reply-To: <Ztbgi4-gDvxMYMXw@pathway.suse.cz>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
 <20240830152916.10136-10-john.ogness@linutronix.de>
 <Ztbgi4-gDvxMYMXw@pathway.suse.cz>
Date: Tue, 03 Sep 2024 13:56:48 +0206
Message-ID: <877cbtj6qv.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-03, Petr Mladek <pmladek@suse.com> wrote:
>> @@ -3071,12 +3080,21 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>>  	do {
>>  		any_progress = false;
>>  
>> +		printk_get_console_flush_type(&ft);
>> +
>>  		cookie = console_srcu_read_lock();
>>  		for_each_console_srcu(con) {
>>  			short flags = console_srcu_read_flags(con);
>>  			u64 printk_seq;
>>  			bool progress;
>>  
>> +			/*
>> +			 * console_flush_all() is only for legacy consoles when
>> +			 * the nbcon consoles have their printer threads.
>> +			 */
>> +			if ((flags & CON_NBCON) && ft.nbcon_offload)
>> +				continue;
>
> I mean that we really
> should handle nbcon consoles in the legacy loop only when there
> is a boot console (both ft.nbcon_* == false).

Agreed. I will change it to:

			/*
			 * console_flush_all() is only responsible for nbcon
			 * consoles when the nbcon consoles cannot print via
			 * their atomic or threaded flushing.
			 */
			if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
				continue;


Also note that patch 15/17 ("printk: Implement legacy printer kthread
for PREEMPT_RT") has the same check in legacy_kthread_should_wakeup(),
which I will also update.

John


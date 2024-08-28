Return-Path: <linux-kernel+bounces-305440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64D2962E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E9E1F238A8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2B91A4F3F;
	Wed, 28 Aug 2024 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZoeIGvUv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pR+zgidQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6673D166F2B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866407; cv=none; b=RI8Nwons7O6y2FjjMYs4wKm6KVz93olkxu9EgmniEcbpCsfPnKWqMLMk0GhlrOTn2o28ckdeXdf1VslL8zUy/g0qsuo/nbhzOXksUh2ricEmbDzeKjw2cUJHQUSmD/xP+or8+ff26Hzd+HfRck4djvlpuscH25hZZ/86QrNjuMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866407; c=relaxed/simple;
	bh=3H5J3L2xof8F9mgHp70NUvd3NFYibPFG40CB+iEOrbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XPSdL6k/lgcHldZymMTp5SEjXJ6m5hAfk0o8L6oveVpvhCTEADbBzA4vI0KzBkJS+so13LDht2X3n4o3NlxytxJpJRQDfZU8YkuVRJfZooYit/AKbxhEG7k5OcbSMtaF2yctpJ8aa4C+PmN8oEdla79EwSTzQIEaCFI5NOXYIwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZoeIGvUv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pR+zgidQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724866403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlzVH2I0xjZsHsbx2kSBiip49ZnONc151wXAOnUGLqM=;
	b=ZoeIGvUvrmq/wzPFp7vF9TT3WUnHYOyCZFWV/fTjT3t91up30+ro7jRC/8J3olXsDhyukc
	SABNAWQuXG2OnMo3/2qzRT8cConkCmC1c3xUWLid6u7WZJkIe0ihOpE0We/2wY1N1xGQRh
	2WzlbUqDLYQW9J7L+jbwfiuTE0XzHxz2WPl6/AluiyQsT6vYD3Wp4p6C5hGY5zq1M+d2nY
	ukku99R2+n7oYMeiUoUaGRb/+2Lq9hxD6n3Y/U06sT0hr10YkfeiYl2XMYm1PxWM1qrVk8
	ascI3KrZqRq2a6GNIX/JLkPlLl/TMd3NJUcK+fOA7MKkjVBZpMRKS1vkTRjxLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724866403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlzVH2I0xjZsHsbx2kSBiip49ZnONc151wXAOnUGLqM=;
	b=pR+zgidQ6RzouqkICdZE89CEEOx8g8VsadqDotDDL5oBkMoV9zyoS/ntLlidtMQUXw0w6z
	Jn9QZxAiVpqTWNAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 06/17] printk: nbcon: Introduce printer kthreads
In-Reply-To: <Zs3nRK4ikgzMx7JU@pathway.suse.cz>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
 <20240827044333.88596-7-john.ogness@linutronix.de>
 <Zs3nRK4ikgzMx7JU@pathway.suse.cz>
Date: Wed, 28 Aug 2024 19:39:22 +0206
Message-ID: <87r0a8wo0t.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-08-27, Petr Mladek <pmladek@suse.com> wrote:
>> +/**
>> + * nbcon_kthread_create - Create a console printer thread
>> + * @con:	Console to operate on
>> + *
>> + * Return:	True if the kthread was started or already exists.
>> + *		Otherwise false and @con must not be registered.
>> + *
>> + * If @con was already registered, it must be unregistered before
>> + * the global state variable @printk_kthreads_running can be set.
>
> This paragraph is quite confusing without more context.

Agreed.

> I would either remove it completely or write something like:
>
> <proposal>
>  * This function is called when nbcon consoles are supposed to be flushed
>  * using the kthread. The messages printed with NBCON_PRIO_NORMAL are not
>  * longer flushed by the legacy loop. This is why the failure is considered
>  * fatal leading to the console unregistration.
> </proposal>

For v5 I am keeping both, slightly modified:

 * This function is called when it will be expected that nbcon consoles are
 * flushed using the kthread. The messages printed with NBCON_PRIO_NORMAL
 * will be no longer flushed by the legacy loop. This is why failure must
 * be fatal for console registration.
 *
 * If @con was already registered and this function fails, @con must be
 * unregistered before the global state variable @printk_kthreads_running
 * can be set.

>> @@ -1419,6 +1644,13 @@ bool nbcon_alloc(struct console *con)
>>  			con_printk(KERN_ERR, con, "failed to allocate printing buffer\n");
>>  			return false;
>>  		}
>> +
>> +		if (printk_kthreads_running) {
>> +			if (!nbcon_kthread_create(con)) {
>> +				kfree(con->pbufs);
>
> It probably is not much important but I would rather do here:
>
> 				con->pbufs = NULL;

Sure.

I'll leave off your Reviewed-by since the comment changes are a bit
different than you suggested.

John


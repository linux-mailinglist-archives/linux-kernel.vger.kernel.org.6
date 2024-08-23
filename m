Return-Path: <linux-kernel+bounces-299533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB5395D5F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3673628539D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043C91922DB;
	Fri, 23 Aug 2024 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2zboGY1+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ycjea7sJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4E913A265
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724440594; cv=none; b=g2rt+I3NlXkKKbvmQ5UhBEdnlZI9FyrIQCfQZb45pRfTtPXIGdV4qgXoBiAs99twPAex5e0TLcsDyhst/sJruZgVYpzmyJBoBuHH5pdFSKcBmyRFqhOnIpsoJOA8ch7cT+n9xqWh4vrhsxH+To73gLklqz/9vQEMUdELmT2XI+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724440594; c=relaxed/simple;
	bh=wLDmGogH1f9s6SYDQKS5kLTfowcNEwIkOYLbGmaKfeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O9JJjpqL9MoOID5NVcTWbmeZcbnAuq499G5HX2kdEuPGlwAQZfWgEB3ngUu9wP6ZIZcL85m6KKhv4oXZYhR6cYiP5tBedsERwtmdGz7FiI9tE6oMbDA9mevJIkYcJI7jH19/pPPR61h6DuIXnucKuhqJvunhNIoQEsFZ6Ko2MaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2zboGY1+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ycjea7sJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724440591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wGYQJJqy7A0xMYqRC/bMPofGyzCYZPoDiqJJsbHmZlU=;
	b=2zboGY1+S0sdDCBpJTKYJYEwJc1QA09oCyER5zR119ECtLgFkS1spOeNH1mxmoUCPPtSic
	zHRvh1Vay2OwKwDRbdQoIh8XzuIcFVg7fFHcYSuseRQU3AsKNmYdJoUKjEyVopBLh3Xl45
	7w6LFynXXLo33hC76WANAfyCbsX/y5terdYn5hR+WOqEQiJZ3BxsqBiu1E0j9Jw2vK7abD
	0E6Xyo/2zYPQtHVObgXNHhAlMwZukR7Zo57D6CFy8EOYvhuS9tUay1AqK6P+N2l9qGtq26
	moQoDkcXOl6lvKZr/pNYfUVksduI4lQ/C6GiR7UPmMqiajThoy0MIuQi9SaWgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724440591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wGYQJJqy7A0xMYqRC/bMPofGyzCYZPoDiqJJsbHmZlU=;
	b=ycjea7sJvGHcmMebUM5TOpUMrrIl9G4PTZEU9dU8frY2PsV49dc+mT+c7+TjCc9p8OPqy5
	ZLLQLAdJ5ws2YNDw==
To: Jeff Xie <jeff.xie@linux.dev>
Cc: linux-kernel@vger.kernel.org, xiehuan09@gmail.com, Jeff Xie
 <jeff.xie@linux.dev>
Subject: Re: [PATCH] genirq: procfs: Make smp_affinity read-only for
 interrupts marked with IRQD_AFFINITY_MANAGED flag
In-Reply-To: <20240820020904.2514189-1-jeff.xie@linux.dev>
References: <20240820020904.2514189-1-jeff.xie@linux.dev>
Date: Fri, 23 Aug 2024 21:16:30 +0200
Message-ID: <875xrrgicx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 20 2024 at 10:09, Jeff Xie wrote:
> Currently, due to the interrupt subsystem introduced this commit 9c2555835bb3
> ("genirq: Introduce IRQD_AFFINITY_MANAGED flag"),

This is not really a proper sentence.

> an error is reported when a
> system administrator modifies the smp_affinity for the virtio_blk driver.
> For example:
>
> jeff-labs:/proc/irq/26 # echo 2 > ./smp_affinity
> -bash: echo: write error: Input/output error

That should obviously return -EPERM for managed interrupts.

> However, checking the permissions of smp_affinity/smp_affinity_list shows that
> they are set to rw. System administrators are strongly complaining about this issue.

System administrators complain strongly about a lot of things. Such
complaints are not necessarily a technical reason to change the code.

A proper reason is to argue, that the kernel already knows at the time
of interrupt allocation that the affinity cannot be controlled by
userspace and therefore creating the file with write permissions is
wrong.

> jeff-labs:/proc/irq/26 # ls -l
> total 0
> -r--r--r-- 1 root root 0 Aug 20 01:32 affinity_hint
> -r--r--r-- 1 root root 0 Aug 20 01:32 effective_affinity
> -r--r--r-- 1 root root 0 Aug 20 01:32 effective_affinity_list
> -r--r--r-- 1 root root 0 Aug 20 01:32 node
> -rw-r--r-- 1 root root 0 Aug 20 01:32 smp_affinity
> -rw-r--r-- 1 root root 0 Aug 20 01:32 smp_affinity_list
> -r--r--r-- 1 root root 0 Aug 20 01:32 spurious
> dr-xr-xr-x 2 root root 0 Aug 20 01:32 virtio3-req.0

We can see that from the code, no?

> Therefore, the permissions of smp_affinity/smp_affinity_list should be changed to read-only.

Should? Tell what the solution is:

Therefore set the file permissions to read-only for such interrupts.

And please format you change log so that it has linebreaks around 75
characters.

>  
>  #ifdef CONFIG_SMP
>  	/* create /proc/irq/<irq>/smp_affinity */
> -	proc_create_data("smp_affinity", 0644, desc->dir,
> +	if (unlikely(irqd_affinity_is_managed(&desc->irq_data)))

This unlikely is a pointless exercise as this is not a hotpath
operation. Also please switch to S_IRUGO / S_IWUSR and simplify the
whole thing to:

	umode_t umode = S_IRUGO;

	if (!irqd_affinity_is_managed(&desc->irq_data))
		umode |= S_IWUSR;
	proc_create_data("smp_affinity", umode, desc->dir, &irq_affinity_proc_ops, irqp);

Thanks,

        tglx


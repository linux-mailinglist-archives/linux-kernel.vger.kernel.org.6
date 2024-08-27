Return-Path: <linux-kernel+bounces-303524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E17960D69
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C71C2840AA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72FB1C4627;
	Tue, 27 Aug 2024 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vIUgN3HD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BA6digEf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5283933E8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768376; cv=none; b=PLxpQ6P+5rm1qjUwfkfDGaucr/wqUdUvycVZlYN9aVISJ0iAHitzFJ1f8Rup6nMrFhBv+bEUpP+W9/6AiGgLLU3BXXjkmOykBBpR3KyY2MJBdcjD2lCa+Hg19wAb3x6eU/qnM1DBHN+aEGAm1TAkqfgn1aR26TP8+uP62sGnxuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768376; c=relaxed/simple;
	bh=QJ/ftQZtxj0LcUygvo9hZYcVnsFGQbSRZ3FZJk2wK3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fhHAGWqPISzLqgUimO0NS3Cwpgscp/TeEieF1gK5MCE/xjFhd/EhOKCZ1ejSxiJbWq3B+L/DdpiXgJshVq0Jn431ES1nr0I+5nAJnbd8BZKjllfKVusAwViR25VMb3iw2e73JgrAW3ABd18fg+mZRhwytR0wTJsYZnoBo6ckUT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vIUgN3HD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BA6digEf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724768372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0+p7x+4QcXQbnltSLZ6EbN36Wx8/Q2GGi33foyf5DI=;
	b=vIUgN3HDFjXtQwvYIqtoKHsYYrJk/NMce9C63ivrT4oCkFhbGrY5vkyHq4Tcuhpb4KwKub
	S2ytYuTuOzmaAa+1qbHbJ1TfEBPvFwclnNtqA9vYG2LSULuusblxocD/yTfqxa36w4iWAb
	c9Cj66Wel4Bib0j5C0GziTK7xZg0f2piL4brV3zKhKKvON3ftKhQO6+eSXyPuRpyvp2rCq
	RmnQGAXj1b+TLRSic2ymCa2Ypt+r3reHFzo4WBUYgurGHmo+olT+ekJV4RDOrbH/MhodvT
	rvvNusQTn7ZkYT1m8JGscy2SMtWIjRiU69blPXt/6V3ansSDyUt6OYTXJpiKGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724768372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0+p7x+4QcXQbnltSLZ6EbN36Wx8/Q2GGi33foyf5DI=;
	b=BA6digEfxdcGwktDje4WJflXrKil5NKoyv5MuH3m4csRBC2vQ/XBG0tWLlEax881E1TfnS
	6R4Wl0KKrWYCymCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH printk v8 31/35] printk: nbcon: Implement emergency
 sections
In-Reply-To: <20240820063001.36405-32-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
 <20240820063001.36405-32-john.ogness@linutronix.de>
Date: Tue, 27 Aug 2024 16:25:31 +0206
Message-ID: <87plpum4jw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Petr,

On 2024-08-20, John Ogness <john.ogness@linutronix.de> wrote:
> +static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
> +{
> +	/*
> +	 * The value of __printk_percpu_data_ready gets set in normal
> +	 * context and before SMP initialization. As a result it could
> +	 * never change while inside an nbcon emergency section.
> +	 */
> +	if (!printk_percpu_data_ready())
> +		return &early_nbcon_pcpu_emergency_nesting;
> +
> +	/* Open code this_cpu_ptr() without checking migration. */
> +	return per_cpu_ptr(&nbcon_pcpu_emergency_nesting, raw_smp_processor_id());
> +}

It was pointed out to me that raw_cpu_ptr() exists exactly for this
purpose. There is no need to open code it. Perhaps you can fold the
following patch into this one for linux-next?

John

------------8<--------------
From fe50e9646c44360d88749c2c24c109405b27ad9e Mon Sep 17 00:00:00 2001
From: John Ogness <john.ogness@linutronix.de>
Date: Tue, 27 Aug 2024 14:06:19 +0000
Subject: [PATCH] printk: nbcon: Use raw_cpu_ptr() instead of open coding

There is no need to open code a non-migration-checking
this_cpu_ptr(). That is exactly what raw_cpu_ptr() is.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/nbcon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 92ac5c590927..cf62f675c673 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -998,8 +998,7 @@ static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
 	if (!printk_percpu_data_ready())
 		return &early_nbcon_pcpu_emergency_nesting;
 
-	/* Open code this_cpu_ptr() without checking migration. */
-	return per_cpu_ptr(&nbcon_pcpu_emergency_nesting, raw_smp_processor_id());
+	return raw_cpu_ptr(&nbcon_pcpu_emergency_nesting);
 }
 
 /**
-- 
2.30.2


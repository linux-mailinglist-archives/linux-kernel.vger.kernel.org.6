Return-Path: <linux-kernel+bounces-254800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E40139337AC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217BE1C220CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626161B974;
	Wed, 17 Jul 2024 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1J46aFuE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z4H+b/mg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E5317583
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721200595; cv=none; b=aRHsCTaAdHmmRBVSzDKZW2sgLASf08SZymIbSQygDdfp+Qh6kmF1mfm/suzJGgKUtuJzGDTwcb6zOtm2xa56QS5+D3i4mgvaM30hc5cTb9b+ZxlkhxgNamrGPDo2HvgeDV5Fbsc95pBTHpqNkitivpAn2ZlfEWrtHKBH4A83Jo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721200595; c=relaxed/simple;
	bh=i9AoYpWgtpdXD1IX9Red9HUNT2/2wI6Kug6Ap8SjPfg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eL3uaVoy5zV0W3vO2yABo1zubTZ/BDAKmcXY/nuqav3auhxJAkOLOuM9JlG5cHd0hHvLB++8yxMLcXteww5fFokW9fhzXrBnFoLowDwXfKWeNhvJcJR4H6wVGTOHfTqjtYYrHvKZVRxMqdmgEuwEcCmYhtpZL4vt94mzrlTnE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1J46aFuE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z4H+b/mg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721200582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSCvW48K6adeN+LDxxf/znVUUt04XgPAkSzush46M6A=;
	b=1J46aFuEwiKTNUT41ZTx6nl2gATuN21u+CCI84qas1z0BjTm+bj+VSEUM5dAZG26ZF7oZd
	wuUEWAIjYvqcUDRKZ4DlwDqMtXzlTib8/QIACW392dIEwwcjKa+d6aybjU4z/ayI8Z9i++
	fohtoPFgs5/EzLpxoasYqUxH3atgKbTYb0JW3T+JY6cx9Am8D8uk8NdRqZ33NOSu3E3MqA
	vmUk+UQYSjjZQwXC+Ifq39g8HPrbkTSd/1Pqj9LV89leLXhLTMJvHI1DrgZtfG51bYvDc0
	Ycf65utgkGntqtVDq0/pTyQS3RVss1KnwczX0aYIQbHLpfBCCMtHu0q9u+90oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721200582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FSCvW48K6adeN+LDxxf/znVUUt04XgPAkSzush46M6A=;
	b=z4H+b/mgowtk55QnxOjZpprU9WgkL5cTAlTNiwdWdWqgF+vJvGGn/3HJCqYuBRD74WzlWA
	VaBkuPmDHAJoxTDw==
To: Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Omar Sandoval <osandov@meta.com>, linux-kernel@vger.kernel.org, Petr
 Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [RFC PATCH] nmi,printk: fix ABBA deadlock between nmi_backtrace
 and dump_stack_lvl
In-Reply-To: <20240715232052.73eb7fb1@imladris.surriel.com>
References: <20240715232052.73eb7fb1@imladris.surriel.com>
Date: Wed, 17 Jul 2024 09:22:21 +0206
Message-ID: <87plrcqyii.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-07-15, Rik van Riel <riel@surriel.com> wrote:
> Both nmi_backtrace and dump_stack_lvl call printk_cpu_sync_get_irqsave.
>
> However, dump_stack_lvl will call into the printk code, while holding
> the printk_cpu_sync_get lock, and then take the console lock.
>
> Another CPU may end up getting an NMI stack trace printed, after
> being stuck printing something to serial console for too long,
> with the console lock held.
>
> This results in the following lock order:
> CPU A: printk_cpu_sync_get lock -> console_lock
> CPU B: console_lock -> (nmi) printk_cpu_sync_get lock
>
> This will cause the system to hang with an ABBA deadlock

The console lock is acquired via trylock, so that will not yield
deadlock here. However, if CPU B was printing, then CPU A will spin on
@console_waiter (in console_trylock_spinning()). _That_ is a deadlock.

The purpose of printk_cpu_sync_get_irqsave() is to avoid having the
different backtraces being interleaved in the _ringbuffer_. It really
isn't necessary that they are printed in that context. And indeed, there
is no guarantee that they will be printed in that context anyway.

Perhaps a simple solution would be for printk_cpu_sync_get_irqsave() to
call printk_deferred_enter/_exit. Something like the below patch.

John Ogness

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 65c5184470f1..1a6f5aac28bf 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -315,8 +315,10 @@ extern void __printk_cpu_sync_put(void);
 #define printk_cpu_sync_get_irqsave(flags)		\
 	for (;;) {					\
 		local_irq_save(flags);			\
+		printk_deferred_enter();		\
 		if (__printk_cpu_sync_try_get())	\
 			break;				\
+		printk_deferred_exit();			\
 		local_irq_restore(flags);		\
 		__printk_cpu_sync_wait();		\
 	}
@@ -329,6 +331,7 @@ extern void __printk_cpu_sync_put(void);
 #define printk_cpu_sync_put_irqrestore(flags)	\
 	do {					\
 		__printk_cpu_sync_put();	\
+		printk_deferred_exit();		\
 		local_irq_restore(flags);	\
 	} while (0)
 


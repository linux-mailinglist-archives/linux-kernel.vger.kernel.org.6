Return-Path: <linux-kernel+bounces-265685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF2493F469
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0782819C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43851465A2;
	Mon, 29 Jul 2024 11:46:08 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8331448DD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253568; cv=none; b=gVL2Ppimy9L99Ji238bpvrGl5x/aQEh3BlqSxt5kapS/kMIyLGyX2Azg8JpYYC9ii3YA73Tw6TEp0wfZWhfJbo4o2pK7NRyRsLMtcVlVK/yzfq9eAgRhQidV88HyeV91HEBhEHhx/WxYGdTjFKZVq+lhDV9PXP2FzdJv2IN0ZW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253568; c=relaxed/simple;
	bh=UOcJZI74Yeik0Br5WtJiNS+1aQgka4w2of2rRtN1a2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tlmRa10900z5D6pZizcQgaxF+Jiiw/uj5uLmahDiczzBC+kU33hYthrvBcErOY664ArgIFesOTkp4h3HabuGwd8jWNetPHuOM3SK+nf/VvVxmI6L5u59jr5EgduU3b/H7QpCGqdF4c3CE4hEIudriQnDg8mnRCCQofIVbCnX8dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id EB985A9D81;
	Mon, 29 Jul 2024 20:46:03 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZQ2sQRu4j-_x; Mon, 29 Jul 2024 20:46:03 +0900 (JST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp [210.128.90.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id C2B8AA9D79;
	Mon, 29 Jul 2024 20:46:03 +0900 (JST)
From: takakura@valinux.co.jp
To: pmladek@suse.com,
	john.ogness@linutronix.de
Cc: rostedt@goodmis.org,
	senozhatsky@chromium.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	lukas@wunner.de,
	wangkefeng.wang@huawei.com,
	ubizjak@gmail.com,
	feng.tang@intel.com,
	j.granados@samsung.com,
	stephen.s.brennan@oracle.com,
	linux-kernel@vger.kernel.org,
	nishimura@valinux.co.jp,
	taka@valinux.co.jp
Subject: Re: [PATCH] printk: CPU backtrace not printing on panic
Date: Mon, 29 Jul 2024 20:46:01 +0900
Message-Id: <20240729114601.176047-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87ttgcw92a.fsf@jogness.linutronix.de>
References: <87ttgcw92a.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Petr and John,

Thanks for the feeedback!
Sorry that I was not keeping up with the recent nbcon updates and I 
don't think the patch I sent was reflecting them.

On 2024-07-26, John Ogness wrote:
>On 2024-07-26, Petr Mladek <pmladek@suse.com> wrote:
>> I would do it the other way and enable printing from other CPUs only
>> when triggring the backtrace. We could do it because
>> trigger_all_cpu_backtrace() waits until all backtraces are
>> printed.
>>

Yes, I think doing it other way around works better filtering out 
the non-panicked CPU's irrelevant messages as it does now.
As suggested, it also makes it simple as it removes the need for 
what I suggested (bringing back commit 13fb0f74d702 ("printk: Avoid 
livelock with heavy printk during panic")) which intention was 
to check wheather to trigger backtrace or not based on those 
irrelevant messages.

>> Something like:
>>
>> diff --git a/include/linux/panic.h b/include/linux/panic.h
>> index 3130e0b5116b..980bacbdfcfc 100644
>> --- a/include/linux/panic.h
>> +++ b/include/linux/panic.h
>> @@ -16,6 +16,7 @@ extern void oops_enter(void);
>>  extern void oops_exit(void);
>>  extern bool oops_may_print(void);
>>  
>> +extern int panic_triggering_all_cpu_backtrace;
>>  extern int panic_timeout;
>>  extern unsigned long panic_print;
>>  extern int panic_on_oops;
>> diff --git a/kernel/panic.c b/kernel/panic.c
>> index f861bedc1925..7e9e97d59b1e 100644
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -64,6 +64,8 @@ unsigned long panic_on_taint;
>>  bool panic_on_taint_nousertaint = false;
>>  static unsigned int warn_limit __read_mostly;
>>  
>> +int panic_triggering_all_cpu_backtrace;
>> +
>>  int panic_timeout = CONFIG_PANIC_TIMEOUT;
>>  EXPORT_SYMBOL_GPL(panic_timeout);
>>  
>> @@ -253,8 +255,12 @@ void check_panic_on_warn(const char *origin)
>>   */
>>  static void panic_other_cpus_shutdown(bool crash_kexec)
>>  {
>> -	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
>> +	if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
>> +		/* Temporary allow printing messages on non-panic CPUs. */
>> +		panic_triggering_all_cpu_backtrace = true;
>>  		trigger_all_cpu_backtrace();
>> +		panic_triggering_all_cpu_backtrace = false;
>
>Note, here we should also add
>
>		nbcon_atomic_flush_pending();
>
>Your suggestion allows the other CPUs to dump their backtrace into the
>ringbuffer, but they are still forbidden from acquiring the nbcon
>console contexts for printing. That is a necessary requirement of
>nbcon_waiter_matches().

Thanks for pointing it out. I see that it can only allows to write into 
the ringbuffer and printing also needs to be taken care as well.

>Or since the cpu_sync is held while printing the backtrace, we could
>allow the non-panic CPUs to print by modifying the check in
>nbcon_context_try_acquire_direct():
>
>----- BEGIN -----
>diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
>index ef6e76db0f5a..cd8724840edc 100644
>--- a/kernel/printk/nbcon.c
>+++ b/kernel/printk/nbcon.c
>@@ -241,7 +241,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
> 	struct nbcon_state new;
> 
> 	do {
>-		if (other_cpu_in_panic())
>+		if (other_cpu_in_panic() && !__printk_cpu_sync_owner())
> 			return -EPERM;
> 
> 		if (ctxt->prio <= cur->prio || ctxt->prio <= cur->req_prio)
>diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>index 613644c55e54..f486d0b84a84 100644
>--- a/kernel/printk/printk.c
>+++ b/kernel/printk/printk.c
>@@ -4569,6 +4569,11 @@ void __printk_cpu_sync_wait(void)
> }
> EXPORT_SYMBOL(__printk_cpu_sync_wait);
> 
>+bool __printk_cpu_sync_owner(void)
>+{
>+	return (atomic_read(&printk_cpu_sync_owner) == raw_smp_processor_id());
>+}
>+
> /**
>  * __printk_cpu_sync_try_get() - Try to acquire the printk cpu-reentrant
>  *                               spinning lock.
>----- END -----
>
>> +	}
>>  
>>  	/*
>>  	 * Note that smp_send_stop() is the usual SMP shutdown function,
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 054c0e7784fd..c22b07049c38 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2316,7 +2316,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>>  	 * non-panic CPUs are generating any messages, they will be
>>  	 * silently dropped.
>>  	 */
>> -	if (other_cpu_in_panic())
>> +	if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
>>  		return 0;
>I wonder if it is enough to check if it is holding the cpu_sync. Then we
>would not need @panic_triggering_all_cpu_backtrace.

Taking a look at the cpu_sync, it seems CPU backtrace is the only one holding 
the cpu_sync after panic. If so, I also think that it can replace 
@panic_triggering_all_cpu_backtrace.

But I thought that we still need @panic_triggering_all_cpu_backtrace
to let non-panic CPUs writing their backtrace to ringbuffer if we were to 
use cpu_sync to pass the check within nbcon_context_try_acquire_direct().
Or can we use cpu_sync for checking wheather non-panicked CPUs can write to 
ringbuffer and let nbcon_atomic_flush_pending() do the printing something like:

----- BEGIN -----
diff --git a/kernel/panic.c b/kernel/panic.c
index 7e207092576b..eed76e3e061b 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -252,8 +252,10 @@ void check_panic_on_warn(const char *origin)
  */
 static void panic_other_cpus_shutdown(bool crash_kexec)
 {
-	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
+	if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
 		trigger_all_cpu_backtrace();
+		nbcon_atomic_flush_pending();
+	}

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d0bff0b0abfd..b8132801ea07 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2354,7 +2354,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	 * non-panic CPUs are generating any messages, they will be
 	 * silently dropped.
 	 */
-	if (other_cpu_in_panic())
+	if (other_cpu_in_panic() && !__printk_cpu_sync_owner())
 		return 0;
 
 	if (level == LOGLEVEL_SCHED) {
@@ -4511,6 +4511,11 @@ void __printk_cpu_sync_wait(void)
 }
 EXPORT_SYMBOL(__printk_cpu_sync_wait);
 
+bool __printk_cpu_sync_owner(void)
+{
+	return (atomic_read(&printk_cpu_sync_owner) == raw_smp_processor_id());
+}
+
----- END -----


>John

Sincerely,
Ryo Takakura


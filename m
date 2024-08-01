Return-Path: <linux-kernel+bounces-270879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E87AA944692
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696DC1F263CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2099C16DC3A;
	Thu,  1 Aug 2024 08:27:27 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D66216DC1A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500846; cv=none; b=B7OpSPtxuUw9fHRZ5u5FH8zXdLM9x2wVuad+2vTXvyfi6peUCP7wBlWXdOwvhAluljuCtiRZTtaaDQfrArxSc5I8ZOn3zH1nwQn7q2C0aQUHeMTG1G9k5lCcT8dbstyQnRMNMDG82Sp7ERiOovDjrxzruKZhg1kYajj3niyEfrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500846; c=relaxed/simple;
	bh=bwQrI43NqaW12FyO/KdLKo2sVaxzLYiyS7gEzeAG22s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AMIib3JGVseEzXBLiiRUiQ9IRCdGlMIutduKtROf5HBOszuNMwSyPVmyxRGvr32Jo5bdRfkU/50McjE6f119A9iXHuZFkt/U5/4M1tKwcXVBrMh8I/FvhxKo7Urw2hyVe6SmZAizooWaMmS3NTvbUqdmTpyc6MHBcISSsFxKJnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 4D2B5A9DA8;
	Thu,  1 Aug 2024 17:27:22 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vgWTJz909g3Y; Thu,  1 Aug 2024 17:27:22 +0900 (JST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp [210.128.90.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 21FC6A9DA6;
	Thu,  1 Aug 2024 17:27:22 +0900 (JST)
From: takakura@valinux.co.jp
To: pmladek@suse.com,
	john.ogness@linutronix.de
Cc: akpm@linux-foundation.org,
	bhe@redhat.com,
	feng.tang@intel.com,
	j.granados@samsung.com,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	nishimura@valinux.co.jp,
	rostedt@goodmis.org,
	senozhatsky@chromium.org,
	stephen.s.brennan@oracle.com,
	taka@valinux.co.jp,
	takakura@valinux.co.jp,
	ubizjak@gmail.com,
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH] printk: CPU backtrace not printing on panic
Date: Thu,  1 Aug 2024 17:27:21 +0900
Message-Id: <20240801082721.62935-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZqjZMIxgm46qVgjL@pathway.suse.cz>
References: <ZqjZMIxgm46qVgjL@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Petr and John,

On 2024-07-30, Petr Mladek <pmladek@suse.com> wrote:
>On Fri 2024-07-26 16:02:45, John Ogness wrote:
>> On 2024-07-26, Petr Mladek <pmladek@suse.com> wrote:
>> > I would do it the other way and enable printing from other CPUs only
>> > when triggring the backtrace. We could do it because
>> > trigger_all_cpu_backtrace() waits until all backtraces are
>> > printed.
>> >
>> > Something like:
>> >
>> > diff --git a/include/linux/panic.h b/include/linux/panic.h
>> > index 3130e0b5116b..980bacbdfcfc 100644
>> > --- a/include/linux/panic.h
>> > +++ b/include/linux/panic.h
>> > @@ -16,6 +16,7 @@ extern void oops_enter(void);
>> >  extern void oops_exit(void);
>> >  extern bool oops_may_print(void);
>> >  
>> > +extern int panic_triggering_all_cpu_backtrace;
>> >  extern int panic_timeout;
>> >  extern unsigned long panic_print;
>> >  extern int panic_on_oops;
>> > diff --git a/kernel/panic.c b/kernel/panic.c
>> > index f861bedc1925..7e9e97d59b1e 100644
>> > --- a/kernel/panic.c
>> > +++ b/kernel/panic.c
>> > @@ -64,6 +64,8 @@ unsigned long panic_on_taint;
>> >  bool panic_on_taint_nousertaint = false;
>> >  static unsigned int warn_limit __read_mostly;
>> >  
>> > +int panic_triggering_all_cpu_backtrace;
>> > +
>> >  int panic_timeout = CONFIG_PANIC_TIMEOUT;
>> >  EXPORT_SYMBOL_GPL(panic_timeout);
>> >  
>> > @@ -253,8 +255,12 @@ void check_panic_on_warn(const char *origin)
>> >   */
>> >  static void panic_other_cpus_shutdown(bool crash_kexec)
>> >  {
>> > -	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
>> > +	if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
>> > +		/* Temporary allow printing messages on non-panic CPUs. */
>> > +		panic_triggering_all_cpu_backtrace = true;
>> >  		trigger_all_cpu_backtrace();
>> > +		panic_triggering_all_cpu_backtrace = false;
>> 
>> Note, here we should also add
>> 
>> 		nbcon_atomic_flush_pending();
>> 
>> Your suggestion allows the other CPUs to dump their backtrace into the
>> ringbuffer, but they are still forbidden from acquiring the nbcon
>> console contexts for printing. That is a necessary requirement of
>> nbcon_waiter_matches().
>
>Great catch!
>
>I would prefer to solve this in a separate patch. This problem existed
>even before the commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing
>to ringbuffer"). In fact, the problem existed very long time even for
>the legacy consoles.
>

Good point! I guess the problem existed since the commit 51a1d258e50e 
("printk: Keep non-panic-CPUs out of console lock") as it forbade the 
acquisition of console lock for non-panic cpus?

>It is pity that we need to handle both consoles separately. IMHO,
>we could get the same job done by calling
>
>	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>
>It flushes both nbcon and legacy consoles.
>
>> Or since the cpu_sync is held while printing the backtrace, we could
>> allow the non-panic CPUs to print by modifying the check in
>> nbcon_context_try_acquire_direct():
>> 
>> ----- BEGIN -----
>> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
>> index ef6e76db0f5a..cd8724840edc 100644
>> --- a/kernel/printk/nbcon.c
>> +++ b/kernel/printk/nbcon.c
>> @@ -241,7 +241,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
>>  	struct nbcon_state new;
>>  
>>  	do {
>> -		if (other_cpu_in_panic())
>> +		if (other_cpu_in_panic() && !__printk_cpu_sync_owner())
>
>Interesting idea. I am not completely against it.
>
>Well, this would be the only situation when nmi_cpu_backtrace() would
>be allowed to flush the messages directly. Also it would be yet
>another exception.
>
>I would probably keep it simple and just flush the messages from
>the panic-CPU (using console_flush_on_panic(CONSOLE_FLUSH_PENDING).
>
>
>>  			return -EPERM;
>>  
>>  		if (ctxt->prio <= cur->prio || ctxt->prio <= cur->req_prio)
>> > --- a/kernel/printk/printk.c
>> > +++ b/kernel/printk/printk.c
>> > @@ -2316,7 +2316,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>> >  	 * non-panic CPUs are generating any messages, they will be
>> >  	 * silently dropped.
>> >  	 */
>> > -	if (other_cpu_in_panic())
>> > +	if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
>> >  		return 0;
>> 
>> I wonder if it is enough to check if it is holding the cpu_sync. Then we
>> would not need @panic_triggering_all_cpu_backtrace.
>
>I prefer to keep panic_triggering_all_cpu_backtrace. I know, it is an
>ugly long name. But it clearly defines what we want to achieve.
>And it limits the exception to printing the backtraces.
>
>The check of the cpu_owner would work now because it is used basically
>only for the backtraces. But it might change anytime in the future.
>cpu_owner is a "generic" lock. I guess that it will be used
>in more situations in the future. Any change might break this
>scenario again...
>

I agree that the checking of cpu_owner can be insufficient in the future and 
the use of panic_triggering_all_cpu_backtrace is more reliable in that sense.

>Summary:
>
>I prefer two patches:
>
>  1st patch would allow storing the backtraces using the variable
>     panic_triggering_all_cpu_backtrace (better name appreciated).
>
>  2nd patch would cause flushing the backtraces. And I would use
>     console_flush_on_panic(CONSOLE_FLUSH_PENDING) as a variant
>     which can be backported to stable kernels. It might later
>     be updated by the upcoming printk rework.
>
>Best Regards,
>Petr

Thanks! I'll prepare another patch based on it!

Sincerely,
Ryo Takakura


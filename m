Return-Path: <linux-kernel+bounces-265724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8965993F50C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B6DB2115A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F1147C60;
	Mon, 29 Jul 2024 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MgrU+ehK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4wOUUFES"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDCF145FF4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255591; cv=none; b=LKdB343QPYD4pzFS2b0pWf8AOtZlvQ1UWQdHKoiCHficbJ9TRAGHLCdGmEV4FQa91jB7ow9zyQrlcTksa9FYv4fzZ3xlbBf9hk6K58t06WOuxyo+pE7etDHi7SLavwPec31XEmir0iuwBt9f0cv0kz+bq9WhbUW09lyMHbxI5GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255591; c=relaxed/simple;
	bh=MzzM7gZMWgYXHuEkglt29iytNyNv1OdxgHfpPiqNJFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mCeMcnN/p618IMCuZ6FTJp802uhwFEY4N3ft7gLXUHZf80Vh7s7aRVrLs1M83SU5iZzh3ZPqDh6d/3hXc7xafQB0INb5TiP9TJtEqLrKcXO8zaceDAyvRN5KlczGxevCLPDnKnlKDe6GmgPgEpt1/HhYRkK3wWXv1M+g5NgCNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MgrU+ehK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4wOUUFES; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722255588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lNWjWZ4uKtqbpDam97p7PdjDCl/yRAeT1Vx+rIPHAmU=;
	b=MgrU+ehKPM4cNIEUY5L6l93vo/apBt2YXNrhbKEhrpVAb+G5k09o6y9RED4YJL9PObG2QV
	PxI0B5K70VbChLWlTNOitdyTt4qb7/0WewhKBTpHL1kyd8NOHmx2vkEo2N3FwhNob0JAup
	1JqXaNiRNDfPok/9K03pmYa0uuWqKE+i1YlYPgJh88YVY4uQD6hXUJ3JdttlcZfsaqf8z8
	gzWdV8tqdRalmGKj9rMA7nFuvaSvgC+wRSnjCOHXYNdcwQLNMYYyViHb6NGUd3EYkbuMMW
	eExef5rcf01uLUq/oMcDxQOUu77Fk8OZ2l9tSaqozMM0TUJneiJizzEvopvyyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722255588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lNWjWZ4uKtqbpDam97p7PdjDCl/yRAeT1Vx+rIPHAmU=;
	b=4wOUUFESsCRWJB0lHQD0vy4+R4AH3BSbYw+7FWcVSi9D1pbYJb1dXHJDzysnxPCT+HF6Zo
	zIcTIYJ4kOA6f2Ag==
To: takakura@valinux.co.jp, pmladek@suse.com
Cc: rostedt@goodmis.org, senozhatsky@chromium.org,
 akpm@linux-foundation.org, bhe@redhat.com, lukas@wunner.de,
 wangkefeng.wang@huawei.com, ubizjak@gmail.com, feng.tang@intel.com,
 j.granados@samsung.com, stephen.s.brennan@oracle.com,
 linux-kernel@vger.kernel.org, nishimura@valinux.co.jp, taka@valinux.co.jp
Subject: Re: [PATCH] printk: CPU backtrace not printing on panic
In-Reply-To: <875xsofl7i.fsf@jogness.linutronix.de>
References: <87ttgcw92a.fsf@jogness.linutronix.de>
 <20240729114601.176047-1-takakura@valinux.co.jp>
 <875xsofl7i.fsf@jogness.linutronix.de>
Date: Mon, 29 Jul 2024 14:25:48 +0206
Message-ID: <871q3cfl0b.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sorry, missed an important negation...

On 2024-07-29, John Ogness <john.ogness@linutronix.de> wrote:
> Hi Ryo,
>
> On 2024-07-29, takakura@valinux.co.jp wrote:
>> Or can we use cpu_sync for checking wheather non-panicked CPUs can
>> write to ringbuffer and let nbcon_atomic_flush_pending() do the
>> printing
>
> Yes, I like this. Let the non-panic CPUs write their messages, but keep
> the actual printing to the panic CPU.
>
> Right after the call to panic_other_cpus_shutdown() we plan [0] on
> calling printk_legacy_allow_panic_sync(), which will handle flushing the
> legacy consoles.
>
>> something like:
>>
>> ----- BEGIN -----
>> diff --git a/kernel/panic.c b/kernel/panic.c
>> index 7e207092576b..eed76e3e061b 100644
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -252,8 +252,10 @@ void check_panic_on_warn(const char *origin)
>>   */
>>  static void panic_other_cpus_shutdown(bool crash_kexec)
>>  {
>> -	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
>> +	if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
>>  		trigger_all_cpu_backtrace();
>> +		nbcon_atomic_flush_pending();
>> +	}
>>
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index d0bff0b0abfd..b8132801ea07 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2354,7 +2354,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>>  	 * non-panic CPUs are generating any messages, they will be
>>  	 * silently dropped.
>>  	 */
>> -	if (other_cpu_in_panic())
>> +	if (other_cpu_in_panic() && !__printk_cpu_sync_owner())
>>  		return 0;
>>  
>>  	if (level == LOGLEVEL_SCHED) {
>> @@ -4511,6 +4511,11 @@ void __printk_cpu_sync_wait(void)
>>  }
>>  EXPORT_SYMBOL(__printk_cpu_sync_wait);
>>  
>> +bool __printk_cpu_sync_owner(void)
>> +{
>> +	return (atomic_read(&printk_cpu_sync_owner) == raw_smp_processor_id());
>> +}
>> +
>> ----- END -----
>
> Note that printing on the non-panic CPUs is guaranteed for nbcon

Note that _preventing_ printing on the non-panic CPUs...

> consoles because of the other_cpu_in_panic() in
> nbcon_context_try_acquire_direct() and for the legacy consoles because
> the cpu_sync holder must defer printing [1].
>
> I am curious what Petr has to say.
>
> John
>
> [0] https://lore.kernel.org/lkml/20240527063749.391035-26-john.ogness@linutronix.de
>
> [1] https://lore.kernel.org/lkml/87plrcqyii.fsf@jogness.linutronix.de


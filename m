Return-Path: <linux-kernel+bounces-265722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7E093F4FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A7F1F214C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF707145FEC;
	Mon, 29 Jul 2024 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RmzbNICN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MqHEV7RR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2994768EE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255334; cv=none; b=l7Uv6n+qHwEJS7KEZ1JblHu4oYSxsPZIu/ymk8GSk31KwiAXsh7B5mLQ2u5hRvVglvlgjmg68bNAfzTAILhWJ/Lo1AHd9ERUuQ3qLRJdyzFxztn53eQe9hpP/u84UWoNitEcYOjutkMobk6BlFLdiFEC5275HPnjSoOnzbbZSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255334; c=relaxed/simple;
	bh=qm0FYESEZsjhqzpEJli3S3dLCv+WuHhQaFgF5tWxM9k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HnE5bsWsnWBhTXULHPKZkIJVPWWX6RWgHTxXHmUaAqf8YC60tqEbDrj60NchAlBJn8zYNMY01f1eZMYos2Rg92JIYn/Q+irCtnlnby+pNhnbnsdyGbs+9uWyUQMepzjQI5K51KQl+qL6TSEyfkqxhIjNa95ddu7flRV7ccPD2Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RmzbNICN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MqHEV7RR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722255329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UqRDy5cDgs8ofUuFAgpB26i3fJChKQ0WdlYHrFrm5c8=;
	b=RmzbNICNYRYnbfc5056Fc01cl/Lb3qN3I4DEEfw3jmgY/wytXLa417XgFYiJm2hD2Oja2T
	CgYSNixhgfFalQ9FCp5MkK0lue10yKdkyXMNXUIySQPfN1uSkIwIk5Ysaj899fqVYnKbzr
	HVZFfHX6cNKGo7ZCLhYPPo5k74J3FI5tRMYmNz1rGoCymi4bCajd2BYJ0mCjuiDib9/X9e
	fXjmT1QIlaq5ja0UFSombHCSmWEWrE34GcPTzFopl56HH460cTG6pFIN3t/G0Spv4Aa0bN
	P9oP4Zc3EG4+Q0+hqW6MB8Mw9jJzx4j3aZReFlwS/RViG1mD7TykjXr2qQEM7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722255329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UqRDy5cDgs8ofUuFAgpB26i3fJChKQ0WdlYHrFrm5c8=;
	b=MqHEV7RRqhZkfQNZts45v5mnKV8G+A60BgWCa8I4azlUcxBWzbaDXYuqQweS1ed6s9amfg
	qqdwhy8TAKtjgTBg==
To: takakura@valinux.co.jp, pmladek@suse.com
Cc: rostedt@goodmis.org, senozhatsky@chromium.org,
 akpm@linux-foundation.org, bhe@redhat.com, lukas@wunner.de,
 wangkefeng.wang@huawei.com, ubizjak@gmail.com, feng.tang@intel.com,
 j.granados@samsung.com, stephen.s.brennan@oracle.com,
 linux-kernel@vger.kernel.org, nishimura@valinux.co.jp, taka@valinux.co.jp
Subject: Re: [PATCH] printk: CPU backtrace not printing on panic
In-Reply-To: <20240729114601.176047-1-takakura@valinux.co.jp>
References: <87ttgcw92a.fsf@jogness.linutronix.de>
 <20240729114601.176047-1-takakura@valinux.co.jp>
Date: Mon, 29 Jul 2024 14:21:29 +0206
Message-ID: <875xsofl7i.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Ryo,

On 2024-07-29, takakura@valinux.co.jp wrote:
> Or can we use cpu_sync for checking wheather non-panicked CPUs can
> write to ringbuffer and let nbcon_atomic_flush_pending() do the
> printing

Yes, I like this. Let the non-panic CPUs write their messages, but keep
the actual printing to the panic CPU.

Right after the call to panic_other_cpus_shutdown() we plan [0] on
calling printk_legacy_allow_panic_sync(), which will handle flushing the
legacy consoles.

> something like:
>
> ----- BEGIN -----
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 7e207092576b..eed76e3e061b 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -252,8 +252,10 @@ void check_panic_on_warn(const char *origin)
>   */
>  static void panic_other_cpus_shutdown(bool crash_kexec)
>  {
> -	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
> +	if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
>  		trigger_all_cpu_backtrace();
> +		nbcon_atomic_flush_pending();
> +	}
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index d0bff0b0abfd..b8132801ea07 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2354,7 +2354,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>  	 * non-panic CPUs are generating any messages, they will be
>  	 * silently dropped.
>  	 */
> -	if (other_cpu_in_panic())
> +	if (other_cpu_in_panic() && !__printk_cpu_sync_owner())
>  		return 0;
>  
>  	if (level == LOGLEVEL_SCHED) {
> @@ -4511,6 +4511,11 @@ void __printk_cpu_sync_wait(void)
>  }
>  EXPORT_SYMBOL(__printk_cpu_sync_wait);
>  
> +bool __printk_cpu_sync_owner(void)
> +{
> +	return (atomic_read(&printk_cpu_sync_owner) == raw_smp_processor_id());
> +}
> +
> ----- END -----

Note that printing on the non-panic CPUs is guaranteed for nbcon
consoles because of the other_cpu_in_panic() in
nbcon_context_try_acquire_direct() and for the legacy consoles because
the cpu_sync holder must defer printing [1].

I am curious what Petr has to say.

John

[0] https://lore.kernel.org/lkml/20240527063749.391035-26-john.ogness@linutronix.de

[1] https://lore.kernel.org/lkml/87plrcqyii.fsf@jogness.linutronix.de


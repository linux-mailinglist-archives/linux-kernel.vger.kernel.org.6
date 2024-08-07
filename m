Return-Path: <linux-kernel+bounces-277591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7C894A376
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A0E1F25100
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4EA1C9ED0;
	Wed,  7 Aug 2024 08:56:53 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DC422334
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723021013; cv=none; b=PJ230D7kWkoCpX6Q/dt6u2V6Z0iueFrh60ZIz4E6pYtVb2jARuuYH6Psa2qRcdhSaUnmN6oX8l1Wpq7iol3r51xkygldYV7ijL+6nMBeGCTDNpZpQA2+mThTkbmrSg/TsAScN/r9G1EyuQfvIGsm2NFB9nb+dJb4T5A78YjkRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723021013; c=relaxed/simple;
	bh=ebtFkMwx3xJufLPFaBedswd0P8SCQrUQf31+qONxTXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NIStadS0FRzrKycSQYIdS7uXmYnnr3FROHKLQOIHCt5guRsnmhih95ChNrQiT53qwkUlDK3uym0XiZiPBIb3PxdSDn7JkDoNOYLPBxeShIGzJzcqzSoq3RGB75v+9OhPY/kef3CtsNdjSrn8gbF68f2hQD7z5vAJuljhllwRDQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 5B3ADA9D00;
	Wed,  7 Aug 2024 17:56:48 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JVcbIOyLQlN1; Wed,  7 Aug 2024 17:56:48 +0900 (JST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp [210.128.90.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 2EFC7A9B79;
	Wed,  7 Aug 2024 17:56:48 +0900 (JST)
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
Subject: Re: [PATCH v2 1/2] Handle flushing of CPU backtraces during panic
Date: Wed,  7 Aug 2024 17:56:47 +0900
Message-Id: <20240807085647.92164-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZrDYfU6SVrR2Hj02@pathway.suse.cz>
References: <ZrDYfU6SVrR2Hj02@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Petr and John,

On 2024-08-05, Petr Mladek wrote:
>On Sat 2024-08-03 17:12:30, takakura@valinux.co.jp wrote:
>> From: Ryo Takakura <takakura@valinux.co.jp>
>> 
>> After panic, non-panicked CPU's has been unable to flush ringbuffer 
>> while they can still write into it. This can affect CPU backtrace 
>> triggered in panic only able to write into ringbuffer incapable of 
>> flushing them.
>> 
>> Fix the issue by letting the panicked CPU handle the flushing of 
>> ringbuffer right after non-panicked CPUs finished writing their
>> backtraces.
>> 
>> Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
>> ---
>>  kernel/panic.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/kernel/panic.c b/kernel/panic.c
>> index 7e2070925..f94923a63 100644
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -252,8 +252,10 @@ void check_panic_on_warn(const char *origin)
>>   */
>>  static void panic_other_cpus_shutdown(bool crash_kexec)
>>  {
>> -	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
>> +	if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
>>  		trigger_all_cpu_backtrace();
>> +		console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>
>Hmm, this is too dangerous.
>
>console_flush_on_panic() is supposed to be called at the end on
>panic() as the final desperate attempt to flush consoles.
>It does not take console_lock(). It must not be called before
>stopping non-panic() CPUs.

I see, yes, it is dangerous...  Thanks for pointing this out!

Just out of curiosity, if we only had nbcon consoles which disables 
acquiring console lock after panic as pointed out by John on [0], 
I guess in that case we will be able to call
console_flush_on_panic(CONSOLE_FLUSH_PENDING) in this context.

>We would need to implement something like:
>
>/**
> * console_try_flush - try to flush consoles when safe
> *
> * Context: Any, except for NMI.
> */
>void console_try_flush(void)
>{
>	if (is_printk_legacy_deferred())
>		return;
>
>	if (console_trylock())
>		console_unlock();
>}
>
>, where is_printk_legacy_deferred() is not yet in the mainline. It is a new
>API proposed by the last version of a patchset adding adding write_atomic() callback,
>see https://lore.kernel.org/all/20240804005138.3722656-24-john.ogness@linutronix.de/

Also thanks for potinting the direction.
I'll send the next version with console_try_flush() for flushing backtraces 
as suggested!

>Best Regards,
>Petr

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/lkml/875xsofl7i.fsf@jogness.linutronix.de/


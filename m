Return-Path: <linux-kernel+bounces-287823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637EE952D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1238B2C58D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3EA1AD9F5;
	Thu, 15 Aug 2024 10:44:01 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8BC19DF66
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718641; cv=none; b=FycxjRKZjCTnzZksdSao3wELy3qbcs0EXeFPnrLFE/iPdtzhEdLZxhpealRDry7iB5GbCFaJdr4aFl2jhctywIS1tm0EYthWyrG0RO7+AFNWmUYhWUbqaS3rrh6K1XOh0e0T9VMmMAdiFFbZVFZDnlsykFBh+jfXKjpKv2lxAEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718641; c=relaxed/simple;
	bh=+PQWBvrm0vURe961tjUIBTjkIbamaMT+/jsxIPI/PQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eIzR2kJNx9+ZqbDWLDyr4wIzz3gLnm9KDDTolvAux20DGVAfxqByDfFnNh3QWMweWDxDzVjyhTHrSUiNilJSnHBNwDiQED88YrTxfXQDU4+zFsKSE6p01dr+OdFldq03cwA7gf1/a6lFruv0ZB8tcPERraq9XH8gtnBCUjD2aoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 5B60EA9E69;
	Thu, 15 Aug 2024 19:43:57 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xyWO6AtnD4lg; Thu, 15 Aug 2024 19:43:57 +0900 (JST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp [210.128.90.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 321ADA9E65;
	Thu, 15 Aug 2024 19:43:57 +0900 (JST)
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
Subject: Re: [PATCH v3 2/2] Handle flushing of CPU backtraces during panic
Date: Thu, 15 Aug 2024 19:43:56 +0900
Message-Id: <20240815104356.49273-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZrtjXChY_0wnFXsS@pathway.suse.cz>
References: <ZrtjXChY_0wnFXsS@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Petr and John,

On Tue 2024-08-13 13:45, Petr Mladek wrote:
>On Mon 2024-08-12 16:29:31, takakura@valinux.co.jp wrote:
>> From: Ryo Takakura <takakura@valinux.co.jp>
>> 
>> After panic, non-panicked CPU's has been unable to flush ringbuffer
>> while they can still write into it. This can affect CPU backtrace
>> triggered in panic only able to write into ringbuffer incapable of
>> flushing them.
>
>I still think about this. The motivation is basically the same
>as in the commit 5d5e4522a7f404d1a96fd ("printk: restore flushing
>of NMI buffers on remote CPUs after NMI backtraces").
>
>It would make sense to replace printk_trigger_flush() with
>console_try_flush(). And the function should queue the irq
>work when it can't be flushed directly, see below.

Yes, I agree.

>> Fix the issue by letting the panicked CPU handle the flushing of
>> ringbuffer right after non-panicked CPUs finished writing their
>> backtraces.
>> 
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -260,6 +260,7 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
>>  		panic_triggering_all_cpu_backtrace = true;
>>  		trigger_all_cpu_backtrace();
>>  		panic_triggering_all_cpu_backtrace = false;
>> +		console_try_flush();
>>  	}
>> 
>>  	/*
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3284,6 +3284,20 @@ void console_flush_on_panic(enum con_flush_mode mode)
>>  	console_flush_all(false, &next_seq, &handover);
>>  }
>> 
>> +/**
>> + * console_try_flush - try to flush consoles when safe
>> + *
>> + * Context: Any, except for NMI.
>
>It is safe even in NMI. is_printk_legacy_deferred() would return true
>in this case.

I'm sorry... I didn't notice this. Thanks.

>> + */
>> +void console_try_flush(void)
>> +{
>> +	if (is_printk_legacy_deferred())
>> +		return;
>> +
>> +	if (console_trylock())
>> +		console_unlock();
>> +}
>
>I would do something like:
>
>/**
> * console_try_or_trigger_flush - try to flush consoles directly when
> *	safe or the trigger deferred flush.
> *
> * Context: Any
> */
>void console_try_or_trigger_flush(void)
>{
>	if (!is_printk_legacy_deferred() && console_trylock())
>		console_unlock();
>	else
>		defer_console_output();
>}
>
>and use it instead of printk_trigger_flush() in
>nmi_trigger_cpumask_backtrace().

Yes, that sounds better to me as well!

>Well, I would postpone this patch after we finalize the patchset
>adding con->write_atomic() callback. This patch depends on it anyway
>via is_printk_legacy_deferred(). The patchset might also add
>other wrappers for flushing consoles and we have to choose some
>reasonable names. Or John could integrate this patch into the patchset.

Sure, I can resend one once the patchset is finalized!
Or would it be better if I just leave it to John so that it can be part of 
the patchset?

>Best Regards,
>Petr

Sincerely,
Ryo Takakura


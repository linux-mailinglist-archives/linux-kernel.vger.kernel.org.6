Return-Path: <linux-kernel+bounces-309778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0EB967053
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105B61F227AB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E64016F27D;
	Sat, 31 Aug 2024 08:20:36 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618E214D28F
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725092435; cv=none; b=r1kADj5PR8sd6OGZk9Z0nc1aQ01XaZ8dydFBaMK8xM2wBoDx8cgaVa87WK26PxIdaPwIWJkpyKJSrQJtBLeizZpc5dKm04izI8sSXgkpM8L6tff15y3ufw3nmoCQYXJlULdrolmSE4LIaX48rqdsRRIrS/mu8+xeCr2HnimwXPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725092435; c=relaxed/simple;
	bh=aYJ2Ad1g1r74GBuJTnfHIfSiWD9aweorAUtS4ZhV6G4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=goPTV8dRNrBUw1yuloryqisSyZzZ2GYy5Rg+j7IybM8Vw8QBtvqm4wzVz1vhjOAr8FrandKifFkzI58VBXId2uOpVYB5Q+/dLcCn5C8SKSlKtfqaydlILhdKjU2NK6M2jXDY0DknzDMoykxWSDjiGzT4WptkTJwk7KMJqNZKFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id B7E35A9EF7;
	Sat, 31 Aug 2024 17:20:24 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KOmGXodl93bv; Sat, 31 Aug 2024 17:20:24 +0900 (JST)
Received: from localhost.localdomain (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp [153.220.101.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 69103A9EEB;
	Sat, 31 Aug 2024 17:20:24 +0900 (JST)
From: takakura@valinux.co.jp
To: john.ogness@linutronix.de
Cc: pmladek@suse.com,
	akpm@linux-foundation.org,
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
Date: Sat, 31 Aug 2024 17:20:04 +0900
Message-Id: <20240831082004.110975-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <877cc38exx.fsf@jogness.linutronix.de>
References: <877cc38exx.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi John,

Thanks for checking into what I pointed out!

On 2024-08-26, John Ogness wrote:
>On 2024-08-21, takakura@valinux.co.jp wrote:
>>>> /**
>>>>  * console_try_or_trigger_flush - try to flush consoles directly when
>>>>  *   safe or the trigger deferred flush.
>>>>  *
>>>>  * Context: Any
>>>>  */
>>>> void console_try_or_trigger_flush(void)
>>>> {
>>>>      if (!is_printk_legacy_deferred() && console_trylock())
>>>>              console_unlock();
>>>>      else
>>>>              defer_console_output();
>>>> }
>>>>
>>>> and use it instead of printk_trigger_flush() in
>>>> nmi_trigger_cpumask_backtrace().
>>>
>>> Just to be clear, you are talking about removing
>>> printk_trigger_flush() entirely and instead provide the new
>>> console_try_or_trigger_flush()?  Which then also involves updating
>>> the call sites:
>>>
>>> lib/nmi_backtrace.c:nmi_trigger_cpumask_backtrace()
>>> arch/powerpc/kernel/watchdog.c:watchdog_timer_interrupt()
>>>
>>
>> Taking a look at [0], in addition to the mentioned call sites, 
>> nbcon_device_release() will also be calling printk_trigger_flush()?
>> For nbcon_device_release(), I thought its better not to be replaced as 
>> it calles for @legacy_off, in which case printk_trigger_flush() seems 
>> more suitable as it always defers printing.
>
>The @legacy_off logic would be within console_try_or_trigger_flush(),
>so the result would be the same.

I see.

>> Also taking a look at the [1], for nmi_trigger_cpumask_backtrace(), 
>> I thought that it will not comply with the syncing of 
>> legacy_allow_panic_sync. I believe it will allow flushing of legacy consoles 
>> before printk_legacy_allow_panic_sync() which is out of sync.
>
>But isn't your patch also causing that violation?

Yes, the patch I sent would be causing the violation...
Sorry I should have asked this earlier before sending patch. The question came up
after sending the patch.

>printk_legacy_allow_panic_sync() performs a trylock/unlock. Isn't that
>good enough?

Also sorry for being unclear here. I also think that 
printk_legacy_allow_panic_sync()'s trylock/unlock is good enough.
My question was that if we were to call console_try_or_trigger_flush() in
panic, wouldn't we need to check @legacy_direct to avoid flushing 
of legacy consoles.

Something like:
/**
 * console_try_or_trigger_flush - try to flush consoles directly when
 *	safe or the trigger deferred flush.
 *
 * Context: Any
 */
void console_try_or_trigger_flush(void)
{
        struct console_flush_type ft;
        printk_get_console_flush_type(&ft);
        if (ft.legacy_direct) {
                if (console_trylock())
                        console_unlock();
        } else {
                defer_console_output();
        }
}

>John

Sincerely,
Ryo Takakura


Return-Path: <linux-kernel+bounces-294882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 366409593D0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DD61F23301
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CBD1547C2;
	Wed, 21 Aug 2024 05:03:00 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E823D8E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724216579; cv=none; b=Bsr6H6K/cw/irqje5GrjIz+32RQFtd9Uk4RzPSOhsYM7Gj2BbsH+Q5ikIM1C5aA/HHx/rNuAVYt7Y+cauvAHdVlunKHQcrLm38g9iZ2axu9xNw/C7JrOUmdDXiqL0EfJbG8XTVc9Ub9XEJS5HlpfOWewXHbj+FaRy6taH/VAkUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724216579; c=relaxed/simple;
	bh=MMMv5fn7e9/vn0AAAGI0YipjnkStoftksdOYVPzOmlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l+iBw4um7R0KI1KEXYTBX7JonHq+Kq+XQN4zK/aiZ1q2X7unJad9vgIqPUEMUGnYbPV5RvtMuVBcuAUkEwiGhiEh4amNh2FqKwS3BWBVTfS2yN9ID1QbV1h+Y5RC3+mCBrY+308ba1HifR9Yr/RaZaNyC8vlihaEX+xP3Awn2bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 67E24A9EAB;
	Wed, 21 Aug 2024 14:02:55 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nSvaXdf4W4wl; Wed, 21 Aug 2024 14:02:55 +0900 (JST)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp [210.128.90.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 3FC8FA8F07;
	Wed, 21 Aug 2024 14:02:55 +0900 (JST)
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
Date: Wed, 21 Aug 2024 14:02:54 +0900
Message-Id: <20240821050254.69853-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87y14sjp0d.fsf@jogness.linutronix.de>
References: <87y14sjp0d.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Petr and John,

On 2024-08-19, John Ogness wrote:
>On 2024-08-13, Petr Mladek <pmladek@suse.com> wrote:
>> I would do something like:
>>
>> /**
>>  * console_try_or_trigger_flush - try to flush consoles directly when
>>  *   safe or the trigger deferred flush.
>>  *
>>  * Context: Any
>>  */
>> void console_try_or_trigger_flush(void)
>> {
>>      if (!is_printk_legacy_deferred() && console_trylock())
>>              console_unlock();
>>      else
>>              defer_console_output();
>> }
>>
>> and use it instead of printk_trigger_flush() in
>> nmi_trigger_cpumask_backtrace().
>
>Just to be clear, you are talking about removing printk_trigger_flush()
>entirely and instead provide the new console_try_or_trigger_flush()?
>Which then also involves updating the call sites:
>
>lib/nmi_backtrace.c:nmi_trigger_cpumask_backtrace()
>arch/powerpc/kernel/watchdog.c:watchdog_timer_interrupt()
>

Taking a look at [0], in addition to the mentioned call sites, 
nbcon_device_release() will also be calling printk_trigger_flush()?
For nbcon_device_release(), I thought its better not to be replaced as 
it calles for @legacy_off, in which case printk_trigger_flush() seems 
more suitable as it always defers printing.

Also taking a look at the [1], for nmi_trigger_cpumask_backtrace(), 
I thought that it will not comply with the syncing of 
legacy_allow_panic_sync. I believe it will allow flushing of legacy consoles 
before printk_legacy_allow_panic_sync() which is out of sync.

>> Well, I would postpone this patch after we finalize the patchset
>> adding con->write_atomic() callback. This patch depends on it anyway
>> via is_printk_legacy_deferred(). The patchset might also add
>> other wrappers for flushing consoles and we have to choose some
>> reasonable names.
>
>I agree. Let's finish up the atomic series and then we can worry about
>this.
>

Ok! I see that it can be better discussed after the atomic series.

>John

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/all/20240820063001.36405-31-john.ogness@linutronix.de/
[1] https://lore.kernel.org/all/20240820063001.36405-30-john.ogness@linutronix.de/


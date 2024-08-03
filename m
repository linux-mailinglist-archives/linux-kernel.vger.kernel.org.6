Return-Path: <linux-kernel+bounces-273378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0C7946894
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 09:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395361F21A84
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 07:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D68514D432;
	Sat,  3 Aug 2024 07:51:54 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA049647
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722671514; cv=none; b=CiptNsNIhtWFjXb7P8G+LtEa3mmzUc/oWhTpIcp807CclCPa6lvFdxLqfyDzFrekn7UqgGqeuOBohO6UoBsvo0Spi/DkMIbtRuaZkE39fgrb6Sm5maI2epdskVOBAP+Kbs9JAsIGu8RBpAmejnQnIIjwt0Fz3d+ih8bNNU0kC/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722671514; c=relaxed/simple;
	bh=DjiN586Eo8jHzSmFOKGcwvE8tf1KpRIoPN/TudQfKms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sudsP9t+1wbK5ql/4QuRkJY1MVarfX0JpTaKeYugIUOPDDa4dOqstuaUCAWayDby0r7cvmlLlVRpnKSOoODpsNsqAxQ9v01x3PRInBDPPkNljEgCjlnXY5I+UUgEvZDFvlPrLi37VgT5CjMrMM500I/z81fO4z/FgpGg+6pwMR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 29F31A9DD3;
	Sat,  3 Aug 2024 16:51:49 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2MkEHVyS57pd; Sat,  3 Aug 2024 16:51:49 +0900 (JST)
Received: from localhost.localdomain (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp [153.220.101.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 4412BA9DCF;
	Sat,  3 Aug 2024 16:51:48 +0900 (JST)
From: takakura@valinux.co.jp
To: pmladek@suse.com
Cc: john.ogness@linutronix.de,
	rostedt@goodmis.org,
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
Date: Sat,  3 Aug 2024 16:51:27 +0900
Message-Id: <20240803075127.217428-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZqttsMNERRCZw8FR@pathway.suse.cz>
References: <ZqttsMNERRCZw8FR@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Petr,

On 2024-08-01, Petr Mladek <pmladek@suse.com> wrote:
>On Thu 2024-08-01 17:27:21, takakura@valinux.co.jp wrote:
>> Hi Petr and John,
>>
>> On 2024-07-30, Petr Mladek <pmladek@suse.com> wrote:
>> >On Fri 2024-07-26 16:02:45, John Ogness wrote:
>> >> On 2024-07-26, Petr Mladek <pmladek@suse.com> wrote:
>> >> > I would do it the other way and enable printing from other CPUs only
>> >> > when triggring the backtrace. We could do it because
>> >> > trigger_all_cpu_backtrace() waits until all backtraces are
>> >> > printed.
>> >> >
>> >> > Something like:
>> >> >
>> >> > diff --git a/include/linux/panic.h b/include/linux/panic.h
>> >> > index 3130e0b5116b..980bacbdfcfc 100644
>> >> > --- a/include/linux/panic.h
>> >> > +++ b/include/linux/panic.h
>> >> > @@ -16,6 +16,7 @@ extern void oops_enter(void);
>> >> >  extern void oops_exit(void);
>> >> >  extern bool oops_may_print(void);
>> >> >
>> >> > +extern int panic_triggering_all_cpu_backtrace;
>> >> >  extern int panic_timeout;
>> >> >  extern unsigned long panic_print;
>> >> >  extern int panic_on_oops;
>> >> > diff --git a/kernel/panic.c b/kernel/panic.c
>> >> > index f861bedc1925..7e9e97d59b1e 100644
>> >> > --- a/kernel/panic.c
>> >> > +++ b/kernel/panic.c
>> >> > @@ -64,6 +64,8 @@ unsigned long panic_on_taint;
>> >> >  bool panic_on_taint_nousertaint = false;
>> >> >  static unsigned int warn_limit __read_mostly;
>> >> >
>> >> > +int panic_triggering_all_cpu_backtrace;
>> >> > +
>> >> >  int panic_timeout = CONFIG_PANIC_TIMEOUT;
>> >> >  EXPORT_SYMBOL_GPL(panic_timeout);
>> >> >
>> >> > @@ -253,8 +255,12 @@ void check_panic_on_warn(const char *origin)
>> >> >   */
>> >> >  static void panic_other_cpus_shutdown(bool crash_kexec)
>> >> >  {
>> >> > -       if (panic_print & PANIC_PRINT_ALL_CPU_BT)
>> >> > +       if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
>> >> > +               /* Temporary allow printing messages on non-panic CPUs. */
>> >> > +               panic_triggering_all_cpu_backtrace = true;
>> >> >                 trigger_all_cpu_backtrace();
>> >> > +               panic_triggering_all_cpu_backtrace = false;
>> >>
>> >> Note, here we should also add
>> >>
>> >>           nbcon_atomic_flush_pending();
>> >>
>> >> Your suggestion allows the other CPUs to dump their backtrace into the
>> >> ringbuffer, but they are still forbidden from acquiring the nbcon
>> >> console contexts for printing. That is a necessary requirement of
>> >> nbcon_waiter_matches().
>> >
>> >Great catch!
>> >
>> >I would prefer to solve this in a separate patch. This problem existed
>> >even before the commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing
>> >to ringbuffer"). In fact, the problem existed very long time even for
>> >the legacy consoles.
>> >
>>
>> Good point! I guess the problem existed since the commit 51a1d258e50e
>> ("printk: Keep non-panic-CPUs out of console lock") as it forbade the
>> acquisition of console lock for non-panic cpus?
>
>It most likely existed since the commit 7acac3445acde1c94
>("printk: always use deferred printk when flush printk_safe lines")
>
>These were times when printk() serialized access to the log buffer
>using a spin lock. The backtraces from other CPUs were stored in
>temporary per-CPU buffers and later copied to the main log buffer.
>The above mentioned commit caused that printk_safe_flush_line()
>did not longer try to flush the messages to the console after
>copying the temporary stored messages.
>
>Well, the above commit was in Jan 2017. It was before panic
>allowed to show the backtraces.
>
>In practice, the problem with flushing bracktraces in panic has
>existed since the option to print the backtraces was added by
>the commit 60c958d8df9cfc40b ("panic: add sysctl to dump
>all CPUs backtraces on oops event") in Jun 2020.
>
>Best Regards,
>Petr

That is quite interesting how flushing of backtraces in panic 
has been affected differently over time until now, even going back 
to days before CPU backtrace was introduced in panic.

Thanks for sharing this!

Sincerely,
Ryo Takakura


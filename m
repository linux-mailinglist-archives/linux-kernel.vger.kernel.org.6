Return-Path: <linux-kernel+bounces-263126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7160E93D158
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D06DB217B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C53176FCF;
	Fri, 26 Jul 2024 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RHA6wNp7"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB78C13D8B3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721990823; cv=none; b=hwzmllap4wAkkXdjCXGVok7WnY3hRYIH6yk4w9wSkvbXGlqreElWWKNxkcrjNrVpITb1w73r2B0TBQL2me/wA5pED+97aM582/O4FegvaxuHCVqing3LfwQm7T7vbZ4r13X1AgoDXg/wqNQEJLMW/bHSGpyGA3ID9wyn+zrLxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721990823; c=relaxed/simple;
	bh=F9+C5tng75AM0mm4yQXJOuCuKMLOgYhdMIf39C7qJ1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvhitEnmhYYzkW2qkuSkqnJI7fewVu/3bEH4j3EFD+8ndmko+//01/RTuWL9H1UAKLJ7PU1/DZN61Iqo0awg2I6RlhxgDiv6IWmG4MRC6NSDzuVJg9W8DHW4wMG7OTNK4riDESc94JpK+Lw56gtz3ANPupqnyRi3GOUqIE9ZgIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RHA6wNp7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so222899466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 03:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721990819; x=1722595619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=54a+yLeH+fk9Ru7raDHCV5+hfbTusx7m6TQ/Lw4ZCuw=;
        b=RHA6wNp7DbkCdHHImwXnkyEPd4zYm9vHA1Q/j110vot0bjuaPq9jaSwDyKThf7gROi
         hNi9WPPCDY6zdWsq3GEwHqXfthskJbB5HZw05FzUGJFHC5ziW0x145CPGXqOK2O08OKq
         +9oC9OYciN76zZoS9Fk0FVR6SDf9JslIO1qY5Xhq5c+AzlVVLjq2tJcEznlRBV/2QneM
         EmIB8X6idPSpzwrgzgmkWfhTllit+XURkvc4vsp80XuuMl0oX3iXG1sFjYBRjwosmJpv
         lmPAFef3U5cvOvM4IuwDiKrV/vNDCAR7pHsxmdQBs4dJ2YjxiF7ku5MJ2PyPZgtfEIqY
         YJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721990819; x=1722595619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54a+yLeH+fk9Ru7raDHCV5+hfbTusx7m6TQ/Lw4ZCuw=;
        b=MomhfzaigmjYUXbm4WrceNudtzg9WdAQOaQ0p7zT+LuJuqBaSes6vimt34fxqPsyh5
         RjWtOBFmdJGmvJd5wY1I4/mMwb4yvcsprrf51Fvshxhopf8qBUnJLJbvN8Q3cf11LNmt
         vlAujIaqqXiaTdbAqnvabx1+lnBhOSGQwPecqH1RfR6hGvMCk/FvAg6b23YtOeckvWrt
         ufkt8nJoB3enmFZYm1KMj7aO8qo+mJojFJSeD2zy0uYO2ZeEvyDC75LX7Zr275qPW9cV
         xz6g9J/1Uo4QNCmDISRAcWvnoUcf5Z9MpKEu3C9OMRyR/nMy06OjV2gIhRYG1+c2PXU1
         4aiA==
X-Forwarded-Encrypted: i=1; AJvYcCUVSrOgFOuTjgGWiN9LGu8+ZUvBrLZD1sh2mJx4TxxtJbZRA4Gc1p03dVKZdexy+16MgA9Bs4HVx4QmCaPVXsyMzRG60qaRKgsp+iLU
X-Gm-Message-State: AOJu0Yz+E4Bg71KHxq/hfn1kruvciHehcg+KtxHfg9Es8SpVcfyfEEoG
	MEhabVCcJz4uFNZ2MbEMpjqNhIv+x8//FbfomeO4mY9nVy6Uor08V0vHX4v41OI=
X-Google-Smtp-Source: AGHT+IGJag/PKuLabeabCV+KmICbtNcJI6TcC4IxfaqC4ey2gN7y/UEWyo3D+3X0BiH6mBJyfLupMw==
X-Received: by 2002:a17:907:9443:b0:a7a:8bcf:ac64 with SMTP id a640c23a62f3a-a7acb4a0043mr371806666b.36.1721990818836;
        Fri, 26 Jul 2024 03:46:58 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad92fd8sm159969766b.159.2024.07.26.03.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 03:46:58 -0700 (PDT)
Date: Fri, 26 Jul 2024 12:46:56 +0200
From: Petr Mladek <pmladek@suse.com>
To: takakura@valinux.co.jp
Cc: rostedt@goodmis.org, john.ogness@linutronix.de,
	senozhatsky@chromium.org, akpm@linux-foundation.org, bhe@redhat.com,
	lukas@wunner.de, wangkefeng.wang@huawei.com, ubizjak@gmail.com,
	feng.tang@intel.com, j.granados@samsung.com,
	stephen.s.brennan@oracle.com, linux-kernel@vger.kernel.org,
	nishimura@valinux.co.jp, taka@valinux.co.jp
Subject: Re: [PATCH] printk: CPU backtrace not printing on panic
Message-ID: <ZqN-oBH5FWJqspMO@pathway.suse.cz>
References: <20240726094437.306330-1-takakura@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726094437.306330-1-takakura@valinux.co.jp>

On Fri 2024-07-26 18:44:37, takakura@valinux.co.jp wrote:
> From: Ryo Takakura <takakura@valinux.co.jp>
> 
> commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing
> to ringbuffer") disabled non-panic CPUs to further write messages to
> ringbuffer after panicked.
> 
> Since the commit, non-panicked CPU's are not allowed to write to
> ring buffer after panicked and CPU backtrace which is triggered
> after panicked to sample non-panicked CPUs' backtrace no longer
> serves its function as it can't print anything.

Great catch!

> Fix the issue by allowing non-panicked CPUs to write to ringbuffer
> when CPU backtrace was enabled if there is no need for message
> suppression. This patch brings back commit 13fb0f74d702 ("printk:
> Avoid livelock with heavy printk during panic")'s implementation
> for suppressing non-panicked CPUs' messages when detected messages
> being dropped.
> 
> Fixes: 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing to ringbuffer")
> Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
> ---
> 
> I was not really sure what the best approach would be if we want to
> allow cpu backtrace to function while prioritizing the panicked CPU's 
> messages. Hoping to get some feedbacks, thanks!
> 
> Sincerely,
> Ryo Takakura
> 
> ---
>  include/linux/panic.h  |  9 +++++++++
>  include/linux/printk.h |  1 +
>  kernel/panic.c         | 10 +---------
>  kernel/printk/printk.c | 26 ++++++++++++++++++++++++--
>  4 files changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index 6717b15e798c..70dc17284785 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -16,6 +16,15 @@ extern void oops_enter(void);
>  extern void oops_exit(void);
>  extern bool oops_may_print(void);
>  
> +#define PANIC_PRINT_TASK_INFO		0x00000001
> +#define PANIC_PRINT_MEM_INFO		0x00000002
> +#define PANIC_PRINT_TIMER_INFO		0x00000004
> +#define PANIC_PRINT_LOCK_INFO		0x00000008
> +#define PANIC_PRINT_FTRACE_INFO		0x00000010
> +#define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
> +#define PANIC_PRINT_ALL_CPU_BT		0x00000040
> +#define PANIC_PRINT_BLOCKED_TASKS	0x00000080
> +
>  extern int panic_timeout;
>  extern unsigned long panic_print;
>  extern int panic_on_oops;
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 40afab23881a..cbb4c1ec1fca 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -78,6 +78,7 @@ extern char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE];
>  struct ctl_table;
>  
>  extern int suppress_printk;
> +extern int suppress_panic_printk;
>  
>  struct va_format {
>  	const char *fmt;
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 8bff183d6180..8c23cd1f876e 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -66,14 +66,6 @@ static unsigned int warn_limit __read_mostly;
>  int panic_timeout = CONFIG_PANIC_TIMEOUT;
>  EXPORT_SYMBOL_GPL(panic_timeout);
>  
> -#define PANIC_PRINT_TASK_INFO		0x00000001
> -#define PANIC_PRINT_MEM_INFO		0x00000002
> -#define PANIC_PRINT_TIMER_INFO		0x00000004
> -#define PANIC_PRINT_LOCK_INFO		0x00000008
> -#define PANIC_PRINT_FTRACE_INFO		0x00000010
> -#define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
> -#define PANIC_PRINT_ALL_CPU_BT		0x00000040
> -#define PANIC_PRINT_BLOCKED_TASKS	0x00000080
>  unsigned long panic_print;
>  
>  ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
> @@ -252,7 +244,7 @@ void check_panic_on_warn(const char *origin)
>   */
>  static void panic_other_cpus_shutdown(bool crash_kexec)
>  {
> -	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
> +	if (panic_print & PANIC_PRINT_ALL_CPU_BT && !suppress_panic_printk)
>  		trigger_all_cpu_backtrace();
>  
>  	/*
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 420fd310129d..0ac2ca1abbbf 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -459,6 +459,13 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
>  static DEFINE_MUTEX(syslog_lock);
>  
>  #ifdef CONFIG_PRINTK
> +
> +/*
> + * During panic, heavy printk by other CPUs can delay the
> + * panic and risk deadlock on console resources.
> + */
> +int __read_mostly suppress_panic_printk;
> +
>  DECLARE_WAIT_QUEUE_HEAD(log_wait);
>  /* All 3 protected by @syslog_lock. */
>  /* the next printk record to read by syslog(READ) or /proc/kmsg */
> @@ -2311,9 +2318,11 @@ asmlinkage int vprintk_emit(int facility, int level,
>  	/*
>  	 * The messages on the panic CPU are the most important. If
>  	 * non-panic CPUs are generating any messages, they will be
> -	 * silently dropped.
> +	 * silently dropped unless CPU backtrace on panic is enabled.
>  	 */
> -	if (other_cpu_in_panic())
> +	if (other_cpu_in_panic() &&
> +	   (!(panic_print & PANIC_PRINT_ALL_CPU_BT) ||

I would do it the other way and enable printing from other CPUs only
when triggring the backtrace. We could do it because
trigger_all_cpu_backtrace() waits until all backtraces are
printed.

Something like:

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 3130e0b5116b..980bacbdfcfc 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -16,6 +16,7 @@ extern void oops_enter(void);
 extern void oops_exit(void);
 extern bool oops_may_print(void);
 
+extern int panic_triggering_all_cpu_backtrace;
 extern int panic_timeout;
 extern unsigned long panic_print;
 extern int panic_on_oops;
diff --git a/kernel/panic.c b/kernel/panic.c
index f861bedc1925..7e9e97d59b1e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -64,6 +64,8 @@ unsigned long panic_on_taint;
 bool panic_on_taint_nousertaint = false;
 static unsigned int warn_limit __read_mostly;
 
+int panic_triggering_all_cpu_backtrace;
+
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
 
@@ -253,8 +255,12 @@ void check_panic_on_warn(const char *origin)
  */
 static void panic_other_cpus_shutdown(bool crash_kexec)
 {
-	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
+	if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
+		/* Temporary allow printing messages on non-panic CPUs. */
+		panic_triggering_all_cpu_backtrace = true;
 		trigger_all_cpu_backtrace();
+		panic_triggering_all_cpu_backtrace = false;
+	}
 
 	/*
 	 * Note that smp_send_stop() is the usual SMP shutdown function,
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 054c0e7784fd..c22b07049c38 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2316,7 +2316,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	 * non-panic CPUs are generating any messages, they will be
 	 * silently dropped.
 	 */
-	if (other_cpu_in_panic())
+	if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
 		return 0;
 
 	if (level == LOGLEVEL_SCHED) {


> +	    unlikely(suppress_panic_printk)))
>  		return 0;
>  
>  	if (level == LOGLEVEL_SCHED) {
> @@ -2816,6 +2825,8 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
>  bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>  			     bool is_extended, bool may_suppress)
>  {
> +	static int panic_console_dropped;
> +
>  	struct printk_buffers *pbufs = pmsg->pbufs;
>  	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
>  	const size_t outbuf_sz = sizeof(pbufs->outbuf);
> @@ -2843,6 +2854,17 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>  	pmsg->seq = r.info->seq;
>  	pmsg->dropped = r.info->seq - seq;
>  
> +	/*
> +	 * Check for dropped messages in panic here so that printk
> +	 * suppression can occur as early as possible if necessary.
> +	 */
> +	if (pmsg->dropped &&
> +	    panic_in_progress() &&
> +	    panic_console_dropped++ > 10) {
> +		suppress_panic_printk = 1;
> +		pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
> +	}

I would keep it simple and omit this change. The risk of mess is lower
if we enable other CPUs only around printing the backtraces.
We could always add it back when we see problems in practice.

> +
>  	/* Skip record that has level above the console loglevel. */
>  	if (may_suppress && suppress_message_printing(r.info->level))
>  		goto out;

Best Regards,
Petr


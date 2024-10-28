Return-Path: <linux-kernel+bounces-385420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769659B36FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074FA1F23EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F461DF245;
	Mon, 28 Oct 2024 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="ZuopdBb+"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1F41DF254
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133943; cv=none; b=LExPvxcg6BS5pc3rt3AjTg4ckeAXdFvucAIvOq20TpSbrSY3afW0OEmsPb7nq284skcm8sNh1/5Q7uS7XPUJ96iMRQLm8DedFp1xyOMAtOWLtB5p1T4c+iAwHnMAs4CmUFw1RnOf0dJIHjcmCfG9R0APZXg7LIp0SSEis204NYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133943; c=relaxed/simple;
	bh=Q/o3IZHmOxdC4QaYJGFQcZogoqnTFgr1GsZTlq7L+XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOLL7zQrHdrifyLyiJb1SiEHLRKLuKlpIsSJ/Q4t1MdIdN81K1aooBfZYHE0ET4r0mbfHSss7fuDGD3JuYe7Hc+4LsXjSK1wsMfkWY0u177tzCQNvPLN3QWw+ez3XK9NRheOUDS4iyd+dhDoOgNCrxKewQV1IDCaCZ0aZ035vHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=ZuopdBb+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso3035005f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1730133939; x=1730738739; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRMZS8Ub8dGxMt1dDX1udMSaq6DesVwPyxLbKJJRJUY=;
        b=ZuopdBb+1wxNi/4pebaoHl9JEFumFHXkojOgkK2gztgyCwYVQxfVg1apxOVUJOU6FL
         +KFwrJRM1WlXYGaVj6th3UsjFBX7RViYT1N1A9Qhpevbra1smNB7JhA5bDFEZ4XSHZGJ
         A1HQQih+XrPIk415TXeTBLE3ZEMdV05yh0LvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133939; x=1730738739;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRMZS8Ub8dGxMt1dDX1udMSaq6DesVwPyxLbKJJRJUY=;
        b=Q3q7TspL1SZm66Zan+AtiZVUs/6tsVEYdZjHoNgbBvSeqhqgF9N6sqfxnnUD12V//F
         PMoQNmuFkxU0olmCWI0iSrqmDoj+U41EcaeR3Auk9unlvaLo/OC670o8rXeIfbUU0bW4
         c+A1ExLRlf8F8AwvnXHq5s8qBkro+Krap8Kl5ibiYbzYzichlimAD6c3GsRwDgzzjTTS
         gB7PgnyMklIBBx2yDbJm61bKE1Rw/BdDOCJBa2gn0zsvxn2RqHjRHkJhTG7K9ji0+BN9
         PIrl1tKOmIgnk5uEL21xrvYcehO/384q/aDRvjoptC1SA4gQY23Wr2LXrAd3S7jj4qRk
         GHDQ==
X-Gm-Message-State: AOJu0YwjZkn4quoQ5vmTDULK0h3w21gCkOyZ+TwUIMpVJjhdXi6RcJDd
	5w5T6qhnDFd615G57SrvFkd5BSu7UaLPd7wscAdb9rDNoBwMuh7LOFRE8Cx3ImgE2AcrQ3vWaUQ
	i
X-Google-Smtp-Source: AGHT+IGrw1DCQhkyoQGgHJjdT72SOzHagxuMM6asNX8kvnHqUuEpwMT5tyu80InC9imCj+opFAUwNQ==
X-Received: by 2002:adf:e28a:0:b0:37d:47b7:f2f5 with SMTP id ffacd0b85a97d-380610f308amr6406254f8f.4.1730133938856;
        Mon, 28 Oct 2024 09:45:38 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b712d6sm9988535f8f.78.2024.10.28.09.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:45:38 -0700 (PDT)
Date: Mon, 28 Oct 2024 16:45:37 +0000
From: Chris Down <chris@chrisdown.name>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: [PATCH v6 03/11] printk: console: Implement core per-console
 loglevel infrastructure
Message-ID: <28d8dff56bc15b2a41f0d2035701ccb11df22610.1730133890.git.chris@chrisdown.name>
References: <cover.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730133890.git.chris@chrisdown.name>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

Consoles can have vastly different latencies and throughputs. For
example, writing a message to the serial console can take on the order
of tens of milliseconds to get the UART to successfully write a message.
While this might be fine for a single, one-off message, this can cause
significant application-level stalls in situations where the kernel
writes large amounts of information to the console.

This means that while you might want to send at least INFO level
messages to (for example) netconsole, which is relatively fast, you may
only want to send at least WARN level messages to the serial console.
Such an implementation would permit debugging using the serial console
in cases that netconsole doesn't receive messages during particularly
bad system issues, while still keeping the noise low enough to avoid
inducing latency in userspace applications. To mitigate this, add such
an interface, extending the existing console loglevel controls to allow
each console to have its own loglevel.

One can't just disable the serial console, because one may actually need
it in situations where the machine is in a bad enough state that nothing
is received on netconsole. One also can't just bump the loglevel at
runtime after the issue, because usually the machine is already so
wedged by this point that it isn't responsive to such requests.

The sysfs and kernel command line interfaces to set the per-console
loglevel will be added later. For now, simply add the necessary internal
infrastructure to be used by later patches.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 drivers/tty/sysrq.c      | 15 ++++++++
 include/linux/console.h  |  2 ++
 include/linux/printk.h   |  5 +++
 kernel/printk/internal.h | 10 ++++++
 kernel/printk/printk.c   | 78 +++++++++++++++++++++++++++++++++++++---
 5 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 930b04e3d148..daa9fe7dad54 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -51,6 +51,7 @@
 #include <linux/syscalls.h>
 #include <linux/of.h>
 #include <linux/rcupdate.h>
+#include <linux/console.h>
 
 #include <asm/ptrace.h>
 #include <asm/irq_regs.h>
@@ -101,11 +102,25 @@ __setup("sysrq_always_enabled", sysrq_always_enabled_setup);
 static void sysrq_handle_loglevel(u8 key)
 {
 	u8 loglevel = key - '0';
+	int cookie;
+	int warned = 0;
+	struct console *con;
 
 	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
 	pr_info("Loglevel set to %u\n", loglevel);
 	console_loglevel = loglevel;
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
+		if (!warned && per_console_loglevel_is_set(con)) {
+			warned = 1;
+			pr_warn("Overriding per-console loglevel from sysrq\n");
+		}
+		WRITE_ONCE(con->level, -1);
+	}
+	console_srcu_read_unlock(cookie);
 }
+
 static const struct sysrq_key_op sysrq_loglevel_op = {
 	.handler	= sysrq_handle_loglevel,
 	.help_msg	= "loglevel(0-9)",
diff --git a/include/linux/console.h b/include/linux/console.h
index eba367bf605d..3ff22bfeef2a 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -321,6 +321,7 @@ struct nbcon_write_context {
  * @dropped:		Number of unreported dropped ringbuffer records
  * @data:		Driver private data
  * @node:		hlist node for the console list
+ * @level:		Console-specific loglevel
  *
  * @nbcon_state:	State for nbcon consoles
  * @nbcon_seq:		Sequence number of the next record for nbcon to print
@@ -349,6 +350,7 @@ struct console {
 	unsigned long		dropped;
 	void			*data;
 	struct hlist_node	node;
+	int			level;
 
 	/* nbcon console specific members */
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index eca9bb2ee637..5fbd6b7f1ab4 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -204,6 +204,7 @@ void printk_legacy_allow_panic_sync(void);
 extern bool nbcon_device_try_acquire(struct console *con);
 extern void nbcon_device_release(struct console *con);
 void nbcon_atomic_flush_unsafe(void);
+bool per_console_loglevel_is_set(const struct console *con);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -303,6 +304,10 @@ static inline void nbcon_device_release(struct console *con)
 static inline void nbcon_atomic_flush_unsafe(void)
 {
 }
+static inline bool per_console_loglevel_is_set(const struct console *con)
+{
+	return false;
+}
 
 #endif
 
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 58ad209e0310..9303839d0551 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -15,6 +15,16 @@ int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
 #define printk_sysctl_init() do { } while (0)
 #endif
 
+enum loglevel_source {
+	LLS_GLOBAL,
+	LLS_LOCAL,
+	LLS_IGNORE_LOGLEVEL,
+};
+
+enum loglevel_source
+console_effective_loglevel_source(const struct console *con);
+int console_effective_loglevel(const struct console *con);
+
 #define con_printk(lvl, con, fmt, ...)				\
 	printk(lvl pr_fmt("%s%sconsole [%s%d] " fmt),		\
 		(con->flags & CON_NBCON) ? "" : "legacy ",	\
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index dfe7011b863a..2e99b63efb46 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1287,9 +1287,62 @@ module_param(ignore_loglevel, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(ignore_loglevel,
 		 "ignore loglevel setting (prints all kernel messages to the console)");
 
-static bool suppress_message_printing(int level)
+bool per_console_loglevel_is_set(const struct console *con)
 {
-	return (level >= console_loglevel && !ignore_loglevel);
+	return con && (READ_ONCE(con->level) > 0);
+}
+
+/*
+ * Hierarchy of loglevel authority:
+ *
+ * 1. con->level. The locally set, console-specific loglevel. Optional, only
+ *    valid if >0.
+ * 2. console_loglevel. The default global console loglevel, always present.
+ */
+enum loglevel_source
+console_effective_loglevel_source(const struct console *con)
+{
+	if (WARN_ON_ONCE(!con))
+		return LLS_GLOBAL;
+
+	if (ignore_loglevel)
+		return LLS_IGNORE_LOGLEVEL;
+
+	if (per_console_loglevel_is_set(con))
+		return LLS_LOCAL;
+
+	return LLS_GLOBAL;
+}
+
+int console_effective_loglevel(const struct console *con)
+{
+	enum loglevel_source source;
+	int level;
+
+	source = console_effective_loglevel_source(con);
+
+	switch (source) {
+	case LLS_IGNORE_LOGLEVEL:
+		level = CONSOLE_LOGLEVEL_MOTORMOUTH;
+		break;
+	case LLS_LOCAL:
+		level = READ_ONCE(con->level);
+		break;
+	case LLS_GLOBAL:
+		level = console_loglevel;
+		break;
+	default:
+		pr_warn("Unhandled console loglevel source: %d", source);
+		level = console_loglevel;
+		break;
+	}
+
+	return level;
+}
+
+static bool suppress_message_printing(int level, struct console *con)
+{
+	return level >= console_effective_loglevel(con);
 }
 
 #ifdef CONFIG_BOOT_PRINTK_DELAY
@@ -2122,7 +2175,21 @@ int printk_delay_msec __read_mostly;
 
 static inline void printk_delay(int level)
 {
-	if (suppress_message_printing(level))
+	bool will_emit = false;
+	int cookie;
+	struct console *con;
+
+	cookie = console_srcu_read_lock();
+
+	for_each_console_srcu(con) {
+		if (!suppress_message_printing(level, con)) {
+			will_emit = true;
+			break;
+		}
+	}
+	console_srcu_read_unlock(cookie);
+
+	if (!will_emit)
 		return;
 
 	boot_delay_msec();
@@ -2975,7 +3042,7 @@ bool printk_get_next_message(struct printk_message *pmsg, struct console *con,
 	pmsg->dropped = r.info->seq - seq;
 
 	/* Never suppress when used in devkmsg_read() */
-	if (con && suppress_message_printing(r.info->level))
+	if (con && suppress_message_printing(r.info->level, con))
 		goto out;
 
 	if (is_extended) {
@@ -3789,6 +3856,9 @@ static int try_enable_preferred_console(struct console *newcon,
 			if (newcon->index < 0)
 				newcon->index = c->index;
 
+			// TODO: Will be configurable in a later patch
+			newcon->level = -1;
+
 			if (_braille_register_console(newcon, c))
 				return 0;
 
-- 
2.46.0



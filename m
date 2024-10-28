Return-Path: <linux-kernel+bounces-385421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA989B36FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04028283075
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E221DF961;
	Mon, 28 Oct 2024 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="GuxqCE9M"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA31DF73A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133946; cv=none; b=cHdIln4pjr+6iazB3eTd2nCkQyaAzyB//JixBhJdf5Tllbu6odXq0oC5QIs5FRxxEHcdp7MmP4yfOuTdE0jGLVxP7rb54gy/vrHHiEg2zgYLcD542urH40tqnfQJMMlABiT00OiO2sR/qEMNmJ2SsmRLnz4XGRQiFvYiSi1Rmmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133946; c=relaxed/simple;
	bh=cPBkORUG+SEbl8XM/oPwA83ucaxxbizdrui0HaiEyNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiM7ynD3yA9N/byANWHKhHDnBaxA1eg/zhLI9WooCJo3s7nfDn12GQ45imcXEgUJktPZ0dAU5Uj4+alcO8gcK2o8Mw8PiCAvU5PS0eWNi9MKs59BBYkdQe4nU3iT3F+UKAr/LLj9ZvljgQA+/2tNLaCuy3ApYdjiG3ij36jW7Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=GuxqCE9M; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315abed18aso43756825e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1730133941; x=1730738741; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/PxkrM9dRJKpeDPy8VpNPxAo5zWOWUFeNbvL9ub7ws=;
        b=GuxqCE9M5iIDtM/1lbcEkPRJiHOupqLEXXx5QHeO7sFmoG+c17t+XewUQhjxhlN2Qw
         e9bTGlhBOB2fGlbhiovJda2GRK4I2OFaM4+lDAESrM+KBdk9l3iZx8dzsdeZa4EiA4Ly
         M/ddPD25eGbwdQnLn1oIttbqJ8XnlovtjaUr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133941; x=1730738741;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/PxkrM9dRJKpeDPy8VpNPxAo5zWOWUFeNbvL9ub7ws=;
        b=ORtXiQDWpCQKqdH7ousD0miXQnPt65Dg3/tdYKiny0LcVEvdFSuLhVEl6mGfTUlqpf
         xXlrx1wHTzmSqLdxir2ik9T/ocJWZkZibBlV7T5dysduGAdAZCcvfRLv/oJmnNXA/B47
         en7wc3b3JI01cma8nf360ASObEJOQRBNqcicRKszzwnevPCVWEy2wxoCq/qySx76iV2p
         ani2p8Hv1sx18Zh3ixzC70fBV7tWCdGGqLjioNjp7IpBuEka5/4VW0KSS9QbmZC9psqF
         B3X1ij5x7jwTFJEXO07WSjumqIeFGjKt7sI4OK9jZ+iq26uLZGjEclNCRkzZ64VF5uVf
         WaBw==
X-Gm-Message-State: AOJu0Yxj4PCfGCjaq3wCDSujaaq6XpwTZfK/SuxjW7dYyeWKZLdcboTY
	WpEjQwQdq3LRq3dLTi7YRHsACpqZ6HV/ItCogx7WxpiAzft8FxWvOmqvWITDNGM=
X-Google-Smtp-Source: AGHT+IGXvtjQ7yxaPQ79ddQagLrkY294O0b3+MI9nvsfLeHQov666vsRoEuG/co909M+5DKZ3zG8hA==
X-Received: by 2002:a05:600c:4d21:b0:431:50cb:2398 with SMTP id 5b1f17b1804b1-431a0c3bb43mr58623635e9.2.1730133941499;
        Mon, 28 Oct 2024 09:45:41 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b579613sm144894605e9.38.2024.10.28.09.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:45:41 -0700 (PDT)
Date: Mon, 28 Oct 2024 16:45:40 +0000
From: Chris Down <chris@chrisdown.name>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: [PATCH v6 04/11] printk: Support toggling per-console loglevel via
 syslog() and cmdline
Message-ID: <07141a533c4071c364c4f2eda6d97a9a89797e67.1730133890.git.chris@chrisdown.name>
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

A new module parameter (ignore_per_console_loglevel) is added, which can
be set via the kernel command line or at runtime through
/sys/module/printk/parameters/ignore_per_console_loglevel. When set, the
per-console loglevels are ignored, and the global console loglevel
(console_loglevel) is used for all consoles.

During sysrq, we temporarily disable per-console loglevels to ensure all
requisite messages are printed to the console. This is necessary because
sysrq is often used in dire circumstances where access to
/sys/class/console may not be trivially possible.

Additionally, the syslog actions SYSLOG_ACTION_CONSOLE_ON and
SYSLOG_ACTION_CONSOLE_OFF are augmented to save and restore the state of
ignore_per_console_loglevel. This allows administrators to enable or
disable per-console loglevels dynamically using the syslog() system
call, as supported in userspace by things like dmesg.

This is useful when debugging issues with message emission, or when
needing to quickly break glass and revert to global loglevel only.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 Documentation/admin-guide/index.rst           |  1 +
 .../admin-guide/per-console-loglevel.rst      | 70 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 drivers/tty/sysrq.c                           |  5 ++
 include/linux/printk.h                        |  2 +
 kernel/printk/printk.c                        | 39 ++++++++++-
 6 files changed, 116 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/admin-guide/per-console-loglevel.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index e85b1adf5908..366a08a1eee2 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -119,6 +119,7 @@ configure specific aspects of kernel behavior to your liking.
    namespaces/index
    numastat
    parport
+   per-console-loglevel
    perf-security
    pm/index
    pnp
diff --git a/Documentation/admin-guide/per-console-loglevel.rst b/Documentation/admin-guide/per-console-loglevel.rst
new file mode 100644
index 000000000000..1ec7608f94b0
--- /dev/null
+++ b/Documentation/admin-guide/per-console-loglevel.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _per_console_loglevel:
+
+Per-console loglevel support
+============================
+
+Motivation
+----------
+
+Consoles can have vastly different latencies and throughputs. For example,
+writing a message to the serial console can take on the order of tens of
+milliseconds to get the UART to successfully write a message. While this might
+be fine for a single, one-off message, this can cause significant
+application-level stalls in situations where the kernel writes large amounts of
+information to the console.
+
+This means that while you might want to send at least INFO level messages to
+(for example) netconsole, which is relatively fast, you may only want to send
+at least WARN level messages to the serial console. This permits debugging
+using the serial console in cases that netconsole doesn't receive messages
+during particularly bad system issues, while still keeping the noise low enough
+to avoid inducing latency in userspace applications.
+
+Loglevel
+--------
+
+Kernel loglevels are defined thus:
+
++---+--------------+-----------------------------------+
+| 0 | KERN_EMERG   | system is unusable                |
++---+--------------+-----------------------------------+
+| 1 | KERN_ALERT   | action must be taken immediately  |
++---+--------------+-----------------------------------+
+| 2 | KERN_CRIT    | critical conditions               |
++---+--------------+-----------------------------------+
+| 3 | KERN_ERR     | error conditions                  |
++---+--------------+-----------------------------------+
+| 4 | KERN_WARNING | warning conditions                |
++---+--------------+-----------------------------------+
+| 5 | KERN_NOTICE  | normal but significant condition  |
++---+--------------+-----------------------------------+
+| 6 | KERN_INFO    | informational                     |
++---+--------------+-----------------------------------+
+| 7 | KERN_DEBUG   | debug-level messages              |
++---+--------------+-----------------------------------+
+
+Tunables
+--------
+
+In order to allow tuning per-console loglevels, the following controls exist:
+
+Global
+~~~~~~
+
+The global loglevel is set by the ``kernel.console_loglevel`` sysctl, which can
+also be set as ``loglevel=`` on the kernel command line.
+
+The printk module also takes two parameters which modify this behaviour
+further:
+
+* ``ignore_loglevel`` on the kernel command line or set in printk parameters:
+  Emit all messages. All other controls are ignored if this is present.
+
+* ``ignore_per_console_loglevel`` on the kernel command line or set in printk
+  parameters: Ignore all per-console loglevels and use the global loglevel.
+
+The default value for ``kernel.console_loglevel`` comes from
+``CONFIG_CONSOLE_LOGLEVEL_DEFAULT``, or ``CONFIG_CONSOLE_LOGLEVEL_QUIET`` if
+``quiet`` is passed on the kernel command line.
diff --git a/MAINTAINERS b/MAINTAINERS
index a27407950242..36490a1fc721 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18449,6 +18449,7 @@ R:	John Ogness <john.ogness@linutronix.de>
 R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
+F:	Documentation/admin-guide/per-console-loglevel.rst
 F:	include/linux/printk.h
 F:	kernel/printk/
 
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index daa9fe7dad54..84befb6d8d82 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -598,6 +598,7 @@ static void __sysrq_put_key_op(u8 key, const struct sysrq_key_op *op_p)
 void __handle_sysrq(u8 key, bool check_mask)
 {
 	const struct sysrq_key_op *op_p;
+	bool orig_ignore_per_console_loglevel;
 	int orig_log_level;
 	int orig_suppress_printk;
 	int i;
@@ -616,6 +617,9 @@ void __handle_sysrq(u8 key, bool check_mask)
 	orig_log_level = console_loglevel;
 	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
 
+	orig_ignore_per_console_loglevel = ignore_per_console_loglevel;
+	ignore_per_console_loglevel = true;
+
 	op_p = __sysrq_get_key_op(key);
 	if (op_p) {
 		/*
@@ -651,6 +655,7 @@ void __handle_sysrq(u8 key, bool check_mask)
 	rcu_read_unlock();
 	rcu_sysrq_end();
 
+	ignore_per_console_loglevel = orig_ignore_per_console_loglevel;
 	suppress_printk = orig_suppress_printk;
 }
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 5fbd6b7f1ab4..0053533dcfec 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -73,6 +73,8 @@ extern int console_printk[];
 #define minimum_console_loglevel (console_printk[2])
 #define default_console_loglevel (console_printk[3])
 
+extern bool ignore_per_console_loglevel;
+
 extern void console_verbose(void);
 
 /* strlen("ratelimit") + 1 */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2e99b63efb46..055619c5c7e8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -103,6 +103,9 @@ DEFINE_STATIC_SRCU(console_srcu);
  */
 int __read_mostly suppress_printk;
 
+/* The sysrq infrastructure needs this even on !CONFIG_PRINTK. */
+bool __read_mostly ignore_per_console_loglevel;
+
 #ifdef CONFIG_LOCKDEP
 static struct lockdep_map console_lock_dep_map = {
 	.name = "console_lock"
@@ -1287,9 +1290,21 @@ module_param(ignore_loglevel, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(ignore_loglevel,
 		 "ignore loglevel setting (prints all kernel messages to the console)");
 
+static int __init ignore_per_console_loglevel_setup(char *str)
+{
+	ignore_per_console_loglevel = true;
+	return 0;
+}
+
+early_param("ignore_per_console_loglevel", ignore_per_console_loglevel_setup);
+module_param(ignore_per_console_loglevel, bool, 0644);
+MODULE_PARM_DESC(
+	ignore_per_console_loglevel,
+	"ignore per-console loglevel setting (only respect global console loglevel)");
+
 bool per_console_loglevel_is_set(const struct console *con)
 {
-	return con && (READ_ONCE(con->level) > 0);
+	return !ignore_per_console_loglevel && con && (READ_ONCE(con->level) > 0);
 }
 
 /*
@@ -1298,6 +1313,16 @@ bool per_console_loglevel_is_set(const struct console *con)
  * 1. con->level. The locally set, console-specific loglevel. Optional, only
  *    valid if >0.
  * 2. console_loglevel. The default global console loglevel, always present.
+ *
+ * The behaviour can be further changed by the following printk module
+ * parameters:
+ *
+ * 1. ignore_loglevel. Can be set at boot or at runtime with
+ *    /sys/module/printk/parameters/ignore_loglevel. Overrides absolutely
+ *    everything since it's used to debug.
+ * 2. ignore_per_console_loglevel. Existing per-console loglevel values are left
+ *    intact, but are ignored in favour of console_loglevel as long as this is
+ *    true. Also manipulated through syslog(SYSLOG_ACTION_CONSOLE_{ON,OFF}).
  */
 enum loglevel_source
 console_effective_loglevel_source(const struct console *con)
@@ -1796,6 +1821,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
 	struct printk_info info;
 	bool clear = false;
 	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
+	static int saved_ignore_per_console_loglevel;
 	int error;
 
 	error = check_syslog_permissions(type, source);
@@ -1836,19 +1862,28 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	/* Disable logging to console */
 	case SYSLOG_ACTION_CONSOLE_OFF:
-		if (saved_console_loglevel == LOGLEVEL_DEFAULT)
+		if (saved_console_loglevel == LOGLEVEL_DEFAULT) {
 			saved_console_loglevel = console_loglevel;
+			saved_ignore_per_console_loglevel =
+				ignore_per_console_loglevel;
+		}
 		console_loglevel = minimum_console_loglevel;
+		ignore_per_console_loglevel = true;
 		break;
 	/* Enable logging to console */
 	case SYSLOG_ACTION_CONSOLE_ON:
 		if (saved_console_loglevel != LOGLEVEL_DEFAULT) {
 			console_loglevel = saved_console_loglevel;
+			ignore_per_console_loglevel =
+				saved_ignore_per_console_loglevel;
 			saved_console_loglevel = LOGLEVEL_DEFAULT;
 		}
 		break;
 	/* Set level of messages printed to console */
 	case SYSLOG_ACTION_CONSOLE_LEVEL:
+		if (!ignore_per_console_loglevel)
+			pr_warn_once(
+				"SYSLOG_ACTION_CONSOLE_LEVEL is ignored by consoles with an explicitly set per-console loglevel, see Documentation/admin-guide/per-console-loglevel.rst\n");
 		if (len < 1 || len > 8)
 			return -EINVAL;
 		if (len < minimum_console_loglevel)
-- 
2.46.0



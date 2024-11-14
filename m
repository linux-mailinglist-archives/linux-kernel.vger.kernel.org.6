Return-Path: <linux-kernel+bounces-409646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD969C904B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7112DB351F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097D322098;
	Thu, 14 Nov 2024 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UnzdzOag"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C7715DBB3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601280; cv=none; b=c2OF0rNn2LznEXn2dEuBZpcSvWYOGH+exZnHtc5YNOUJhQc9uRVfUnBYb9gL1nu+seh/UinZwRYFMMSWuoM7yvHEQWq2B8djngdzPDFC4+jiJizWfm0w8H82iMMKhKgOiULYgIwoH/Q8WBI43lS4PMdW5Fp2zjfgyLN3MLwCo80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601280; c=relaxed/simple;
	bh=yluMu3s1ddRU+1VpFF84R6nxi0FtrgiTkz5FLtVNMnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA5rBPaDgbl4/lVKQobVmilRY+QRTWl69pSYJA8bfawrc6tnWObHaIBAop5x4kWlQTGm3AoEu1AVSYrjSPNyOufFxy4Hyh7yKsmk+ws5byQG57nNE0mO0HJ+vwyXsCAuMbdXl8T2OL5Ixm99x1DebHHDDvxLYl8fFK5lR7Z2Krg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UnzdzOag; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53b34ed38easo825349e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731601275; x=1732206075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w53pxGA8laoN1vPzXrQ6LZ3BqhLCjC4Obozb8Zt3n0E=;
        b=UnzdzOagomughDF4+AFm63CecaDaO3QIOhD5HWJaMNEEq0k9uvgLidyRtkMTKfiijD
         FIzMZ/nODm9+1jbLKLbvexaQQbPF9EYriaU9pFD0FvaX1NGOvOIU2h7olKzfbniH8rQ6
         UBqgAc/hdDoBFShzW6f2YivVYZnxTSfrrK/R/JlOLDIIwOJu6UzynXenoMKXzAz91X1z
         FjwbI1gPikUs0GdC+L90+b9q2uJDzTl9NKeqTycJlbbWDuVr0nAcfOxtMdbspz0SGRnK
         bxbxLaEWKmZ6nkDBP+aj91iCqPI8ZnYH8GsoCojDOj1G7Qinadq1XnaYlnzXgOycvTxW
         GI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601275; x=1732206075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w53pxGA8laoN1vPzXrQ6LZ3BqhLCjC4Obozb8Zt3n0E=;
        b=r37u0RjT6Bl4g7d4oqAZJXCupWWY5QscVur4anjbNLIghtccAHHsV4IZipd8LaL7Xz
         brq04QQ/RBaujYtpgFNiF/1Ny6dN9yCyQlrUmVj1SNTTac1pRPz/klpWAIfNx+e9bLHm
         oDYiflEacdtfL4ERsjV9hFsvTZ+flOCNEwiMEH5r1VeVsrx/MfDbJfiii96DAMU7OmM8
         WSRFd8xAWppvG/YJ/yXAALkueCIjC/YoLn6viIDkgYuExUsuesFJGSCHSetYDuYmemXl
         cVyy+a+TLqF38rHdLcnimd0GiBUxsdrSowEtQ+w1dkQqInnmOinsDapsNhu3WkCjLQjn
         EDdg==
X-Gm-Message-State: AOJu0YzJ1DihbT3sfEG/h8/GfC0DnvHz6B+B1gswl7s9cZ/7EORxJ7rd
	ABSySDfbLAy237oejD+Y1vC7PUlJrqgfT5npcEaNBGUJwBzs7e2zIku0zxUZcd8=
X-Google-Smtp-Source: AGHT+IHJ/n5Ny0G/LvlX+PIYU//nf+Sd5yCXe6EmElknSy44MXZAQTx0oaSrqS5fKxnevulb9lGxsA==
X-Received: by 2002:a05:6512:ac4:b0:534:3cdc:dbef with SMTP id 2adb3069b0e04-53d862e4e43mr12808312e87.43.1731601275250;
        Thu, 14 Nov 2024 08:21:15 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265668sm28457885e9.10.2024.11.14.08.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:21:14 -0800 (PST)
Date: Thu, 14 Nov 2024 17:21:11 +0100
From: Petr Mladek <pmladek@suse.com>
To: Chris Down <chris@chrisdown.name>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 09/11] printk: Add sysctl interface to set global
 loglevels
Message-ID: <ZzYjd5TOvQjGNd1n@pathway.suse.cz>
References: <cover.1730133890.git.chris@chrisdown.name>
 <f4aa4bc84a7936080bbd727efbd8b540995c8b27.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4aa4bc84a7936080bbd727efbd8b540995c8b27.1730133890.git.chris@chrisdown.name>

On Mon 2024-10-28 16:45:55, Chris Down wrote:
> Introduce two new sysctl interfaces for configuring global loglevels:
> 
> - kernel.console_loglevel: Sets the global console loglevel, determining
>   the minimum priority of messages printed to consoles. Messages with a
>   loglevel lower than this value will be printed.
> - kernel.default_message_loglevel: Sets the default loglevel for
>   messages that do not specify an explicit loglevel.
> 
> The kernel.printk sysctl was previously used to set multiple loglevel
> parameters simultaneously, but it was confusing and lacked proper
> validation. By introducing these dedicated sysctl interfaces, we provide
> a clearer and more granular way to configure the loglevels.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 17 ++++++++-
>  kernel/printk/sysctl.c                      | 42 +++++++++++++++++++++
>  2 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index f8bc1630eba0..8019779b27f6 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1044,6 +1044,20 @@ otherwise the 'doze' mode will be used.
>  
>  ==============================================================
>  
> +Some of these settings may be overridden per-console, see
> +Documentation/admin-guide/per-console-loglevel.rst. See ``man 2 syslog`` for
> +more information on the different loglevels.
> +
> +console_loglevel
> +================
> +
> +Messages with a higher priority than this will be printed to consoles.
> +
> +default_message_loglevel
> +========================
> +
> +Messages without an explicit priority will be printed with this priority.
> +
>  printk
>  ======
>  
> @@ -1052,8 +1066,7 @@ The four values in printk denote: ``console_loglevel``,
>  ``default_console_loglevel`` respectively.
>  
>  These values influence printk() behavior when printing or
> -logging error messages. See '``man 2 syslog``' for more info on
> -the different loglevels.
> +logging error messages.
>  
>  ======================== =====================================
>  console_loglevel         messages with a higher priority than
> diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
> index f5072dc85f7a..3bce8b89dacc 100644
> --- a/kernel/printk/sysctl.c
> +++ b/kernel/printk/sysctl.c
> @@ -11,6 +11,9 @@
>  
>  static const int ten_thousand = 10000;
>  
> +static int min_msg_loglevel = LOGLEVEL_EMERG;
> +static int max_msg_loglevel = LOGLEVEL_DEBUG;
> +
>  static int proc_dointvec_minmax_sysadmin(const struct ctl_table *table, int write,
>  				void *buffer, size_t *lenp, loff_t *ppos)
>  {
> @@ -20,6 +23,29 @@ static int proc_dointvec_minmax_sysadmin(const struct ctl_table *table, int writ
>  	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>  }
>  
> +static int printk_console_loglevel(const struct ctl_table *table, int write,
> +				   void *buffer, size_t *lenp, loff_t *ppos)

I would make it more clear that this function is using the procfs
based API and call it "proc_dointvec_console_loglevel()".

> +{
> +	struct ctl_table ltable = *table;
> +	int ret, level;
> +
> +	if (!write)
> +		return proc_dointvec(table, write, buffer, lenp, ppos);
> +
> +	ltable.data = &level;

Ah, I have missed that this is a copy and spent quite some time
wondering why it worked ;-) I remember that the same happened
last time I saw this trick.

It would deserve a comment for people like me. Or maybe, rename
the variable from ltable to table_copy.

Or I think about another solution, see below.

> +
> +	ret = proc_dointvec(&ltable, write, buffer, lenp, ppos);
> +	if (ret)
> +		return ret;
> +
> +	if (level != -1 && level != clamp_loglevel(level))
> +		return -ERANGE;
> +
> +	console_loglevel = level;

There is no locking. It seems that the original proc_dointvec code
handle this by using WRITE_ATOMIC(). It prevents compiler
optimizations. In particular, it makes sure that the entire value
will be updated in a single operation (atomically).

> +	return 0;
> +}
> +

I have mixed feelings. On one hand, the copy of the table entry looks
like a nice trick. On the other hand, I guess that this is the only
code using such a trick. It might make it more error prone when
some of the API internals change.

It seems that other users handle similar situations by
passing a custom @conv callback to do_proc_dointvec(),
for example, proc_dointvec_minmax(), proc_dointvec_jiffies().

This approach would require exporing do_proc_dointvec()
and do_proc_dointvec_conv(). But there already is a precedent
when do_proc_douintvec() is used in proc_dopipe_max_size().

I have tried to implement it to see how it looks. And I would
prefer to use it. Here is the updated patch:


From 05a75d464276da24b7f4b7b97b982041607bbae2 Mon Sep 17 00:00:00 2001
From: Chris Down <chris@chrisdown.name>
Date: Mon, 28 Oct 2024 16:45:55 +0000
Subject: [POC 09/11] printk: Add sysctl interface to set global loglevels

Introduce two new sysctl interfaces for configuring global loglevels:

- kernel.console_loglevel: Sets the global console loglevel, determining
  the minimum priority of messages printed to consoles. Messages with a
  loglevel lower than this value will be printed.
- kernel.default_message_loglevel: Sets the default loglevel for
  messages that do not specify an explicit loglevel.

The kernel.printk sysctl was previously used to set multiple loglevel
parameters simultaneously, but it was confusing and lacked proper
validation. By introducing these dedicated sysctl interfaces, we provide
a clearer and more granular way to configure the loglevels.

Signed-off-by: Chris Down <chris@chrisdown.name>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 17 ++++++-
 include/linux/sysctl.h                      |  7 +++
 kernel/printk/sysctl.c                      | 51 +++++++++++++++++++++
 kernel/sysctl.c                             |  4 +-
 4 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index f8bc1630eba0..8019779b27f6 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1044,6 +1044,20 @@ otherwise the 'doze' mode will be used.
 
 ==============================================================
 
+Some of these settings may be overridden per-console, see
+Documentation/admin-guide/per-console-loglevel.rst. See ``man 2 syslog`` for
+more information on the different loglevels.
+
+console_loglevel
+================
+
+Messages with a higher priority than this will be printed to consoles.
+
+default_message_loglevel
+========================
+
+Messages without an explicit priority will be printed with this priority.
+
 printk
 ======
 
@@ -1052,8 +1066,7 @@ The four values in printk denote: ``console_loglevel``,
 ``default_console_loglevel`` respectively.
 
 These values influence printk() behavior when printing or
-logging error messages. See '``man 2 syslog``' for more info on
-the different loglevels.
+logging error messages.
 
 ======================== =====================================
 console_loglevel         messages with a higher priority than
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index aa4c6d44aaa0..a297ca0d4096 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -237,6 +237,13 @@ extern struct ctl_table_header *register_sysctl_mount_point(const char *path);
 
 void do_sysctl_args(void);
 bool sysctl_is_alias(char *param);
+int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp, int *valp,
+			  int write, void *data);
+int do_proc_dointvec(const struct ctl_table *table, int write,
+		     void *buffer, size_t *lenp, loff_t *ppos,
+		     int (*conv)(bool *negp, unsigned long *lvalp, int *valp,
+				 int write, void *data),
+		     void *data);
 int do_proc_douintvec(const struct ctl_table *table, int write,
 		      void *buffer, size_t *lenp, loff_t *ppos,
 		      int (*conv)(unsigned long *lvalp,
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index f5072dc85f7a..749e3575f2d1 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -11,6 +11,9 @@
 
 static const int ten_thousand = 10000;
 
+static int min_msg_loglevel = LOGLEVEL_EMERG;
+static int max_msg_loglevel = LOGLEVEL_DEBUG;
+
 static int proc_dointvec_minmax_sysadmin(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -20,6 +23,38 @@ static int proc_dointvec_minmax_sysadmin(const struct ctl_table *table, int writ
 	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 }
 
+static int do_proc_dointvec_console_loglevel(bool *negp, unsigned long *lvalp,
+					int *valp,
+					int write, void *data)
+{
+	int level, ret;
+
+	/*
+	 * If writing, first do so via a temporary local int so we can
+	 * bounds-check it before touching *valp.
+	 */
+	int *intp = write ? &level : valp;
+
+	ret = do_proc_dointvec_conv(negp, lvalp, intp, write, data);
+	if (ret)
+		return ret;
+
+	if (write) {
+		if (level != -1 && level != clamp_loglevel(level))
+			return -ERANGE;
+		WRITE_ONCE(*valp, level);
+	}
+
+	return 0;
+}
+
+static int proc_dointvec_console_loglevel(const struct ctl_table *table,
+		int write, void *buffer, size_t *lenp, loff_t *ppos)
+{
+	return do_proc_dointvec(table, write, buffer, lenp, ppos,
+				do_proc_dointvec_console_loglevel, NULL);
+}
+
 static struct ctl_table printk_sysctls[] = {
 	{
 		.procname	= "printk",
@@ -76,6 +111,22 @@ static struct ctl_table printk_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "console_loglevel",
+		.data		= &console_loglevel,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_console_loglevel,
+	},
+	{
+		.procname	= "default_message_loglevel",
+		.data		= &default_message_loglevel,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &min_msg_loglevel,
+		.extra2		= &max_msg_loglevel,
+	},
 };
 
 void __init printk_sysctl_init(void)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 79e6cb1d5c48..225ef261d2fb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -424,7 +424,7 @@ static void proc_put_char(void **buf, size_t *size, char c)
 	}
 }
 
-static int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp,
+int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp,
 				 int *valp,
 				 int write, void *data)
 {
@@ -541,7 +541,7 @@ static int __do_proc_dointvec(void *tbl_data, const struct ctl_table *table,
 	return err;
 }
 
-static int do_proc_dointvec(const struct ctl_table *table, int write,
+int do_proc_dointvec(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos,
 		  int (*conv)(bool *negp, unsigned long *lvalp, int *valp,
 			      int write, void *data),
-- 
2.47.0




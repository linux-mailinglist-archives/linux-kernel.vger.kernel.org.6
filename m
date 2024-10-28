Return-Path: <linux-kernel+bounces-385426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E219B3705
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BA31F24C28
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D891DFE10;
	Mon, 28 Oct 2024 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="HmcNA+f0"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945DD1DFDBC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133959; cv=none; b=VN1ITVPbV+CO4n+ze75BKPEocoxTfXcn8Ql2Klou3p/GcYdIsofHHzOqyPgD7xgDLlfpjgbql2SBdrunYHMOonZcVwkpI83fHJITFhb6pvEOnUWlc6Awhq4TM+4YGZzN0DdK/67SNSd3ajS47bZAiLRQa2L7wlK5Uoem7Nge0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133959; c=relaxed/simple;
	bh=FJz5ZYHXv2EYMhNVZ1HdE9gJlLVWwx5DQdm0EHjF+Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHWKgKVUGwXhp1/vCSOt4GSFTm6B1rO2ItshijNdyGDQqxt15mf5PJlBFvq6ckdRtksnwn+tULbj+qPA+AORCW5YweZb7DClmnqk7GrgYTRJAc+tmF/T6gxrUnpU7AJY67EDJgjhm9XWj+NjjzMEWBavs75AakAKxQt0me7IHBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=HmcNA+f0; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f7606199so4931677e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1730133955; x=1730738755; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdxmvRxcUCh2wU6MGMITBYWUXVm7PGpvZFKsGRUujMU=;
        b=HmcNA+f0Xt3f0YZDiNfs4Tmv5U2Pl3tAMc3XBymmalHD1/qZYGfumeyMEU7OoWL6tt
         xAhDjHK/4lanSZh4MHISKaX3ZwJfAu6FBo564pZ9IjtjhtFKtZjCp9nti0R4dz0xrORM
         yVQCs/jHf974BchkOSLllLAMR3IE/tNuVQk5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133955; x=1730738755;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdxmvRxcUCh2wU6MGMITBYWUXVm7PGpvZFKsGRUujMU=;
        b=bjVqaLvITPgbfhRNW/t9wa7KbmNJr80auHxkdfBZ3TveBq+KN7bCvgr/34KfVaeGbS
         +QF3zm5+8kkQ9CPE1hVzyRQWYBB1qXmZWeqDtYS2t4i4zVDRTD6FuM+iWMi9QRYZpZGZ
         e/QyMra96qGjWkPB9UISFJ0ajRugBrt/9aZQJcF+wvtmu6vKieMbAGI7Uht1u6c0GUnm
         SVlh8DACDuBsl0pymbWJrciUAXv4qozXBBcbwAZ9HbKrbI7DpJU0OSonNvVa50Ar1Q7b
         WSXSnSPbEVTq91UwVfTnkYR9T//1Ux5QbfFgHFHFjYnRd5ct4IL9KnfXxKSZlxlo7aY/
         4yAA==
X-Gm-Message-State: AOJu0YxINebvZpgB0vjdKCqvkrHrT4ZiFRTmiLb8AfcYoOVhs5hkwDm6
	fp9+gxG4JdfxxZJVhkWD4PaZCeZfoQyld0JJPbALtKCrSZZRF5+ts7MPz5p1HYw=
X-Google-Smtp-Source: AGHT+IHZvNmhqv9/cwd4qrjDL/P6Dm2CW/EPcLmAMDoaHfhzcy/c184ISjVKoRMKNsJXTY4WqERHBw==
X-Received: by 2002:a05:6512:32c6:b0:539:ee0a:4f8f with SMTP id 2adb3069b0e04-53b3491cd35mr3587690e87.44.1730133953804;
        Mon, 28 Oct 2024 09:45:53 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4317dde77a5sm137445455e9.1.2024.10.28.09.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:45:53 -0700 (PDT)
Date: Mon, 28 Oct 2024 16:45:52 +0000
From: Chris Down <chris@chrisdown.name>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: [PATCH v6 08/11] printk: Support setting initial console loglevel
 via console= on cmdline
Message-ID: <fe2d066784a1b9e1c3fc3ba22cb7c113830caca2.1730133890.git.chris@chrisdown.name>
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

Extend the console= kernel command line parameter to support specifying
per-console loglevels at boot time. This is achieved by introducing a
new loglevel option that can be passed as a loglevel option within a
console= stanza.

For example, this is an example of how one might configure netconsole
devices to print messages with a higher priority than loglevel 3
(KERN_ERR) at startup:

    console=netcon0,loglevel:3

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 .../admin-guide/kernel-parameters.txt         | 24 +++--
 Documentation/admin-guide/serial-console.rst  | 37 +++++++-
 Documentation/networking/netconsole.rst       |  6 +-
 kernel/printk/console_cmdline.h               |  1 +
 kernel/printk/printk.c                        | 87 ++++++++++++++++++-
 5 files changed, 140 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..d883a851fffc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -799,13 +799,18 @@
 		ttyS<n>[,options]
 		ttyUSB0[,options]
 			Use the specified serial port.  The options are of
-			the form "bbbbpnf", where "bbbb" is the baud rate,
-			"p" is parity ("n", "o", or "e"), "n" is number of
-			bits, and "f" is flow control ("r" for RTS or
-			omit it).  Default is "9600n8".
+			the form "bbbbpnf,extra", where "bbbb" is the baud
+			rate, "p" is parity ("n", "o", or "e"), "n" is
+			number of bits, and "f" is flow control ("r" for RTS
+			or omit it). Default is "9600n8".
 
-			See Documentation/admin-guide/serial-console.rst for more
-			information.  See
+			At present the only extra option is "loglevel" to
+			set the per-console loglevel. For example:
+
+				console=ttyS0,9600n8,loglevel:3
+
+			See Documentation/admin-guide/serial-console.rst for
+			more information.  See
 			Documentation/networking/netconsole.rst for an
 			alternative.
 
@@ -3167,8 +3172,11 @@
 	loglevel=	[KNL,EARLY]
 			All Kernel Messages with a loglevel smaller than the
 			console loglevel will be printed to the console. It can
-			also be changed with klogd or other programs. The
-			loglevels are defined as follows:
+			also be changed with klogd or other programs. Note that
+			this can be overridden per-console, see
+			Documentation/admin-guide/per-console-loglevel.rst.
+
+			The loglevels are defined as follows:
 
 			0 (KERN_EMERG)		system is unusable
 			1 (KERN_ALERT)		action must be taken immediately
diff --git a/Documentation/admin-guide/serial-console.rst b/Documentation/admin-guide/serial-console.rst
index a3dfc2c66e01..240f7a36379d 100644
--- a/Documentation/admin-guide/serial-console.rst
+++ b/Documentation/admin-guide/serial-console.rst
@@ -32,6 +32,33 @@ The format of this option is::
 			and F is flow control ('r' for RTS). Default is
 			9600n8. The maximum baudrate is 115200.
 
+			One can also specify the per-console loglevel for this
+			console by providing a loglevel parameter, for example
+			"loglevel:4" to set this console's loglevel to 4. The
+			value provided can be from 0 (LOGLEVEL_EMERG) to 8
+			(LOGLEVEL_DEBUG + 1), and messages below that will be
+			emitted onto the console as they become available.
+
+The available loglevels are defined thus:
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
 You can specify multiple console= options on the kernel command line.
 
 The behavior is well defined when each device type is mentioned only once.
@@ -39,11 +66,14 @@ In this case, the output will appear on all requested consoles. And
 the last device will be used when you open ``/dev/console``.
 So, for example::
 
-	console=ttyS1,9600 console=tty0
+	console=ttyS1,9600,loglevel:5 console=tty0
 
 defines that opening ``/dev/console`` will get you the current foreground
-virtual console, and kernel messages will appear on both the VGA
-console and the 2nd serial port (ttyS1 or COM2) at 9600 baud.
+virtual console, and kernel messages will appear on both the VGA console and
+the 2nd serial port (ttyS1 or COM2) at 9600 baud. The optional loglevel "5"
+indicates that this console will emit messages more serious than
+LOGLEVEL_NOTICE (that is, LOGLEVEL_WARNING and below, since more serious
+messages have lower ordering).
 
 The behavior is more complicated when the same device type is defined more
 times. In this case, there are the following two rules:
@@ -143,3 +173,4 @@ Replace the sample values as needed.
    the integration of these patches into m68k, ppc and alpha.
 
 Miquel van Smoorenburg <miquels@cistron.nl>, 11-Jun-2000
+Chris Down <chris@chrisdown.name>, 23-October-2024
diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 34419e6fe106..a7c7519fe2d0 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -72,7 +72,11 @@ Built-in netconsole starts immediately after the TCP stack is
 initialized and attempts to bring up the supplied dev at the supplied
 address.
 
-You can also set a loglevel at runtime::
+You can also set a loglevel at boot time on the kernel command line::
+
+  console=netcon0,loglevel:2
+
+This can also be changed at runtime::
 
   $ ls -l /sys/class/console/netcon0/
   total 0
diff --git a/kernel/printk/console_cmdline.h b/kernel/printk/console_cmdline.h
index 0ab573b6d4dc..cb3b99d31d80 100644
--- a/kernel/printk/console_cmdline.h
+++ b/kernel/printk/console_cmdline.h
@@ -7,6 +7,7 @@ struct console_cmdline
 	char	name[16];			/* Name of the driver	    */
 	int	index;				/* Minor dev. to use	    */
 	char	devname[32];			/* DEVNAME:0.0 style device name */
+	int	level;				/* Log level to use */
 	bool	user_specified;			/* Specified by command line vs. platform */
 	char	*options;			/* Options for the driver   */
 #ifdef CONFIG_A11Y_BRAILLE_CONSOLE
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index bbd037b84a0d..c47dda23a7d6 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2597,12 +2597,84 @@ static void set_user_specified(struct console_cmdline *c, bool user_specified)
 	console_set_on_cmdline = 1;
 }
 
+static bool find_and_remove_console_option(char *options, const char *key,
+					   char *val_buf, size_t val_buf_size)
+{
+	bool found = false, first = true;
+	char *option, *next = options;
+
+	while ((option = strsep(&next, ","))) {
+		char *value;
+
+		value = strchr(option, ':');
+		if (value)
+			*(value++) = '\0';
+
+		if (strcmp(option, key) == 0) {
+			found = true;
+			if (value) {
+				if (strlen(value) >= val_buf_size) {
+					pr_warn("Can't copy console option value for %s:%s: not enough space (%zu)\n",
+						option, value, val_buf_size);
+					found = false;
+				} else {
+					strscpy(val_buf, value, val_buf_size);
+				}
+			} else
+				*val_buf = '\0';
+		}
+
+		if (found)
+			break;
+
+		if (next)
+			*(next - 1) = ',';
+		if (value)
+			*(value - 1) = ':';
+
+		first = false;
+	}
+
+	if (found) {
+		if (next)
+			memmove(option, next, strlen(next) + 1);
+		else if (first)
+			*option = '\0';
+		else
+			*--option = '\0';
+	}
+
+	return found;
+}
+
+static int find_and_remove_loglevel_option(char *options)
+{
+	char val[16];
+	int loglevel;
+
+	if (!find_and_remove_console_option(options, "loglevel", val,
+					    sizeof(val)))
+		return -ENOENT;
+
+	if (kstrtoint(val, 10, &loglevel)) {
+		pr_warn("Invalid console loglevel, ignoring: %s\n", val);
+		return -EINVAL;
+	}
+
+	if (clamp_loglevel(loglevel) != loglevel) {
+		pr_warn("Per-console loglevel out of range, ignoring: %d\n", loglevel);
+		return -ERANGE;
+	}
+
+	return loglevel;
+}
+
 static int __add_preferred_console(const char *name, const short idx,
 				   const char *devname, char *options,
 				   char *brl_options, bool user_specified)
 {
 	struct console_cmdline *c;
-	int i;
+	int i, ret;
 
 	if (!name && !devname)
 		return -EINVAL;
@@ -2639,6 +2711,13 @@ static int __add_preferred_console(const char *name, const short idx,
 		strscpy(c->name, name);
 	if (devname)
 		strscpy(c->devname, devname);
+
+	ret = find_and_remove_loglevel_option(options);
+	if (ret >= 0)
+		c->level = ret;
+	else
+		c->level = -1;
+
 	c->options = options;
 	set_user_specified(c, user_specified);
 	braille_set_options(c, brl_options);
@@ -3903,8 +3982,10 @@ static int try_enable_preferred_console(struct console *newcon,
 			if (newcon->index < 0)
 				newcon->index = c->index;
 
-			// TODO: Will be configurable in a later patch
-			newcon->level = -1;
+			if (c->level > 0)
+				newcon->level = c->level;
+			else
+				newcon->level = -1;
 
 			newcon->classdev = NULL;
 
-- 
2.46.0



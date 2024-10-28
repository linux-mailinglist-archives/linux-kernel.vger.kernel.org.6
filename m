Return-Path: <linux-kernel+bounces-385427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 378DF9B3706
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1B21C226FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4721DFE23;
	Mon, 28 Oct 2024 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="WSyBEQs+"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E11DF273
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133961; cv=none; b=CFYshUVlq4PIKd+X+AZUbu1nSItVT/HH7eLR401hDZwemxMlcFoiJqFZRQvU9fScCu11mKMGvokunwKThGR4qGudAmFOw/zDYo96YHZfWkaavrBfkYCVgMe3JQjfDDIyIiAccbeZzYsfAw2q8EBgGrE/OnmUY66MJwKWG0Zdcpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133961; c=relaxed/simple;
	bh=hCTeBcjd7iD4npJLTCTrUA2Zs2OYGmA4QQyHBaJpgqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4fJYIBddkfajPxgm6UO3ml2Agc5C1t38qsQihwpppQDlWEFdgWC7SDVzU+rcNWMCkpQlnd5F4XdTxEYaZ64DQU0dw6W12ox/zC5HM+k8eLgoaFid097dmxmPAiYL17pfcLVhz+tJ7t4enI9Fnq6IN3gQS0OFPWgNI1KkJ4Inpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=WSyBEQs+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4314c452180so38207735e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1730133958; x=1730738758; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbVhQ674tMTDDUxWK+JYxDMM69XMs+UNwDYGU3cpCJM=;
        b=WSyBEQs+kjw9DlYpKgKFY2eHNPcLlB9Qx0fpey3hPiPezt306Nky+irV1u2zoePL+C
         Vo6Wij9G/S1odxVgMnwwzCMr2ccpqfRCdfQPbCmw4BmsHRJ2LzoesfFCP1gleG0Cb6R8
         5BJdPvaEpy3NLj5bLJzjrvyFqQHtuAY4b1hvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133958; x=1730738758;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbVhQ674tMTDDUxWK+JYxDMM69XMs+UNwDYGU3cpCJM=;
        b=eLaQzx91qsC9R/mKKINtk4wm5KmY59FIbOxishzc1KSCfhic9kua6TrX+kiIWLrDXa
         eNW4AKFrrK0ry0FxjCC09d3XSi4X/75ZuaF1+l7nydzIiGVhhL5LRGPltONdquz/o2Th
         gmU/k/lhW+1tA9Gub9/mQxf/+jQ4HrIIztLyfpErjzlWjYPWtYLUjLYvwA2P3hiCfiSL
         7UTILVk3L8fOOl9P9FhnDXqTkEq1+egN034knFAz59R3f1yNm0tuGYq586eONdMa9+EO
         l7NqgyaXgxJR/UPYNR9ALOse6FuXFAnseyTxi9m/rqA21ai7F4ZjzFszB22QUK3Dre2x
         nEqg==
X-Gm-Message-State: AOJu0Ywm3/btsyi52b6qyOTO42TfoaqGvCfUwVNSmiyEp1iv7tY82A44
	6SGRTvfoaVYio7axYMx0YtuFqAglG6XNgXPSpB0M7bvlkPO18t8DPrnIcEAewXc=
X-Google-Smtp-Source: AGHT+IHJvu2pohYpsdBuR+YDwUK3Ikz9/BrbQZ/b8XBcpBP4aAwoWkcwtdALE8PVbKnEIQCZki9wwA==
X-Received: by 2002:a05:600c:5490:b0:42c:b991:98bc with SMTP id 5b1f17b1804b1-431b2def197mr2610965e9.0.1730133957668;
        Mon, 28 Oct 2024 09:45:57 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b56ef06sm146260435e9.30.2024.10.28.09.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:45:57 -0700 (PDT)
Date: Mon, 28 Oct 2024 16:45:55 +0000
From: Chris Down <chris@chrisdown.name>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: [PATCH v6 09/11] printk: Add sysctl interface to set global loglevels
Message-ID: <f4aa4bc84a7936080bbd727efbd8b540995c8b27.1730133890.git.chris@chrisdown.name>
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
---
 Documentation/admin-guide/sysctl/kernel.rst | 17 ++++++++-
 kernel/printk/sysctl.c                      | 42 +++++++++++++++++++++
 2 files changed, 57 insertions(+), 2 deletions(-)

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
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index f5072dc85f7a..3bce8b89dacc 100644
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
@@ -20,6 +23,29 @@ static int proc_dointvec_minmax_sysadmin(const struct ctl_table *table, int writ
 	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 }
 
+static int printk_console_loglevel(const struct ctl_table *table, int write,
+				   void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table ltable = *table;
+	int ret, level;
+
+	if (!write)
+		return proc_dointvec(table, write, buffer, lenp, ppos);
+
+	ltable.data = &level;
+
+	ret = proc_dointvec(&ltable, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
+
+	if (level != -1 && level != clamp_loglevel(level))
+		return -ERANGE;
+
+	console_loglevel = level;
+
+	return 0;
+}
+
 static struct ctl_table printk_sysctls[] = {
 	{
 		.procname	= "printk",
@@ -76,6 +102,22 @@ static struct ctl_table printk_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "console_loglevel",
+		.data		= &console_loglevel,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= printk_console_loglevel,
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
-- 
2.46.0



Return-Path: <linux-kernel+bounces-385428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7719B3707
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A400C1F250C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4781DFE34;
	Mon, 28 Oct 2024 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="Yy/MUa9l"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310961DFE1E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133966; cv=none; b=slbJFr/P1yK2jGxLRGXgGX2pWukZI+GGZ6CYQmQ5ikMJGJW5Ylyc8E8dnKXFbSZMlhP6aPRAyo365TnxBLEYaBcRpB64dCnjNGhkoWSwr8lCAOxj+HXLsWcUYNSoE6teuILznos3UqHY7QQkx/nwqYbqXWWeABr0tPtOahUo600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133966; c=relaxed/simple;
	bh=sI52s5i9k4pYNrQHBS72EU98OIueE15hSE4KEthCY5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGb41gKVFC5Fv3DFh9qGDOtw8INuok4WjW+w/7pbqc2dw5EMBBJoAnpPCWCn2jDD3tzY7GKQGw4770G5uP6/KFEnpm+CVpXefwUoU80mf9Tk4bOoXOLmZEl0tEBsN4Pkw6UTyZcWeBLfYyuWUBixKnir9iDeSIVksHwr0c8ac+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=Yy/MUa9l; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431ac30d379so9160745e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1730133960; x=1730738760; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbATi4LQJSIUmiSf9Q8b/uDqq/jBD5xLfukP+H/32dM=;
        b=Yy/MUa9l2q67eBZtZoYV0tINKz0i/IlLmYxLOGmiK4a+F2budkEVrzG4skhk8MpVqr
         ScMrw8XKmBfcylZpPbk8JaQuXMElpCcbfNHjchLe64PoxfGM7loU8NZ7qiukRH/Wr8ZI
         iK+hKFmHFjkGaESjIaUf13tCUG6FGx+uuAkCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133960; x=1730738760;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbATi4LQJSIUmiSf9Q8b/uDqq/jBD5xLfukP+H/32dM=;
        b=Q9AqS0Ws8246t+RD1M7f+OEQuGb2mKyH9jvhZ5llh4/x3lGVQwcQYDR3YnC4Tw9ip7
         pC9Lse5YPO/zKl2u1+aMCHBLnzG/xVu7nytqY9QzRocNdYPDI32xkMItb3T2nemm90PX
         HID/JvaiX9p0zKvLLMKqA8dE2/7PSQA/ci4+l10gCC5RZLiguTG+M8cTz/Ea/g2wYvTy
         ZeqlY9cojfogbbv9WPWcGz6YyjoLPlaiLEznndnaB4fIkjzvlGzhbLT5x8wjldvnWnOz
         trFyuat7/PD2gdrxZFdailrBQwzJoJATYqPFrHVwRGECL9HJuLQnmRtoiuUonr7O3Rw/
         Jhvg==
X-Gm-Message-State: AOJu0YxspVcIUInjBjkceY1gk4VsDACdTqpM0/PysTiwF5e8w2BhtBXQ
	haGW9zgWgHVjiIujD0MQp7/W9V4EwJxR6ILqN4lpoJ557BtdH3bQ1g42us7FMHA=
X-Google-Smtp-Source: AGHT+IEvvpnLREHjelMIBqHzAmiYJ5zM0d1BpPVE3JPzD4+dRIX/DKHK7f23k+8pfDQQZhz5g38RgQ==
X-Received: by 2002:a05:600c:4e8b:b0:431:40ca:ce44 with SMTP id 5b1f17b1804b1-4319ad34a44mr68787325e9.30.1730133960493;
        Mon, 28 Oct 2024 09:46:00 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b929a8sm10083304f8f.103.2024.10.28.09.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:46:00 -0700 (PDT)
Date: Mon, 28 Oct 2024 16:45:59 +0000
From: Chris Down <chris@chrisdown.name>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: [PATCH v6 10/11] printk: Deprecate the kernel.printk sysctl interface
Message-ID: <993d978d4a59dd370ac39c6c24c9b72c11f4dc74.1730133890.git.chris@chrisdown.name>
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

The kernel.printk sysctl interface is deprecated in favour of more
granular and clearer sysctl interfaces for controlling loglevels, namely
kernel.console_loglevel and kernel.default_message_loglevel.

kernel.printk has a number of fairly significant usability problems:

- It takes four values in a specific order, which is not intuitive.
  Speaking from personal experience, even people working on printk
  sometimes need to look up the order of these values, which doesn't
  suggest much in the way of perspicuity.
- There is no validation on the input values, so users can set them to
  invalid or nonsensical values without receiving any errors or
  warnings. This can lead to unpredictable behaviour.
- One of the four values, default_console_loglevel, is not used in the
  kernel (see below), making it redundant and potentially confusing.
- Overall, the interface is complex, hard to understand, and combines
  multiple controls into a single sysctl, which is not ideal. It should
  be separated into distinct controls for clarity.

Setting kernel.printk now calls printk_sysctl_deprecated, which emits a
pr_warn. The warning informs users about the deprecation and suggests
using the new sysctl interfaces instead.

By deprecating kernel.printk, we aim to:

- Encourage users to adopt the new, dedicated sysctl interfaces
  (kernel.console_loglevel and kernel.default_message_loglevel), which
  are more straightforward and easier to understand.
- Improve input validation and error handling, ensuring that users
  receive appropriate feedback when setting invalid values.
- Simplify the configuration of loglevels by exposing only the controls
  that are necessary and relevant.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 Documentation/admin-guide/sysctl/kernel.rst |  3 +++
 kernel/printk/sysctl.c                      | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 8019779b27f6..6027f0057ea3 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1061,6 +1061,9 @@ Messages without an explicit priority will be printed with this priority.
 printk
 ======
 
+This sysctl is deprecated and will be removed in future. Please consider using
+``kernel.console_loglevel`` or ``kernel.default_message_loglevel`` instead.
+
 The four values in printk denote: ``console_loglevel``,
 ``default_message_loglevel``, ``minimum_console_loglevel`` and
 ``default_console_loglevel`` respectively.
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index 3bce8b89dacc..42f9e94b1e47 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -7,6 +7,7 @@
 #include <linux/printk.h>
 #include <linux/capability.h>
 #include <linux/ratelimit.h>
+#include <linux/console.h>
 #include "internal.h"
 
 static const int ten_thousand = 10000;
@@ -46,13 +47,24 @@ static int printk_console_loglevel(const struct ctl_table *table, int write,
 	return 0;
 }
 
+static int printk_sysctl_deprecated(const struct ctl_table *table, int write,
+				    void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int res = proc_dointvec(table, write, buffer, lenp, ppos);
+
+	if (write)
+		pr_warn_once("printk: The kernel.printk sysctl is deprecated. Consider using kernel.console_loglevel or kernel.default_message_loglevel instead.\n");
+
+	return res;
+}
+
 static struct ctl_table printk_sysctls[] = {
 	{
 		.procname	= "printk",
 		.data		= &console_loglevel,
 		.maxlen		= 4*sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= printk_sysctl_deprecated,
 	},
 	{
 		.procname	= "printk_ratelimit",
-- 
2.46.0



Return-Path: <linux-kernel+bounces-385429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBF99B3708
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDCC284242
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783F91E0094;
	Mon, 28 Oct 2024 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="fQM7gfsH"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D941DFE3E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133966; cv=none; b=mKP9T0n6jbyPUE1bf6IqOt1P60DfFcAW3AzU9MeKoOjqe/U0021P5Vfdmgyuc2WR7m6VPKaSjk/vmM/3XyR6mizNCcjlGEui7vKayR23Jo1udsHH3POVfO7WjuRnUgpKQm6gP1xPO8dpyAbUZvnxSglxXjv11v/vR2cCoXpAwfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133966; c=relaxed/simple;
	bh=MIAjzwi4cO1uwoYcl3/hokrXBrQxGA0D5qMxMRZRFkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToGKcWLsOS7fj5AemEOxzQCf3aiMOJbOSd8gOvAm+hnDeSC/vDllTkIAutgXhx1KxRX4PFpMwAP+nIRohcMXaEmBSw0x267bT13zOrFk4szeSYitQ9+Mf88Q6goGgFLX2+9i0gIO9syaIPZ1QXzHAjFuFrscsOBO8lU23Bv2xA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=fQM7gfsH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4314c452180so38208345e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1730133963; x=1730738763; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe3DceTPULKpPQyU6tk9aCv8FZUAKvYc33ASTgoizb4=;
        b=fQM7gfsH1G4Y8Eht/2eECq5hKnV0RuaD7i1H7O4aZMJF9bUOqXGFbjHMEtmaNTwE5l
         3xnla8wY29XpQZtHnDa2lIEK5d7RXSKGam+RxizgDeZGZX9kJ7Ae7QYRmE6tumJAYgFQ
         cqwDTh0jUE0MCdyTnsNu6VVkDfgOgyTIr9bi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133963; x=1730738763;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pe3DceTPULKpPQyU6tk9aCv8FZUAKvYc33ASTgoizb4=;
        b=SVZ0JlRIFWCHwPHm6CpN74OUisRp5IXSpS2QHzVB+1V1CKx0n0LcI3MAkYxA6127z7
         5bIEL2uAbvprUeVPRZMD2G5S3Prpyfm0JPq+DatHRFtdsAJm6wbFVjBPIu9dWnFHpEOA
         xM5jaoiXbqhDP8BRYPbPbquSAaVkbp79we2cRGCBKRj1BWGE226IwxXGTtFkMx6Qq913
         Sll27nVAFk7leA9v10pcd0G2uULa+c5dnKIp8ie7fNWBCxpA/YzDOlOtL2QlW4ovlZim
         xoVFNhnF3GEjpnbMrdqQ6GePlQckpJyP4f/HTcOjDiJldLpd+ldte1K4SNoD+RfnTFHt
         t6GA==
X-Gm-Message-State: AOJu0Yx/2TEOEFGH4qcaAOUJwILgJ2808+I7nV8IbPvFbEBW4kcRw7MO
	jLfZS/5WGw136JTHifpObpiSGotpTQpC8MtMVitmbQUoUcfPQnMIhrrovozxMb4=
X-Google-Smtp-Source: AGHT+IE0HPKAnm5+enrIloZNvuHS6g3fAvcHJ7RVCpchNz8MLfx2eafTU9darqIcPaMWZv2UPbwrdQ==
X-Received: by 2002:a5d:44cc:0:b0:37d:4660:c027 with SMTP id ffacd0b85a97d-3808142da47mr192382f8f.24.1730133962866;
        Mon, 28 Oct 2024 09:46:02 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193594fe7sm114820565e9.14.2024.10.28.09.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:46:02 -0700 (PDT)
Date: Mon, 28 Oct 2024 16:46:01 +0000
From: Chris Down <chris@chrisdown.name>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: [PATCH v6 11/11] printk: Purge default_console_loglevel
Message-ID: <3326b5ea5d95bd580c6e4dea9f5703d83e3f913a.1730133890.git.chris@chrisdown.name>
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

default_console_loglevel (then DEFAULT_LOGLEVEL) was created in Linux
0.99.13 (September 1993) to power what we now call
SYSLOG_ACTION_CONSOLE_{ON,OFF}. It was originally hardcoded to 7.

In Linux 2.3.12 (March 1997), Chris Horn made it configurable by sysctl
through kernel.printk.

Its demise came about in July 2009 in commit 1aaad49e856c ("printk:
Restore previous console_loglevel when re-enabling logging"), which
replaces default_console_loglevel with the previously used
console_loglevel. However, the documentation was never updated, and we
still kept on telling users that this sets the default value for
console_loglevel, even though this hasn't been true for over 15 years.

Purge both the documentation and all remaining references to
default_console_loglevel. It will still be initialised in the sysctl
array.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 Documentation/admin-guide/sysctl/kernel.rst | 5 ++---
 include/linux/printk.h                      | 1 -
 kernel/printk/printk.c                      | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 6027f0057ea3..e1b5124ab383 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1065,8 +1065,8 @@ This sysctl is deprecated and will be removed in future. Please consider using
 ``kernel.console_loglevel`` or ``kernel.default_message_loglevel`` instead.
 
 The four values in printk denote: ``console_loglevel``,
-``default_message_loglevel``, ``minimum_console_loglevel`` and
-``default_console_loglevel`` respectively.
+``default_message_loglevel``, ``minimum_console_loglevel`` and an unused legacy
+value respectively.
 
 These values influence printk() behavior when printing or
 logging error messages.
@@ -1078,7 +1078,6 @@ default_message_loglevel messages without an explicit priority
                          will be printed with this priority
 minimum_console_loglevel minimum (highest) value to which
                          console_loglevel can be set
-default_console_loglevel default value for console_loglevel
 ======================== =====================================
 
 
diff --git a/include/linux/printk.h b/include/linux/printk.h
index b7e8411e033d..41ce323b4e77 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -71,7 +71,6 @@ extern int console_printk[];
 #define console_loglevel (console_printk[0])
 #define default_message_loglevel (console_printk[1])
 #define minimum_console_loglevel (console_printk[2])
-#define default_console_loglevel (console_printk[3])
 
 extern bool ignore_per_console_loglevel;
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c47dda23a7d6..018087b57031 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -65,7 +65,7 @@ int console_printk[4] = {
 	CONSOLE_LOGLEVEL_DEFAULT,	/* console_loglevel */
 	MESSAGE_LOGLEVEL_DEFAULT,	/* default_message_loglevel */
 	CONSOLE_LOGLEVEL_MIN,		/* minimum_console_loglevel */
-	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
+	/* legacy default console loglevel, unused */
 };
 EXPORT_SYMBOL_GPL(console_printk);
 
-- 
2.46.0



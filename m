Return-Path: <linux-kernel+bounces-385425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDB99B3703
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B011F24816
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608381DFD9D;
	Mon, 28 Oct 2024 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="VXMnEqtb"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D7C1DFD91
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133953; cv=none; b=J4L2pwkTVou95hxe3zQ3sOhHdSnBsdzkU2cLqUIdPlQAchr3wyE/r1VDK6re7jISNbm8WshBGmbdXNKbIYKWTK4s46bXYXyOScXq0D8UwQ83WagpaaIuoMUY1UJF35i7bAzJzSsbwaYZb+v5ZU/mlGNG1dg/muhjNIRKylkaBlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133953; c=relaxed/simple;
	bh=Vmt82dwaOjFT6uTwz3tL39RVhl65BBmX7ghox9IjL+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTi8koCJvRlZvTSMy8mL7lWt5iMhvtDUo5G9A69gP9/blUmOXtHa/JSlX4WJq3DNGrLGto+gYgf3fFAgIR5YqG00O1tsslW2yIKHZaKlLCngaM5HkARVDfkA3ysEkO9TPR1gq1EtO3cbWHmkCrMykJVJjqE3ZTB63hVsRxFkmQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=VXMnEqtb; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so5987050e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1730133950; x=1730738750; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLkfA7TIE3/EUT1Ui9HqWC+wbqjWNmJFUMwyewiF4NA=;
        b=VXMnEqtbERrYDcpJWsAvv7cd+NVBPAjQ6g8hVbHB49v5nw6OynJXMZlQwmd1AjANGO
         in+zXXIHJdMmO91VAGyK3zG7Ti37jWHig1qTPsoK8FItMELW0gbNObo8/qysyrmpm7GL
         7Oxlv5onExKNJWea5Cbzl5cuPzHs3zQIXYgO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133950; x=1730738750;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLkfA7TIE3/EUT1Ui9HqWC+wbqjWNmJFUMwyewiF4NA=;
        b=Wl6SIfZyOwBrnYbC/d0uW44+rlOJJ/oztb8HslUQEOo7/n9oNMBEQanM1Pbi6pp5mw
         yfFtMwbrQan3AChtrYKOIkKD8G2nICflLNm9bVCzeTMT9vfb2zTOjo7hFx+IsA7C2Tqy
         ax3JfTUaX0smMKYyKzuGn8uHEk4bHtm83+WadxLZQgDH1Jiexu9g9vED8NPHtv8UNinn
         eMrYm/GhvxJWMBOjWADXl3LBkZdWQ+/0ZkdkFth5ixmVfRTrIB0O9IYITs82kxxOnU8/
         FFuK72Y9xp+8vKXZBBIQ+SRA/lNgf6srYCPWfIp8o9o7nn/8G0bAjyCNvuIydvRk6C1F
         gMjA==
X-Gm-Message-State: AOJu0YzEM77LphAeGtVCcDV0QbR933wlXEydIwipYQCI241CVYxGuNC8
	sR/tR3ykYxiZU4VEgOfV+qOTKYFs9Mrw0z3r4Lh5tsSY/VIDty1vvk3Nupm2UXQ=
X-Google-Smtp-Source: AGHT+IHXkIqu82alCxKsn+FjVpdMLj7nsam7bAPuN2BNkxCv+ZuZYKCCNGkZ28Yyml9WXbJLfQDFlw==
X-Received: by 2002:a05:6512:3407:b0:539:f67b:b849 with SMTP id 2adb3069b0e04-53b34c8b7e4mr3729760e87.49.1730133949583;
        Mon, 28 Oct 2024 09:45:49 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b567e23sm144787645e9.25.2024.10.28.09.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:45:49 -0700 (PDT)
Date: Mon, 28 Oct 2024 16:45:48 +0000
From: Chris Down <chris@chrisdown.name>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: [PATCH v6 07/11] printk: Constrain hardware-addressed console checks
 to name position
Message-ID: <507dee05e622cc37418b23e5de96b6b449410414.1730133890.git.chris@chrisdown.name>
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

Commit 7640f1a44eba ("printk: Add
match_devname_and_update_preferred_console()") adds support for
DEVNAME:n:n style console= registration. It determines whether or not
this is a hardware-addressed console by looking at whether the console=
string has a colon in it. However, this interferes with loglevel:n and
potentially other future named options, which also make use of the
character.

In order to avoid this, only search positions before options.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 kernel/printk/printk.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index bc456f7624d4..bbd037b84a0d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2670,6 +2670,7 @@ static int __init console_setup(char *str)
 	char *devname = NULL;
 	char *options;
 	char *s;
+	char *first_delim;
 	int idx;
 
 	/*
@@ -2685,8 +2686,13 @@ static int __init console_setup(char *str)
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
 
-	/* For a DEVNAME:0.0 style console the character device is unknown early */
-	if (strchr(str, ':'))
+	/*
+	 * For a DEVNAME:0.0 style console the character device is unknown
+	 * early. We must restrict this to before any comma to avoid interfering
+	 * with named options, like "loglevel".
+	 */
+	first_delim = strpbrk(str, ":,");
+	if (first_delim && *first_delim == ':')
 		devname = buf;
 	else
 		ttyname = buf;
-- 
2.46.0



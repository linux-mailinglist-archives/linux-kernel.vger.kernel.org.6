Return-Path: <linux-kernel+bounces-385418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B069B36FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A4E2812D8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19D81DF25A;
	Mon, 28 Oct 2024 16:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="V1hIQwYS"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C8C1DEFC7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133937; cv=none; b=Ju7zeOy1ImllElt6E4lLJDFTGzO/HY8/Xia0wt6QRZ/G6M2jYLZHEqI7HpwW+1b8hD9apRbFLOFUO87WCdhCqhT5997ZA9fitlFFZ0QilQ+BxbVeuXRP/gUQoCdF417gWw+8l/yi3hUhHoFtPxS2tw7Q3r34l5uzG1vXZ+QVqvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133937; c=relaxed/simple;
	bh=ql6Bn+2gNBB4Xey5j1lc75dwIYP+yNqE+DHlZx8kWvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDnk0fzrP08Z1+SZ6h7VTZsILkeGrexNk+5J+KtyAfpWbw46+bNPQorApqLfYmT7nrSWlhxmnn90qWb6IZBKBy70Dkr7vqml0Y8zIHsL+zFWrZ5T+bnAH8zvaVISEbgB5v/kCN3Yr7d/pcs6ysO8uuY3UBDyD52xFJI/dSXI/V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=V1hIQwYS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso60756755e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1730133933; x=1730738733; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlHE1AXmr5UIRTY0JExgFknW+MYNUuiW66lPp7YixPs=;
        b=V1hIQwYSSR2yFmvKh9kjuH9SbCloUts8B0gpDGfnD3C2OK0r6YmsjaL0nSIHqsj8fi
         VpA1CfyRu8/znE4tFy4u3GbPPF96xyOivnVOB5VfAbsRN5QxTE++POfdc09HHk8yEhBK
         RClAzDSmeK3K3kJ8FjpwHx2xiWjBM/GXMQCcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133933; x=1730738733;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlHE1AXmr5UIRTY0JExgFknW+MYNUuiW66lPp7YixPs=;
        b=rf5tioWWnhayDYZ2SkI8ksYsBJOy3A+nIqE5NFhLei8jT2Rbr3XByTz7IPkJARHb8K
         UNJGI99JDdMR7cT+x0iCIWEIRWN4oJHMAMVklnehs0CD/kHBgrygdkNdvVjtPo61EtDf
         4CCRsBFCXx13082yzMcJF1cOShZ6m5DF/Aljpa0b39eZbe7jZLQU7cOE1kqNQT4zlCiC
         f/PSNulOQMxnMx9PcXP6CSHve16kZVgA5RF0iBpCnTUoIyHSwAt4yfn9YqEUOv7GlqpI
         RWwAZxUFBdb+5LQyedpGf2eK+SwYKXGDFCSqO3fs0+HkNSx8UBQOl+bkhBepXsurtPG5
         mdCg==
X-Gm-Message-State: AOJu0YwlUh2eHlgDdnjvxfyAEieoLpa5O8kV5exJ7G0J1VNOF6Ue9JvF
	SkreSsYk/BdtpR/4FC8FwH6+ggFEfqYH38n+QGOv1T1CBD5bBdcLHhRKKZa9xq2wzF9PUm3h8sX
	C
X-Google-Smtp-Source: AGHT+IGrkFPUAi8YEMClr0kIws83LbibtyvRs15RoDLA0esCvnhiOPzpA4qVR0QvhXFABdyG0U/MgA==
X-Received: by 2002:a05:6000:b11:b0:37d:4376:6e1d with SMTP id ffacd0b85a97d-38061227b35mr8505267f8f.41.1730133932891;
        Mon, 28 Oct 2024 09:45:32 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b13223sm10001678f8f.1.2024.10.28.09.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 09:45:32 -0700 (PDT)
Date: Mon, 28 Oct 2024 16:45:31 +0000
From: Chris Down <chris@chrisdown.name>
To: Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: [PATCH v6 01/11] printk: Avoid delaying messages that aren't
 solicited by any console
Message-ID: <023621f3c477d6246e27d11b78ae28a2bcb47e8d.1730133890.git.chris@chrisdown.name>
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

printk_delay() may introduce delays even when no console wants to emit
the message, which is unnecessary and may hold back messages we actually
care about. Add a check in printk_delay() to determine if any console
will print the message to avoid introducing unnecessary delays. This
change aligns with the existing behaviour of boot-delayed printk
messages, which already have a similar check.

Signed-off-by: Chris Down <chris@chrisdown.name>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index beb808f4c367..d6159f1c5b29 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1315,15 +1315,13 @@ static int __init boot_delay_setup(char *str)
 }
 early_param("boot_delay", boot_delay_setup);
 
-static void boot_delay_msec(int level)
+static void boot_delay_msec(void)
 {
 	unsigned long long k;
 	unsigned long timeout;
 
-	if ((boot_delay == 0 || system_state >= SYSTEM_RUNNING)
-		|| suppress_message_printing(level)) {
+	if (boot_delay == 0 || system_state >= SYSTEM_RUNNING)
 		return;
-	}
 
 	k = (unsigned long long)loops_per_msec * boot_delay;
 
@@ -1342,7 +1340,7 @@ static void boot_delay_msec(int level)
 	}
 }
 #else
-static inline void boot_delay_msec(int level)
+static inline void boot_delay_msec(void)
 {
 }
 #endif
@@ -2124,7 +2122,10 @@ int printk_delay_msec __read_mostly;
 
 static inline void printk_delay(int level)
 {
-	boot_delay_msec(level);
+	if (suppress_message_printing(level))
+		return;
+
+	boot_delay_msec();
 
 	if (unlikely(printk_delay_msec)) {
 		int m = printk_delay_msec;
-- 
2.46.0



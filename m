Return-Path: <linux-kernel+bounces-271529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7045944F89
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43400B23264
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E471B32A6;
	Thu,  1 Aug 2024 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJSM2zF9"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8542049
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722527049; cv=none; b=c2z1FyffzQ3cPyA/PX3OJ0DmKJaU8xIDHThj+2wL9SY69LjqZTobOwiRcvieYWVprPTftU18zlCs5i+AVFHjQOYvuLwAZTr3jSGihFuQHtIWC/Q7+ISVcNzq4Cl79+YDS0y4aQsqrvL7xMI/P/3AfppFGiWEUL1CqKowWNYe428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722527049; c=relaxed/simple;
	bh=EcuGzQjHqLusS/+dbwysQI+pN2qNFegADwsOUs4X2Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VGtikmXX7PDsOGhs/SIMu8U6E5z0xHktemoTa2JOVs4kAbrf9OnYVkQcsgilvtWqJl3KmRpEttRUQMlwP0K4A+LYsKOp6VjSF3wjZv/cswRLx3DwdWgcvPJ9Sq05OtdnTWOpPQBsH6DpJ1xKEAfBZmDSuF4RrhRmUhnklqtAncs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tJSM2zF9; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3db19caec60so5082956b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722527046; x=1723131846; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8xU+FFSwrHLbWLoH1Gr7i4p7NxAzK8Rk95/w5Fli7M=;
        b=tJSM2zF9f6dtlauf4+Rr5AnYKIm2MMzVsIujSdSreJeWXOKAPrangAIIfULlH9kPvI
         OdO3y80jqA0Fjv3aL/YDvHERco4izuT0qpkcMcWe5ttSckcQ8h2CepmSVJPk0ONK/Piz
         zmuj16Ny5JDSvgPn6GYtsFSISZIFj4nrpYFFEmKjUvYvlAgh0MSv6KxKTqA8vpTl0BpL
         5ECZ1+1s6wOJ2oYCNCrfbTNAkJdGj3lyq0pbzmLtHFulYK1SUL3NFJe/UmT6/zVlastv
         hmMiGXyxKohpJ4E0TZiFMs5AmiXLyc30AeK6PZJCvrHtwapbiBe7bQeyJtaCN97Y06u+
         0GGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722527046; x=1723131846;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8xU+FFSwrHLbWLoH1Gr7i4p7NxAzK8Rk95/w5Fli7M=;
        b=umxWrworBzf9Ua4cvqvB0dkworPrau8EB41VmU+EX+XKzrc0xF9q5Au8uN42N3fb9Q
         7BmhS4uwgCwONtpzQZuArwtMh+2zzlnT3gTqEH29EKUjqpFWvIfyZ5obGXiv7+hSuNT+
         DgysEn97DTiOVN9l8S4rLbrPNu0eazmZlGnwtpc5Q+shyuArjoPGcVu6VY2D7Tnzjhwe
         CzoMuhNDkYwDc+pM68SaWBrf73SrtWxeN1PraUyH7e7an6VBuYz6y6oNnqaoO3g52n36
         6wE6FUoN25l4aG2Hhi1zUAlBX1bjmwthD1cEGsoP8IhT0lcZGz24TeDXWpJA8zbsuiSx
         mvJg==
X-Forwarded-Encrypted: i=1; AJvYcCWrGdj1RlIe+2yHi/LlyKGdPHcjpVCqwvPJLDZGsYfY9pbEXfqVwEI8dC0397G6WuGARNARxaEUaaJFMSP5wpudOpr67B52M3QxGDFn
X-Gm-Message-State: AOJu0YyDc/wG/RfvYtkVNOKgbOUwbNUdZ0OJvO41NQqCSbEehjxEyM0Z
	mhJMxFa/Ov8LbtwfnwAx/O6+WY6LxC90Y4jl1F0Fen1dWDMZOde9axgfjLOAA8s=
X-Google-Smtp-Source: AGHT+IGlB+w3sZQqVhX2g0HDrq/6ha3oM3A0N/5uNfNe8H8NLjZA4UoR7LI/7rQUDkMw6oP+vT/drg==
X-Received: by 2002:a05:6808:10c5:b0:3d9:2594:cfb1 with SMTP id 5614622812f47-3db55840a58mr495694b6e.42.1722527046294;
        Thu, 01 Aug 2024 08:44:06 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:93d4:3a5d:300f:67ab])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db41f02be1sm1152848b6e.40.2024.08.01.08.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:44:05 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:44:03 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] sched/debug: Fix fair_server_period_max value
Message-ID: <a936b991-e464-4bdf-94ab-08e25d364986@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code has an integer overflow or sign extension bug which was caught
by gcc-13:

  kernel/sched/debug.c:341:57: error: integer overflow in expression of
  type 'long int' results in '-100663296' [-Werror=overflow]
    341 | static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */

The result is that "fair_server_period_max" is set to 0xfffffffffa000000
(585 years) instead of instead of 0xfa000000 (4 seconds) that was
intended.

Fix this by changing the type to shift from (1 << 22) to (1UL << 22).

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYtE2GAbeqU+AOCffgo2oH0RTJUxU+=Pi3cFn4di_KgBAQ@mail.gmail.com/
Fixes: d741f297bcea ("sched/fair: Fair server interface")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 kernel/sched/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0148bc65d39c..845b79238398 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -338,7 +338,7 @@ enum dl_param {
 	DL_PERIOD,
 };
 
-static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
+static unsigned long fair_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
 static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
 
 static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
-- 
2.43.0



Return-Path: <linux-kernel+bounces-401593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E70EE9C1CB0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9984E1F23C60
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B081E5713;
	Fri,  8 Nov 2024 12:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PWdp1h5Z"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0741E1031
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067913; cv=none; b=TpF+RNq4z0D8UGSuPZBQOkJ+4kV4w9IuVts/9I0Raif78KBxp6fguKLbg8JZyuaXJuFXLQpyivYBzixxTAAkU4ATSF5fBf54QNHUIGILa/rMCYar75dqyGqW4EoOEyUT1J2+dJq8lQb6xvXmBjmjASb5vdFtjnCye96r3vK5l3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067913; c=relaxed/simple;
	bh=kWJ0DEepdEDLXNiXRnM7h04QQ4YIrM5zxBCdJrqoyME=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rpxH3tb9lh1oJ6haiWdd26V6sb2GBOecs5PNPomAxVLg7Io/wT9ig5sYWCfSF+Jc7RrmKBI3AD7UiGzAEPA2pWJqm3KXHGIoXKDaENoqqGI4EPIopgGtU5mJWACgXU6Ho23iav4I31bUNo+ZJQMjxPzxIGaz04nCCHNqM9SimQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ciprietti.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PWdp1h5Z; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ciprietti.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4316e350d6aso14651395e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 04:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731067910; x=1731672710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZCCuctOksN+g0ACutW+mHqSe3tKykXSGfpMAlVsHOvw=;
        b=PWdp1h5Z1Z3iy4rG5aAs9ivb2RNbl0pgRzJI21/jWRb8B87BnfZ7GmfGmxgTyAh4ff
         g6NHHUiePnnTlHppPoeDVK6z/eQ3EkICENFMpevJYgo14ikdSp6JdU3JYSv2PStZN8h4
         dHKmEGkdZ85Bvnk3Zfrq43F42QLC/h/au4IORY+ArLzpF0+JCC960ThppDe+UtQudtQw
         muWmfVOFQ3ihKrWML7SXrz58/WOl8nHcUXs0qf4KwUdaQjF3XFkhTRFh+Ma7C1S53IBw
         SXVLqK/IJIeq0RabwbnkO8n9O+aN2S8rZJc3M8WaQSgvprb5KfUt5ca7MxNnToDJ0Kwc
         to5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731067910; x=1731672710;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZCCuctOksN+g0ACutW+mHqSe3tKykXSGfpMAlVsHOvw=;
        b=j9bOoxUP6gLOuGrOYq18sg3qhMxfjgfAR+eVxiNbzLbcc7Oq0WBhc6Dl+fHq/FiHx0
         WntYoEkGmFRcYozNTi1XcRp40L4NapkyFYmuWgZ1B5vVyV3CrU1pvFA2DBwZIO5t5i02
         pPjmMhYuSuW4Tsq3mAAsabdZ5Se4WAilBmN6VM6C9AvNp1Nz7N7KJSElYs0y4hue7CBL
         0r0q2gnTHeMh7kirNzeqH1JIh0ue16mrMTJLO9MyIsYXO83hYFct2r6NUNq8stLFZCiy
         R6S8Da/X/Jis9nci0lvlL7nFvAVdxFjDuQS4UjWLzvS4CeVZ65gCKxY74BwkjIJZdKqN
         QpRA==
X-Gm-Message-State: AOJu0YwUm1z6QMiK++RMQ4nliHaefyhH2r5VG5tkIieg4nXX5PO0xmRR
	RXip3ra0ukB1kAPmjgqY19KhAhyxl9clU83yGvuG6CqcL+e/u4mkTB9Akt98fxLHg58R4ezRkn8
	A0zrJxCRsjUuJKcRkTsdbKbvZ+mFWNlCjgzzbN7DyRcWX9Km2Gyd73wDfEUS3Z5d5V2ek7CEqOl
	ubx9bwlBcVmOrBHsX1RSpNZREgKkpuiwcndE4WuRK1r9qdGKAH913x/w0T
X-Google-Smtp-Source: AGHT+IGYoutF8zZp5qp+BDEkaAp1zoCMP3TID3nPDMK6WM1N6Af1gNVPcyXlyt0bZqLKXb8sqzIi2AzSQi9YlaI=
X-Received: from ciprietti.c.googlers.com ([fda3:e722:ac3:cc00:ee:a3ee:ac1c:78f4])
 (user=ciprietti job=sendgmr) by 2002:a5d:4f84:0:b0:37d:31a7:6610 with SMTP id
 ffacd0b85a97d-381f182787amr1753f8f.0.1731067910109; Fri, 08 Nov 2024 04:11:50
 -0800 (PST)
Date: Fri,  8 Nov 2024 12:11:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108121120.3912918-1-ciprietti@google.com>
Subject: [PATCH] sched/smt: Call sched_core_cpu_deactivate() after error is handled
From: Andrea Ciprietti <ciprietti@google.com>
To: linux-kernel@vger.kernel.org
Cc: Andrea Ciprietti <ciprietti@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"

In sched_cpu_deactivate(), the error path restores most of the initial
state before returning, but, if CONFIG_SCHED_SMT is defined, it does not
undo the previous call to sched_core_cpu_deactivate().

There is no easy way to invert such function since it overrides some shared
state of the leader CPU. Instead, simply move the call past the error
handling code. This is fine since cpuset_cpu_inactive() performs unrelated
operations.

Note that there's no need for #ifdef since cpuset_core_* have empty
definitions when CONFIG_SCHED_SMT is not set (in which case this patch is a
no-op).

Fixes: 3c474b3239f1 ("sched: Fix Core-wide rq->lock for uninitialized CPUs")
Cc: stable@kernel.org
Suggested-by: Josh Don <joshdon@google.com>
Signed-off-by: Andrea Ciprietti <ciprietti@google.com>
---
 kernel/sched/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 719e0ed1e976..4d55bc243ae5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8187,10 +8187,6 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 */
 	sched_smt_present_dec(cpu);
 
-#ifdef CONFIG_SCHED_SMT
-	sched_core_cpu_deactivate(cpu);
-#endif
-
 	if (!sched_smp_initialized)
 		return 0;
 
@@ -8204,6 +8200,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 		sched_update_numa(cpu, true);
 		return ret;
 	}
+	sched_core_cpu_deactivate(cpu);
 	sched_domains_numa_masks_clear(cpu);
 	return 0;
 }
-- 
2.47.0.277.g8800431eea-goog



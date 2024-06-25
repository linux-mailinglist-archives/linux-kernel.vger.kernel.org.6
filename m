Return-Path: <linux-kernel+bounces-228751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF117916665
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C851F249B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12441527A9;
	Tue, 25 Jun 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9YMl1Pa"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB4152503
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315789; cv=none; b=NcyzjrXe3II+Uj3wkAiu1xPajKJOuvPUQalT/Re/BmP7gaflFvb1kMLFJYn3i6vCmEwzeVfBzecCF1mb67knG83ux3B841aIzVwvculB7dli4e+prV9Wd3lO74KgYgZUO1UJoOecJbsv4eHpFKenm5h35ooRSdNXS7ZsQYKM7Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315789; c=relaxed/simple;
	bh=pG7PEDJSU75AngYJXfFf1+5rP+FYTqtYQqM1uU+9lqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5PWkxi/6l9cz1Fy9MbEhfmtjAkKWhvzBigjYKvd2NdO599gIqffiXbn9Y3JZphBy381vJvuRboaX46Tq6l7HqKNbVXUpuct8LPeavfKsRaXzzPO6jXEVT8kod6lULOJB5ZeqPz7y2MLHMMLgH1L5ojBml5nxq4bdaK0J0hnVow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9YMl1Pa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fa0f143b85so21519795ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719315787; x=1719920587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHkqx3Vf/PXoicoAHPo0Hgl41Wb+/6pWvOIAvWHYmAs=;
        b=B9YMl1Paw3iqDT72mT13l0EZhuIjwsijw9L/6GBytraep5whFpC53NC+evFMCHFvLD
         Ue5tCzdSgvtCd87JtjU/8itCJSKGorc5tUirPJJmVRMEbTXnUo+RUFLc12M66U/1D8Os
         j0TavQi3lTpwZjePvI5MfYeUDRdQsNhxUKTAtgAHcoH2iMvaO7ExctAGsN7rLC2J6rRp
         dKpW3TzjxQrfbj/lEazvjGnMDO0wtRkzvPQW/z/jMtKQ8CjrEkCxqdCrqevd2JB7q4rV
         kbbPaNn9beiOtmSm4WwTlOshc9Q7Naur4eFEVxbgxmMNQK0Dbr+qe/R8PlpVP3Be4uMv
         rzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719315787; x=1719920587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHkqx3Vf/PXoicoAHPo0Hgl41Wb+/6pWvOIAvWHYmAs=;
        b=wS2FgguDGPPj0mbddm7Pj3lZvpT/kAunLxgIHrbobl5vRKM5gWtc2bov3okxnBZpdB
         nNESjg7iSTMqcUHYBogwoc0Cc4xj1y4Wx2FjHPyWNyN7ijz9og7/XyZJXLwxROqWF8P9
         J9/KAUYCvY/EhNPLX/PACGG0zsL+X9cYPOiYnRLhKZn+WUG4rl+c1kdS24AwE81EE9/1
         zPQyiz3X7h8Ljmtq3zVjizmc1lLVI3AhPVrwQmcg1AlwQK+lP4o/APlDQuSKkQj3LUog
         xSrsF4THtPW7L4+XJBj0oFQVPyNsaiJmp1MhVaiJ2zqTQTJChyV6OaCVsOIKZfP/Ofb1
         2YLg==
X-Forwarded-Encrypted: i=1; AJvYcCW77FxKtdpWPxTcqKSZe2tq0qPBq/lxhQPRcAR/AYUZXyXjClo4MvDRdF+WhlBCRKD4twXwUOK9PBFfA57BiPsgG1zVTfO532+fOpTB
X-Gm-Message-State: AOJu0YwG7Nd6n1n9Cke5eP25MajFYrj1GxnEdJGguG9S1HZsEYOlJnC0
	noqpovAd9Y3z2z4F1ZP5N7lpz9kBwqa3mCoNxVGtsaqgDjnd7AxO/Q+gNw==
X-Google-Smtp-Source: AGHT+IFakaFvbd8m6nAAdYcQDtL565vvVWPg14fBYfm3KsXgtMR3piv2WKOl+/9xipGtKuUAjESGgA==
X-Received: by 2002:a17:902:c40e:b0:1fa:2401:be7d with SMTP id d9443c01a7336-1fa2401befcmr83336905ad.8.1719315786990;
        Tue, 25 Jun 2024 04:43:06 -0700 (PDT)
Received: from wheely.local0.net (118-211-5-80.tpgi.com.au. [118.211.5.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f028asm79638525ad.3.2024.06.25.04.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 04:43:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] workqueue: Improve scalability of workqueue watchdog touch
Date: Tue, 25 Jun 2024 21:42:45 +1000
Message-ID: <20240625114249.289014-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240625114249.289014-1-npiggin@gmail.com>
References: <20240625114249.289014-1-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a ~2000 CPU powerpc system, hard lockups have been observed in the
workqueue code when stop_machine runs (in this case due to CPU hotplug).
This is due to lots of CPUs spinning in multi_cpu_stop, calling
touch_nmi_watchdog() which ends up calling wq_watchdog_touch().
wq_watchdog_touch() writes to the global variable wq_watchdog_touched,
and that can find itself in the same cacheline as other important
workqueue data, which slows down operations to the point of lockups.

In the case of the following abridged trace, worker_pool_idr was in
the hot line, causing the lockups to always appear at idr_find.

  watchdog: CPU 1125 self-detected hard LOCKUP @ idr_find
  Call Trace:
  get_work_pool
  __queue_work
  call_timer_fn
  run_timer_softirq
  __do_softirq
  do_softirq_own_stack
  irq_exit
  timer_interrupt
  decrementer_common_virt
  * interrupt: 900 (timer) at multi_cpu_stop
  multi_cpu_stop
  cpu_stopper_thread
  smpboot_thread_fn
  kthread

Fix this by having wq_watchdog_touch() only write to the line if the
last time a touch was recorded exceeds 1/4 of the watchdog threshold.

Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/workqueue.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0954b778b315..f60886782f31 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7560,12 +7560,18 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 
 notrace void wq_watchdog_touch(int cpu)
 {
+	unsigned long thresh = READ_ONCE(wq_watchdog_thresh) * HZ;
+	unsigned long touch_ts = READ_ONCE(wq_watchdog_touched);
+	unsigned long now = jiffies;
+
 	if (cpu >= 0)
-		per_cpu(wq_watchdog_touched_cpu, cpu) = jiffies;
+		per_cpu(wq_watchdog_touched_cpu, cpu) = now;
 	else
 		WARN_ONCE(1, "%s should be called with valid CPU", __func__);
 
-	wq_watchdog_touched = jiffies;
+	/* Don't unnecessarily store to global cacheline */
+	if (time_after(now, touch_ts + thresh / 4))
+		WRITE_ONCE(wq_watchdog_touched, jiffies);
 }
 
 static void wq_watchdog_set_thresh(unsigned long thresh)
-- 
2.45.1



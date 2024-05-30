Return-Path: <linux-kernel+bounces-195376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361A08D4BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5EB2B21985
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E937E132123;
	Thu, 30 May 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3KB5WVr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2AD18309F
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717072946; cv=none; b=dA9bvSXcElUqSv0QUVtApBXGs72Biz/41v9NxyMQSpGlW3hYkT1xXmp7InllxROf8uDmAqj9jUnifEY6/xkE6g6PCRKb3j47mlpObJ2e95gCTIKAqEA2TZ4wpodT3tiPftRmeKfgbsBkR5T4GR+5Pnz8dkIQLuD/3nU/iLNvRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717072946; c=relaxed/simple;
	bh=UDq5p7N8hM9ghkOXmyXukJe2Fcsshv8WO2RUv36WPVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5ePolCXFBQpgRwonQGgedJXM82UFM6MmPuJ+53WsY5Z5F0om7BQJrO8wsmH8kJQIpcVvR/uiB7OFaegPoBSlMljwMf/P5qhb+HqEeHxaVV/OzzllCExGQFouiQAY+OB56hJOxglOcamxmJV2A90LjmP2KdR5/Af0eNEPPQLAtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b3KB5WVr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717072943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KfFTRNobR6w6r7ulB7ciYohd23NT6TT29URqx7b26wE=;
	b=b3KB5WVreq7CNsty81IJgNKo4SZQ3xqIXj135SLkvgF7NweeDcVq55Xukn9ooVoqlvHkQW
	abmGbKOuMYcoico6HKNvdtrDpx3uG2eGAeORUhFLr8/QHwLzD/xSfgNrY2RjiOA8+vUxsr
	A3MbgDnA7nYKhkHNyaOJnNNu7RkR9jo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-8cajHHd6NdCJDfm7qoPCWg-1; Thu, 30 May 2024 08:42:21 -0400
X-MC-Unique: 8cajHHd6NdCJDfm7qoPCWg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 937898008A4;
	Thu, 30 May 2024 12:42:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.232])
	by smtp.corp.redhat.com (Postfix) with SMTP id 97E66286E;
	Thu, 30 May 2024 12:42:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 30 May 2024 14:40:53 +0200 (CEST)
Date: Thu, 30 May 2024 14:40:50 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tick/nohz_full: turn tick_do_timer_boot_cpu into
 boot_cpu_is_nohz_full
Message-ID: <20240530124032.GA26833@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240528122019.GA28794@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528122019.GA28794@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

We don't need to record the cpu number of the nohz_full boot CPU, a simple
boolean is enough.

We could even kill it along with #ifdef, the "else if" branch could check
tick_nohz_full_cpu(tick_do_timer_cpu) && !tick_nohz_full_cpu(cpu).

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/time/tick-common.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 27d0018c8b05..9829a2cda072 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -49,15 +49,6 @@ ktime_t tick_next_period;
  *    procedure also covers cpu hotplug.
  */
 int tick_do_timer_cpu __read_mostly = TICK_DO_TIMER_BOOT;
-#ifdef CONFIG_NO_HZ_FULL
-/*
- * tick_do_timer_boot_cpu indicates the boot CPU temporarily owns
- * tick_do_timer_cpu and it should be taken over by an eligible secondary
- * when one comes online.
- */
-static int tick_do_timer_boot_cpu __read_mostly = -1;
-#endif
-
 /*
  * Debugging: see timer_list.c
  */
@@ -178,9 +169,13 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
 	}
 }
 
+#ifdef CONFIG_NO_HZ_FULL
 /*
- * Setup the tick device
+ * Iindicates that the boot CPU temporarily owns tick_do_timer_cpu.
  */
+static bool boot_cpu_is_nohz_full __read_mostly;
+#endif
+
 static void tick_setup_device(struct tick_device *td,
 			      struct clock_event_device *newdev, int cpu,
 			      const struct cpumask *cpumask)
@@ -205,12 +200,9 @@ static void tick_setup_device(struct tick_device *td,
 			 * first housekeeping secondary will take do_timer()
 			 * from us.
 			 */
-			if (tick_nohz_full_cpu(cpu))
-				tick_do_timer_boot_cpu = cpu;
-
-		} else if (tick_do_timer_boot_cpu != -1 &&
-						!tick_nohz_full_cpu(cpu)) {
-			tick_do_timer_boot_cpu = -1;
+			boot_cpu_is_nohz_full = tick_nohz_full_cpu(cpu);
+		} else if (boot_cpu_is_nohz_full && !tick_nohz_full_cpu(cpu)) {
+			boot_cpu_is_nohz_full = false;
 			/*
 			 * The boot CPU will stay in periodic (NOHZ disabled)
 			 * mode until clocksource_done_booting() called after
-- 
2.25.1.362.g51ebf55




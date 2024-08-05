Return-Path: <linux-kernel+bounces-274498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797819478DF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5D81F2200B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C701814BF89;
	Mon,  5 Aug 2024 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yLDBa5hI"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB874778C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852089; cv=none; b=TvjlFlGk9PMxcXXfNnKZvBEFeB+QqLN0rClQEXPIfD1L2LoWi3eVY/CovoFeOYylBdlB+C/tQORH6JqBHu/eZ+j7nI570Tw+OvoDH2UAW0d5Hzo0zik71YhGIJVuArn5TaZ4PhdtQVbPa/8YY5kEWOB88YuJTWw7Na2SxK2jl3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852089; c=relaxed/simple;
	bh=nDy3wET1bCrkFT9iQ5VxEJgX/xfWjHSf/fpyha5vlZM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L7y7usaY+dJqZm7amHKmbuvloDzlpAgnsRYuWq8yiP2jCV3ZPTeNyUw7yylO4tUwFTsajrHmd0bqMJD9HEwtissJ8JhJqClCw54XINFl0x7nZVWirbbkWbNn+NNH0NR0ujrzyj+n+2SgMK4IoHilC5MUyy5FK/RSD1n6ddaXa1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yLDBa5hI; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 475A1FV1079818;
	Mon, 5 Aug 2024 05:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722852075;
	bh=vJztHsiJZCnPEht6eUErnMsmsKgP+ehLpT5NqXqbgOQ=;
	h=From:To:CC:Subject:Date;
	b=yLDBa5hINB6utIf6sk1IWR0VfYEEH73TLO6hWsamBLzHoc4kupAu8BfcU1ugwWgDR
	 7eeQuf+fNd2xLK6r0VpR+EBvuj0yCX4fde1b6mv2/jjFi9Xi3pZGfjQXUglUyeUVxD
	 Y6PWFHMRT06UPFfFYlR0NGOMHDNtDsLRVDisr6L4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 475A1FS8085899
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Aug 2024 05:01:15 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Aug 2024 05:01:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Aug 2024 05:01:15 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 475A1Ckv043875;
	Mon, 5 Aug 2024 05:01:13 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot
	<vincent.guittot@linaro.org>
CC: Steven Rostedt <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        Valentin Schneider <vschneid@redhat.com>, Dhruva Gole <d-gole@ti.com>
Subject: [PATCH] kernel: sched: idle: s/bool/int for done
Date: Mon, 5 Aug 2024 15:30:46 +0530
Message-ID: <20240805100046.425598-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Since it->done takes only 1 or 0 throughout the code it makes sense to
call it a bool variable than int. This will also help improve
readability.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 kernel/sched/idle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index e53e2da04ba4..98eac397d667 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -365,14 +365,14 @@ bool cpu_in_idle(unsigned long pc)
 
 struct idle_timer {
 	struct hrtimer timer;
-	int done;
+	bool done;
 };
 
 static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 {
 	struct idle_timer *it = container_of(timer, struct idle_timer, timer);
 
-	WRITE_ONCE(it->done, 1);
+	WRITE_ONCE(it->done, true);
 	set_tsk_need_resched(current);
 
 	return HRTIMER_NORESTART;
@@ -398,7 +398,7 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 	current->flags |= PF_IDLE;
 	cpuidle_use_deepest_state(latency_ns);
 
-	it.done = 0;
+	it.done = false;
 	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	it.timer.function = idle_inject_timer_fn;
 	hrtimer_start(&it.timer, ns_to_ktime(duration_ns),

base-commit: d6dbc9f56c3a70e915625b6f1887882c23dc5c91
-- 
2.34.1



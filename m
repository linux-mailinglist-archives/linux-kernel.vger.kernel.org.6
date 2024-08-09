Return-Path: <linux-kernel+bounces-280380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D9694C9CD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF5F1F241D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E927A16C6AA;
	Fri,  9 Aug 2024 05:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fngC3nO0"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA162564
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 05:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723182431; cv=none; b=N9wy9eCm9B7twAPJiIZP5nbQZXpltdKZGquI6xXPn1v9lgzqZbtRmzgQQdf0v7nycxNfWrHPicZdiMPF0/buootOfDqOy5VVeDukXCMrIhV36kQxjEFwKsGzIsbyJ1PHT1zUSPABCQ7e9x8kjUm35pX2t4tIIYFVZXZX84/E8Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723182431; c=relaxed/simple;
	bh=GfvIK5UBzCDhYqJiwio2zXfcQXCwAi/cWWbG06EnJak=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FsVwchQC0LlVhqfz0UJ1TtPDoiZD9KYcDwQIGKniDm9D+jiMNN5nO9idSiIp5BlgCnShLw+d34igUJdvz2NlvVjO54pPPlJMYyqA49AqPMPxDC3r7meYT4h7djnFWGVWdXRwlHK2jvXtR09OLtaX1x1S+Eoiuo8dlCJLOFU3Pck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fngC3nO0; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4795knBp083282;
	Fri, 9 Aug 2024 00:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723182409;
	bh=LDaf9m5udums6p3yjcCkDBMTFmKAlc6s/+RJ4+TMm9M=;
	h=From:To:CC:Subject:Date;
	b=fngC3nO0W+0DD84TU/4IcJ70U/rTfIGgIyYF9CLU16SIOOZuBfojFcIakOmzuFWcA
	 LwO7AFqh13A1j09CNP/eexH2GRqqRSO1lmaD8w0i2GxcDvhPjMXDFUmCroTgSBb024
	 sK6I/igh8aRXKJzejOclaE/CnUH/yYSb90U5k/20=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4795knCs046761
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Aug 2024 00:46:49 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Aug 2024 00:46:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Aug 2024 00:46:48 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4795kjlW076490;
	Fri, 9 Aug 2024 00:46:46 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot
	<vincent.guittot@linaro.org>
CC: Steven Rostedt <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Kevin Hilman
	<khilman@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Dhruva
 Gole <d-gole@ti.com>
Subject: [PATCH V2] sched: idle: s/int/bool for idle_timer: done
Date: Fri, 9 Aug 2024 11:16:26 +0530
Message-ID: <20240809054626.580532-1-d-gole@ti.com>
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

Changelog:

v1 --> v2:
Fixed $subject as the replace was written reverse.
No logical changes.

Link to v1: https://lore.kernel.org/all/20240805100046.425598-1-d-gole@ti.com/

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

base-commit: 61c01d2e181adfba02fe09764f9fca1de2be0dbe
-- 
2.34.1



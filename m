Return-Path: <linux-kernel+bounces-199365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260708D860E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98BD281C71
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643D91304B7;
	Mon,  3 Jun 2024 15:30:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58EF1EF1A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428646; cv=none; b=LQoovvryH7HAJuF+5ObcB4/RRClYvGNjfafv7I7tiug/ide5VTPg5xjvTsqK3zDNYhUCrhpNvDTxQfaq/WPNkBNns7cSqhJ9Bxrdx/QTOYG2bnbwAv2Jc4trGmHnA/RMFSbXCgbf+SsEnFKRVvAnW5vL7Q2vV/Nvgrhe0pg5cfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428646; c=relaxed/simple;
	bh=RBLBKM97OJ9PfjLoAidYZRfTjsq8OteewWEsvMvqYP4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dvJi3XjVhQuo5vDybD+6DJ4Et5V3JvY1pCnXLhT1AAQ1vQuOQgouplM8FcJxl/3K4sfhrINWqJBFwGMZWCR+ycwcgQAoFIUDvmT6M5xY1bKAMdjCfo05jDSA/beiwGlqk0zq9uaNutVLK76gtnnC3lY/mVZkJF2W1jxyUJDEWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F41191042;
	Mon,  3 Jun 2024 08:31:06 -0700 (PDT)
Received: from [10.1.30.30] (e127648.arm.com [10.1.30.30])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CF7E3F792;
	Mon,  3 Jun 2024 08:30:41 -0700 (PDT)
Message-ID: <5b936388-47df-4050-9229-6617a6c2bba5@arm.com>
Date: Mon, 3 Jun 2024 16:30:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] idle: Remove stale RCU comment
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The call of rcu_idle_enter() from within cpuidle_idle_call() was
removed in commit 1098582a0f6c ("sched,idle,rcu: Push rcu_idle deeper
into the idle path") which makes the comment out of place.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/idle.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 6135fbe83d68..3cc1a592d9a1 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -179,12 +179,6 @@ static void cpuidle_idle_call(void)
 		return;
 	}
 
-	/*
-	 * The RCU framework needs to be told that we are entering an idle
-	 * section, so no more rcu read side critical sections and one more
-	 * step to the grace period
-	 */
-
 	if (cpuidle_not_available(drv, dev)) {
 		tick_nohz_idle_stop_tick();
 
-- 
2.34.1


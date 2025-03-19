Return-Path: <linux-kernel+bounces-567774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 140C0A68A73
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B43719C7EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBDD254B06;
	Wed, 19 Mar 2025 10:59:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CD9253B48
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381966; cv=none; b=LNshO+zdD2FOgXDfs1chdxCvt10EYLxHzFvEv1KEdTYv7TaXu1l+qfobhweN50q2Sl7rzCCRJOZehjjtb6VKUMI5hLEY3iXgHFUd0ULp0zLRMLEVJKJLqFx0Y1A6k3tL9hEDRQ5wnRAtXxEYgtGtly4R6H3c7NsSo8aMIJ/23B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381966; c=relaxed/simple;
	bh=FwaBLIVUQWvItzmry3zvuSeqFlQ+8PSGsGfAQnwjNy4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Q79SixEqy2f6X9uBQD4xHnMUSUfbNSbw8CCWE2OJersZJEQHNQ63k433kHFK8ItjCWwkBhq6lipbjr+2C0dY7km78fq1GCkGi3QqzTFgydVlbM9FE+H6CeFcI+C8ZiMxaXD6Ue2ZJMJvddAxVPb43apDpE+/wf5OuN6gLlh9VtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69E9D106F;
	Wed, 19 Mar 2025 03:59:31 -0700 (PDT)
Received: from [192.168.3.228] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88A923F63F;
	Wed, 19 Mar 2025 03:59:21 -0700 (PDT)
Message-ID: <ba823a10-3199-4702-8821-03dd88d45212@arm.com>
Date: Wed, 19 Mar 2025 10:59:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] sched/topology: Fix sched_is_eas_possible() prints
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add the missing newline on two failure prints to ensure EAS abort
reasons don't go missing.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c49aea8c1025..18e804b416f5 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -245,7 +245,7 @@ static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
 
 	if (!arch_scale_freq_invariant()) {
 		if (sched_debug()) {
-			pr_info("rd %*pbl: Checking EAS: frequency-invariant load tracking not yet supported",
+			pr_info("rd %*pbl: Checking EAS: frequency-invariant load tracking not yet supported\n",
 				cpumask_pr_args(cpu_mask));
 		}
 		return false;
@@ -256,7 +256,7 @@ static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
 		policy = cpufreq_cpu_get(i);
 		if (!policy) {
 			if (sched_debug()) {
-				pr_info("rd %*pbl: Checking EAS, cpufreq policy not set for CPU: %d",
+				pr_info("rd %*pbl: Checking EAS, cpufreq policy not set for CPU: %d\n",
 					cpumask_pr_args(cpu_mask), i);
 			}
 			return false;
-- 
2.34.1


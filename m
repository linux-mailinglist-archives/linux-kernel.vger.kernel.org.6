Return-Path: <linux-kernel+bounces-449958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A8E9F58C3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91604189765C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA251F9EDC;
	Tue, 17 Dec 2024 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ddoRcP90"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABFE1FA16F
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470473; cv=none; b=Cdv0PmyiVLfZPLGn7eG0z5J+oYSIJBzESSAqQxsO2mcscv746WpIMoI1RvJd8F2pcP0QUF0ITj7h7G9EItvqawkLTFfx22yp2wWlxMUolDQ7458v828wKkLAOg0HWl73oWp120/K04zX/cJim05YsrP0PCuBKz2SSpWeyMEeHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470473; c=relaxed/simple;
	bh=eiwq6RgB8GhHpBYsd2ZpxBy2hA1o6EoqjXwu7pBcIKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MWj4lP2LlN5pJbjqPdX7uZve8D1nCHixmDYpPSzoTPF24SBY1qijbTnLPzFAH6+KKU9my0GiIci9co+WtKixK8n/fgxxQS0dqrXWyoi9xoko/xLJr0+HKppJpT9tbUZ70qGYrp/PjZK3HCl9tFM9zIvWzvnl1V4r+csNar3qDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ddoRcP90; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734470468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9OvSlPazCgFtig4k2fUccNlDviHoE6kU11ttZKdFgo=;
	b=ddoRcP90eOxaD/OLmG314kYYJZdKueqpRMZqLSDK8LApVxf6E0CFffLjN5P7svI4JCuymF
	kCtEx16eZ2XrvMPB/tQdxl6bQjt9AJGodbwK9RcIZcQjvjHt/75D23JxGd6hv26ImJaZLY
	zu0vVyzFpI7uxSBh78RomHXfH+jdE0Y=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mingwei Zhang <mizhang@google.com>,
	Colton Lewis <coltonlewis@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 03/18] drivers/perf: apple_m1: Map generic branch events
Date: Tue, 17 Dec 2024 13:20:33 -0800
Message-Id: <20241217212048.3709204-4-oliver.upton@linux.dev>
In-Reply-To: <20241217212048.3709204-1-oliver.upton@linux.dev>
References: <20241217212048.3709204-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Map the generic perf events for branch prediction stats to the
corresponding hardware events.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 drivers/perf/apple_m1_cpu_pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 2a34523500f8..d6d4ff6da862 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -170,6 +170,8 @@ static const unsigned m1_pmu_perf_map[PERF_COUNT_HW_MAX] = {
 	PERF_MAP_ALL_UNSUPPORTED,
 	[PERF_COUNT_HW_CPU_CYCLES]		= M1_PMU_PERFCTR_CORE_ACTIVE_CYCLE,
 	[PERF_COUNT_HW_INSTRUCTIONS]		= M1_PMU_PERFCTR_INST_ALL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= M1_PMU_PERFCTR_INST_BRANCH,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= M1_PMU_PERFCTR_BRANCH_MISPRED_NONSPEC,
 };
 
 /* sysfs definitions */
-- 
2.39.5



Return-Path: <linux-kernel+bounces-394997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B779BB6EA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9571C225E5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762671C4A25;
	Mon,  4 Nov 2024 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aeMlqisB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F761BBBCA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728618; cv=none; b=W7VlhPa8FgtDEUuICGClesm2FH16fhDJRBJtFaxojCoWWDtQKW1R/gGoeqJ0AzdmiM7PRApAKviyWDdfpgiIzOm9X+gIGX9lxpQQsqlz/szlym0/cIPBWEhwuJqOoYAU2kQ1H2knKJmq9LWYelfpG8EL/m+LvHy/LUBJtJPLfDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728618; c=relaxed/simple;
	bh=k/cG38pmzyjUIZk1609SZCN25ncHk8XKRnc054U+rLI=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BjMBx9pYZcy+Goz62AZG+CZr0Kdxl8/Tk5ZNHplby7VT6md71x/wNrv1qLfDoCajXyg2d+pO8xP2OLav1iLorGMkE133yLoBt3nV6DPCihj2JyMavUzQirwVVvtNiTMlNC4TkrZsMDZRhDvvN/Gda0UZVJ/ShFcMLghOZr12GmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aeMlqisB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=awRwc3C7jyT26FBW24uhR95uNITqcA5r2W8hvYtalrM=; b=aeMlqisBDSkVNZgUhhtzolL9fL
	F/31ppnGzgUp61eZ7e+uU2QncyEpxkIoZzzGjdH1QBaxe0B35UFMHrxkuKAWKbkgB1MM0Y4Qy/oYe
	xcY7elFlwVrfGBDAIudiT5HxAUO3KciiTS4mZ5IbvMRoB4dqwKpNhe5EVtYG+rGdXAjRDfZ7ELJBu
	hkHhHv4fJHtfUVAOCg3zemq3A4tWnxQBWz2jwsG6ycTbT2xJKuE29WE3AIV6Y8bV/S8XOYdC4ijnp
	G+QsC0G2eNnivSs1X9xn4nypN5J76CoLgreOjaoVl/bpXc7LAj4eSHej4Nq7HllA9j4JIjK3lO8yn
	5FUIXMOA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZW-00000001EDp-3Ahk;
	Mon, 04 Nov 2024 13:56:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 56B0D300ABE; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104135517.679556858@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 willy@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com
Subject: [PATCH 02/19] perf: Fix pmus_lock vs pmus_srcu ordering
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Commit a63fbed776c7 ("perf/tracing/cpuhotplug: Fix locking order")
placed pmus_lock inside pmus_srcu, this makes perf_pmu_unregister()
trip lockdep.

Move the locking about such that only pmu_idr and pmus (list) are
modified while holding pmus_lock. This avoids doing synchronize_srcu()
while holding pmus_lock and all is well again.

Fixes: a63fbed776c7 ("perf/tracing/cpuhotplug: Fix locking order")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11836,6 +11836,8 @@ void perf_pmu_unregister(struct pmu *pmu
 {
 	mutex_lock(&pmus_lock);
 	list_del_rcu(&pmu->entry);
+	idr_remove(&pmu_idr, pmu->type);
+	mutex_unlock(&pmus_lock);
 
 	/*
 	 * We dereference the pmu list under both SRCU and regular RCU, so
@@ -11845,7 +11847,6 @@ void perf_pmu_unregister(struct pmu *pmu
 	synchronize_rcu();
 
 	free_percpu(pmu->pmu_disable_count);
-	idr_remove(&pmu_idr, pmu->type);
 	if (pmu_bus_running && pmu->dev && pmu->dev != PMU_NULL_DEV) {
 		if (pmu->nr_addr_filters)
 			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
@@ -11853,7 +11854,6 @@ void perf_pmu_unregister(struct pmu *pmu
 		put_device(pmu->dev);
 	}
 	free_pmu_context(pmu);
-	mutex_unlock(&pmus_lock);
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 




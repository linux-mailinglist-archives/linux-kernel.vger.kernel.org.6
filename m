Return-Path: <linux-kernel+bounces-394994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD2B9BB6E8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D5A282C6D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03841C07F6;
	Mon,  4 Nov 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EzEMbU5r"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78F11632C1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728616; cv=none; b=rKYxD6Km7bmjhMlE5KrMB4Ybu4Jl1ohtI8G+eQFmPWFejmeOffSr7pPdJDB7uk188kgyUDjjf6rbAjZyCRY9SImuYyKm8HjrH1jqPoqzj0AXVjcZ/Tx8opvlblFDyk+V27v+6ShjBTaUmOOdpBA/FpUoNmrlwuGMosZ+J8PtrTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728616; c=relaxed/simple;
	bh=f5dpMh9AhzPjGGmswmBsQrHH1XA3sp2ngO2q5ZzvHoo=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fQR7EhDLbWHxcLFVovCizL2JM1w3RLEm89tMWX02RJ9lpHJ+VPQgWRT+cIa495XLOdAacWGGb2Dh7eimct3SJq8dgjpN4PwXrizr1o61UT+N+2WtWo5I6kBzZBA73z53y/4549cL5PRE01FBpUtKYyNj3IWO5klmVIjNjiQiakc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EzEMbU5r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=mO36VRNVxK68SLi3Hxx0gi8+RzNHKpmki4ffDW+Vt6g=; b=EzEMbU5rD3XDuP+FIT6MqM51QQ
	iLxpGQotwGyZvJMyICj7M9b+UZudFJ1vbMkZX+nYg7NTT8upOiYKOiTbZAI9yGxZnTtBrAJ0qlGdN
	pf05t4T7lmc6NIiz2na1zQti4DPb/NaCqe3YGTYPrQV4jR7CJP7TjZYuBD8h7Fo2OedLIjd20onxH
	SgRPY4J9Xd1HF6THaE4qN9qoCWzTb840Bdyzw1JtCYYuwHJcznAV0BbUBhPlQiS102leNKRLYQB2m
	5TyCYyYH4XRcxBZBN5K8wYyEhLEv8acSLh7LXFqkc3kCcxvKcyKiL3KP79NsHqwY5nkITEqc2p+fC
	vpURNsBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZX-00000001EDt-20mA;
	Mon, 04 Nov 2024 13:56:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 6C01C308CB4; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104135518.302444446@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:16 +0100
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
Subject: [PATCH 07/19] perf: Simplify perf_init_event()
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11942,10 +11942,10 @@ static int perf_try_init_event(struct pm
 static struct pmu *perf_init_event(struct perf_event *event)
 {
 	bool extended_type = false;
-	int idx, type, ret;
 	struct pmu *pmu;
+	int type, ret;
 
-	idx = srcu_read_lock(&pmus_srcu);
+	guard(srcu)(&pmus_srcu);
 
 	/*
 	 * Save original type before calling pmu->event_init() since certain
@@ -11958,7 +11958,7 @@ static struct pmu *perf_init_event(struc
 		pmu = event->parent->pmu;
 		ret = perf_try_init_event(pmu, event);
 		if (!ret)
-			goto unlock;
+			return pmu;
 	}
 
 	/*
@@ -11977,13 +11977,12 @@ static struct pmu *perf_init_event(struc
 	}
 
 again:
-	rcu_read_lock();
-	pmu = idr_find(&pmu_idr, type);
-	rcu_read_unlock();
+	scoped_guard (rcu)
+		pmu = idr_find(&pmu_idr, type);
 	if (pmu) {
 		if (event->attr.type != type && type != PERF_TYPE_RAW &&
 		    !(pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE))
-			goto fail;
+			return ERR_PTR(-ENOENT);
 
 		ret = perf_try_init_event(pmu, event);
 		if (ret == -ENOENT && event->attr.type != type && !extended_type) {
@@ -11992,27 +11991,21 @@ static struct pmu *perf_init_event(struc
 		}
 
 		if (ret)
-			pmu = ERR_PTR(ret);
+			return ERR_PTR(ret);
 
-		goto unlock;
+		return pmu;
 	}
 
 	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
 		ret = perf_try_init_event(pmu, event);
 		if (!ret)
-			goto unlock;
+			return pmu;
 
-		if (ret != -ENOENT) {
-			pmu = ERR_PTR(ret);
-			goto unlock;
-		}
+		if (ret != -ENOENT)
+			return ERR_PTR(ret);
 	}
-fail:
-	pmu = ERR_PTR(-ENOENT);
-unlock:
-	srcu_read_unlock(&pmus_srcu, idx);
 
-	return pmu;
+	return ERR_PTR(-ENOENT);
 }
 
 static void attach_sb_event(struct perf_event *event)




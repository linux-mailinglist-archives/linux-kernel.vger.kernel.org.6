Return-Path: <linux-kernel+bounces-394990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0F39BB6E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E5A3283FBF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F181BC077;
	Mon,  4 Nov 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a137qDa7"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD727DA8C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728614; cv=none; b=aA6YNIm9yeiDBRbVTfm4S3qV3E11ysKNop2iy4QhLZr1yke3aRrXcx4PYG+jI2p0ent4Ou6b5jp0LTs8wIV3NdB9/IAeAInaBm4SFsQtIaNXj3dRwZVK832aO9ju48PdqtWk5374TTuBw/IveKUzBVUW8oDJmxouTMis+JAVCuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728614; c=relaxed/simple;
	bh=AeZhM/tJiHVa4QhSBs3iTgAN3KRu0glOTLTyr6soPK8=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iAXLFy8n8PAMey3ZdMAZUQw53WowrvQMK+DTIttQpfPFCoxuuM7qI+f3KWMRGnTf0N0ENcb+MDcDYo5GaaSBKD8MHZYyxutFkZ6PD+Se+1+gCfWNWX9qyGmMVy4KNcB0Wkb99BaMrfPh3tlPuLXIXQHisFwqDuIwIBwq/vrAMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a137qDa7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=rqt7ldGfsvkJgM5c0RTcP/CKPPdkVrAGzemxz4WCgPU=; b=a137qDa7wS+1Syss2VJNzCYMVi
	I6+Bp0G6zTl6aPWtJcP+WztkBBOzf7Vl3L1b022C0cHWfmGi3JMG6E8IbCSg1oE7aL7gf1rNYbIS2
	TeLuJitRQAc8LklhRtBb4XODhrjlB+qvyoCfnkDnZ0ZnNgXgVEdzFAveMoGNf2eUp+ZeWN4wkyPNH
	Cvmi9ExSMQ3QLS7QNQq7KFb1c+4Lqq4/RX4K6I7XbOafA5Eg84GJJE47zPQGMOOsJVDvNiWyh3Hjh
	ucoRis2ueglx2eKFt9hsrk+jrfgeq65ZhTbJpgrnXITNiopz0tas9z0B2J1aiWY7UnyrhnFj9DF3Z
	g0Hp9Pnw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZX-0000000BL80-1Q0M;
	Mon, 04 Nov 2024 13:56:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 5B1613018AA; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104135517.858805880@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:12 +0100
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
Subject: [PATCH 03/19] perf: Fix perf_pmu_register() vs perf_init_event()
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

There is a fairly obvious race between perf_init_event() doing
idr_find() and perf_pmu_register() doing idr_alloc() with an
incompletely initialized pmu pointer.

Avoid by doing idr_alloc() on a NULL pointer to register the id, and
swizzling the real pmu pointer at the end using idr_replace().

Also making sure to not set pmu members after publishing the pmu, duh.

[ introduce idr_cmpxchg() in order to better handle the idr_replace()
  error case -- if it were to return an unexpected pointer, it will
  already have replaced the value and there is no going back. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11739,6 +11739,21 @@ static int pmu_dev_alloc(struct pmu *pmu
 static struct lock_class_key cpuctx_mutex;
 static struct lock_class_key cpuctx_lock;
 
+static bool idr_cmpxchg(struct idr *idr, unsigned long id, void *old, void *new)
+{
+	void *tmp, *val = idr_find(idr, id);
+
+	if (val != old)
+		return false;
+
+	tmp = idr_replace(idr, new, id);
+	if (IS_ERR(tmp))
+		return false;
+
+	WARN_ON_ONCE(tmp != val);
+	return true;
+}
+
 int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 {
 	int cpu, ret, max = PERF_TYPE_MAX;
@@ -11765,7 +11780,7 @@ int perf_pmu_register(struct pmu *pmu, c
 	if (type >= 0)
 		max = type;
 
-	ret = idr_alloc(&pmu_idr, pmu, max, 0, GFP_KERNEL);
+	ret = idr_alloc(&pmu_idr, NULL, max, 0, GFP_KERNEL);
 	if (ret < 0)
 		goto free_pdc;
 
@@ -11773,6 +11788,7 @@ int perf_pmu_register(struct pmu *pmu, c
 
 	type = ret;
 	pmu->type = type;
+	atomic_set(&pmu->exclusive_cnt, 0);
 
 	if (pmu_bus_running && !pmu->dev) {
 		ret = pmu_dev_alloc(pmu);
@@ -11821,14 +11837,22 @@ int perf_pmu_register(struct pmu *pmu, c
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 
+	/*
+	 * Now that the PMU is complete, make it visible to perf_try_init_event().
+	 */
+	if (!idr_cmpxchg(&pmu_idr, pmu->type, NULL, pmu))
+		goto free_context;
 	list_add_rcu(&pmu->entry, &pmus);
-	atomic_set(&pmu->exclusive_cnt, 0);
+
 	ret = 0;
 unlock:
 	mutex_unlock(&pmus_lock);
 
 	return ret;
 
+free_context:
+	free_percpu(pmu->cpu_pmu_context);
+
 free_dev:
 	if (pmu->dev && pmu->dev != PMU_NULL_DEV) {
 		device_del(pmu->dev);




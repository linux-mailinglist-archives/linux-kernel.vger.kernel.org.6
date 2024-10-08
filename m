Return-Path: <linux-kernel+bounces-355765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6959956BC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335CC1F264EB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC9A21502D;
	Tue,  8 Oct 2024 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOWb547T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E972141D0
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412543; cv=none; b=W+cjHUHNthoqlaYS+zW4uKZD70yOkhftzBDdzTm+J2mMoiNvmfumQaXev9TdAJRnhnyda3ZX3poz3iU0B5f3zqc6B8/W8f+ki8I004eFAZh5MztPSOi16p9xTEFGbJ3AbIOTHGDZ8X9h4lzNxEhLMTWqpr6NurmI4sDiNAFs9FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412543; c=relaxed/simple;
	bh=9NC942Tnu9eotfuiQ8yTEZBW0BsoN3zsxEknTk/dLpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3E7RrGEMvPhhIxMWIPtH0wuHmn3O3UUDai37zbIYLgvzCwaIiRlxi38ebfGF102oZD3tM6v54Ayxfb0RaSWCiKCXMcOu3fNRRF7BKHYgbziLYtCUmp/1KD6Au8c+CtBgoGQWRT3M2GgxFc7RBEtuyRiPpXcoYk4YTKumOqA2HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOWb547T; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728412542; x=1759948542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9NC942Tnu9eotfuiQ8yTEZBW0BsoN3zsxEknTk/dLpA=;
  b=BOWb547TP/V0TvNa2disxv7ByD0NIVvQaI6tQj8RFmlcMnlQhpM5UTA+
   1T1eL7/22i03PwlbvecRFfVoG2xel/6govgohqjPNKjk/6d9tn7TPzJiD
   RDxxVwpq8VO7NYnLHHJADJqG0Vh774jsK1FBJeQQMRbfqlWXlv7B2kHbV
   Z37AtwVlitx1YkuGqx3ndPj3k9+cB/FgA9gcb6RzuRDy5RpfYjVfg7lGG
   1l/7ykaSVmoR8ySThBlEtoYRklC+hsm4t/OhwQBwoeWr4hwXFXSFvvjJj
   iD4baZojPwlhOe0FTR+XlLJL7msiu9+a7qA0SeT99T6ZRQPALCQDlMEmh
   Q==;
X-CSE-ConnectionGUID: qU8ep5+4Tn+tsk2k/oMbLA==
X-CSE-MsgGUID: q5dZcY8VTXyJbvZ2+bdEdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38295365"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="38295365"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 11:35:42 -0700
X-CSE-ConnectionGUID: 1sJW7vDLTn64kfNX0ZMYPg==
X-CSE-MsgGUID: k5K8oGCjTxiFbh0EcnRngQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="80530929"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2.intel.com) ([10.125.110.138])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 11:35:40 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Ian Rogers <irogers@google.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 4/5] perf/dummy_pmu: Tie pmu to device lifecycle
Date: Tue,  8 Oct 2024 13:35:00 -0500
Message-ID: <20241008183501.1354695-5-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008183501.1354695-1-lucas.demarchi@intel.com>
References: <20241008183501.1354695-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to unregister the PMU from perf with active events. When driver is
being accessed perf keeps a reference that when released triggers the
device cleanup.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 kernel/events/dummy_pmu.c | 56 ++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/kernel/events/dummy_pmu.c b/kernel/events/dummy_pmu.c
index cdba3a831e4a..c07e111bff01 100644
--- a/kernel/events/dummy_pmu.c
+++ b/kernel/events/dummy_pmu.c
@@ -49,6 +49,11 @@ static struct dummy_device *pmu_to_device(struct dummy_pmu *pmu)
 	return container_of(pmu, struct dummy_device, pmu);
 }
 
+static struct dummy_pmu *pmu_to_dummy(struct pmu *pmu)
+{
+	return container_of(pmu, struct dummy_pmu, base);
+}
+
 static ssize_t dummy_pmu_events_sysfs_show(struct device *dev,
 					   struct device_attribute *attr,
 					   char *page)
@@ -92,18 +97,9 @@ static const struct attribute_group *attr_groups[] = {
 	NULL,
 };
 
-static void dummy_pmu_event_destroy(struct perf_event *event)
-{
-	struct dummy_pmu *pmu = event_to_pmu(event);
-	struct dummy_device *d = pmu_to_device(pmu);
-
-	kref_put(&d->refcount, device_release);
-}
-
 static int dummy_pmu_event_init(struct perf_event *event)
 {
 	struct dummy_pmu *pmu = event_to_pmu(event);
-	struct dummy_device *d = pmu_to_device(pmu);
 
 	if (!pmu->registered)
 		return -ENODEV;
@@ -121,10 +117,6 @@ static int dummy_pmu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
-	/* Event keeps a ref to maintain PMU allocated, even if it's unregistered */
-	kref_get(&d->refcount);
-	event->destroy = dummy_pmu_event_destroy;
-
 	return 0;
 }
 
@@ -195,10 +187,29 @@ static void dummy_pmu_event_del(struct perf_event *event, int flags)
 	dummy_pmu_event_stop(event, PERF_EF_UPDATE);
 }
 
+static struct pmu *dummy_pmu_get(struct pmu *pmu)
+{
+	struct dummy_device *d = pmu_to_device(pmu_to_dummy(pmu));
+
+	kref_get(&d->refcount);
+
+	return pmu;
+}
+
+static void dummy_pmu_put(struct pmu *pmu)
+{
+	struct dummy_device *d = pmu_to_device(pmu_to_dummy(pmu));
+
+	kref_put(&d->refcount, device_release);
+}
+
 static int device_init(struct dummy_device *d)
 {
 	int ret;
 
+	if (WARN_ONCE(d->pmu.name, "Cannot re-register pmu.\n"))
+		return -EINVAL;
+
 	d->pmu.base = (struct pmu){
 		.attr_groups	= attr_groups,
 		.module		= THIS_MODULE,
@@ -209,6 +220,8 @@ static int device_init(struct dummy_device *d)
 		.start		= dummy_pmu_event_start,
 		.stop		= dummy_pmu_event_stop,
 		.read		= dummy_pmu_event_read,
+		.get		= dummy_pmu_get,
+		.put		= dummy_pmu_put,
 	};
 
 	d->pmu.name = kasprintf(GFP_KERNEL, "dummy_pmu_%u", d->instance);
@@ -217,12 +230,22 @@ static int device_init(struct dummy_device *d)
 
 	ret = perf_pmu_register(&d->pmu.base, d->pmu.name, -1);
 	if (ret)
-		return ret;
+		goto fail;
 
 	d->pmu.registered = true;
 	pr_info("Device registered: %s\n", d->pmu.name);
 
 	return 0;
+
+fail:
+	/*
+	 * See device_release: if name is non-NULL, dummy_pmu was registered
+	 * with perf and needs cleanup
+	 */
+	kfree(d->pmu.name);
+	d->pmu.name = NULL;
+
+	return ret;
 }
 
 static void device_exit(struct dummy_device *d)
@@ -237,7 +260,10 @@ static void device_release(struct kref *ref)
 {
 	struct dummy_device *d = container_of(ref, struct dummy_device, refcount);
 
-	kfree(d->pmu.name);
+	if (d->pmu.name) {
+		perf_pmu_free(&d->pmu.base);
+		kfree(d->pmu.name);
+	}
 	kfree(d);
 }
 
-- 
2.46.2



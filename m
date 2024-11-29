Return-Path: <linux-kernel+bounces-418973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB2C9D67F5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 08:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D75C4B22AE4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 07:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E90218C343;
	Sat, 23 Nov 2024 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fH1V2+H1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59EA185935;
	Sat, 23 Nov 2024 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732345296; cv=none; b=NBps32aFUfLDOKpipu7uOI+KA2m+q5t4C3BXj3EOnoBTxZezR/CM0HLeMR/myj7WQ3hghgJ+FjSbjsCq6cK/Z2T2FPtR93Scu+5bFWqCLJcnf8ztBMSyDLZh5p6B4538YmKO5tb6qR9LHtkbQRTc98etfEHoU2QUY5879Zrr1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732345296; c=relaxed/simple;
	bh=DO3/7O2ZpUjwMR3VehypPmAPmQx23xHOewI0rvj2B7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jXFxTGZDDQkVf0dP/a5/LOBmD7s9Q76lY3K9NmzZCpursMS1+JwNU6kfZ3R3weGqZXJVSplcSL6xJxy40aYQwZ3jpnFJIZjBj0eROulvfJ3Y999Z7WZZjzXRUo4nXHNB1Xu8SZIMXgsJsm7m1x7Z0KcBvmMEQJxNJRsNzprBOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fH1V2+H1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732345294; x=1763881294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DO3/7O2ZpUjwMR3VehypPmAPmQx23xHOewI0rvj2B7Y=;
  b=fH1V2+H1e9RqiyFgAgFC8+KduWsJRTK//oKGjItrhefIFhlXbT9QZVHY
   tmjSa7NpsbJ1pLExWOeeJT7Ay4hJGGsy14Vnz6fXqcCtjLfB2a2HDaGK3
   t9KM7t/0cx6JjrL7vCuiWfqGtSJXFNZaIyyMx06Z+2ushJlj3fBOeUacf
   eNssy2NRaLC2t4glr9eSwxO8ieGmubYZ3VLPREinPrwyOVLJT4VQkIB5R
   nv5DCvzkpyUzuT7y4F1nBqstcJHqZQ4JPiL5qumwfyRKchdqlPLpux0Hh
   eZu6RzmbyTSfENaPr0ucAUzdlHc6mBjUvwj5VePc2xXgjP39uPtalrrxt
   A==;
X-CSE-ConnectionGUID: qNqz7bQ7Q8a8x0UDl7jdhA==
X-CSE-MsgGUID: l9QDG4HnTkyOpnZQk0l4WA==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32435541"
X-IronPort-AV: E=Sophos;i="6.12,178,1728975600"; 
   d="scan'208";a="32435541"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 23:01:29 -0800
X-CSE-ConnectionGUID: uUHpSe6CT1q3CZdP12z6dQ==
X-CSE-MsgGUID: w3LXN6+CRxW907z0i/z7aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,178,1728975600"; 
   d="scan'208";a="91573565"
Received: from unknown (HELO JF5300-B11A338T.jf.intel.com) ([10.242.51.115])
  by orviesa008.jf.intel.com with ESMTP; 22 Nov 2024 23:01:29 -0800
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v4 07/10] crypto: iaa - Map IAA devices/wqs to cores based on packages instead of NUMA.
Date: Fri, 22 Nov 2024 23:01:24 -0800
Message-Id: <20241123070127.332773-8-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241123070127.332773-1-kanchana.p.sridhar@intel.com>
References: <20241123070127.332773-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch modifies the algorithm for mapping available IAA devices and
wqs to cores, as they are being discovered, based on packages instead of
NUMA nodes. This leads to a more realistic mapping of IAA devices as
compression/decompression resources for a package, rather than for a NUMA
node. This also resolves problems that were observed during internal
validation on Intel platforms with many more NUMA nodes than packages: for
such cases, the earlier NUMA based allocation caused some IAAs to be
over-subscribed and some to not be utilized at all.

As a result of this change from NUMA to packages, some of the core
functions used by the iaa_crypto driver's "probe" and "remove" API
have been re-written. The new infrastructure maintains a static/global
mapping of "local wqs" per IAA device, in the "struct iaa_device" itself.
The earlier implementation would allocate memory per-cpu for this data,
which never changes once the IAA devices/wqs have been initialized.

Two main outcomes from this new iaa_crypto driver infrastructure are:

1) Resolves "task blocked for more than x seconds" errors observed during
   internal validation on Intel systems with the earlier NUMA node based
   mappings, which was root-caused to the non-optimal IAA-to-core mappings
   described earlier.

2) Results in a NUM_THREADS factor reduction in memory footprint cost of
   initializing IAA devices/wqs, due to eliminating the per-cpu copies of
   each IAA device's wqs. On a 384 cores Intel Granite Rapids server with
   8 IAA devices, this saves 140MiB.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto.h      |  17 +-
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 276 ++++++++++++---------
 2 files changed, 171 insertions(+), 122 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index 56985e395263..ca317c5aaf27 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -46,6 +46,7 @@ struct iaa_wq {
 	struct idxd_wq		*wq;
 	int			ref;
 	bool			remove;
+	bool			mapped;
 
 	struct iaa_device	*iaa_device;
 
@@ -63,6 +64,13 @@ struct iaa_device_compression_mode {
 	dma_addr_t			aecs_comp_table_dma_addr;
 };
 
+struct wq_table_entry {
+	struct idxd_wq **wqs;
+	int	max_wqs;
+	int	n_wqs;
+	int	cur_wq;
+};
+
 /* Representation of IAA device with wqs, populated by probe */
 struct iaa_device {
 	struct list_head		list;
@@ -73,19 +81,14 @@ struct iaa_device {
 	int				n_wq;
 	struct list_head		wqs;
 
+	struct wq_table_entry		*iaa_local_wqs;
+
 	atomic64_t			comp_calls;
 	atomic64_t			comp_bytes;
 	atomic64_t			decomp_calls;
 	atomic64_t			decomp_bytes;
 };
 
-struct wq_table_entry {
-	struct idxd_wq **wqs;
-	int	max_wqs;
-	int	n_wqs;
-	int	cur_wq;
-};
-
 #define IAA_AECS_ALIGN			32
 
 /*
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index c2362e4525bd..28f2f5617bf0 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -30,8 +30,9 @@
 /* number of iaa instances probed */
 static unsigned int nr_iaa;
 static unsigned int nr_cpus;
-static unsigned int nr_nodes;
-static unsigned int nr_cpus_per_node;
+static unsigned int nr_packages;
+static unsigned int nr_cpus_per_package;
+static unsigned int nr_iaa_per_package;
 
 /* Number of physical cpus sharing each iaa instance */
 static unsigned int cpus_per_iaa;
@@ -462,17 +463,46 @@ static void remove_device_compression_modes(struct iaa_device *iaa_device)
  * Functions for use in crypto probe and remove interfaces:
  * allocate/init/query/deallocate devices/wqs.
  ***********************************************************/
-static struct iaa_device *iaa_device_alloc(void)
+static struct iaa_device *iaa_device_alloc(struct idxd_device *idxd)
 {
+	struct wq_table_entry *local;
 	struct iaa_device *iaa_device;
 
 	iaa_device = kzalloc(sizeof(*iaa_device), GFP_KERNEL);
 	if (!iaa_device)
-		return NULL;
+		goto err;
+
+	iaa_device->idxd = idxd;
+
+	/* IAA device's local wqs. */
+	iaa_device->iaa_local_wqs = kzalloc(sizeof(struct wq_table_entry), GFP_KERNEL);
+	if (!iaa_device->iaa_local_wqs)
+		goto err;
+
+	local = iaa_device->iaa_local_wqs;
+
+	local->wqs = kzalloc(iaa_device->idxd->max_wqs * sizeof(struct wq *), GFP_KERNEL);
+	if (!local->wqs)
+		goto err;
+
+	local->max_wqs = iaa_device->idxd->max_wqs;
+	local->n_wqs = 0;
 
 	INIT_LIST_HEAD(&iaa_device->wqs);
 
 	return iaa_device;
+
+err:
+	if (iaa_device) {
+		if (iaa_device->iaa_local_wqs) {
+			if (iaa_device->iaa_local_wqs->wqs)
+				kfree(iaa_device->iaa_local_wqs->wqs);
+			kfree(iaa_device->iaa_local_wqs);
+		}
+		kfree(iaa_device);
+	}
+
+	return NULL;
 }
 
 static bool iaa_has_wq(struct iaa_device *iaa_device, struct idxd_wq *wq)
@@ -491,12 +521,10 @@ static struct iaa_device *add_iaa_device(struct idxd_device *idxd)
 {
 	struct iaa_device *iaa_device;
 
-	iaa_device = iaa_device_alloc();
+	iaa_device = iaa_device_alloc(idxd);
 	if (!iaa_device)
 		return NULL;
 
-	iaa_device->idxd = idxd;
-
 	list_add_tail(&iaa_device->list, &iaa_devices);
 
 	nr_iaa++;
@@ -537,6 +565,7 @@ static int add_iaa_wq(struct iaa_device *iaa_device, struct idxd_wq *wq,
 	iaa_wq->wq = wq;
 	iaa_wq->iaa_device = iaa_device;
 	idxd_wq_set_private(wq, iaa_wq);
+	iaa_wq->mapped = false;
 
 	list_add_tail(&iaa_wq->list, &iaa_device->wqs);
 
@@ -580,6 +609,13 @@ static void free_iaa_device(struct iaa_device *iaa_device)
 		return;
 
 	remove_device_compression_modes(iaa_device);
+
+	if (iaa_device->iaa_local_wqs) {
+		if (iaa_device->iaa_local_wqs->wqs)
+			kfree(iaa_device->iaa_local_wqs->wqs);
+		kfree(iaa_device->iaa_local_wqs);
+	}
+
 	kfree(iaa_device);
 }
 
@@ -716,9 +752,14 @@ static int save_iaa_wq(struct idxd_wq *wq)
 	if (WARN_ON(nr_iaa == 0))
 		return -EINVAL;
 
-	cpus_per_iaa = (nr_nodes * nr_cpus_per_node) / nr_iaa;
+	cpus_per_iaa = (nr_packages * nr_cpus_per_package) / nr_iaa;
 	if (!cpus_per_iaa)
 		cpus_per_iaa = 1;
+
+	nr_iaa_per_package = nr_iaa / nr_packages;
+	if (!nr_iaa_per_package)
+		nr_iaa_per_package = 1;
+
 out:
 	return 0;
 }
@@ -735,53 +776,45 @@ static void remove_iaa_wq(struct idxd_wq *wq)
 	}
 
 	if (nr_iaa) {
-		cpus_per_iaa = (nr_nodes * nr_cpus_per_node) / nr_iaa;
+		cpus_per_iaa = (nr_packages * nr_cpus_per_package) / nr_iaa;
 		if (!cpus_per_iaa)
 			cpus_per_iaa = 1;
-	} else
+
+		nr_iaa_per_package = nr_iaa / nr_packages;
+		if (!nr_iaa_per_package)
+			nr_iaa_per_package = 1;
+	} else {
 		cpus_per_iaa = 1;
+		nr_iaa_per_package = 1;
+	}
 }
 
 /***************************************************************
  * Mapping IAA devices and wqs to cores with per-cpu wq_tables.
  ***************************************************************/
-static void wq_table_free_entry(int cpu)
-{
-	struct wq_table_entry *entry = per_cpu_ptr(wq_table, cpu);
-
-	kfree(entry->wqs);
-	memset(entry, 0, sizeof(*entry));
-}
-
-static void wq_table_clear_entry(int cpu)
-{
-	struct wq_table_entry *entry = per_cpu_ptr(wq_table, cpu);
-
-	entry->n_wqs = 0;
-	entry->cur_wq = 0;
-	memset(entry->wqs, 0, entry->max_wqs * sizeof(struct idxd_wq *));
-}
-
-static void clear_wq_table(void)
+/*
+ * Given a cpu, find the closest IAA instance.  The idea is to try to
+ * choose the most appropriate IAA instance for a caller and spread
+ * available workqueues around to clients.
+ */
+static inline int cpu_to_iaa(int cpu)
 {
-	int cpu;
-
-	for (cpu = 0; cpu < nr_cpus; cpu++)
-		wq_table_clear_entry(cpu);
+	int package_id, base_iaa, iaa = 0;
 
-	pr_debug("cleared wq table\n");
-}
+	if (!nr_packages || !nr_iaa_per_package)
+		return 0;
 
-static void free_wq_table(void)
-{
-	int cpu;
+	package_id = topology_logical_package_id(cpu);
+	base_iaa = package_id * nr_iaa_per_package;
+	iaa = base_iaa + ((cpu % nr_cpus_per_package) / cpus_per_iaa);
 
-	for (cpu = 0; cpu < nr_cpus; cpu++)
-		wq_table_free_entry(cpu);
+	pr_debug("cpu = %d, package_id = %d, base_iaa = %d, iaa = %d",
+		 cpu, package_id, base_iaa, iaa);
 
-	free_percpu(wq_table);
+	if (iaa >= 0 && iaa < nr_iaa)
+		return iaa;
 
-	pr_debug("freed wq table\n");
+	return (nr_iaa - 1);
 }
 
 static int alloc_wq_table(int max_wqs)
@@ -795,13 +828,11 @@ static int alloc_wq_table(int max_wqs)
 
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		entry = per_cpu_ptr(wq_table, cpu);
-		entry->wqs = kcalloc(max_wqs, sizeof(struct wq *), GFP_KERNEL);
-		if (!entry->wqs) {
-			free_wq_table();
-			return -ENOMEM;
-		}
 
+		entry->wqs = NULL;
 		entry->max_wqs = max_wqs;
+		entry->n_wqs = 0;
+		entry->cur_wq = 0;
 	}
 
 	pr_debug("initialized wq table\n");
@@ -809,33 +840,27 @@ static int alloc_wq_table(int max_wqs)
 	return 0;
 }
 
-static void wq_table_add(int cpu, struct idxd_wq *wq)
+static void wq_table_add(int cpu, struct wq_table_entry *iaa_local_wqs)
 {
 	struct wq_table_entry *entry = per_cpu_ptr(wq_table, cpu);
 
-	if (WARN_ON(entry->n_wqs == entry->max_wqs))
-		return;
-
-	entry->wqs[entry->n_wqs++] = wq;
+	entry->wqs = iaa_local_wqs->wqs;
+	entry->max_wqs = iaa_local_wqs->max_wqs;
+	entry->n_wqs = iaa_local_wqs->n_wqs;
+	entry->cur_wq = 0;
 
-	pr_debug("%s: added iaa wq %d.%d to idx %d of cpu %d\n", __func__,
+	pr_debug("%s: cpu %d: added %d iaa local wqs up to wq %d.%d\n", __func__,
+		 cpu, entry->n_wqs,
 		 entry->wqs[entry->n_wqs - 1]->idxd->id,
-		 entry->wqs[entry->n_wqs - 1]->id, entry->n_wqs - 1, cpu);
+		 entry->wqs[entry->n_wqs - 1]->id);
 }
 
 static int wq_table_add_wqs(int iaa, int cpu)
 {
 	struct iaa_device *iaa_device, *found_device = NULL;
-	int ret = 0, cur_iaa = 0, n_wqs_added = 0;
-	struct idxd_device *idxd;
-	struct iaa_wq *iaa_wq;
-	struct pci_dev *pdev;
-	struct device *dev;
+	int ret = 0, cur_iaa = 0;
 
 	list_for_each_entry(iaa_device, &iaa_devices, list) {
-		idxd = iaa_device->idxd;
-		pdev = idxd->pdev;
-		dev = &pdev->dev;
 
 		if (cur_iaa != iaa) {
 			cur_iaa++;
@@ -843,7 +868,8 @@ static int wq_table_add_wqs(int iaa, int cpu)
 		}
 
 		found_device = iaa_device;
-		dev_dbg(dev, "getting wq from iaa_device %d, cur_iaa %d\n",
+		dev_dbg(&found_device->idxd->pdev->dev,
+			"getting wq from iaa_device %d, cur_iaa %d\n",
 			found_device->idxd->id, cur_iaa);
 		break;
 	}
@@ -858,29 +884,58 @@ static int wq_table_add_wqs(int iaa, int cpu)
 		}
 		cur_iaa = 0;
 
-		idxd = found_device->idxd;
-		pdev = idxd->pdev;
-		dev = &pdev->dev;
-		dev_dbg(dev, "getting wq from only iaa_device %d, cur_iaa %d\n",
+		dev_dbg(&found_device->idxd->pdev->dev,
+			"getting wq from only iaa_device %d, cur_iaa %d\n",
 			found_device->idxd->id, cur_iaa);
 	}
 
-	list_for_each_entry(iaa_wq, &found_device->wqs, list) {
-		wq_table_add(cpu, iaa_wq->wq);
-		pr_debug("rebalance: added wq for cpu=%d: iaa wq %d.%d\n",
-			 cpu, iaa_wq->wq->idxd->id, iaa_wq->wq->id);
-		n_wqs_added++;
+	wq_table_add(cpu, found_device->iaa_local_wqs);
+
+out:
+	return ret;
+}
+
+static int map_iaa_device_wqs(struct iaa_device *iaa_device)
+{
+	struct wq_table_entry *local;
+	int ret = 0, n_wqs_added = 0;
+	struct iaa_wq *iaa_wq;
+
+	local = iaa_device->iaa_local_wqs;
+
+	list_for_each_entry(iaa_wq, &iaa_device->wqs, list) {
+		if (iaa_wq->mapped && ++n_wqs_added)
+			continue;
+
+		pr_debug("iaa_device %px: processing wq %d.%d\n", iaa_device, iaa_device->idxd->id, iaa_wq->wq->id);
+
+		if (WARN_ON(local->n_wqs == local->max_wqs))
+			break;
+
+		local->wqs[local->n_wqs++] = iaa_wq->wq;
+		pr_debug("iaa_device %px: added local wq %d.%d\n", iaa_device, iaa_device->idxd->id, iaa_wq->wq->id);
+
+		iaa_wq->mapped = true;
+		++n_wqs_added;
 	}
 
-	if (!n_wqs_added) {
-		pr_debug("couldn't find any iaa wqs!\n");
+	if (!n_wqs_added && !iaa_device->n_wq) {
+		pr_debug("iaa_device %d: couldn't find any iaa wqs!\n", iaa_device->idxd->id);
 		ret = -EINVAL;
-		goto out;
 	}
-out:
+
 	return ret;
 }
 
+static void map_iaa_devices(void)
+{
+	struct iaa_device *iaa_device;
+
+	list_for_each_entry(iaa_device, &iaa_devices, list) {
+		BUG_ON(map_iaa_device_wqs(iaa_device));
+	}
+}
+
 /*
  * Rebalance the wq table so that given a cpu, it's easy to find the
  * closest IAA instance.  The idea is to try to choose the most
@@ -889,48 +944,42 @@ static int wq_table_add_wqs(int iaa, int cpu)
  */
 static void rebalance_wq_table(void)
 {
-	const struct cpumask *node_cpus;
-	int node, cpu, iaa = -1;
+	int cpu, iaa;
 
 	if (nr_iaa == 0)
 		return;
 
-	pr_debug("rebalance: nr_nodes=%d, nr_cpus %d, nr_iaa %d, cpus_per_iaa %d\n",
-		 nr_nodes, nr_cpus, nr_iaa, cpus_per_iaa);
+	map_iaa_devices();
 
-	clear_wq_table();
+	pr_debug("rebalance: nr_packages=%d, nr_cpus %d, nr_iaa %d, cpus_per_iaa %d\n",
+		 nr_packages, nr_cpus, nr_iaa, cpus_per_iaa);
 
-	if (nr_iaa == 1) {
-		for (cpu = 0; cpu < nr_cpus; cpu++) {
-			if (WARN_ON(wq_table_add_wqs(0, cpu))) {
-				pr_debug("could not add any wqs for iaa 0 to cpu %d!\n", cpu);
-				return;
-			}
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		iaa = cpu_to_iaa(cpu);
+		pr_debug("rebalance: cpu=%d iaa=%d\n", cpu, iaa);
+
+		if (WARN_ON(iaa == -1)) {
+			pr_debug("rebalance (cpu_to_iaa(%d)) failed!\n", cpu);
+			return;
 		}
 
-		return;
+		if (WARN_ON(wq_table_add_wqs(iaa, cpu))) {
+			pr_debug("could not add any wqs for iaa %d to cpu %d!\n", iaa, cpu);
+			return;
+		}
 	}
 
-	for_each_node_with_cpus(node) {
-		node_cpus = cpumask_of_node(node);
-
-		for (cpu = 0; cpu <  cpumask_weight(node_cpus); cpu++) {
-			int node_cpu = cpumask_nth(cpu, node_cpus);
-
-			if (WARN_ON(node_cpu >= nr_cpu_ids)) {
-				pr_debug("node_cpu %d doesn't exist!\n", node_cpu);
-				return;
-			}
-
-			if ((cpu % cpus_per_iaa) == 0)
-				iaa++;
+	pr_debug("Finished rebalance local wqs.");
+}
 
-			if (WARN_ON(wq_table_add_wqs(iaa, node_cpu))) {
-				pr_debug("could not add any wqs for iaa %d to cpu %d!\n", iaa, cpu);
-				return;
-			}
-		}
+static void free_wq_tables(void)
+{
+	if (wq_table) {
+		free_percpu(wq_table);
+		wq_table = NULL;
 	}
+
+	pr_debug("freed local wq table\n");
 }
 
 /***************************************************************
@@ -2281,7 +2330,7 @@ static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 	free_iaa_wq(idxd_wq_get_private(wq));
 err_save:
 	if (first_wq)
-		free_wq_table();
+		free_wq_tables();
 err_alloc:
 	mutex_unlock(&iaa_devices_lock);
 	idxd_drv_disable_wq(wq);
@@ -2331,7 +2380,9 @@ static void iaa_crypto_remove(struct idxd_dev *idxd_dev)
 
 	if (nr_iaa == 0) {
 		iaa_crypto_enabled = false;
-		free_wq_table();
+		free_wq_tables();
+		BUG_ON(!list_empty(&iaa_devices));
+		INIT_LIST_HEAD(&iaa_devices);
 		module_put(THIS_MODULE);
 
 		pr_info("iaa_crypto now DISABLED\n");
@@ -2357,16 +2408,11 @@ static struct idxd_device_driver iaa_crypto_driver = {
 static int __init iaa_crypto_init_module(void)
 {
 	int ret = 0;
-	int node;
+	INIT_LIST_HEAD(&iaa_devices);
 
 	nr_cpus = num_possible_cpus();
-	for_each_node_with_cpus(node)
-		nr_nodes++;
-	if (!nr_nodes) {
-		pr_err("IAA couldn't find any nodes with cpus\n");
-		return -ENODEV;
-	}
-	nr_cpus_per_node = nr_cpus / nr_nodes;
+	nr_cpus_per_package = topology_num_cores_per_package();
+	nr_packages = topology_max_packages();
 
 	if (crypto_has_comp("deflate-generic", 0, 0))
 		deflate_generic_tfm = crypto_alloc_comp("deflate-generic", 0, 0);
-- 
2.27.0



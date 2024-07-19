Return-Path: <linux-kernel+bounces-257586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D28E937C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111BB2815C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC9F146A99;
	Fri, 19 Jul 2024 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W23QQN0a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7447146587
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412728; cv=none; b=D9hfELSkdZtobaMunBXZTvt/2y/F9SNhGr2Icslfj/ECuShSeBXIOejTwPmOQklP+E6jnAb/fGLrrTnoD/Sfa2+1Im6lkm+7Gl8W5gQzL28MvzEVNBWFdEI9wejzGDvWhh+PNOrBgVQrxjOs+NmFy//DGBdySByiR7eLMOigSow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412728; c=relaxed/simple;
	bh=1JMFO5JpLtKBg+aq7X958P5rykVu7IXsY1pr6nOtH6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t8sr/I7vBH7uAB0RJ9wA73nzNXjwoK1JpVEQJ1SyC5rVp3azyiTp6XbX4jZ3I3e0R40OZ/ZwDubjXpEeiGzVRfFspmhyix4G9qWDHVMXW6Kv7szgolZ9s3zfkROR8eujTFeQu1sZYTzusiKw/hCZEA5RzktdkOBjLMC9wtU42B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W23QQN0a; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721412726; x=1752948726;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1JMFO5JpLtKBg+aq7X958P5rykVu7IXsY1pr6nOtH6I=;
  b=W23QQN0ayN2GiIhbTjLRwqnfMGseH/xJQ4TztwEw6fe0IxtBkKrghhIr
   hugA5Usylk8kcG5STIIGDRn2mV+aWDfYaOXbsJu9otHBnql+d1vCCsYLw
   xpp89K1C0dShFDrMGo2k4NLesaTRZEnS8mO4qgPxfK/LDCxWRrG+SLWb2
   yTBuBBYgq9t1FNbUzHra3z8s7vSh5QPaQFTsmnrN9tM2iAbD5KgrkBFoR
   7owMrPkRGjmrc20aajnZO2XAQ5Q2T/toBbZKOTLecjOv1r8dhRfavJm46
   4c6y6K8tyjILd7olbQxpA/eo7eh2wnzvwfKyim2GaMdwdJcUBBx6wkQV3
   g==;
X-CSE-ConnectionGUID: erUjWbrARHqOR53V89Zz3Q==
X-CSE-MsgGUID: PYBG1WpsQLaHVgcixh88Cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="22907952"
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="22907952"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 11:12:06 -0700
X-CSE-ConnectionGUID: cM90IvprSVOF0HJ/Herccw==
X-CSE-MsgGUID: LGlI8zVcRbCAYEt2sxv5lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="51820349"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by orviesa007.jf.intel.com with ESMTP; 19 Jul 2024 11:12:06 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Lu Baolu" <baolu.lu@linux.intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	tina.zhang@intel.com,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] iommu/vt-d: Fix potential soft lockup due to reclaim
Date: Fri, 19 Jul 2024 11:17:25 -0700
Message-Id: <20240719181725.1446021-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay K Kumar <sanjay.k.kumar@intel.com>

If qi_submit_sync() is invoked with 0 invalidation descriptors (for
instance, for DMA draining purposes), we can run into a bug where a
submitting thread fails to detect the completion of invalidation_wait.
Subsequently, this led to a soft lockup.

Suppose thread T1 invokes qi_submit_sync() with non-zero descriptors, while
concurrently, thread T2 calls qi_submit_sync() with zero descriptors. Both
threads then enter a while loop, waiting for their respective descriptors
to complete. T1 detects its completion (i.e., T1's invalidation_wait status
changes to QI_DONE by HW) and proceeds to call reclaim_free_desc() to
reclaim all descriptors, potentially including adjacent ones of other
threads that are also marked as QI_DONE.

During this time, while T2 is waiting to acquire the qi->q_lock, the IOMMU
hardware may complete the invalidation for T2, setting its status to
QI_DONE. However, if T1's execution of reclaim_free_desc() frees T2's
invalidation_wait descriptor and changes its status to QI_FREE, T2 will
not observe the QI_DONE status for its invalidation_wait and will
indefinitely remain stuck.

This soft lockup does not occur when only non-zero descriptors are
submitted.In such cases, invalidation descriptors are interspersed among
wait descriptors with the status QI_IN_USE, acting as barriers. These
barriers prevent the reclaim code from mistakenly freeing descriptors
belonging to other submitters.

Considered the following example timeline:
	T1			T2
========================================
	ID1
	WD1
	while(WD1!=QI_DONE)
	unlock
				lock
	WD1=QI_DONE*		WD2
				while(WD2!=QI_DONE)
				unlock
	lock
	WD1==QI_DONE?
	ID1=QI_DONE		WD2=DONE*
	reclaim()
	ID1=FREE
	WD1=FREE
	WD2=FREE
	unlock
				soft lockup! T2 never sees QI_DONE in WD2

Where:
ID = invalidation descriptor
WD = wait descriptor
* Written by hardware

The root of the problem is that the descriptor status QI_DONE flag is used
for two conflicting purposes:
1. signal a descriptor is ready for reclaim (to be freed)
2. signal by the hardware that a wait descriptor is complete

The solution (in this patch) is state separation by introducing a new flag
for the descriptors called QI_TO_BE_FREED.

Once a thread's invalidation descriptors are complete, their status would
be set to QI_TO_BE_FREED. The reclaim_free_desc() function would then only
free descriptors marked as QI_TO_BE_FREED instead of those marked as
QI_DONE. This change ensures that T2 (from the previous example) will
correctly observe the completion of its invalidation_wait (marked as
QI_DONE).

Currently, there is no impact by this bug on the existing users because no
callers are submitting invalidations with 0 descriptors.

Signed-off-by: Sanjay K Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 13 +++++++++----
 drivers/iommu/intel/iommu.h |  3 ++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 304e84949ca7..00e0f5f801c5 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1204,8 +1204,7 @@ static void free_iommu(struct intel_iommu *iommu)
  */
 static inline void reclaim_free_desc(struct q_inval *qi)
 {
-	while (qi->desc_status[qi->free_tail] == QI_DONE ||
-	       qi->desc_status[qi->free_tail] == QI_ABORT) {
+	while (qi->desc_status[qi->free_tail] == QI_TO_BE_FREED) {
 		qi->desc_status[qi->free_tail] = QI_FREE;
 		qi->free_tail = (qi->free_tail + 1) % QI_LENGTH;
 		qi->free_cnt++;
@@ -1463,8 +1462,14 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		raw_spin_lock(&qi->q_lock);
 	}
 
-	for (i = 0; i < count; i++)
-		qi->desc_status[(index + i) % QI_LENGTH] = QI_DONE;
+	/*
+	 * The reclaim code can free descriptors from multiple submissions
+	 * starting from the tail of the queue. When count == 0, the
+	 * status of the standalone wait descriptor at the tail of the queue
+	 * must be set to QI_TO_BE_FREED to allow the reclaim code to proceed.
+	 */
+	for (i = 0; i <= count; i++)
+		qi->desc_status[(index + i) % QI_LENGTH] = QI_TO_BE_FREED;
 
 	reclaim_free_desc(qi);
 	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index eaf015b4353b..1ab39f9145f2 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -382,7 +382,8 @@ enum {
 	QI_FREE,
 	QI_IN_USE,
 	QI_DONE,
-	QI_ABORT
+	QI_ABORT,
+	QI_TO_BE_FREED
 };
 
 #define QI_CC_TYPE		0x1
-- 
2.25.1



Return-Path: <linux-kernel+bounces-264869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C855293E979
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 22:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B54C1F2152C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 20:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCC578C68;
	Sun, 28 Jul 2024 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5VPp08M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E87828B
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722200139; cv=none; b=NPowx+8euExHnWIMdbShq8PbQk/5wdJpp+GntR6PeneFcSltYoPHoZqHCMrR1TPN7cJBRFVJM+yWHmowF6cA1HsxnL3XcQNTzAI/+eSgerazA+BuZowzHZBggCJxvOdcS2vNR8gLeLPVmEyEpHvGc6hiNf7rJUtpZOgS40hTH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722200139; c=relaxed/simple;
	bh=t0yhNmOTS4H6qYf43gluXt6XAHGsQAAm4KSYak9lD0w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZRGBknIXeY0hQex1ahDpvaTGlRRf4wq2oVr8kzVU7tsUhjCSUYkrS0F5Kf6n6RDB74aNxPtnXOXEKJEqP1r9YbY0qBfULyDCG01VDkAEkhJhCbBfPgoQixdzr4stKiJ4+Z+NCU4zQRW7OqWf3wBy69bPnrUdBMoFKuD1x5qCGpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5VPp08M; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722200137; x=1753736137;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t0yhNmOTS4H6qYf43gluXt6XAHGsQAAm4KSYak9lD0w=;
  b=k5VPp08MBEef4n4hyXw3++q79nCbCJbSz5h0f+zEnlXgpC//r06y5BVX
   Hfj0RX4CK7aomgT6k39g0h7E3ozH4iN8StxMaMo1NLtYh17W50+n058WF
   sNMZwfKm242DZQ4cm+UxJ25XWYVCGMOW62Uafcir+i29HFXeyzt/vfBmX
   GiDvzKJD1AWjxiVEckTYZPCNxWBSb50ZaWptEJEGHx23IiIpCbY3djk3y
   YwKdOoCsReYsoYbYC2C6Hp5FK3w5TkAbQlL5YEG+x7sRz1NxEDYDVTV5b
   H3MgWKpMaRMlnoumJbfW+KTHA17uTM7QwuEcqU2mFcJQr0uEgjFtVJ/RH
   Q==;
X-CSE-ConnectionGUID: zmn9QwDMSXSLfm/H2KKd7A==
X-CSE-MsgGUID: pSdSg8t9RCS51UxYjkG60Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="19625499"
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="19625499"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 13:55:37 -0700
X-CSE-ConnectionGUID: 9WcsO4RRRpmbpY/bKOEv/A==
X-CSE-MsgGUID: mFh5O5A+S7KkpAc7jDqvMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="58567760"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by orviesa005.jf.intel.com with ESMTP; 28 Jul 2024 13:55:37 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Lu Baolu" <baolu.lu@linux.intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	tina.zhang@intel.com,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2] iommu/vt-d: Fix potential lockup if qi_submit_sync called with 0 count
Date: Sun, 28 Jul 2024 14:00:59 -0700
Message-Id: <20240728210059.1964602-1-jacob.jun.pan@linux.intel.com>
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
Subsequently, this led to a soft lockup. Currently, there is no impact
by this bug on the existing users because no callers are submitting
invalidations with 0 descriptors. This fix will enable future users
(such as DMA drain) calling qi_submit_sync() with 0 count.

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

The solution (in this patch) is state separation by using QI_FREE flag
for #1.

Once a thread's invalidation descriptors are complete, their status would
be set to QI_FREE. The reclaim_free_desc() function would then only
free descriptors marked as QI_FREE instead of those marked as
QI_DONE. This change ensures that T2 (from the previous example) will
correctly observe the completion of its invalidation_wait (marked as
QI_DONE).

Signed-off-by: Sanjay K Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

---
v2: (Kevin)
   - Reuse QI_FREE flag instead of a new QI_TO_BE_FREED flag
   - Clarify the impact of the bug on existing users
---
 drivers/iommu/intel/dmar.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 304e84949ca7..cd24f2e9eb3c 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1204,9 +1204,7 @@ static void free_iommu(struct intel_iommu *iommu)
  */
 static inline void reclaim_free_desc(struct q_inval *qi)
 {
-	while (qi->desc_status[qi->free_tail] == QI_DONE ||
-	       qi->desc_status[qi->free_tail] == QI_ABORT) {
-		qi->desc_status[qi->free_tail] = QI_FREE;
+	while (qi->desc_status[qi->free_tail] == QI_FREE && qi->free_tail != qi->free_head) {
 		qi->free_tail = (qi->free_tail + 1) % QI_LENGTH;
 		qi->free_cnt++;
 	}
@@ -1463,8 +1461,16 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 		raw_spin_lock(&qi->q_lock);
 	}
 
-	for (i = 0; i < count; i++)
-		qi->desc_status[(index + i) % QI_LENGTH] = QI_DONE;
+	/*
+	 * The reclaim code can free descriptors from multiple submissions
+	 * starting from the tail of the queue. When count == 0, the
+	 * status of the standalone wait descriptor at the tail of the queue
+	 * must be set to QI_FREE to allow the reclaim code to proceed.
+	 * It is also possible that descriptors from one of the previous
+	 * submissions has to be reclaimed by a subsequent submission.
+	 */
+	for (i = 0; i <= count; i++)
+		qi->desc_status[(index + i) % QI_LENGTH] = QI_FREE;
 
 	reclaim_free_desc(qi);
 	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
-- 
2.25.1



Return-Path: <linux-kernel+bounces-294519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBD2958EAC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA651C21881
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A44157488;
	Tue, 20 Aug 2024 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDGtECqA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48F614B94B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724182636; cv=none; b=s8pFs5UOcsX1ol3IX0RmidoQbRPrjmnqvAhk2wNnw1xT03BWZ6zYsDCmauT2nAFCS8r+cocB/51T171btVm1FVkLXwXUhqNWpiApTDZxUuzhupESaSFQbSU4A1vvS28gFzQoOMpeR++AjHvg9TbH1DYbdMsFQsdAE7L/vmCq150=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724182636; c=relaxed/simple;
	bh=friwrIjD5i1j70NXQPAalr3vj4RE7Kl5vZEd2Qp3P5E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uXzA82dM0laJbSl7V7XTNjLqBC42jIrXWlphXFeSbI6hyWLfmMHXi1Kf5WShkxNwYefV9U1WQBV5YWb98gmoNEhub7A+QqB5eo4E9PsD3ynZJqJLMW8P0gVmzm04JozppOneRD/3eqEfAgYin7z7oPZSWOB5OkyceN0xAT/A1k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDGtECqA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724182635; x=1755718635;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=friwrIjD5i1j70NXQPAalr3vj4RE7Kl5vZEd2Qp3P5E=;
  b=eDGtECqAiB387fzCZvqRV9KhLpyVscmJi5oQkNmZuOv/S5VnXmSYJUSv
   DdFd1r+/xaBgkcILMHLI9+a//ejr+kdaE4r3li74zbL10JEqvwDIJyG+t
   Bg10OPntDbjo81f+2G/eKIFgwRb7D0yu7xQ8ESlf/nRhO/PA4O2PwhIKB
   of5phyP2t/sTb6+eHDaLNSSi7kZBLiSFFr+8/sDw3aHArPjLwzuGNpRb1
   RNDQlnSmqhhDnG/ogbRCsghMsv7QhLFIhcOZB+Vm6tuVJ6KBDLmPAiy0I
   vt6DcK5XJMtsCQTDzS8TJ3lRFaBpWH/QPMAqxXZ7fpjY49hfWFBEqDlKE
   A==;
X-CSE-ConnectionGUID: lkuFi/ulQkectxuuOoSrVA==
X-CSE-MsgGUID: jsd5cIevQ+24Ly+3Y2Az+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33899178"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="33899178"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 12:37:14 -0700
X-CSE-ConnectionGUID: 13K1Yx+nQOOAfgSU1vjALg==
X-CSE-MsgGUID: qapWRI+hQre4QqRcsgBMiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="65533516"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 12:37:13 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: linux-kernel@vger.kernel.org
Cc: senozhatsky@chromium.org,
	tj@kernel.org,
	jiangshanlai@gmail.com
Subject: [PATCH] workqueue: Don't call va_start / va_end twice
Date: Tue, 20 Aug 2024 12:38:08 -0700
Message-Id: <20240820193808.1127501-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling va_start / va_end multiple times is undefined and causes
problems with certain compiler / platforms.

Change alloc_ordered_workqueue_lockdep_map to a macro and updated
__alloc_workqueue to take a va_list argument.

Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 include/linux/workqueue.h | 16 ++--------------
 kernel/workqueue.c        |  6 +-----
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 8ccbf510880b..57a49cc3976a 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -543,20 +543,8 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags, int max_active,
  * RETURNS:
  * Pointer to the allocated workqueue on success, %NULL on failure.
  */
-__printf(1, 4) static inline struct workqueue_struct *
-alloc_ordered_workqueue_lockdep_map(const char *fmt, unsigned int flags,
-				    struct lockdep_map *lockdep_map, ...)
-{
-	struct workqueue_struct *wq;
-	va_list args;
-
-	va_start(args, lockdep_map);
-	wq = alloc_workqueue_lockdep_map(fmt, WQ_UNBOUND | __WQ_ORDERED | flags,
-					 1, lockdep_map, args);
-	va_end(args);
-
-	return wq;
-}
+#define alloc_ordered_workqueue_lockdep_map(fmt, flags, lockdep_map, args...)	\
+	alloc_workqueue_lockdep_map(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, lockdep_map, ##args)
 #endif
 
 /**
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f4b50a995e99..4824056b0a0e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5619,12 +5619,10 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 	} while (activated);
 }
 
-__printf(1, 4)
 static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 						  unsigned int flags,
-						  int max_active, ...)
+						  int max_active, va_list args)
 {
-	va_list args;
 	struct workqueue_struct *wq;
 	size_t wq_size;
 	int name_len;
@@ -5656,9 +5654,7 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 			goto err_free_wq;
 	}
 
-	va_start(args, max_active);
 	name_len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
-	va_end(args);
 
 	if (name_len >= WQ_NAME_LEN)
 		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n",
-- 
2.34.1



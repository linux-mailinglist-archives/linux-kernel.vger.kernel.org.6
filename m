Return-Path: <linux-kernel+bounces-560538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5779A60658
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976C519C430C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73312E336E;
	Fri, 14 Mar 2025 00:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWRQEJfp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD3623
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741910555; cv=none; b=m/iFFBht0mNBTf0BGQYhYZMVYvWgIjgmsMGMESZLNnvqQ0w5YDzF+7epXva78l+nQYAcutNCsL0qeVtnB9xm+XXqkcR3yMmy/8rzGZGsw4yRmStupkey4Yyzj76FaueZ1G2/OF5eCT7vNctxc93lm3Rqdkn1jhKex6+xfduG46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741910555; c=relaxed/simple;
	bh=QYnMAU3kepSgQPK8rWgaUEb44rxqDs5a0JYpwwHyjVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=koOK7gfF/Pfo/5UIenAXPU8bT6So6uBnGk8UgqhiYJ0w1wZ3WIfBQDdGgO3u+NMI9TzD3wYvMs9enwnXFr+wWkxoamEFwgNYh13ftXLRyCtGH3/HUupEABLR4KHBEoz8ZjobJTLhyDRar0qMy5xEfylOl+xO14TCfAK6485asek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWRQEJfp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741910554; x=1773446554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QYnMAU3kepSgQPK8rWgaUEb44rxqDs5a0JYpwwHyjVc=;
  b=HWRQEJfpvdqVb4fTQpLeLvuOUEuNNZ8rks5nRpBrnu8/PFzvd/i29vxn
   HAlZgCx8W4x/buyB+kUhuMNhjMieq8ReD9btQm0GG1Al5DDblju6n/NG1
   FyND8iXFGH/wKR1ElmJavfaIBZmzBVjo1tDGQWF7C7pujMSWva9KXSAs8
   UQ6LHu5LpYYFDDkpAdz7B6NvkGQMl11MoUDm6tB6vx45rUp/kLB5B7z08
   dkHIIc9rWC2KuC1DIOy/8YJkZr6HGIxCir9IRIgbgIgx6a9/+8DueQRld
   /9G0Rm+ze1JBP2uVN4sO/2RL7Q1IjTfcWxHUNS/oQeHuoCm1EuqizLlIs
   A==;
X-CSE-ConnectionGUID: dnMfDd9ATkeX44Bsv3YqDw==
X-CSE-MsgGUID: WlXrQGdeQQSN2wTYCq8gQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43160653"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="43160653"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 17:02:31 -0700
X-CSE-ConnectionGUID: oIzgFu6nSxiXQWyPKKfdyg==
X-CSE-MsgGUID: 8ugg9EqVSceyCIR4kecUAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="125986543"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 13 Mar 2025 17:02:31 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	bp@alien8.de,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	linux-mm@kvack.org
Subject: [PATCH V9 2/7] locking/percpu-rwsem: Add guard support
Date: Thu, 13 Mar 2025 17:02:37 -0700
Message-Id: <20250314000242.323199-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250314000242.323199-1-kan.liang@linux.intel.com>
References: <20250314000242.323199-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

To simplify the usage of the percpu rw semaphore.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: linux-mm@kvack.org
---

New patch

 include/linux/percpu-rwsem.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index c012df33a9f0..af7d75ede619 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -8,6 +8,7 @@
 #include <linux/wait.h>
 #include <linux/rcu_sync.h>
 #include <linux/lockdep.h>
+#include <linux/cleanup.h>
 
 struct percpu_rw_semaphore {
 	struct rcu_sync		rss;
@@ -125,6 +126,13 @@ extern bool percpu_is_read_locked(struct percpu_rw_semaphore *);
 extern void percpu_down_write(struct percpu_rw_semaphore *);
 extern void percpu_up_write(struct percpu_rw_semaphore *);
 
+DEFINE_GUARD(percpu_read, struct percpu_rw_semaphore *,
+	     percpu_down_read(_T), percpu_up_read(_T))
+DEFINE_GUARD_COND(percpu_read, _try, percpu_down_read_trylock(_T))
+
+DEFINE_GUARD(percpu_write, struct percpu_rw_semaphore *,
+	     percpu_down_write(_T), percpu_up_write(_T))
+
 static inline bool percpu_is_write_locked(struct percpu_rw_semaphore *sem)
 {
 	return atomic_read(&sem->block);
-- 
2.38.1



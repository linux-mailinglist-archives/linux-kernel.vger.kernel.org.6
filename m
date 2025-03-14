Return-Path: <linux-kernel+bounces-561859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFDAA61794
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B31461AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C553204C10;
	Fri, 14 Mar 2025 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="krxFLivp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6A22045B5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973213; cv=none; b=mvUuZ8m1y9s9W/n+MYuvuZViq4E1nyREDo9syxcPvyiCe3BDBNw39eigGcMpGpYdAKzbLF5DxYN3sjWOaAKaKtwTBZCW7XtDx/0JliIGI+hiW3Gpg/ACjQsrasWxr+rQNRBED1W0jjVuGxn3z1yFXE7lJrk5v+H4SKs5eKfwI7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973213; c=relaxed/simple;
	bh=dp4AYd5zIokUQ1uGBpUz6CR9JIcnAYZG/kwUZz9JECw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dO1kBbOQc8MJr0B0hvhzM9lZ/fSTxZa4RAeg5SCYmYmQbkeoNBkBF/PKt99TBbvq2mq0jpDzE9ruabLBC35BaTke4biDS4+BRvCE1hCl+/JkvzyjZP11FxvgqcmTj5f3WB/qzptf5caZGOX8LXn6W1sDueEic3r7NiGFB/s3qGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=krxFLivp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741973212; x=1773509212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dp4AYd5zIokUQ1uGBpUz6CR9JIcnAYZG/kwUZz9JECw=;
  b=krxFLivprVww8m8UUQSG5smLfdezszh1anI4sOcGn5WdPGlWvTNXnzcS
   RvM0YW+cL0ViMsNKz/f28+ddnOry7vmPRsTlg2uxiFNmxqopYHniUosCA
   Fns0hghRss31CrYZ0FC5OY25jPDL951xp2fINc8phjB6tCoCOWX+LOOJ1
   I3khAVbk/nbpHzyT97MS1nnhtyeIHlWL0bEuV1YQGKxIvcCQtQxBoErET
   weegkx6S3JOcB2Bq1PG0GyBpf1IXFQXjO6pQe/o+y+ApM4Zr4kYpvYDg9
   UR3jJUDcD54SU4r0P5zjGwYJkSOJ/UCsTgduLv7nzqVYACu8qzAD/xQbc
   g==;
X-CSE-ConnectionGUID: wyVudxfCQtOn2Chv1YhSWg==
X-CSE-MsgGUID: kzUGwsAmSjyadU5RwIL69w==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="54516537"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="54516537"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 10:26:49 -0700
X-CSE-ConnectionGUID: hmq0h1ZjRaa7f3tW9sxG7A==
X-CSE-MsgGUID: Z3xlfc67Sqq2dlP271umew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="152231806"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa002.jf.intel.com with ESMTP; 14 Mar 2025 10:26:49 -0700
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
Subject: [PATCH V10 2/7] locking/percpu-rwsem: Add guard support
Date: Fri, 14 Mar 2025 10:26:55 -0700
Message-Id: <20250314172700.438923-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250314172700.438923-1-kan.liang@linux.intel.com>
References: <20250314172700.438923-1-kan.liang@linux.intel.com>
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

No changes since V9

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



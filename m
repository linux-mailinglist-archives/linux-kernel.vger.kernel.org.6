Return-Path: <linux-kernel+bounces-281604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A8294D8B8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5F31F22E5A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B1A16A954;
	Fri,  9 Aug 2024 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dJ7o0y5j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C70A16B3A6
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723242467; cv=none; b=fowNyTLg7FNO6M65XzbsVxLm9vzYBzVqOjNPKe1tE8BV+fQugu1azNz4iQsX8IhESSCZwomdcnHzCbbgkHONHpXQ/jnxCStI85SRoOZWT00hpolSAddEOWyQySIEh2hNwYg/qZk4mFYx4IDyqJVSwF3t5IHZOGVSEWyDTEPgaDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723242467; c=relaxed/simple;
	bh=ZTr6JyEn1nSzgdfSh1QuqS59D0zZxggT3OqlXoJsrlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tcIcjzhn859yvbFpZripyQzQMnrZzFmOwg9W1x3GqhGL9IhcX2ih/8430rauDEj8XBxeZsOzYJNhjJxXyR8tZbRNKHnr44YTHRyhjsYSbwyOTPwZXxuIhDbUNHZNmDjydJ5a7RKiZJEI+j/DhCvhUHByczrDSIg9ZdRz1x1SKqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dJ7o0y5j; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723242466; x=1754778466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZTr6JyEn1nSzgdfSh1QuqS59D0zZxggT3OqlXoJsrlE=;
  b=dJ7o0y5jzwE0eUxlpsnY4NwvilBn8c7ZguIfFI1DYAsqTCANuiPb17fk
   8knjDXO3BkRH/DWiEmYqKGMtTRQ2jdVG4giILdMsKR296AEPjALtSZ8R0
   sQy8X81epBI1LOnW+DfsW39djx7PY2Y1Hjq2IFIhjncphu/thglJI3I1s
   GSeGsrwdlry75QQrbYv4R8hPJ3EOq7aqSjMfOeBRnsmPoG42vRixezN5z
   7y2x5KfDJV0ylyL+2Pdv557fqvIi+RN+5s+EgYzDi2tyE/J6mIfHEl5Qa
   o6KqE72Cvpe7f++Kk2LbKgROqs6G0tyzsXOq10tG8nV9YorR/0Lxs5+In
   A==;
X-CSE-ConnectionGUID: h9BZz1xvQw6EYpf6SLOyqA==
X-CSE-MsgGUID: Mx7okzGbQoOy/6499idxlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="25229641"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="25229641"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 15:27:43 -0700
X-CSE-ConnectionGUID: LScDgSonScyBM7vJaVgrww==
X-CSE-MsgGUID: N+9j/irpR96KLJvRSuTSWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="62641782"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 15:27:43 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	christian.koenig@amd.com,
	ltuikov89@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH v3 1/5] workqueue: Split alloc_workqueue into internal function and lockdep init
Date: Fri,  9 Aug 2024 15:28:23 -0700
Message-Id: <20240809222827.3211998-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809222827.3211998-1-matthew.brost@intel.com>
References: <20240809222827.3211998-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Will help enable user-defined lockdep maps for workqueues.

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 kernel/workqueue.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1745ca788ede..90a98c9b0ac6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5612,9 +5612,9 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 }
 
 __printf(1, 4)
-struct workqueue_struct *alloc_workqueue(const char *fmt,
-					 unsigned int flags,
-					 int max_active, ...)
+static struct workqueue_struct *__alloc_workqueue(const char *fmt,
+						  unsigned int flags,
+						  int max_active, ...)
 {
 	va_list args;
 	struct workqueue_struct *wq;
@@ -5680,12 +5680,11 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	INIT_LIST_HEAD(&wq->flusher_overflow);
 	INIT_LIST_HEAD(&wq->maydays);
 
-	wq_init_lockdep(wq);
 	INIT_LIST_HEAD(&wq->list);
 
 	if (flags & WQ_UNBOUND) {
 		if (alloc_node_nr_active(wq->node_nr_active) < 0)
-			goto err_unreg_lockdep;
+			goto err_free_wq;
 	}
 
 	/*
@@ -5724,9 +5723,6 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 		kthread_flush_worker(pwq_release_worker);
 		free_node_nr_active(wq->node_nr_active);
 	}
-err_unreg_lockdep:
-	wq_unregister_lockdep(wq);
-	wq_free_lockdep(wq);
 err_free_wq:
 	free_workqueue_attrs(wq->unbound_attrs);
 	kfree(wq);
@@ -5737,6 +5733,25 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	destroy_workqueue(wq);
 	return NULL;
 }
+
+__printf(1, 4)
+struct workqueue_struct *alloc_workqueue(const char *fmt,
+					 unsigned int flags,
+					 int max_active, ...)
+{
+	struct workqueue_struct *wq;
+	va_list args;
+
+	va_start(args, max_active);
+	wq = __alloc_workqueue(fmt, flags, max_active, args);
+	va_end(args);
+	if (!wq)
+		return NULL;
+
+	wq_init_lockdep(wq);
+
+	return wq;
+}
 EXPORT_SYMBOL_GPL(alloc_workqueue);
 
 static bool pwq_busy(struct pool_workqueue *pwq)
-- 
2.34.1



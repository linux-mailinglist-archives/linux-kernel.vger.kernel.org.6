Return-Path: <linux-kernel+bounces-324200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C020974971
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7EDE1F26CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B9653E15;
	Wed, 11 Sep 2024 05:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpRVZUQZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78D748A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031264; cv=none; b=kfakF5YlVeF0UlxywLSFT/TtRchcnV1RIdZBEW1T/m+R21wEtAuIu3Z2055pVrB3FH0Rsb/bfegg3x4vsjEBVUOb8wkOiIlxlCQUzVuHpGi14KYsR6bAnr8NVi9Tr+BkVCgEUTUlbFtsZk/5kZyolw6hXR0XhmF1WsiiF1Ob4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031264; c=relaxed/simple;
	bh=5qoclP/vu8qpNshWN+Gh0DdEMn5dfoAOULzsqnG3DsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=G/sFZ20BX8CkYnbVvucSiBjY3S4lyXx0LRskcg3LVnCh+udzsx08aNKUMw2LCSqcXjuldRFr0pySiWoFAhh5TLlg515Gn/pNc5N9TB+kpu9RjUz7v6s7uZ6QczpW4xG6u40Kf7v2g5l3CRwfJ0X4NSlKn+59behbrlM+b9rX16g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpRVZUQZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726031261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tv7TB9on+PO8089XiiE3rgCcqgQ+LT5rhiFbfeHyTM4=;
	b=GpRVZUQZzcDyDFNC8ukBFTZsCOk2jpHsBLAHThrGI7KIo+sVH+++eElZXR+4io7jLBSXBm
	LcOSXbP550ibKFuQT5TfVT37kJMVc5/4lsOKNkA089spFXbcPlrqJo1ueEEUhHP9PlcayQ
	mWWyz4wCxt3ewR/PFYvN2CISkur6ccg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-s0OBy7vTNkiB9QI0rV7xvQ-1; Wed,
 11 Sep 2024 01:07:38 -0400
X-MC-Unique: s0OBy7vTNkiB9QI0rV7xvQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AB6919560BC;
	Wed, 11 Sep 2024 05:07:37 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.58])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5C8D230001A1;
	Wed, 11 Sep 2024 05:07:32 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH] kernel/workqueue.c: fix DEFINE_PER_CPU_SHARED_ALIGNED expansion
Date: Wed, 11 Sep 2024 13:07:28 +0800
Message-ID: <20240911050728.258817-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Make tags always produces below annoying warnings:

ctags: Warning: kernel/workqueue.c:470: null expansion of name pattern "\1"
ctags: Warning: kernel/workqueue.c:474: null expansion of name pattern "\1"
ctags: Warning: kernel/workqueue.c:478: null expansion of name pattern "\1"

In commit 25528213fe9f ("tags: Fix DEFINE_PER_CPU expansions"), codes in
places have been adjusted including cpu_worker_pools definition. I noticed
in commit 4cb1ef64609f ("workqueue: Implement BH workqueues to eventually
replace tasklets"), cpu_worker_pools definition was unfolded back. Not
sure if it was intentionally done or ignored carelessly.

Makes change to mute them specifically. 

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 - If this is not expected, please ignore it.

 kernel/workqueue.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e7b005ff3750..10ea9d1e65ad 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -476,16 +476,13 @@ static bool wq_debug_force_rr_cpu = false;
 module_param_named(debug_force_rr_cpu, wq_debug_force_rr_cpu, bool, 0644);
 
 /* to raise softirq for the BH worker pools on other CPUs */
-static DEFINE_PER_CPU_SHARED_ALIGNED(struct irq_work [NR_STD_WORKER_POOLS],
-				     bh_pool_irq_works);
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct irq_work [NR_STD_WORKER_POOLS], bh_pool_irq_works);
 
 /* the BH worker pools */
-static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS],
-				     bh_worker_pools);
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS], bh_worker_pools);
 
 /* the per-cpu worker pools */
-static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS],
-				     cpu_worker_pools);
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS], cpu_worker_pools);
 
 static DEFINE_IDR(worker_pool_idr);	/* PR: idr of all pools */
 
-- 
2.41.0



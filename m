Return-Path: <linux-kernel+bounces-349843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C2498FC1B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 04:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3BF28474E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB031BC23;
	Fri,  4 Oct 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzG08dOc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EF93D55D
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 02:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728007230; cv=none; b=nwDC2qHFYXxPS6n2VFByYiPgmgWeXSbNKU/cs+KogcIooh55oCnDM111H//6HCJKKGoIon2vFOqbDbt7mpsV4cPq2wkKtsSRCDA27y0rnzbMY+xpORf/ntHvLBZfrYZ3B+VF2RGTgKmHgxtrOKt8y3h0wzJ8Ua0IQ0DKEcQQg2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728007230; c=relaxed/simple;
	bh=8AVf/hwze/5baY+1Gra15GOYyq2bi/jH2hqtiFjGc7A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZ38YiFdPNhDS5PMktxXkhSxFnnEHI7pazeZ0hD/ePfqJVBLfg2MSbW25/n6Vu4bUIXLpMmTsQWH6EtO9uIJMgZJifbgTmzaei9sin2a0p6aZN4rIVfoaWesFJL+t1hzlA88v1bWktBTJYJUY5ZWDqZidT68U7YjFKMj0HLrQh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzG08dOc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728007227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ka5Cv+MBxLJO+Sw188++gI12rAdTxumDlQnEmXZkrew=;
	b=GzG08dOcOaAY3YKskWXVXoGSMVikkylZZCnZWrzmYVBSQ1kTNaN1VFy85qz55cYYUgtPs0
	WYu6h2qayE1mCA4O1EBpIVtSRd7u/1OMNQYfBEpuEV9t4YTfa/kBDgrqTDftnFPg6uYvLm
	C7cf7GDqwqHVI5FtlloUNjSNb3rxU4E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-mTfJqz24M36r-R9G0ieiXg-1; Thu,
 03 Oct 2024 22:00:26 -0400
X-MC-Unique: mTfJqz24M36r-R9G0ieiXg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2CE7B1955F42;
	Fri,  4 Oct 2024 02:00:25 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.45])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F79F19560A2;
	Fri,  4 Oct 2024 02:00:20 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 4/7] vhost: Add the vhost_worker to support kthread
Date: Fri,  4 Oct 2024 09:58:18 +0800
Message-ID: <20241004015937.2286459-5-lulu@redhat.com>
In-Reply-To: <20241004015937.2286459-1-lulu@redhat.com>
References: <20241004015937.2286459-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add back the previously removed vhost_worker function to support the kthread
and rename it vhost_run_work_kthread_list.

The old function vhost_worker was change to support task in
commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
change to xarray in
commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index fed6671c1ffb..349499139f4f 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -418,6 +418,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	__vhost_vq_meta_reset(vq);
 }
 
+static int vhost_run_work_kthread_list(void *data)
+{
+	struct vhost_worker *worker = data;
+	struct vhost_work *work, *work_next;
+	struct vhost_dev *dev = worker->dev;
+	struct llist_node *node;
+
+	kthread_use_mm(dev->mm);
+
+	for (;;) {
+		/* mb paired w/ kthread_stop */
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (kthread_should_stop()) {
+			__set_current_state(TASK_RUNNING);
+			break;
+		}
+		node = llist_del_all(&worker->work_list);
+		if (!node)
+			schedule();
+
+		node = llist_reverse_order(node);
+		/* make sure flag is seen after deletion */
+		smp_wmb();
+		llist_for_each_entry_safe(work, work_next, node, node) {
+			clear_bit(VHOST_WORK_QUEUED, &work->flags);
+			__set_current_state(TASK_RUNNING);
+			kcov_remote_start_common(worker->kcov_handle);
+			work->fn(work);
+			kcov_remote_stop();
+			cond_resched();
+		}
+	}
+	kthread_unuse_mm(dev->mm);
+
+	return 0;
+}
+
 static bool vhost_run_work_list(void *data)
 {
 	struct vhost_worker *worker = data;
-- 
2.45.0



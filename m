Return-Path: <linux-kernel+bounces-228856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8329167D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0AB1C25359
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D36215FA85;
	Tue, 25 Jun 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1RKMGn1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4152E14A4C7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318383; cv=none; b=D1Q9AA5Ys5l2bXq5ZeL6pT0Fg5PJcqxnzxIbj6ed7x/hWvJCqA/IM9ITdoOHwGEONAGIpIWjt5aX8/6VNV2OpLNKNk/YDwL7uYLBts29QgbRajkb7h4XXbTnvGnlXtKILuVsLznE1tBrXXRw4Y/5f6KfraRn+FaPU2t/Dm/GjKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318383; c=relaxed/simple;
	bh=2WUZ7LXGCMYKUjKWDYs9fgLmiaCHl3iV3Mpp0Lke7rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=nqQuO7b2Rz23mu3OsHBrtcbp2LRIEhNiLkGj9pzP8d93OlQzXm86JzszH3BGsUd2W9LkFvajRVXlh23UDbEGeLlpcERFDUZxfXC8OPPCK9tUPo4XpkJzbfXwOzRFCjk8DZvPO/Tq3tlpKK172ic3fYroJaorsiZg0z5XRhuXiEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T1RKMGn1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719318381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTitNVRGPj2/sy+vCINs/a5dERClA89sJfbo+NdMWMQ=;
	b=T1RKMGn17qb3/VHlUiKcijdavLFgM306pequa5DwaTbpFI6eoGTHGtpEtq/qHbzMbYXIAn
	+08eFmw/0Q8DLv5/8M9OLj+duu81XYqzjnLfLnQb4IjcQs5kakKSkJilqTdQVhUeSRcCOR
	Z7hXnPqspSMMfMVHphL53ZZ7/MvNH2c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-62ruxzYmOgaHLh82rnGNzw-1; Tue,
 25 Jun 2024 08:26:16 -0400
X-MC-Unique: 62ruxzYmOgaHLh82rnGNzw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA8F4195609D;
	Tue, 25 Jun 2024 12:26:14 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.34.111])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 54A8F1956057;
	Tue, 25 Jun 2024 12:26:12 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	chaitanyak@nvidia.com,
	hare@kernel.org
Subject: [PATCH v8 1/2] nvme-multipath: prepare for "queue-depth" iopolicy
Date: Tue, 25 Jun 2024 08:26:04 -0400
Message-ID: <20240625122605.857462-2-jmeneghi@redhat.com>
In-Reply-To: <20240625122605.857462-1-jmeneghi@redhat.com>
References: <20240625122605.857462-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch prepares for the introduction of a new iopolicy by breaking up
the nvme_find_path() code path into sub-routines.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/multipath.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 8a4d0e377114..0ade378e514b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -291,10 +291,14 @@ static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
 	return list_first_or_null_rcu(&head->list, struct nvme_ns, siblings);
 }
 
-static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
-		int node, struct nvme_ns *old)
+static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns, *found = NULL;
+	int node = numa_node_id();
+	struct nvme_ns *old = srcu_dereference(head->current_path[node], &head->srcu);
+
+	if (unlikely(!old))
+		return __nvme_find_path(head, node);
 
 	if (list_is_singular(&head->list)) {
 		if (nvme_path_is_disabled(old))
@@ -340,7 +344,7 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 		ns->ana_state == NVME_ANA_OPTIMIZED;
 }
 
-inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
 {
 	int node = numa_node_id();
 	struct nvme_ns *ns;
@@ -348,14 +352,19 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	ns = srcu_dereference(head->current_path[node], &head->srcu);
 	if (unlikely(!ns))
 		return __nvme_find_path(head, node);
-
-	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
-		return nvme_round_robin_path(head, node, ns);
 	if (unlikely(!nvme_path_is_optimized(ns)))
 		return __nvme_find_path(head, node);
 	return ns;
 }
 
+inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+{
+	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
+		return nvme_round_robin_path(head);
+	else
+		return nvme_numa_path(head);
+}
+
 static bool nvme_available_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns;
-- 
2.45.2



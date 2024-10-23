Return-Path: <linux-kernel+bounces-377810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4F39AC723
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCDB283314
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A519E997;
	Wed, 23 Oct 2024 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULlnjceg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE55719F13F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729677307; cv=none; b=DSeFxr1Vv2tYYDSOPtLrWFTTuYdXXJKrlS2NLdK8DQ4bgOKhjUNOY3ebOMgSjc9pUAJf+7HJ/ynnrpIafU1zakmwc2W7RBjHyY5Xw3NS//x7ONszbtuG8VCPKrVNvWdzvKpT/Q+pgsW0FvZ8JDRU5eSzp040tm9rgupfAL/ei9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729677307; c=relaxed/simple;
	bh=dEtJywqzX9NlCIsXbk6wbkz14aF8BZqWYkvg6LKGRZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pll2ASJmSa31a8CKgfCuGTwH3O9zRJQeRA34JxIgH/JAeFkDSYQAVAQse9AU2vV4BSMFYobR7ROzj6NAczJuZ6t28knMpkjCNlngck3jWjoSLs138wvz4LwGTh390+mRwlrk1sZNomltkLCBja35CnpTaW5Fj9oEXhPTl8n3Ad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULlnjceg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729677305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDWZQpe65meGR6CH+Ygs8rTGaxpZEfZwq23nZiUncY8=;
	b=ULlnjceg72UiAq4tdPx7tVxxbd4XSt0WFxk/J0Hef952w2foQMcRC+jqgMKNMQvd/0nK/P
	x5qR3yalPAjmyyY5zPIpbl3g7hUOgEF2ikAvMo1YN8iLTUEB8HyJVhhFhw8r+76pc9PV2h
	FqsGAh740aQYwHxTKcy37aq853XIyCY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-dw2ZXFFvPeS1l5XK2Hi2tg-1; Wed,
 23 Oct 2024 05:55:01 -0400
X-MC-Unique: dw2ZXFFvPeS1l5XK2Hi2tg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAD9419560AF;
	Wed, 23 Oct 2024 09:54:59 +0000 (UTC)
Received: from localhost (unknown [10.72.116.171])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EA06300018D;
	Wed, 23 Oct 2024 09:54:56 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] blk-mq: add non_owner variant of start_freeze/unfreeze queue APIs
Date: Wed, 23 Oct 2024 17:54:33 +0800
Message-ID: <20241023095438.3451156-2-ming.lei@redhat.com>
In-Reply-To: <20241023095438.3451156-1-ming.lei@redhat.com>
References: <20241023095438.3451156-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add non_owner variant of start_freeze/unfreeze queue APIs, so that the
caller knows that what they are doing, and we can skip lockdep support
for non_owner variant in per-call level.

Prepare for supporting lockdep for freezing/unfreezing queue.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 19 +++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b2c8e940f59..2c84c2d2510d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -196,6 +196,25 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
+/*
+ * non_owner variant of blk_freeze_queue_start
+ *
+ * The queue needn't to be unfreeze in current task, and non-owner use is
+ * fragile and easy to cause race, please try your best to avoid it
+ */
+void blk_freeze_queue_start_non_owner(struct request_queue *q)
+{
+	blk_freeze_queue_start(q);
+}
+EXPORT_SYMBOL_GPL(blk_freeze_queue_start_non_owner);
+
+/* non_owner variant of blk_mq_unfreeze_queue */
+void blk_mq_unfreeze_queue_non_owner(struct request_queue *q)
+{
+	__blk_mq_unfreeze_queue(q, false);
+}
+EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_non_owner);
+
 /*
  * FIXME: replace the scsi_internal_device_*block_nowait() calls in the
  * mpt3sas driver such that this function can be removed.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 4fecf46ef681..c5063e0a38a0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -925,6 +925,8 @@ void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
+void blk_mq_unfreeze_queue_non_owner(struct request_queue *q);
+void blk_freeze_queue_start_non_owner(struct request_queue *q);
 
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
-- 
2.46.0



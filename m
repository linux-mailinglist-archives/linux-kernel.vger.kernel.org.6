Return-Path: <linux-kernel+bounces-380800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110019AF63D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97221F22BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3EE1173F;
	Fri, 25 Oct 2024 00:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MaJfSqWZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76F5AD2C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729816679; cv=none; b=Ih5dgRi2FJCmezjeFQqR8sm23N3risEtL8Ooi0haKBX+RlJ+V0cfmtNpKpkVfKF5irnZi2Mfi7GSz3kDUiuhe9eF3f+tvXVaxs7am7XAdVA8sjSkT/tEClbwJTf85drQNwSx4iDMXt0rUZ3pbC79jangGjuDFNrnLmgmQhrFvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729816679; c=relaxed/simple;
	bh=Olg2lpE8qFdYHK1854gCWeI/rvnaCSXJqNbsUpx8ubA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocd7PmwZy7VS9aLPtKjscSQqjnOi6vjGP3hldyxRg+MqE6xVzC6haj2XP61xH33rnwIGMOsIdMPar3+EiPz+DHJ5EorYkvxKCzrZYLVVFNFUN+eeb33brl8oyMLy20d9Ohts2s1HXGDk+92DG+n4APkf3s9EDzEKFn5jpk7/hiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MaJfSqWZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729816675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uE1fr5Ij3ZfzUwzW5aMbdzvUD+Foxf2eQ6lm2mTzYMU=;
	b=MaJfSqWZbtFBJo+8Ejv1zjAnpCH3exa6+rzQ6ZOf1+B1Tn1bwkQXCFy50ROcq6eBZBZdbz
	QjYQFz7WZunvrcxDmauyKGcC9E4WbMpHG7+ZZs2yM6zSxWF2pBbTAfBjNdESn1dpLSy+5d
	0lU8MHqzPXMVTrQvuOTb+WuRqKMQK88=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-LJYOV8XoMXS9NDdZSkRLTQ-1; Thu,
 24 Oct 2024 20:37:45 -0400
X-MC-Unique: LJYOV8XoMXS9NDdZSkRLTQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0F071956096;
	Fri, 25 Oct 2024 00:37:43 +0000 (UTC)
Received: from localhost (unknown [10.72.116.27])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7FF30196BB7D;
	Fri, 25 Oct 2024 00:37:41 +0000 (UTC)
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
Subject: [PATCH V2 2/3] nvme: core: switch to non_owner variant of start_freeze/unfreeze queue
Date: Fri, 25 Oct 2024 08:37:19 +0800
Message-ID: <20241025003722.3630252-3-ming.lei@redhat.com>
In-Reply-To: <20241025003722.3630252-1-ming.lei@redhat.com>
References: <20241025003722.3630252-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

nvme_start_freeze() and nvme_unfreeze() may be called from same context,
so switch them to call non_owner variant of start_freeze/unfreeze queue.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba6508455e18..66d76a9296b1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4871,7 +4871,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
 	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
-		blk_mq_unfreeze_queue(ns->queue);
+		blk_mq_unfreeze_queue_non_owner(ns->queue);
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	clear_bit(NVME_CTRL_FROZEN, &ctrl->flags);
 }
@@ -4913,7 +4913,12 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 	set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
 	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
-		blk_freeze_queue_start(ns->queue);
+		/*
+		 * Typical non_owner use case is from pci driver, in which
+		 * start_freeze is called from timeout work function, but
+		 * unfreeze is done in reset work context
+		 */
+		blk_freeze_queue_start_non_owner(ns->queue);
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
-- 
2.46.0



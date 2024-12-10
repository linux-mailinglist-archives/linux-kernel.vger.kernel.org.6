Return-Path: <linux-kernel+bounces-439971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B059EB73C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18619284FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9333F237A37;
	Tue, 10 Dec 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B30658la"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75240234986
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849163; cv=none; b=D+oE5Vd0V1BcB91Q5OgW6K3vXuRnrCbJvZLgD7e0d7gshG0iChjictbkwClsW+3LIY5/DyC4TgRFrbESzef1yWbmZFMba+DM/1Pr3qCenhab+HcEi+ADQ9knJ9g8X5dLVYIlICBGO4j+Z3uGZNyMrBdqWPUepye3nkWmgnUvxrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849163; c=relaxed/simple;
	bh=Kp0iIIE/kSL/BU14HXYAIg5EU4ZZS6Kg8QDyOD4nqiQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcYDDZlOUBpfHmVUHxXPtUgYdRNX/3mIW3hw9wqglQrWO67g8CPWKKJ+KeVDwoXhSwoee2scw/IJumQ0H4l5EDoekCrl6MrDH2DwvfZDqRUhdXt98GjeH2FYOIjplvGQ4d3lEso2hpuHFce3AmBrBirs5Sx8OpQhxyxXvIRCFFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B30658la; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733849160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76z9zS4RFMPn2YcEr8rESUAPULegGSBBggeYhtMkPgk=;
	b=B30658laYUk61noh+MChVD7D64p626p+qKntprZ/kuE+ovG9WL5sWh7oNEj8wdgY0RWFij
	liMG5watntiaRkIILbo1hkIEYkWfCVzj+lz42/BQmvgRqQM0MsJgKxgyUJhY8EcIgjPMKB
	zoxPHHtfuTO2xUgY456FGbzqX7R1KsM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-66HnsfF7NO6ROf4rHCso8A-1; Tue,
 10 Dec 2024 11:45:59 -0500
X-MC-Unique: 66HnsfF7NO6ROf4rHCso8A-1
X-Mimecast-MFC-AGG-ID: 66HnsfF7NO6ROf4rHCso8A
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E84A01954ADC;
	Tue, 10 Dec 2024 16:45:57 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.152])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DB2C19560A2;
	Tue, 10 Dec 2024 16:45:53 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 6/8] vhost: Add kthread support in function vhost_worker_destroy()
Date: Wed, 11 Dec 2024 00:41:45 +0800
Message-ID: <20241210164456.925060-7-lulu@redhat.com>
In-Reply-To: <20241210164456.925060-1-lulu@redhat.com>
References: <20241210164456.925060-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The function vhost_worker_destroy() uses a function pointer in
vhost_worker, which is initialized based on the inherit_owner
value.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index d1aec41bcd56..3e9cb99da1b5 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -701,7 +701,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
 
 	WARN_ON(!llist_empty(&worker->work_list));
 	xa_erase(&dev->worker_xa, worker->id);
-	vhost_task_stop(worker->vtsk);
+	worker->task_stop(worker);
 	kfree(worker);
 }
 
-- 
2.45.0



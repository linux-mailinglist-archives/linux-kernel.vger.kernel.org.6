Return-Path: <linux-kernel+bounces-396034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5623D9BC703
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5F81F2382A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B061FEFDA;
	Tue,  5 Nov 2024 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYXsOIvx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411A41FF7A1
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791676; cv=none; b=Yb/bamvwzlIYxAj+gy63J90MEtgHtg8Uc+tVYiRdoi/7vzykUG+NGqz92OU5g3orDZ/UDYCoPuleFs8gnh47ZBjKYWcYr9OQjplRvyDTpaWVGPqNGWsVIR3rDQ6LuStoYauZyFrvVGfFPuyimQUFwzWU+mdhJG8HpWC6vHL7mVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791676; c=relaxed/simple;
	bh=+38GjQ5iNed2+14XtChEVV9Ul7oBJUOLzQdRTNmOgpQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jp2zaDQJqQ0Z9UeOu8Iy2nZmjyIBFXJOmHaoiKv6Oyq0gwdt8KKWIS1GD6wBlCodiXgajYxd5cgiER0wFKTreEEuf2xo+aqDfCEHY9fVT5puZzRblHer3C+U88dMYd6GkW7A7dbywxHZwXrPU0+P31uq4nV/g9/eOPVzN5Od1dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYXsOIvx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730791674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPknO6DVyO1LjLhZHYo5oROtWHiUqkzRt9HMN0ycP2A=;
	b=TYXsOIvxwmu9XSPwwwHW6oMO3Qgo+ocWSyfXLwzLf7AfpPshRRy4/Hg2tWZFAP08mxoB0P
	tFlCE1q9OvH4++ghtAS5orLLLhD2IRkhrdjdrblOiuIPWYrf+ufKuZUse+JY7oLrpMuKC8
	0I/1271BTwE0rJ9BJIZfh2pZeQuwwyw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-18RcnFfyPAuvZxSF-A6PBg-1; Tue,
 05 Nov 2024 02:27:50 -0500
X-MC-Unique: 18RcnFfyPAuvZxSF-A6PBg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6BC719560A2;
	Tue,  5 Nov 2024 07:27:49 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64CC91956086;
	Tue,  5 Nov 2024 07:27:44 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 5/9] vhost: Add kthread support in function vhost_worker_queue()
Date: Tue,  5 Nov 2024 15:25:24 +0800
Message-ID: <20241105072642.898710-6-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-1-lulu@redhat.com>
References: <20241105072642.898710-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The function vhost_worker_queue() uses vhost_task_fn and
selects the different mode based on the value of inherit_owner.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 603b146fccc1..8b7ddfb33c61 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -238,13 +238,18 @@ EXPORT_SYMBOL_GPL(vhost_poll_stop);
 static void vhost_worker_queue(struct vhost_worker *worker,
 			       struct vhost_work *work)
 {
+	if (!worker && !worker->fn)
+		return;
+
 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
 		/* We can only add the work to the list after we're
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &worker->work_list);
-		vhost_task_wake(worker->vtsk);
+		worker->fn->wakeup(worker->dev->inherit_owner ?
+					   (void *)worker->vtsk :
+					   (void *)worker->task);
 	}
 }
 
-- 
2.45.0



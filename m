Return-Path: <linux-kernel+bounces-396035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43089BC705
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61B01C221EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F4D1FF02D;
	Tue,  5 Nov 2024 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Voto5gTr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EE81FF7CB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 07:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791680; cv=none; b=UzHWlxSP/MiIu8WAeWHWl3eS+OuC5A8XYUr6Ym7P4FN1tgVram68ULmSXwZy8ZXgATEfzIvQcj6oeWDhAiNHa5TUHzPozFtSS+XR1P0m4l+MWPFkr0T2Ckmm4s40YRhDuEIR63esrL8TRIpk/YRfMTFZD2nU74NTnQbo1LoxBPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791680; c=relaxed/simple;
	bh=M49i9Z80LvRN1KH00nCqmQiLAV5d1TcbHzx3zh4khGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6UgN93pF4+LE2HfmAtaWx3GZMtPD/bK0bYGTPNJw9qYuWwGqmaAqkM4ZMoWoZTYm8a0tOUscO/T2LJkwL3QvW9qboVKhzZauXHrziVOEWpqgMKsY4s9V3HQOq+EhS6o9491vVxEthLZdMQWNgQH+AM1DXusybhurJ7UTMoP0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Voto5gTr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730791677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1m4NUSQOwh8h3S2yfP06X/nb4pg21Jt9eMtwUyyXqBQ=;
	b=Voto5gTrBd9tol/whxXwvflJsNrxZHI7Kd8otQQzltpD6h8OueKKjwNTQPdZLZXt1mcyZg
	MSrU/4u/UP+gwvQzEpp8zjHsjd2gQX9iZJHRbea1mZZgUf4JHFsPIHUVnq7h7epYXzio1q
	l2wXogtNWEK18uDTbO1zPe6JiDo6q6M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-p_ZQeHAjNgOwXe-RNXUbxQ-1; Tue,
 05 Nov 2024 02:27:56 -0500
X-MC-Unique: p_ZQeHAjNgOwXe-RNXUbxQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCC5519560AB;
	Tue,  5 Nov 2024 07:27:54 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B52F1956086;
	Tue,  5 Nov 2024 07:27:50 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 6/9] vhost: Add kthread support in function vhost_worker_destroy()
Date: Tue,  5 Nov 2024 15:25:25 +0800
Message-ID: <20241105072642.898710-7-lulu@redhat.com>
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

The function vhost_worker_destroy() will use struct vhost_task_fn and
selects the different mode based on the value of inherit_owner.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 8b7ddfb33c61..c17dc01febcc 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -718,12 +718,14 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 static void vhost_worker_destroy(struct vhost_dev *dev,
 				 struct vhost_worker *worker)
 {
-	if (!worker)
+	if (!worker && !worker->fn)
 		return;
 
 	WARN_ON(!llist_empty(&worker->work_list));
 	xa_erase(&dev->worker_xa, worker->id);
-	vhost_task_stop(worker->vtsk);
+	worker->fn->stop(dev->inherit_owner ? (void *)worker->vtsk :
+					      (void *)worker->task);
+	kfree(worker->fn);
 	kfree(worker);
 }
 
-- 
2.45.0



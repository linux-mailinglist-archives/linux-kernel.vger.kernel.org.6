Return-Path: <linux-kernel+bounces-226584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAFA9140A0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CC31B20975
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9F279EA;
	Mon, 24 Jun 2024 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVMrgsEw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2976FB1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719197158; cv=none; b=Hl8KBRmPjkDQKPgC9jMVLOC7pGmvIaNW/koDnwNYbfN6P1gPWDsS3fn5gfWQgEBVCW+gfiF05mpfLtQubFREhhiuGIPH0ih2C9pQkAHMjnSsjKwaXXc3bkD4zqWpPkn5Wzvs9wBUx7Bgq7VIw2iDqwWC7WNqPf/embNhRHKE4CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719197158; c=relaxed/simple;
	bh=lHMBMN1aOOtIjA3goGFM8RsDgSslvqlT0CFKvQne9HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PY309fXbfSmewT8Xg9/qjnHCsd/MdggOiKnN5MEmiMrhEzuPN2pY26kwFgGZf+u41pnnHUfg14Fp+cEljLoQA28fx2bgi8cvds+tmyXKzUUCPxDiy7zkDgngtk4CE3bY+OUBvznFVjCgXWVppKwgkuZ7m4g2UDG1RGyg5ZxLHOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVMrgsEw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719197156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8ma79Lf12qsH/HRx/hyZ2J2F2i4kk451VRlEuUsJkU=;
	b=EVMrgsEwOcJbydi4FZO4hT87G6DA2e5ciHIy8XgK251Cbd2OdpJO5SKY7XTA304v0Ju0v+
	STKpRHeqWRVs0cweEWimqh94ULVDI9eESflMyT92oiDxrMTUCqnzyXta/tPdVeNUcHcf9/
	mktOHoJlGA/9ATDQX5ghTFOicm71M9U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-EpZqdHUWMp-q_eNjjqwztA-1; Sun,
 23 Jun 2024 22:45:54 -0400
X-MC-Unique: EpZqdHUWMp-q_eNjjqwztA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5198619560BF;
	Mon, 24 Jun 2024 02:45:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 961B33000218;
	Mon, 24 Jun 2024 02:45:43 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: [PATCH V2 2/3] virtio: export virtio_config_{enable|disable}()
Date: Mon, 24 Jun 2024 10:45:22 +0800
Message-ID: <20240624024523.34272-3-jasowang@redhat.com>
In-Reply-To: <20240624024523.34272-1-jasowang@redhat.com>
References: <20240624024523.34272-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patch exports virtio_config_enable() and virtio_config_disable()
for drivers to disable config callbacks.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c | 6 ++++--
 include/linux/virtio.h  | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index d3aa74b8ae5d..a4622a62aac3 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -143,14 +143,15 @@ void virtio_config_changed(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_config_changed);
 
-static void virtio_config_disable(struct virtio_device *dev)
+void virtio_config_disable(struct virtio_device *dev)
 {
 	spin_lock_irq(&dev->config_lock);
 	--dev->config_enabled;
 	spin_unlock_irq(&dev->config_lock);
 }
+EXPORT_SYMBOL_GPL(virtio_config_disable);
 
-static void virtio_config_enable(struct virtio_device *dev)
+void virtio_config_enable(struct virtio_device *dev)
 {
 	spin_lock_irq(&dev->config_lock);
 
@@ -165,6 +166,7 @@ static void virtio_config_enable(struct virtio_device *dev)
 
 	spin_unlock_irq(&dev->config_lock);
 }
+EXPORT_SYMBOL_GPL(virtio_config_enable);
 
 void virtio_add_status(struct virtio_device *dev, unsigned int status)
 {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 4496f9ba5d82..bc5e408582c9 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -163,6 +163,9 @@ void __virtqueue_break(struct virtqueue *_vq);
 void __virtqueue_unbreak(struct virtqueue *_vq);
 
 void virtio_config_changed(struct virtio_device *dev);
+
+void virtio_config_disable(struct virtio_device *dev);
+void virtio_config_enable(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
-- 
2.31.1



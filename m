Return-Path: <linux-kernel+bounces-430569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A1A9E32F1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 06:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61F4284F1F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CBE18FC75;
	Wed,  4 Dec 2024 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="e+Z/auLe"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326F318F2EF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 05:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288902; cv=none; b=mnAajQQdsVRc3lxyPj8IlZ09wpXyTOz5VIijm2X2pW2txLhhF98PBJiGpIxEtU+vRwqZRyW9KznlRTzAZQa0PbR0ouiNk/aIzd7GazcdO1p5IKC7ooneYnKigi1rwJ7YJySkf0P802gTRtIm342cDgn4oVGhdoveoOm4Hq3uE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288902; c=relaxed/simple;
	bh=/hxsPKXVZNwPj0FSFmTo2DxSrpBL+nEcvnadMx1VMr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iU9UxEi8zp6fj4rmsJKE+jb+HMwBTSEfsFuVTcDUQc/aXllg387Qnd5v8t6AiNOkdetPD2lxYrv7E5N/1psQ5tiNSvyC+YlTgMxzkQZ8210gaVzwFpL/QfU2Oc9sjJjQPqFBvoFsQVUhPec1iLrahEeuhaQYHQqebgnwqa/pJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=e+Z/auLe; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C44883F1CE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 05:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288899;
	bh=cMQ1mn6QkKh++9sVefHm/YQARbeGOPYVwGZmbPvclzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=e+Z/auLe4VrP/HY06rKtp4J1/jkJ7IlDoYUNgfe9m6hcDPyfvAqUkpUh1MApIMp1x
	 B/xbSuhQvt5tDzT2mfCU1UzZ8vWgOukWp/G3D9C31OP5jf25txTbADO0R3R67EL4H0
	 kgveLAt9mbzvRdFWnVOvXH+RsDakydwksvuu75NjQaZOeyoFnPyWfTwy9vCMaTnB4c
	 dwJxaZmcxQqHEaJ9nmTnW16BrBvSVe/APU3EfiJyS6h8N7U0axEjJQCqSQ3nFisLrX
	 XPRWdT7QVUr6ggUahYlKmAXXMix0L8WwSNDhsG1K05bJg126qBncDQYAKQ5apNe13z
	 /ck584pR0Nkhw==
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7251d37eac5so7164408b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 21:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288898; x=1733893698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMQ1mn6QkKh++9sVefHm/YQARbeGOPYVwGZmbPvclzE=;
        b=PY1V11eXd/mnG9dPJPT+nfnaZudlNhOY3NGCw3FOaMQ6WX2TBg58waFFbwpnVkFxqV
         E69rUeK7vdX1N4SraqeTg+R5KdTb65YqiHX6EUqnH9wTwBYyK5cM1lzo7tPzYCbL+MOm
         +OBMexvSLJODn29Keq/zLawJ9is+IObe1Xf7TJhudBcuS1+U+PZGGi+3o/gfBSrPbKHo
         ArJ9Yz+Ak7HERPKX97HPUmCWVTcqwOU4V+EKLT1AmTSv3J9PNoKaSs1n5WW4ZcXeLhtI
         Wj9V6WSXxiAnI56aXSwWvc67DttmS0rqO6Zhr6BcZfH1yBkBepfzRc9tK7Ad0Cwd2f46
         klfw==
X-Forwarded-Encrypted: i=1; AJvYcCXGlr1/nvMJMbfKy2Kyei/q2wH7Mp8XGDYNGz9lKtMUB+cytqTr6Ut4wkaXca0eHaNOLGoTsB98y3BDu0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YywyetisR3iVlnJhcEVbJKRfPle2WoEG7XXDDvaYZfEXUTxbaPa
	rQBxc0/rb1e6JaTLq22v0lw/gNX9vnuXhW1MrnIRsXyb2Jy9Qn1N5yWof1I8zTqyQ/286m25SVK
	KySBZFH5xB06QjETxsMTjT+W4S8QW7rvkuXzFHdFQbdkCTcvc/NcsJjtkefT43pWQ67xvf5zTsy
	Qrxw==
X-Gm-Gg: ASbGncvi9HzJp5HkS3mOxjLZLQfW5wmUvmDZZP9f26/xWOGHwvQCv5/Ho8byPansQLO
	B62T7oBThPyKo46M/tdf3qPSyaJNuw9UKwHFvxdB0C5WzcTd198pokpfN6TD2nVIVrfSUjomr10
	uLcBsX2a8wr+WTMZrgYYXfDz7cti2iOWOLSmC7YZxCZKDt2m8L09zioDEpTQWJBCsTPocphhydw
	GZzhojgGbwIHV4iCB489kfHhAcqY7YHImV3iLGAiPymOV34XQA0+qQg1uLmZFkS1DOS
X-Received: by 2002:a05:6a00:3c8a:b0:71e:5fa1:d3e4 with SMTP id d2e1a72fcca58-7257fa45248mr6730698b3a.2.1733288898384;
        Tue, 03 Dec 2024 21:08:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzK4BK1oktH3ckDZBRjHOokufY6SEBLhJ5DJ7e1vYZicOqoakq+cqHgepP7ZCNIOpN0Nx7ew==
X-Received: by 2002:a05:6a00:3c8a:b0:71e:5fa1:d3e4 with SMTP id d2e1a72fcca58-7257fa45248mr6730677b3a.2.1733288898066;
        Tue, 03 Dec 2024 21:08:18 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:17 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net-next v3 6/7] virtio_ring: add a func argument 'recycle_done' to virtqueue_reset()
Date: Wed,  4 Dec 2024 14:07:23 +0900
Message-ID: <20241204050724.307544-7-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204050724.307544-1-koichiro.den@canonical.com>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When virtqueue_reset() has actually recycled all unused buffers,
additional work may be required in some cases. Relying solely on its
return status is fragile, so introduce a new function argument
'recycle_done', which is invoked when it really occurs.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c     | 4 ++--
 drivers/virtio/virtio_ring.c | 6 +++++-
 include/linux/virtio.h       | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d0cf29fd8255..5eaa7a2884d5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5711,7 +5711,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
 
 	virtnet_rx_pause(vi, rq);
 
-	err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
+	err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf, NULL);
 	if (err) {
 		netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
 
@@ -5740,7 +5740,7 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
+	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, NULL);
 	if (err) {
 		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
 		pool = NULL;
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6af8cf6a619e..fdd2d2b07b5a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2827,6 +2827,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  * virtqueue_reset - detach and recycle all unused buffers
  * @_vq: the struct virtqueue we're talking about.
  * @recycle: callback to recycle unused buffers
+ * @recycle_done: callback to be invoked when recycle for all unused buffers done
  *
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
@@ -2838,7 +2839,8 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  * -EPERM: Operation not permitted
  */
 int virtqueue_reset(struct virtqueue *_vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf))
+		    void (*recycle)(struct virtqueue *vq, void *buf),
+		    void (*recycle_done)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	int err;
@@ -2846,6 +2848,8 @@ int virtqueue_reset(struct virtqueue *_vq,
 	err = virtqueue_disable_and_recycle(_vq, recycle);
 	if (err)
 		return err;
+	if (recycle_done)
+		recycle_done(_vq);
 
 	if (vq->packed_ring)
 		virtqueue_reinit_packed(vq);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 0aa7df4ed5ca..dd88682e27e3 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -112,7 +112,8 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
 		     void (*recycle)(struct virtqueue *vq, void *buf),
 		     void (*recycle_done)(struct virtqueue *vq));
 int virtqueue_reset(struct virtqueue *vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf));
+		    void (*recycle)(struct virtqueue *vq, void *buf),
+		    void (*recycle_done)(struct virtqueue *vq));
 
 struct virtio_admin_cmd {
 	__le16 opcode;
-- 
2.43.0



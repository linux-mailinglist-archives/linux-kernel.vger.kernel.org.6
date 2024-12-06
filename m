Return-Path: <linux-kernel+bounces-434203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 202739E631E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DE528338D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EE0153812;
	Fri,  6 Dec 2024 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tbca2gfv"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075D41537D4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447525; cv=none; b=Pbc6P3FOYOGq7keOZzlOrEWoUcS+VRSTT3iYEl4WNSNs17PgLKqEClMX9grQAr5CT7Wvdnm2z40aHUBUWcIpk4Bl1D7ihCAbg+JF8/G5Z3buP+hVbiA4tAJra/jiqu47+dRW5OmkDraJJ46tG8YmHVL2WFFYhdana3uiKc4RS5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447525; c=relaxed/simple;
	bh=HSdpSrosBpFjoXoHgEPxOFMdxecD/sTFHyHuYcmRo44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCgH9eSyltu+JDypk+CGztGJ2q52z/UQzvXFHaoJpMTcDzJaeNyjtrbRccya/CEntHEs0uBl0OO86h7qJk+3+nhuIFTAR4y9vaFJlZDLuBgcur7Ko4kVWqfZ9Vzf6w9LwS+Sl+nlMoku/MSoGOsna/shPaEFk1Lk6K9JIYWnJz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tbca2gfv; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3549A40AFF
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 01:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733447522;
	bh=3okZ7Dk5bsE+ZlwnvoQtqX4jE3/LzcC69p28rg/sS/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=tbca2gfv2PwPq0DU19SM1pmigc1fn0BZaJvbxBrAJMD3swtG4VWCOvQPozh5UA1AS
	 M31/yHYVuq0VqFg1BH+mUEu4o15cnyyVILDUj4WUOIK3xslNK8mraF0RBJXCIIMUC5
	 QgDe9sMs/mFs+Yf/LRbHO6tqFuzr8WgxUuBUzJgYiJFCshgOFnzhIblluovSwPVZuD
	 ahyd4pPdc6i4PQa5pYeTugFmA9nomhNUsDSaZkT0WJUYHkYh2HKNIrbKMMFVQeZi9J
	 wMErPd1BLaiEHFQWOV6mepi9M5fzE38e5mVAQFGLfSvGYrSdQsgawkOIqjVT2V+IQ4
	 U4SOx1Tt8mb8Q==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-215c54e5ceeso14102475ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 17:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733447519; x=1734052319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3okZ7Dk5bsE+ZlwnvoQtqX4jE3/LzcC69p28rg/sS/E=;
        b=sKzv2dQ9Os0IUhXsoWQcw0f/CXsB3Px5lT3/mTlizbUBqsy/j9L9+UwVTC5a1wYiS5
         Ny5UH5CRR8BjZIMoRadFNcdXXs8AZQbb88yvuZkUrBbq34TDqMgBcIC6EsCtr/CR95uK
         nmhcgrfecOymq0ipR6hgoIh1iiuj+UUwPmprq9hONA/k7yrVPim5QKjqQem4LFwg+w3B
         xiz9aaARe97PCPsUo73T68tZkrP7Fqdar5ssZIpnyejCb6112OF2AmxLbM4EIgGLhK5T
         vRizxr1Y3Y0bL0tRIM4d8GwKxjalexOMWMsb++zns8JxbV5vQ5DLJw9O24DgXgVjtZSE
         oZHw==
X-Forwarded-Encrypted: i=1; AJvYcCV3CbbJVpwqnsHWIwwYciQ3M2ExwwFSBfo44uxqHZGfjkrzxysLPh4qbytwiIujGGZRUmMVbVclN67S0vM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlnset3E2u9rynyCKo6aTm4XyCxvqy6Ovw/h4WStD/N78sGv02
	qMpPhRWCyivNRH3OgxIf7In+UE6HyAeMO3U0PU2YWCvozCpYilBw4+9Dus4J4Fu/26RDNRKsd3Q
	anXJphbuoxW7KLeIN0drkqsZRFYorNovwrHfOMYojEnBLQhvUTmionHQZciIevqcdHDq4D/DSMR
	nz3A==
X-Gm-Gg: ASbGncuBqyAfx+n2hiKl3RlecAwpMPvzmq5lGSH5hblZTzLjUdgwKPZLuZjycTcPeBY
	xGbdLQBsMn+QXS2NQdBl2ixpejSB3C8AgIWww0MNd1hNt3nNZiADp35H5cO9xxyGdO56W3irQM9
	xE5IQf5hbpq2YhVS7G8AaE3hKu9ha0GwwxYuoGFcOJefBQbpLWGhZBheXYAW59ETIuL6T4ZhguZ
	54/zZ1N0zlfL6IzFb4U3xxPylcBGZ4gow4ypERux+qCmVno2FM=
X-Received: by 2002:a17:902:f601:b0:215:b13e:9b14 with SMTP id d9443c01a7336-21614d75a53mr12429215ad.25.1733447519043;
        Thu, 05 Dec 2024 17:11:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQJN3aYvWonWOaVQbbwag0krwaPJYzGL0PhqRtYyRPCKfavtSDhMd7s04xv5fglvYMegTrDg==
X-Received: by 2002:a17:902:f601:b0:215:b13e:9b14 with SMTP id d9443c01a7336-21614d75a53mr12428985ad.25.1733447518781;
        Thu, 05 Dec 2024 17:11:58 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:9740:f048:7177:db2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa18esm17979355ad.123.2024.12.05.17.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 17:11:58 -0800 (PST)
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
Subject: [PATCH net v4 4/6] virtio_net: ensure netdev_tx_reset_queue is called on tx ring resize
Date: Fri,  6 Dec 2024 10:10:45 +0900
Message-ID: <20241206011047.923923-5-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206011047.923923-1-koichiro.den@canonical.com>
References: <20241206011047.923923-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_tx_resize() flushes remaining tx skbs, requiring DQL counters to
be reset when flushing has actually occurred. Add
virtnet_sq_free_unused_buf_done() as a callback for virtqueue_reset() to
handle this.

Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e10bc9e6b072..3a0341cc6085 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -503,6 +503,7 @@ struct virtio_net_common_hdr {
 static struct virtio_net_common_hdr xsk_hdr;
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
+static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq);
 static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct net_device *dev,
 			       unsigned int *xdp_xmit,
@@ -3394,7 +3395,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf, NULL);
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf,
+			       virtnet_sq_free_unused_buf_done);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
 
@@ -6233,6 +6235,14 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 	}
 }
 
+static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq)
+{
+	struct virtnet_info *vi = vq->vdev->priv;
+	int i = vq2txq(vq);
+
+	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
+}
+
 static void free_unused_bufs(struct virtnet_info *vi)
 {
 	void *buf;
-- 
2.43.0



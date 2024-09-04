Return-Path: <linux-kernel+bounces-314630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C93696B60B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A2F1F22A4B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDCA1CC17A;
	Wed,  4 Sep 2024 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QyoyVeJZ"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C4219B3F6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440944; cv=none; b=gF0Sv0j9WlPqGcWhFiDuAkPlLN9kwqXQ9rx4nWjHV+cTUvU+j3cjoQQfFG3xaEDB8K1trUJGu2eF85X9OqlI9WtMeuzCAlMUHOp0dCBp/OchaxwqOxfcgdVxPIUWMr8RDBKD9tc4afgSs2GZW+rQZVhsXInCYD+Ret/7o25yRVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440944; c=relaxed/simple;
	bh=PlJdXfCl7z5GITdFrA3sDKLcDG9iFjX/X4c3rw7NHVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sCR9EmddUPctDJXUze4izfQHyWTo8HtdjGKb9z8jseIKcVhItjU56yC8XqLWBpzskbrpaySSAGIid6j0fxGsqzjQrZZf55n+9zJnxYSnb/ND7JI2CdkEMg/FM6BpD5jG3JvyCcXWBgpSonqjiHMSXRzBaWlf6Rzbkou8pyZKzpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QyoyVeJZ; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-277e6002b7dso1555779fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 02:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725440942; x=1726045742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7eCTU1AOHaUUwMtmGS3dOCXqi4sZOm3TtWxsQHb+32g=;
        b=QyoyVeJZFgvY+jHHdyS35CNBePkg/4Sn2h3v65Oo2k3SCDhqK4UKyQQcUTwWHGUVTj
         684MojfaEAZwIIly91Y30o9lnn5Mtyy80fHAG7rDysEJ5I/2NjbumxBfix3E0A7vRlIy
         Et9jHNlBqldprvj8ZGJ4hO0VCrRLkxtgyyKJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725440942; x=1726045742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eCTU1AOHaUUwMtmGS3dOCXqi4sZOm3TtWxsQHb+32g=;
        b=nWkUHG1xwFFjKVp2a2WlqhSmj90JQW5wxhUptlt5Rc3lG1g6CEp56sHW045pqtNB6s
         97lcpE8ILK+DCuDwJBopat+byYoidjIugv48Z6gTBTW5XbPi2f7kELI30fXQOegfQTDd
         h8766a20LNRLQ9hBRyW6QbrNofnSdu5avO73wZEh3vIx7ow/Ydg6Y5xH9MJyuPIn7NOP
         UFgvGZ0pXnl/wyOtD9sywaHin7kxtXY/EBdnygK9OtMkI9yACsPyF58kgK+EOS6Acmov
         WW4pGQrvc0OiY1BbNSpDp9BJl1nKIwPN1g8Hw7/Uq13goGaQKEPNnXTnWxRd5s46+UdV
         Gf2g==
X-Forwarded-Encrypted: i=1; AJvYcCWXxb+PVTjzxtpUltkrbxxig7lUuZOEm4j+6e47Lv3azD5a+YAKFRdulTja44NEUhxI5T2FN5WBgbAQB70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxooIEu7qJNKit6gp9DpCnlkIxTdJvHoqhicIrZf6EM/ZjygBmu
	96tkiNl0iO02bM56WPFLzACtDp2jcyyAVttYQWWytBH95WG1XMg42iVQmAnWhg==
X-Google-Smtp-Source: AGHT+IEuKwdsL6Brf++PqlqKCm8Wb2D1A/dk6x7le3ZX0A36iHJ+V6NVDFzn0XXFrxLbntFKkyBZKQ==
X-Received: by 2002:a05:6870:390a:b0:25d:e3d:b441 with SMTP id 586e51a60fabf-277c81ed3a6mr14723563fac.40.1725440941752;
        Wed, 04 Sep 2024 02:09:01 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177859aa50sm1206994b3a.175.2024.09.04.02.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:09:01 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Breno Leitao <leitao@debian.org>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v4.19-v5.10] virtio_net: Fix napi_skb_cache_put warning
Date: Wed,  4 Sep 2024 02:08:53 -0700
Message-Id: <20240904090853.15187-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit f8321fa75102246d7415a6af441872f6637c93ab ]

After the commit bdacf3e34945 ("net: Use nested-BH locking for
napi_alloc_cache.") was merged, the following warning began to appear:

	 WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_put+0x82/0x4b0

	  __warn+0x12f/0x340
	  napi_skb_cache_put+0x82/0x4b0
	  napi_skb_cache_put+0x82/0x4b0
	  report_bug+0x165/0x370
	  handle_bug+0x3d/0x80
	  exc_invalid_op+0x1a/0x50
	  asm_exc_invalid_op+0x1a/0x20
	  __free_old_xmit+0x1c8/0x510
	  napi_skb_cache_put+0x82/0x4b0
	  __free_old_xmit+0x1c8/0x510
	  __free_old_xmit+0x1c8/0x510
	  __pfx___free_old_xmit+0x10/0x10

The issue arises because virtio is assuming it's running in NAPI context
even when it's not, such as in the netpoll case.

To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
is available. Same for virtnet_poll_cleantx(), which always assumed that
it was in a NAPI context.

Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
Link: https://patch.msgid.link/20240712115325.54175-1-leitao@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on v4.19.y-v5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f7ed99561..99dea89b2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1497,7 +1497,7 @@ static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
 		return false;
 }
 
-static void virtnet_poll_cleantx(struct receive_queue *rq)
+static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int index = vq2rxq(rq->vq);
@@ -1508,7 +1508,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 		return;
 
 	if (__netif_tx_trylock(txq)) {
-		free_old_xmit_skbs(sq, true);
+		free_old_xmit_skbs(sq, !!budget);
 		__netif_tx_unlock(txq);
 	}
 
@@ -1525,7 +1525,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int received;
 	unsigned int xdp_xmit = 0;
 
-	virtnet_poll_cleantx(rq);
+	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
 
@@ -1598,7 +1598,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit_skbs(sq, true);
+	free_old_xmit_skbs(sq, !!budget);
 
 	opaque = virtqueue_enable_cb_prepare(sq->vq);
 
-- 
2.39.4



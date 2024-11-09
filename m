Return-Path: <linux-kernel+bounces-402737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BE19C2B52
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 10:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9511F21ED6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 09:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF382145A1E;
	Sat,  9 Nov 2024 09:19:20 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5D41DFD1
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731143960; cv=none; b=MgEGLZh9huOMzOkNxMRnkYxS9txegDPuMNkFPiK3jG5MUNUCXA3ti1ZfUrSwDeJ46T99qsILaTNLQZKKZq3G1AJigL3c2K6pQ/t3oK7566IDN5Q9YweTTXtwBS3p5MeA7XAYTeGSjmkVYJHDuYlryM6TsIvGoUi1hKJ9K20dtmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731143960; c=relaxed/simple;
	bh=izouzB/5ns6y4szMVLv6hmt1MHQuVilQ2FqjaH9P09w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALoQqaRkojzHGeu2acsEPiP+xIQbLH3BSSlLpy6suG6E0A3JtZjR2JWGKZlOYkeq5QGymGken/nWnirl4JC9JKs1ZMelsxs0jYtDQCKpjXDEE9S4PyUPjlE32KAZEIW5s0sI/vwgYJuk0NKGx4CvS5A3mXxxzzpP36dnN3gX6vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: aed4f01c9e7b11efa216b1d71e6e1362-20241109
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:a7f4d244-5893-4a49-95b0-3a0b52fc30ee,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:3be22847dbd25ccf88b01841480c1bec,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0
	,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aed4f01c9e7b11efa216b1d71e6e1362-20241109
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1824792887; Sat, 09 Nov 2024 17:19:12 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 2B348E0080FF;
	Sat,  9 Nov 2024 17:19:12 +0800 (CST)
X-ns-mid: postfix-672F2910-395305
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 71926E0080FF;
	Sat,  9 Nov 2024 17:19:11 +0800 (CST)
From: zhangheng <zhangheng@kylinos.cn>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhangheng <zhangheng@kylinos.cn>
Subject: [PATCH 2/4] staging: octeon: Use DEV_STAT_INC()
Date: Sat,  9 Nov 2024 17:19:09 +0800
Message-ID: <20241109091909.4038571-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

syzbot/KCSAN reported that races happen when multiple CPUs updating
dev->stats.tx_error concurrently. Adopt SMP safe DEV_STATS_INC() to
update the dev->stats fields.
---
 drivers/staging/octeon/ethernet-tx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeo=
n/ethernet-tx.c
index bbf33b88bb7c..f9c38bf25851 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -442,7 +442,7 @@ netdev_tx_t cvm_oct_xmit(struct sk_buff *skb, struct =
net_device *dev)
 	case QUEUE_DROP:
 		skb->next =3D to_free_list;
 		to_free_list =3D skb;
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		break;
 	case QUEUE_HW:
 		cvmx_fau_atomic_add32(FAU_NUM_PACKET_BUFFERS_TO_FREE, -1);
@@ -516,7 +516,7 @@ netdev_tx_t cvm_oct_xmit_pow(struct sk_buff *skb, str=
uct net_device *dev)
 	if (unlikely(!work)) {
 		printk_ratelimited("%s: Failed to allocate a work queue entry\n",
 				   dev->name);
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		dev_kfree_skb_any(skb);
 		return 0;
 	}
@@ -527,7 +527,7 @@ netdev_tx_t cvm_oct_xmit_pow(struct sk_buff *skb, str=
uct net_device *dev)
 		printk_ratelimited("%s: Failed to allocate a packet buffer\n",
 				   dev->name);
 		cvmx_fpa_free(work, CVMX_FPA_WQE_POOL, 1);
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		dev_kfree_skb_any(skb);
 		return 0;
 	}
@@ -644,8 +644,8 @@ netdev_tx_t cvm_oct_xmit_pow(struct sk_buff *skb, str=
uct net_device *dev)
 	/* Submit the packet to the POW */
 	cvmx_pow_work_submit(work, work->word1.tag, work->word1.tag_type,
 			     cvmx_wqe_get_qos(work), cvmx_wqe_get_grp(work));
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes +=3D skb->len;
+	DEV_STATS_INC(dev, tx_packets);
+	DEV_STATS_ADD(dev, tx_bytes, skb->len);
 	dev_consume_skb_any(skb);
 	return 0;
 }
--=20
2.45.2



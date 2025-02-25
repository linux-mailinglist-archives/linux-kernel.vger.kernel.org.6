Return-Path: <linux-kernel+bounces-530387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AACA432CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840A4189F233
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE43126C10;
	Tue, 25 Feb 2025 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SeVNVpXz"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC13156F5D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740449118; cv=none; b=Dyhb4LB4S6zxqcHPSuUsUuQ2Vjpf3UEFJKUEO6yFA5/L7Omi1R5Cwxf/4X87e3TiUHBBJWC8Dz+wtwDeRZIxs4dzACI1w9sYiU9ufC+jd0g2TIuXNVCToN/WveIXS2sLAcQuI6ilfLRkopyuhIANWJsY2XZVG70WMtqrxGzHUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740449118; c=relaxed/simple;
	bh=sqHw+hydx5+J+3nTg7GiF/z4kDtuYCJJCVEcYQMUN3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VioV/4FFyHMHG25LSpmGvXeM9eGmApLS/OICgd621eSxUYb49NV2kyS3pjpCgt4SVh78TudDfz0JelAYTdmThLU65ykx67FneSS0HTRRYnrn+TB3YIyZTxTXe+3aOpfmSndB2FPb3G1F8LAJ+dlrKdh3nDpBamIjmASUHf5Y6kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SeVNVpXz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f42992f608so7929452a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740449116; x=1741053916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jTrPXbJae2NFrVRDORH6UMqB3L+3yI0Uf5GqI0AUQw=;
        b=SeVNVpXzBVmWL24GcetM5Sq9Fmxm4MTy37KknoKqfo5uz6UzqUGpwtSyIm/7WLmRsg
         QhDzFre74qNDcOkHjyAfLiVs0BO5XF/gn0zjMmxaWMINkhXwgAd+j35CUtA/CUj6CWxR
         GGWZ5dTw0Hn7mHgDI1+QxSJ657/ymjj2DpgwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740449116; x=1741053916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jTrPXbJae2NFrVRDORH6UMqB3L+3yI0Uf5GqI0AUQw=;
        b=p7Aez2cB0j8vaEu4LImIuz5HNQ0lrN2PdGktM8RzNn+Y4AEZzf1/5xsBjn96NV1Uju
         HSEHshDEerB69JwcPU17HeYehqKd9Nqz9pILp08V3gAiu5naEqwG29UReGzekwsutJQn
         CAPPOYiQN5TFDvHfhBx3CD4AZsr5p2p25HfDm5Wp5F4ZhBj31qwHSQBTOc/n7YvDuXPo
         yi6DgDvSAx8ynji/Vitud0wMnHavuNorPJtBego++AbhVHo4Zx3fFD4RLf/WN4lN2F+z
         89RMz7aI2nJbskdh8qLV42XX+mC3RG/5PdBbvVEmRDvp6yvQzYwPpuLlQGM9nXBjZzOt
         Pm2g==
X-Forwarded-Encrypted: i=1; AJvYcCXzkIOpU0EUOyLNuyna0K0NiF2rPjo+WyECIRTbFRyygCqkgCjviJuuUkrYubr2InzYiKhsQU5lm0Q0iSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KNAnaK4lzyMdL2RQ6hSrCwfWf11oL9i9xmURLKwpZbTElQku
	SAkuqzGEDWwCsaPsFZhcye7ImuVL+TrkY31mDzmd5b836MQDs5xu7KqXxyOrn2plz53FvV+K9nA
	Tyes=
X-Gm-Gg: ASbGncsi4WI4FIo3dXN7eEgbf+Gw4s0uBOt6A7ObWWUbPn4CdAzQxR+h+ZjB0T2wV0K
	+oPhdZJw6tPiMS4MHyDJVl08bD8LpxfdoAc+X5+CcP0O9zi1uzQZGGQWnMueHBB9H9lihjVkhxF
	BB3N32nRzTAGzgrATbTFUs/QJXNzkSXAEYdKpGudKQamNFTIlrgrTb1AZ7C5M5EhE1hjOvNzxza
	yatGJ/eSEDtfE+n83INl5U4OMxWc/93mWMajDzI/EJdSpQPRaNoCZl7Ht//IQz7SBEzXF6FEOve
	CvFTEGm3Kci0b8T+hLJtVxOggN+/2WEwJA==
X-Google-Smtp-Source: AGHT+IGbedvJQbC1f3rBktTR2fDXpQeCE8dIxMRlL1M+qlTRLacNZdzhniWMjgESJ1sAs0pz8D4XNA==
X-Received: by 2002:a17:90b:4a41:b0:2ee:4b8f:a5b1 with SMTP id 98e67ed59e1d1-2fe68cf3fc4mr2493123a91.24.1740449116365;
        Mon, 24 Feb 2025 18:05:16 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a021909sm2926985ad.94.2025.02.24.18.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:05:16 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	gerhard@engleder-embedded.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 4/4] virtio-net: Use persistent NAPI config
Date: Tue, 25 Feb 2025 02:04:51 +0000
Message-ID: <20250225020455.212895-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225020455.212895-1-jdamato@fastly.com>
References: <20250225020455.212895-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use persistent NAPI config so that NAPI IDs are not renumbered as queue
counts change.

$ sudo ethtool -l ens4  | tail -5 | egrep -i '(current|combined)'
Current hardware settings:
Combined:       4

$ ./tools/net/ynl/pyynl/cli.py \
    --spec Documentation/netlink/specs/netdev.yaml \
    --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'type': 'tx'}]

Now adjust the queue count, note that the NAPI IDs are not renumbered:

$ sudo ethtool -L ens4 combined 1
$ ./tools/net/ynl/pyynl/cli.py \
    --spec Documentation/netlink/specs/netdev.yaml \
    --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'type': 'tx'}]

$ sudo ethtool -L ens4 combined 8
$ ./tools/net/ynl/pyynl/cli.py \
    --spec Documentation/netlink/specs/netdev.yaml \
    --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
 {'id': 4, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
 {'id': 5, 'ifindex': 2, 'napi-id': 8198, 'type': 'rx'},
 {'id': 6, 'ifindex': 2, 'napi-id': 8199, 'type': 'rx'},
 {'id': 7, 'ifindex': 2, 'napi-id': 8200, 'type': 'rx'},
 [...]

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 13bb4a563073..186030693eeb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6454,8 +6454,9 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 	INIT_DELAYED_WORK(&vi->refill, refill_work);
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		vi->rq[i].pages = NULL;
-		netif_napi_add_weight(vi->dev, &vi->rq[i].napi, virtnet_poll,
-				      napi_weight);
+		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
+				      i);
+		vi->rq[i].napi.weight = napi_weight;
 		netif_napi_add_tx_weight(vi->dev, &vi->sq[i].napi,
 					 virtnet_poll_tx,
 					 napi_tx ? napi_weight : 0);
-- 
2.45.2



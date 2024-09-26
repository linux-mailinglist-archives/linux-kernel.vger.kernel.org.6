Return-Path: <linux-kernel+bounces-339835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85419986B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4AB1F233D9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1762E183CD6;
	Thu, 26 Sep 2024 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="U9OP4OLN"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D517B513
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727319649; cv=none; b=Fjaqbf0WVWh6abrpysgnPEJzAHI+fmCZxRkQb03RWaLtnEmZIair/G2lhv+b2aO3PaNRu20RcO7LJaFp6cAmTXkkGjyg9Y/8V6wE+hoYlJ+nIB2qTh7+wq0xfmzeThq/mNdNWRvHhW0YLvH1NfK9V8UyR+vtpqjb93BIDYfOsmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727319649; c=relaxed/simple;
	bh=fOP1RW8xaYXgo6UAKNyyCaNdqYpSFEzAXlb1gulSoCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h2Z5ISrnzIOBZ+J+iTjc2A3KGYr/tCsSs57UZHlrSgBDW4Pun1mWIeCq9feSFC5YPPJIfO6utQ0nFvPKNfcUNeV9tJmq86qV+groV8YiKq2NaFI6j+AZsLHXVCz1LfqHi7zIymoE7oksv8oMQIV4pOYXOtjKAqtoOv2+GquwFO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=U9OP4OLN; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-719b17b2da1so432189b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 20:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727319647; x=1727924447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Go4TL5YXIlZZjrMduyK+IYQM3hDPDoYu1c/gM7Xg4NM=;
        b=U9OP4OLNmdPKBCZkhRLl1Y8pWLWiIM3gNP6ukhz+HMKlPan5/Pw9RFUN8T1mrqbUxP
         m4R5jJ9sy2BH3PTGb0JKnyB1hOr9hOtBnhhQzBL3kNfD/AoRwvxG7nCfn8qS3Tn7X/5H
         RTi+8i2BsqLVicmXWiHl3jXjMJbfN0AxoPEz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727319647; x=1727924447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Go4TL5YXIlZZjrMduyK+IYQM3hDPDoYu1c/gM7Xg4NM=;
        b=H/rZj6xTNl4RDprOZ3rMkyjrbVt0nwp2DPui37hVJze6hQmcwanXE9ST+uNvGaOsuM
         +7Zv7jxq66InZyFBvMRpTcBM9APeoHDGQgjT19oU7CwVHONpSFefwEteYvNXt9WvvfP7
         40J5piO4iqD20pTMF6mG34rwDXpJwztY8y7wIkBUvLPaazGLwajwMGvNIU5gbs5RCvzf
         FPXWkcVugm6FXm0PUJHy3u9ZEI7PBfsqhFGKFTeEraq14kVQmf+j0HyS2WTlA2uRWtwx
         XhXEB1OHkg5mwdQ0nb4DZt2mKxx8wGqTTxfylH5WOp/yfgqmCm8HO9nC3vPdFqXfFLb9
         IzUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV5WDvrgInQa904I/4OM89XLcUKotiYq6Zoo0nMf6OiS/pUnCq2aNjho9F4A/sPqhe6ng3NyRb/oWk2yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcvjRNb/BQqhYZ8dZ+aE42PQa+Sr969cTJGNNp8dnbwU8XAjUn
	Sz6rlidYZmTyu7THw+1ELPKhJk2Mxzix8VJco9U4YKWBIlJAoK7gCpi7JxPCWck=
X-Google-Smtp-Source: AGHT+IHo/QvXYlAQpeWJb8WEqJxzH+RaMo6+alDlGBaUSCq3IFim3Y3CWxECI4I1FBHAIyJCrPXsJw==
X-Received: by 2002:a05:6a00:174c:b0:718:d94b:4b with SMTP id d2e1a72fcca58-71b0aaa22ddmr6704494b3a.6.1727319647069;
        Wed, 25 Sep 2024 20:00:47 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc97c2a8sm3354111b3a.163.2024.09.25.20.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 20:00:46 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 2/2] gve: Map NAPI instances to queues
Date: Thu, 26 Sep 2024 03:00:22 +0000
Message-Id: <20240926030025.226221-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926030025.226221-1-jdamato@fastly.com>
References: <20240926030025.226221-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the netdev-genl interface to map NAPI instances to queues so that
this information is accessible to user programs via netlink.

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
			 --dump queue-get --json='{"ifindex": 2}'

[{'id': 0, 'ifindex': 2, 'napi-id': 8313, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8314, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8315, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8316, 'type': 'rx'},
 {'id': 4, 'ifindex': 2, 'napi-id': 8317, 'type': 'rx'},
[...]
 {'id': 0, 'ifindex': 2, 'napi-id': 8297, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8298, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8299, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8300, 'type': 'tx'},
 {'id': 4, 'ifindex': 2, 'napi-id': 8301, 'type': 'tx'},
[...]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 661566db68c8..da811e90bdfa 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1875,6 +1875,9 @@ static void gve_turndown(struct gve_priv *priv)
 
 		if (!gve_tx_was_added_to_block(priv, idx))
 			continue;
+
+		netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_TX,
+				     NULL);
 		napi_disable(&block->napi);
 	}
 	for (idx = 0; idx < priv->rx_cfg.num_queues; idx++) {
@@ -1883,6 +1886,9 @@ static void gve_turndown(struct gve_priv *priv)
 
 		if (!gve_rx_was_added_to_block(priv, idx))
 			continue;
+
+		netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_RX,
+				     NULL);
 		napi_disable(&block->napi);
 	}
 
@@ -1909,6 +1915,9 @@ static void gve_turnup(struct gve_priv *priv)
 			continue;
 
 		napi_enable(&block->napi);
+		netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_TX,
+				     &block->napi);
+
 		if (gve_is_gqi(priv)) {
 			iowrite32be(0, gve_irq_doorbell(priv, block));
 		} else {
@@ -1931,6 +1940,9 @@ static void gve_turnup(struct gve_priv *priv)
 			continue;
 
 		napi_enable(&block->napi);
+		netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_RX,
+				     &block->napi);
+
 		if (gve_is_gqi(priv)) {
 			iowrite32be(0, gve_irq_doorbell(priv, block));
 		} else {
-- 
2.43.0



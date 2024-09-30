Return-Path: <linux-kernel+bounces-344845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC1998AEDD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30481F219F9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90EF1A2C0C;
	Mon, 30 Sep 2024 21:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jwdGHszC"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E576D1A284A
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727730478; cv=none; b=oQAR4ct6HobaC7HEZd0uHGx5c49hZEHvN2DVs00MtQUnVi/UmyTvfsE/opDsxXNhgUZnYpWT6fqGbbPuzTqvhsdOxKEhcx9NvVAVXDhC9NZ4XNI7VUc/3ej8oz+5Hy6AXAqp5eRsJgWc/xqmy5MQtZ2V/SAGa032OQhLxhAdy1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727730478; c=relaxed/simple;
	bh=5pEd4BRaR9Lunjg0fDKMGKtOehrFlWLLxYni9JjSKGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaMHTr+ngqlj9nqEZuxuiKDD9AMPcZpQgobBNuIZMNo1LU7EZgmWRjgQoCTaJ89QeMe2TQApgVvZkFEmh25ZIjd+YUqe2wrOslvNngVQ5/43T3EzeLwnek2mEsBXmKHG/icwAy7f20zeeQ2dDmvN3pjpqDBg/IwdQN5BeDz6lik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jwdGHszC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e0a950e2f2so3752204a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727730476; x=1728335276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qhy/eIcYUU/FYB8Yva0fnrqDzEaqYHdkFo8c9EaozE=;
        b=jwdGHszC087tOTQT6519bxEiz856IjJ9cigfGgLCzsr0RRaao3t3xAqmB6Un+OrAtM
         +NEhywNrcpNkRPR6GwLx+Q9XmbuIpjtdCBgAi8uyjHi3tjq06nXpZX7IyAPb3ros0Pt0
         fY5zC4w26pAbobG1YC76HE3n9R/7oHCK5wAlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727730476; x=1728335276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qhy/eIcYUU/FYB8Yva0fnrqDzEaqYHdkFo8c9EaozE=;
        b=QVv70VuLlDFoDccOaUtAo15e07v1aXEthBbdWpwCzkY8xhyB1jbU7mww9LJOEk4Y+B
         BiQ9luFN98/lOEN9CNTfeq/XKaCh/ru1Q/X+36aOl4tCZfQr+dMYIBZWo5Ehx2aWbEEm
         Q+sz+RZX2+IcQ8Sy87auVFNDAoXDYvdYtCN7QVVUfUERiOtrgWzpMFW9/xfSAenBD54m
         3bG6rFiM9lWFdLgbwzcnJm4ohM7zssaTWGQ0M3S4RPR1r+5zDcijLmNxc0EM87jK7342
         7O4kg2BCfUoaRtvge5eIg7YhAcUsNrCWWkTXMBR0OzdNOC0JCXnKYff39J313vN2zgiD
         E2ow==
X-Forwarded-Encrypted: i=1; AJvYcCUzUpw0VDfv9AMMw7+pDTneyF5JzyL30lYpSV3UYTeDbebVWcjUw+AcjBZZ9nc5X1WeKm4p9xch8ZWjpoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgGFjnwTZAH9uI1/rdIhWSYM61L0bIO8qqllZm2YxnKzYSUOxm
	dcZu6BKdygYPlnl/w4rrjybHe6kTsS+zOdEr7tUMNn30KmlDu4d5nK61+x2WNxw=
X-Google-Smtp-Source: AGHT+IH12d57PmNt5MTcpHoZ629eFxcezgIbQ+59xZVEm0Nj3wdAa46Bm1xaik8a9mc6BNhrGvWnJw==
X-Received: by 2002:a17:90a:df0e:b0:2e0:a508:77f2 with SMTP id 98e67ed59e1d1-2e0b8e97ec3mr15745448a91.25.1727730476275;
        Mon, 30 Sep 2024 14:07:56 -0700 (PDT)
Received: from jdamato-dev.c.c-development.internal (74.96.235.35.bc.googleusercontent.com. [35.235.96.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bcddsm8427642a91.4.2024.09.30.14.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 14:07:55 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pkaligineedi@google.com,
	horms@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v2 2/2] gve: Map NAPI instances to queues
Date: Mon, 30 Sep 2024 21:07:08 +0000
Message-ID: <20240930210731.1629-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240930210731.1629-1-jdamato@fastly.com>
References: <20240930210731.1629-1-jdamato@fastly.com>
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
 v2:
   - Check that idx < priv->tx_cfg.num_queues in both gve_turnup and
     gve_turndown as suggested by Praveen Kaligineedi

 drivers/net/ethernet/google/gve/gve_main.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 661566db68c8..294ddcd0bf6c 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1875,6 +1875,11 @@ static void gve_turndown(struct gve_priv *priv)
 
 		if (!gve_tx_was_added_to_block(priv, idx))
 			continue;
+
+		if (idx < priv->tx_cfg.num_queues)
+			netif_queue_set_napi(priv->dev, idx,
+					     NETDEV_QUEUE_TYPE_TX, NULL);
+
 		napi_disable(&block->napi);
 	}
 	for (idx = 0; idx < priv->rx_cfg.num_queues; idx++) {
@@ -1883,6 +1888,9 @@ static void gve_turndown(struct gve_priv *priv)
 
 		if (!gve_rx_was_added_to_block(priv, idx))
 			continue;
+
+		netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_RX,
+				     NULL);
 		napi_disable(&block->napi);
 	}
 
@@ -1909,6 +1917,12 @@ static void gve_turnup(struct gve_priv *priv)
 			continue;
 
 		napi_enable(&block->napi);
+
+		if (idx < priv->tx_cfg.num_queues)
+			netif_queue_set_napi(priv->dev, idx,
+					     NETDEV_QUEUE_TYPE_TX,
+					     &block->napi);
+
 		if (gve_is_gqi(priv)) {
 			iowrite32be(0, gve_irq_doorbell(priv, block));
 		} else {
@@ -1931,6 +1945,9 @@ static void gve_turnup(struct gve_priv *priv)
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



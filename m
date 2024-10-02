Return-Path: <linux-kernel+bounces-346873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCA498CA12
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C881C219E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279851C2E;
	Wed,  2 Oct 2024 00:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="sLldTGhJ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AF8F66
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727829257; cv=none; b=ALZxPHpMPhVVxom6AebApBM5TRfDJ7Abhnz5hBO5T2VBvYszIi08zuisYZCANwMIW3/ZUAJLDSWZHcqlBDr7Qnju5EEX6iMypK4CUoccZ+J39kL2xy16AbqR/cXczjIL6ZT+AIYpxISBCUeLoS0tmvDjk23UjsncO4cm5euBeDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727829257; c=relaxed/simple;
	bh=yStr/6PJPenHSI7D8HokTLRUj51fig9mf3TfmVYcCLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p0eGUcnNB/g4HWedlxXudC8xr9+jnKf6MsErw4ctHp23RSypf7G2mKkds8AybyTEsW6/L3AcgLQ2y8Swdgf7Gs2SXV1lJElI48JRXYhGX6ssZL8NiGHChlS3Zb96HQhX3XMxMxvLqzG+LwkPSI5UIdy/37UQsN97uHotRDNCx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=sLldTGhJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b86298710so26195545ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 17:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727829255; x=1728434055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSZqwRLg8/VfUGa/yJh0BLiOqFcBWWUlHrlyk3W8pCU=;
        b=sLldTGhJzHsCqhdRcsHu5fpCh2Mo9E9kyNkcK4ycJKIxXVz+A8vZpNthUtQuBRfEPW
         vWcms+ZXSNcdxphJwdPc4OkVJDZHZzCjmKmElgbpChjmalyIym8JrZkHaQirTExyUPFl
         /lERu5OR6o2bHL9FEo3XZ4mWJO+VG97uRNkhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727829255; x=1728434055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSZqwRLg8/VfUGa/yJh0BLiOqFcBWWUlHrlyk3W8pCU=;
        b=SyckwrF26AwylEHljNy/8YQaHHIdHV+/X9fTqz9jvwfXmVRhw9fiz4aFwBl25D5PiI
         NzSF1g6/fCXT+8/GGKqz0AZY8wGnXSv6fP7WwXZmARe4gkfU+2RbFxdF70erql/+d/fH
         KcfBGWVkyhD9C9h6u2iZ6smc3qyqTpIy2Ydf85KfWqAOwReZjYsWrJmK8Q7XeLIcWgb7
         bOzd5ULNEJ0jukn/ItSl0BG0TR/NJxyeLrOdasP38W7g1YJ/Aw6AczUhtzaoExKXjk0I
         UdS0hzPG/aqMfb05I8InciYnpct0yxMaDLNmj9/Q3/GfqlhyK+QqtG+6au7aP+giq4OY
         09qA==
X-Forwarded-Encrypted: i=1; AJvYcCUhEHStBdnvO2l/g9Mnr4eOebE+Z0B3M8zQqhRMJSR2RWQrkgxfPtehWHcxMuMo9h7ypY+mSUrsu94F/cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdJZB8qMkW4yw8zE5FaiCBK6ZTyTEDVfAM0iBVk7J/Kcjl+ALQ
	Opr6gsarhpSb1MCusxWWl41uYOxX+JsEfJiMiR4thGw8xw7J0K1zUa1IfD1kF9s=
X-Google-Smtp-Source: AGHT+IEqTtOYAZ0xs5mg5rdotEr2lEo3d5tqrafo4yS/vRO6Ol5mizZCFWULpLfJsb7blCc8Mpf/bA==
X-Received: by 2002:a17:902:e80c:b0:20b:51c2:d789 with SMTP id d9443c01a7336-20bc59e6496mr20807085ad.16.1727829255450;
        Tue, 01 Oct 2024 17:34:15 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e5ecc1sm75521295ad.268.2024.10.01.17.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 17:34:14 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: darinzon@amazon.com,
	Joe Damato <jdamato@fastly.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v2 2/2] ena: Link queues to NAPIs
Date: Wed,  2 Oct 2024 00:13:28 +0000
Message-Id: <20241002001331.65444-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241002001331.65444-1-jdamato@fastly.com>
References: <20241002001331.65444-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link queues to NAPIs using the netdev-genl API so this information is
queryable.

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump queue-get --json='{"ifindex": 2}'

[{'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'rx'},
 {'id': 4, 'ifindex': 2, 'napi-id': 8205, 'type': 'rx'},
 {'id': 5, 'ifindex': 2, 'napi-id': 8206, 'type': 'rx'},
 {'id': 6, 'ifindex': 2, 'napi-id': 8207, 'type': 'rx'},
 {'id': 7, 'ifindex': 2, 'napi-id': 8208, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'tx'},
 {'id': 4, 'ifindex': 2, 'napi-id': 8205, 'type': 'tx'},
 {'id': 5, 'ifindex': 2, 'napi-id': 8206, 'type': 'tx'},
 {'id': 6, 'ifindex': 2, 'napi-id': 8207, 'type': 'tx'},
 {'id': 7, 'ifindex': 2, 'napi-id': 8208, 'type': 'tx'}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v2:
   - Comments added to ena_napi_disable_in_range and
     ena_napi_enable_in_range
   - No functional changes

 drivers/net/ethernet/amazon/ena/ena_netdev.c | 28 +++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 74ce9fa45cf8..96df20854eb9 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1821,20 +1821,40 @@ static void ena_napi_disable_in_range(struct ena_adapter *adapter,
 				      int first_index,
 				      int count)
 {
+	struct napi_struct *napi;
 	int i;
 
-	for (i = first_index; i < first_index + count; i++)
-		napi_disable(&adapter->ena_napi[i].napi);
+	for (i = first_index; i < first_index + count; i++) {
+		napi = &adapter->ena_napi[i].napi;
+		if (!ENA_IS_XDP_INDEX(adapter, i)) {
+			/* This API is supported for non-XDP queues only */
+			netif_queue_set_napi(adapter->netdev, i,
+					     NETDEV_QUEUE_TYPE_TX, NULL);
+			netif_queue_set_napi(adapter->netdev, i,
+					     NETDEV_QUEUE_TYPE_RX, NULL);
+		}
+		napi_disable(napi);
+	}
 }
 
 static void ena_napi_enable_in_range(struct ena_adapter *adapter,
 				     int first_index,
 				     int count)
 {
+	struct napi_struct *napi;
 	int i;
 
-	for (i = first_index; i < first_index + count; i++)
-		napi_enable(&adapter->ena_napi[i].napi);
+	for (i = first_index; i < first_index + count; i++) {
+		napi = &adapter->ena_napi[i].napi;
+		napi_enable(napi);
+		if (!ENA_IS_XDP_INDEX(adapter, i)) {
+			/* This API is supported for non-XDP queues only */
+			netif_queue_set_napi(adapter->netdev, i,
+					     NETDEV_QUEUE_TYPE_RX, napi);
+			netif_queue_set_napi(adapter->netdev, i,
+					     NETDEV_QUEUE_TYPE_TX, napi);
+		}
+	}
 }
 
 /* Configure the Rx forwarding */
-- 
2.25.1



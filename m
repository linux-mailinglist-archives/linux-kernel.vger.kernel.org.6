Return-Path: <linux-kernel+bounces-344735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2C198AD9C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D961F23DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F118219EED2;
	Mon, 30 Sep 2024 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="yRg+imbU"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75D71A01B7
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726194; cv=none; b=dv8ImkhbVSdSNtiRVIzuqzn7Puw3H2t6DfOEYjVCPA5XvAVoRaKYKTuVAvVyLIs4H3PZdXUKawVq2hyOzOoHwmYAEty8K12EEUSPu9l4jE3831hHaUmH7s6oqKZrPvMFZVrwt9NqP8BNAFT5ZytK0pfg6zAh3UFCutWWeoU6Xbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726194; c=relaxed/simple;
	bh=UA0m3VMYAwf7VZLj3wNgsyeHamH7xUAmp8+jviHGxUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z/jLyapAWUUpSAoVHDClHrrHRJh6wIiXKiSHCTTmQgAAsfA+Izx1vYSodDHASehlZHttH1EVxLQ1rcqLIz3HYoXp9ReTRZOZZu870cCaInw3sJuQeIyG/gjxlSuyg0u1ln2riT9AbIlwETK6PbIhRJ3ZRG7rmU0mbwnZ6tSEnAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=yRg+imbU; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718d606726cso3394911b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727726192; x=1728330992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxtv2lrF1kOetNp7xi3WglFSuTqjxy0uNajfsDkNvuU=;
        b=yRg+imbUi7bGSZneMP0cJqGUe6lYG0H3ejIn3qalyl/5b67WeQk5LWEoPRDfZUkQPC
         QYauuwVtpF2KelD25JqqmdOM11bzJb++6w4K9vyzkaBY/SnUhywbcDugSD+/El95FBV3
         RVqciJ63OMQltvkALlxuMvFjGdppsvS69h6iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727726192; x=1728330992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxtv2lrF1kOetNp7xi3WglFSuTqjxy0uNajfsDkNvuU=;
        b=UA4uPo/hlsFMaoloOLFgMJkvhzmbofN0Trx7x01NVvJMEhdP7QzGwlSXuyR1xBP1ih
         JOkyY4Ts5jfSfEu3RiMgea/rSSB15GIdpuN0ERlzeeQfW6w+19EHEO+X/6w9Mt1DS0AB
         NJ16rHO0o1M/pO8MRq+CPFr6vyxYZpAoA6xEEW6KM2DUSv3jYzRVBNw/peWwc8xbps8m
         9y66SX2lO406ETl7b9v92R95v0HmlytV74xHIBi2B72hcO6VkkdCDLyTelU84NonUUao
         mkKTWGWZPjQGQqzzJAYZWxFCgrze3ScpqRXzVb03mr8QDP7TmZ1mjShBHOvcjsEuXVHF
         MQ4w==
X-Forwarded-Encrypted: i=1; AJvYcCUw8IdqnrDY9EzQOseuBUHM5wOGKN3VKeUW/gBPxQhNuq+vWWksiZJkiDpk+UgQHE86wN6q4p1r0VZwA0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4/VfgUmLh+j0K+mNu/krlrmn4H0afuK78gnXZcRzIEG9Vd2yj
	LmAvGIy/U2LqNQecvlmIvksNVMkv/RrRBLidnTfurui5U7opaU3EmGJzAoAwxKs=
X-Google-Smtp-Source: AGHT+IHYMQgS9wxg2iL/t0osMPTamKqFGShjRfad8poeTcxLS0lYKsFnK8dQ6emauZeBXHfOlaTwiQ==
X-Received: by 2002:a05:6a00:cc4:b0:706:58ef:613 with SMTP id d2e1a72fcca58-71b2607ae1bmr16336872b3a.27.1727726192145;
        Mon, 30 Sep 2024 12:56:32 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649a2cesm6604450b3a.43.2024.09.30.12.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:56:31 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next 2/2] ena: Link queues to NAPIs
Date: Mon, 30 Sep 2024 19:56:13 +0000
Message-Id: <20240930195617.37369-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930195617.37369-1-jdamato@fastly.com>
References: <20240930195617.37369-1-jdamato@fastly.com>
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
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 26 +++++++++++++++++---
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index e88de5e426ef..1c59aedaa5d5 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1821,20 +1821,38 @@ static void ena_napi_disable_in_range(struct ena_adapter *adapter,
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
+			netif_queue_set_napi(adapter->netdev, i,
+					     NETDEV_QUEUE_TYPE_RX, napi);
+			netif_queue_set_napi(adapter->netdev, i,
+					     NETDEV_QUEUE_TYPE_TX, napi);
+		}
+	}
 }
 
 /* Configure the Rx forwarding */
-- 
2.43.0



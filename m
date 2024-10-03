Return-Path: <linux-kernel+bounces-349731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28A598FAAE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04BE281D7A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719B31D0E12;
	Thu,  3 Oct 2024 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Kyugc5wi"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458D51D0438
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998748; cv=none; b=Kxzamfmng1BXmJtB8TI4NgRKWQmMR4wTDlgxspHeUYvjwDBn4Gmedc1BXsqEnk6tb7lbMExOp5Tqwo8/OG7YB68+CFfInOBYsbSgVrB4gcpsyksQA+rm/f4ej08O8Itcs2XxDRYvzSUiQBzGyZC4MEd8N8alGdSABmS8Lz1DXv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998748; c=relaxed/simple;
	bh=4bT09cAu2qhfAav0tDdUjSpZJuBDzgUwRyW6i3IdhQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E7DCgC0BjC/ipjD0/4ooMR5s4/MJ0F/DpGUd/0AStg9RkyOKKRvwQP/+yG79t3GiVwWIAN3/k5859BRdHr3BA4NkoQin9tWW6sFgkk6Vp8ThbY8lmNtQOhSrfX/TttRaKac7qKXopQB97vTXuxnquQQytW4CkSUTECSDz/+TD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Kyugc5wi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b833f9b35so13664865ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 16:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727998746; x=1728603546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpDtgFKpiW6n7Ug+1YSP06l0kr3SHis2120480WaYUs=;
        b=Kyugc5wir13cdYyZ18KMwU15BRqdyJ7meCAM+9FU08XMc7vOLlGVMCm2s5NMW+DwtM
         MPKrfyhJPd8fchfMMXUFUKZkoDUJxLGB56k4LIDuMN2R0/aPH0xwXH3pRydSLXr9hc7T
         oxyl36myH06sEOpLxkwWL67gWw8COHL3pjKAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727998746; x=1728603546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpDtgFKpiW6n7Ug+1YSP06l0kr3SHis2120480WaYUs=;
        b=G+AvUPeDGaHB7/UnyCHj1IYPRXwKjpC4SDO/n+vDMNsHTAonm7VNNMrl1iJWdDp6TZ
         NmCS94qeHi30C4N58Cvsyuzza1GFVuQ19O/dpVUr4Gh7KXrjnjkULRVOWXAJcj4mXf/B
         HueJZJOkEdXxERlFEjULZLmXFXGMfYYraVet2ejXNY4feThLTgdQiTkBhxlGA90G6ODB
         cEKweLyBbFnTb/0i0KCK0tkpQf45wZfb0le9FdThrUqDz9717AFYLGJJs4RaKBYsHULt
         pI1I+AWBSlpeDsRMfEyxAoH/jEiCpxuYlzFNNw1H2sa8uvbaKyiDDQ5dv7kcpZRtBCib
         Ks8g==
X-Forwarded-Encrypted: i=1; AJvYcCUgyE2Ft8mrTPrBquco9/JJ2T17FROBA+oGG6ZdNFPQAt+QBEt3TSNLT5bRn1N3mKHK+IMtrRQIAfxSO/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/zDL5bP7/7k3FH21MaTzw8H9/5dMyjCjY5FApABE6Pgpnu75
	BMvXN97Sw/4+iHZiyQdC5uTfefnzPhoF2EFJb6adtw0b8d/a1ZzNuG8gCjaK6tk=
X-Google-Smtp-Source: AGHT+IEscOgAVx/0YG9i/MINtF9xq0NivswWkuBxhiN50OJBwJky40grr6JNhThn+Z2xOj8C0ihYvQ==
X-Received: by 2002:a17:902:e742:b0:20b:b7b2:b6f4 with SMTP id d9443c01a7336-20bfea5417fmr10500325ad.47.1727998746571;
        Thu, 03 Oct 2024 16:39:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beef8ec6bsm13960705ad.158.2024.10.03.16.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 16:39:06 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 2/2] igc: Link queues to NAPI instances
Date: Thu,  3 Oct 2024 23:38:50 +0000
Message-Id: <20241003233850.199495-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003233850.199495-1-jdamato@fastly.com>
References: <20241003233850.199495-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link queues to NAPI instances via netdev-genl API so that users can
query this information with netlink:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump queue-get --json='{"ifindex": 2}'

[{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8194, 'type': 'tx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8195, 'type': 'tx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8196, 'type': 'tx'}]

Since igc uses only combined queues, you'll note that the same NAPI ID
is present for both rx and tx queues at the same index, for example
index 0:

{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'rx'},
{'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'},

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 30 ++++++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7964bbedb16c..b3bd5bf29fa7 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4955,6 +4955,7 @@ static int igc_sw_init(struct igc_adapter *adapter)
 void igc_up(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
+	struct napi_struct *napi;
 	int i = 0;
 
 	/* hardware has been reset, we need to reload some things */
@@ -4962,8 +4963,17 @@ void igc_up(struct igc_adapter *adapter)
 
 	clear_bit(__IGC_DOWN, &adapter->state);
 
-	for (i = 0; i < adapter->num_q_vectors; i++)
-		napi_enable(&adapter->q_vector[i]->napi);
+	for (i = 0; i < adapter->num_q_vectors; i++) {
+		napi = &adapter->q_vector[i]->napi;
+		napi_enable(napi);
+		/* igc only supports combined queues, so link each NAPI to both
+		 * TX and RX
+		 */
+		netif_queue_set_napi(adapter->netdev, i, NETDEV_QUEUE_TYPE_RX,
+				     napi);
+		netif_queue_set_napi(adapter->netdev, i, NETDEV_QUEUE_TYPE_TX,
+				     napi);
+	}
 
 	if (adapter->msix_entries)
 		igc_configure_msix(adapter);
@@ -5192,6 +5202,10 @@ void igc_down(struct igc_adapter *adapter)
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
 			napi_synchronize(&adapter->q_vector[i]->napi);
+			netif_queue_set_napi(netdev, i, NETDEV_QUEUE_TYPE_RX,
+					     NULL);
+			netif_queue_set_napi(netdev, i, NETDEV_QUEUE_TYPE_TX,
+					     NULL);
 			napi_disable(&adapter->q_vector[i]->napi);
 		}
 	}
@@ -6021,6 +6035,7 @@ static int __igc_open(struct net_device *netdev, bool resuming)
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct pci_dev *pdev = adapter->pdev;
 	struct igc_hw *hw = &adapter->hw;
+	struct napi_struct *napi;
 	int err = 0;
 	int i = 0;
 
@@ -6056,8 +6071,15 @@ static int __igc_open(struct net_device *netdev, bool resuming)
 
 	clear_bit(__IGC_DOWN, &adapter->state);
 
-	for (i = 0; i < adapter->num_q_vectors; i++)
-		napi_enable(&adapter->q_vector[i]->napi);
+	for (i = 0; i < adapter->num_q_vectors; i++) {
+		napi = &adapter->q_vector[i]->napi;
+		napi_enable(napi);
+		/* igc only supports combined queues, so link each NAPI to both
+		 * TX and RX
+		 */
+		netif_queue_set_napi(netdev, i, NETDEV_QUEUE_TYPE_RX, napi);
+		netif_queue_set_napi(netdev, i, NETDEV_QUEUE_TYPE_TX, napi);
+	}
 
 	/* Clear any pending interrupts. */
 	rd32(IGC_ICR);
-- 
2.25.1



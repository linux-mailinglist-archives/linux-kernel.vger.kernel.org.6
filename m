Return-Path: <linux-kernel+bounces-351914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB00B99178F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5290E282E11
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB36158543;
	Sat,  5 Oct 2024 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="f+Oi/nLi"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5158A14D29B
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728140250; cv=none; b=URUP+tD+1wd/hwqgqjsswUG53lFvsKclKa/0kThPt/n4j09H82tgO/avl3694CKMeItTiFkgANoPio2zW3X/ROaN0+Arub+vmHi1CjGfKSjg1wbrFS5kpiBIvW7Enuy+auJpDQS3OpiudW1rtV1S8Gq02qpphxblTRYPRk/L1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728140250; c=relaxed/simple;
	bh=thcYphpNAdIzT0H0M8T+Xo0AMmC8z3xkUwKuUa32lqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDkq/X1cGUDSsJVCJCGHXWoOaqXCIx0nbNKP/91YEaEQdNW08OWOPclXiedMlM7lic21EfZ/OxIX7BkhqAdroG2ZcWLlubXe6P9CBpA3HKl4tvpbplIMrO6MhzQxSj1+qd2EnYUstKn2JiI3xxy5ZyJ3VTENqBlMEcMRc2w7yhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=f+Oi/nLi; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7179069d029so2358041b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728140249; x=1728745049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj//5XoNe5l6Dm+CRfm/cmDjjfvCDewa/ozF5GNrUio=;
        b=f+Oi/nLiUj0pjrRp0rbgEG9HDFZtIWkaO7WfwbePIJcNb3LscOur+iQdghLjxFgP5O
         YDgxm8R5VBCJ04Ym5uywEshk4NWyc72ZuRwDmrb/2PzPIYMc8KMWjNRPcxoTiumzHi2s
         CJX4T+Mrx90JoEaRLbweL0nUhEPNk0zGJTXvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728140249; x=1728745049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj//5XoNe5l6Dm+CRfm/cmDjjfvCDewa/ozF5GNrUio=;
        b=a9A1grRLwYDjl1Ol7sC5wHORI6uvmja/6cl2dJZOChODoOb/DL6p0z9mdglpULn5K0
         XFUA6H1CCMwWCo3+Adc2uc4RZHfGgHLvpdBAM+IQjli+kgi/YUUrPz7M2M8btBBscyiT
         C5plrjCusI/zUw0eHRcvVTSBh7RnzFUS3pX6BYhP/FvRMPTO0xj5a6Z+lt7QbBRBFB5Q
         PGYKIPuUsMyaNaUy121eN2D/yCuxbrnbbwoSaEWG8mhrIGegyTfU0AJxSkWECNwexICo
         hn2UzZ/SV/DfFxLzUUhCSw/hlLgyrVuUtXUyJgKd2+XUfMr1FEwf3sA0JCku4ySZVICi
         ohdA==
X-Forwarded-Encrypted: i=1; AJvYcCU8lZJdovQEfsdJaLv3MZm7x2SuJHLHST//LczA3LFFIGZEDe5bnWoYV5M0TdoODKjslAHTG+SMRVZX118=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZOyr6KAjac0fFQhat1qmSDukP1aQ0CHcAOmTNEfLIRI7B2SWy
	ZxZf6fjMZGNeaXvy2N9r+q/9MR3gL+35wBB977ZpKGtthhaXne6h2dO24DSdWtA=
X-Google-Smtp-Source: AGHT+IFM8cTLINP21Oa0a7lFaVHhoyEZPhHMUUa1IT3Mgtmuz66wQMuiHFBnA4EPR0BKC2/BFUEojw==
X-Received: by 2002:a05:6a21:a24c:b0:1d3:1765:c09c with SMTP id adf61e73a8af0-1d6dfa486e7mr10003756637.29.1728140248804;
        Sat, 05 Oct 2024 07:57:28 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7d3b5sm1569273b3a.215.2024.10.05.07.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 07:57:28 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v3 2/2] tg3: Link queues to NAPIs
Date: Sat,  5 Oct 2024 14:57:17 +0000
Message-Id: <20241005145717.302575-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241005145717.302575-1-jdamato@fastly.com>
References: <20241005145717.302575-1-jdamato@fastly.com>
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

[{'id': 0, 'ifindex': 2, 'napi-id': 8194, 'type': 'rx'},
 {'id': 1, 'ifindex': 2, 'napi-id': 8195, 'type': 'rx'},
 {'id': 2, 'ifindex': 2, 'napi-id': 8196, 'type': 'rx'},
 {'id': 3, 'ifindex': 2, 'napi-id': 8197, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 8193, 'type': 'tx'}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 37 +++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 6564072b47ba..12172783b9b6 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7395,18 +7395,47 @@ static int tg3_poll(struct napi_struct *napi, int budget)
 
 static void tg3_napi_disable(struct tg3 *tp)
 {
+	int txq_idx = tp->txq_cnt - 1;
+	int rxq_idx = tp->rxq_cnt - 1;
+	struct tg3_napi *tnapi;
 	int i;
 
-	for (i = tp->irq_cnt - 1; i >= 0; i--)
-		napi_disable(&tp->napi[i].napi);
+	for (i = tp->irq_cnt - 1; i >= 0; i--) {
+		tnapi = &tp->napi[i];
+		if (tnapi->tx_buffers) {
+			netif_queue_set_napi(tp->dev, txq_idx,
+					     NETDEV_QUEUE_TYPE_TX, NULL);
+			txq_idx--;
+		} else if (tnapi->rx_rcb) {
+			netif_queue_set_napi(tp->dev, rxq_idx,
+					     NETDEV_QUEUE_TYPE_RX, NULL);
+			rxq_idx--;
+		}
+		napi_disable(&tnapi->napi);
+	}
 }
 
 static void tg3_napi_enable(struct tg3 *tp)
 {
+	int txq_idx = 0, rxq_idx = 0;
+	struct tg3_napi *tnapi;
 	int i;
 
-	for (i = 0; i < tp->irq_cnt; i++)
-		napi_enable(&tp->napi[i].napi);
+	for (i = 0; i < tp->irq_cnt; i++) {
+		tnapi = &tp->napi[i];
+		napi_enable(&tnapi->napi);
+		if (tnapi->tx_buffers) {
+			netif_queue_set_napi(tp->dev, txq_idx,
+					     NETDEV_QUEUE_TYPE_TX,
+					     &tnapi->napi);
+			txq_idx++;
+		} else if (tnapi->rx_rcb) {
+			netif_queue_set_napi(tp->dev, rxq_idx,
+					     NETDEV_QUEUE_TYPE_RX,
+					     &tnapi->napi);
+			rxq_idx++;
+		}
+	}
 }
 
 static void tg3_napi_init(struct tg3 *tp)
-- 
2.25.1



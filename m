Return-Path: <linux-kernel+bounces-300611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD9E95E602
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 02:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2617E281122
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3643FE4;
	Mon, 26 Aug 2024 00:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="gAiQ2cIm"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0045E2F50
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724631451; cv=none; b=QOGgvCUWBMKE4NVCKrjXF509oseWgQaqNA7V4nXWvkXi7V6mM2xV7I043RB+oKN1A930N1bDMGXqgvqhTBv/1P+bKzR2w9oJ2ySA0A5efAHOjgHEbSfQAHtQr0cmMc5u9mYBZkCM8FcNSsUOPsBLyLFeonZj51diwtYxtdqel9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724631451; c=relaxed/simple;
	bh=S+Z6PJyaSmQhlIQp5Y6utZhqCwrSWc6kUiM3bwJoleU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T3S059Pr+BDwCYXHQ782EYgVjL3MsZBgvNmeB7QkZ4p3L94POUx7pA+eiphLM6L+3DsdOVEIRozS8B/kwnoC8+A6P42ZWQwnt7WlbGk9oroVK7BCJgIxcUkewqgd+U9HnLhE8ru4U4f36i0JuX+QZmlGfZj3b3z9OnQobLAHOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=gAiQ2cIm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fee6435a34so23328255ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 17:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724631449; x=1725236249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ocJqzZ8bzJemFKKS0cPSkwvik8OFTuPmEhYsMphrCg=;
        b=gAiQ2cIm+c+X4kAWhHjU3J86W/IQF3f1blxFBrZwLPUmdm50EQOBq/3BYld18TSeJN
         ktZlWp26utr8aykjYGiujdNUL2DfCu+5LPOj+Iuy+vUhI4Hyid6WDgS/4VwmFq0/vNkq
         dmQcyU9t1FRHQi8u7ELesGZ7Ut8KlAxiaAZZ6leZbgxwGcJrj15XVcyLK73fjqBdTBdQ
         c3BLtnIGOphrNkbx3ZZ+Q7cxYdeIGx84+e+hRng8s7bMb+DKgois4C506TIXqu177NH9
         OOsy2UxxnL70XhPLzCR8NtVbTKDM/smuYLWsb5OwMvtvtu1GFwpvnbJKDYHcy1nbXzJU
         nYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724631449; x=1725236249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ocJqzZ8bzJemFKKS0cPSkwvik8OFTuPmEhYsMphrCg=;
        b=mr8JanNOYZ6CL1z+/oOskKv1ygPTWP3lP9D7R3mOIY74lR3+hkqAYd92tOTGWp8OBb
         qRqUKdOE95YDVjcsWP7Ou2mzsj6oHQ9eQJFqvw3uTWg51ggW2aWoKSe0NNI93/QhHV80
         v6BZiD9kG8/pUhi4BTIXkWVskS5BiePH5KraG9tTCFbJkn+QjNx3FOqo5KMSrFDKPu4S
         Aq3EFU+QHKt4JmsXWYKgrQ83Uq6FOZOxNaxT11MHLKQAU8ODnryvxBBv4J5hQmzVDvHD
         GeLhlAByVpGYCDPiAzp5hMurA00TpYoeVbnX/r6p31VUsYYojxNzPJBeszd1WrgQZWl1
         Z0VA==
X-Forwarded-Encrypted: i=1; AJvYcCXDPIVZ0oSfV8V3+OaEDcZpVsJJAdTmUiKcJqQxfaFyjdfPlBhTUBcLSnt5BoqFSve6v/NVN48X3ETGe/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLW63CjAwccDrblwxz8cN0dTuas9wDz989nCDDFlmDoyLf915G
	5EKoec1lsRf0zoa8t3mdYgJ4Iyr6xfK7ytAbru2zs1k32muUwy3L1ClPDRafkcA=
X-Google-Smtp-Source: AGHT+IFfy8YIndXr+rHv9Dou4P7+V1+essF3+qWDSxzOqg6z1+wYN4SrGOKZf/Dq1C5vAeRVAY/WMA==
X-Received: by 2002:a17:902:d4ce:b0:201:f853:3e69 with SMTP id d9443c01a7336-2039e4fbb83mr82215805ad.57.1724631449213;
        Sun, 25 Aug 2024 17:17:29 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203857051b9sm58695955ad.234.2024.08.25.17.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 17:17:28 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 2/6] Staging: rtl8192e: Rename variable bLastIniPkt
Date: Sun, 25 Aug 2024 17:17:20 -0700
Message-Id: <20240826001724.274811-3-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240826001724.274811-1-tdavies@darkphysics.net>
References: <20240826001724.274811-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable bLastIniPkt to last_ini_pkt
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c | 8 ++++----
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c    | 2 +-
 drivers/staging/rtl8192e/rtllib.h                 | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
index e470b49b0ff7..8247f22454cd 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
@@ -16,18 +16,18 @@ bool rtl92e_send_cmd_pkt(struct net_device *dev, u32 type, const void *data,
 	struct sk_buff		*skb;
 	unsigned char		*seg_ptr;
 	struct cb_desc *tcb_desc;
-	u8				bLastIniPkt;
+	u8				last_ini_pkt;
 
 	struct tx_fwinfo_8190pci *pTxFwInfo = NULL;
 
 	do {
 		if ((len - frag_offset) > CMDPACKET_FRAG_SIZE) {
 			frag_length = CMDPACKET_FRAG_SIZE;
-			bLastIniPkt = 0;
+			last_ini_pkt = 0;
 
 		} else {
 			frag_length = (u16)(len - frag_offset);
-			bLastIniPkt = 1;
+			last_ini_pkt = 1;
 		}
 
 		if (type == DESC_PACKET_TYPE_NORMAL)
@@ -43,7 +43,7 @@ bool rtl92e_send_cmd_pkt(struct net_device *dev, u32 type, const void *data,
 		tcb_desc = (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_SIZE);
 		tcb_desc->queue_index = TXCMD_QUEUE;
 		tcb_desc->bCmdOrInit = type;
-		tcb_desc->bLastIniPkt = bLastIniPkt;
+		tcb_desc->last_ini_pkt = last_ini_pkt;
 
 		if (type == DESC_PACKET_TYPE_NORMAL) {
 			tcb_desc->pkt_size = frag_length;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b25e83743956..8ca7eb6b8e75 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -987,7 +987,7 @@ void  rtl92e_fill_tx_cmd_desc(struct net_device *dev, struct tx_desc_cmd *entry,
 	if (dma_mapping_error(&priv->pdev->dev, mapping))
 		netdev_err(dev, "%s(): DMA Mapping error\n", __func__);
 	memset(entry, 0, 12);
-	entry->LINIP = cb_desc->bLastIniPkt;
+	entry->LINIP = cb_desc->last_ini_pkt;
 	entry->FirstSeg = 1;
 	entry->LastSeg = 1;
 	if (cb_desc->bCmdOrInit == DESC_PACKET_TYPE_INIT) {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 4e72fa65a559..8ca36d1c7fb1 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -101,7 +101,7 @@ static inline void *netdev_priv_rsl(struct net_device *dev)
 /* At most 28 byte */
 struct cb_desc {
 	/* Tx Desc Related flags (8-9) */
-	u8 bLastIniPkt:1;
+	u8 last_ini_pkt:1;
 	u8 bCmdOrInit:1;
 	u8 tx_dis_rate_fallback:1;
 	u8 tx_use_drv_assinged_rate:1;
-- 
2.30.2



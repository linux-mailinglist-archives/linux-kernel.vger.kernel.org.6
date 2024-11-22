Return-Path: <linux-kernel+bounces-418785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36859D65A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D82282253
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899C31A01C3;
	Fri, 22 Nov 2024 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bkbNsZ9e"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59414187342
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313818; cv=none; b=gGw6A3pBFqupoVAJJrswZ1RoWbomNOPR4NoJg1DRFDRjz5I4M/Le0DCSzfOVfR5pW9GXuGgdEm5nSYRnoJT0WKJDeb/XOep/KM/8+KVswnr22lRuuA+h1dNFfS5HsKvpR8qpvXyADdqOSpEJjPJj1lcA3V6AFycwfZxJ4z+YGRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313818; c=relaxed/simple;
	bh=ldxR7DmjrgRcjjZ1Z/p/luxN1xxh7dfLbpLVH96Oblw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ogce8WtVViJwobtWyR3ULY9Y9p3umNTe7Hbk5D9cC2dMtp+QM1Ex8tbn73X+q/eFjM08P4BnU63RfZMnWOiaAXOP3ukat/xX/EWfME/WMReHdgaNtJPYn56AP7H+PSwzwSKD0KHCQMEpYGmBFBcLyKZAsrsd4T0veG87XD4XEjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=bkbNsZ9e; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53da3545908so3148192e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313815; x=1732918615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXl+FSVARqVcRtIxq69Tn4oF98SIhVQqmrh7i+R1ZlE=;
        b=bkbNsZ9eaWAvGMRAzTcz9B8FpGfDFioyNBSHHNJzxKhfa1QFmu++vLFtiVnXxbkcyF
         +wFozAHgbeGaPcDup+3ENtLk22rJPmqmzcYO5l/jRjCx/OGeICUFaOhDLNnrJu0qvLFf
         dq2Tu4aZ89taKZGrnQlmBSZV2/u0AbKun65D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313815; x=1732918615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXl+FSVARqVcRtIxq69Tn4oF98SIhVQqmrh7i+R1ZlE=;
        b=WV/kFJOcwzxiYl+PeRJb+rgTp2+8jquFaFkchuDOFFx84pqZvwEX6x1AEHmOpbrD0i
         pOVISz/gfO9gMjh7ZFeVHu6kLgFboPnLsOqzuNjMIsuUbPlRxHOEzxc+xRQwVj99cuK8
         W1wzHejOw6g19fwM3HW8S1yeU6Y/wXFkHLL+zw8TkyKKOIyujGGp3y2wHju5kpdOPsQF
         t6U6RtvQy0xVYkclgweRDG3kB9WibAghV5fR6Hl3i5JRDhQUipKGQsmHxi94W1k48ElX
         5Tmn8k5mPT2GloiezKBHh+zgUQlXlNjh15Oa6IrVZccrWR8ScmrrYrjkVt2s8Wrt0n+3
         fFUg==
X-Gm-Message-State: AOJu0YwS795bbVAKgKRU2e1Yanf3l76obZfNg04TssOzuAvRZPm5xzoP
	W+lGSZlbizkW8P0z+neLtVCpuHY7QeyMrdVD44iuSshTy1B01gdYyRGffEDHnLEoJ+wa8/atwmW
	O
X-Gm-Gg: ASbGncsHA4BnTU64x2tS9dml/3aVToly2589Efwr6pZ7x0ZbGe2Rmc5ei7laUazu2w/
	qeveNRNilT9Zg4aS9i9nh5SZzWt+rgmKsyD9E5+4qWZCcbQ9OIIvlJSeb/Lf2B35Cr1f/FQuYrN
	LuDNAJ2npZ5SP4ro5HE6CfSc/+lsSLlQWvCx4aLUy4W33Ehf791TprtuUsVUKDBZ3DiyTj7ey7e
	zFQxLJqJlSptRCyRzHOyMoi297ZM3YzgFrNf+ju8PLZe/df11Yif2KiWAyVqyo6XAzhD2Z9C++/
	QGJVzziCN8HRxvuQyKLjAU2G0Ikb5wXy7FMd1qmf7ANy4t0QpPvufTulsQZHw6hu7oxINNVCyEF
	hjFJxozEHXb4ZQQMm
X-Google-Smtp-Source: AGHT+IHPZQFrM56J/OIyk1Q59hKMDjmlud7peYUn3uyJVNqixLxLsv4xopNTFKGImm55L3dfJExZHQ==
X-Received: by 2002:a05:6512:39c3:b0:53d:d957:9f92 with SMTP id 2adb3069b0e04-53dd9579fd5mr1789697e87.9.1732313815331;
        Fri, 22 Nov 2024 14:16:55 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:16:55 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [PATCH v2 01/12] can: c_can: update statistics if skb allocation fails
Date: Fri, 22 Nov 2024 23:15:42 +0100
Message-ID: <20241122221650.633981-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
References: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch ensures that the statistics are always updated, even if the
skb allocation fails.

Fixes: 4d6d26537940 ("can: c_can: fix {rx,tx}_errors statistics")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Added in v2

 drivers/net/can/c_can/c_can_main.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index 511615dc3341..cc371d0c9f3c 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -1014,49 +1014,57 @@ static int c_can_handle_bus_err(struct net_device *dev,
 
 	/* propagate the error condition to the CAN stack */
 	skb = alloc_can_err_skb(dev, &cf);
-	if (unlikely(!skb))
-		return 0;
 
 	/* check for 'last error code' which tells us the
 	 * type of the last error to occur on the CAN bus
 	 */
-	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+	if (likely(skb))
+		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
 	switch (lec_type) {
 	case LEC_STUFF_ERROR:
 		netdev_dbg(dev, "stuff error\n");
-		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_STUFF;
 		stats->rx_errors++;
 		break;
 	case LEC_FORM_ERROR:
 		netdev_dbg(dev, "form error\n");
-		cf->data[2] |= CAN_ERR_PROT_FORM;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_FORM;
 		stats->rx_errors++;
 		break;
 	case LEC_ACK_ERROR:
 		netdev_dbg(dev, "ack error\n");
-		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		if (likely(skb))
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
 		stats->tx_errors++;
 		break;
 	case LEC_BIT1_ERROR:
 		netdev_dbg(dev, "bit1 error\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT1;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_BIT1;
 		stats->tx_errors++;
 		break;
 	case LEC_BIT0_ERROR:
 		netdev_dbg(dev, "bit0 error\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT0;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_BIT0;
 		stats->tx_errors++;
 		break;
 	case LEC_CRC_ERROR:
 		netdev_dbg(dev, "CRC error\n");
-		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		if (likely(skb))
+			cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 		stats->rx_errors++;
 		break;
 	default:
 		break;
 	}
 
+	if (unlikely(!skb))
+		return 0;
+
 	netif_receive_skb(skb);
 	return 1;
 }
-- 
2.43.0



Return-Path: <linux-kernel+bounces-304859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 716A39625E7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E281F25096
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFFB172BD3;
	Wed, 28 Aug 2024 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Znq4QM4A"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288F417085C;
	Wed, 28 Aug 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844103; cv=none; b=YQ7y2Ov83KsJMhLkkSg7JZqYyLIvlf2GgMjDvjec0YwLFLgU4FJq4HC0zqIY5uxiezvE5hZE9xhMIN4CrmThPjm5PNnCa36x5oBAqFkF0OFpM9C4bw9fv/iG7z0aDHurkv3MHb9AHeFTPYaVZgvGbL/Qukk1OuDYILi0FwZbujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844103; c=relaxed/simple;
	bh=56M3DMja+r+95VlN3FKRf3LWJiO8WGCUMdFbsdy/NB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K/GFAggrb9oZwyVEC+hHb9Zj1bpPcZZj9lkKv99d1q7DnAyE5hJD1NBXKjF7S+dbKszo7xRl/tu1aaAWfJ+CuW7QdKqjCyJErilw1CEuLirtl4U7cY+X0IOod0kE6dSHANI1LqBkulap1E6rSGvrRowQHo5/gFVEiHiz8ojLlt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Znq4QM4A; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bf006f37daso935354a12.1;
        Wed, 28 Aug 2024 04:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724844099; x=1725448899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tp88SF2BiHdIWhq5PmvKpT0xpcn3RokNnwTnJLgZEHw=;
        b=Znq4QM4A2AurpMVkLTskmqhMm/zHdEnh6w3NYeWUuT7unGgfAyySDVlHU2sONI2Ceu
         xSPBeh53drn7T+DC6GOEH3kX+famhAf3yuJRJDHkrWNuWRFVVf1BRC8SzyM99P86bGM5
         M3DVckUNSj5b/JCOrTxrO/+bsFRm1JZBVBFmNU27QwRlQIvmZ2whEIb0F9soSZcC0GUg
         AjwFkamf8aAE880pfJiho0t9YDdwlOWnl2VO45GqmDbhe4m0bcQV0lOALQQ3Gfh6qah2
         KvjNozgE6oUDjE04+ZtHUfVhduGrHswvR5w1LMOmLfvF+N3yj9rsQUplAJo0tvKSndlJ
         O1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724844099; x=1725448899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tp88SF2BiHdIWhq5PmvKpT0xpcn3RokNnwTnJLgZEHw=;
        b=AO03+8p2HKzCZw0pSg/jQ0oyBIY5nTJ8VFT0NDrkPkYKYJ87ATHuh4SMwzQpbzU0jb
         rQZt7LTShltt1+ebE61KB7zDC9k/i6jQApx31rBO6c6Hmwly3gj0thw3WP/z0hh6h2ZD
         xEXDDhxBdugNCYhsEiHxnISNGVZ5xwZYg7aqoG5oK3WPrR18S51m7591YDwPDUX3LwzO
         FCFGphSjRPOgnuuy8gsI/fFkIQss/AMnR3k2ZrOVVHgOPoEbDpBmsFii375swtuRMwSl
         fOBJcfooOnH7GlgeQhgJwVk29pzG+eJztLikT5wZkCcB3FBW4HWfTnb9OrS3fJewwqBx
         kzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8qc/oxoePnjNds/aZyPKyh+qxTw7XMxURpc0CeBlLgbnEC9sQYhRq7ZXpYtuMB3VYHy/EOXHXzcXy@vger.kernel.org, AJvYcCXfuQ/wAwjr5qh4xD5oMZcu730VWCk6b1GEHqOgwAWsEWZ+YS6fIAIOmpmFSrwIY/d7ua13WNVJ9loWvqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp7K5nwTOHblF99lXG7TfEcSQu/bGOuTLR4SRn9bRt3kbF9KnV
	OHJn1EbnyczW3k56I7Lcqi2c+Qyat7kfIV1ph8Eg505e9uKXbAhBw7NUdcbp
X-Google-Smtp-Source: AGHT+IFX3hmclvvWJ0qPWAUqHkRLdyPZKETkDs++n062wZW2Bu7IBjbw8lasut0tXfIIzaS6NS9mfg==
X-Received: by 2002:a05:6402:1ed5:b0:5c0:ad65:ebf8 with SMTP id 4fb4d7f45d1cf-5c212a4f477mr1887301a12.7.1724844098971;
        Wed, 28 Aug 2024 04:21:38 -0700 (PDT)
Received: from partp-nb.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c29b9sm2136348a12.18.2024.08.28.04.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 04:21:38 -0700 (PDT)
From: Parth Pancholi <parth105105@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Parth Pancholi <parth.pancholi@toradex.com>
Subject: [PATCH] usb: typec: tcpci: support edge irq
Date: Wed, 28 Aug 2024 13:20:58 +0200
Message-Id: <20240828112058.479753-1-parth105105@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

TCPCI USB PHY - PTN5110 could be used with SOCs that only support
the edge-triggered GPIO interrupts such as TI's K3 device AM69.
Move the interrupt configuration to the firmware which would
allow to accommodate edge triggered interrupts for such SOCs.
In order to support the edge interrupts, register irq line in advance
and keep track of occurrence during port registering.

When the edge interrupts are used, it is observed that some of the
interrupts are missed when tcpci_irq() is serving the current
interrupt. Therefore, check the status register at the end of
tcpci_irq() and re-run the function if the status is not clear
i.e. pending interrupt.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
---
 drivers/usb/typec/tcpm/tcpci.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index a2651a2a7f2e..4537c1d97e8f 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -707,10 +707,13 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
 {
 	u16 status;
 	int ret;
+	int irq_ret;
 	unsigned int raw;
 
 	tcpci_read16(tcpci, TCPC_ALERT, &status);
+	irq_ret = status & tcpci->alert_mask;
 
+process_status:
 	/*
 	 * Clear alert status for everything except RX_STATUS, which shouldn't
 	 * be cleared until we have successfully retrieved message.
@@ -783,7 +786,12 @@ irqreturn_t tcpci_irq(struct tcpci *tcpci)
 	else if (status & TCPC_ALERT_TX_FAILED)
 		tcpm_pd_transmit_complete(tcpci->port, TCPC_TX_FAILED);
 
-	return IRQ_RETVAL(status & tcpci->alert_mask);
+	tcpci_read16(tcpci, TCPC_ALERT, &status);
+
+	if (status & tcpci->alert_mask)
+		goto process_status;
+
+	return IRQ_RETVAL(irq_ret);
 }
 EXPORT_SYMBOL_GPL(tcpci_irq);
 
@@ -915,18 +923,24 @@ static int tcpci_probe(struct i2c_client *client)
 
 	chip->data.set_orientation = err;
 
-	chip->tcpci = tcpci_register_port(&client->dev, &chip->data);
-	if (IS_ERR(chip->tcpci))
-		return PTR_ERR(chip->tcpci);
-
 	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
 					_tcpci_irq,
-					IRQF_SHARED | IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+					IRQF_SHARED | IRQF_ONESHOT,
 					dev_name(&client->dev), chip);
-	if (err < 0) {
-		tcpci_unregister_port(chip->tcpci);
+	if (err < 0)
 		return err;
-	}
+
+	/*
+	 * Disable irq while registering port. If irq is configured as an edge
+	 * irq this allow to keep track and process the irq as soon as it is enabled.
+	 */
+	disable_irq(client->irq);
+
+	chip->tcpci = tcpci_register_port(&client->dev, &chip->data);
+	if (IS_ERR(chip->tcpci))
+		return PTR_ERR(chip->tcpci);
+
+	enable_irq(client->irq);
 
 	return 0;
 }
-- 
2.34.1



Return-Path: <linux-kernel+bounces-546047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B03A4F588
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8593AC3E7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35609194A73;
	Wed,  5 Mar 2025 03:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To067iNB"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E443192D6B;
	Wed,  5 Mar 2025 03:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146290; cv=none; b=UNThTrZ2pF6EbMmZ0PdM64wJRJzGDnGcOt6iSYKgyW8K04F8aD3u+Sr36gc9YGaKRhZuPzbhGnxSuu3Ld7IGTDmjFrCcPQHvH6qwP1kyIYJYIzx/0wXQVtlr4X6+H+0GTiqJXMjsFPDd6PrEgwLOXn7u18q3patyalePdpQtoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146290; c=relaxed/simple;
	bh=mIk0IRH1OW9MDPjRzX0QhIQFS2iXhEpe42K081Z5Vxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AsCHftMfWJW2pyNqDb0/uJHzX92FXpHYFuFmpa+3wlceWRX+zlMPHKPXrMmy8tymjvUGSpIhBoFplMYEgpWYNVTUQj7lHOhrSfXGwlPYDJNrPfo1Z3ht8/j8gnjjV6EKH0EVqq796jZJk/OG93AErP5q8ljAWQfAhSx6/hoTxrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To067iNB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22349bb8605so122797105ad.0;
        Tue, 04 Mar 2025 19:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741146288; x=1741751088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWiOwn7nT5PFN7bTmIow5wbcXHHUl8L4grOIfv03884=;
        b=To067iNBBLYIgHQnrLXQS9rjKlrCFAE+bsFvJRlJDNwDBW4a99VJWSqaVL+ZNlz2K9
         b+XJQgYo+NLYq/X2I6o29Jtn/fOdGgDY5HENOPUWzm+X/ED85BqrNBNTwJYkkv36P2II
         zRc09igp+BxDPuFXM0izaz5zc+LpMFfVxUR9sUqgRzwJu3oaMOOR/DvJMcT8HBffVFuQ
         hGkyKG7SeZOyvxqauXUvzGE3X63IyTHWNfkFMZyY8WTk2Y+R/Nq2RyYzdBePYcgNxMmM
         GZH6zs0QeIe3lXU/TMtBdBX6AMmGQSwLGRpGqFaOVB+gNwx0KGnkIzpUwTR99HbsvdKZ
         hz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741146288; x=1741751088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWiOwn7nT5PFN7bTmIow5wbcXHHUl8L4grOIfv03884=;
        b=ZPCQ5qcZI6dvP1rGR3xK1yjAsgec4W/7eHtWyXOIkoctEvXhW6FIKOEuOUaQ0GlZ8i
         I/dWLRw2GZir+y7uIyesFWE2n/qmH6AWlsbFUrtDeqe3nR4KhI4Zltz66g8fOWmMJGEJ
         NNgIGG0wQ6UPqD20dTzRUCep/3HDxuqhMCnzh+w2uhtacGIXMfo49DAZDrDy/pOIVKzU
         K6u5SSOwB068G2RWgGwxIp9JesIkG1YjCPeJh1D7moH/NMEl7tGeLqjnRjuLrn4xPh6l
         +zdzYlNNBKG/2MZZpr5v30Rzb8/d49+6F+hK5H8eJMiwO3M5ui5Q4b2dIbVXGaZEpNLP
         rfmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0d+6roE4UjyOxJD4KN4wg2hP0i5uCbv585uD9MbZAiG8eCRt2b262h64KPQry+Dw7Qtzr50mauZxE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy9W0yQsvdGlOoF5F7H3ugi7cGmQnS+CoXCo/80KXlzMqmJUmX
	Odaeb9sUYA+Lylfb8O3BRi10zHZg5olKKebdlADGXyztj61gK09e
X-Gm-Gg: ASbGncsNVP90iB0Z9QAPHemud52tGMX7iLzc6uyPiiIDTM3jtuyD1xe6exzkKTc4jAb
	7SmW83STuqqeKuKG/mtlkmU6hrm2qObjzyb7gENOt0YffclrA4dsgo3wLT8a48BYWHxKj4j2+qy
	VbYmsmg0RGbvXkP0LH/F2z5Sp1KvntXxFVR/rVGNiR6RiODJK04/98upXKE6ET+RnkqEgmnew6t
	10LQUi1cWftXO4x48/JIMSfEVClgAZ7pdo0xVOgv5fSUn7S0WsYvN/kAGdCGYWEkjepa4CVJ+D6
	8olRGAoBbfuevfMad9E1vJpma0dOTBMU3I269/KBgY+0J8Tb+pMsra8=
X-Google-Smtp-Source: AGHT+IF6e7ShP+dFYnCi3KFWoYYWdUXK08szUlSs8mu7o0gUCi5hQ15jqTxbMjAROfk9XAz/T2tSVg==
X-Received: by 2002:a17:903:2312:b0:21f:9c48:254b with SMTP id d9443c01a7336-223f1c9945amr28241945ad.24.1741146288312;
        Tue, 04 Mar 2025 19:44:48 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:d305:9d26:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c37sm102734335ad.133.2025.03.04.19.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:44:48 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v6 4/5] i3c: master: svc: Fix npcm845 invalid slvstart event
Date: Wed,  5 Mar 2025 11:44:13 +0800
Message-Id: <20250305034414.2246870-5-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305034414.2246870-1-yschu@nuvoton.com>
References: <20250305034414.2246870-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

I3C HW may generate an invalid SlvStart event when emitting a STOP.
If it is a true SlvStart, the MSTATUS state is SLVREQ. Check the
MSTATUS state to ignore the false event.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 46b032b61f3c..5c29912e0a69 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -58,6 +58,7 @@
 #define SVC_I3C_MSTATUS      0x088
 #define   SVC_I3C_MSTATUS_STATE(x) FIELD_GET(GENMASK(2, 0), (x))
 #define   SVC_I3C_MSTATUS_STATE_DAA(x) (SVC_I3C_MSTATUS_STATE(x) == 5)
+#define   SVC_I3C_MSTATUS_STATE_SLVREQ(x) (SVC_I3C_MSTATUS_STATE(x) == 1)
 #define   SVC_I3C_MSTATUS_STATE_IDLE(x) (SVC_I3C_MSTATUS_STATE(x) == 0)
 #define   SVC_I3C_MSTATUS_BETWEEN(x) FIELD_GET(BIT(4), (x))
 #define   SVC_I3C_MSTATUS_NACKED(x) FIELD_GET(BIT(5), (x))
@@ -143,6 +144,12 @@
  * Fill the FIFO in advance to prevent FIFO from becoming empty.
  */
 #define SVC_I3C_QUIRK_FIFO_EMPTY	BIT(0)
+/*
+ * SVC_I3C_QUIRK_FLASE_SLVSTART:
+ * I3C HW may generate an invalid SlvStart event when emitting a STOP.
+ * If it is a true SlvStart, the MSTATUS state is SLVREQ.
+ */
+#define SVC_I3C_QUIRK_FALSE_SLVSTART	BIT(1)
 
 struct svc_i3c_cmd {
 	u8 addr;
@@ -586,6 +593,11 @@ static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
 	/* Clear the interrupt status */
 	writel(SVC_I3C_MINT_SLVSTART, master->regs + SVC_I3C_MSTATUS);
 
+	/* Ignore the false event */
+	if (svc_has_quirk(master, SVC_I3C_QUIRK_FALSE_SLVSTART) &&
+	    !SVC_I3C_MSTATUS_STATE_SLVREQ(active))
+		return IRQ_HANDLED;
+
 	svc_i3c_master_disable_interrupts(master);
 
 	/* Handle the interrupt in a non atomic context */
@@ -2018,7 +2030,8 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
 };
 
 const struct svc_i3c_drvdata npcm845_drvdata = {
-	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY,
+	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY |
+		SVC_I3C_QUIRK_FALSE_SLVSTART,
 };
 
 const struct svc_i3c_drvdata svc_default_drvdata = {};
-- 
2.34.1



Return-Path: <linux-kernel+bounces-520747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1141A3AEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F97F7A2FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6DD25757;
	Wed, 19 Feb 2025 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdhYC/u5"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCBC13CFB6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739927436; cv=none; b=r87e/oKooqQ1umRUDTtTRPkpvT9wPbH77CtoHEYDDUeolB5A9S320Ai8+bmLCHg/yoeIONMhJ1JLL+Xm9GZkuNdYpt8D5TcYQCLWl74pp/hQm/ZxHTGntiW/hv0XYQYe76nr4Q7sIOjjql6RGXNz5wU6764R/0JfnD4Z0BCgndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739927436; c=relaxed/simple;
	bh=torwI9xzLIIK0HgPjCTxvzGxXal9Q+8FEMK+XHcTf10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qQ+Q1O5sMT1ZAjms8cNq8bhgmrMie800fsOzO48ZayMDx9lxpiYEvnoRqMySAEJcy6xHL10D7XcxTHeMHa+fZ9SvWxezvaZbsC6XiXoGMniP/+kg7a01uAjNrU8oZfWwdDpVzKLa5u7tal2iGQfL3dwLBebEsyXps7gn4AxwjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdhYC/u5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220ca204d04so84542965ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739927434; x=1740532234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3mYC7ENmf6rcEpzheezEvM9BfeiOk2Z8ZQkMdJrj/8=;
        b=JdhYC/u5jTWkP0KBFgA1DXTVRmvLboKf66oG8TLBTQuyUba6euqkQS8Ca8Sda6LseY
         jIZtX6Fpz3qO1Gh+mKnqX3ifm1UbwSdnY0RFMRms3jJqw2t6Fypv+FzJzYvNj7Q5ADfl
         nwNls4sTl11hO2RhXKapMuQ9WigpkjHzX+zFmuIC6MO5T9F2SENw/Gyz9TBW1buciTRE
         CXbc/28sQq4S6lsohlENBIaDrZa3isWDYsylHcUxq50MDtrfsJBEwejF16ydJknqi+9w
         vFSSnmXN895uOIx5Te0ovGAdlQLOZ+KOZK2ZcjDD2Q33sWzsKT4WTOjry41SVoWmyO2N
         /aTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739927434; x=1740532234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3mYC7ENmf6rcEpzheezEvM9BfeiOk2Z8ZQkMdJrj/8=;
        b=pL0K3kvTcOLGjXzFGmSdCZArfSNKytQcSPl6IY3drSYEEIy4G1OP5CA2nAbf3l8051
         WFl404bv71OSUgGzpSG1lTO+RGQwzyPEGMHdEdW4FINxet4fnMY+mq/ztnj0I5U+RmCE
         Q+DZN6u6CrRUS3fqLBupRlP2FwylksNJyfiHXLDuyIwukTQwJJPXzXPzENwC7oSf/HWk
         yw8B3HTmdjO+YeFemiZASQ1LaDY5A0XyjEwcT6tA9cWBCn0tIIYviZVQw7RZtcb2m2uP
         7XGC0sK0V3pcHaIWDaqRph+PzN6JeoXry2tux5/pS7TdPs+F8RS29SELjhkBuO0T7Rxk
         DHrw==
X-Gm-Message-State: AOJu0YwxtnzGTJwk6GfWJkf+WIfasE0KXcVg1PK0/EoaYkMLAH5VIyyC
	4VFCnCYgvEPAkmTe5QmF3D66/qPTNfycPeb3aoOgSPEp6DrHgub5
X-Gm-Gg: ASbGnctb8Ty8ZTgrsD9pknn5v/IB5n9c1vgfs7r6ZObMTrGwnZyCPXcWrcFc0PdQwlQ
	q8Hgh100oIWQUT4hYURp7UbbuRRx9ssBf3DykeLsFNy2ydFNnLOQZADNEt0q2gUsCdiVpWDP040
	VG+5bvX7PCrCCJ6Ino+4tUF7YzUaEzTLEBYA6RyGNrfEGXHAtGe/loGjzIPv3fiucpYkMy7LJlm
	fWwIjspeNfTO4S1mfNs09W1desLxypjvLaMQCKl5EAlRoO+smVDOt8hrWhG7xGrkf4C2j5WyM/C
	TTy+IDBHrwfBfxAUE/R45dCf0w==
X-Google-Smtp-Source: AGHT+IGXfY3WGuhGV/3mSu1e9ym7RxoJ3BskUzPfy/qOHknOlucPS8A+jBmMTZSyoS6Zh/ed/iN22g==
X-Received: by 2002:a17:902:f550:b0:21f:7077:2aaf with SMTP id d9443c01a7336-221711c2a34mr23963485ad.44.1739927432623;
        Tue, 18 Feb 2025 17:10:32 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5348f05sm96080315ad.2.2025.02.18.17.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 17:10:32 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v1 3/3] i3c: master: svc: fix npcm845 invalid slvstart event
Date: Wed, 19 Feb 2025 09:10:19 +0800
Message-Id: <20250219011019.1600058-4-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219011019.1600058-1-yschu@nuvoton.com>
References: <20250219011019.1600058-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I3C HW may generate an invalid SlvStart event when emitting a STOP.
If it is a true SlvStart, the MSTATUS state should be SLVREQ.
Check the MSTATUS state to ignore the false event.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 22cb1f1c1fdc..14cedcb81c52 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -59,6 +59,7 @@
 #define   SVC_I3C_MSTATUS_STATE(x) FIELD_GET(GENMASK(2, 0), (x))
 #define   SVC_I3C_MSTATUS_STATE_DAA(x) (SVC_I3C_MSTATUS_STATE(x) == 5)
 #define   SVC_I3C_MSTATUS_STATE_IDLE(x) (SVC_I3C_MSTATUS_STATE(x) == 0)
+#define   SVC_I3C_MSTATUS_STATE_SLVREQ(x) (SVC_I3C_MSTATUS_STATE(x) == 1)
 #define   SVC_I3C_MSTATUS_BETWEEN(x) FIELD_GET(BIT(4), (x))
 #define   SVC_I3C_MSTATUS_NACKED(x) FIELD_GET(BIT(5), (x))
 #define   SVC_I3C_MSTATUS_IBITYPE(x) FIELD_GET(GENMASK(7, 6), (x))
@@ -143,6 +144,12 @@
  * Fill the FIFO in advance to prevent FIFO from becoming empty.
  */
 #define SVC_I3C_QUIRK_FIFO_EMPTY	BIT(0)
+/*
+ * SVC_I3C_QUIRK_FLASE_SLVSTART:
+ * I3C HW may generate an invalid SlvStart event when emitting a STOP.
+ * If it is a true SlvStart, the MSTATUS state should be SLVREQ.
+ */
+#define SVC_I3C_QUIRK_FALSE_SLVSTART	BIT(1)
 
 struct svc_i3c_cmd {
 	u8 addr;
@@ -576,6 +583,11 @@ static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
 	/* Clear the interrupt status */
 	writel(SVC_I3C_MINT_SLVSTART, master->regs + SVC_I3C_MSTATUS);
 
+	/* Ignore the false event */
+	if ((master->quirks & SVC_I3C_QUIRK_FIFO_EMPTY) &&
+	    !SVC_I3C_MSTATUS_STATE_SLVREQ(active))
+		return IRQ_HANDLED;
+
 	svc_i3c_master_disable_interrupts(master);
 
 	/* Handle the interrupt in a non atomic context */
@@ -1915,7 +1927,8 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 	svc_i3c_master_reset(master);
 
 	if (device_is_compatible(master->dev, "nuvoton,npcm845-i3c"))
-		master->quirks = SVC_I3C_QUIRK_FIFO_EMPTY;
+		master->quirks = SVC_I3C_QUIRK_FIFO_EMPTY |
+				 SVC_I3C_QUIRK_FALSE_SLVSTART;
 
 	/* Register the master */
 	ret = i3c_master_register(&master->base, &pdev->dev,
-- 
2.34.1



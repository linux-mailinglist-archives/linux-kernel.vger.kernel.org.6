Return-Path: <linux-kernel+bounces-523013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFBFA3D0FC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6190C189DD5B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B81E5721;
	Thu, 20 Feb 2025 05:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bT1pu+a5"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447C31E47C5;
	Thu, 20 Feb 2025 05:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740030229; cv=none; b=iGTwWbONmo0R1oiEvF198WEtuwiQjUWIZkMCuw0bRom1owXQlUjIFOAGSOe2NZbuyeQZzGppcwvFERfYmbGAcL+cmaEqsOMTflFLGeOudqzWM0SsWxSLs+oEwuvhj10yOuBHsg4qSZAEhQURaYvAC59uep9kre4dmmOvVt2sQv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740030229; c=relaxed/simple;
	bh=m2cYmUh+KamvrrBS1L6miPwNFXrZm6t9/n8dqxo3Iu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CNkfNTbLLAncRILLr54pS592wPcrhcp9vUko+TZhcSVwUnwtjQvVs+YOQz3QGn5xTsnmiYjGyadvy8uz1Sakr4/+gxv3iCakDtZeH0lRJm9tsm/ieTEtfXpvpmtkG0obhy4p5igCNZ41dfAtXmEstKAtxrLVzCSxmberShFRon8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bT1pu+a5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2211acda7f6so9643775ad.3;
        Wed, 19 Feb 2025 21:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740030227; x=1740635027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdyLMLTg8byPe8k/ZJkRLFsyG1RrElmC3EJS6e+873Y=;
        b=bT1pu+a5pPqkrvJdScvcCZpNDvVlAFPjJH1NaaSFQsclqePxNF3o80mogo+YbAwiPh
         qROQgGg5tpzVwh40a/RYqmgfM+sVWx3nOj/eKeObHEmsZQZDtKfY1wPhm21Gi37BVNWg
         PlNC8C9/0E32IF0QPpRub7+DAafGo9T73bL/2PHNLGY9+D0G8N8/kVJj0llL4mkmXBJU
         bkIpQxKZbBuItA6RXnhviKYvnmIa9KLFGhqQM9nnQsimZmaDd/jEhWGAkB9G4AZMFLDV
         eoMBDAjVP1GmSXU6o9srl4JlMas9RqtjgfiGWkRmOh4zVW3FX+qb3qmYh+VE22tbPpLO
         mc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740030227; x=1740635027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdyLMLTg8byPe8k/ZJkRLFsyG1RrElmC3EJS6e+873Y=;
        b=iQ1Kvb/u0MUZnD7FjIYda9xbzJMjSfgOP6cVKWRs7NnW+qKruUXbLP7giq34dZgFlv
         VvB5ToOEBFcTX2pG0RmnZNBj77bwbI72wCD1aapQ+yZjRv186MYh1zJigmAwA2fL3YZA
         XDiIhwYJtczDaIKqAMft7+zXkJxueQS3e1XTE7I6Ra0kskrn8DQhdJB0vxa231nCqdcA
         Q7W8bGpyF8rDxSbPvCd1QbiIL7yakVaz0Yjg8VNMjDZO7UuLiF1S/95/AoeVOGz1FG1X
         6IupaIzWw1UCj1V/af1YOHGrDrjNhatbx/dB/vz6U9TqtMfhAsE9mXiA3rLMHbi2csCD
         NvUg==
X-Forwarded-Encrypted: i=1; AJvYcCWhMkPLqtZcWxP+Dlm2TMa2vFh3KpysRT9I8s9e8p9yn5wyXaBnvt2bquMqigYWxh71jvUY7b4TXlnt@vger.kernel.org
X-Gm-Message-State: AOJu0YyvD0kPMe4l1KBGlmafE11iR344nLfX9/vY/iKvXQGXSMGuW7H5
	EyHMg3qf+xveemwGjRQ2BuIKkhpxj6Ko9n1yPbwR4O/MusQoouol
X-Gm-Gg: ASbGnctWjbnVBp4I0htktq2xfbx3FuDMk4WYWvsXpNPW5sHhFvoNwLSUvYMY79GYnBE
	qGLYTNe3566cO4EVT+1NTcSn4ObrVTqHIkGeQS2fx0pqh3/j7pZ6O4HivRtB7hxj8w/3Rppal0C
	jMYUmdAqO5L5ND0vaOexl32YX3FhPyu039vks0icXmoUrJDgyQW+MqFnvl71dQgSenJWW3wFgX3
	LYfHxuPWKcpcXAZz+gs3t9eI1SrVS0D53ltYS8Vazl/TIK8hILzQmsDr5S+/0FVE0hoPovHbSQp
	uqL3JLm3yJWS5x/fo3iDHTzbOA==
X-Google-Smtp-Source: AGHT+IHpDIBFsH7vbUvCxPzxU+DThzUJ3gvnL5P2dGfiTDolUeJEuC1kCfITRVmlniKuIgAkbGy8og==
X-Received: by 2002:a17:902:f609:b0:220:d79f:60f1 with SMTP id d9443c01a7336-2217119ecc7mr98131815ad.42.1740030227442;
        Wed, 19 Feb 2025 21:43:47 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534951fsm114415335ad.25.2025.02.19.21.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 21:43:47 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v2 2/4] i3c: master: svc: Add support for Nuvoton npcm845 i3c
Date: Thu, 20 Feb 2025 13:43:28 +0800
Message-Id: <20250220054330.1711979-3-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220054330.1711979-1-yschu@nuvoton.com>
References: <20250220054330.1711979-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nuvoton npcm845 SoC uses the same Silvico IP but an older version.
Add npcm845 specific quirks.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index d6057d8c7dec..c58440061d5a 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -133,6 +133,22 @@
 #define SVC_I3C_EVENT_IBI	GENMASK(7, 0)
 #define SVC_I3C_EVENT_HOTJOIN	BIT(31)
 
+/*
+ * SVC_I3C_QUIRK_FIFO_EMPTY:
+ * I3C HW stalls the write transfer if the transmit FIFO becomes empty,
+ * when new data is written to FIFO, I3C HW resumes the transfer but
+ * the first transmitted data bit may have the wrong value.
+ * Workaround:
+ * Fill the FIFO in advance to prevent FIFO from becoming empty.
+ */
+#define SVC_I3C_QUIRK_FIFO_EMPTY	BIT(0)
+/*
+ * SVC_I3C_QUIRK_FLASE_SLVSTART:
+ * I3C HW may generate an invalid SlvStart event when emitting a STOP.
+ * If it is a true SlvStart, the MSTATUS state should be SLVREQ.
+ */
+#define SVC_I3C_QUIRK_FALSE_SLVSTART	BIT(1)
+
 struct svc_i3c_cmd {
 	u8 addr;
 	bool rnw;
@@ -216,6 +232,7 @@ struct svc_i3c_master {
 	struct mutex lock;
 	u32 enabled_events;
 	u32 mctrl_config;
+	u32 quirks;
 };
 
 /**
@@ -230,6 +247,14 @@ struct svc_i3c_i2c_dev_data {
 	struct i3c_generic_ibi_pool *ibi_pool;
 };
 
+struct svc_i3c_drvdata {
+	u32 quirks;
+};
+
+const struct svc_i3c_drvdata npcm845_drvdata = {
+	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY | SVC_I3C_QUIRK_FALSE_SLVSTART,
+};
+
 static inline bool is_events_enabled(struct svc_i3c_master *master, u32 mask)
 {
 	return !!(master->enabled_events & mask);
@@ -1811,6 +1836,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct svc_i3c_master *master;
+	const struct svc_i3c_drvdata *data = of_device_get_match_data(dev);
 	int ret;
 
 	master = devm_kzalloc(dev, sizeof(*master), GFP_KERNEL);
@@ -1868,6 +1894,8 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, master);
+	if (data)
+		master->quirks = data->quirks;
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SVC_I3C_PM_TIMEOUT_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -1960,6 +1988,7 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
 
 static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
 	{ .compatible = "silvaco,i3c-master-v1"},
+	{ .compatible = "nuvoton,npcm845-i3c", .data = &npcm845_drvdata },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
-- 
2.34.1



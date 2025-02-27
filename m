Return-Path: <linux-kernel+bounces-535664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221C1A475B8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7FB16FED3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C66621CC72;
	Thu, 27 Feb 2025 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMBeHwMg"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3645521B9FA;
	Thu, 27 Feb 2025 06:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740636112; cv=none; b=PomkGrbvg2T1UShGYcRHHjKmHCmRRF0svEy18QsTYykBnc87tqzy9Xvqox/y1ViAWiSS475I51LuMCMT1iGGyqcmUKZ5Lx5DqjGDF3xwFCkwOvlkQ9tlzDu1lLIxXum1UZ78LJUwee/IlKOJ519szBu0bRSoT/edvTrP0gV+4Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740636112; c=relaxed/simple;
	bh=WgQiFtvSaXDUKj25QoRJIdQwRAilkoADHx3Rz71ZUf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=twHnY8A6X+mJyXDBVLR9qgZRQLG16ao08gpfMzaKczOQhZrkvNDNoN8NBGNj/wVMErfRB4v0YX4Lkr1qF7+loWfvVBcQU+v+Kulm6IXMQtDXq1aNyof81ZOxyv2iWgXIokZqyJr+zt6Ug6W+ebAIpMvujxS9DbTHslKLwmfdThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMBeHwMg; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fe98d173daso983589a91.1;
        Wed, 26 Feb 2025 22:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740636110; x=1741240910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okBbsi8R7J7tXxfGwTKtAERjRy2rLXaYUYDOVdToU2Y=;
        b=HMBeHwMgaMHiyNiw8EXQHBOeR5cnwrWbHWQciR8tqzWjpZSFDdDwTAAOA/tcFBgmEr
         v8IxSyhK9CgKAcuAeXL7b0OYHIZsvSBSeNeUOnyMyIN6wmHKHPuna6zJUhG+yO4M9yzX
         aAASunUJaXyt5jOLDrePbQ6wEYxgC2oCFalbxnvDr4hjUWi3uK/jGHMoJ9pk35X0hNRq
         wJVcvDU59fKW43Szf2J6wOkcl1i7hOyJtfT5nMfRE5VD/H51QUiEucuolK5LWHSV7+mY
         DVY8K3UOdlHhINwSBPetn2hx/qx91y/DW/9ti1q0okEhHDv0T/dzWJJjoUOb5a5aVjhV
         XePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740636110; x=1741240910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okBbsi8R7J7tXxfGwTKtAERjRy2rLXaYUYDOVdToU2Y=;
        b=Qoa5XUcndvpdh4LXBouMgNyhXIR+lvDNyW24GIT4q67VakQ/wGgFQwb+FgLWwFOk5u
         ZAMcLunGNI7GrynVrFutY+/bKwvCzTSq3fZ0t7/f6A8ifuCJdpZBYtHS2ncjIszTb8FB
         PaUaY20ZN8I8258F5DFIiiK8/twUco7MgyfNynlm7sx9H847lSetWwdVT4iSeITC7tq/
         q8IsNznx75DR0JEo7TC/0WOYrHBCwHzD+a3h+ydcIKITyakQzmsEXHXtI8ZDsJeOPBuX
         +bZAYCTAYm+U/o1OSRLKNEIWuLh+N7q+8ouZmSp7R+fw7TVXJU95np7gbqHs+eXWOBfB
         vY5A==
X-Forwarded-Encrypted: i=1; AJvYcCV3pWGTAFn3DwT/UkCELDPqkBRtBgqNuMcvcUgFA8W9byBN5Fow7yRbddWyV1R5lNdG+vbw3UvczlZu@vger.kernel.org
X-Gm-Message-State: AOJu0YwDB+nnyWoIexloykoZMZZ7Q/FSalou8IfZuoAqH2jKmtPyV8mm
	rmPav67KWIkv4d6F8TP6eaHqclePg0jYIGQwv4zbGR1lm9yih1+9
X-Gm-Gg: ASbGncu+Iv9IXLR7nOBfzn8JutpqyNURb89ASHy37Sez4oRlAZdAlv9S+bU+uLfcXb2
	hev4Yhp1ccHGjF+9eR6Y6ualhru+gduf4QjxmrSE8IuFsiCvKVJYSOAe61k0Y+Ii9CZSnqLOgsy
	o7hSoL9OTaV7tI7mb2h8mFsc+C4NeQYDo+X1h4MumqN7nAihPM8FHNiQ1GPJqLXCnttX2fx40kv
	yxxjEKwsSQ+VaZRcv6mcFA9ZNH4vd67Mxpdg7XFS3zw2OFBA/wRwQmS0W7vDOODDnL3A10wA1jD
	W2SUjVA9V0A2ZGBEfG9SZnwXcQ+RFkCnpHEe
X-Google-Smtp-Source: AGHT+IHTzGNN16mA3hpJreOiHYFjyZ3AeGJoP48E0laGo4020Qg/YZh8K/FYFaSVpFevtJH+vOQWPQ==
X-Received: by 2002:a17:90b:5148:b0:2ee:c9b6:4c42 with SMTP id 98e67ed59e1d1-2fce86cf0ebmr42714472a91.16.1740636110407;
        Wed, 26 Feb 2025 22:01:50 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:cd02:bc36:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe824b67a1sm2728177a91.0.2025.02.26.22.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 22:01:50 -0800 (PST)
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
Subject: [PATCH v5 2/5] i3c: master: svc: Add support for Nuvoton npcm845 i3c
Date: Thu, 27 Feb 2025 14:01:28 +0800
Message-Id: <20250227060131.2206860-3-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227060131.2206860-1-yschu@nuvoton.com>
References: <20250227060131.2206860-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

Nuvoton npcm845 SoC uses the same Silvico IP but an older version.
Add quirks to address the npcm845 specific issues.

FIFO empty issue:
I3C HW stalls the write transfer if the transmit FIFO becomes empty,
when new data is written to FIFO, I3C HW resumes the transfer but
the first transmitted data bit may have the wrong value.

Invalid SlvStart event:
I3C HW may generate an invalid SlvStart event when emitting a STOP.

DAA process corruption:
When MCONFIG.SKEW=0 and MCONFIG.ODHPP=0, the ENTDAA transaction gets
corrupted and results in a no repeated-start condition at the end of
address assignment.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 56 ++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index d6057d8c7dec..9143a079de53 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -32,6 +32,7 @@
 #define   SVC_I3C_MCONFIG_ODBAUD(x) FIELD_PREP(GENMASK(23, 16), (x))
 #define   SVC_I3C_MCONFIG_ODHPP(x) FIELD_PREP(BIT(24), (x))
 #define   SVC_I3C_MCONFIG_SKEW(x) FIELD_PREP(GENMASK(27, 25), (x))
+#define   SVC_I3C_MCONFIG_SKEW_MASK GENMASK(27, 25)
 #define   SVC_I3C_MCONFIG_I2CBAUD(x) FIELD_PREP(GENMASK(31, 28), (x))
 
 #define SVC_I3C_MCTRL        0x084
@@ -133,6 +134,32 @@
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
+ * If it is a true SlvStart, the MSTATUS state is SLVREQ.
+ */
+#define SVC_I3C_QUIRK_FALSE_SLVSTART	BIT(1)
+/*
+ * SVC_I3C_QUIRK_DAA_CORRUPT:
+ * When MCONFIG.SKEW=0 and MCONFIG.ODHPP=0, the ENTDAA transaction gets
+ * corrupted and results in a no repeated-start condition at the end of
+ * address assignment.
+ * Workaround:
+ * Set MCONFIG.SKEW to 1 before initiating the DAA process. After the DAA
+ * process is completed, return MCONFIG.SKEW to its previous value.
+ */
+#define SVC_I3C_QUIRK_DAA_CORRUPT	BIT(2)
+
 struct svc_i3c_cmd {
 	u8 addr;
 	bool rnw;
@@ -158,6 +185,10 @@ struct svc_i3c_regs_save {
 	u32 mdynaddr;
 };
 
+struct svc_i3c_drvdata {
+	u32 quirks;
+};
+
 /**
  * struct svc_i3c_master - Silvaco I3C Master structure
  * @base: I3C master controller
@@ -183,6 +214,7 @@ struct svc_i3c_regs_save {
  * @ibi.tbq_slot: To be queued IBI slot
  * @ibi.lock: IBI lock
  * @lock: Transfer lock, protect between IBI work thread and callbacks from master
+ * @drvdata: Driver data
  * @enabled_events: Bit masks for enable events (IBI, HotJoin).
  * @mctrl_config: Configuration value in SVC_I3C_MCTRL for setting speed back.
  */
@@ -214,6 +246,7 @@ struct svc_i3c_master {
 		spinlock_t lock;
 	} ibi;
 	struct mutex lock;
+	const struct svc_i3c_drvdata *drvdata;
 	u32 enabled_events;
 	u32 mctrl_config;
 };
@@ -230,6 +263,25 @@ struct svc_i3c_i2c_dev_data {
 	struct i3c_generic_ibi_pool *ibi_pool;
 };
 
+const struct svc_i3c_drvdata svc_default_drvdata = {};
+const struct svc_i3c_drvdata npcm845_drvdata = {
+	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY |
+		SVC_I3C_QUIRK_FALSE_SLVSTART |
+		SVC_I3C_QUIRK_DAA_CORRUPT,
+};
+
+static inline bool svc_has_quirk(struct svc_i3c_master *master, u32 quirk)
+{
+	return (master->drvdata->quirks & quirk);
+}
+
+static inline bool svc_has_daa_corrupt(struct svc_i3c_master *master)
+{
+	return ((master->drvdata->quirks & SVC_I3C_QUIRK_DAA_CORRUPT) &&
+		!(master->mctrl_config &
+		(SVC_I3C_MCONFIG_SKEW_MASK | SVC_I3C_MCONFIG_ODHPP(1))));
+}
+
 static inline bool is_events_enabled(struct svc_i3c_master *master, u32 mask)
 {
 	return !!(master->enabled_events & mask);
@@ -1868,6 +1920,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, master);
+	master->drvdata = of_device_get_match_data(dev);
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SVC_I3C_PM_TIMEOUT_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -1959,7 +2012,8 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
 };
 
 static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
-	{ .compatible = "silvaco,i3c-master-v1"},
+	{ .compatible = "silvaco,i3c-master-v1", .data = &svc_default_drvdata },
+	{ .compatible = "nuvoton,npcm845-i3c", .data = &npcm845_drvdata },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
-- 
2.34.1



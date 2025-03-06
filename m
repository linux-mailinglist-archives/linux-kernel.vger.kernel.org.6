Return-Path: <linux-kernel+bounces-548379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEA2A54408
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0391664C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E658C1FCFD9;
	Thu,  6 Mar 2025 07:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwY36xIL"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662451FC7FC;
	Thu,  6 Mar 2025 07:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247688; cv=none; b=KvjXmaKVZD1E55gmzkA5ARG6A416OAzb5YDFIQYFxV/0wluJnsszJJNQDAKPYEjul2/QsHQCUo8yolXz2ll5roosQ3I/f8qBIP/0/xMXYCq6fQtg0jpnJL3TyHxthWV0S1x2vGK+SGYs4TeKFuteBDmYSx63Wn4fpQi7VuudwbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247688; c=relaxed/simple;
	bh=BGdtgGjecU9Y9WjgrE1NhOVjSWJFz3oecpoqxxs/E08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mqt+psYhR9cTztw/iOHGXGjXj/69ufFqYvXE5ciqSqmz3zqHRbA/j9hHHU+Od2RQNlOXGgxVevTx8sIaLERgVk3xlwH2ZmqC3xOIqoaMTwdJjjo2I5VNFrhZlgp6LWbqYYBnekLEZklhbP3kSFzFZEQj2O9uDXa1R9RWTXrhS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwY36xIL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2234e5347e2so4976605ad.1;
        Wed, 05 Mar 2025 23:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741247685; x=1741852485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEZQpIQJFkHZeLv9/Dqh07QChyI7uFyuz8YE5XUUtDc=;
        b=PwY36xILoh3vLj3BZnyin25OCuHS66AProq84e7HMMvr6/pAdIUHs9p/7nC+lY98DZ
         UssiJ/+ihfiPjWZXXYKFtpxsTW0EjsW38j5QxrApAojByIB4bNOyCFCoiwHJEuFCs94Y
         +xIf66r5vG9OR453xF5NAWg5U6Vcq6R/CyFUR3cuyq06oc0pVT6rUD9HtpzPFM9vk0gL
         N6qzk//ptgK0QJ9cHLzoQx9LLp5e6EJ9QoWFaT019Wwp/NW4s68OTcA16vKG/GCxo4ne
         Azp5GSsrKmC4I50g1df/NP3PKLyBBgr0vjqeGvPQ9mAFIRJ5LgXVt4HdgGxshFtBJIZh
         5cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741247685; x=1741852485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEZQpIQJFkHZeLv9/Dqh07QChyI7uFyuz8YE5XUUtDc=;
        b=nHsDYn+QQHdD3xeS4brszQaCXAVqyrSf4mG81xJSEFVeRv6zjCqXTDCrEob6POQab1
         Qw18c3vO8sGglxqurFrm1R8DAc8s/wUe+hGqL0uM3KGsi+u1Xf8Uak5mQ7tTyjI8o6Ql
         sJac/d/96D5O0rj6iKCX6wa7orpw4rTJ5Y0g4OCdCT2z9/XJSw/UoLy9Pp8+b15D1z2q
         pNQBfVhyFpLtZOu66t25sMlTNe7Z5fCtQ665oYTgM9O27HsbNLf+g6/GfZsmzEa0+f+L
         9uPcFIvWFqJcd0f4gy83+hHkR0w8sdJo+li1ohsQ/z5fA7QZAsmO/UKPPQyZtDEjvvQs
         CB4A==
X-Forwarded-Encrypted: i=1; AJvYcCWGeBRur3V0t10IPbO3301qWvLUbtrcpdWlOh1oJJX7KNmnLc5NoR4X2+xRQOpw9uDaboZDSFtuynzr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7cWucFYlPko2c05TSHfr5hgXUPRAJ1cGy449X+XwJRPLL0CGP
	ocY9n6o/FapXRUOIwI43Dt6R9M3O3UnjrQAGGAedrRcOj+pamSEy
X-Gm-Gg: ASbGncvihuQVHfObwapFipFCcNPJQNJRraO1FUDusMpfMBQGU/MW4yD4CMNRxBjDSp9
	c5OyrqLiHdYh60FXpFRGNH+guNlGRgAWODdkxnokibSSAT5aGODNEsOQPKbEZ6n+f/pwoQFOycD
	wsWGOdLwReRRCHg//PShAR3h+QSA2j4I6aSzSd7s3IdBTgIZpEftIIjRZ09wUR3ZyOMcX2KYWHO
	9lTxxb7uNAEfDOKUnSiSphBmGt9HBmyzC8dYKlt2aazPCRw+hGbb1Egi3ukOZaZJoOlnsdXgwJz
	gKeN4XVU211OhKqKJ2XU5ezGZabpOMorjRbGH1gEF+XmTrR1FH0Cww8=
X-Google-Smtp-Source: AGHT+IFcL0+B3Hx4sm17S7HaaAzS7pgvJFy07ZpdfXIMFxdeHGAgASq3H6x7BYZUzd2tuu/iirTDGQ==
X-Received: by 2002:a17:902:e950:b0:224:11fc:40c0 with SMTP id d9443c01a7336-22411fc412fmr15782245ad.11.1741247685528;
        Wed, 05 Mar 2025 23:54:45 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:d305:9d26:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa448dsm6085485ad.210.2025.03.05.23.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 23:54:45 -0800 (PST)
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
Subject: [PATCH v7 3/5] i3c: master: svc: Fix npcm845 FIFO empty issue
Date: Thu,  6 Mar 2025 15:54:27 +0800
Message-Id: <20250306075429.2265183-4-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306075429.2265183-1-yschu@nuvoton.com>
References: <20250306075429.2265183-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

I3C HW stalls the write transfer if the transmit FIFO becomes empty,
when new data is written to FIFO, I3C HW resumes the transfer but the
first transmitted data bit may have the wrong value.
Fill the FIFO in advance to prevent FIFO from becoming empty.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 71 +++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 40269b692aa8..cba89a685e13 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -113,6 +113,7 @@
 #define SVC_I3C_MWDATAHE     0x0BC
 #define SVC_I3C_MRDATAB      0x0C0
 #define SVC_I3C_MRDATAH      0x0C8
+#define SVC_I3C_MWDATAB1     0x0CC
 #define SVC_I3C_MWMSG_SDR    0x0D0
 #define SVC_I3C_MRMSG_SDR    0x0D4
 #define SVC_I3C_MWMSG_DDR    0x0D8
@@ -133,6 +134,16 @@
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
+
 struct svc_i3c_cmd {
 	u8 addr;
 	bool rnw;
@@ -236,6 +247,11 @@ struct svc_i3c_i2c_dev_data {
 	struct i3c_generic_ibi_pool *ibi_pool;
 };
 
+static inline bool svc_has_quirk(struct svc_i3c_master *master, u32 quirk)
+{
+	return (master->drvdata->quirks & quirk);
+}
+
 static inline bool is_events_enabled(struct svc_i3c_master *master, u32 mask)
 {
 	return !!(master->enabled_events & mask);
@@ -894,7 +910,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 					u8 *addrs, unsigned int *count)
 {
 	u64 prov_id[SVC_I3C_MAX_DEVS] = {}, nacking_prov_id = 0;
-	unsigned int dev_nb = 0, last_addr = 0;
+	unsigned int dev_nb = 0, last_addr = 0, dyn_addr;
 	u32 reg;
 	int ret, i;
 
@@ -937,6 +953,25 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 		if (SVC_I3C_MSTATUS_RXPEND(reg)) {
 			u8 data[6];
 
+			/*
+			 * One slave sends its ID to request for address assignment,
+			 * prefilling the dynamic address can reduce SCL clock stalls
+			 * and also fix the SVC_I3C_QUIRK_FIFO_EMPTY quirk.
+			 *
+			 * Ideally, prefilling before the processDAA command is better.
+			 * However, it requires an additional check to write the dyn_addr
+			 * at the right time because the driver needs to write the processDAA
+			 * command twice for one assignment.
+			 * Prefilling here is safe and efficient because the FIFO starts
+			 * filling within a few hundred nanoseconds, which is significantly
+			 * faster compared to the 64 SCL clock cycles.
+			 */
+			dyn_addr = i3c_master_get_free_addr(&master->base, last_addr + 1);
+			if (dyn_addr < 0)
+				return -ENOSPC;
+
+			writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
+
 			/*
 			 * We only care about the 48-bit provisioned ID yet to
 			 * be sure a device does not nack an address twice.
@@ -1015,21 +1050,16 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 		if (ret)
 			break;
 
-		/* Give the slave device a suitable dynamic address */
-		ret = i3c_master_get_free_addr(&master->base, last_addr + 1);
-		if (ret < 0)
-			break;
-
-		addrs[dev_nb] = ret;
+		addrs[dev_nb] = dyn_addr;
 		dev_dbg(master->dev, "DAA: device %d assigned to 0x%02x\n",
 			dev_nb, addrs[dev_nb]);
-
-		writel(addrs[dev_nb], master->regs + SVC_I3C_MWDATAB);
 		last_addr = addrs[dev_nb++];
 	}
 
 	/* Need manual issue STOP except for Complete condition */
 	svc_i3c_master_emit_stop(master);
+	svc_i3c_master_flush_fifo(master);
+
 	return ret;
 }
 
@@ -1226,6 +1256,24 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		       SVC_I3C_MCTRL_RDTERM(*actual_len),
 		       master->regs + SVC_I3C_MCTRL);
 
+		/*
+		 * The entire transaction can consist of multiple write transfers.
+		 * Prefilling before EmitStartAddr causes the data to be emitted
+		 * immediately, becoming part of the previous transfer.
+		 * The only way to work around this hardware issue is to let the
+		 * FIFO start filling as soon as possible after EmitStartAddr.
+		 */
+		if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len) {
+			u32 end = xfer_len > SVC_I3C_FIFO_SIZE ? 0 : SVC_I3C_MWDATAB_END;
+			u32 len = min_t(u32, xfer_len, SVC_I3C_FIFO_SIZE);
+
+			writesb(master->regs + SVC_I3C_MWDATAB1, out, len - 1);
+			/* Mark END bit if this is the last byte */
+			writel(out[len - 1] | end, master->regs + SVC_I3C_MWDATAB);
+			xfer_len -= len;
+			out += len;
+		}
+
 		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
 				 SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
 		if (ret)
@@ -1314,6 +1362,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 emit_stop:
 	svc_i3c_master_emit_stop(master);
 	svc_i3c_master_clear_merrwarn(master);
+	svc_i3c_master_flush_fifo(master);
 
 	return ret;
 }
@@ -1968,7 +2017,9 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
 			   svc_i3c_runtime_resume, NULL)
 };
 
-static const struct svc_i3c_drvdata npcm845_drvdata = {};
+static const struct svc_i3c_drvdata npcm845_drvdata = {
+	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY,
+};
 
 static const struct svc_i3c_drvdata svc_default_drvdata = {};
 
-- 
2.34.1



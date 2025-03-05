Return-Path: <linux-kernel+bounces-546046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44973A4F586
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659D716FB0D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE213192D97;
	Wed,  5 Mar 2025 03:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrHw848X"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B32219068E;
	Wed,  5 Mar 2025 03:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146288; cv=none; b=Ah7G7EWFNx5Zu+auP/q9dAo9EC3HXHv1Ot236JbC5P2F5G2YWYDsAMlS9yS/mzc3RZz+jqtyhSgkDhFP+JPxa91j6/+OtAwH6hiW/XXZOIf01yiEEWLxEmjOmZzdIc8zlujJs0z84OKfmSsM+xCiecamyy94PsI3X7YqYPU3C5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146288; c=relaxed/simple;
	bh=iecFRRQddV3zIspJB1emZmnoR5LziWLenNDIFNA16Kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IAbR7+rOnliAxq+6K32+MkpJPYROP4Oil/xob5cjuOt6kDsWqzwRnX+6MBXLni4Afye0O5/aA0hxb/xO++jFYuLYM0Aqkv1NtgkGc4zE3poFY+AGKrmq1nFGPTk7sq2s1XviihQctjcHV/luPURQsW9B1P7kxjLvYzRk4unBZM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrHw848X; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22349bb8605so122796845ad.0;
        Tue, 04 Mar 2025 19:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741146286; x=1741751086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5XgaLNVCOBJH6qLNdTYPllzrDzuWjs4hTrWU2in37A=;
        b=BrHw848XMc5XVHdHBCExEXxM0GSWzuuIBHrTqqZn/18l+zTl/nIPD0+osiK2TxrbOF
         s85DXxR3YFlHFhYw5jFU/TGUDLZAMHjHlJSDwbzP7bCFgdsi51WW7tB58sjrRfuzNZTI
         4eDvPZ5EEvrJUUUG2ucOMeSgKgwOa1S/ekTZTTb6DrkSWvoFgDrbb7EXUkQ3SOk/PNWV
         /X3mYhDlQ/yr1lZfCojAyhOC5d+HAzMU10p+KAiepWIygHP0LUmTnCA3MQAwHMolu3xj
         jmtJXl0zTLpDkjcIMIKCFNir1+/vtGkrbSKZZQsD3XT4MJm5JIPsTHwQdRU6m+GFDCTG
         QIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741146286; x=1741751086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5XgaLNVCOBJH6qLNdTYPllzrDzuWjs4hTrWU2in37A=;
        b=LZhFTGt5OjOkJfhvZ/eHLwMc/s1vG04FIb6+5cF9WL2nyf6mi1bDwTK4tpUHyENkxP
         krddpYFl2Gh2G5J9jPsLIK75IjWMB9aO/E/tG3JtDJsLiaAEd3vRsger/HEIRpwCU2nx
         kDRBRNZ9dvPHK+jTNX8yry2ZO2QMvQUBXdMAjOrn6b4qx+jlarq87NqpuxyyaSftG9uq
         EdOqmGDU4Jgj5r1DIZzfY1zHHsxPnMcTPiPYQ8II3aj9UhrTR1+84vDYK08uMGFwS5XA
         Vtdy7faq8Vk+95jdMIQoBXGtXUYBlct/k9fjJvvjssGKAGO4r9D6TkkGpShnkYHxO4vk
         vRXw==
X-Forwarded-Encrypted: i=1; AJvYcCWvVQBAJ2BPATzQrZLoKtwuiRr7MgrcqBV0UuW4igi+/ytRL0ALmQrSHZdJXRHuDlfHNzhxoEn3EK8M@vger.kernel.org
X-Gm-Message-State: AOJu0Yz91jfW3CvpTUflxIn1cgCMt5ELeowwt8PcXoKjfQYsO+5u+0fy
	UpXxKSuTpZM2QnSWXmrjnagz3+7OdfoPUjNf7+C15ep74+rkqOCB
X-Gm-Gg: ASbGncsBcMLOvXB7AJsogunq8Oer4g86glJiw+WuDjZwdVZJOrCu7yXrvZC6xrY0OY2
	m0erHg6ejeOlHNiZECbFmme1jBPIqLHzRsefEYqmefZADvyp95SIpCIeHvswhvCdFlna/rvfifK
	SCBnnJlOIWQiT4DLTeEtSaIb6/uUVahFV+wcKr6JJfhHj5n/NnQfaIDk68w+hfPyDn/qHcQQBrq
	ayLKRdZDD+lgtKZJpLS7Pc1HBpi6IpDCHVvAh793lPdVUKjfZxv2MSHrV/6u3tdqSIlav8H/kjb
	SwduQbMm6pNZlXXmQX5BTdnYVGGQONb1ximTD0bdjEJOyQ2dgdDfXiw=
X-Google-Smtp-Source: AGHT+IGPoR5eAIQW9xdEo8WStH1w40nmyMmwzBz1XdEZxtqBN5FLjqj3BW1bdcFkkK22otVnGbjCBA==
X-Received: by 2002:a17:902:ecca:b0:215:8809:b3b7 with SMTP id d9443c01a7336-223f1c6b194mr22922005ad.7.1741146285606;
        Tue, 04 Mar 2025 19:44:45 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:d305:9d26:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c37sm102734335ad.133.2025.03.04.19.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:44:45 -0800 (PST)
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
Subject: [PATCH v6 3/5] i3c: master: svc: Fix npcm845 FIFO empty issue
Date: Wed,  5 Mar 2025 11:44:12 +0800
Message-Id: <20250305034414.2246870-4-yschu@nuvoton.com>
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
index 7cafdc8fd1ad..46b032b61f3c 100644
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
 
-const struct svc_i3c_drvdata npcm845_drvdata = {};
+const struct svc_i3c_drvdata npcm845_drvdata = {
+	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY,
+};
 
 const struct svc_i3c_drvdata svc_default_drvdata = {};
 
-- 
2.34.1



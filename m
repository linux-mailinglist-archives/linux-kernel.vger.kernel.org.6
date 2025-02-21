Return-Path: <linux-kernel+bounces-525244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE62A3ECF1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21B3421F36
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98BC1FF601;
	Fri, 21 Feb 2025 06:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/9aD3sn"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3F1FF1CB;
	Fri, 21 Feb 2025 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119746; cv=none; b=KMmbnPyLRjcQJqSmdkkESHWPnBBoIt48CJL6G0gYdtEReoF4zt2Yicishj+zitaDSWTSwpcTalfoIxxr4UY3/ZURw/hhIDwptHcAdo9Q0ht/71xQX+kB0kyvrqJhhW+LXcqkWkZRaJ99TJGsjAaAsJcUq14FuwbzrflSFgC4YNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119746; c=relaxed/simple;
	bh=BHRDJzpyVKhe/ZczGxC5ck8OVO3Qn8BX7p3xQspg/x0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gwJsBfRvWwbKtiTe18kOVD82ydR46R+WzjMZSMR/vfu8K3KOz83PfUoeM5LahzO3d4nfg1+5rx10cKOx24ahiYJYxwjUdsx6xBlKuvzhhyA0eoPK3acQn4y0GqlPfBsh+3moBZRjF7h0hv20whQOhpfPnuP1/gDJ5fcf6i1GqBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/9aD3sn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22128b7d587so33230535ad.3;
        Thu, 20 Feb 2025 22:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740119744; x=1740724544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmC19JBPGsENQ1VkviAHTu5A3YwsTQcs9ernFXwa91g=;
        b=G/9aD3snsiwk0hcKfG/8kFgsYkvKRsIUQg0r7RT3wgZ/hNxIlL4vKuM9bkTvi6Jmch
         iNGgAvaHAQfanVp+xY1EPbusT0tbGaQjCB8T7OilJrkdzFplGqnvqFWC6uMGrZ1T4kjT
         WXAiIuz326/JzqMngxh8Oh7ITuDjCqTPN6DR8ibhkurh7FA95FPcQRu+WzeLEQsgG4Hj
         3yvA8SsQDEFN63ddp7MGHOp11ubyOyOfBVZmTwKm8l9c3/dPZ54zcqFOhBz0eliAlA4N
         YMYJ1fX8HSeRdFL3Xayynpo5LaJSGXQBguEuIjcfAZBtpsJGbLcNNqvrWu5+zphDxS4a
         U2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740119744; x=1740724544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmC19JBPGsENQ1VkviAHTu5A3YwsTQcs9ernFXwa91g=;
        b=s4Tj5KHwpS8aHMnKHAvJeJU6173Efp6ifAZQgcuquBq+Td3WmhTIS13IdgwBA71Z1I
         I50BWwA7ONgQfesRRQHAI9LQI2UdjfqUrf21q6FYmK7ZKkJx8DlQ/NkhDrUQeTOeM8TX
         kOyU1Jy9VQ2Vcc4wAqzxbiSCPTHtVjYmNZ+r3rr9QK7cT+FmDZBG0I1CH7J+IfuMoIwh
         Rdan2gDXt4N7TSG94nQaymkGprIN5RnO3L3DUPhijB9ubyLcOY3xv9wm+FR2gRC4Q6NT
         lmUgTZCvHcRuVvQaGJk/e5y8SKV0PMXbDGzZxmGMcZS9isOsT9KUUMsUoDgQgpI9nURN
         0XeA==
X-Forwarded-Encrypted: i=1; AJvYcCUl4PX5yolu3eTjuBqIVi7oUvqND1qRciLYB2RmnvE7iPA75fiQ1AvA0TmmTcuzEz/RgOU6W+0pw8N6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpx/p7JxYxDBYVwb7vxaS/huabjHLIuUZY0l8c3TqASI3gKonx
	1cufa6GCBKpe+PQaYcz6KZY3BnHy/+NxlBMK5ivD1iUIdGtLWWaD
X-Gm-Gg: ASbGncvOikrp14G93KB16c2CN89jeobYpGBi1GSTftNxtYKNql5EGQkhRdmrtZhrbYm
	b7mpr35wmIiW63FMx/b/wFEmwScGiYa6WHUMhzxHgt2KT1s1MWQ9bXC7cN0DItMdfhMDoUuD1Zi
	5bLlSrs7cg3+vDTWprn4ioKbIr8J+rAe5ADB60iXaTApsP1TsxU/3HbABBPmDPpIRVBU+I5LW/I
	Hm6haA0gpLT0P5him2bI7AAuv/tiusV4K8teJ60jNnpsNedvOxJZNy2pYXSyZ6c1PqWik6CNCKl
	LElfsembMoWMOWxWKSthSlI7v1tApP9VbzLL
X-Google-Smtp-Source: AGHT+IHcLopNzqkHAb76GoiyWMDUo2xcF/l6UUNHRIBoO6hb5KRaBtRoFFyBw9WH1MBRsIG3Mamdtg==
X-Received: by 2002:a17:903:18b:b0:221:1cf:da1 with SMTP id d9443c01a7336-2219ff5f759mr40749795ad.24.1740119743680;
        Thu, 20 Feb 2025 22:35:43 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb57c5dc68sm13777275a12.9.2025.02.20.22.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:35:43 -0800 (PST)
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
Subject: [PATCH v3 3/4] i3c: master: svc: Fix npcm845 FIFO empty issue
Date: Fri, 21 Feb 2025 14:35:27 +0800
Message-Id: <20250221063528.1810007-4-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221063528.1810007-1-yschu@nuvoton.com>
References: <20250221063528.1810007-1-yschu@nuvoton.com>
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

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 43 +++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 1e7e3e1f3d22..7919a49e97c7 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -921,6 +921,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 	unsigned int dev_nb = 0, last_addr = 0;
 	u32 reg;
 	int ret, i;
+	u32 dyn_addr;
 
 	while (true) {
 		/* clean SVC_I3C_MINT_IBIWON w1c bits */
@@ -961,6 +962,17 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 		if (SVC_I3C_MSTATUS_RXPEND(reg)) {
 			u8 data[6];
 
+			/*
+			 * Filling the dynamic address in advance can avoid SCL clock stalls
+			 * and also fix the SVC_I3C_QUIRK_FIFO_EMPTY quirk.
+			 */
+			dyn_addr = i3c_master_get_free_addr(&master->base, last_addr + 1);
+			if (dyn_addr < 0) {
+				ret = -ENOSPC;
+				break;
+			}
+			writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
+
 			/*
 			 * We only care about the 48-bit provisioned ID yet to
 			 * be sure a device does not nack an address twice.
@@ -1039,21 +1051,16 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
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
 
@@ -1201,8 +1208,8 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
 	return offset;
 }
 
-static int svc_i3c_master_write(struct svc_i3c_master *master,
-				const u8 *out, unsigned int len)
+static int svc_i3c_master_write(struct svc_i3c_master *master, const u8 *out,
+				unsigned int len, bool last)
 {
 	int offset = 0, ret;
 	u32 mdctrl;
@@ -1219,7 +1226,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 		 * The last byte to be sent over the bus must either have the
 		 * "end" bit set or be written in MWDATABE.
 		 */
-		if (likely(offset < (len - 1)))
+		if (likely(offset < (len - 1)) || !last)
 			writel(out[offset++], master->regs + SVC_I3C_MWDATAB);
 		else
 			writel(out[offset++], master->regs + SVC_I3C_MWDATABE);
@@ -1250,6 +1257,17 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		       SVC_I3C_MCTRL_RDTERM(*actual_len),
 		       master->regs + SVC_I3C_MCTRL);
 
+		if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len) {
+			u32 len = min_t(u32, xfer_len, SVC_I3C_FIFO_SIZE);
+
+			ret = svc_i3c_master_write(master, out, len,
+						   xfer_len <= SVC_I3C_FIFO_SIZE);
+			if (ret < 0)
+				goto emit_stop;
+			xfer_len -= len;
+			out += len;
+		}
+
 		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
 				 SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
 		if (ret)
@@ -1311,7 +1329,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
 	else
-		ret = svc_i3c_master_write(master, out, xfer_len);
+		ret = svc_i3c_master_write(master, out, xfer_len, true);
 	if (ret < 0)
 		goto emit_stop;
 
@@ -1338,6 +1356,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 emit_stop:
 	svc_i3c_master_emit_stop(master);
 	svc_i3c_master_clear_merrwarn(master);
+	svc_i3c_master_flush_fifo(master);
 
 	return ret;
 }
-- 
2.34.1



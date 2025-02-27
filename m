Return-Path: <linux-kernel+bounces-535665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD8CA475BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82514188E7EF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F3621D587;
	Thu, 27 Feb 2025 06:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMFrObb2"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7AB21CC78;
	Thu, 27 Feb 2025 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740636115; cv=none; b=TqDECLGBm5QrvGot0Rr1/JW1BjZN7KA+Qbuus7v91HzfCFd0q15lx6WBVAH+zvpXsAED0VeJY7kJMlNOk06qQ/F8RA1n9ZxYP6jyA4HBf6GzF6HYY4kjpWMTG8vhdElj2nzeFKZD7/32T9OPXi0Yv8zpgdBNpZKCthnKdVz+Rkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740636115; c=relaxed/simple;
	bh=n5x1RSWO88eudXIOnQe5F6cW1vLQoM5iOAUvbK3otuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qnzqghbAWcDgGSgVz92VxtrgFtIi30/muaqolEXamqOrjVxJvprAm92gnXktl80O+9pIaIIEejK4pwj3PCQC6Yl9jLEOG9TeAOrsfp3HcZpj3aqxS5H/1FWcA+TLoE4lR/JrTkemsRrwy5BPMFSMN2fH/UGsdOjxol3Og9+werM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMFrObb2; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f441791e40so964885a91.3;
        Wed, 26 Feb 2025 22:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740636113; x=1741240913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jkvj3L9bGHMjbRbwPbZT9vYFOnv0oJXGKH8ygdTiAFw=;
        b=XMFrObb2l79xaNMksRhsyds/2CVpWYybKSU1NzOgsWMqFZDMCJi3GQ4qLSgQC/lPFe
         C12WQKa+c96kn6KFUTE/OmlNN4vi5Uu146+jFvjJlFxJDYDX5ByZZYoY+mpB2+IUxYn/
         f7loFoyXlnLFCFdM9foKQEZLOfSfROpyhpflV+Xfe0O6RYbi7Y14e1ZMgq9MQvRZRxtW
         URzudA5YkfQysz5XtI5JEKSVSyDUXyi19m4ygjsY4rkIp1M31ff6VuD0uOzNL9l3/MHB
         bqhIeIOH97gSUO4AqEOmVAvUBu97tkBFZoUUH7l8/zltq48vGxSSQspXi95J06Kz12NL
         jj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740636113; x=1741240913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jkvj3L9bGHMjbRbwPbZT9vYFOnv0oJXGKH8ygdTiAFw=;
        b=rqHx8K1O9PHXxCmg49WHWsC7vAvgAcmT2gjPKZzy2ZFL8HYBhFxce1eskVT9qp090w
         KJztOrfTXk9E3dk4ghggOCKsR2d7S/N6/ZR3HT2yCC9g83r322GRlx9EmMk1dOS21/ZA
         k/xh20RZha/hJAOQ8u6lm58xSbzAFWFqIBF1RRDVR+aZWOsvf/1klERVmXR+0pRS8Ub1
         ABEqaJSW+jQFLdu7cfttipVcMmWX/r5gUyV3+ZmY6m0mJOGpLanP0AiqfvLs9bSDx9kD
         iCMoc49a7GkdR/k0LDWnVM5/6XQrVwwEHa4BZ1jJFb6zuVF1iVK1TBlFoupu/k+BS5M0
         d7WA==
X-Forwarded-Encrypted: i=1; AJvYcCUXhZmsSf9iKGv+AC3Qlb4THtsGE8Soby+kueXun778fNrCJpACw6oJ1kbO4amdyFtD00XJeLdk+0In@vger.kernel.org
X-Gm-Message-State: AOJu0YxM3Fxo6bA2gcBAqiKpxEO0GtmkO+S121cTPW+qVtg2HIe1apOS
	+U8PIb4vP16wuE08ijAopmpRF+oF9/VOP3u8G6LfhEhTj7M34hYo
X-Gm-Gg: ASbGncsEWSIk1Ga/DaijUhYeXPSb6f5jhdj58ZAOOlCTkDMXnO61twDVWTISmpVFjpc
	8pVIDDUhsvE9PJnlKcw79CHEsigTc73XQXpyVArmb9wQRuTfJXg7/tG69yE6FSnz51FZzM9Y0Mk
	XQ0gv9K2zbsV10dWrrY6TXU76ez/TbAoMVjGt1HmQrgbBZkaUdlLeyW52ujb4npBeAahTLX7Ycx
	QlXpXv+ssC9lvRigp5elqSePtg81O+91Cu6P0/tfIBC1SoLARCrKmcOPnTLpK1+hKS/aoJ3MJ5Z
	iLQM9pv0Rv32rcVIhdjx5+VKlXxXbzH6PLXr
X-Google-Smtp-Source: AGHT+IGJf1EprWbsXZ2jFkUl5sHahMq3HVyinxDfNpi1XqlJ5NGR7aG6ByojzGWqVWyAfi7gUIv7zQ==
X-Received: by 2002:a17:90b:1f81:b0:2ee:d433:7c50 with SMTP id 98e67ed59e1d1-2fce873af2cmr32572563a91.23.1740636113433;
        Wed, 26 Feb 2025 22:01:53 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:cd02:bc36:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe824b67a1sm2728177a91.0.2025.02.26.22.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 22:01:53 -0800 (PST)
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
Subject: [PATCH v5 3/5] i3c: master: svc: Fix npcm845 FIFO empty issue
Date: Thu, 27 Feb 2025 14:01:29 +0800
Message-Id: <20250227060131.2206860-4-yschu@nuvoton.com>
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

I3C HW stalls the write transfer if the transmit FIFO becomes empty,
when new data is written to FIFO, I3C HW resumes the transfer but the
first transmitted data bit may have the wrong value.
Fill the FIFO in advance to prevent FIFO from becoming empty.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 52 ++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 9143a079de53..a0c6d8053a25 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -114,6 +114,7 @@
 #define SVC_I3C_MWDATAHE     0x0BC
 #define SVC_I3C_MRDATAB      0x0C0
 #define SVC_I3C_MRDATAH      0x0C8
+#define SVC_I3C_MWDATAB1     0x0CC
 #define SVC_I3C_MWMSG_SDR    0x0D0
 #define SVC_I3C_MRMSG_SDR    0x0D4
 #define SVC_I3C_MWMSG_DDR    0x0D8
@@ -940,7 +941,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 					u8 *addrs, unsigned int *count)
 {
 	u64 prov_id[SVC_I3C_MAX_DEVS] = {}, nacking_prov_id = 0;
-	unsigned int dev_nb = 0, last_addr = 0;
+	unsigned int dev_nb = 0, last_addr = 0, dyn_addr;
 	u32 reg;
 	int ret, i;
 
@@ -983,6 +984,25 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
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
@@ -1061,21 +1081,16 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
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
 
@@ -1272,6 +1287,24 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
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
+			u32 end = xfer_len > SVC_I3C_FIFO_SIZE ? 0 : BIT(8);
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
@@ -1360,6 +1393,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 emit_stop:
 	svc_i3c_master_emit_stop(master);
 	svc_i3c_master_clear_merrwarn(master);
+	svc_i3c_master_flush_fifo(master);
 
 	return ret;
 }
-- 
2.34.1



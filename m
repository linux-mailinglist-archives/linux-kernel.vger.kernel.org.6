Return-Path: <linux-kernel+bounces-528428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A114A4179C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8943B5910
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A367120ADE6;
	Mon, 24 Feb 2025 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSVJjGNd"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512771DC99C;
	Mon, 24 Feb 2025 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386394; cv=none; b=DocMfW/nhWCQrAO4Tdgoz5MZ1MNA4bke8nRvTrWWb3VhKDt0TPGEiWip9RzSYu2gCi6m0PRhE2m750wPXFi3wdIrQUIh8hSMD5U/+NcIFYHcRgsPM3Tl7P/Xkkriv3Tu63p7FjN+JzZxGvdunhPQklh4CD7NEYCqWBvQJ0ccpas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386394; c=relaxed/simple;
	bh=qRH5fVxfQAsRwmC+LwhbI9RH7UEigg8d33gbtNKiX84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J36BfJO7WzZkHzD4pfIWAqytqXKXGzUVkbFLpNft59+9U37bruUwpiKPgOP6I+QaRl779t7u1RNauag3n7PD9OfRMFjG954jiA87Nak9EqnRm6qdSN2YnO0j9oQCBxVH/uRrgzwkMxIcCtDZv2DhueM+KGhrggG7iFwjkV/OMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSVJjGNd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220dc3831e3so78357255ad.0;
        Mon, 24 Feb 2025 00:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740386392; x=1740991192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/zcMpskijGYRuDfk1c7h2QKxlF14yge6iyoocOzfaI=;
        b=BSVJjGNdP/IupYYxgOFMJD7+2XZxySbBjyjWyWXywe0B0bQqxPT8929xSXDwhhATah
         UeHXzgch0+6p5ChhmjwSduZAd/vEStvocND/ANAcNVEGIRLJkXDoyWtTHVCPKuV0okw2
         w8cm7c1b6iZZMy7TLbIVVEtDI+B7ZUJJ5LI570I0A2WVitZcyFgEckH8csuh4fR3PaJW
         G2qvoRI298pPj6pPKRagusKD8IXLGPqZuSjxqB0HjmWlJ91BH6SoVcow9bPNTnCwvFNF
         19OrVsVwzaj2G+Brl0MpWJotxs5qmyWqTwZdY/a2xrjblKlU0XvEyyF0FDcN8LSm7GsX
         QxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740386392; x=1740991192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/zcMpskijGYRuDfk1c7h2QKxlF14yge6iyoocOzfaI=;
        b=lvLmLqNzuRKY0CjCtmGZ7IT6GKS6+/Hm9cq0sOmtlFPaV1qsyMdn5DiI77rUaavLYT
         SSZgrk2ZYYnOk/VjC6p/cwbGPI6GC6vLtnmTVFD9pJ8W+IZVm4zT8Bd7Xnz9inv6InLb
         nOPjLGLHme2BxJ9FG5bYF+ppXmslgFHcr4urjYaNtNKKxjnxh9yg/2laCZKLQ0qwyT4f
         Chlyczw5o1lg+AcMQN1r+bnGKNVSDxFl99TICGBrr8gF+rezfkl7RMoUWHRvTh/Lewwa
         H/yl0BzoUhLJrl3yOrVXdsDlUP/2o45IeihQNwONtBn5GxHARXCUZUq33g+hZP8op5zR
         u0Dw==
X-Forwarded-Encrypted: i=1; AJvYcCV9BmTvNagubwYMdwrn213VzBjPmydIlDUW66DF1zV+VV+ZM3A/9C25I7Ib07bE30LuLEBrepTgTv6w@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvejkbx4DFcm8VOEH+cQPS+ZAmgAXl2QrWMNqadk8h8Uryur0p
	fbfNCUZTEocISs8/jUgAGQ9rRk1JHvz0r6EC20TcfAPj0iIvkKVk
X-Gm-Gg: ASbGnctJ7E6RYBZ6+jBH3Agp0gf+aReit8u688mMvmg9g/0CMQ4Ad7EKNG4DM+5NsUB
	G4DTQ55HmXA/H6wQNE8BV/2SBJd4IkM5BaVOsF72ghPVXoGyI2LVw6IOX7fyTtE9uDfl3Whde9k
	oqbVDAuRZ84xgTRoZi0pncXFhajQSAZ1cBU7ukFbZt8E7w9KKKVDjq0qF+eaHWZcDDEV+sSe8A1
	71LMG3FZDbhwxaygpDCt2ZMIQ/2oCZn4K8PyqK97dkKaiBBGLgEj672XipXwnzXjdDOKx8erc/a
	O60CWe7PmY0jrOL0h2zw+wsVPuPmZREeJnsh
X-Google-Smtp-Source: AGHT+IH0vF5JtrmGfyOiw3Uz/WiGXZ6m0VJD5EWTauPDEIQovZ+YQzc9KpIobnt648BkAXZ8UT2PeQ==
X-Received: by 2002:a05:6a21:3991:b0:1e0:cc01:43da with SMTP id adf61e73a8af0-1eef3b2586amr18631154637.0.1740386392571;
        Mon, 24 Feb 2025 00:39:52 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:cd02:bc36:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7327590ff12sm14634793b3a.115.2025.02.24.00.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:39:52 -0800 (PST)
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
Subject: [PATCH v4 3/5] i3c: master: svc: Fix npcm845 FIFO empty issue
Date: Mon, 24 Feb 2025 16:39:06 +0800
Message-Id: <20250224083908.1880383-4-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224083908.1880383-1-yschu@nuvoton.com>
References: <20250224083908.1880383-1-yschu@nuvoton.com>
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
 drivers/i3c/master/svc-i3c-master.c | 44 ++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 8834f87a4767..07506ae0f914 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -942,7 +942,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 					u8 *addrs, unsigned int *count)
 {
 	u64 prov_id[SVC_I3C_MAX_DEVS] = {}, nacking_prov_id = 0;
-	unsigned int dev_nb = 0, last_addr = 0;
+	unsigned int dev_nb = 0, last_addr = 0, dyn_addr;
 	u32 reg;
 	int ret, i;
 
@@ -985,6 +985,17 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 		if (SVC_I3C_MSTATUS_RXPEND(reg)) {
 			u8 data[6];
 
+			/*
+			 * One slave sends its ID to request for address assignment,
+			 * pre-filling the dynamic address can reduce SCL clock stalls
+			 * and also fix the SVC_I3C_QUIRK_FIFO_EMPTY quirk.
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
@@ -1063,21 +1074,16 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
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
 
@@ -1225,8 +1231,8 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
 	return offset;
 }
 
-static int svc_i3c_master_write(struct svc_i3c_master *master,
-				const u8 *out, unsigned int len)
+static int svc_i3c_master_write(struct svc_i3c_master *master, const u8 *out,
+				unsigned int len, bool last)
 {
 	int offset = 0, ret;
 	u32 mdctrl;
@@ -1243,7 +1249,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 		 * The last byte to be sent over the bus must either have the
 		 * "end" bit set or be written in MWDATABE.
 		 */
-		if (likely(offset < (len - 1)))
+		if (likely(offset < (len - 1)) || !last)
 			writel(out[offset++], master->regs + SVC_I3C_MWDATAB);
 		else
 			writel(out[offset++], master->regs + SVC_I3C_MWDATABE);
@@ -1274,6 +1280,17 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
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
@@ -1335,7 +1352,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
 	else
-		ret = svc_i3c_master_write(master, out, xfer_len);
+		ret = svc_i3c_master_write(master, out, xfer_len, true);
 	if (ret < 0)
 		goto emit_stop;
 
@@ -1362,6 +1379,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 emit_stop:
 	svc_i3c_master_emit_stop(master);
 	svc_i3c_master_clear_merrwarn(master);
+	svc_i3c_master_flush_fifo(master);
 
 	return ret;
 }
-- 
2.34.1



Return-Path: <linux-kernel+bounces-523014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EF5A3D100
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862A83BE821
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34291E5B7A;
	Thu, 20 Feb 2025 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i20GQhFl"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9591E572A;
	Thu, 20 Feb 2025 05:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740030232; cv=none; b=JwLcME1ndgQP6nrTw1IjgYgYGgKgoN/1YePHwMKoSr8V6Vhskzt0SSxKQtst5Byb8cNl7+IdxwGx+niFLrmjP0ik9yVgabH7/349zQjL/YSqDY2LZT0JDOUCDMgAFQ5UH+S2oBB1FxeqUwnT+RDLdzja8ZAcMSflvEh2GD/MVxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740030232; c=relaxed/simple;
	bh=Gxgd/HB07V6amielBN0Bv7UZ7D0SVoo3tIPVAPikVhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JopZgLgq0WHfWenwUmjI3BZzN2vQdpYTiUfjOu78uyQWN4qt57zYvMwkWV4x9ULFZLLcrtruHPkJZuLeFpxJIQ744aeA3UpX+kkmE3ZuP9VlhRF9gbJN5/x53xtGQT6fwuDLzG6Cy17nOZT2o/3BMAHWUtKt2dGzVM/WehTRpTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i20GQhFl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220ecbdb4c2so12988535ad.3;
        Wed, 19 Feb 2025 21:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740030230; x=1740635030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+uWDhaMgi+jxwkqAdo/eMNwsqE8P1kcmn3GiPEcAYA=;
        b=i20GQhFli2CPAjUJRFZI1eSngSfjTlDa963+UAhBWzf1bEVzqf91B304gcaiCT4t9s
         KTjSTaFS2O0SVI+mCCQJ4jT43IpCcb44FU6DAqLcjDwaxAdeJJ38an/PHwBYWAVHxHEw
         gb1wm1ahr8ERTfHna2h3Yi+/vvp00/dOcAHVnlj0DyGW6JlM0JCKTn6auxUCVWpGJW9E
         QoL7WAqQyR0XoAGW2Cf8wEHvktjknnWkMwRqhjGESQsPlIiWyj0D2vVrltXpn2FHOHnn
         jnlYNLTMzuBImzZL6W5ATTMfl4hWhP12THc3rrqMM8v6X0dddhU19tk+N8xvENCGbawl
         N0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740030230; x=1740635030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+uWDhaMgi+jxwkqAdo/eMNwsqE8P1kcmn3GiPEcAYA=;
        b=bz8ev8/6LXQk5y1pdTvd+7punguHXk6fcqZYyr+pkEvxXiVoOioF1ChSvQJMITGoA0
         Sb3l1G2ANqVaOwHeTWq2oTCEkaWIgTEMbKVpj0t2GEimNkkzdaO1rverlCTCMJnG3V0Y
         w8MTCYELg9ir0Ibdtq1yqain8+3bTeS6ES/bmiWWhucqAP+SUYQymHz4oOljI08wG1DS
         WTTx+ka3a9sTcpNZjlqBF1JLPujoSRbgbtjYPktbiAkTTJEp5sQCcE3OHtpNdzSu4HYx
         SLrtrDoo89qLV0jhp1E9Mc4GftkTGl/78r0gVbVROp741WDXeJQY6W29z+l+028ZmW3U
         mTwg==
X-Forwarded-Encrypted: i=1; AJvYcCX+ascvU/E2CW+F8udTSnjs8NsTWwPxh4oyFlOEW0SpWnw5t+dUQHR9YlP2wM5JSWVL6+f/RdJEmMi4@vger.kernel.org
X-Gm-Message-State: AOJu0YySbNcxKxgm1Jgk8iRcm1NhSpbLo6EmIBFOq7jTP6wNG3upNgZq
	TImctpLOqODoQRqcd6VtwMExWjirj8SGc4iB+1t9ADTM/P8JkCJl
X-Gm-Gg: ASbGncuHpe7qaH5SoIzHnZq0cF9QNU4dbBsOT7k4ZfW/At11xb3fwJX4D9/2dzL7zr9
	03X0Cfe/mvOhg9KGHGamZdsufNIBdTgYSi12wYZ4lTbmeoKNqsS/26XKLqCDHFkjLzXOZ/z4U/V
	2BYZMOUMmvwqVG9Jrgw+Dz6tVKMUMjU8SrkQvwwOVr/CUYa5ZVmjB/hhYO47nF/dGkVLUlto69r
	bDVe6JwGE+Cq+BF1ud2UFyrGh8zTMWKCptaAuhc2dQAwsi8IDnotACrDq8PNrT0VWw0MeRuzyH3
	0vsoZsxag3oxCeNhufdNpDRjBw==
X-Google-Smtp-Source: AGHT+IGGhLQt8RYHyL3O5/X/szpd7Iw5l6Qfx7Qwl68H9aQX/UAag77wmnRGfcRwgAJCMHxr4lD11w==
X-Received: by 2002:a17:902:ce0d:b0:215:a179:14ca with SMTP id d9443c01a7336-22103ef5861mr324352105ad.2.1740030229980;
        Wed, 19 Feb 2025 21:43:49 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534951fsm114415335ad.25.2025.02.19.21.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 21:43:49 -0800 (PST)
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
Subject: [PATCH v2 3/4] i3c: master: svc: Fix npcm845 FIFO empty issue
Date: Thu, 20 Feb 2025 13:43:29 +0800
Message-Id: <20250220054330.1711979-4-yschu@nuvoton.com>
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

I3C HW stalls the write transfer if the transmit FIFO becomes empty,
when new data is written to FIFO, I3C HW resumes the transfer but the
first transmitted data bit may have the wrong value.
Fill the FIFO in advance to prevent FIFO from becoming empty.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index c58440061d5a..2140da3f5187 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1196,8 +1196,8 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
 	return offset;
 }
 
-static int svc_i3c_master_write(struct svc_i3c_master *master,
-				const u8 *out, unsigned int len)
+static int svc_i3c_master_write(struct svc_i3c_master *master, const u8 *out,
+				unsigned int len, bool last)
 {
 	int offset = 0, ret;
 	u32 mdctrl;
@@ -1214,7 +1214,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 		 * The last byte to be sent over the bus must either have the
 		 * "end" bit set or be written in MWDATABE.
 		 */
-		if (likely(offset < (len - 1)))
+		if (likely(offset < (len - 1)) || !last)
 			writel(out[offset++], master->regs + SVC_I3C_MWDATAB);
 		else
 			writel(out[offset++], master->regs + SVC_I3C_MWDATABE);
@@ -1245,6 +1245,19 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		       SVC_I3C_MCTRL_RDTERM(*actual_len),
 		       master->regs + SVC_I3C_MCTRL);
 
+		if ((master->quirks & SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len) {
+			unsigned int len = xfer_len;
+
+			if (xfer_len > SVC_I3C_FIFO_SIZE)
+				len = SVC_I3C_FIFO_SIZE;
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
@@ -1306,7 +1319,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
 	else
-		ret = svc_i3c_master_write(master, out, xfer_len);
+		ret = svc_i3c_master_write(master, out, xfer_len, true);
 	if (ret < 0)
 		goto emit_stop;
 
@@ -1333,6 +1346,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 emit_stop:
 	svc_i3c_master_emit_stop(master);
 	svc_i3c_master_clear_merrwarn(master);
+	svc_i3c_master_flush_fifo(master);
 
 	return ret;
 }
-- 
2.34.1



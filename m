Return-Path: <linux-kernel+bounces-418789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564E89D65AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1801428223C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2621D7E35;
	Fri, 22 Nov 2024 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fxsO3iOR"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA531D12E0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313824; cv=none; b=bTblXChpFL2cnYngoEXXBHj5JJE+GxSMQ/OjdMw8SDLqiS7M8eQeiz7ZAlIMpHAkwT15ziR3HkcwFBzgK9l8fbuYYwnI9RUv49nRuhCt6AjSvo/jo3KzK6+ERWfsJ+ae0c9lKVAjdnweLwowHjAUa67+nEi6Jw9avM2WioQmix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313824; c=relaxed/simple;
	bh=I2LtvohaVFJmgdnLxw93thch89TSJ/pRe33LDaC2gmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWe9BGzivH3+VidAlsAaMi5FB/Awfev3WR1Ojg0O3yt7Rp1dDgAJQTdIkypLF4XX/XQg5Xe+1wqJ73okx7MmLOsA6oHmmU5XCl7jZiU5OM3qhB73i4zEOd0WGbjMahbEpbq2hwnsS6tjMuVL4fesSTq/MK2xgS0i6ZwJ8cjsvO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=fxsO3iOR; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38245e072e8so2372046f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313821; x=1732918621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX04a1ntmZvpkxNuR7+A/BvpYp1w7zMI7wCHavx9c7Q=;
        b=fxsO3iORFwTSuc0vg+4QpPtILlQUy9fcDrwugccJJMnKvPMIMnc/yHh2vOV4ZlUJSB
         JSNHdos7Yk1Vm1VWz/RWhu3vLBx28j+coLfiADuk8HT/I5GJPXQAed4EnMgmHDcRQPry
         45Bxy1jYXqkPg/uvdex+trRlaOvfkqsJJdbaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313821; x=1732918621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RX04a1ntmZvpkxNuR7+A/BvpYp1w7zMI7wCHavx9c7Q=;
        b=GqTjx0mydI5j7VpY1J4Ebf8ZzuhpNE1/vs2WbicaREiKjjDUg50Qrmsww+JtrUOoGD
         9dqMwz1884mk1e1Ljf7Ih4ZU3+cCLiNwCf/Mm5bTppY2ruHt4oPBcApfJD1yss8CZexa
         HaDqbH461WfGrCIjRXVggQb4K8pdD3Jcj91r/Wh9gwLN71jzLkjcNy7/1tEIbu4lmkdv
         o2LLXALiMyy5Gvav9LPSXrPgpdpZf/KmfZqvcUiHc0aGjumwNKehsmtdzefoOOIMM8J0
         3i7fSeDRK1u5/d4mjHyCb4ixsUQsFPiJHsw4mVYvPBb9bPYsusuYx/gIHnMnz0XqjWYK
         EIEQ==
X-Gm-Message-State: AOJu0YxKilSraRH2TbHNS1p/P8xK7HdeJ3TffwHkoEEFFGfY+Rj5q0as
	gT0Tvv9idK3BzxyTiCYqEsaxkgjejR5m/uqtYh7FsTnVfm9s3tabqKwoQiUO2zPA0eC/znFPml1
	/
X-Gm-Gg: ASbGncvsoUdvoAzcYtaG/x2hSc5v6FBVE4xFUVO5ya/oA9w7atvlksoVudIufvJ1GdA
	OMJAbUHLKyLuY3dI5ry8PVSBVseQwCAjlFHKUW2OaDXdIWk7G4cV9cW+kMx42JgyK6gXTQP4FXq
	n6dE0/TaxVWxq0ifFGl/rkK21TdAOKRlviGgGhC09Y7dshkq4RfXlGQqjiZQ64We6CAzL7/wp6w
	ApSohMuKzgkS2TvSOCp0CZzV6FGsSO+4aaFK/8EH7alHyanYVoxpiqDqkUJbbggndybr2FVW1CX
	pdv9Tb2ASEjtyPYbL29gslk5wkgOxPiqU2GcyHSuaHoym3W3c2PEI9H43Nj4w1eDVydpgaojexG
	Gf59EcsRG5RhUU5vd
X-Google-Smtp-Source: AGHT+IHAxj0+27hbn5+PS2X0z9RbUmW0ALk+EbhHU9lNW6NXCe6XpBxQu2KoM64ItRHZ2zhJK1K97A==
X-Received: by 2002:a05:6000:1788:b0:382:51d7:a2e0 with SMTP id ffacd0b85a97d-38260b61f45mr4102854f8f.27.1732313821142;
        Fri, 22 Nov 2024 14:17:01 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:17:00 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Dong Aisheng <b29396@freescale.com>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Varka Bhadram <varkabhadram@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [PATCH v2 06/12] can: m_can: fix {rx,tx}_errors statistics
Date: Fri, 22 Nov 2024 23:15:47 +0100
Message-ID: <20241122221650.633981-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
References: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The m_can_handle_lec_err() function was incorrectly incrementing only the
receive error counter, even in cases of bit or acknowledgment errors that
occur during transmission. The patch fixes the issue by incrementing the
appropriate counter based on the type of error.

Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Update statistics even if skb allocation fails

 drivers/net/can/m_can/m_can.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16e9e7d7527d..533bcb77c9f9 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -695,47 +695,60 @@ static int m_can_handle_lec_err(struct net_device *dev,
 	u32 timestamp = 0;
 
 	cdev->can.can_stats.bus_error++;
-	stats->rx_errors++;
 
 	/* propagate the error condition to the CAN stack */
 	skb = alloc_can_err_skb(dev, &cf);
-	if (unlikely(!skb))
-		return 0;
 
 	/* check for 'last error code' which tells us the
 	 * type of the last error to occur on the CAN bus
 	 */
-	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+	if (likely(skb))
+		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
 	switch (lec_type) {
 	case LEC_STUFF_ERROR:
 		netdev_dbg(dev, "stuff error\n");
-		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		stats->rx_errors++;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_STUFF;
 		break;
 	case LEC_FORM_ERROR:
 		netdev_dbg(dev, "form error\n");
-		cf->data[2] |= CAN_ERR_PROT_FORM;
+		stats->rx_errors++;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_FORM;
 		break;
 	case LEC_ACK_ERROR:
 		netdev_dbg(dev, "ack error\n");
-		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		stats->tx_errors++;
+		if (likely(skb))
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
 		break;
 	case LEC_BIT1_ERROR:
 		netdev_dbg(dev, "bit1 error\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT1;
+		stats->tx_errors++;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_BIT1;
 		break;
 	case LEC_BIT0_ERROR:
 		netdev_dbg(dev, "bit0 error\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT0;
+		stats->tx_errors++;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_BIT0;
 		break;
 	case LEC_CRC_ERROR:
 		netdev_dbg(dev, "CRC error\n");
-		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		stats->rx_errors++;
+		if (likely(skb))
+			cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 		break;
 	default:
 		break;
 	}
 
+	if (unlikely(!skb))
+		return 0;
+
 	if (cdev->is_peripheral)
 		timestamp = m_can_get_timestamp(cdev);
 
-- 
2.43.0



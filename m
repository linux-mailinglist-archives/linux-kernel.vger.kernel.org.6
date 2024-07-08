Return-Path: <linux-kernel+bounces-243880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A643929C19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD6D1C21471
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B80214A8F;
	Mon,  8 Jul 2024 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GchawBzH"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873B1B948
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419683; cv=none; b=jReVQnzKFKrXgygCZcSWPpiBXw0RBbDkoUYDxqBqv6Wljr66JMP1LUeUEVOBKv/chxnE1SHpDTbN3WS6HA2doxhkMCEAG1PUy7CkF5EW2y5YrxVVVU3fhkhoFZN5dFQdBKlf49D0WNk8tn7Kz1Wg/mRRO//gyYRT3q+iXy9MB/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419683; c=relaxed/simple;
	bh=YDdwcRd3fvi/CAivQXaj/gHAI3ri/cGFe1SFviBHhGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CbArAziJqDAhtISkS3l+K+wKCaF7SrmhjRjQJnPLtI+dPP4zr1dWS2R1PCTpxAOGeeSq/u5gFFBVR9Jb3s/38ozyldEO3xTInim5c+a1KSL/eSFq2uIzm5hSHnnwXiYB+oSQQIDXDRg59loIdTFzKT9TTT95YliquTQA5cOr9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GchawBzH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e032d4cf26aso6963047276.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 23:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720419681; x=1721024481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRE3CTl41ox4KiTMo7IKJflgnlE4+zxOG9BgLIy76LA=;
        b=GchawBzHfHmxl4deNum8LI1c0bXxdJqzHP5BaErFpFkK/kZKJrmLdmB+WpGNCXFCt+
         qPjdYcm0oD0zfUza+UbY6Niaeb9KHFvIs0M5e9OKPtEG9R43yQ8tFQQAZpziufdb4wA4
         mRY3NvPJhvVqUe2Dc2YhUMleCf98ZSVHyUfxDapuq8J374A58iLEcy2T8lwv7YRRT1sP
         15MBl5wO8LEMQluJAE5+DmnlRS2H25FR6BnDt6a4UbT88c4DVBO7ADa9P7pb+Dzcdh38
         syMojDvI+XbimExUcOgzCM+PZutfQPtE2JTfhtL7uul/8FLHynYyx7meklVmWnLzXF54
         Ajbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720419681; x=1721024481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JRE3CTl41ox4KiTMo7IKJflgnlE4+zxOG9BgLIy76LA=;
        b=ujGe6DacK26zuRmHbdsmza8M810Hq4owD+K/pD4X+xPz7uvJXzQeGd1dA+Jm1Ceu9q
         XtG/s9XVPGlNj0nNKT7cuJnlh+oQy69zJTzWv8TLmPYU0XmcBRO6VIL4a7JszzL5Vz2q
         M7onnN601WjzkNQ7LQdemqAkPIJdU5NaDzXh+pbakKYwEnjCg657Uyzja1CpLzZdiSua
         UGgXWAxMjHn/6O2WfJfIzxV0XQOOUwD4laEoIJTK91eIA9E+uSiM60TOIGYqcJQG73fD
         gWhcxFH5Uj9mCne+KhKUd8U0Hn2U/wA030unk88kApYY+0a9LsvlYSpwgs4F2n5elO5U
         fsEg==
X-Forwarded-Encrypted: i=1; AJvYcCVX3bGTM2j+J29wvEN0trvOXuSCwA5k+MJEvKVeGzR3HT78zMfZt3ns+cC/CJI9aDWJbBCde+l3uqgxA/hr4fOKvk8ndPL/SlLfS3A7
X-Gm-Message-State: AOJu0Yxu5CmnCp6i5g2SUhghCX1mqgCWfmFyRWfP3+jHnfp1aN/Xg1Ks
	y5IsUk184fnUNH2sjHNW3Cl6pT5Mk3bjloR+gCAI0+TO5Hc2By0cREcsfreCkVqAHcAxnjFIsOI
	eBq2yvKoNj1FSDl7DRfzatCg2Ug==
X-Google-Smtp-Source: AGHT+IHlkJtcNN0OXfJII+G6EXZjRqg/GVIaRc00MqzWRa6cfLCMbK9U0UrS9QmCLqwe7QweYJbtQDhrxI5xAgMfXpA=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a25:53c9:0:b0:e03:b5d0:2aa2 with SMTP
 id 3f1490d57ef6-e03c1bf24b8mr307204276.13.1720419681282; Sun, 07 Jul 2024
 23:21:21 -0700 (PDT)
Date: Mon,  8 Jul 2024 06:21:02 +0000
In-Reply-To: <20240708062103.3296587-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240708062103.3296587-1-aniketmaurya@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240708062103.3296587-3-aniketmaurya@google.com>
Subject: [PATCH 2/3] i3c: dw: Add some functions for reusability
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	vamshigajjela@google.com, Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

Separate logic for setting intr/thld registers in a func.
Also modify enable function to take care of setting all fields in DEVICE_CTRL.
These functions can be reused later for power management.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 drivers/i3c/master/dw-i3c-master.c | 62 +++++++++++++++++-------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index fcfa37f55d86..fadb58ac8b68 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -300,7 +300,14 @@ static void dw_i3c_master_disable(struct dw_i3c_master *master)
 
 static void dw_i3c_master_enable(struct dw_i3c_master *master)
 {
-	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_ENABLE,
+	u32 dev_ctrl;
+
+	dev_ctrl = readl(master->regs + DEVICE_CTRL);
+	/* For now don't support Hot-Join */
+	dev_ctrl |= DEV_CTRL_HOT_JOIN_NACK;
+	if (master->i2c_slv_prsnt)
+		dev_ctrl |= DEV_CTRL_I2C_SLAVE_PRESENT;
+	writel(dev_ctrl | DEV_CTRL_ENABLE,
 	       master->regs + DEVICE_CTRL);
 }
 
@@ -521,6 +528,32 @@ static void dw_i3c_master_end_xfer_locked(struct dw_i3c_master *master, u32 isr)
 	dw_i3c_master_start_xfer_locked(master);
 }
 
+static void dw_i3c_master_set_intr_regs(struct dw_i3c_master *master)
+{
+	u32 thld_ctrl;
+
+	thld_ctrl = readl(master->regs + QUEUE_THLD_CTRL);
+	thld_ctrl &= ~(QUEUE_THLD_CTRL_RESP_BUF_MASK |
+		       QUEUE_THLD_CTRL_IBI_STAT_MASK |
+		       QUEUE_THLD_CTRL_IBI_DATA_MASK);
+	thld_ctrl |= QUEUE_THLD_CTRL_IBI_STAT(1) |
+		QUEUE_THLD_CTRL_IBI_DATA(31);
+	writel(thld_ctrl, master->regs + QUEUE_THLD_CTRL);
+
+	thld_ctrl = readl(master->regs + DATA_BUFFER_THLD_CTRL);
+	thld_ctrl &= ~DATA_BUFFER_THLD_CTRL_RX_BUF;
+	writel(thld_ctrl, master->regs + DATA_BUFFER_THLD_CTRL);
+
+	writel(INTR_ALL, master->regs + INTR_STATUS);
+	writel(INTR_MASTER_MASK, master->regs + INTR_STATUS_EN);
+	writel(INTR_MASTER_MASK, master->regs + INTR_SIGNAL_EN);
+
+	master->sir_rej_mask = IBI_REQ_REJECT_ALL;
+	writel(master->sir_rej_mask, master->regs + IBI_SIR_REQ_REJECT);
+
+	writel(IBI_REQ_REJECT_ALL, master->regs + IBI_MR_REQ_REJECT);
+}
+
 static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 {
 	unsigned long core_rate, core_period;
@@ -615,7 +648,6 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
 	struct i3c_bus *bus = i3c_master_get_bus(m);
 	struct i3c_device_info info = { };
-	u32 thld_ctrl;
 	int ret;
 
 	ret = master->platform_ops->init(master);
@@ -638,22 +670,6 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 		return -EINVAL;
 	}
 
-	thld_ctrl = readl(master->regs + QUEUE_THLD_CTRL);
-	thld_ctrl &= ~(QUEUE_THLD_CTRL_RESP_BUF_MASK |
-		       QUEUE_THLD_CTRL_IBI_STAT_MASK |
-		       QUEUE_THLD_CTRL_IBI_DATA_MASK);
-	thld_ctrl |= QUEUE_THLD_CTRL_IBI_STAT(1) |
-		QUEUE_THLD_CTRL_IBI_DATA(31);
-	writel(thld_ctrl, master->regs + QUEUE_THLD_CTRL);
-
-	thld_ctrl = readl(master->regs + DATA_BUFFER_THLD_CTRL);
-	thld_ctrl &= ~DATA_BUFFER_THLD_CTRL_RX_BUF;
-	writel(thld_ctrl, master->regs + DATA_BUFFER_THLD_CTRL);
-
-	writel(INTR_ALL, master->regs + INTR_STATUS);
-	writel(INTR_MASTER_MASK, master->regs + INTR_STATUS_EN);
-	writel(INTR_MASTER_MASK, master->regs + INTR_SIGNAL_EN);
-
 	ret = i3c_master_get_free_addr(m, 0);
 	if (ret < 0)
 		return ret;
@@ -668,15 +684,7 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	if (ret)
 		return ret;
 
-	master->sir_rej_mask = IBI_REQ_REJECT_ALL;
-	writel(master->sir_rej_mask, master->regs + IBI_SIR_REQ_REJECT);
-
-	writel(IBI_REQ_REJECT_ALL, master->regs + IBI_MR_REQ_REJECT);
-
-	/* For now don't support Hot-Join */
-	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_HOT_JOIN_NACK,
-	       master->regs + DEVICE_CTRL);
-
+	dw_i3c_master_set_intr_regs(master);
 	dw_i3c_master_enable(master);
 
 	return 0;
-- 
2.45.2.803.g4e1b14247a-goog



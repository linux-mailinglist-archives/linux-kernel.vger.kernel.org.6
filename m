Return-Path: <linux-kernel+bounces-243881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0A7929C1A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603431F21AFC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62E7171A5;
	Mon,  8 Jul 2024 06:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnR+Uo/e"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE531CD00
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419688; cv=none; b=ZjFquKq/KUE4bSlrgqni6EmKMifMfS7A5nNbfSbATbLBv/44mV0b067IU6i8UEeBAKdCEl7eA4lPzrAaClNwLOLTC/Qe4sWw6159sa/xfBBLHPStIK/UoV/jibtov5jrB36NL6VH9pZU3TFdh8ELsQS9WN+vvP9x2IMmRPxQdlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419688; c=relaxed/simple;
	bh=3lC8IBX1ut2owKTUXyZbEOhLhGw97CDVrOYC1Ub08bw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WU8W+rdah+1fGAyY6KRwpsxjRAZ+riS2uEApf2PpKc4uXUUskt4oYaTNdYCWhbkiZ7tUFQ8ufihFYnVs114feOYHkH0W451NNqyxLpECV2Ea7NSzo3CFo3iAwGjtu8h7Zz2trFtYkZNXySwXnZDN2OZaGof5nJt32yxKvrQps34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnR+Uo/e; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa73db88dcso6620351276.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 23:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720419686; x=1721024486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BB+cdXL3sSGy9Qxqc/xCUd9m5f97Vr6+9inOlt8r8ns=;
        b=mnR+Uo/ew7G7Ph7aXW8iXZVoEenfF+TD20CCwsY/7nJBwyoCdGmn7aFPWIPqHEhsw9
         I9YBpcA4MlAutQBWk8F6tYFz9qC91qTH02Qr2WuZz0yslgs8iiZ8QGqKmJahsxT6WKVb
         gKbPWhaDqELGN6ZVoITW+/6/O0Jvn5fv0qBHElRL8UAvBBq9rLUwyxJQhSCtyJzN93So
         6W947V3jnfeWCVcKL0uis4wz/JoJPZnxHxWKUrKN9uBUX1FZagi5f27R0k+7mggPqtCR
         PCFZxY8XeBFqLymnBTQKx7LyXhvoa6XZM6tdLz4SkRS8wQXgfJfHvyNh+NjNljsgci2n
         naTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720419686; x=1721024486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BB+cdXL3sSGy9Qxqc/xCUd9m5f97Vr6+9inOlt8r8ns=;
        b=UjUOU2diGiFa4FSN5tCB6ki536rBy/G1bSh0y0jSVEMsFHBnCYJ2onCGv/ZjPIcUkA
         pT2nWEVAs0q7uP+4rHodsH+W0Kkj9YU2SA+Nq0GpJ5MdFJcEsKQw6L2SM3DLPLu3CQwT
         3QGyRE1o8Hu96QVbOAHay74HYOZOisUVfwtsXWp3v1bUA89m/gsPHzK2BWKVaRKk0K2z
         BbCKFZ7PLihLyGvhzEj7WrWZpvbj3tHG/g4v5+8rjPAy+tYp2dVoq6mi6QhmOGdjspBZ
         m67p0024IuPsarhUIbJIjlQiH21kn7g5uPxwZI0Z69MRjyyF6FtJbhtTDBe2O460Gy1X
         7BnA==
X-Forwarded-Encrypted: i=1; AJvYcCXBKOfHqVMX+zi/GlwodFE6wZOpTM2cwPXoBW8NZL9yWSokjFxdY4Xll5k6lVaKQF3KEBu1nwpcUbBL317LmtjQt9GwuSBCz3RXb2Fz
X-Gm-Message-State: AOJu0Yx0yBnM7ooneYwKHtyZ3VY0mKUA74PwD8pSkVGz4M1eajTgCK7h
	9SAB695gMhMK5fgjyJZehrNfXuqxDs7MANBbekXWfXfx5BaYT/NqMR70yu1KigIsJU4TunbJ4ph
	zs3QitDpAWffshDLCflbH7fiD6w==
X-Google-Smtp-Source: AGHT+IGI+Y5RmB7MP/77m+CCpLnc7H12EsxH/k+T3+lVUmWTxfbGgLYw+uW29XFJU7udaD7+0BhiH8dbZLmljtJX6kM=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a05:6902:18ca:b0:e02:b093:dc1f with
 SMTP id 3f1490d57ef6-e03c19598d4mr30530276.1.1720419685909; Sun, 07 Jul 2024
 23:21:25 -0700 (PDT)
Date: Mon,  8 Jul 2024 06:21:03 +0000
In-Reply-To: <20240708062103.3296587-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240708062103.3296587-1-aniketmaurya@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240708062103.3296587-4-aniketmaurya@google.com>
Subject: [PATCH 3/3] i3c: dw: Add power management support
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	vamshigajjela@google.com, Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for runtime and system power management.
Handle clocks, resets, pads as part of suspend and resume.
Restore controller registers that could be lost due to suspend.
Finally add get and put calls appropriately in functions which
access controller : bus_init, do_daa, send_ccc_cmd, priv_xfers,
i2c_xfers, ibi and hot-join.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 drivers/i3c/master/dw-i3c-master.c | 225 ++++++++++++++++++++++++++---
 drivers/i3c/master/dw-i3c-master.h |   1 +
 2 files changed, 209 insertions(+), 17 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index fadb58ac8b68..8d694672c110 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -17,7 +17,9 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 
@@ -217,7 +219,7 @@
 #define I3C_BUS_THIGH_MAX_NS		41
 
 #define XFER_TIMEOUT (msecs_to_jiffies(1000))
-
+#define RPM_AUTOSUSPEND_TIMEOUT 1000 /* ms */
 struct dw_i3c_cmd {
 	u32 cmd_lo;
 	u32 cmd_hi;
@@ -650,29 +652,38 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	struct i3c_device_info info = { };
 	int ret;
 
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev,
+			"<%s> cannot resume i3c bus master, err: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
 	ret = master->platform_ops->init(master);
 	if (ret)
-		return ret;
+		goto rpm_out;
 
 	switch (bus->mode) {
 	case I3C_BUS_MODE_MIXED_FAST:
 	case I3C_BUS_MODE_MIXED_LIMITED:
 		ret = dw_i2c_clk_cfg(master);
 		if (ret)
-			return ret;
+			goto rpm_out;
 		fallthrough;
 	case I3C_BUS_MODE_PURE:
 		ret = dw_i3c_clk_cfg(master);
 		if (ret)
-			return ret;
+			goto rpm_out;
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		goto rpm_out;
 	}
 
 	ret = i3c_master_get_free_addr(m, 0);
 	if (ret < 0)
-		return ret;
+		goto rpm_out;
 
 	writel(DEV_ADDR_DYNAMIC_ADDR_VALID | DEV_ADDR_DYNAMIC(ret),
 	       master->regs + DEVICE_ADDR);
@@ -682,12 +693,15 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 
 	ret = i3c_master_set_info(&master->base, &info);
 	if (ret)
-		return ret;
+		goto rpm_out;
 
 	dw_i3c_master_set_intr_regs(master);
 	dw_i3c_master_enable(master);
 
-	return 0;
+rpm_out:
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+	return ret;
 }
 
 static void dw_i3c_master_bus_cleanup(struct i3c_master_controller *m)
@@ -789,11 +803,21 @@ static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 	if (ccc->id == I3C_CCC_ENTDAA)
 		return -EINVAL;
 
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev,
+			"<%s> cannot resume i3c bus master, err: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
 	if (ccc->rnw)
 		ret = dw_i3c_ccc_get(master, ccc);
 	else
 		ret = dw_i3c_ccc_set(master, ccc);
 
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -806,6 +830,14 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	u8 p, last_addr = 0;
 	int ret, pos;
 
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev,
+			"<%s> cannot resume i3c bus master, err: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
 	olddevs = ~(master->free_pos);
 
 	/* Prepare DAT before launching DAA. */
@@ -814,8 +846,10 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 			continue;
 
 		ret = i3c_master_get_free_addr(m, last_addr + 1);
-		if (ret < 0)
-			return -ENOSPC;
+		if (ret < 0) {
+			ret = -ENOSPC;
+			goto rpm_out;
+		}
 
 		master->devs[pos].addr = ret;
 		p = even_parity(ret);
@@ -825,16 +859,21 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 		writel(DEV_ADDR_TABLE_DYNAMIC_ADDR(ret),
 		       master->regs +
 		       DEV_ADDR_TABLE_LOC(master->datstartaddr, pos));
+
+		ret = 0;
 	}
 
 	xfer = dw_i3c_master_alloc_xfer(master, 1);
-	if (!xfer)
-		return -ENOMEM;
+	if (!xfer) {
+		ret = -ENOMEM;
+		goto rpm_out;
+	}
 
 	pos = dw_i3c_master_get_free_pos(master);
 	if (pos < 0) {
 		dw_i3c_master_free_xfer(xfer);
-		return pos;
+		ret = pos;
+		goto rpm_out;
 	}
 	cmd = &xfer->cmds[0];
 	cmd->cmd_hi = 0x1;
@@ -859,7 +898,10 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 
 	dw_i3c_master_free_xfer(xfer);
 
-	return 0;
+rpm_out:
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
+	return ret;
 }
 
 static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
@@ -894,6 +936,14 @@ static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	if (!xfer)
 		return -ENOMEM;
 
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev,
+			"<%s> cannot resume i3c bus master, err: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
 	for (i = 0; i < i3c_nxfers; i++) {
 		struct dw_i3c_cmd *cmd = &xfer->cmds[i];
 
@@ -935,6 +985,8 @@ static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	ret = xfer->ret;
 	dw_i3c_master_free_xfer(xfer);
 
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -1045,6 +1097,14 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 	if (!xfer)
 		return -ENOMEM;
 
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev,
+			"<%s> cannot resume i3c bus master, err: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
 	for (i = 0; i < i2c_nxfers; i++) {
 		struct dw_i3c_cmd *cmd = &xfer->cmds[i];
 
@@ -1075,6 +1135,8 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 	ret = xfer->ret;
 	dw_i3c_master_free_xfer(xfer);
 
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
 	return ret;
 }
 
@@ -1217,6 +1279,15 @@ static void dw_i3c_master_set_sir_enabled(struct dw_i3c_master *master,
 static int dw_i3c_master_enable_hotjoin(struct i3c_master_controller *m)
 {
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev,
+			"<%s> cannot resume i3c bus master, err: %d\n",
+			__func__, ret);
+		return ret;
+	}
 
 	dw_i3c_master_enable_sir_signal(master, true);
 	writel(readl(master->regs + DEVICE_CTRL) & ~DEV_CTRL_HOT_JOIN_NACK,
@@ -1232,6 +1303,8 @@ static int dw_i3c_master_disable_hotjoin(struct i3c_master_controller *m)
 	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_HOT_JOIN_NACK,
 	       master->regs + DEVICE_CTRL);
 
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
 	return 0;
 }
 
@@ -1242,12 +1315,23 @@ static int dw_i3c_master_enable_ibi(struct i3c_dev_desc *dev)
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
 	int rc;
 
+	rc = pm_runtime_resume_and_get(master->dev);
+	if (rc < 0) {
+		dev_err(master->dev,
+			"<%s> cannot resume i3c bus master, err: %d\n",
+			__func__, rc);
+		return rc;
+	}
+
 	dw_i3c_master_set_sir_enabled(master, dev, data->index, true);
 
 	rc = i3c_master_enec_locked(m, dev->info.dyn_addr, I3C_CCC_EVENT_SIR);
 
-	if (rc)
+	if (rc) {
 		dw_i3c_master_set_sir_enabled(master, dev, data->index, false);
+		pm_runtime_mark_last_busy(master->dev);
+		pm_runtime_put_autosuspend(master->dev);
+	}
 
 	return rc;
 }
@@ -1265,6 +1349,8 @@ static int dw_i3c_master_disable_ibi(struct i3c_dev_desc *dev)
 
 	dw_i3c_master_set_sir_enabled(master, dev, data->index, false);
 
+	pm_runtime_mark_last_busy(master->dev);
+	pm_runtime_put_autosuspend(master->dev);
 	return 0;
 }
 
@@ -1465,6 +1551,8 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	if (!master->platform_ops)
 		master->platform_ops = &dw_i3c_platform_ops_default;
 
+	master->dev = &pdev->dev;
+
 	master->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(master->regs))
 		return PTR_ERR(master->regs);
@@ -1497,6 +1585,11 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 
 	platform_set_drvdata(pdev, master);
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, RPM_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	/* Information regarding the FIFOs/QUEUEs depth */
 	ret = readl(master->regs + QUEUE_STATUS_LEVEL);
 	master->caps.cmdfifodepth = QUEUE_STATUS_LEVEL_CMD(ret);
@@ -1513,10 +1606,15 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	ret = i3c_master_register(&master->base, &pdev->dev,
 				  &dw_mipi_i3c_ops, false);
 	if (ret)
-		goto err_assert_rst;
+		goto err_disable_pm;
 
 	return 0;
 
+err_disable_pm:
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+
 err_assert_rst:
 	reset_control_assert(master->core_rst);
 
@@ -1528,7 +1626,9 @@ void dw_i3c_common_remove(struct dw_i3c_master *master)
 {
 	i3c_master_unregister(&master->base);
 
-	reset_control_assert(master->core_rst);
+	pm_runtime_disable(master->dev);
+	pm_runtime_set_suspended(master->dev);
+	pm_runtime_dont_use_autosuspend(master->dev);
 }
 EXPORT_SYMBOL_GPL(dw_i3c_common_remove);
 
@@ -1552,6 +1652,96 @@ static void dw_i3c_remove(struct platform_device *pdev)
 	dw_i3c_common_remove(master);
 }
 
+static void dw_i3c_master_restore_addrs(struct dw_i3c_master *master)
+{
+	u32 pos, reg_val;
+
+	writel(DEV_ADDR_DYNAMIC_ADDR_VALID | DEV_ADDR_DYNAMIC(master->dev_addr),
+	       master->regs + DEVICE_ADDR);
+
+	for (pos = 0; pos < master->maxdevs; pos++) {
+		if (master->free_pos & BIT(pos))
+			continue;
+
+		if (master->devs[pos].is_i2c_addr)
+			reg_val = DEV_ADDR_TABLE_LEGACY_I2C_DEV |
+			       DEV_ADDR_TABLE_STATIC_ADDR(master->devs[pos].addr);
+		else
+			reg_val = DEV_ADDR_TABLE_DYNAMIC_ADDR(master->devs[pos].addr);
+
+		writel(reg_val, master->regs + DEV_ADDR_TABLE_LOC(master->datstartaddr, pos));
+	}
+}
+
+static void dw_i3c_master_restore_timing_regs(struct dw_i3c_master *master)
+{
+	writel(master->i3c_pp_timing, master->regs + SCL_I3C_PP_TIMING);
+	writel(master->bus_free_timing, master->regs + BUS_FREE_TIMING);
+	writel(master->i3c_od_timing, master->regs + SCL_I3C_OD_TIMING);
+	writel(master->ext_lcnt_timing, master->regs + SCL_EXT_LCNT_TIMING);
+
+	if (master->i2c_slv_prsnt) {
+		writel(master->i2c_fmp_timing, master->regs + SCL_I2C_FMP_TIMING);
+		writel(master->i2c_fm_timing, master->regs + SCL_I2C_FM_TIMING);
+	}
+}
+
+static int dw_i3c_master_enable_clks(struct dw_i3c_master *master)
+{
+	int ret = 0;
+
+	ret = clk_prepare_enable(master->core_clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(master->pclk);
+	if (ret) {
+		clk_disable_unprepare(master->core_clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline void dw_i3c_master_disable_clks(struct dw_i3c_master *master)
+{
+	clk_disable_unprepare(master->pclk);
+	clk_disable_unprepare(master->core_clk);
+}
+
+static int __maybe_unused dw_i3c_master_runtime_suspend(struct device *dev)
+{
+	struct dw_i3c_master *master = dev_get_drvdata(dev);
+
+	dw_i3c_master_disable(master);
+
+	reset_control_assert(master->core_rst);
+	dw_i3c_master_disable_clks(master);
+	pinctrl_pm_select_sleep_state(dev);
+	return 0;
+}
+
+static int __maybe_unused dw_i3c_master_runtime_resume(struct device *dev)
+{
+	struct dw_i3c_master *master = dev_get_drvdata(dev);
+
+	pinctrl_pm_select_default_state(dev);
+	dw_i3c_master_enable_clks(master);
+	reset_control_deassert(master->core_rst);
+
+	dw_i3c_master_set_intr_regs(master);
+	dw_i3c_master_restore_timing_regs(master);
+	dw_i3c_master_restore_addrs(master);
+
+	dw_i3c_master_enable(master);
+	return 0;
+}
+
+static const struct dev_pm_ops dw_i3c_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(dw_i3c_master_runtime_suspend, dw_i3c_master_runtime_resume, NULL)
+};
+
 static const struct of_device_id dw_i3c_master_of_match[] = {
 	{ .compatible = "snps,dw-i3c-master-1.00a", },
 	{},
@@ -1564,6 +1754,7 @@ static struct platform_driver dw_i3c_driver = {
 	.driver = {
 		.name = "dw-i3c-master",
 		.of_match_table = dw_i3c_master_of_match,
+		.pm = &dw_i3c_pm_ops,
 	},
 };
 module_platform_driver(dw_i3c_driver);
diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
index f23e9d5aca86..219ff815d3a7 100644
--- a/drivers/i3c/master/dw-i3c-master.h
+++ b/drivers/i3c/master/dw-i3c-master.h
@@ -25,6 +25,7 @@ struct dw_i3c_dat_entry {
 
 struct dw_i3c_master {
 	struct i3c_master_controller base;
+	struct device *dev;
 	u16 maxdevs;
 	u16 datstartaddr;
 	u32 free_pos;
-- 
2.45.2.803.g4e1b14247a-goog



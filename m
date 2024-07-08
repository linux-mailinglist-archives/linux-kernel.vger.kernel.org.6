Return-Path: <linux-kernel+bounces-243879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3413D929C18
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D991F21AE3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DC618643;
	Mon,  8 Jul 2024 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+G5Y+Ha"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BED17C66
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419678; cv=none; b=SFF2gEKcE55cENFLU3t0OZPKJ/P0dOUaIGmDGbeOQzAYuQqzBpZt/Lr/vAVFu3E3uN0vF+KIkJ5wQTYqrMTAUYo2giuw8wkAlZpsl5aEw2hoqPKY0A/6EudHYSnQkETOYA6/NBNbUBCwZE7QziOBQ5e8c+C3YtwVSNNgMwn6Ars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419678; c=relaxed/simple;
	bh=dQ7NHtYtF6uL+Y/Gr/LXsMc+5eb5CNZYrkqWBRic5w8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MdbEIQUbq42rbgvrqinpVxzPDqLAfinpqh37sEh75zQlTBlgDuIPISp1+FmLr/GEkUtLfW9PCFxxcBflkz6J9T0jMcHpQuuxZUpgrFQHCPLDm0pivEbrpN+UUe+cnNMfSdjCvqgpVR4MwtrSDJrKHLCrWtnrS7CwylW6g9WC99Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+G5Y+Ha; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fb1c206242so18695185ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 23:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720419677; x=1721024477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBFBYt9OaLc4OX3uBfAr6G8BybiHmWegQe0q6D9D5b0=;
        b=S+G5Y+HacGwWj40SGkGOeKayZneXtDJTthOFxgW2tsqQoU/8mVP8vubGC/ifHtDVZq
         EXcbntiBmyoiefU9/YlnK27s+lLhUTdzAIK+RfoTkNyA3VaFOxEOM/PGI9Lphvxvh+qk
         h+o/tbUdHqoMih8ddad04cABMJxBnhodUgvcI/WsDo0Ys5jMkYS8Lt2Dq6edUWuKpvGl
         5dokQUlhk3phD+ajF5WyonBD6XqSbw+EFtkezJ/LsNfKlXzoANtSnt0F0bR0La8Ifyiu
         kMEX5VOUk+zvqW13KxVljvDV4Lj01zibBQ7jxxLS2VFD0i/9Ufn+vwXF7QsfYSZbTiJf
         Vjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720419677; x=1721024477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBFBYt9OaLc4OX3uBfAr6G8BybiHmWegQe0q6D9D5b0=;
        b=tKQzXVj6CMaCP19JLM02hXmB9GbfBgyZLHm71cNoYp1k78vR6TW+kwWS+a4wv+Lpez
         x5hGSId6l0z21qGUWBCjYpjbltvhLg3j0YY0dS2L6xcfRGSgIVeJTWRdo/jTnppmmoFO
         AnfNXrZ6SbCCVjEDsbRdhFt437Y4TD2C35vcZs2xAitBXiERUtDOI0eWcnHraON/RhrS
         5joZaTGOV/2L/g9YIZhQ81yx+YHfjViINJObv8HJWAx2SHXW8IOZMRkS9GhUZ9nNpDl/
         iNiulacCkWpz9QH47+dpF4xpt1nVEyJJK7xtmoQaXVUNwM/A5E1HZ48IuZIKt+zirC6j
         tyGw==
X-Forwarded-Encrypted: i=1; AJvYcCWczAVzeu8EDUdN2CHXD8vZF4I9CCLPbPGBeXIaCjgHsFvkHug/UWxooY5rtvWTnd+Zjrp1XRy9/1ACUahWObW+W59Ng4HlN204kHi2
X-Gm-Message-State: AOJu0Yy0owuhjSZY7mg28RNtcjHM9Oc2eHOAlr6nx8HRCapPedCq60ff
	kWxLqUvjUDwvWF78gc1NZW9aEGRGneYBEjaMhbBhvAGVETvkxmheYfvcqQMC4flm6H9ldjH+jGN
	1lS1x3YYMfz2d9sgnBNJHtFQd0A==
X-Google-Smtp-Source: AGHT+IGyxOofX5NtXwiv3RmzLQfz6C1YmxhTYd83aKt2ToUFb9JlL8B+I57wHdB8sG8W04bkwT3WNR5Ztv9XE9uNrHM=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a17:902:c404:b0:1f7:3763:5ff0 with
 SMTP id d9443c01a7336-1fb33e3d924mr6890585ad.1.1720419676561; Sun, 07 Jul
 2024 23:21:16 -0700 (PDT)
Date: Mon,  8 Jul 2024 06:21:01 +0000
In-Reply-To: <20240708062103.3296587-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240708062103.3296587-1-aniketmaurya@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240708062103.3296587-2-aniketmaurya@google.com>
Subject: [PATCH 1/3] i3c: dw: Save timing registers and other values
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	vamshigajjela@google.com, Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

Add variables to store timing registers and other values.
These variables would be later used to restore registers
during resume without recomputation.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 drivers/i3c/master/dw-i3c-master.c | 15 +++++++++++++--
 drivers/i3c/master/dw-i3c-master.h |  9 +++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 0ca41782f3a6..fcfa37f55d86 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -543,18 +543,22 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 
 	scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I3C_PP_TIMING);
+	master->i3c_pp_timing = scl_timing;
 
 	/*
 	 * In pure i3c mode, MST_FREE represents tCAS. In shared mode, this
 	 * will be set up by dw_i2c_clk_cfg as tLOW.
 	 */
-	if (master->base.bus.mode == I3C_BUS_MODE_PURE)
+	if (master->base.bus.mode == I3C_BUS_MODE_PURE) {
 		writel(BUS_I3C_MST_FREE(lcnt), master->regs + BUS_FREE_TIMING);
+		master->bus_free_timing = BUS_I3C_MST_FREE(lcnt);
+	}
 
 	lcnt = max_t(u8,
 		     DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period), lcnt);
 	scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
+	master->i3c_od_timing = scl_timing;
 
 	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR1_SCL_RATE) - hcnt;
 	scl_timing = SCL_EXT_LCNT_1(lcnt);
@@ -565,6 +569,7 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR4_SCL_RATE) - hcnt;
 	scl_timing |= SCL_EXT_LCNT_4(lcnt);
 	writel(scl_timing, master->regs + SCL_EXT_LCNT_TIMING);
+	master->ext_lcnt_timing = scl_timing;
 
 	return 0;
 }
@@ -586,16 +591,21 @@ static int dw_i2c_clk_cfg(struct dw_i3c_master *master)
 	scl_timing = SCL_I2C_FMP_TIMING_HCNT(hcnt) |
 		     SCL_I2C_FMP_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I2C_FMP_TIMING);
+	master->i2c_fmp_timing = scl_timing;
 
 	lcnt = DIV_ROUND_UP(I3C_BUS_I2C_FM_TLOW_MIN_NS, core_period);
 	hcnt = DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_SCL_RATE) - lcnt;
 	scl_timing = SCL_I2C_FM_TIMING_HCNT(hcnt) |
 		     SCL_I2C_FM_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I2C_FM_TIMING);
+	master->i2c_fm_timing = scl_timing;
 
 	writel(BUS_I3C_MST_FREE(lcnt), master->regs + BUS_FREE_TIMING);
+	master->bus_free_timing = BUS_I3C_MST_FREE(lcnt);
+
 	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_I2C_SLAVE_PRESENT,
 	       master->regs + DEVICE_CTRL);
+	master->i2c_slv_prsnt = true;
 
 	return 0;
 }
@@ -650,7 +660,7 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 
 	writel(DEV_ADDR_DYNAMIC_ADDR_VALID | DEV_ADDR_DYNAMIC(ret),
 	       master->regs + DEVICE_ADDR);
-
+	master->dev_addr = ret;
 	memset(&info, 0, sizeof(info));
 	info.dyn_addr = ret;
 
@@ -1077,6 +1087,7 @@ static int dw_i3c_master_attach_i2c_dev(struct i2c_dev_desc *dev)
 
 	data->index = pos;
 	master->devs[pos].addr = dev->addr;
+	master->devs[pos].is_i2c_addr = true;
 	master->free_pos &= ~BIT(pos);
 	i2c_dev_set_master_data(dev, data);
 
diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
index fb7121c6c687..f23e9d5aca86 100644
--- a/drivers/i3c/master/dw-i3c-master.h
+++ b/drivers/i3c/master/dw-i3c-master.h
@@ -19,6 +19,7 @@ struct dw_i3c_master_caps {
 
 struct dw_i3c_dat_entry {
 	u8 addr;
+	bool is_i2c_addr;
 	struct i3c_dev_desc *ibi_dev;
 };
 
@@ -40,6 +41,14 @@ struct dw_i3c_master {
 	char version[5];
 	char type[5];
 	u32 sir_rej_mask;
+	bool i2c_slv_prsnt;
+	u32 dev_addr;
+	u32 i3c_pp_timing;
+	u32 i3c_od_timing;
+	u32 ext_lcnt_timing;
+	u32 bus_free_timing;
+	u32 i2c_fm_timing;
+	u32 i2c_fmp_timing;
 	/*
 	 * Per-device hardware data, used to manage the device address table
 	 * (DAT)
-- 
2.45.2.803.g4e1b14247a-goog



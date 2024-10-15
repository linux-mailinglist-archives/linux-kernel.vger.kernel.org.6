Return-Path: <linux-kernel+bounces-364962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6619799DBB6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DDF287DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABBF174ED0;
	Tue, 15 Oct 2024 01:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR47BMjW"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614F017278D;
	Tue, 15 Oct 2024 01:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956047; cv=none; b=sB/DbKj6A9jk/GHN6XbsygC7sb1wd9bRNRRs4w9/qF8qU+w7oXqa54VRlhewBD329d/0UwQSI03sL2sKYk9n/26irFkglIlld5+RlRKddU0vaiAbG4Bnp5J8/pB7swQ70UKCuJCsLhtyVxCDmZnSHwRW6Rt7YutNZAgRznJGNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956047; c=relaxed/simple;
	bh=iqGGq6N27+nHuKYdGvepkbL4yx0VHztAXhAi6+Z+rWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MMEJVZN+Cj/xp9OCIhKyR8stKUZAyBJjwOvvOA4Y/w+m9YDM51vlSW4zeRyhycxBjTIIDlORO8cor2hx9hXEZX/HNHHLcZkUUW9mZOmzjKFt8kExEa+G7fsf/+SZET+SCG9krGUtYOb1jUDo2jqJhh1UwnD0lgf8U+xT98KR4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GR47BMjW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e49d5deeeso92824b3a.0;
        Mon, 14 Oct 2024 18:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956045; x=1729560845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GH3A6vmgsIOEd/hbrPIWDSgafEN9K6GfNlaS75g6hkg=;
        b=GR47BMjWd//epMWCjnXJRcn5qUGpXqGQtC0O5umCSXrevqrn52zl5OwUXT1ET3MybI
         aOY5pI5zBgWrbgARNWTQN2HM1rJo9ZlaH3s44CQjqa+YkNEWpEU43N4JRZkL537/Hrwo
         XtbPWek/h2Pz/8R/rDFpUT1cPeBfgYkLH6YpqbsNWENkzBSSlu4n7zAVfZYakv9u8dtm
         5knN1FhlLn4knz0IFGYCxkmXK4lbZmB1YzSAevkvC4ibpdhkp4iJBjBXvEW7FhmfsAzg
         Wm0f5C9aIFg3pagDCQ9dHycWASVJSTuDk4cl/zomx8BkvkCS/KBISARQDmIT28GE5bcD
         8bKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956045; x=1729560845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GH3A6vmgsIOEd/hbrPIWDSgafEN9K6GfNlaS75g6hkg=;
        b=l6oGU2sNhODM6RwvDr1URZarIzofU4WXEt5atT+nhL25TMaHwopnfHn+RhO/Per4mY
         fOn99qGwsF0NW/vgkB9nyG4LiTBsrx0/t149TGDyr483cB/n9sYBvDi5wVscADQ/WUxQ
         Lg/azYqo/chdO6gTXwn37+47n2PH3RpVO0Ij4oE1Dv1KrTATWtMpTl55pPbe23JCeKg3
         OrlqIceW/Sers6GsqJB1ZLHdfx58BsjF/pk0aXEj9KIoHURs8volzgnH4zzNk4XgpNP1
         RrcI5qe8oPja3q7bJ6YihU/0OL0+uoZ3SakhPbeIoEb5w5P1S2IJbbWojJ4jMF8liooj
         Z9WA==
X-Forwarded-Encrypted: i=1; AJvYcCUv5+egpxlXlQqSYuwahnGkcoI+3uopefu8yB7NfkAOJtw+S6ctmq6lC5Knnezjb+XgtXr/2qHh1D8q@vger.kernel.org, AJvYcCWIs2N4xZfmedjtsFfpivHhTNkGv0vXbtkJyaew61V+PNccpWI3wduF7JMPzkxgDQTbhGy3bULfHNPyKCh0@vger.kernel.org
X-Gm-Message-State: AOJu0YxOfMqJUUjvV7pjbFmOB/s3/u9ro53zXuAH0HwZZ6VCdkDWTok1
	+kOjtVe/tlwOMBgBMkwBE9Sj6RemZBhCNdd15GP34WCxC8lTC0EriN6olg==
X-Google-Smtp-Source: AGHT+IENbE5VfJLTsH3qhdrga+goKQnThLNGc16l2GIKEVjDEiHa1fFBGByWr8papJ5EnN6tQKh//w==
X-Received: by 2002:a05:6a00:198e:b0:71e:594c:a812 with SMTP id d2e1a72fcca58-71e594caa26mr4591504b3a.0.1728956044402;
        Mon, 14 Oct 2024 18:34:04 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a4243sm189713b3a.131.2024.10.14.18.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:34:04 -0700 (PDT)
From: Frank Wang <frawang.cn@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	william.wu@rock-chips.com,
	tim.chen@rock-chips.com,
	Kever Yang <kever.yang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH 2/2] phy: rockchip-naneng-combo: Support rk3576
Date: Tue, 15 Oct 2024 09:33:51 +0800
Message-Id: <20241015013351.4884-2-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241015013351.4884-1-frawang.cn@gmail.com>
References: <20241015013351.4884-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kever Yang <kever.yang@rock-chips.com>

phy0: pcie, sata
phy1: pcie, sata, usb3

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: William Wu <william.wu@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 .../rockchip/phy-rockchip-naneng-combphy.c    | 202 ++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 0a9989e41237..4c41317a8041 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -98,6 +98,7 @@ struct rockchip_combphy_grfcfg {
 	struct combphy_reg pipe_rxterm_set;
 	struct combphy_reg pipe_txelec_set;
 	struct combphy_reg pipe_txcomp_set;
+	struct combphy_reg pipe_clk_24m;
 	struct combphy_reg pipe_clk_25m;
 	struct combphy_reg pipe_clk_100m;
 	struct combphy_reg pipe_phymode_sel;
@@ -584,6 +585,203 @@ static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
 	.combphy_cfg	= rk3568_combphy_cfg,
 };
 
+static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
+{
+	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
+	unsigned long rate;
+
+	switch (priv->type) {
+	case PHY_TYPE_PCIE:
+		/* Set SSC downward spread spectrum */
+		rockchip_combphy_updatel(priv, GENMASK(5, 4), BIT(4), 0x7c);
+
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
+		break;
+	case PHY_TYPE_USB3:
+		/* Set SSC downward spread spectrum */
+		rockchip_combphy_updatel(priv, GENMASK(5, 4), BIT(4), 0x7c);
+
+		/* Enable adaptive CTLE for USB3.0 Rx */
+		rockchip_combphy_updatel(priv, GENMASK(0, 0), BIT(0), 0x38);
+
+		/* Set PLL KVCO fine tuning signals */
+		rockchip_combphy_updatel(priv, GENMASK(4, 2), BIT(3), 0x80);
+
+		/* Set PLL LPF R1 to su_trim[10:7]=1001 */
+		writel(0x4, priv->mmio + (0xb << 2));
+
+		/* Set PLL input clock divider 1/2 */
+		rockchip_combphy_updatel(priv, GENMASK(7, 6), BIT(6), 0x14);
+
+		/* Set PLL loop divider */
+		writel(0x32, priv->mmio + (0x11 << 2));
+
+		/* Set PLL KVCO to min and set PLL charge pump current to max */
+		writel(0xf0, priv->mmio + (0xa << 2));
+
+		/* Set Rx squelch input filler bandwidth */
+		writel(0x0d, priv->mmio + (0x14 << 2));
+
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->usb_mode_set, true);
+		break;
+	case PHY_TYPE_SATA:
+		/* Enable adaptive CTLE for SATA Rx */
+		rockchip_combphy_updatel(priv, GENMASK(0, 0), BIT(0), 0x38);
+
+		/* Set tx_rterm = 50 ohm and rx_rterm = 43.5 ohm */
+		writel(0x8F, priv->mmio + (0x06 << 2));
+
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_sata, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_sata, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_sata, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_sata, true);
+		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_con0_for_sata, true);
+		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_con1_for_sata, true);
+		break;
+	default:
+		dev_err(priv->dev, "incompatible PHY type\n");
+		return -EINVAL;
+	}
+
+	rate = clk_get_rate(priv->refclk);
+
+	switch (rate) {
+	case REF_CLOCK_24MHz:
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_24m, true);
+		if (priv->type == PHY_TYPE_USB3 || priv->type == PHY_TYPE_SATA) {
+			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz */
+			rockchip_combphy_updatel(priv, GENMASK(7, 6), BIT(6), 0xe << 2);
+
+			rockchip_combphy_updatel(priv, GENMASK(7, 0), 0x5f, 0xf << 2);
+		} else if (priv->type == PHY_TYPE_PCIE) {
+			/* PLL KVCO tuning fine */
+			rockchip_combphy_updatel(priv, GENMASK(4, 2), 0x4 << 2, 0x20 << 2);
+
+			/* Set up rx_trim */
+			writel(0x0, priv->mmio + (0x1b << 2));
+
+			/* Set up su_trim: T0_1 */
+			writel(0x90, priv->mmio + (0xa << 2));
+			writel(0x02, priv->mmio + (0xb << 2));
+			writel(0x57, priv->mmio + (0xd << 2));
+
+			writel(0x5f, priv->mmio + (0xf << 2));
+		}
+		break;
+	case REF_CLOCK_25MHz:
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_25m, true);
+		break;
+	case REF_CLOCK_100MHz:
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
+		if (priv->type == PHY_TYPE_PCIE) {
+			/* gate_tx_pck_sel length select work for L1SS */
+			writel(0xc0, priv->mmio + 0x74);
+
+			/* PLL KVCO tuning fine */
+			rockchip_combphy_updatel(priv, GENMASK(4, 2), 0x4 << 2, 0x20 << 2);
+
+			/* Set up rx_trim: PLL LPF C1 85pf R1 1.25kohm */
+			writel(0x4c, priv->mmio + (0x1b << 2));
+
+			/* Set up su_trim: T3_P1 650mv */
+			writel(0x90, priv->mmio + (0xa << 2));
+			writel(0x43, priv->mmio + (0xb << 2));
+			writel(0x88, priv->mmio + (0xc << 2));
+			writel(0x56, priv->mmio + (0xd << 2));
+		} else if (priv->type == PHY_TYPE_SATA) {
+			/* downward spread spectrum +500ppm */
+			rockchip_combphy_updatel(priv, GENMASK(7, 4), 0x50, 0x1f << 2);
+
+			/* ssc ppm adjust to 3500ppm */
+			rockchip_combphy_updatel(priv, GENMASK(3, 0), 0x7, 0x9 << 2);
+		}
+		break;
+	default:
+		dev_err(priv->dev, "Unsupported rate: %lu\n", rate);
+		return -EINVAL;
+	}
+
+	if (priv->ext_refclk) {
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
+		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
+			writel(0x10, priv->mmio + (0x20 << 2));
+
+			writel(0x0c, priv->mmio + (0x1b << 2));
+
+			/* Set up su_trim: T3_P1 650mv */
+			writel(0x90, priv->mmio + (0xa << 2));
+			writel(0x43, priv->mmio + (0xb << 2));
+			writel(0x88, priv->mmio + (0xc << 2));
+			writel(0x56, priv->mmio + (0xd << 2));
+		}
+	}
+
+	if (priv->enable_ssc) {
+		rockchip_combphy_updatel(priv, GENMASK(4, 4), BIT(4), 0x7 << 2);
+
+		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_24MHz) {
+			/* Xin24M T0_1 650mV */
+			writel(0x00, priv->mmio + (0x10 << 2));
+			writel(0x32, priv->mmio + (0x11 << 2));
+			writel(0x00, priv->mmio + (0x1b << 2));
+			writel(0x90, priv->mmio + (0x0a << 2));
+			writel(0x02, priv->mmio + (0x0b << 2));
+			writel(0x08, priv->mmio + (0x0c << 2));
+			writel(0x57, priv->mmio + (0x0d << 2));
+			writel(0x40, priv->mmio + (0x0e << 2));
+			writel(0x5f, priv->mmio + (0x0f << 2));
+			writel(0x10, priv->mmio + (0x20 << 2));
+		}
+	}
+
+	return 0;
+}
+
+static const struct rockchip_combphy_grfcfg rk3576_combphy_grfcfgs = {
+	/* pipe-phy-grf */
+	.pcie_mode_set		= { 0x0000, 5, 0, 0x00, 0x11 },
+	.usb_mode_set		= { 0x0000, 5, 0, 0x00, 0x04 },
+	.pipe_rxterm_set	= { 0x0000, 12, 12, 0x00, 0x01 },
+	.pipe_txelec_set	= { 0x0004, 1, 1, 0x00, 0x01 },
+	.pipe_txcomp_set	= { 0x0004, 4, 4, 0x00, 0x01 },
+	.pipe_clk_24m		= { 0x0004, 14, 13, 0x00, 0x00 },
+	.pipe_clk_25m		= { 0x0004, 14, 13, 0x00, 0x01 },
+	.pipe_clk_100m		= { 0x0004, 14, 13, 0x00, 0x02 },
+	.pipe_phymode_sel	= { 0x0008, 1, 1, 0x00, 0x01 },
+	.pipe_rate_sel		= { 0x0008, 2, 2, 0x00, 0x01 },
+	.pipe_rxterm_sel	= { 0x0008, 8, 8, 0x00, 0x01 },
+	.pipe_txelec_sel	= { 0x0008, 12, 12, 0x00, 0x01 },
+	.pipe_txcomp_sel	= { 0x0008, 15, 15, 0x00, 0x01 },
+	.pipe_clk_ext		= { 0x000c, 9, 8, 0x02, 0x01 },
+	.pipe_phy_status	= { 0x0034, 6, 6, 0x01, 0x00 },
+	.con0_for_pcie		= { 0x0000, 15, 0, 0x00, 0x1000 },
+	.con1_for_pcie		= { 0x0004, 15, 0, 0x00, 0x0000 },
+	.con2_for_pcie		= { 0x0008, 15, 0, 0x00, 0x0101 },
+	.con3_for_pcie		= { 0x000c, 15, 0, 0x00, 0x0200 },
+	.con0_for_sata		= { 0x0000, 15, 0, 0x00, 0x0129 },
+	.con1_for_sata		= { 0x0004, 15, 0, 0x00, 0x0000 },
+	.con2_for_sata		= { 0x0008, 15, 0, 0x00, 0x80c1 },
+	.con3_for_sata		= { 0x000c, 15, 0, 0x00, 0x0407 },
+	/* php-grf */
+	.pipe_con0_for_sata	= { 0x001C, 2, 0, 0x00, 0x2 },
+	.pipe_con1_for_sata	= { 0x0020, 2, 0, 0x00, 0x2 },
+};
+
+static const struct rockchip_combphy_cfg rk3576_combphy_cfgs = {
+	.num_phys = 2,
+	.phy_ids = {
+		0x2b050000,
+		0x2b060000
+	},
+	.grfcfg		= &rk3576_combphy_grfcfgs,
+	.combphy_cfg	= rk3576_combphy_cfg,
+};
+
 static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
 {
 	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
@@ -775,6 +973,10 @@ static const struct of_device_id rockchip_combphy_of_match[] = {
 		.compatible = "rockchip,rk3568-naneng-combphy",
 		.data = &rk3568_combphy_cfgs,
 	},
+	{
+		.compatible = "rockchip,rk3576-naneng-combphy",
+		.data = &rk3576_combphy_cfgs,
+	},
 	{
 		.compatible = "rockchip,rk3588-naneng-combphy",
 		.data = &rk3588_combphy_cfgs,
-- 
2.34.1



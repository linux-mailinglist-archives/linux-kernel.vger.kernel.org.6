Return-Path: <linux-kernel+bounces-369092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEBB9A18CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 04:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898FF286AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF7657333;
	Thu, 17 Oct 2024 02:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3ANBmxV"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B220A13635C;
	Thu, 17 Oct 2024 02:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729133571; cv=none; b=Q1TgpzWYyD6aH1bdW1Kot8yesT+/DpW7RJviOC3mteZYTZLShKMsSSFFwAcj+BbuHEum+JaeZHc1CP7XCdO30hWJN8CX1HJG8nzY4NsHxS9gzgsNVKFg23ZdMIVo0l+d0reL0SUTuB8SppEaGfdUh1rLkEp+OONxrQHXLET996Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729133571; c=relaxed/simple;
	bh=8HqwrcMzL63E0s24nH5FuchNMsbuO0sIxDPt/CsFJeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mosPdkLePMiT5FBY+cg1wunSiJa8AYRuHBEGacbRVM94SvXr9jw0N97ZTCgH1MncmiMedANkkJfredgMDC3vr0uT4alU+LmUe3QigJhXJT+hT565ifuPMmv/4ZlUT1AiphKx6+EEzhuO+UYoD5akiBzaCNyXbTApjMl10PpNRZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3ANBmxV; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2da8529e1so77651a91.1;
        Wed, 16 Oct 2024 19:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729133568; x=1729738368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gf+PMX6YxweSXYAEzNrfFe+MZTHHEq+3Qule4g5FzBA=;
        b=G3ANBmxVHcPy7EXYQAP31ylRba5lxJMwXG6YKuqG68xveXBMAuvxstuPqdqytHyoTA
         zWlfsxIpYrKodHRBzps/eJTu0NaC/GJaBBR/p4eT6OFNdp0GltS/KEqYT1OJEDFbC93v
         g0GrwZ37HfyyXmnK7zz/2EuWoXuo68XVgla+bixlL0Isw4XL+td0NpmqbrVHQvJ8/+mi
         WY0zv2U6fPTNtSrEh0tBFyEnv+AB6A7HNMJFZl4Oi8+svt6SjTlI+xWqgnV1h+40pt7z
         y0o+KkBPPV9eIs4F3WE+EUbISY31L8f5Lkdc4eQcpqFJO45n2dBn6hqS+W/uPy+YugIw
         oOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729133568; x=1729738368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gf+PMX6YxweSXYAEzNrfFe+MZTHHEq+3Qule4g5FzBA=;
        b=Zht60LefZAGn/dazQHfpgQ6XCokAwR5XmdxPqmi2Jz4oYXwQcEXH1zsNWCX8FAX3YM
         NWu0b0nGlNL4iDfZwsf1MrNRw+0ZzAxoO/pWdnwr120CzeQ4PbbBM+bl3Xi4cKUOMhPV
         PVA/fP19/KjfNT1XyusPEYw+hKGHA+bqu/NFVENxz4Q6LDv366Iw/FxDN9CAOdqgNzb+
         Qt0IyCTk+wDm0O4kqCDkMC4F9DeFSzSLopUDbszvreMK3gvS9iQCM+J7R9FW4rM1pWVj
         OVxr8JoQDt8XlsaCiAdl63MJH0bF19hPXQr3p6DqEffpzOjlzDeWuQfIeg/Vn+UGugUX
         8o7g==
X-Forwarded-Encrypted: i=1; AJvYcCUksYMxxWKmY5gBT0At0pduKX92ptcWkfu6Pk1Ru9LL/zs+JRmSSKHdkXyR4WegIp0wFd1dDjmRCREG@vger.kernel.org, AJvYcCVnZ/+K37Mhq218xjHgL7WyyIPfjWQZtt6vy86mz3nkssAk7nbqKdvUdnH2o5IjRsBYmqACfyQAuRQt2+sD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywayzhq7rpDOJZk4gsmuDx925BhR9oIJAACvZALDiHYo63MjQqg
	6bRlU1UrnZI+4OQ0DL99uZEkr4nMCW/KqvwVUD89v7252ERR6/0d
X-Google-Smtp-Source: AGHT+IHEYEmjYlU0tYbqmxNPBntwEjtGskPlYMwZntBvTJCgBTEhOctyXNt80QCb485EeMieShL0Sg==
X-Received: by 2002:a17:90a:bf85:b0:2e2:ada8:2984 with SMTP id 98e67ed59e1d1-2e3dc25fc19mr918337a91.4.1729133568018;
        Wed, 16 Oct 2024 19:52:48 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08d8b6esm628537a91.29.2024.10.16.19.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 19:52:47 -0700 (PDT)
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
	yubing.zhang@rock-chips.com,
	Frank Wang <frank.wang@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v2 3/3] phy: rockchip: usbdp: add rk3576 device match data
Date: Thu, 17 Oct 2024 10:52:30 +0800
Message-Id: <20241017025230.28752-3-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241017025230.28752-1-frawang.cn@gmail.com>
References: <20241017025230.28752-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wang <frank.wang@rock-chips.com>

This adds RK3576 device match data support.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
Acked-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
Changelog:
v2:
 - add Reviewed and Acked tag.

v1:
 - https://patchwork.kernel.org/project/linux-phy/patch/20241014020342.15974-2-frawang.cn@gmail.com/

 drivers/phy/rockchip/phy-rockchip-usbdp.c | 41 +++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index 2c51e5c62d3eb..5b1e8a3806ed4 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -1538,6 +1538,43 @@ static const char * const rk_udphy_rst_list[] = {
 	"init", "cmn", "lane", "pcs_apb", "pma_apb"
 };
 
+static const struct rk_udphy_cfg rk3576_udphy_cfgs = {
+	.num_phys = 1,
+	.phy_ids = { 0x2b010000 },
+	.num_rsts = ARRAY_SIZE(rk_udphy_rst_list),
+	.rst_list = rk_udphy_rst_list,
+	.grfcfg	= {
+		/* u2phy-grf */
+		.bvalid_phy_con		= RK_UDPHY_GEN_GRF_REG(0x0010, 1, 0, 0x2, 0x3),
+		.bvalid_grf_con		= RK_UDPHY_GEN_GRF_REG(0x0000, 15, 14, 0x1, 0x3),
+
+		/* usb-grf */
+		.usb3otg0_cfg		= RK_UDPHY_GEN_GRF_REG(0x0030, 15, 0, 0x1100, 0x0188),
+
+		/* usbdpphy-grf */
+		.low_pwrn		= RK_UDPHY_GEN_GRF_REG(0x0004, 13, 13, 0, 1),
+		.rx_lfps		= RK_UDPHY_GEN_GRF_REG(0x0004, 14, 14, 0, 1),
+	},
+	.vogrfcfg = {
+		{
+			.hpd_trigger	= RK_UDPHY_GEN_GRF_REG(0x0000, 11, 10, 1, 3),
+			.dp_lane_reg    = 0x0000,
+		},
+	},
+	.dp_tx_ctrl_cfg = {
+		rk3588_dp_tx_drv_ctrl_rbr_hbr_typec,
+		rk3588_dp_tx_drv_ctrl_rbr_hbr_typec,
+		rk3588_dp_tx_drv_ctrl_hbr2,
+		rk3588_dp_tx_drv_ctrl_hbr3,
+	},
+	.dp_tx_ctrl_cfg_typec = {
+		rk3588_dp_tx_drv_ctrl_rbr_hbr_typec,
+		rk3588_dp_tx_drv_ctrl_rbr_hbr_typec,
+		rk3588_dp_tx_drv_ctrl_hbr2,
+		rk3588_dp_tx_drv_ctrl_hbr3,
+	},
+};
+
 static const struct rk_udphy_cfg rk3588_udphy_cfgs = {
 	.num_phys = 2,
 	.phy_ids = {
@@ -1584,6 +1621,10 @@ static const struct rk_udphy_cfg rk3588_udphy_cfgs = {
 };
 
 static const struct of_device_id rk_udphy_dt_match[] = {
+	{
+		.compatible = "rockchip,rk3576-usbdp-phy",
+		.data = &rk3576_udphy_cfgs
+	},
 	{
 		.compatible = "rockchip,rk3588-usbdp-phy",
 		.data = &rk3588_udphy_cfgs
-- 
2.25.1



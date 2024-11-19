Return-Path: <linux-kernel+bounces-414356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D879D2708
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0C5B29D05
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0BE1CDA3C;
	Tue, 19 Nov 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="gp1pAgKw"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4F01CC163;
	Tue, 19 Nov 2024 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023012; cv=none; b=PTwSEMBsPl9zKqOHWy/smlidxzfE+srQLAzI0X2yj/DwBzx/djV+i7LPS7OU0zne9sJEvZ4oQT0V2hvOVTQ2CmGry+RvdLbHH1vhmVS9/GUBWxcapCCbtAS29+z3ZNOHZnGXG31HFIb34nyqfxU+J7PJHp5tp1X3bM9eUEFB8t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023012; c=relaxed/simple;
	bh=OHaWP2CncpzzNuPG2amgndlMmmPI6sxu0hEoPCpaMj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYVsP1cxSSgidxvnbevJ4aAX/6ZwxLWXTXHKexvNcWKIzBbXDQS5YbshE7iBqC0j+PoyUPVEI9vIvSwER1tD2ZmKTlDoOsTkNTAZXQr4en+hO5+uDwB7IaMpWoXSAhnf/nWyXpXA2llPnxnm7wVuS+ro/3HH0+1d3xhVcTETr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=gp1pAgKw; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=heKbr9O2GKx5xLAYwPcBI72bkFwvVK0SwD6u81KEJCg=; b=gp1pAgKw78BBuGpxs/OTpQ/ciL
	KGYM30VM9wWnXMmSnqom84K92HtJ0ndUA9SJWLx908DkSCPhhxDjBBMoAlEbLOWHS9d3uq0EMQfNB
	ffDjTcjAMQEg2e2jtWKRUrC5QuNNh5D9xY63iUElj7Yczx1UBszoLILJ741LPwHcGA2lnli8Tx7F4
	IDAc3qn5dV6+yKcCoQOythUqhKY+o/l4Mxr59ow7XsFS0B1wYXG9ZCb106Rb0JAxrbBOg8ec/e9MH
	9udfg63N2JQuqkL8AYvUFYgn7L79OX/QCU9tfQYKOS0XMWs8NgDQ4iUp4WtjoGhIYfmoU4aMIZDer
	E6PBdXlg==;
Received: from i53875a30.versanet.de ([83.135.90.48] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tDOIn-0006z1-Dv; Tue, 19 Nov 2024 14:29:57 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: srinivas.kandagatla@linaro.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	detlev.casanova@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	sebastian.reichel@collabora.com
Subject: [PATCH 1/5] clk: rockchip: rk3576: define clk_otp_phy_g
Date: Tue, 19 Nov 2024 14:29:12 +0100
Message-ID: <20241119132916.1057797-2-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119132916.1057797-1-heiko@sntech.de>
References: <20241119132916.1057797-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The phy clock of the OTP block is also present, but was not defined
so far. Though its clk-id already existed, so just define its location.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3576.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3576.c b/drivers/clk/rockchip/clk-rk3576.c
index 595e010341f7..029939a98416 100644
--- a/drivers/clk/rockchip/clk-rk3576.c
+++ b/drivers/clk/rockchip/clk-rk3576.c
@@ -541,6 +541,8 @@ static struct rockchip_clk_branch rk3576_clk_branches[] __initdata = {
 			RK3576_CLKGATE_CON(5), 14, GFLAGS),
 	GATE(CLK_OTPC_AUTO_RD_G, "clk_otpc_auto_rd_g", "xin24m", 0,
 			RK3576_CLKGATE_CON(5), 15, GFLAGS),
+	GATE(CLK_OTP_PHY_G, "clk_otp_phy_g", "xin24m", 0,
+			RK3588_CLKGATE_CON(6), 0, GFLAGS),
 	COMPOSITE(CLK_MIPI_CAMERAOUT_M0, "clk_mipi_cameraout_m0", mux_24m_spll_gpll_cpll_p, 0,
 			RK3576_CLKSEL_CON(38), 8, 2, MFLAGS, 0, 8, DFLAGS,
 			RK3576_CLKGATE_CON(6), 3, GFLAGS),
-- 
2.45.2



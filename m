Return-Path: <linux-kernel+bounces-260375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6FA93A7E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8368284FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD22E143C79;
	Tue, 23 Jul 2024 19:56:40 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF981143C65
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764600; cv=none; b=SZClH5b6WrRcule7DWlw82A+oQquWSXcLqZ3FbnMYZmyLi/3//LIMt6bMz6pdPgOMcaotoTU59oWeYjwo2I+4FHR2k3HnUcibLyHRO4Ah1MghgD8iex1UHMawZG45x1gbjUjGsGK3E9cc/cYeb4itohpgfjxB6UUdb/id83bSa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764600; c=relaxed/simple;
	bh=2/8e8iZJOWh6+x6a5YNsJ8TkxIsAfgwwFktgsQ5SlgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZjAbh2LNryKjFUCg1av2Rhun6rKHr37W2Qp0WxakeVqhVVktW5p7K+HqmowGEPE89la2Fk8Ve2KA58m/nJkiYQ06jMO1suYfVWtcDOkZv544mQjRRK7lpcFjPoNXPeFvnnR5fUYSVdHB0lC7tkhde9t6auFKIUs4itbidztqzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sWLbv-0005iD-Iq; Tue, 23 Jul 2024 21:55:47 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/14] arm64: dts: rockchip: enable gpu on Qnap-TS433
Date: Tue, 23 Jul 2024 21:55:37 +0200
Message-Id: <20240723195538.1133436-14-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240723195538.1133436-1-heiko@sntech.de>
References: <20240723195538.1133436-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The TS433 doesn't provide display output, but the gpu nevertheless can be
used for compute tasks for example.

So there is no reason not to enable it.

Tested-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index b807da6e85015..9a0cb69c3cfa0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -210,6 +210,11 @@ &gmac0_rgmii_clk
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.39.2



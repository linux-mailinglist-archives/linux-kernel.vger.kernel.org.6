Return-Path: <linux-kernel+bounces-521252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFE7A3BABB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E273BD989
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A221D88DB;
	Wed, 19 Feb 2025 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ve2MFcP1"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D631D9A50
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957615; cv=none; b=glJ2Gi3i/+FhMZsKaSkMu9RiB0yhgJoEbK6zt18+MU0+1stV7kE1wpd9A1GJSFAwFd35B/yfIabnkAIMPAskxE7Ml9C+sTcp2DlSPRaJSF0IozC3oJPlf2BnoaUaJoTb7e+Zvrcki/0LkuILBJVOYd0VNhJ2hHIC+XXVHBEz6Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957615; c=relaxed/simple;
	bh=yKVLQ864T5vevIjDKT+eF8FDgGwpkhDHTZGv6+1IgF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThaevEL+YSWpXjqcIXhbSBhpFK9Dxhef6z2Yt+cEZIV1gt9qBtjmh7I917pt4a8IZajnYfV9qbhIiTo3+nZ8V4wXGkO78JdAd76CgquZ3bw9CWeIKLVQV4dIL5d/x6XvcOsaJ78KqhMNXO6xKKGc55ycDqnANqkyr+OCxwezRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ve2MFcP1; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vH4/0sUG9+QNhK0ITVG/OSD+cVU4w2SoCvst46XTGXE=; b=ve2MFcP1J/odujnY4NdczgJVYx
	mvdQZ3zKNbbPE3rFTjV9C5v1HIhUFl/YGA6+PfOLerbEkCq0Tm5qwnONnRnb0TzkFXmKmNzmGnrZo
	BOJ6XqxKAsttnzwj7sVsagH63laEILi+DpuuU147tJaK+UN7DXitbDlEu2e3PQp5NIXd6MQe/ai75
	exDndkfzaCXFw6XNQGEA78lhNBdSK9zfrZZR7AwdP0gMjf6oaCU0WEc/7pZyz6Vf+11CrMGOVdSpP
	5S4SVAEpREWplQEh9509gYVIH5FGndixuStJpblJzomENRDt4hb2hKbKuB6gk0AVcayjJDwuscada
	ej56tdkg==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tkgSR-0007nl-74; Wed, 19 Feb 2025 10:33:31 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lukasz.czechowski@thaumatec.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 2/2] arm64: dts: rockchip: remove supports-cqe from rk3588 tiger
Date: Wed, 19 Feb 2025 10:33:03 +0100
Message-ID: <20250219093303.2320517-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250219093303.2320517-1-heiko@sntech.de>
References: <20250219093303.2320517-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The sdhci controller supports cqe it seems and necessary code also is in
place - in theory.

At this point Jaguar and Tiger are the only boards enabling cqe support
on the rk3588 and we are seeing reliability issues under load.

This can be caused by either a controller-, hw- or driver-issue and
definitly needs more investigation to work properly it seems.

So disable cqe support on Tiger for now.

Fixes: 6173ef24b35b ("arm64: dts: rockchip: add RK3588-Q7 (Tiger) SoM")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index 81a6a05ce13b..e8fa449517c2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -386,7 +386,6 @@ &sdhci {
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_bus8 &emmc_cmd &emmc_clk &emmc_data_strobe>;
-	supports-cqe;
 	vmmc-supply = <&vcc_3v3_s3>;
 	vqmmc-supply = <&vcc_1v8_s3>;
 	status = "okay";
-- 
2.47.2



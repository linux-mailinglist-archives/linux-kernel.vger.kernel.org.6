Return-Path: <linux-kernel+bounces-212244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C82905D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA72284DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C9684FDF;
	Wed, 12 Jun 2024 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="lDhlTD5K"
Received: from shout12.mail.de (shout12.mail.de [62.201.172.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547BC12C474;
	Wed, 12 Jun 2024 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225673; cv=none; b=Qbs0AN5lQs6RMtK87KjeaddjU/9ImDc7vbo2uEOwUjqju6bu+ISCLsfxb5o0udUV9BFK5Bbf7L8Oh3VAeKNP9sQzlsuPfcpnjAc6eSxcw/f93aSX/mN4dQuoO+GS3QQZHI8l542THWHdoUBM2r1M6f3JZFWnyd1US6vUbALJGJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225673; c=relaxed/simple;
	bh=X/r/oHMy8dOwR8VKQt0p0IMSLPiew0x6KHjtkpK4Q7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAC7T0B+hhGDpYgZ+93UG7y5guvqMuEANhkFcy/VUAsiffM6rZdMfSaurntfQiutlQkg25Q9rZy1Fp5yaFKQdqqFaDCXLYJspeKZgUSb3PxvlSJ3ptDkxo37t/C/CJz6O8W4Bdj6grInQ4rvKZJg6fy/fTc3ITJtKrGBlKmWBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=lDhlTD5K; arc=none smtp.client-ip=62.201.172.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout01.mail.de (unknown [10.0.120.221])
	by shout12.mail.de (Postfix) with ESMTPS id 0B797241949;
	Wed, 12 Jun 2024 22:54:21 +0200 (CEST)
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
	by shout01.mail.de (Postfix) with ESMTP id E62722405B9;
	Wed, 12 Jun 2024 22:54:20 +0200 (CEST)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
	by postfix01.mail.de (Postfix) with ESMTP id C6BD68016E;
	Wed, 12 Jun 2024 22:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1718225660;
	bh=X/r/oHMy8dOwR8VKQt0p0IMSLPiew0x6KHjtkpK4Q7M=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
	b=lDhlTD5Kv+jOfeVrYfJo0m45ybKSOinIQlktcMl5tem0Hhv1LnueMppD4D3hgcBg0
	 c1mz1wG13LHivrN9YlWPeiRRVdl1jSdZKft2Zn7fWnkAGfqEPl0IEH3s0MyZoWea2+
	 Jy6c/mK99//RkhBvxQ/a72IXWcrhE+ZBLSkkp5lsdpX9oLG21hkdoZgrx12hmqan72
	 Bd828D8kIj7192kiNLnWp2Jrs1/HH8zrg1P8MmR1V8x7UZej/PWvehXc58J2iHUFXe
	 dfzM5ilw/7AqEWgRgo0vXGGn+l9G1HvlCk6nuLGMHtzmEUReOc7uUJLFlKyzdZ4F5Y
	 B5GzCG46inNbw==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 444B6240EB5;
	Wed, 12 Jun 2024 22:54:20 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: rockchip: Enable GPU on NanoPi R6C/R6S
Date: Wed, 12 Jun 2024 22:48:14 +0200
Message-ID: <20240612205056.397204-6-seb-dev@mail.de>
In-Reply-To: <20240612205056.397204-1-seb-dev@mail.de>
References: <20240612205056.397204-1-seb-dev@mail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 760
X-purgate-ID: 154282::1718225660-FE5BF670-E64745C7/0/0

Enable the Mali GPU on the FriendlyElec NanoPi R6C and R6S.

Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
---
 arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
index 9676e7194451..3620677dc7b4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
@@ -207,6 +207,12 @@ &gmac1_rgmii_clk
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu_s0>;
+	sram-supply = <&vdd_gpu_mem_s0>;
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0m2_xfer>;
-- 
2.43.0



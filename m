Return-Path: <linux-kernel+bounces-538729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD24A49C72
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60903B7B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A0927182A;
	Fri, 28 Feb 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UPxUa2Ff"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2648D270EC1;
	Fri, 28 Feb 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754403; cv=none; b=QH1VvC0ZYXJEAiyi/i6CmwNm12r0OmPRBl05DYUm5ExiW5d24QxzrTjw6nPQsMMeUhRIj3yEh2VYNhi8MGtmSXInO/ebX03KDnoHrX59320O/cwEPLY2bhR93gjCSGk3RN8fvCIfJAMViwa++yBFyat0XGfx1/iK0UrLDZkB/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754403; c=relaxed/simple;
	bh=oRoY54GYwkZqq9qz+2JJWuc/yHiIM4DNvPGXJPJIl98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXocwiMTFqLB33wqsWor/kkLyqBTCvuoAO3tg8rNZ3pjqskN3z1y6hWVk/hjIYzoroSM0VnDjEtzF/l8yArxfHrdV4cEtP9XtgS2MxCCgSDkx0DGsfm2Wk9ejVenbj3/eLVkMuj836q/dCePOZR+sELL1t8NYlYmOztH98CrSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UPxUa2Ff; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740754400;
	bh=oRoY54GYwkZqq9qz+2JJWuc/yHiIM4DNvPGXJPJIl98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UPxUa2FfP22b2Q5Tc0r9oojcibLXvIhkoJ69hI6gNj1TgUqDnNsmgur2QydWvjkjw
	 iijx9pKiKRtvPsPpGenohoWIfmtyy8tRRQr4rc4HP4C6S55AnjJCYRo4ytdmyg0nGA
	 +3Bbh/Om/G7w9Sb/oKKqHwoed7Nsjvvib6C3LdN+nqTkz+4V3Dcy+Z7w7vSFFENazi
	 0zZYWH7E6pklX8tuViuCxrWhgMbL4GAGRETmhtFy1+zRpOO4q3kMkMOdVzfaw4djU6
	 Jv3ivI8GVejufqyjpRo22GkVdou9bys+ax1tkrG39jrqUkUu4MHk6qP+VSJ9FPo/d4
	 02Wa0V6ZZm7uQ==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3675217E0B64;
	Fri, 28 Feb 2025 15:53:18 +0100 (CET)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Alexey Charkov <alchark@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Stephen Chen <stephen@radxa.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 2/2] arm64: dts: rockchip: Add SPI NOR device on the ROCK 4D
Date: Fri, 28 Feb 2025 09:50:48 -0500
Message-ID: <20250228145304.581349-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228145304.581349-1-detlev.casanova@collabora.com>
References: <20250228145304.581349-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPI NOR chip is connected on the FSPI0 core, so enable the sfc0 node
and add the flash device to it.

The SPI NOR won't work at higher speed than 50 MHz, specify the limit.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 5dc1c18a3b211..09977dc191fe1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -670,6 +670,22 @@ &sdmmc {
 	status = "okay";
 };
 
+
+&sfc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspi0_pins &fspi0_csn0>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+		vcc-supply = <&vcc_1v8_s3>;
+	};
+};
+
 &u2phy0 {
 	status = "okay";
 };
-- 
2.48.1



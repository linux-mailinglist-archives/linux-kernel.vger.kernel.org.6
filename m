Return-Path: <linux-kernel+bounces-311246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B022E968689
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A85B1F2154B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE36D1D6DA2;
	Mon,  2 Sep 2024 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="DhtdbHKK"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AB91D6C4F;
	Mon,  2 Sep 2024 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277638; cv=none; b=DWQKnqvZ5BwLoj2z3fi/q8cwYsCvR9CXZcyCOaGjAILJUBhMEbLCTPh8+TxLERHBr+nEtHwVRtCj/xJZJGPP985C6hPmQ9M81Jngb3tblXLKzySLAtVWxqH/T9z23WKWBzjOEbLzRqccJB5r3bL9cyTrezAw9CopD51fkFFiUnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277638; c=relaxed/simple;
	bh=9o+RrAQd+gd4k/syUzqom+Fp1TS2bIbERUNXEmH7JyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aw5RKDO38U81wdF8j0bE44+RG6wEUQI87uNi6nx0pOSDD1wNQzwHg0/j2zYnEmq2WrS7ucC9/7EaF7ISZWSseSeEd6fZltF/NGNJ7Ydugy2B/30NhrESf1e6epgLje9ZeY9wlGGdHOjSi24NQ+1tTi+7MgZ40/9cy3QpsodZNzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=DhtdbHKK; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id A660D889EB;
	Mon,  2 Sep 2024 13:47:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725277628;
	bh=aYamewc2eH+HlO7ZUdrAAC11IZvPiDq6VBihAAscScY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DhtdbHKK5eTSDk+t0PTWbQjQjLuBqNt/Um5T1PbLYvTqEoFjwizOq2JHVNKEBMzyv
	 sZWQYGp+KTZS4pwBmNRxMqY2jeOw/16VAw8DOXbouT06TvW6qzm87Ts0WfBHDpYeGu
	 Vj+a7dv+/4mBG79eHOXYhXsiBwIl6ueajfbDK9Aj8eejGaZ+N15CZodG6eUIn/ikEB
	 HMQYHL2z65awGqvbLXYOaG8Qyk9Z7V2u+wORRV4ZkSZ/ExjwENLUTxvY1dSWCHw3tK
	 oet2X8G3PZa8XBq95SsK+9RH5OwCK+zZkPOetxjDvsEr9q6fq2qNQ75ycQF9vEAjtV
	 tRh4vSfD0Rcfg==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH] ARM: dts: imx28-lwe: Reduce maximal SPI frequency
Date: Mon,  2 Sep 2024 13:46:51 +0200
Message-Id: <20240902114652.893272-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240902114652.893272-1-lukma@denx.de>
References: <20240902114652.893272-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Due to some operational problems (HW) the maximal speed of the SPI
frequency for flash memory has been reduced by half.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi
index a954fef8bd8e..0fc74eeac217 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-lwe.dtsi
@@ -109,7 +109,7 @@ &ssp3 {
 
 	flash@0 {
 		compatible = "jedec,spi-nor";
-		spi-max-frequency = <40000000>;
+		spi-max-frequency = <20000000>;
 		reg = <0>;
 
 		partitions {
-- 
2.39.2



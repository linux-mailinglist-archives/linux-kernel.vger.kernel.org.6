Return-Path: <linux-kernel+bounces-254980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C26933A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A801F243BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D7B53E22;
	Wed, 17 Jul 2024 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dT7QjkcL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066E5589B;
	Wed, 17 Jul 2024 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209102; cv=none; b=DbbC48wU7QWsa0WogD+zD0+K9nxpBPUwYnDs9oWbvCSvzG1tNLqIY6BdEtUgHIi/0jDf10WSwALPFofyNxKa/Mnx3m6fnohDq3EczKCp0g7W8qrv6VXQvDLOWIvJqfTmWWO0OvdpttPWry9n3u6PC8KA2UcMKagA/x2cic05zF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209102; c=relaxed/simple;
	bh=kvAvf3K13By68WYYkU8J/NSbxi+QzftdA8TmLyuxtq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaDoEyuJrvphAm2YIpTmYcdqo4aa8rJt4Zyf2pmfKbbuhTFcAh44TbLhrQuHgxdyRaIbMEJoDpx526tb2/d3OA8lizZbFFFcUpXDXVgK6uWS/C7ysN/qNihF8qjRTpiUv3sEbcc94Cuivhnu/9IdrCdXJDxAs4NUYcpCmsWb4Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dT7QjkcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0460BC4AF09;
	Wed, 17 Jul 2024 09:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721209102;
	bh=kvAvf3K13By68WYYkU8J/NSbxi+QzftdA8TmLyuxtq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dT7QjkcLSQyTYW+upkHxZPkqByBL2o8ELkc8voWPr2JPTBJVqWgrjKDUy0zA7f1M5
	 LpmBztk1tru1WTy6CVfQGaBkZQVzjTQ17LwFXYhoKWGKFcDbXAjMCQjx6hpGTfCTUj
	 hHecFyKnDZup/UZ8X5qXvrGrdP2hQLRJNP30XMzpuvpJfbZF55q9axNy1k9xeNcFGc
	 yuZ6XPb3mQyHZW4KNzsW4RDRx6XB4J9FuP9LotQgiCP7asnQhiBF3oLKYbKTy21Vhw
	 0DDU3dG7m+2f/sSAYQsF3vfghyLn3jScF379FhG5+D4PhifvoYUK2k3Yl5P0liblNy
	 Kb4rypoeHK6ig==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	imx@lists.linux.dev,
	loongarch@lists.linux.dev
Subject: [PATCH v1 3/4] loongarch: dts: remove non-existent DAC from 2k1000-ref
Date: Wed, 17 Jul 2024 10:37:55 +0100
Message-ID: <20240717-preacher-sandal-2aeffa322b9f@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717-anvil-ashy-544e80a1317c@spud>
References: <20240717-anvil-ashy-544e80a1317c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=958; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=jfLYO8PFemfCqGXNrh1eFKx07e6y8OVxxug9hg0F1C0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnTJ3wU+s7fvKRHVGz+tenHhQ6u+vrlkYLe4hNn2rVXF HV2LHmf1FHKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJJJcx/PdJF2lX6+VKeudx xv6ec7hVzOGt+8qki78ErNwe8JdfKZyRYVF6v9Uj3+6GPcdYu8PPVBh1pk+61dXt/W3ajAMVs9I 0GAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The 2k1000 reference boards do not have a Rohm DAC on them as far as I
can tell, and they certainly do not have a dh2228fv, as this device does
not actually exist! Remove the dac nodes from the devicetrees as it is
not acceptable to pretend to have a device on a board in order to bind
the spidev driver in Linux.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/loongarch/boot/dts/loongson-2k1000-ref.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/loongarch/boot/dts/loongson-2k1000-ref.dts b/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
index 23cf26cc3e5f..3514ea78f525 100644
--- a/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
+++ b/arch/loongarch/boot/dts/loongson-2k1000-ref.dts
@@ -90,11 +90,6 @@ &spi0 {
 
 	#address-cells = <1>;
 	#size-cells = <0>;
-	spidev@0 {
-		compatible = "rohm,dh2228fv";
-		spi-max-frequency = <100000000>;
-		reg = <0>;
-	};
 };
 
 &ehci0 {
-- 
2.43.0



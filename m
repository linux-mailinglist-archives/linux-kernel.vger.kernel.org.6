Return-Path: <linux-kernel+bounces-339101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF78986082
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C047FB32050
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7771A2C1E;
	Wed, 25 Sep 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="dDFrbvLr"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D591A2866;
	Wed, 25 Sep 2024 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268578; cv=none; b=JuP6diImsoh22uw8ejvW7QL0FmNfHmKBXS43Lsej8O52ZNXpbrhaypzE1HxZbNAbQUEwM+yNIsYp0vGugHAJfXZqbpRt1kukdwZytsyVZ8nAIid6hMRv8kXnSUj2hx/JZFNp5DfUDPtKsgcKW38qNVgoMjnJlojxzApoZSzfR1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268578; c=relaxed/simple;
	bh=pOpCdNDWE7AOs2h//XUIygbEAbG/8yJofHY4Quh7DXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BviSPRRLLcmqiBxHogL99GmfdUCQbPdpWVEUbiouerSuNyBVJf2+1Wv04t6pjdK2c/8gMjxlbOsJoziU9YzmQJ0AS8zl1RWkLRYrO75VUY3ltnGpvM4DMszOcCQnDaNGRUzrsKIB5SnJ6Hk1efoUpvr6IpsEpaXHywPVAvGydYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=dDFrbvLr; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1727268574;
	bh=ZNoWTEQsqc34AgTnGl6LHBfTCISxnDjwkPLJBXG2qA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dDFrbvLrElO5T5DTtm3e6uAMU+pJf36qke0NzDKSiHyQxVP/4LdB59Wjyww5SP0Es
	 Xg0SofsmJlXstfAr030jQT9aRXy7SrrbVJAlmTzivBgx2EQr3IAupH+45TywQBA/Je
	 etNYa8jyeXGfDzo/+nLiG9G2Bvdb3DIkkWiZiQpw=
Received: from vokac-nb.ysoft.local (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id 94FF8A055B;
	Wed, 25 Sep 2024 14:49:34 +0200 (CEST)
From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Petr Benes <petr.benes@ysoft.com>,
	Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Michael Walle <mwalle@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: arm: Add i.MX8MP IOTA2 Lumpy board
Date: Wed, 25 Sep 2024 14:49:02 +0200
Message-ID: <20240925124903.1837869-2-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925124903.1837869-1-michal.vokac@ysoft.com>
References: <20240925124903.1837869-1-michal.vokac@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add new board from the Y Soft IOTA family. This one is based on the i.MX8MP
SoC. It is basically a stripped-down clone of the EVK board with some minor
additions.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
v5:
- none
v4:
- none
v3:
- none
v2:
- Added tag from Krzysztof.

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b39a7e031177..a3389f2d06e6 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1088,6 +1088,7 @@ properties:
               - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
               - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
               - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
+              - ysoft,imx8mp-iota2-lumpy  # Y Soft i.MX8MP IOTA2 Lumpy Board
           - const: fsl,imx8mp
 
       - description: Avnet (MSC Branded) Boards with SM2S i.MX8M Plus Modules
-- 
2.43.0



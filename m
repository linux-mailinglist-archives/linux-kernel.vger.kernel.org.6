Return-Path: <linux-kernel+bounces-384438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573819B2A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895D11C2199D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFCC192598;
	Mon, 28 Oct 2024 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="RXBqu2z/"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01061922FC;
	Mon, 28 Oct 2024 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730103826; cv=none; b=mSrH3hb2pZLxVSRT0zJGBUOZZRiVJD0O7fAI3z6Esl/duxpoNBtFWH8jD1OmFTp0QoF6gYgFqG9pMRMn3JgUrpBCL0dtonx7UYByTkScN70XGZEB5/J0jBG5TI6Bbznt7WSg18taBGrG2KsSUtO/x6vOYou4JC1JoKIm5vuR65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730103826; c=relaxed/simple;
	bh=VbVGk8yHINzn5tu+DGeibVD9tHHDPBEDnUMANo4xhqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rHPPM6FOO7L8JhbDrIGrrFbQWMQwJ9BnB5KyYLmv33v84iRBcbMrwNRgCPeT92+3XOkkLLwYjBHq5jaRrgUimg7+0ych7VPD9MCkhNeUXOECgsASLvTyTCKJdY53ZEudQ0tZrMqPVzbggMn+uO+hwQChuch4KaGe0xRMEMD+j5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=RXBqu2z/; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (89-186-114-4.pool.digikabel.hu [89.186.114.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: hs@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4534489079;
	Mon, 28 Oct 2024 09:23:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730103823;
	bh=HNvX6ZbwPyB4/shxX6Hc7XKr5awJSCQ19OWnRHT5kcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXBqu2z/Kt6ToKBnoKyDSzXgs0Jw/DH+Hy1YjgSm1AjCTMgfbpvK+HDCnn7rbBawM
	 mSWWzAfCRDNOEJORDK4pA+l3L98IGhoht93LuTaTtZWMCr72QjfSPgKAOYQJXP7z5E
	 YvvrvzvUVeIyRF5nhKjjx1H19xtVHkBSlhF57/THkqTPW5t+/+qucGW4UkGOpEde0N
	 qa+yZSyzssVvJ1oxz7XmhTvAXs1uODo10s2bNEQzOuy9hyEZ5Gr4WpbIOJ0NYNbvLE
	 k098gljQcxfhyWSk3i3RzFV2NcI/BxOc9oJyjXje549x4kWF4I92Q+JzC2NzOx34Ez
	 kKkzi09LrAoIw==
From: Heiko Schocher <hs@denx.de>
To: linux-kernel@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Max Merchel <Max.Merchel@ew.tq-group.com>,
	Michael Walle <mwalle@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: arm: fsl: Add ABB SoM and carrier
Date: Mon, 28 Oct 2024 09:23:31 +0100
Message-Id: <20241028082332.21672-2-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241028082332.21672-1-hs@denx.de>
References: <20241028082332.21672-1-hs@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

add support for the i.MX8MP based SoM and carrier from ABB.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b39a7e031177..96b0eaa3b80f 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1073,6 +1073,8 @@ properties:
       - description: i.MX8MP based Boards
         items:
           - enum:
+              - abb,imx8mp-aristianetos3 # i.MX8MP ABB Board
+              - abb,imx8mp-aristianetos3-som # i.MX8MP ABB Board SoM
               - beacon,imx8mp-beacon-kit  # i.MX8MP Beacon Development Kit
               - dmo,imx8mp-data-modul-edm-sbc # i.MX8MP eDM SBC
               - emcraft,imx8mp-navqp      # i.MX8MP Emcraft Systems NavQ+ Kit
-- 
2.20.1



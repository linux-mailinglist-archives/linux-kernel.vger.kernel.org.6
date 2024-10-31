Return-Path: <linux-kernel+bounces-390047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0069B74E8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285441C219FB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD47C149C7B;
	Thu, 31 Oct 2024 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="gFcok4re"
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD44D148318;
	Thu, 31 Oct 2024 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730358212; cv=none; b=NUiOUqaDJLeTvCrhyjfIKNJ/7/ZURDsRDU8yTTnZYh7UfyKNA8z0h5NY81Cu8df0c9dI/6teRc/PaF5EhPhOT8FqnTMecG0roWDnOwojRdmnP1OCxdcArh5BTSJ4PWtysMeDe47z1PmDBJz02Aul7NKZtclBYHeLtfPLjQLuZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730358212; c=relaxed/simple;
	bh=Os/2HAMdT7ukejERWbP8Yp9xeT6KhRyx6c3PHQ0aWEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbH+8Z4BWugGQGkmK6vnrtvO7gica/sEK8wa2p2LIJ2xTGboGDdgFPNIp8ciZWp757sQrx9P285+SpOFFgr+igKv9SIaCPCg1CbK2NJtxWgkDci3+j+HFPhfi5Dx+V8vARzzRl5JSM6U/NA33ylhHuqA99grwnTAok1HOnw3ros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=gFcok4re; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730358202;
	bh=Os/2HAMdT7ukejERWbP8Yp9xeT6KhRyx6c3PHQ0aWEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gFcok4reqrQOlsc4g8NJc8TQjsUCpiSjgreTa+ZqAuh+0YrcGbuXQKhT3igIykUz0
	 Eyaa7RaLFbO0d3M+cyLw0koMvJB65WLf7zAAvvn9na/OckpChpJ+yOT5jPyZtL81V3
	 6QCSsmeaxE3NGWGBTWEFz58w0JZ4oA8D/I6FVgL8fUuCDC7WuCwq2NNj1lQVcQWTa1
	 B7GD6TnS7r9rR1d0QZpjI+WHNZ9zqPDWo/lXTdQqqNUpsRZZnu5R3vRhAEPt8PceTi
	 zwPr9MSiYwBDoKZcXhm2geD6AYvXk67+k6b48fNrlTmFnRMgziER6z8+Q6qFzwpae8
	 UtXapdSmZABlA==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Parthiban <parthiban@linumiz.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Cody Eksal <masterr3c0rd@epochal.quest>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/13] dt-bindings: phy: sun50i-a64: add a100 compatible
Date: Thu, 31 Oct 2024 04:02:16 -0300
Message-ID: <20241031070232.1793078-4-masterr3c0rd@epochal.quest>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The USB PHY found in the A100 is similar to that found in the D1. Add a
compatible for the A100.

Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in V2:
 - Update binding to allow using the D1 as a compatible.

 .../bindings/phy/allwinner,sun50i-a64-usb-phy.yaml     | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
index f557feca9763..21209126ed00 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
@@ -15,9 +15,13 @@ properties:
     const: 1
 
   compatible:
-    enum:
-      - allwinner,sun20i-d1-usb-phy
-      - allwinner,sun50i-a64-usb-phy
+    oneOf:
+      - enum:
+          - allwinner,sun20i-d1-usb-phy
+          - allwinner,sun50i-a64-usb-phy
+      - items:
+          - const: allwinner,sun50i-a100-usb-phy
+          - const: allwinner,sun20i-d1-usb-phy
 
   reg:
     items:
-- 
2.47.0



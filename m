Return-Path: <linux-kernel+bounces-288047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC7C95322F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D6E1C265C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432FD1AC42C;
	Thu, 15 Aug 2024 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Svv4ptI+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF571A2C0F;
	Thu, 15 Aug 2024 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730516; cv=none; b=rYKYf4/9LjkJBf1lcwFZEVRTVA5X58C+TZIdQyIcYiXOr1ahHuUlcLW6tKZsWh2eW4vel8++CnOIGCnCByFybZcMvzfV27Gd0qjVkzuVIAro8tsaf0cOaBc35gi8I9LQ5ZoMrW04XzuR/VvDUQYiUeBdenzgND5gWxntfRpXMyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730516; c=relaxed/simple;
	bh=KO+CxFioosPhJuOhJwS2XgoaJigS1Scj6/2TKWpq48I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/4h+EvfdQOkfbqxzMta2d8UEHsubs/g7zIckDSAAWSE2OmxiqNaipFxEPKMUIrjGbjQyFaDyWk8oPsvAc0mBIlX9kwegzAoN64QitAX7a2OaSM6n0lVH9I/VVxFaKe/aBDe002W8rq4kMzw78Yd71G0HdSukraGkONHIrv6Mls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Svv4ptI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6D0C4AF0C;
	Thu, 15 Aug 2024 14:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730516;
	bh=KO+CxFioosPhJuOhJwS2XgoaJigS1Scj6/2TKWpq48I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Svv4ptI+SN47Q+ejbZwApr0cv7ZFYRy3RPHiyffYmRomMCfLSvGrOnS+qzj097G9t
	 uOcX2fi2bL0dXTbmEauqb+W0VgLIIs110yaIKomjv4u5I3/hzmcJCJqRSdSRZPKeTQ
	 hBv8Bc1JMsftVBO/qjW+fsi7miOoLoFS5rPmBkqPiBU+2+bkEqc6rwZ7GO6qCFJghM
	 W+bGaY8qbuIakpKBNmJOBP73Rp0j6QUBQLQUCGLgUCJzFBko9zCh/q3BXtZHNmLxjv
	 4jQtsjEtmURSZP4f/ZuCCFt4mNXvHvXlaQ6DF3T/q7YgwNfPJtTTnqOBeDCBFOAiYu
	 00CFeaoznldiA==
From: Conor Dooley <conor@kernel.org>
To: devicetree@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/11] dt-bindings: mfd: syscon document the non simple-mfd syscon on PolarFire SoC
Date: Thu, 15 Aug 2024 15:01:08 +0100
Message-ID: <20240815-jockstrap-unlovable-fc0a745604dc@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815-shindig-bunny-fd42792d638a@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=yoxgUiS5KEsrq0Jq9KVYTtTl2t+HJYVgJhtYs6CJM5A=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGn7uHSqzH5xFyUqKpTt4Vr2SDPvRCy39lTFn/w6q4vzP LtsX8p1lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCIHuhn+yiz94lN7QPbShFU7 zh+11dP2TAxT/nIlOqDtvmHliZ9MnYwMXXJHE56blde9FXYo2raZ5/Bz1sibt2z7a7xzzvaYzNH gBAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The "mss_top_scb" register region on PolarFire SoC contains many
different functions, including controls for the AXI bus and other things
mainly of interest to the bootloader. The interrupt register for the
system controller's mailbox is also in here, which is needed by the
operating system.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 9dc594ea3654..6e6eda8afeed 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -88,6 +88,7 @@ select:
           - mediatek,mt8173-pctl-a-syscfg
           - mediatek,mt8365-syscfg
           - microchip,lan966x-cpu-syscon
+          - microchip,mpfs-sysreg-scb
           - microchip,sam9x60-sfr
           - microchip,sama7g5-ddr3phy
           - mscc,ocelot-cpu-syscon
@@ -183,6 +184,7 @@ properties:
           - mediatek,mt8173-pctl-a-syscfg
           - mediatek,mt8365-syscfg
           - microchip,lan966x-cpu-syscon
+          - microchip,mpfs-sysreg-scb
           - microchip,sam9x60-sfr
           - microchip,sama7g5-ddr3phy
           - mscc,ocelot-cpu-syscon
-- 
2.43.0



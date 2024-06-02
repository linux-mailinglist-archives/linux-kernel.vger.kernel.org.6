Return-Path: <linux-kernel+bounces-198421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58BB8D7804
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57EAE1F22B92
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 20:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769D685631;
	Sun,  2 Jun 2024 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="tTvuGlY2"
Received: from mail-108-mta41.mxroute.com (mail-108-mta41.mxroute.com [136.175.108.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FEB85289
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717359648; cv=none; b=WZAb341X+6s2SZ9fwgHc7gapvXVF1sV5JOzVlWHmqOcLacmQExMvp5MHKutyg5gcQcN8VSPbWytMvMYa5VcfI5wvAa7e1ulG2zIquV53k9stRK+TtZNY9DlhM5o/yuDP4gKq4YSoBB+FV4xSbNoEJZBgdkarlLLeUs6bPBUDzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717359648; c=relaxed/simple;
	bh=liAeCOCis53oq3GtruCxMWUheY7cl+d70gOgO+0PYV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCkrsvEd7BEMFG7scg3YyLCNtNKC3EP3394qHEsCNcp+LWfGVukGbo2T6ktiEXlYu4fn1Z9az6iVO/uWdMx71O0jM5MyuXw2E8hrqpxqex32wPVugc6nFCT4auORQL7EZ9KRqFqg4lke0XdsqfP6kJOLU9HDcUO/SXlz7nCA1IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=tTvuGlY2; arc=none smtp.client-ip=136.175.108.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta41.mxroute.com (ZoneMTA) with ESMTPSA id 18fda96e095000e2b6.011
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 02 Jun 2024 20:14:32 +0000
X-Zone-Loop: 75c7acd39329e6f7cf41883a26bbcba920ac0bdb474e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PzT4xTOEeVDL66kJK8reXjWQ9fp0oEJkeO2UsrLAT0g=; b=tTvuGlY2R/yvA8ERPzoTDtgZ6I
	FUy0FdxvmaYyVNxmLqegOkq+sAY5FHGlaL5r99/LJtJqt+4ZOGkTntUNaz6yHqitfMaNXJ4bNkF+a
	N0jg3DKgq6PiWo3Vs+fhPpasirB2xOeaKKex461ShwZCVntTqceMSG97yJ26hb3gjdd50Zrh2CeLb
	WhPWFupwfjYy89IkpQrMf0aKZkM1NXfJQnlycbOwSD/eebB9DO8fPT4PbqOmSwyD2Xb9ONM1kyO5Q
	PZ9Xp9rxByYL1hlyzqLM6ZqPdYDFGBHHex9XF5jmDSPjf9kj/L1VqBI4GTA3b6kGw/2qMRVbvlECn
	/StAqmRA==;
From: git@luigi311.com
To: linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pavel@ucw.cz,
	phone-devel@vger.kernel.org,
	Luis Garcia <git@luigi311.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 18/23] dt-bindings: media: imx258: Add alternate compatible strings
Date: Sun,  2 Jun 2024 14:13:40 -0600
Message-ID: <20240602201345.328737-19-git@luigi311.com>
In-Reply-To: <20240602201345.328737-1-git@luigi311.com>
References: <20240602201345.328737-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

There are a number of variants of the imx258 modules that can not
be differentiated at runtime, so add compatible strings for the
PDAF variant.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Luis Garcia <git@luigi311.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/i2c/sony,imx258.yaml       | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
index bee61a443b23..c978abc0cdb3 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
@@ -13,11 +13,16 @@ description: |-
   IMX258 is a diagonal 5.867mm (Type 1/3.06) 13 Mega-pixel CMOS active pixel
   type stacked image sensor with a square pixel array of size 4208 x 3120. It
   is programmable through I2C interface.  Image data is sent through MIPI
-  CSI-2.
+  CSI-2. The sensor exists in two different models, a standard variant
+  (IMX258) and a variant with phase detection autofocus (IMX258-PDAF).
+  The camera module does not expose the model through registers, so the
+  exact model needs to be specified.
 
 properties:
   compatible:
-    const: sony,imx258
+    enum:
+      - sony,imx258
+      - sony,imx258-pdaf
 
   assigned-clocks: true
   assigned-clock-parents: true
-- 
2.44.0



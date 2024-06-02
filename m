Return-Path: <linux-kernel+bounces-198419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2D58D7800
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA4D2833C1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 20:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2D48060D;
	Sun,  2 Jun 2024 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="dKXAlCNN"
Received: from mail-108-mta158.mxroute.com (mail-108-mta158.mxroute.com [136.175.108.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664CE77F30
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717359640; cv=none; b=AdbGDk8joLxKSXE9lGomC15141b9X/gLdY02ieFa6ud3YoueuVqaJ3E0Tec07WAoIv35BS29pdSWJrRkOKuRsEuap1+XeZf49HQCvO1jeu3hg+FtIhzj6C97AU31mBl/BJ66XIToaD7wNllmsJ4UDCr3G6lipqDAuUYIlpfPtEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717359640; c=relaxed/simple;
	bh=3GOmMIRHsNVhxdy69UdU/N5ldgNF0c1SP/SadcWTgmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPgxWMVoPTsdDGdhVCQJUOH+HDE1y10Bicj1A11GDVU+u6D9JJCgV9ZK1Q0lXha8p474lrsm2+uGLWDG//bTHPekCAIABwl291sP9DG4/YpzHuQ89zcsS9JnMdQH+HI1IKs0iPswWeNoKPFdGWfd2rvQAj6f7GvWcZwiHD79vHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=dKXAlCNN; arc=none smtp.client-ip=136.175.108.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta158.mxroute.com (ZoneMTA) with ESMTPSA id 18fda96d7b8000e2b6.011
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 02 Jun 2024 20:14:29 +0000
X-Zone-Loop: 1b45c442781ffa48c3bee0c5a15ba20e65279261ebce
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hBpjW4fXJ0RL8rfhZEBmzy5bT//pxdiec10L9b4NGpg=; b=dKXAlCNNS/9BWGwrOWCGxJdDjz
	cJCggiBUzEL6bETspYh1Ldh4ayPz4BzMSnjNTnEKQXEG2n0i+WuHS4q7pOrelMdWPWhGtW4tNgDIw
	4shMVHqKwQ5D87Z0EtRaGfr6xXCKO1ovXWoln1YUCnfIxzdb2tJdGBgqxmLHB8IROfR31g+yY1AAV
	kVhszgzBMcr7OBvkViUlvLsa+4OtL2sTYZDpHFZ0Bx/Wyc1tLl25PETY+aFH6VJA855h7LQbQZguI
	M9mFdiKVtesERTkRte0tw6z2iRhMeJpWKsyk34g7UjJtImAQV8VSluC/TIifPL3sJJjiY/+jOnacu
	itmnfH4Q==;
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
	Conor Dooley <conor.dooley@microchip.com>,
	Luis Garcia <git@luigi311.com>
Subject: [PATCH v6 17/23] dt-bindings: media: imx258: Rename to include vendor prefix
Date: Sun,  2 Jun 2024 14:13:39 -0600
Message-ID: <20240602201345.328737-18-git@luigi311.com>
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

imx258.yaml doesn't include the vendor prefix of sony, so
rename to add it.
Update the id entry and MAINTAINERS to match.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Luis Garcia <git@luigi311.com>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
---
 .../bindings/media/i2c/{imx258.yaml => sony,imx258.yaml}        | 2 +-
 MAINTAINERS                                                     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/media/i2c/{imx258.yaml => sony,imx258.yaml} (97%)

diff --git a/Documentation/devicetree/bindings/media/i2c/imx258.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
similarity index 97%
rename from Documentation/devicetree/bindings/media/i2c/imx258.yaml
rename to Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
index 80d24220baa0..bee61a443b23 100644
--- a/Documentation/devicetree/bindings/media/i2c/imx258.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/media/i2c/imx258.yaml#
+$id: http://devicetree.org/schemas/media/i2c/sony,imx258.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Sony IMX258 13 Mpixel CMOS Digital Image Sensor
diff --git a/MAINTAINERS b/MAINTAINERS
index 8ceb49f1b630..a8c3a531ad39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20489,7 +20489,7 @@ M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
-F:	Documentation/devicetree/bindings/media/i2c/imx258.yaml
+F:	Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
 F:	drivers/media/i2c/imx258.c
 
 SONY IMX274 SENSOR DRIVER
-- 
2.44.0



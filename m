Return-Path: <linux-kernel+bounces-230936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C51918403
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB4A1C22658
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E26185E5F;
	Wed, 26 Jun 2024 14:26:58 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84431822C2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412018; cv=none; b=AW/hIVNlp8XdVYmQORjIbuPP4YLygKcxmVPHik4d3ijWaYLYY8zhq38w83jYl2EVtgnokixw5CT77GsD6q1gOzO/hpDy4fIZSE9TUqx5pTKgmuf8KIsuHwzzh0X16EkvVrd3CYnJbiqsNZ2UtnErsWzA+LC8DbTREEn5zkX5Bro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412018; c=relaxed/simple;
	bh=whpbwhrEakapp6ARSx28pzKavWRe8tqJgMqKz0U+2F4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mPwoR1bX/kZj+SL09PimItty+acn9iZttSgZdeQcHBGylCpZpd1iO9Wqx7Le8E5TGvwFc5jqSI3EpvyvGmEYscLNIyN3zxgA4z/Bwuya+QKqEkhoItECwh1IVsTBKHvua8/+upFYl3iQg6NmYgcpyg7UjOVwCHywk0WqPL1nXU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sMTbk-0005JO-FP; Wed, 26 Jun 2024 16:26:48 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 26 Jun 2024 16:26:48 +0200
Subject: [PATCH] Input: exc3000 - add EXC81W32 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-input-exc3000-exc81w32-v1-1-ac42d3b87aff@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIACclfGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyMz3cy8gtIS3dSKZGMDAwMQbWFYbmyka2oBhEmJJomWFmlKQM0FRal
 pmRVgg6Nja2sB/rBwSWgAAAA=
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.14-dev
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This adds support for EXC81W32 controllers.

Tested with firmware reported as type "PCAP81X32 Series",
model "Orion_0183_1019", fw_version "8001280G".

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../devicetree/bindings/input/touchscreen/eeti,exc3000.yaml        | 1 +
 drivers/input/touchscreen/exc3000.c                                | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
index 9dc25d30a0a8..c299838e2680 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/eeti,exc3000.yaml
@@ -18,6 +18,7 @@ properties:
       - eeti,exc3000
       - eeti,exc80h60
       - eeti,exc80h84
+      - eeti,exc81w32
   reg:
     const: 0x2a
   interrupts:
diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscreen/exc3000.c
index a4030cc9ff60..2e77cfb63f32 100644
--- a/drivers/input/touchscreen/exc3000.c
+++ b/drivers/input/touchscreen/exc3000.c
@@ -53,6 +53,7 @@ enum eeti_dev_id {
 	EETI_EXC3000,
 	EETI_EXC80H60,
 	EETI_EXC80H84,
+	EETI_EXC81W32,
 };
 
 static struct eeti_dev_info exc3000_info[] = {
@@ -68,6 +69,10 @@ static struct eeti_dev_info exc3000_info[] = {
 		.name = "EETI EXC80H84 Touch Screen",
 		.max_xy = SZ_16K - 1,
 	},
+	[EETI_EXC81W32] = {
+		.name = "EETI EXC81W32 Touch Screen",
+		.max_xy = SZ_16K - 1,
+	},
 };
 
 struct exc3000_data {
@@ -441,6 +446,7 @@ static const struct i2c_device_id exc3000_id[] = {
 	{ "exc3000", EETI_EXC3000 },
 	{ "exc80h60", EETI_EXC80H60 },
 	{ "exc80h84", EETI_EXC80H84 },
+	{ "exc81w32", EETI_EXC81W32 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, exc3000_id);
@@ -450,6 +456,7 @@ static const struct of_device_id exc3000_of_match[] = {
 	{ .compatible = "eeti,exc3000", .data = &exc3000_info[EETI_EXC3000] },
 	{ .compatible = "eeti,exc80h60", .data = &exc3000_info[EETI_EXC80H60] },
 	{ .compatible = "eeti,exc80h84", .data = &exc3000_info[EETI_EXC80H84] },
+	{ .compatible = "eeti,exc81w32", .data = &exc3000_info[EETI_EXC81W32] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, exc3000_of_match);

---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240626-input-exc3000-exc81w32-58585ba4a98f

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>



Return-Path: <linux-kernel+bounces-379653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8EC9AE19D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A531F222E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8CD1C4A35;
	Thu, 24 Oct 2024 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HSXJrohl"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049D1B85CB;
	Thu, 24 Oct 2024 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763749; cv=none; b=XdUxnsnxnuXMjH6mFNrah5sFXBMtvTcEGFeCnbgl7gw8e7s6MMkBZrZrNHeJwdOEs/Op8M/wiLKgwJvXeo1J53EpGzkSg2b7GcTjN/D5z2NorqsH6fajziPvKF1WOqTAxx3xNwQI6I3nTPmTe3cFdbZLT7i27X8IgVatAsYVVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763749; c=relaxed/simple;
	bh=3bNuyNqTCqctE1Y5C/z7XLN3NgQXwfflMN0uz3D4eag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcCL/GqZRwd7DUWdHZPwGR5KReK4ycp0S5zv/YBA9tcFmibXsJBokkv9RaxykVaNTNLGiJC5UK9e9ETtPB4hN5gOMPpzHeMzD6wfZWX4BkLjOFW3zmrsoqTFTOaczTIC6D0opg/VDjGMPN1VL33WEd8jQUeySe8WnyvSrooUUm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HSXJrohl; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E355840005;
	Thu, 24 Oct 2024 09:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729763744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=re3k969/SlvgwROLTlKKLvNJkp+Z9Z/HnVPkdFKy4V0=;
	b=HSXJrohlUgJJIsTUV1WUUKYrcz1hc6hgvNNTHiLerynqwjMmPaFJJ85vQgO0b9m7ZOZr6w
	uhQ3lJC5eIGgpogpUccKQ+zSMNvkldQqUjTQuilGbp01Qrv74hayRMkPtOGXgCctEOz2wT
	1dCApNsZ6jHgm1JJz54f25So8fviiujexGIXEz5bQQKS/31mTO7PpUPH+T//COV4qY6mAq
	7uWxQLP8QG7tITqcv5AcrTclk94ixSjVFZn9MwPkMG2Gf5Az9z1c8kNgCqD4AK6Q7RwiH/
	84dBA1vVKzsIIZ13u7iirPNLYuh2o4/WsAyh/uEYTgt3BxxD8xFdd79C1dIn9Q==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 1/2] dt-bindings: display: bridge: sn65dsi83: Add interrupt
Date: Thu, 24 Oct 2024 11:55:37 +0200
Message-ID: <20241024095539.1637280-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241024095539.1637280-1-herve.codina@bootlin.com>
References: <20241024095539.1637280-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Both the TI SN65DSI83 and SN65DSI84 bridges have an IRQ pin to signal
errors using interrupt.

This interrupt is not documented in the binding.

Add the missing interrupts property.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../devicetree/bindings/display/bridge/ti,sn65dsi83.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
index 48a97bb3e2e0..4505d2d83e0d 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
@@ -35,6 +35,9 @@ properties:
   vcc-supply:
     description: A 1.8V power supply (see regulator/regulator.yaml).
 
+  interrupts:
+    maxItems: 1
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
-- 
2.46.2



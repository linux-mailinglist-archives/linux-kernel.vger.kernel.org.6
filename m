Return-Path: <linux-kernel+bounces-529819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125C1A42B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47F73A2194
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36498265CC9;
	Mon, 24 Feb 2025 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="VVrHpcAs"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A260BCA64;
	Mon, 24 Feb 2025 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421575; cv=none; b=dXKOhTI87h0JCvuegcVhTgzyvuniga9YHwXJUTMbiLFuwpEtqux4zwksH0JlX0BcogydHvXHmX2ZPG99gv+eIERRLd9vhtUOQuo9pRzQ+9LEO5GTGcRYLOxJ8n0mu/MgHC1JdB4JDHfIUd4e/FuH/q5O8GPQt1i7ZQFzMe2/tQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421575; c=relaxed/simple;
	bh=fPLzH7LE8mpU0lpFBxI6bTtDCg+LS4q5KJKW0NDcF+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WYagX99A/035o07EKVIlEKe3vuE8akIME78hykB0tZTRiT5Qx4WF1caF8s0HSXfbS448lP23bK7uDZgnZ1jStB6f3hdxIqMqifYsZnMure7PZqFq7gaXjeG2oLGLU11dpkVWf/DuriJCyVM/ckhhDqXmwHs38H+eg1rluYP1G9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=VVrHpcAs; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 923481F989;
	Mon, 24 Feb 2025 19:08:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1740420486;
	bh=mWS9c2cfDFeU9QDimntm/gZ5WTWvS8Fqw7BP//0uZ2w=; h=From:To:Subject;
	b=VVrHpcAsvGj7xi9g1Uubcuetnf5Nm8V36W/ScEMseQRU7h6ar7ZPloeyOjfzqPD1w
	 vaLXkLAXVxsVsT4yztRfAl04FtfUw4PAGQM33HNpSKgqOONwMrXC5WnVEnZFXWyfsj
	 a7uZXqrnknLQ/MSp+VENoHHix8kGOcvZNou0TPCg63l2KdY+0CdJMufCAVNFlH+4Sb
	 +Ma4we4fVfMlnG8ZHc9YhrW0t9HpVX202yiLV6YXgutaK6tbwIIp4R7W11EVz+clsR
	 VK1AZM2v9UOBGbqPZSV2G5DVu1koXPZLI0S+4ZvPrHUWRG59fYAQIJzp/kNIffJaLV
	 otz4Of0mqz3ig==
From: Francesco Dolcini <francesco@dolcini.it>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: hwmon: amc6821: add PWM polarity
Date: Mon, 24 Feb 2025 19:08:00 +0100
Message-Id: <20250224180801.128685-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224180801.128685-1-francesco@dolcini.it>
References: <20250224180801.128685-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add property to describe the PWM-Out pin polarity.

Link: https://www.ti.com/lit/gpn/amc6821
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: no changes
v1: https://lore.kernel.org/all/20250218165633.106867-2-francesco@dolcini.it/
---
 Documentation/devicetree/bindings/hwmon/ti,amc6821.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,amc6821.yaml b/Documentation/devicetree/bindings/hwmon/ti,amc6821.yaml
index 5d33f1a23d03..11604aa41b3e 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,amc6821.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,amc6821.yaml
@@ -28,6 +28,14 @@ properties:
   i2c-mux:
     type: object
 
+  ti,pwm-inverted:
+    type: boolean
+    description:
+      Set to make the PWM-Out pin go high (with an external pull-up resistor)
+      for 100% duty cycle (suitable for driving the fan using a NMOS device),
+      when not set the PWM-Out pin goes low for 100% duty cycle (suitable for
+      driving the fan using a PMOS device).
+
 required:
   - compatible
   - reg
-- 
2.39.5



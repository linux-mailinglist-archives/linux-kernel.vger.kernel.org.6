Return-Path: <linux-kernel+bounces-207867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E92901D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7496D280E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1DB770ED;
	Mon, 10 Jun 2024 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="bIchdf/q"
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313474068;
	Mon, 10 Jun 2024 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.0.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008879; cv=none; b=Dny0MnyIE+NHnx4yrxC4w9V7X5fp/1N4VlAnrExOjufEZkArFbs22xOdXsOKfIrprq8rDlO4MM0A2wCUbHFcNsVtoo81d299JYUAV5fbIBFkePNvv4EOWz8BNQ02Dgh1y89qn2vZmmmdXToflukgBj7nQGvQJEZH/PhCPQnrBYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008879; c=relaxed/simple;
	bh=Rgl/wU6R7ljBF8epw4YZuVxNQeyf2OvzEU669qYabgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WS9c//IWVijje2MzTKUPMrR+wvFRebOcMUrfsJuxtewZ/gxCU6cmfYsJVvDQ1xpNalG0gsKJJ2xHCnHoOGdNVKEq4eukKV+JWO9EAYL9FEsai1ifpsjHIoENvKLUfkYAQCwEh0mO6FHSDdY3qjviqpT+1dasmlslT44scPB/PoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=bIchdf/q; arc=none smtp.client-ip=185.250.0.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 068A6FAF0A;
	Mon, 10 Jun 2024 11:41:10 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1718008876; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=laCP84RUPwmaIblaMPMK69tL2FcMDmuxzvJrD60X/k8=;
	b=bIchdf/q7BDMXH2idoY+0OAhDhWpSb3KcwwiRJ/mjZY+MDx5+DAa/Z26EK16PSO0yS5D5Y
	+jfymK7FpUJy8x3MoQJCnSnuQP8N6foh3vRGNlblNWflmXM6Bdc/YyIYF4DyDB6qkYKJTb
	/2DTLwl9758k08J71y69AEmqxwu3suSP99fLdcC/p5kShJmm6sATjeN/bUCdICXt8AzFjR
	b1phmcmrXw2775Z3WpUezPwTPG/cidIfUlutXKgQTF/A/EtQ3pu1035dmJz2msqkhoPVmv
	uOQn8k7e6nln5cZ6DvJ9wEayzzHvmqieoLt3actzUKgq5TEe6lMCPdKEVJxQWQ==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v5 3/4] dt-bindings: arm: amlogic: amlogic,meson-gx-ao-secure: add secure-monitor property
Date: Mon, 10 Jun 2024 11:39:49 +0300
Message-ID: <20240610084032.3096614-4-adeep@lexina.in>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240610084032.3096614-1-adeep@lexina.in>
References: <20240610084032.3096614-1-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add secure-monitor property to schema for meson-gx-socinfo-sm driver.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 .../bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
index 7dff32f373cb..1128a794ec89 100644
--- a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
@@ -32,6 +32,10 @@ properties:
   reg:
     maxItems: 1
 
+  secure-monitor:
+    description: phandle to the secure-monitor node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
   amlogic,has-chip-id:
     description: |
       A firmware register encodes the SoC type, package and revision
-- 
2.45.2



Return-Path: <linux-kernel+bounces-295374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A26BB959A30
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544131F22DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077D11BF7FA;
	Wed, 21 Aug 2024 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="u967oBSE"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2751BA286;
	Wed, 21 Aug 2024 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238002; cv=none; b=NBN1AglqhiF7/sSvH/1VbdO/9wHok9Xwa40gweOoi1pvws0hBkZ9RON5O7mpjah35GIXVV4fU/Rep3nQruHVAVZWdk7elP9d15liuahZdBfitvyLlTKPWAEP5Csi44HJ9eNc8eU6dKwVnf0ILanKm3o1cWRlR6G52CYFe9TD9u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238002; c=relaxed/simple;
	bh=st6qru0aA6v8gy4EaRFbuG3ZJ7Z30JGYCTim6v6PJus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bw87kbwTXKifg3OuUHaplFqrBTHY/NTscv8KMLSGuni0DxYFHAk0LSlggKk8BHHHeLf3D4adq7NVYfqmAFHMh9uJktcxX7h/k97JRLNZqjxzmHCeOH1l78EwwEJhijYGbpWE7CEyT+3nVz8ZiLa2B8OYX71bhf9AYdL8BvGymFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=u967oBSE; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A25E1483DEE;
	Wed, 21 Aug 2024 12:59:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724237998; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=RxP+7FhQ7B7RR8we2m9jYjfDUkGx0+B+yYzfsV/BxBo=;
	b=u967oBSEa9c1H/goYN6LwJDfcx2Bv3V2fiOhtyYaL4yCT5Wi9smjiEVFExrkMrr9XCMjUS
	B10dLm2dERlXaQDGpl1wL/+neYKyOD3VJLcd3qexBWzsBmEg+TunZjufbC+Nl1rNCiEc3h
	QJeE/oPpP/6xTTdtY3aUamR6t3KrvCXj+hxEl9/sD6R+OB7hlq80MVhOG/ao80ObXbp8ad
	V5YcD2JaR76PTEgPsYU5qhenJZ3lSWYGZMxMuOGJEvv+19C2w5QxnzVMQbwTJgWli5MTj+
	esSeNjR0qKw2e3iYEipyCOsEbYYv5fD3NF9httW/r/UkwwlCD4d+FJZiIkrUFw==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Christian Melki <christian.melki@t2data.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 10/12] ARM: dts: microchip: sam9x60: Add clock properties to OTPC
Date: Wed, 21 Aug 2024 12:59:41 +0200
Message-Id: <20240821105943.230281-11-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821105943.230281-1-ada@thorsis.com>
References: <20240821105943.230281-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This will allow to enable the main RC Oscillator from
nvmem_microchip_otpc driver.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    This requires some DT bindings update, right?

 arch/arm/boot/dts/microchip/sam9x60.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
index 2159a6817f44..4f0651b8cb60 100644
--- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
@@ -162,6 +162,8 @@ otpc: efuse@eff00000 {
 			reg = <0xeff00000 0xec>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			clocks = <&pmc PMC_TYPE_CORE 11>;
+			clock-names = "main_rc_osc";
 		};
 
 		apb {
-- 
2.39.2



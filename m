Return-Path: <linux-kernel+bounces-345757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEE798BAC3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22730B21A6E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2E419DFA3;
	Tue,  1 Oct 2024 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eez4j/xu"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938A81BF333;
	Tue,  1 Oct 2024 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781263; cv=none; b=SUHgOq2Psb2pmF0BnjZ9y/uuHYGeJRrXdMxmabkF4vuwhxcB4CZJT47ueUDXD+LxDGZr/BC60Kf97/90aMaGevXW2BpMAAwSbVjsW4utXpRZkW8Qtx2yjAkjEf2D4BPAMWYQtqyOmvoKpV5t9Qs7d1k/tucbt42k89Fl5/rdKJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781263; c=relaxed/simple;
	bh=7FxJXsJfp8JhH3Bqcg+XlWz/UrVvrEBo+pS963NvkV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YH2tmOX0x0iqQS+C33tAHvQILdv5YRO2Itj4+U3Pju+F8NgMMgJC7mN+oN8LEiDDS6ZOkqXQwVUept8RkmRq+qjvfxtbu4Qj3Y1d2ExQIse2FjBGH8IHVal2d6GM0hB6/ASaZeHP3H9/AoXixUx1EM4Vpws68+gBliQ5vtAB2EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eez4j/xu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-207115e3056so46712335ad.2;
        Tue, 01 Oct 2024 04:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727781262; x=1728386062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OT5UCnEPjLLpr90c+CrdpK+uMQX2+jueZPt0r72UEf4=;
        b=Eez4j/xuMyK7Vq/UTi1ECKP86hlu+QyD1zHix7sg26FNEdx9ypnTBx2KbrnOXQmINe
         t5dxJVmP3qKsW6xHrHsOi6HZzhiQGJ3dEwW2+tcPrXa5EGXCPCFW7QK4qVvyI9lr9aE7
         4HRTvoPOHZkqZDzfDDQZu1XfIW9oT8y/lQwON0agev4MHo+ZHQp+wDAIEB1ysDhc3wy/
         ReG+7MCHTsaDBYWQmvy8x/cRivawd0FPmlRoVvsi/kwDRIt4mA9AcRL6TIwW9UDBF/gJ
         /ScX3k4idmKt8OtXx9khRg+ceoCPrGJ6Ra90SALR4itpm+mhxqydwhiRXf9CJzbyVBfH
         F9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727781262; x=1728386062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OT5UCnEPjLLpr90c+CrdpK+uMQX2+jueZPt0r72UEf4=;
        b=dwTszcmdq73XMATxM/K/vWCjZTd0PDo1clOryML/qs1QAGn8EGV505DNEUFYLDg7Cb
         +D7XTVTCuuOmw8kpGLB9TXTPEhsd+tARhohqPVJ3/B4nBqYPQBU2fsKe2C2efApzAL4Z
         AcLofckFHaxBzdn0n83iHfp0XAYdxo44Z/5RW92dDecxhcCD11L0jnliXBxmndyQQ5Ir
         3T/VtmjwFWY39b4+7lCl4OuIfGs+NdAQrcywlK1GW02manDCuD67q7lCdxGDOTIMt63a
         ir2t4lhD7s6yAfVrCwUb4CPaBRps1SZFCkTirgbHbzRnYjPOhXLSUqkAE4WNFNaNlDrn
         FBxg==
X-Forwarded-Encrypted: i=1; AJvYcCUBh0NZuDmEgkByntB16WcNZ2z/mvMB3wLr/9JIYh/HM4BjgSkIobm9aDujuo1+KLNNhGdOpzPlRNcY@vger.kernel.org, AJvYcCXuV/3yyq2/keU2MMR62KL5wYbjgAKSuBKrvcPi22fwHM7ocfYADjC1XcnYwMDoHXOUmV/ue2WuiD908AnT@vger.kernel.org
X-Gm-Message-State: AOJu0YxHDI033Fdm513LgcnpZ1IpzSyFoawO2cXPT2yJ7AR9Cp7SHa61
	v8AxOpzpFHmZwjMmoFjcRD6OcAgDpt51tFWwfYdttd2m2TJkp90+
X-Google-Smtp-Source: AGHT+IHOM6f3sGG93F8eVyhA2pl035ByC+iSxxxz3C8+SEy6bFjxwX0FBmNrlxTsp7TVsafWO+y+CA==
X-Received: by 2002:a17:902:ced2:b0:20b:7d21:fb8a with SMTP id d9443c01a7336-20b7d2214e8mr86292665ad.61.1727781261799;
        Tue, 01 Oct 2024 04:14:21 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e200f7sm68081405ad.167.2024.10.01.04.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:14:21 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: ti: k3-am62-verdin: Update tla2024 adc compatible
Date: Tue,  1 Oct 2024 08:14:13 -0300
Message-Id: <20241001111413.10390-1-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

With commit f1c9ce0ced2d ("iio: adc: ti-ads1015: Add TLA2024 support") a
new compatible was introduced for TLA2024 ADC. Update the device
tree to use the correct compatible for the Verdin-AM62 hardware.

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 5bef31b8577b..f201722d81b3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -1220,7 +1220,7 @@ sensor@48 {
 	};

 	adc@49 {
-		compatible = "ti,ads1015";
+		compatible = "ti,tla2024";
 		reg = <0x49>;
 		#address-cells = <1>;
 		#size-cells = <0>;
--
2.34.1


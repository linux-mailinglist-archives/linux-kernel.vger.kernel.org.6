Return-Path: <linux-kernel+bounces-517537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB540A3822B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DAA3B512B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDF421A42A;
	Mon, 17 Feb 2025 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VUpGfGaO"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D427219A9F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792619; cv=none; b=IZjNps6e/gIxjeLTkD7ygnxwcDR2ATgX2hZ15XgGvya9qf1CXDBwrGs7Fxw3IDR67CdRhEbedvhQWxS7hXIXfGoIyhVxuuNCXf9Ln2O+G9gG/YG5rIlGA/fZlB2P+LK0IzFUPKaZsN+UsmbHnVDrIGnpHisMZEy3qZ4+N1fuiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792619; c=relaxed/simple;
	bh=d+7O1pW7WIc2OfcTMlCmLP5Nln6iods30Tp5o/hOi2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t0Ny/DqmUK67paMrSkcKgv95MhT4LuI9kzaUbz5W19OVOduFwmOo9e/OMW+VouMHbGc9+cbYIMhpstiWEe1/KlP65CLSOmas6WgVmdACaGLOvfB1/ym2aJKKUe/t3pvrXw6QQ1pOJOZy5pohB0zqZCDkUNyoegvOCJEYJcQYy4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=VUpGfGaO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-439714a799aso17299245e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1739792615; x=1740397415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrzveV3yJfkPYl/HtQGv60ZGdyQJcVgInP4M19o5eMg=;
        b=VUpGfGaOVuARDxDNoqzgIO7AKKYBfEi0v3z1rzUNCByrNx2DpAtPZFGkMkgbmtWpYA
         NC0HHRh4utsMod8md8EUYa7Q13utH7itTJBwBtu40j03DzbbGlR3hHxWxn1S+pMjyLw8
         o17aD6tgOOI1a0rq2knCgx87SGypNXuluw35U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739792615; x=1740397415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrzveV3yJfkPYl/HtQGv60ZGdyQJcVgInP4M19o5eMg=;
        b=Bu1nkFG29r4v3KogHTBIqFyFpXwxML/oJ+7NVurnEr+gileUZhw550bfW0IFi83Ano
         qfUm6pqlbhKzPKgnv7wmframqE9vZuvs9zcf7TtgNA+3BFOIvGknK5g4VGIgm5l5fk4S
         dF83Q1QF9+RwzckHTQoRUthgHx2PBPS5kqSnttsKKsL11gjC+yECzsB2o1UysfWCq1Ku
         wwwwfDDnUmMt3CRNJ2zWk7mlTZ2nHghBJdPBVYa9chKGMwGwDgo799GP4N2iwd5CSPH7
         Nr7ulMszHa4/m6OkfkocZ3rplTh+5QkTzS490EN54GIMTMfZxhpyBaBX0VvlkMcjqLH7
         2e1A==
X-Gm-Message-State: AOJu0YzEbuHJfkZB0hgP/wLEDf0E/AyXJgLEidzp0V5QTm7uxItehbza
	sUFO6+sZFMaGyzJ1QVwKO/ppxcVLtRoqXm0nnZ0hprZEOrMpVlFgHQHzv49wdzIUA1im+PkA2q5
	y
X-Gm-Gg: ASbGncsA7NMt8JN+JUoYj3cxwCNhCLcUKlUd6EaCHFgePMqwhm3fsKRq43EZJggrUNS
	f1TA9VRgMPjhW4v7YIWbp0X6mQwSSk7Q9wpMJfc+l6HJ1qKAqSdUGOtCSo7q5uQf5xiG694HGXU
	y5seUEuwj+EcngHocOm0xSSdFhm72I0bhieWUlDQMxu/oR7RuPNPaAFzSkpT9tfacn0AhQeT+2B
	dUHumq9IomL+A10phoR5ly0YQzfGn+4HyAxxXxGYEaWEU4/93sGW9iqOwjiE9PJ3aPM1tf9SPhm
	BpwUo614F3fuh3e0NhthB91NOfHpsJ2TcfvOErihOPS4wyRrq96eDusDLvDHhUyBWG7/I/kmqDE
	w73/nB4ECZr8=
X-Google-Smtp-Source: AGHT+IF609P3CALKCKzz+rtZjz9vss0xU2nv7oly2Unvy2CCr8jtqlkrTWn26An774F51BMNCDUg9g==
X-Received: by 2002:a05:600d:1b:b0:439:7c0b:13f6 with SMTP id 5b1f17b1804b1-4397c0b19fbmr45089825e9.31.1739792615169;
        Mon, 17 Feb 2025 03:43:35 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:78d7:ec72:38e9:87de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987088ecbsm18918465e9.31.2025.02.17.03.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 03:43:34 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 1/2] ARM: dts: stm32: add led to stm32f746 Discovery board
Date: Mon, 17 Feb 2025 12:43:22 +0100
Message-ID: <20250217114332.1098482-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add node for the user led.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/boot/dts/st/stm32f746-disco.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f746-disco.dts b/arch/arm/boot/dts/st/stm32f746-disco.dts
index 087de6f09629..8bdd10644bf1 100644
--- a/arch/arm/boot/dts/st/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f746-disco.dts
@@ -78,6 +78,14 @@ aliases {
 		serial0 = &usart1;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+		led-usr {
+			gpios = <&gpioi 1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
 	usbotg_hs_phy: usb-phy {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";
-- 
2.43.0



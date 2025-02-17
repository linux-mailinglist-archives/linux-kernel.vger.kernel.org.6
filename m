Return-Path: <linux-kernel+bounces-517541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1DDA38224
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A791885581
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0252219A97;
	Mon, 17 Feb 2025 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pxW2Dmf8"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C719F128
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792719; cv=none; b=WVkSex9wblkeTDhnCX/Y6y8uzX0IS3XPiDqAyIFrpRWfi8RXM0iJF7KqofxvugoLYd9EZH0TidH/lUlK/tYWDjnNAS9+1tRGkjn9CJRfMV6id4iUplA+aYgM5FroI3oIc2pWk5rE2/Dsu12Z/Gwuy5FgC3e2TVkO6XmJzA+HG1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792719; c=relaxed/simple;
	bh=o8xILJ09LYlj4RHvPWNUC2zF7GvZng7IN2WtTiu1ub8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8GZzkjo5PEm649wo39e479Hh9AEpXrAESFnCMD+odsT1PZcR8wVn8WdtHScnk21ggGJNHbGoOibqdaR3frjUsDI7DLghIz6D8fID43oOq6hsKVKrjZVjYzG5jP/hjlYhw9QcFQjtDeHDIAGJE+6FMlw9HMuipFmbRxW7XJujy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=pxW2Dmf8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f2b7ce319so2373450f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1739792716; x=1740397516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4wD4WIcZmxg1bV/511uzbm9dEqsTwVeyjkL26ur+v0E=;
        b=pxW2Dmf8rL6rV+1Baqni/TI7QJaghO9zt9WibP9rGFfePpjneDUHNiONylK4ZkzHMn
         FXqBwdfi/5LxZm6puICNUU0qSC0UDZVaGxXWaKa2i8ZWdAUVXic50dZB256vWVr9G5L2
         Sz5+0jgTMpDQ0VJZbp0DvLGwDA789mMt9Lw00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739792716; x=1740397516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wD4WIcZmxg1bV/511uzbm9dEqsTwVeyjkL26ur+v0E=;
        b=gHA5eYJYEE/8Tx0olXlPWmiXNvonC1e3nNc1wrmM97WcKrv/Hhs8iOj1ItntjbD/vU
         Fdvuzb4WZ7o/3BWZZhMhy7JNN2XhSuS3YOmX9ogcWXc7EC8Z8QKDXFMaNVYz9mOwAE6D
         eZru5hyM6oJucKz/QM2WeC4CUI1HL5c+7Mc5x0ExUJblqU1nXSUEaG/lI9PLpYcVLyO+
         xdyM0EiHhWNKHT+LLPObjIXoysz+sUitZw2ulbhu+AJ9d1n4XfT3bIaoIJRORoIupJRv
         TmTcaiUM29AkbnrN9puJQpfuvWFDLxB8mJOkXCtM0vRyXaI59Cfb9pO0o+e+CSVRvvC8
         O15g==
X-Gm-Message-State: AOJu0YxPyCi9IArNrZg8jLXE4nrHWje+cDOA1SZrw2haMEP1jJEuBS4o
	wKSFCpNwSrdwVVFh732xzb0IFQxPX5YcxzqF1HnV7lBnLKua+rKJAPVtYjd4tV3a7jMKHmqi9xT
	K
X-Gm-Gg: ASbGncs32zjqjTXx1GOHnz+ovGD680cot8p/u4Ni75fNOfUPvP+CveolF/6Ir+ppnWU
	0qjzoRVC5nu86x1h0+W3Dob4icPVh6gzb5aUjRHNf2ql8xn6jPeyV2q6CHaEH7gZaHK3YY0UPlc
	eYuLmM4j8W1dWLl7EstSeV/RF6xDFrNDd1HTxpxmwe1DLvt/dtWZfN+iSuLUqYEVfbOMBRW7qbI
	JG/6XBZoHaqVYAEYJrDjXKmu2VjvWst5Pq2rFM/6+WWaZaxyJ+89WJQAluiF0y7d0PG1fuXB7A+
	Duei7Ts9cP5vsaaSHTZzykt7QbYUIV3tuQsH7f/1G6OEinAjNw+83LY9WzUIE/d/Z4/1oIVjHJB
	vm5w/SK8mduU=
X-Google-Smtp-Source: AGHT+IH4HZR8AI05mEm9pkEq128S5TzlgBTTQQpv9pmG8gm704yEZzj5BkD0hyM6Bc9Lk5oPYaBLNg==
X-Received: by 2002:a5d:470d:0:b0:38f:2a49:f6a5 with SMTP id ffacd0b85a97d-38f33f271c2mr7154894f8f.15.1739792715727;
        Mon, 17 Feb 2025 03:45:15 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:78d7:ec72:38e9:87de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddbe0sm12181637f8f.39.2025.02.17.03.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 03:45:15 -0800 (PST)
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
Subject: [PATCH 1/2] ARM: dts: stm32: rename LEDs nodes for stm32f769-disco
Date: Mon, 17 Feb 2025 12:45:08 +0100
Message-ID: <20250217114513.1098844-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Associate the LED node name with the corresponding board silkscreen for
more precise identification. In fact, the board has a total of seven
LEDs, some of which are user-controllable (i. e. usr{1,2,3}), while
others are directly controlled by hardware (e. g. power, overcurrent,
...). All these LEDs are either green or red, so using the names
led-green and led-red for the two LEDs mapped in the DTS does not
simplify their identification on the board.

Moreover, this patch is a prerequisite for adding the usr3 LED, which
has not been included in the DTS.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/boot/dts/st/stm32f769-disco.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32f769-disco.dts b/arch/arm/boot/dts/st/stm32f769-disco.dts
index 52c5baf58ab9..d52e36aedcfb 100644
--- a/arch/arm/boot/dts/st/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f769-disco.dts
@@ -79,11 +79,11 @@ aliases {
 
 	leds {
 		compatible = "gpio-leds";
-		led-green {
+		led-usr2 {
 			gpios = <&gpioj 5 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
-		led-red {
+		led-usr1 {
 			gpios = <&gpioj 13 GPIO_ACTIVE_HIGH>;
 		};
 	};
-- 
2.43.0



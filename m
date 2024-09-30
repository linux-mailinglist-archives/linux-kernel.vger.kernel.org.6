Return-Path: <linux-kernel+bounces-344800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEE498AE59
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B632F280D48
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7C91A3058;
	Mon, 30 Sep 2024 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVKt8J4s"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29EC1A2630;
	Mon, 30 Sep 2024 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728029; cv=none; b=ezxuGSOugdusIDQDYkBTMms4UIn+lwLIfUnl5c+Vw0KNrejc//E7vibVdibW7nofwwKDa8nS8Klw0Il+3cAVxZX9+EXzyO4jQRAMHGatyzB92vSs//KuHp/tl71PX78v5mRNI/NBKsJR55ViSCqu9D8P2rjc+HHFCba67+8NCz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728029; c=relaxed/simple;
	bh=7XX1i+SbT4SYl4k59Ql6NGxzt6dwDUFFukwGZiQqVy0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=txEGPqFXZNx4WExnEt37e3LZKn26ZOAPdaiUwt7zENYPlDD48DvGyuaj4w3qJmT1st0VOT9TnDqb0eRq733CqmLjoNBZh102bnp/JsKiG5JYA089dIvl+ZM2m4S1RkXR2ruXiSB7UTUYyQgxKLrMb6P+xYgaio0a3+R6b1M2Lmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVKt8J4s; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e2772f7df9so11449887b3.2;
        Mon, 30 Sep 2024 13:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727728027; x=1728332827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EY+WLrQgjCPEvSE7PizmLu5iygZ73i+tPtZS7VjtmHI=;
        b=CVKt8J4sVJx81GLVV0LOOwdBbfZxuKJpdUgpfhDdIxZij34KBdNRfSS8L2bB7TnPdD
         xPeMbDUvYR1k71PYXG5pyOpgi0ZG5PdJtEnn/RmkX84niaj8vasXRdCFnUtVUGR58A55
         16ZrsmVqUbw8UnhXYS7Fi6JlCUGHfp8T+JZfbP4pxtIjAVa6Uo/P/S5oHLUFrn1FY0sV
         YsatgmWtQT7mLHgQR4b0aV7/rUZ145thqUkAwBZ0b5WD1eHDerRCCy8i9biBo7hPoEpV
         FytDIaF7fL4Z7ivfUXsCdW6k/8o53QMyf/S3Jsorcrk2YxqUQzs6iq7E6iA0ROWASgLI
         O7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727728027; x=1728332827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EY+WLrQgjCPEvSE7PizmLu5iygZ73i+tPtZS7VjtmHI=;
        b=dEb3yQYNcl7B7jtbc26WG5TSDMwRQUqV7KOW0in9uX7QFYitj8VpTowovSBHpsu1As
         FCsaZRXaYzLfLEnxNeRNJiNh8mMrSbyzhTRZT+khR5hyMxmxgjU61qDKaBOpVxOjdDuT
         cIzkYcHHU04JSBdozcA5sfDyyShdS35ltwqDkANsbf83x6YTFlv4c8aS0B9OGy9iQYwX
         uIuIWGf30w+6lABXHAdz5RBUltDM/j3STS3V1wUF2wAd7NZCORpVPHszQYoiTN3P/pPv
         bHu2UDL/abIKgn4ADw2+BxOoL4iAesvRuQH0dL3rHBGuBl0aLn3Lqk1js90LH0nfZnHe
         kKKg==
X-Forwarded-Encrypted: i=1; AJvYcCVnzOIYPPuLdwf+K0RSs1I+nPCojYs8rm0lVx067xkJnPUExYD2E9Ve5ugB2OqXOn8pldrWEIZnrCCIW0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOhJywNhsngtNptLasWVyHpgt1rqE+RMTkfMCQ6WbdgAzeOv/c
	07CL8dQOtw+qE8RBAnZ/JIoMwGhwWlPczZsJgigB7J/cKAii0nA=
X-Google-Smtp-Source: AGHT+IFZlK8RBJc2v0ohd2jAmkSwJ+MS4VIw9LwKpXn3CxkvbmgCxvIHGr3QggG3fHHOIAXjX7bTLg==
X-Received: by 2002:a05:690c:6001:b0:6db:d7c9:c97b with SMTP id 00721157ae682-6e2475f9fa6mr102597097b3.40.1727728026616;
        Mon, 30 Sep 2024 13:27:06 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:118f:ec2d:6ca4:5df0:327c:8c2e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2453292f5sm15726007b3.72.2024.09.30.13.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:27:06 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: claudiu.beznea@tuxon.dev,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	conor+dt@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH] ARM: dts: microchip: sam9x7: Add missing usart-mode property
Date: Mon, 30 Sep 2024 22:26:39 +0200
Message-Id: <20240930202639.37606-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the atmel,usart-mode property to UART nodes in Microchip SAM9X75
boards' device trees (boards which inherit sam9x7.dtsi). This ensures
compliance with the atmel at91-usart.yaml schema and resolves errors
that occur during DT validation, such as:

arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb: serial@200:
serial@200' does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$'
from schema: http://devicetree.org/schemas/serial/atmel,at91-usart.yaml#

arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb:
serial@200: atmel,use-dma-rx: False schema does not allow True
from schema: http://devicetree.org/schemas/serial/atmel,at91-usart.yaml#

arch/arm/boot/dts/microchip/at91-sam9x75_curiosity.dtb:
serial@200: atmel,fifo-size: False schema does not allow 16
from schema: http://devicetree.org/schemas/serial/atmel,at91-usart.yaml#


By adding "atmel,usart-mode = <AT91_USART_MODE_SERIAL>" to UART nodes
0 up until 12, these errors are resolved, ensuring proper DTB validation.

This issue has been tested on the sam9x75 (sam9x75eb & sam9x75_curiosity)
boards, both of which inherit the sam9x7.dtsi file.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 arch/arm/boot/dts/microchip/sam9x7.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sam9x7.dtsi b/arch/arm/boot/dts/microchip/sam9x7.dtsi
index 29950159bb94..d3f7238eda85 100644
--- a/arch/arm/boot/dts/microchip/sam9x7.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x7.dtsi
@@ -166,6 +166,7 @@ flx4: flexcom@f0000000 {
 			uart4: serial@200 {
 				compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -234,6 +235,7 @@ flx5: flexcom@f0004000 {
 			uart5: serial@200 {
 				compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -375,6 +377,7 @@ flx11: flexcom@f0020000 {
 			uart11: serial@200 {
 				compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -424,6 +427,7 @@ flx12: flexcom@f0024000 {
 			uart12: serial@200 {
 				compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -595,6 +599,7 @@ flx6: flexcom@f8010000 {
 			uart6: serial@200 {
 				compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -644,6 +649,7 @@ flx7: flexcom@f8014000 {
 			uart7: serial@200 {
 				compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -693,6 +699,7 @@ flx8: flexcom@f8018000 {
 			uart8: serial@200 {
 				compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -742,6 +749,7 @@ flx0: flexcom@f801c000 {
 			uart0: serial@200 {
 				compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -810,6 +818,7 @@ flx1: flexcom@f8020000 {
 			uart1: serial@200 {
 				compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -878,6 +887,7 @@ flx2: flexcom@f8024000 {
 			uart2: serial@200 {
 				compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -946,6 +956,7 @@ flx3: flexcom@f8028000 {
 			uart3: serial@200 {
 				compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -1067,6 +1078,7 @@ flx9: flexcom@f8040000 {
 			uart9: serial@200 {
 				compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
@@ -1116,6 +1128,7 @@ flx10: flexcom@f8044000 {
 			uart10: serial@200 {
 				compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) |
-- 
2.39.2



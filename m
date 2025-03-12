Return-Path: <linux-kernel+bounces-558340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A96A5E48D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95713AD32B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973312586E7;
	Wed, 12 Mar 2025 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="gt7FamQ2";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="QXCgkYUd"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEF11F461D;
	Wed, 12 Mar 2025 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808212; cv=pass; b=NhnBFaGBz2sbEcQYidWfxyczwGlPQegb+em7vZ/jf3MyLgQSaQWZzU26JaJ8qCxuPC33UOH/L1Ky/FBKv9+U5zZYFNEZSFZw3YCY/gWU2tzHwJ/4qU9SK3nk8m1fxtHD+TTmjF+gN84RQGgIThQYTDJqMe2BziUNO1lfQVQf2IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808212; c=relaxed/simple;
	bh=JGvc9t6eH0Disvyp4YztNchToLyen6Ed5SE8DsNC68M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHWotVAVTEeNuTNBKfYSoHYXTdwVucMRSptv5WSgVXW/PkWjOFF5NBn4NQcBfBsgB5r6vsu2VE5GFTu7bPcTiQadJ9+dt+MExfUgIgfy8GYNItdBpte/AU0zNKOefjx6j84MfBUr1kaGU2a7Z8HJdyNJ04Sl67QsNpx8vlW6to4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=gt7FamQ2; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=QXCgkYUd; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1741808199; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bZTM+TpNLvX2TTB1x5D6nVm6z3UwFgMWiNrpQs3N9yxuoKqt+C2OsafUxoMUxcNvv+
    6S7vy+rlJ4cLs9mgc9X2cKmG4MFPLfnemMypjdrmy1zzV0dtVo1KS0ggGdswLcV4dZjm
    Pm/34Xw5+//hUhdMINtRAkHLoRcN6YS2mWbIxUo7IP3wnTYVYhAG1//WC5jFDGej76Ea
    rE0Ti/CQDgYtgMDE5YOq/C9DPvBHfVrZEBG5nW65zRiNE7Qd5W7ioQQYBWFHU7ryqaPl
    WhtGczY05021riCyXNXTJrlzEGb9x3bVGUl4XrwBQnb3yAh4zQF3LdG1CMMcUDtCVZga
    h28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1741808199;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=lxcMHEKMN0k1o6vOkcWOO4z96etmbwK9XpxIauqtEzg=;
    b=P1GfOOwvi1B3JVUQyFFdHAYDNy9n41E4PEttx23NEaO9+OU3aA0HO+GrIxi9IF9cDP
    OVkvp8Y59XpGnDMvgVEgdNtWeDIsO5rhQ+XuhG77rM5PQOcmJJS8OLFKVCbAU8eHdOkO
    RaSASdQAyj2YcqwKb402KS3agLPFlgrO405H4Q59pZI6kwwUo4h42AsoewzIeKnXonLv
    Cj8xCAXiCPsjJP12JdrHbyy3eRjBZRo2m/2dfnlDIxtr9eSyQWGWezGPMCvm1DcQF8wt
    wskJYhnn2psGKiDRye0oCg/MqdmsGhaW+BU0NnTeWwMuJkK17EoXNlN84IPduhdOi/I0
    1C4g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1741808199;
    s=strato-dkim-0002; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=lxcMHEKMN0k1o6vOkcWOO4z96etmbwK9XpxIauqtEzg=;
    b=gt7FamQ25ZzxZ9sFrcg90bxaAuhAk3yFKTmHvQpXB7PGw0AWpXTRaG+VsrWAqE4N8T
    IiXeuHlnfLQ0pIakXdNHDK/Wlv3NNFhUlL07lSENxJFHEa16TTTIy7g4RYF55gAwOXyL
    Wmkt0I0aWVFw7TuQP9wkE9w6oNSswAwRrufUefDM3RRA2c1oDP3nOotH0j+nYHNMhHGq
    qFoXTJ/+gCMvpu5xoWqc76bEaNVryl0G8XX+X6y3zAzPmbTaUPCFj3TEEt/hlj2dUYqR
    x3UXFdl2AhKHz96xTvLqhDPHrx8xQwUTBC0zy+hHkF9Ol4NFCKKgQi4tsWf3SXxq9HtN
    Pmgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1741808199;
    s=strato-dkim-0003; d=fossekall.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=lxcMHEKMN0k1o6vOkcWOO4z96etmbwK9XpxIauqtEzg=;
    b=QXCgkYUdfs/CwX/mn9IEzU6DJkDIHTl1S+jLKvYoa9PAtq9eHaOt99/9NnnAVjfTVR
    P1TuhcYisDn2Thgo0WAQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512CJackg5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 12 Mar 2025 20:36:38 +0100 (CET)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1tsRsb-00058E-1Q;
	Wed, 12 Mar 2025 20:36:37 +0100
Received: (nullmailer pid 85457 invoked by uid 502);
	Wed, 12 Mar 2025 19:36:37 -0000
From: Michael Klein <michael@fossekall.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Cc: Michael Klein <michael@fossekall.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: bananapi: add support for PHY LEDs
Date: Wed, 12 Mar 2025 20:36:28 +0100
Message-Id: <20250312193629.85417-2-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250312193629.85417-1-michael@fossekall.de>
References: <20250312193629.85417-1-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The Bananapi M1 has three LEDs connected to the RTL8211E ethernet PHY.
Add the corresponding nodes to the device tree.

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 .../boot/dts/allwinner/sun7i-a20-bananapi.dts | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts
index 46ecf9db2324..4976453ed192 100644
--- a/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts
@@ -48,6 +48,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "LeMaker Banana Pi";
@@ -169,6 +170,32 @@ &ir0 {
 &gmac_mdio {
 	phy1: ethernet-phy@1 {
 		reg = <1>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_GREEN>;
+				default-state = "keep";
+				linux,default-trigger = "netdev";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_AMBER>;
+				default-state = "keep";
+				linux,default-trigger = "netdev";
+			};
+
+			led@2 {
+				reg = <2>;
+				color = <LED_COLOR_ID_BLUE>;
+				default-state = "keep";
+				linux,default-trigger = "netdev";
+			};
+		};
 	};
 };
 
-- 
2.39.5



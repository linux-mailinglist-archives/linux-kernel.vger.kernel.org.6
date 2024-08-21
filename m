Return-Path: <linux-kernel+bounces-294916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEA8959443
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A012855BF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6623216B39E;
	Wed, 21 Aug 2024 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="K6vxd4Ok"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FDE1547D4;
	Wed, 21 Aug 2024 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724219515; cv=none; b=d6iWdGYf/8tCD3EmLMy2uQmuTPu+7AD1jZ9rBd8Ai6MN0BiYBOF10REYFLDsmgh4mmR7giB7IG5PNo0bzARCYvcIaG3anxYqmMZW9bUNhoBdjxpnDIQz9L36Gdj6iUTMhkDw5X5YLXOyPn6biHDza01zesxj1RkBULr0ZODJD0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724219515; c=relaxed/simple;
	bh=SGZVWHE/rNJaT6VTyLe9HtJE1mXikZC/TCYeZV5ZLVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1utZUKPfwP5ZR1KBNef1+Zhqu2ahC3eQzP8Cvs99GtKZ7rETPBMBbM7vUALYL2RXE1Wnw126/nwlglZ/lgo1iVJXoTBu7FMmjXgerC4cpvUjmd8MiaJT99nhiy4I0y5bMUhi9+lKhQDMAoVvjGC0GX8JxYs1wLCGnuNqcGZfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=K6vxd4Ok; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C22361487F9C;
	Wed, 21 Aug 2024 07:51:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724219503; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DWzPwgcZoX1s68hJAPgZlTk8e2myy4m4ZaSsHQWStoM=;
	b=K6vxd4Ok3tMNWRdNQsL/OfpE9z3SBSfxfmBUbEctkSqxaCp39DvAlvSPK7o3P09jwoux3e
	Sw7z3NEbKhcAqIO6ATWO7LQOwWo01wVD3x3q5behGzOm4gC3CzjdlG0j9ugIJa3tfIVEGJ
	7UiUxnkFI64HG4k3VLFld4wQtdeVOTHj+Mk533WgnOqzAy4zr0nheYMGDJ8aSU+3atsgVh
	kIfQ26VZMcy/T7CxMtXPgjhkuH8s0hAgFtlveh4yme54AywSOLZ9AY2hG0shmQzwnU9rl9
	OeBphabwmtxxRBzTQ0BzdiQXZB0wFFc4svv8v5s6fDhRkgldHI4tQCb5PVMeeQ==
From: Alexander Dahl <ada@thorsis.com>
To: linux-clk@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
	Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ARM: dts: microchip: sam9x60: Fix rtc/rtt clocks
Date: Wed, 21 Aug 2024 07:51:36 +0200
Message-Id: <20240821055136.6858-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240820132730.357347-1-ada@thorsis.com>
References: <20240820132730.357347-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The RTC and RTT peripherals use the "timing domain slow clock (TD_SLCK),
sourced from the 32.768 kHz crystal oscillator.

(The previously used Monitoring domain slow clock (MD_SLCK) is sourced
from an internal RC oscillator which is most probably not precise enough
for real time clock purposes.)

Fixes: 1e5f532c2737 ("ARM: dts: at91: sam9x60: add device tree for soc and board")
Fixes: 5f6b33f46346 ("ARM: dts: sam9x60: add rtt")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    Picked the wrong patch in the first try.  This v2 one has a slightly
    adapted commit message and more context below.
    
    This obviously requires a 32.768 kHz crystal oscillator to be present,
    but the sam9x60.dtsi does contain that, and the clock-controllers
    reference that, so I assume it's always present.
    
    /sys/kernel/debug/clk/clk_summary content excerpt before:
    
         slow_rc_osc                         1       1        0        32768       93750000   0     50000      Y   deviceless                      no_connection_id
            md_slck                          4       4        0        32768       0          0     50000      Y      fffffea8.rtc                    no_connection_id
                                                                                                                      fffffe20.rtc                    no_connection_id
                                                                                                                      fffffe10.poweroff               no_connection_id
                                                                                                                      fffffe00.reset-controller       no_connection_id
                                                                                                                      timer@f8008000                  slow_clk
                                                                                                                      deviceless                      no_connection_id
    …
         slow_xtal                           0       0        0        32768       0          0     50000      Y   deviceless                      no_connection_id
            slow_osc                         0       0        0        32768       0          0     50000      Y      deviceless                      no_connection_id
               td_slck                       0       0        0        32768       0          0     50000      Y         deviceless                      no_connection_id
    
    And after:
    
         slow_rc_osc                         1       1        0        32768       93750000   0     50000      Y   deviceless                      no_connection_id
            md_slck                          2       2        0        32768       0          0     50000      Y      fffffe10.poweroff               no_connection_id
                                                                                                                      fffffe00.reset-controller       no_connection_id
                                                                                                                      timer@f8008000                  slow_clk
                                                                                                                      deviceless                      no_connection_id
    …
         slow_xtal                           1       1        0        32768       0          0     50000      Y   deviceless                      no_connection_id
            slow_osc                         1       1        0        32768       0          0     50000      Y      deviceless                      no_connection_id
               td_slck                       2       2        0        32768       0          0     50000      Y         fffffea8.rtc                    no_connection_id
                                                                                                                         fffffe20.rtc                    no_connection_id
                                                                                                                         deviceless                      no_connection_id

 arch/arm/boot/dts/microchip/sam9x60.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
index 291540e5d81e..d077afd5024d 100644
--- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
@@ -1312,7 +1312,7 @@ rtt: rtc@fffffe20 {
 				compatible = "microchip,sam9x60-rtt", "atmel,at91sam9260-rtt";
 				reg = <0xfffffe20 0x20>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&clk32k 0>;
+				clocks = <&clk32k 1>;
 			};
 
 			pit: timer@fffffe40 {
@@ -1338,7 +1338,7 @@ rtc: rtc@fffffea8 {
 				compatible = "microchip,sam9x60-rtc", "atmel,at91sam9x5-rtc";
 				reg = <0xfffffea8 0x100>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-				clocks = <&clk32k 0>;
+				clocks = <&clk32k 1>;
 			};
 
 			watchdog: watchdog@ffffff80 {

base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
-- 
2.39.2



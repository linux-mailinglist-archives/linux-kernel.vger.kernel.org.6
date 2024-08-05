Return-Path: <linux-kernel+bounces-275104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B599480A4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA4C280EF1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C86A15F330;
	Mon,  5 Aug 2024 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFzboOfc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB1481B9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879877; cv=none; b=A2KiLELgBAMVnVHpuVt3JJGSifMzlkpW8/E18VHcjgcDLpXEtzzLOXrn8v52+VGJYM3sjlEWLVaeSzVB240osUbwze+y1AgrNVuW/UPbVMADzQmUiNKBAgZHNZQFK4ZqJx/0197oKQwAxtcUpMmklDFfEBvRKaPX0ldWZbvjn+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879877; c=relaxed/simple;
	bh=aW7sdQAfUYelcSjYlOp/AM4kUFrnoILrNxfz7quBevo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=FWTpS7fIyRIXWUC1mslzgaokZdeHJrH0n8iYK9lIYtYn/EiIsLCPuI1Jwbtevtr9UBZmWFcmiM6cpEQ3zL+fSvefufIJSg9EdwMLMMMtI3aOlc7/en+/f5/OPeYIOn/L/6uT/3CI8UeN9SblFIjHf4qBgbNQzz2NpRBgvsC0yJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFzboOfc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722879873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=in3v0c9+Ovml4ykztWb8OrUnybcqrtY0gPAUUXpjpCg=;
	b=QFzboOfcrVNr0nnzuCwTbk6tEAlzlGGXN9xWOs4p9TheBlNW9WKvXWw5xtiYwLhIMHjiQP
	UzJ/7tidu0rCgtT36FaaofPSXbBinn2bwntK7iAypC5+HkGC3vGSWOaASt/24XWXwm3pEA
	Cu9Jw5eeLYuLU5BbYOeXyoxPcntwf1k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-PNSpnUvzNyCEUVf0jCdvwQ-1; Mon, 05 Aug 2024 13:44:32 -0400
X-MC-Unique: PNSpnUvzNyCEUVf0jCdvwQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a1d4335cceso1167558985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722879872; x=1723484672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=in3v0c9+Ovml4ykztWb8OrUnybcqrtY0gPAUUXpjpCg=;
        b=wianKGYFILy8EB6j+2ctNyyzUMsKbFMWaxVKxSz+okxS+2XtLLTvojArADmWFHPhSY
         zHaG3tzfgEk63VaFL4n0jIpOiI5lSV2yyPNsTfixKkegIrZL0DFWGLCR/D4LIZ1+SFvX
         3f5WXPbxKLjsfEGE9N4Q3uoBEQYcAHPHBPJn5me1Ni+5cEHWa5LjVB00IsjJrEKC/52a
         Sg1F4oOlo1Sl5Twa6nhyJL5Ghrheph2Nzg94EfAb2r+v66nTrvJixifLvuVwZDmnd6OQ
         zBaqeYe09t9awHWsk34nrBP9XPotOyDxIxdciKJMzWpwzvPztTgWbJEKU8NHnYU3fZBw
         GSVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3QgkR0lLEjXLLf87yUdwzfVqxUewAJipM7DFlLzJ4RUH8t8JNE71YuNUVJiMN4tXfIIfrDy1C6uxCDrQ8crwLuFGKK1ZXhzidL2Uf
X-Gm-Message-State: AOJu0Yx0OQ8rZq1MFrRoaJxcMPQMnetHpDeR3zp6LbzPDUyGvdjg7NIv
	siPRxgb8YkaVtdkv4wMj3xsBtswufTSs22DAJ6x3AF2p1Vdw7J33OZrdABU0R2/GCtpSn+N+T3t
	6h5vrpXntpXIHGOnLF9tNJe0Zw9PEiAlDLapQKZG/82CQ46DUZ3ptKp5UCLn+bg==
X-Received: by 2002:a05:620a:29d4:b0:79e:f932:7ca7 with SMTP id af79cd13be357-7a34f0001a0mr2056479885a.29.1722879871650;
        Mon, 05 Aug 2024 10:44:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmcU76OAYHJ/RqLSfBF2eTd4UvIYfVkWbCUA8e7kym6xJ1NXMxJMBazTzvelP7eNmYWvFU3g==
X-Received: by 2002:a05:620a:29d4:b0:79e:f932:7ca7 with SMTP id af79cd13be357-7a34f0001a0mr2056461885a.29.1722879869599;
        Mon, 05 Aug 2024 10:44:29 -0700 (PDT)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f773abdsm373597185a.72.2024.08.05.10.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:44:29 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Chanudet <echanude@redhat.com>,
	Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH] arm64: dts: ti: k3-j784s4-main: align watchdog clocks
Date: Mon,  5 Aug 2024 13:42:51 -0400
Message-ID: <20240805174330.2132717-2-echanude@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

assigned-clock sets DEV_RTIx_RTI_CLK(id:0) whereas clocks sets
DEV_RTIx_RTI_CLK_PARENT_GLUELOGIC_HFOSC0_CLKOUT(id:1)[1]. This does not
look right, the timers in the driver assume a max frequency of 32kHz for
the heartbeat (HFOSC0 is 19.2MHz on j784s4-evm).

With this change, WDIOC_GETTIMELEFT return coherent time left
(DEFAULT_HEARTBEAT=60, reports 60s upon opening the cdev).

[1] http://downloads.ti.com/tisci/esd/latest/5_soc_doc/j784s4/clocks.html#clocks-for-rti0-device

Fixes: caae599de8c6 ("arm64: dts: ti: k3-j784s4-main: Add the main domain watchdog instances")
Suggested-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
I could not get the watchdog to do more than reporting 0x32 in
RTIWDSTATUS. Setting RTIWWDRXCTRL[0:3] to generate a reset instead of an
interrupt (0x5) didn't trigger a reset either when the window expired.

 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 38 +++++++++++-----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index f170f80f00c1..6c014d335f2c 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -2429,7 +2429,7 @@ main_esm: esm@700000 {
 	watchdog0: watchdog@2200000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x2200000 0x00 0x100>;
-		clocks = <&k3_clks 348 1>;
+		clocks = <&k3_clks 348 0>;
 		power-domains = <&k3_pds 348 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 348 0>;
 		assigned-clock-parents = <&k3_clks 348 4>;
@@ -2438,7 +2438,7 @@ watchdog0: watchdog@2200000 {
 	watchdog1: watchdog@2210000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x2210000 0x00 0x100>;
-		clocks = <&k3_clks 349 1>;
+		clocks = <&k3_clks 349 0>;
 		power-domains = <&k3_pds 349 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 349 0>;
 		assigned-clock-parents = <&k3_clks 349 4>;
@@ -2447,7 +2447,7 @@ watchdog1: watchdog@2210000 {
 	watchdog2: watchdog@2220000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x2220000 0x00 0x100>;
-		clocks = <&k3_clks 350 1>;
+		clocks = <&k3_clks 350 0>;
 		power-domains = <&k3_pds 350 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 350 0>;
 		assigned-clock-parents = <&k3_clks 350 4>;
@@ -2456,7 +2456,7 @@ watchdog2: watchdog@2220000 {
 	watchdog3: watchdog@2230000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x2230000 0x00 0x100>;
-		clocks = <&k3_clks 351 1>;
+		clocks = <&k3_clks 351 0>;
 		power-domains = <&k3_pds 351 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 351 0>;
 		assigned-clock-parents = <&k3_clks 351 4>;
@@ -2465,7 +2465,7 @@ watchdog3: watchdog@2230000 {
 	watchdog4: watchdog@2240000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x2240000 0x00 0x100>;
-		clocks = <&k3_clks 352 1>;
+		clocks = <&k3_clks 352 0>;
 		power-domains = <&k3_pds 352 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 352 0>;
 		assigned-clock-parents = <&k3_clks 352 4>;
@@ -2474,7 +2474,7 @@ watchdog4: watchdog@2240000 {
 	watchdog5: watchdog@2250000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x2250000 0x00 0x100>;
-		clocks = <&k3_clks 353 1>;
+		clocks = <&k3_clks 353 0>;
 		power-domains = <&k3_pds 353 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 353 0>;
 		assigned-clock-parents = <&k3_clks 353 4>;
@@ -2483,7 +2483,7 @@ watchdog5: watchdog@2250000 {
 	watchdog6: watchdog@2260000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x2260000 0x00 0x100>;
-		clocks = <&k3_clks 354 1>;
+		clocks = <&k3_clks 354 0>;
 		power-domains = <&k3_pds 354 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 354 0>;
 		assigned-clock-parents = <&k3_clks 354 4>;
@@ -2492,7 +2492,7 @@ watchdog6: watchdog@2260000 {
 	watchdog7: watchdog@2270000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x2270000 0x00 0x100>;
-		clocks = <&k3_clks 355 1>;
+		clocks = <&k3_clks 355 0>;
 		power-domains = <&k3_pds 355 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 355 0>;
 		assigned-clock-parents = <&k3_clks 355 4>;
@@ -2506,7 +2506,7 @@ watchdog7: watchdog@2270000 {
 	watchdog8: watchdog@22f0000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x22f0000 0x00 0x100>;
-		clocks = <&k3_clks 360 1>;
+		clocks = <&k3_clks 360 0>;
 		power-domains = <&k3_pds 360 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 360 0>;
 		assigned-clock-parents = <&k3_clks 360 4>;
@@ -2517,7 +2517,7 @@ watchdog8: watchdog@22f0000 {
 	watchdog9: watchdog@2300000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x2300000 0x00 0x100>;
-		clocks = <&k3_clks 356 1>;
+		clocks = <&k3_clks 356 0>;
 		power-domains = <&k3_pds 356 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 356 0>;
 		assigned-clock-parents = <&k3_clks 356 4>;
@@ -2528,7 +2528,7 @@ watchdog9: watchdog@2300000 {
 	watchdog10: watchdog@2310000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x2310000 0x00 0x100>;
-		clocks = <&k3_clks 357 1>;
+		clocks = <&k3_clks 357 0>;
 		power-domains = <&k3_pds 357 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 357 0>;
 		assigned-clock-parents = <&k3_clks 357 4>;
@@ -2539,7 +2539,7 @@ watchdog10: watchdog@2310000 {
 	watchdog11: watchdog@2320000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x2320000 0x00 0x100>;
-		clocks = <&k3_clks 358 1>;
+		clocks = <&k3_clks 358 0>;
 		power-domains = <&k3_pds 358 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 358 0>;
 		assigned-clock-parents = <&k3_clks 358 4>;
@@ -2550,7 +2550,7 @@ watchdog11: watchdog@2320000 {
 	watchdog12: watchdog@2330000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x2330000 0x00 0x100>;
-		clocks = <&k3_clks 359 1>;
+		clocks = <&k3_clks 359 0>;
 		power-domains = <&k3_pds 359 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 359 0>;
 		assigned-clock-parents = <&k3_clks 359 4>;
@@ -2561,7 +2561,7 @@ watchdog12: watchdog@2330000 {
 	watchdog13: watchdog@23c0000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x23c0000 0x00 0x100>;
-		clocks = <&k3_clks 361 1>;
+		clocks = <&k3_clks 361 0>;
 		power-domains = <&k3_pds 361 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 361 0>;
 		assigned-clock-parents = <&k3_clks 361 4>;
@@ -2572,7 +2572,7 @@ watchdog13: watchdog@23c0000 {
 	watchdog14: watchdog@23d0000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x23d0000 0x00 0x100>;
-		clocks = <&k3_clks 362 1>;
+		clocks = <&k3_clks 362 0>;
 		power-domains = <&k3_pds 362 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 362 0>;
 		assigned-clock-parents = <&k3_clks 362 4>;
@@ -2583,7 +2583,7 @@ watchdog14: watchdog@23d0000 {
 	watchdog15: watchdog@23e0000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x23e0000 0x00 0x100>;
-		clocks = <&k3_clks 363 1>;
+		clocks = <&k3_clks 363 0>;
 		power-domains = <&k3_pds 363 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 363 0>;
 		assigned-clock-parents = <&k3_clks 363 4>;
@@ -2594,7 +2594,7 @@ watchdog15: watchdog@23e0000 {
 	watchdog16: watchdog@23f0000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x23f0000 0x00 0x100>;
-		clocks = <&k3_clks 364 1>;
+		clocks = <&k3_clks 364 0>;
 		power-domains = <&k3_pds 364 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 364 0>;
 		assigned-clock-parents = <&k3_clks 364 4>;
@@ -2605,7 +2605,7 @@ watchdog16: watchdog@23f0000 {
 	watchdog17: watchdog@2540000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x2540000 0x00 0x100>;
-		clocks = <&k3_clks 365 1>;
+		clocks = <&k3_clks 365 0>;
 		power-domains = <&k3_pds 365 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 365 0>;
 		assigned-clock-parents = <&k3_clks 366 4>;
@@ -2616,7 +2616,7 @@ watchdog17: watchdog@2540000 {
 	watchdog18: watchdog@2550000 {
 		compatible = "ti,j7-rti-wdt";
 		reg = <0x00 0x2550000 0x00 0x100>;
-		clocks = <&k3_clks 366 1>;
+		clocks = <&k3_clks 366 0>;
 		power-domains = <&k3_pds 366 TI_SCI_PD_EXCLUSIVE>;
 		assigned-clocks = <&k3_clks 366 0>;
 		assigned-clock-parents = <&k3_clks 366 4>;
-- 
2.45.2



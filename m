Return-Path: <linux-kernel+bounces-552362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A8CA5790B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 08:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D363B3FE4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 07:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF841B5ED1;
	Sat,  8 Mar 2025 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwDW2tVE"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB351B3935;
	Sat,  8 Mar 2025 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741420261; cv=none; b=hlqPvD5QFo5sdQGfA+ls6sf6sHpdmtXStk63HOvK0DCEJHaYQ+aO6oiTmjHch7RX5m3Ftnz9jE00anbuP5uju9qTwJNiN+1tMo82vwApGT7Mfc1FP/Dqrh6y7pf90LRMVPICxa+qT+Us4Hy8WI79v9jbSV6E2pq0SLiZdQOziMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741420261; c=relaxed/simple;
	bh=NWxQJr69T1lJZmCiHGaLhprHxELl4TcRh7xLKs+PcuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pd5AF+fVWB5XQr4ExclbKCilcb5JeRSWjawfICoVVQ8KA8G3cqaXI6w/HVl+Ma618je0U40/Wbc2IIymp/fQHAokMMcBYvskwwQBUmjcJTPvfondkFeXjNCihgwm2IfcOw2GKeHY6G+0cs6aroD/3WGPno37YEZkDfo3PuBlbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwDW2tVE; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so4887816a12.0;
        Fri, 07 Mar 2025 23:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741420258; x=1742025058; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRgn7Ji5C+YzF1ddxyvW2TOfmqPRd4kGtHBRiwohv6s=;
        b=FwDW2tVErff6z50V8Q816p2u9MWoeTWxPATTL+d8V84xZkRgvJOuMjiko6u6sBKr+R
         KkGhastBJkNj8fsCMS/PB44homlMwK+uW2EugEdS3qbx+DIdjOeD3O2Ws4N9EM1Ssg9P
         VK/y5jILnQ/H4FRxhCo97volip0mS3F7+iZbNRh3wUAHiCfSAgfF8dx6QEPw2n0GRWhw
         yAyq/OD/x9YlS1hQ6FsM8eB55WaWhIpxmCHYSNq8hJJupDPbTAg2zi3Cev6Ht+EzxhyM
         q/sNwF2CWdRApc4QDaVWVr4MVSeGibzS0HY4tV6zGmWMYG0sWlHKUK4g7W5VdPGY4LTW
         aWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741420258; x=1742025058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRgn7Ji5C+YzF1ddxyvW2TOfmqPRd4kGtHBRiwohv6s=;
        b=MnjdfGEai7NV/BeCaImMtnX2U09Ist7amhWNQdkrXnBNSlNkkJgj7OotRU/yvXNTZv
         W2NW7ot+lh/fWmpuJ6N9OhZidkK2OhyG9qhpjxMYehXnIKjEWmG5abi9zXFTS74jY+mA
         PyGrEYsJG14jDggXm0hG84rcR6+PU9AL7I9tT0936rHCVoKzjuIxzkMC6C4MadPe7Pov
         A8GnhwqPWpNFPddArW8QeW5cqCnkGzR45n59Ku0SDV/h5BzvpyUm4Kjk3H++KKVX3fRx
         goZa0DumLSliz7hbd6ZDxfCwti2gv0tTmBH+CuqlHnDyxbpF+diyG27WjQp22tY9qB/q
         H3Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVZz9AcaHhUsIm4LMAumk4GpuL8TqZcR21gFbE26JJgffFefFfWoQMUXVvg6cBNjGAVHbfEyWWZ2urT@vger.kernel.org, AJvYcCWpNI1KdpD97Ctl2lwhxL5MswTkJ8aAN8rcSy1TBzLKCU3WmbT9CYE0MTVEs9fbwW37IuSGQXJG4O+Y2GK0@vger.kernel.org, AJvYcCXxHoqnHAhFZnDD3hp1Xhf95Y9gxoNqOur6jxefuAzYHKk2w4tZEuvfr4yXZmNElH+ogQ224O9R8lP7@vger.kernel.org
X-Gm-Message-State: AOJu0YzO63LV1zDGkgeZormygB8NcN2vmyN5klDPybQpHd+hYdIAc2fD
	DI7fNIJ/HyymdXOg4yICdr5Mz2oPgtVMFtM/uksv1TGO9cOuOGn9
X-Gm-Gg: ASbGnctcoWBhBxJ/XjCNOAREczFcYfSsRnlUbkExwJz/oUaozmc8Dq9FZWaWcv2tlp+
	zesqYd72GRJtwaR9hvpqzP9+MQe/17/do62IJ4OHRreEZD11NaIgb2SIo+33HOJ/T/P8ZsiliDg
	sqT910Q9Nt5I7XyiUZVGCFmTkxyjjuqP2RFM7qRcbnHbQsdF72GvOMxtJ56ztZK2wjzXTeRLriG
	NNzitIvA2PWlxUP/Mme+LuTyJH9JFxvaB8aNhfKmR/6htCIoTuLPq7M9VRpA2jiM7LxD9SMh/Jx
	uc2mWJGuqK13FByxG9CzvDaYqFWlnrngEJc2t9FQeP2107d1JWtiAQ2PUcvQ8LhEw3AgYbVBRqK
	f+q2p0NA/AM2PgeDDU3J/+AEecg1q
X-Google-Smtp-Source: AGHT+IG5lIrp7vfPC3/6Z+PEevFK+jZJCO75tUUnV2AFBvGHGbru6Sg8Wh/Y8fqN+r81qf9JP14NUA==
X-Received: by 2002:a17:907:c994:b0:abf:7940:dba2 with SMTP id a640c23a62f3a-ac2526d9b1dmr551492166b.30.1741420257567;
        Fri, 07 Mar 2025 23:50:57 -0800 (PST)
Received: from hex.my.domain (83.11.221.132.ipv4.supernova.orange.pl. [83.11.221.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25d376342sm213104766b.106.2025.03.07.23.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 23:50:56 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 08 Mar 2025 08:50:46 +0100
Subject: [PATCH v3 8/9] ARM: dts: bcm2166x-common: Add matching bus clocks
 for peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-kona-bus-clock-v3-8-d6fb5bfc3b67@gmail.com>
References: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
In-Reply-To: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741420241; l=2369;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=NWxQJr69T1lJZmCiHGaLhprHxELl4TcRh7xLKs+PcuA=;
 b=68WrJZ5qnwnBLofOhhsWqXSoMSMpwFgvHDM6Qp+Je5YacEXEe6ORsDZFiC4kVDOX2tkDPiPHF
 KGAMftEoBwfC/sBBRX8ZVAWVR2yowXiD7Wk2mMDmfRCoxFtXJ4yUWYr
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Following changes in the clock driver, add bus clocks for timer, SDIO,
BSC and UART to the DTS clock output names. Replace the usb_otg_ahb
fixed clock with the real bus clock.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi | 28 ++++++++++++++++---------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi b/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
index 87180b7fd695e65b52c52743e6315cbcca385fba..ab6ad8c6d326171a6da1762ecd839bd82e9da482 100644
--- a/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi
@@ -143,7 +143,7 @@ usbotg: usb@e20000 {
 			compatible = "snps,dwc2";
 			reg = <0x00e20000 0x10000>;
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&usb_otg_ahb_clk>;
+			clocks = <&master_ccu BCM21664_MASTER_CCU_USB_OTG_AHB>;
 			clock-names = "otg";
 			phys = <&usbphy>;
 			phy-names = "usb2-phy";
@@ -248,12 +248,6 @@ var_52m_clk: var_52m {
 			clock-frequency = <52000000>;
 		};
 
-		usb_otg_ahb_clk: usb_otg_ahb {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <52000000>;
-		};
-
 		ref_96m_clk: ref_96m {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -301,7 +295,8 @@ aon_ccu: aon_ccu@35002000 {
 			compatible = "brcm,bcm21664-aon-ccu";
 			reg = <0x35002000 0x0f00>;
 			#clock-cells = <1>;
-			clock-output-names = "hub_timer";
+			clock-output-names = "hub_timer",
+					     "hub_timer_apb";
 		};
 
 		slave_ccu: slave_ccu@3e011000 {
@@ -314,7 +309,15 @@ slave_ccu: slave_ccu@3e011000 {
 					     "bsc1",
 					     "bsc2",
 					     "bsc3",
-					     "bsc4";
+					     "bsc4",
+					     "uartb_apb",
+					     "uartb2_apb",
+					     "uartb3_apb",
+					     "bsc1_apb",
+					     "bsc2_apb",
+					     "bsc3_apb",
+					     "bsc4_apb";
+
 		};
 
 		master_ccu: master_ccu@3f001000 {
@@ -328,7 +331,12 @@ master_ccu: master_ccu@3f001000 {
 					     "sdio1_sleep",
 					     "sdio2_sleep",
 					     "sdio3_sleep",
-					     "sdio4_sleep";
+					     "sdio4_sleep",
+					     "sdio1_ahb",
+					     "sdio2_ahb",
+					     "sdio3_ahb",
+					     "sdio4_ahb",
+					     "usb_otg_ahb";
 		};
 	};
 };

-- 
2.48.1



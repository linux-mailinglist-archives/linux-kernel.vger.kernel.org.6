Return-Path: <linux-kernel+bounces-340505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F17E987458
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14779B24CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEAF29405;
	Thu, 26 Sep 2024 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/BO86Hw"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E9D1CAB8
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356920; cv=none; b=U4AshPPG6uu3pOASJKxqhhzLiZXbkQ7YTHWWlOQHzEQn0eTFVJBH2XXkmAOvHSxo+wT70ybjxzIPH6jUckge2IynbOlpu3dwErt15no0JEdcbOwl8Rcbn6WpDvMoIy/mfFnxTj6yn7cemaNcLAiXnk0s8//xk19d5f1tAxJQqyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356920; c=relaxed/simple;
	bh=47Psf2wnqwK3b685VXfZD84839u8L5ZQ/UBz5WLC5N0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWLA/AoJZxqQ47OJYPoOmpKX7KN3HltaSttqGKFl4Uy5UBUOR8A5ae1yKC5uiH0jsYHr/QAT0GT1b/YMRRZKyOvIMT+38IYmqmLUGbYB7thIqTcA/7bh/Gn/whfNe1kH8km926/QgBk+FK0N8TGxuzX2FoflnuInLFTvS8Rg+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/BO86Hw; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7aa086b077so132970066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727356917; x=1727961717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiWNxzHpdIxEgozeWCgcfOvfbJ2xvJ369Qeayq1vics=;
        b=l/BO86Hwl2SpdFbsJ2PHgG0ioVNOm4nBmhpSllOp1h+u0X5QORvLfRpu9cYPkfkLI+
         JE2/TFWsGyPsYOdI8YtsRSzITlQYlT5npxDZ2dY/S00j8OHVY+6nImaD97upNKk10798
         COlpkT+FDORY8XW0B8Po3Kd7qO/ghGCln6Vt098DMG2LYjId4Gfr8A7bZ+718rw4X20X
         jWtgZ21mc3ONLIVXXymMJyII2nnqSM2/736xohTa0+UZYg4D7NMwH2iLNAKwDNKZpoRP
         HVFUfYs1lP8uAcQRVIe/o/XOgm+W1N4CTJ96YDxsS4Ay1FviY3fYFhsX8JNwymtrkOyo
         ofZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727356917; x=1727961717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiWNxzHpdIxEgozeWCgcfOvfbJ2xvJ369Qeayq1vics=;
        b=K83XN5jdG22NaGUtI7XxOgFO6XANFvYucZF5ki14eMXtSyV+eMvZiGxmVhwrUEIOMH
         28HM+/FRBm4dVV0N7Ibs4f6d56nbU7JydmCnF3HCLi6r+BddVyNIu2fLPR6fZ+4Fs2QU
         GrjjeThE7+XCPRnq9wVZJhH5g8/5slNQt4Oc3ZGMTCkvORzUNZREvCCwnlEjl17PdjPN
         u8/nkuV/AwZTbsavaN2yInHtW3KQlyVm7uWbEtOIFgWzMEwbqccWxKmisdHn+Af94N+k
         9tjtCdZ8FJYcEML228YyvfG08OPtcD8xEA9dVZ9YzU8bxQ42TTxIXyhCelDk829FIAXt
         H/zw==
X-Forwarded-Encrypted: i=1; AJvYcCWfZu+0DUQkGEgxVOM6ZkSbwSQu1OKpu7EWCrMT/hlV28l9DtRleSY+w/zFJzWxU9wPuBHOa4qUSO7WCxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxImiAXqv7xKfjUUMd+8kExRwVAus50ug8vBNvfpUYp/ncxBL3k
	EXMei2HqzV6SBeTY709fUrPRg0fCEJsQJ7we1/0MulPQE39x4iMc
X-Google-Smtp-Source: AGHT+IGOt5L12RHdJ4pPqDxdQwJA03xYBQoAx0ixKOGhq9DXlvdGeL4BsQHiKGlCVlbXW/toFWK6FA==
X-Received: by 2002:a17:907:3187:b0:a8e:a578:2b63 with SMTP id a640c23a62f3a-a93a067db60mr664711866b.55.1727356916778;
        Thu, 26 Sep 2024 06:21:56 -0700 (PDT)
Received: from opti3050-1.lan (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f5417csm347680966b.74.2024.09.26.06.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 06:21:55 -0700 (PDT)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
To: quentin.schulz@cherry.de
Cc: heiko@sntech.de,
	jakobunt@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Subject: [PATCH v2] arm64: dts: rockchip: add attiny_rst_gate to Ringneck
Date: Thu, 26 Sep 2024 15:20:30 +0200
Message-Id: <20240926132028.21910-1-jakob.unterwurzacher@cherry.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <69f79284-b52e-496e-a286-d7e5ce3d90ce@cherry.de>
References: <69f79284-b52e-496e-a286-d7e5ce3d90ce@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ringneck v1.4 can contain (placement option) an on-board ATtiny
microcontroller instead of an STM32. In normal operation, this
is transparent to the software, as both microcontrollers emulate
the same ICs (amc6821 and isl1208).

For flashing the ATtiny, the SWITCH_REG1 regulator of the board's PMIC is
used to enable the ATtiny UPDI debug interface. If the STM32 is placed, or if
we are running on an older Ringneck revision, SWITCH_REG1 is not connected
and has no effect.

Add attiny-updi-gate-regulator so userspace can control it via sysfs
(needs CONFIG_REGULATOR_USERSPACE_CONSUMER):

  echo enabled > /sys/devices/platform/attiny-updi-gate-regulator/state

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
---
v2: remove vcc8-supply

 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index bb1aea82e666e..216a6b6a6ee74 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -15,6 +15,12 @@ aliases {
 		rtc1 = &rk809;
 	};
 
+	/* allows userspace to control the gate of the ATtiny UPDI pass FET via sysfs */
+	attiny-updi-gate-regulator {
+		compatible = "regulator-output";
+		vout-supply = <&vg_attiny_updi>;
+	};
+
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		pinctrl-0 = <&emmc_reset>;
@@ -281,6 +287,11 @@ regulator-state-mem {
 					regulator-suspend-microvolt = <1800000>;
 				};
 			};
+
+			/* supplies the gate of the ATtiny UPDI pass FET */
+			vg_attiny_updi: SWITCH_REG1 {
+				regulator-name = "vg_attiny_updi";
+			};
 		};
 	};
 };
-- 
2.39.2



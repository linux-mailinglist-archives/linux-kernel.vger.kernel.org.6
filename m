Return-Path: <linux-kernel+bounces-216087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A258D909B36
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 03:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AA64B20D56
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 01:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF13167DAE;
	Sun, 16 Jun 2024 01:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="LrTB5hls"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE7E1667D1
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718502927; cv=none; b=Z1umcFGdrVshbEvLDl9z0nru3/2r2/jd/LqrDvkG4msjGdapgf8eM2OBZwhkegeYHyjjPlb50BmtHqMrJgGEXVpf/MabBstiq/rm5x2YHn3MWzb5oixiCqeRYgvvcfbzbXgDt11ADqHvt9VDJPJsOUuqnA6tlp5rCQ+4oSPy0VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718502927; c=relaxed/simple;
	bh=XqKXG4uo59DWYr9Fi4bTSjMiIlOLqenSJX3Df4v2sB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i4BYMbeGeJEhrUXSymzVnButB/nyVBY42itQ5ZhbUK+5zvxAnVfXvIgn9+riXteecerMhCw0tnXUiqfA6ctYxAaK8DY/2KeHchjUnD2pyS1iTj8EGTJwyjO8m2WCKM20TBtYiOALo7mgUfKPfjXNtfHI93kGgbfBE+6IjjxZuqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=LrTB5hls; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-60585faa69fso2411121a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 18:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1718502925; x=1719107725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYP33pfM3TIsirUS57cb0IQBQXI0dVM9b8GqIW7IwP8=;
        b=LrTB5hlsDgQ2U49frF2b1IDn5U8ZbBQCsR9UAGb/NY/2YAQMAZbKogfG1k8lpk0naW
         4ecCTZdx/+xI7aayouIYyC0HGVoMrJoetvu5/mUvyYuX0wC4ldYnCtTfms8ZYmrTUPlh
         u63fstymrgkG+oC4Gq92MtB0kJuVev+3usnQanUFYXIoiHns/zJvRli1ckPO5u3f8mKW
         DyJ9YE+YxBWsqJxMKkoqracvmlGlCIHi1wdn1Me5GcyXGD5DlVvxgs3KtrVF8yA/ZoMB
         O8HwEc70K5JJ11x+PdNi1wWtNtN3AQke7U4vhPpee7iaC4dWKftDOC/lDSliq4JBgXqR
         Pr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718502925; x=1719107725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYP33pfM3TIsirUS57cb0IQBQXI0dVM9b8GqIW7IwP8=;
        b=ZFBslvVJ6ikmbUXrrs6wWTTYyjylrfWXSirzcS1onHodjSsNkhpSOWqSU4NCFko23G
         gK2m9QvLO/EDDdF1I6oiDsRnevDA1Mpo1JAUao7o2muzwL/gxxEUfd1KpOtu2Ny1D6a5
         IKGN0tikw1hBgrHdTwUH/9hYZF3nj9WzSgCPlMxEI+fHGplLohGEEeGqDrGRCSpKWuJs
         sOLNO4vPUXBkqoWaX910M2AXLsy4X6cuuMw3peb6wRONQXCHtdg0WeVpFk+CifTVqB2T
         /c+Wa3HV0qPvw+etrpg4hF3hJqpaK+Ahzoz06j4ilXNnXPgS7lbdZ7T1fYRw24I/pL1N
         J+3w==
X-Forwarded-Encrypted: i=1; AJvYcCVB0wSmghsD5/fR+KM+F0j+5elJbzZmGwAzISohgqPvTDJgi1swuvzsqCVJS9d8zMa4jhX6Azw4jAtMzbVyQb5zQ20fyhkhj4TwxK8C
X-Gm-Message-State: AOJu0Yyvwpf1wLkQLGGIlpSd9VJyPIqCHWK1rECY7FOc0KpH939BRcL9
	+V7Qc8sLbVTVYXgB0uu9NGSgf6yr2Y1Q0kL/+mwZyJFWMEC0rfVghqGuCHQ3V60=
X-Google-Smtp-Source: AGHT+IG6RSXfzO7sqKUhPBDMa2VZZ5KrxxwUmWhQgIIqkFN2DyFbZRCIbUwEj54xUpeHGSH02hVVOg==
X-Received: by 2002:a17:90b:3010:b0:2c2:da08:c341 with SMTP id 98e67ed59e1d1-2c4bdb0fa48mr14052541a91.23.1718502925097;
        Sat, 15 Jun 2024 18:55:25 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:1cea:28dd:2ee0:e8e5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a769aedbsm8751201a91.43.2024.06.15.18.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 18:55:24 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Sat, 15 Jun 2024 18:54:34 -0700
Subject: [PATCH 5/6] riscv: dts: thead: change TH1520 mmc nodes to use
 clock controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240615-th1520-clk-v1-5-3ba4978c4d6b@tenstorrent.com>
References: <20240615-th1520-clk-v1-0-3ba4978c4d6b@tenstorrent.com>
In-Reply-To: <20240615-th1520-clk-v1-0-3ba4978c4d6b@tenstorrent.com>
To: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.12.3

Change the clock property in the TH1520 mmc controller nodes to a clock
provided by AP_SYS clock controller.

Remove sdhci fixed clock reference from BeagleV Ahead and LPI4a dts.

Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts     |  4 ----
 arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi |  4 ----
 arch/riscv/boot/dts/thead/th1520.dtsi                  | 13 +++----------
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index 164afd18b56c..55f1ed0cb433 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -48,10 +48,6 @@ &apb_clk {
 	clock-frequency = <62500000>;
 };
 
-&sdhci_clk {
-	clock-frequency = <198000000>;
-};
-
 &dmac0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
index 1b7ede570994..762eceb415f8 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
@@ -29,10 +29,6 @@ &apb_clk {
 	clock-frequency = <62500000>;
 };
 
-&sdhci_clk {
-	clock-frequency = <198000000>;
-};
-
 &dmac0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 66df04ceb3e4..ce3a0847aa9c 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -141,13 +141,6 @@ apb_clk: apb-clk-clock {
 		#clock-cells = <0>;
 	};
 
-	sdhci_clk: sdhci-clock {
-		compatible = "fixed-clock";
-		clock-frequency = <198000000>;
-		clock-output-names = "sdhci_clk";
-		#clock-cells = <0>;
-	};
-
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -200,7 +193,7 @@ emmc: mmc@ffe7080000 {
 			compatible = "thead,th1520-dwcmshc";
 			reg = <0xff 0xe7080000 0x0 0x10000>;
 			interrupts = <62 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sdhci_clk>;
+			clocks = <&clk CLK_EMMC_SDIO>;
 			clock-names = "core";
 			status = "disabled";
 		};
@@ -209,7 +202,7 @@ sdio0: mmc@ffe7090000 {
 			compatible = "thead,th1520-dwcmshc";
 			reg = <0xff 0xe7090000 0x0 0x10000>;
 			interrupts = <64 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sdhci_clk>;
+			clocks = <&clk CLK_EMMC_SDIO>;
 			clock-names = "core";
 			status = "disabled";
 		};
@@ -218,7 +211,7 @@ sdio1: mmc@ffe70a0000 {
 			compatible = "thead,th1520-dwcmshc";
 			reg = <0xff 0xe70a0000 0x0 0x10000>;
 			interrupts = <71 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sdhci_clk>;
+			clocks = <&clk CLK_EMMC_SDIO>;
 			clock-names = "core";
 			status = "disabled";
 		};

-- 
2.40.1



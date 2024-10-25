Return-Path: <linux-kernel+bounces-381597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C86BE9B015F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D51CB228B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC3A1E284B;
	Fri, 25 Oct 2024 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnLRvEAE"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AD0202637;
	Fri, 25 Oct 2024 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855775; cv=none; b=WD69pPnYcrbtMFzREqSgO1BnZ9RdXwcZTruQYYKA8FvgcL6o+KJ7UYmxmYRhqmn2Q/gLUJOeQqPZINZssYq/Wrbz6GVNmSbdbs2PUI51GBOeBeu7FD7whjjLdQOEe5aK5bRNnGe1Ct6Gk6zlGYF6iVGDXkqGSWMHE6RejaOmKPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855775; c=relaxed/simple;
	bh=JhPx5qae6xbO3tvvd89Mn7WVbrk2W67iBnPAUCjIjnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2TzUoPO4IE0n1WVIVWIsXBfMDVVwFwiTwsI6TRTTO7uNb73qJ9F4ZORT+TjB189mTfysafG3WLSrCJTeeT8OcRPIhyjISsjLWvpLrU1RM9vCTO0Kl68HKcIJQNSmr4m8PcZbykh1H2C8L+5MQt+JnaWStUdIvBPvWkIH8Q0tP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnLRvEAE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7203c431f93so1484772b3a.1;
        Fri, 25 Oct 2024 04:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729855773; x=1730460573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIGxF2ZObIsraW8vGBCdt5dvhIiK6tBRnTKa3/XZgvQ=;
        b=WnLRvEAEGvtkl9+9vtO2ETW4zHFMx97IeYx7eVO91mGyBddehmhjH2aohxhpUoDiNm
         m5gNEyQu0fGEjnWAt1+HFlQx4VxYV8Ljw67j4g8F0EsxtnW1jFpjTMAatwkhH1LI8KIL
         cBXxyqS93pqbSrPQVqeVHR8yo9yjzj7jOE3c4r7KRaM7iNQc/PPgsde2nkbXWlzI5Whw
         QkUMDKbrdnC4w3zD7xaDnYqElQYqILUmt/SzlqBYHSwEYAy0bNb3teQbCYdfYYU+ugoQ
         DQCS5rH5ZPvSeRceGd2jCQEFS9wdZb8uGVTHkHp3aLpoLT+2pH/kBr5YrnuX9SMfYxU+
         OG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729855773; x=1730460573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIGxF2ZObIsraW8vGBCdt5dvhIiK6tBRnTKa3/XZgvQ=;
        b=b6RuSSThv5u97KtoINo5VV0yPjbCOVolnQ1NcNb5DVWeEdt1r2VnE4OAfl4DJ1xjbV
         02npyJ1IDvGLqoh6ejZllI/gEPgxqfmaHUs7BkIvf71YwxLwoLqToeSSdVy5k6tzRXRI
         +Ds+ypTOTCNNQTt+uAD+cWQ6UelkT6v7YpmG1EmFzMkWEyVGdUgXvjZPsk6ebT+VtE8Z
         N8zMlmpCvYMRdVCKgn8V94JseyZrbRU4/x5FfyyxP8gSJkqOQQvEiAIzkDhJVHAO1vZA
         sDduyf64JKQorhSKeSGlPdRGf3qdoLSGLDzUXqkC4k3lRe2zfyeQEgSIVNTzkbdqh2Nk
         TGBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmrBd2FADt1AW7Mbm+w8qOcAWboEAKlhbl2ghbIS+zwgvpjRsUJv/STXc1XpctJGlxJzHsXVkuITUp@vger.kernel.org, AJvYcCX+i8rQZXMBke1B+wyCtpvZYzt+0L/zJBCBVncu47DDVnvW5z4IXhaOv2g3A+xkmX8fjDpgg9SZZE3LCwcB@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbLugV7ePz2DobKLl8nD2m3FeLKSt4Rak9ezRQXuHa9DJkWk6
	iBdZUnvsMUQcRZmQfxXtQXHNKMRCW1qHpRXA9CoZHrp9XTXecyLZ
X-Google-Smtp-Source: AGHT+IH9hL6sjc3soe+IsGOsI9AiJaPl4BtIw9lhwEN62zU4CVjOVV7qgP/yNH28TGevoCYuTQ+TGw==
X-Received: by 2002:a05:6a00:180f:b0:71e:77e7:d60 with SMTP id d2e1a72fcca58-72030bba29amr13321624b3a.23.1729855773157;
        Fri, 25 Oct 2024 04:29:33 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205793175bsm877382b3a.48.2024.10.25.04.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 04:29:32 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] riscv: dts: sophgo: Add emmc support for Huashan Pi
Date: Fri, 25 Oct 2024 19:29:00 +0800
Message-ID: <20241025112902.1200716-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025112902.1200716-1-inochiama@gmail.com>
References: <20241025112902.1200716-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Inochi Amaoto <inochiama@outlook.com>

Add emmc node configuration for Huashan Pi.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../boot/dts/sophgo/cv1812h-huashan-pi.dts    | 12 +++++++++++
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi       |  1 +
 arch/riscv/boot/dts/sophgo/cv181x.dtsi        | 21 +++++++++++++++++++
 arch/riscv/boot/dts/sophgo/sg2002.dtsi        |  1 +
 4 files changed, 35 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sophgo/cv181x.dtsi

diff --git a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
index 4ea27cd357dc..26b57e15adc1 100644
--- a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
@@ -43,6 +43,18 @@ &osc {
 	clock-frequency = <25000000>;
 };
 
+&emmc {
+	status = "okay";
+	bus-width = <4>;
+	max-frequency = <200000000>;
+	mmc-ddr-1_8v;
+	mmc-ddr-3_3v;
+	mmc-hs200-1_8v;
+	no-sd;
+	no-sdio;
+	non-removable;
+};
+
 &sdhci0 {
 	status = "okay";
 	bus-width = <4>;
diff --git a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
index 815114db54ed..8a1b95c5116b 100644
--- a/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1812h.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/pinctrl-cv1812h.h>
 #include "cv18xx.dtsi"
+#include "cv181x.dtsi"
 
 / {
 	compatible = "sophgo,cv1812h";
diff --git a/arch/riscv/boot/dts/sophgo/cv181x.dtsi b/arch/riscv/boot/dts/sophgo/cv181x.dtsi
new file mode 100644
index 000000000000..5fd14dd1b14f
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/cv181x.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2024 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#include <dt-bindings/clock/sophgo,cv1800.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	soc {
+		emmc: mmc@4300000 {
+			compatible = "sophgo,cv1800b-dwcmshc";
+			reg = <0x4300000 0x1000>;
+			interrupts = <34 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk CLK_AXI4_EMMC>,
+				 <&clk CLK_EMMC>;
+			clock-names = "core", "bus";
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/riscv/boot/dts/sophgo/sg2002.dtsi b/arch/riscv/boot/dts/sophgo/sg2002.dtsi
index 242fde84443f..8c35cdc34d2d 100644
--- a/arch/riscv/boot/dts/sophgo/sg2002.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2002.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/pinctrl-sg2002.h>
 #include "cv18xx.dtsi"
+#include "cv181x.dtsi"
 
 / {
 	compatible = "sophgo,sg2002";
-- 
2.47.0



Return-Path: <linux-kernel+bounces-548760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25644A548FF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D7418946DF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91F20E021;
	Thu,  6 Mar 2025 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MG+c78OI"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFF020D4EF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259772; cv=none; b=HTvFZIZGN9mvP9CyPm7b6K6TLhl0e1GxzlRHadKd5TfVbe5ZgsZ2SOPgJ/PCl+w39AcAu3rZdkzkiXSoXEjkEJ3urByU40ruzc4HNoBGe2iv+p811IPMoAgypoPmQM/YgBiur6H1529j7JBsLmIR4GfRmJY98cJwnTdq5g+cPpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259772; c=relaxed/simple;
	bh=d8JktRpsnXtExrDEQg8XETgLfj06OhFCRQiosuwspHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omCi0DvVJ1zfQLeZtKac2HEY8qdEMVxx9akJYbwTc77UUoXYpK1gIs4NIWeZJ421VM4FS7FYnYxC8J1IaMD5wUy5dNpkIIp74PHGUJ4M9RTs2j8gyArmYr2uqSg9p5gkGUI+8J73eHAYsXI80GPf+2eiCDxsdLB8WD7r9Wr7T/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MG+c78OI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so703922a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741259769; x=1741864569; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYtwui9Erh4I2K3zHdu+q0zTdYm3AFiykAHnPwI2sAM=;
        b=MG+c78OIvqGzFQzRgwF87ytvUBWB1c++4khhpuJ+67w8eqLwqWJirpTpiwJH+Hee9G
         bN+/+85WlTABJ0c/Ds+6m6WyMx0+XBnpb8EGkSrSsnajKl9wovaXw75WQ4n9exJAVbLc
         H3eh81Z63kSlmTB6NlSpENU0nplKWc4YZu9qaTbFA62xULp1N6xJrVftZRVso0ekmIAy
         ykOWYo/mNsu+rAmQY/PbBFHMghrMkdgKE1lim3eBkcn7MwFXaRK857v31Z6L/aEXrXpg
         bKMWrV63u45Lamp7Un1k8nTUlhRxROYb+bsP3e7JwfqkUL5+lFjgtHMl5BUHCg+6AUmY
         viLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259769; x=1741864569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYtwui9Erh4I2K3zHdu+q0zTdYm3AFiykAHnPwI2sAM=;
        b=Jd9DN8J9y0zoibY+OvTGViudxEAZtC2M46uWUHtqqncDQyQXNXNE9nS8HPZO+hc5mY
         HB5Zbjl429aIYszsSrcXgJ84hg1nEiA96tvTXWxqX00nPqIHMUWdWtHCpNhIAwgCegDp
         Z0icbMQ8PSVDOLvPDd6Lf4A0G3fC3JhdmWZWr0pL8oULevb41mf+KMyCyQtQeoMX9XxZ
         Tvp2vj7emGCIlK/KvFiK4koC8efL7jC1epIuhFBCZHJ31kT9bD0ia7rqieDsTGREQb2W
         g7vNC2tHpR9jDYWxSSLnZ4YGBFCKftNO3iSz2Z5hKfKvLYj73JqD5NnrHC9iquQKS7rQ
         S/wg==
X-Forwarded-Encrypted: i=1; AJvYcCUvxlxM2pw/CYsr6PgRnt5ZobT0ETbR3fNZwJMFRxROZ3A/IfK74Egk9Oqefc6pnQOxDtIC+EOjcM9NXJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfzeaMh4GmOdpi342U6E0iHN5oB2QVzQ5B5/T4Hz/1zWUwXpE
	9BDcTE7JHJBuuMVQ8JIRpyx5igaD3TBhSdFQPgdxm7mkaC6pqZdNntw2ZdAYadU=
X-Gm-Gg: ASbGncs0MC8PmbvnHEyc1x6BjywWk/EHGYyz/07905YGl3BqnYPjYRkR2puzhKEj/Fj
	N5vsTMzz6pPTa0xRaSwSNaDsu3m08OjYl0sy+2SkvUiOFw5WlNugW1jBRrtKRlN0GPlW8hapYhg
	z9BxEnD4dYakroW8mtJKmkAWVFc4+uzB74qSTIpfo4s4pzkuOtCkFo7/LTlecJGIMqLXUNU7qhU
	N2B6XR7r7NqOVHRpPYGvBA8uJCwrdn2ZVjgws9MH5zUsG9ZrLwKsU506UadlYL/aYPo8esCGld2
	qTKpcujSuvRO+eji3Rj9CV/E+nprxAw+/rJCSWCINA==
X-Google-Smtp-Source: AGHT+IHLvSc6bXLemWdNMPjb7kOiDfMReioYbM1WlDggWAhYIkoRPKliPoiO8nRDtf8Q913t8YyBCA==
X-Received: by 2002:a05:6402:1e94:b0:5dc:7823:e7e4 with SMTP id 4fb4d7f45d1cf-5e59f3c6c25mr6989946a12.12.1741259768527;
        Thu, 06 Mar 2025 03:16:08 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:80ad:8144:3b07:4679])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e5c74a8f3bsm807671a12.44.2025.03.06.03.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:16:08 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 06 Mar 2025 12:14:48 +0100
Subject: [PATCH v5 10/13] arm64: dts: ti: k3-am62p: Define possible system
 states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-topic-am62-partialio-v6-12-b4-v5-10-f9323d3744a2@baylibre.com>
References: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
In-Reply-To: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Kendall Willis <k-willis@ti.com>, 
 linux-can@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=msp@baylibre.com;
 h=from:subject:message-id; bh=d8JktRpsnXtExrDEQg8XETgLfj06OhFCRQiosuwspHg=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJPNl+Put9e/HPlKiWxlxzN29cIXz7lLa+W8/shT3pn5
 6Mn+fr3O0pZGMQ4GGTFFFnuflj4rk7u+oKIdY8cYeawMoEMYeDiFICJMH1k+O++VLSJ6dE2ltNu
 Zfm7Q3O447bICs7mazreEfUlz7LCiJGRYery4qOcrx5+iyvd1CasrftjFcfXA4v9kw/XPz/XdOG
 6NzMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Add the system states that are available on am62p SoCs.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62p.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 75a15c368c11b068430362fe0b8d2d9ecc052588..64cd070f196fdd2999ddc7bfee3ac9a03f1366b4 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -44,6 +44,33 @@ pmu: pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	system-idle-states {
+		system_partial_io: system-partial-io {
+			compatible = "system-idle-state";
+			idle-state-name = "Partial-IO";
+		};
+
+		system_io_ddr: system-io-ddr {
+			compatible = "system-idle-state";
+			idle-state-name = "IO+DDR";
+		};
+
+		system_deep_sleep: system-deep-sleep {
+			compatible = "system-idle-state";
+			idle-state-name = "DeepSleep";
+		};
+
+		system_mcu_only: system-mcu-only {
+			compatible = "system-idle-state";
+			idle-state-name = "MCU Only";
+		};
+
+		system_standby: system-standby {
+			compatible = "system-idle-state";
+			idle-state-name = "Standby";
+		};
+	};
+
 	cbass_main: bus@f0000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;

-- 
2.47.2



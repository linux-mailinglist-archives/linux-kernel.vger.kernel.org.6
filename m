Return-Path: <linux-kernel+bounces-383671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FF39B1EEB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCBFD1F217F2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E33018F2C1;
	Sun, 27 Oct 2024 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqqXR/vE"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B842218D658;
	Sun, 27 Oct 2024 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039847; cv=none; b=SyTCIcLX4SKFE+HACg7n4Y4XO+kmVlu6H4d+z1OYwMcP538UiPeHrb8WZqnlrptHCiIuk6GqqJj6A8u4ksr++WtG6EL7Wki0v3bfAu1t/3UFUdCYMLFXs8oA+Nd3B+Edj4iOik8A6FQXSU95ElAdO7WUxH5MytvnOCNe8r2ZFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039847; c=relaxed/simple;
	bh=S9k+VQ0WleJZ5GpcYDB2e3SzoRT8QVHAAnec/ufVy8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e7Em9S+/qtGdx987HuPWjAS8CSqbrudyO9mSctamLslHnkbrBUiulBCqvEnwi+BVmgk18OO/4axy3zA1SDfVfMTordeOSdT5CvnDDFGW1XuRfsRFcPFOt0MWnQ0VmsPOiKcc1+0XWhiKSWWmssiv8aY9NkEV1zbR7i0WE4zkJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqqXR/vE; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a017a382bso55228066b.3;
        Sun, 27 Oct 2024 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039843; x=1730644643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5pESrG6jMEz3xnbtE1/gQgYKtauCE3QcRjN239YnKs=;
        b=VqqXR/vE4kZrhy5HWNcvwZf9MTYkKJLba3gssFq+lsiuJ+jt5Vkr+lvL6jej2ozkVi
         XmpUVndN71vJd6LRtV5YZQRtCHJKQ4eu1LbhIhfKrevZU+W55VYPjejpvsfxEKhD7B/l
         xiEEt20LraY/rKTaPdO3KKvrO8xkR4iMuYoulDHzUhq2r/ilgUSWB1hmgwoK20HUN94E
         iweLsSXewPFzzuf5AcYtPWvjH8VyERSBKsBsH77Wvaf0rvSJnIECdTBFZ780b5z5bz9L
         ZYqpRCCLBaq981SzOF/WP5CPVb8KwcDneR9dfxFiICHW5Y1fauwWFGkb1t3TMDhCb0Eu
         bFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039843; x=1730644643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5pESrG6jMEz3xnbtE1/gQgYKtauCE3QcRjN239YnKs=;
        b=ovZMXROilPcXxn8cMUyHX29shH3xCaBSB66lA7qw60bVAGBnfMQPcUFGt6ygHXgHn6
         RdrWCoeqeZICODMiAIXKXd6h8OqEWbyMIwqwaWEE+nR6lDeLHSrvr7RX3zVRIRga9nHt
         YiXw7htYpVuqPKI9WGsuCyt9zo0jJhp/Y/4y7yAfzo2U/mg5LSwB5NdzP5ir9PAAcSXd
         f+COfHqrqGdkKC+QIJfK+KWJmfygCBTHF12Z+O2d39bMpT8K+xy+IvJnVhllyzVaKM62
         7C2jVSVvpxfAtUS7gyU6MX6Rb6RXRQNJWDDnhjU4eLNf13DgLp2uX7AtPe6flPzEQit/
         Ej4w==
X-Forwarded-Encrypted: i=1; AJvYcCUFC5dV/MlDzUdQAW1qekwylOhBs6FGVdlJ2eXG36a1xx3V5qNzwaqo62lbsbjf9h1Jxd23BUMfDjdB5N8I@vger.kernel.org, AJvYcCULL2FdjfxpRXvq9LE71DRwCSf+RTIX7swPESRKHaiur7s3A8tnrkzvxlKlajE4UyW0r5WoQTLkjIS/@vger.kernel.org
X-Gm-Message-State: AOJu0YzwsehWW1OTptYkHz664UWOdWVftPpjgYeWu0773xnFHKauABpn
	FL09NVrXRD/WTujNPbaquto5+6ix/5cEoITdfMQ9Wm53o7EawyxLgOutFQ==
X-Google-Smtp-Source: AGHT+IEM+SKjv0KHRJwA1rCsj1ubf+u3gxyqn9fU+uRHd/8tGzpMooP+afK4cUesdFqimD5jbD7eBw==
X-Received: by 2002:a17:907:e8b:b0:a99:d6e1:6056 with SMTP id a640c23a62f3a-a9de61a3ad5mr224242266b.10.1730039842754;
        Sun, 27 Oct 2024 07:37:22 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:22 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 20/22] ARM: dts: socfpga: removal of generic PE1 dts
Date: Sun, 27 Oct 2024 14:36:52 +0000
Message-Id: <20241027143654.28474-21-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241027143654.28474-1-l.rubusch@gmail.com>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the older socfpga_arria10_mercury_pe1.dts, since it is duplicate,
the hardware is covered by the combination of Enclustra's .dtsi files.

The older .dts was limited to only the case of having an Enclustra
Mercury+ AA1 on a Mercury+ PE1 base board, booting from sdmmc. This
functionality is provided also by the generic Enclustra dtsi and dts
files, in particular socfpga_arria10_mercury_aa1_pe1_sdmmc.dts. Since
both .dts files cover the same, the older one is to e replaced in
favor of the more modularized approach.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/Makefile      |  1 -
 .../socfpga/socfpga_arria10_mercury_pe1.dts   | 55 -------------------
 2 files changed, 56 deletions(-)
 delete mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts

diff --git a/arch/arm/boot/dts/intel/socfpga/Makefile b/arch/arm/boot/dts/intel/socfpga/Makefile
index c467828ae..d95862e34 100644
--- a/arch/arm/boot/dts/intel/socfpga/Makefile
+++ b/arch/arm/boot/dts/intel/socfpga/Makefile
@@ -2,7 +2,6 @@
 dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
 	socfpga_arria5_socdk.dtb \
 	socfpga_arria10_chameleonv3.dtb \
-	socfpga_arria10_mercury_pe1.dtb \
 	socfpga_arria10_socdk_nand.dtb \
 	socfpga_arria10_socdk_qspi.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
deleted file mode 100644
index cf533f76a..000000000
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
+++ /dev/null
@@ -1,55 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2023 Steffen Trumtrar <kernel@pengutronix.de>
- */
-/dts-v1/;
-#include "socfpga_arria10_mercury_aa1.dtsi"
-
-/ {
-	model = "Enclustra Mercury+ PE1";
-	compatible = "enclustra,mercury-pe1", "enclustra,mercury-aa1",
-		     "altr,socfpga-arria10", "altr,socfpga";
-
-	aliases {
-		ethernet0 = &gmac0;
-		serial0 = &uart0;
-		serial1 = &uart1;
-	};
-};
-
-&gmac0 {
-	status = "okay";
-};
-
-&gpio0 {
-	status = "okay";
-};
-
-&gpio1 {
-	status = "okay";
-};
-
-&gpio2 {
-	status = "okay";
-};
-
-&i2c1 {
-	status = "okay";
-};
-
-&mmc {
-	status = "okay";
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-};
-
-&usb0 {
-	status = "okay";
-	dr_mode = "host";
-};
-- 
2.25.1



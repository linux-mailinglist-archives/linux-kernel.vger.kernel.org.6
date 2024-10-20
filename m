Return-Path: <linux-kernel+bounces-373411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CF29A5660
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54E21C21088
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A504519F429;
	Sun, 20 Oct 2024 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baXx6kBc"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE83619EEBF;
	Sun, 20 Oct 2024 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453264; cv=none; b=HYfaGwkjmrvoTNLQ/HZ1gTTgo4f4GDH3EfkIG+jmW6+ScRkBB6TJfZAmhH9ftjDfXXPYsuxJqQdJgX3jzf4uYp9SN9b/IPaaFmGNsIRha7wfvXO6kWr2N3+4di+xZxRrxkD2jGhFE06jIOceWXlsqNM8pPSzPR96e4MhiUHvRzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453264; c=relaxed/simple;
	bh=S9k+VQ0WleJZ5GpcYDB2e3SzoRT8QVHAAnec/ufVy8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDHNASykeijWHncCVzIR9COnLlprBj2pExV/+83lK0kHGpvO4L+DTcE4vc7ny1umO/dKWcOeK+JRdfwFxhexYJNTNw6yF0ss4Muigm65zyAd3FgQhYQGEJ9PxeZFvxGaYGHItwFQgLWWd+JXpPJcvAkqSCgtxQpi0t0286GIdNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baXx6kBc; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c940512711so703441a12.1;
        Sun, 20 Oct 2024 12:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453261; x=1730058061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5pESrG6jMEz3xnbtE1/gQgYKtauCE3QcRjN239YnKs=;
        b=baXx6kBcP0j7mQ/rBmfMbO38MyNohCNU82zurLeoP0ecixts5Um91pw5ow+najE6Ti
         A0VFxOZz9C0rmzXxrlvUTBinQjJLW4cyoMG5VvC5+iWA0IBx7awK+15/w85NOEw+rQs3
         1uBRaygcO0wVrbZ3/fA8GfogucaAzLbgOIHCT5OHbEQCyIGKE+y1DO6Zna9+sFrLJCQ+
         uwuiuhxmogM/oOdNXi2yCnpvkThJz83VnckduR8fFa9cSb2Hmffgn0kmlv96vBEddH2k
         +wkXvMgaUy/88huy6U7EobXWCD458W/QPyKVoIPL/irYc16AaHcZMa/eUjcqI5Ca1Ze3
         C4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453261; x=1730058061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5pESrG6jMEz3xnbtE1/gQgYKtauCE3QcRjN239YnKs=;
        b=r3X2/xkIbpCOYp9msUXByTB7WI2uFxGct0KYY1IcXHcOfU64ErLi912YmmXVuVKqTP
         9txoZnDZbOFOXb7tWOlsokyiL3JTIvAcC5g3xw/d09ZAiJruJzdTjyVIk2qeMYFsVaHk
         3vvAmPyQ5d1gLpNdFVx96vdg0n40/Ik8SV4FZR0EogLsGVtq+YpD4jJQEw3w72MvixgQ
         3AqaMkqTXBzajjeYn0yB6jkXSXIsBZKmFhFs5qDQLA0JR24zgJBTysRS0qpIKPHFPpQF
         azkWDHCWAkmha7g6Anyt/xKNfimnB2g+mMA+BOYpaA9MudtFu5kBRCwbUP3JlHVb1Xz/
         k0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJT7J71cLyuAk/QO14iwJMMUcDeJdYutOQpUD8pAYJ885GEVQXkuMcuftJ8QuD5UXgNM1bcVvwivNnCRa2@vger.kernel.org, AJvYcCWapsYPaxRdHgvwdDaaTmXifHKI5bsk/IacueJXsirPaQnz90beZ4HfGiYTNUK0n82cUVQx0IzxCyOd@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbNc/W4xv/JF+1XGfSYHKPsa4DCQvt3fKsR2dMbiR2CWTSuQG
	q8lAYJVOyiGNzQXZigXW9/abGeJJKIxzHTJm4DvCElGuyUJ9toKV
X-Google-Smtp-Source: AGHT+IF83gtc3ceZBYemTxj0XFxbfY/ErtG6IxAMozBeReiybohHByeIJGVjNxrziEzzmZQmGm954g==
X-Received: by 2002:a17:907:7f17:b0:a9a:3dc0:fbc3 with SMTP id a640c23a62f3a-a9a699608c7mr466509066b.2.1729453261075;
        Sun, 20 Oct 2024 12:41:01 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:41:00 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de
Cc: l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 21/23] ARM: dts: socfpga: removal of generic PE1 dts
Date: Sun, 20 Oct 2024 19:40:26 +0000
Message-Id: <20241020194028.2272371-22-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241020194028.2272371-1-l.rubusch@gmail.com>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
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



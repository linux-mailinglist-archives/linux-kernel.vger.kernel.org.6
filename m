Return-Path: <linux-kernel+bounces-353407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F776992D5E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42198284381
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC831D6DB4;
	Mon,  7 Oct 2024 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlfoiujF"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490D31D5CEE;
	Mon,  7 Oct 2024 13:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307891; cv=none; b=hSoMTrTEeA/8BN5rgWujIGMM++sxJYGwZZtSEEiAfovVr+U2mBeh02cBgeu4H2JHHfuaQj0Mv7gHKTGk1diATFClbiy2LZ/zwRPvnh3wGr/xNxLA4MZFz6kEy3ZXTO2wNSwBYTLALkUW3K/pB06eNo5Cp47AmXZpBLenDzThzzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307891; c=relaxed/simple;
	bh=QYzn/955ZjeOvNOvkHDf4Ka9h8/a7+pdEk5HLRSv/bc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLd/LPE6RFL9Q9mrftedrgVczguh4o6OzuuqskYMZyvZxEclrFZlznsSoRvYFzUVGT47bLw0YrgUBegpwv9vHzZNOm9Ic/7Ktke6+L1fKhTVtctv9LOW1zWcWEi91HPeQ1cyZIu8OgmsK3T5VwL3M9nDC8DPPUMJ4WJ/pFi7aOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlfoiujF; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c884bc72e9so564662a12.0;
        Mon, 07 Oct 2024 06:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728307887; x=1728912687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzfSo2f6UaXYJPSwB5Rwcfg3k9bR+7+UcxfS8j5KpLY=;
        b=nlfoiujFoQua9gm9E+DPDy4sqXnFKFcD839ADjiiMaV+Wthrfpaniy9yBHvZG262z6
         GCM/BeqKbxIKUxxd6NN+eDufy6FBht8macCBWacsaLnynR62k+ZmOjMe83V86PjUjmqd
         Z7Hal8cKmM5WtXPZwLLLIvSeF5+KEW5qcE9Xmytu1BdtpfEDGUe7J9OtHoLeYn3jlLeQ
         YV65wIq0xBIhWXveygiqZ3pTJQvHZdzOTRCSnPZAQ4Zzh0fSKK5+ZyEV3jmrh4t8v4gG
         ZhT+CYXytzPFr6RhR1gigweu0X4TpEpzqfQ+XcdkKrYhcWYmEzgZ1UPY1jOrBSKby5Ee
         p9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307887; x=1728912687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzfSo2f6UaXYJPSwB5Rwcfg3k9bR+7+UcxfS8j5KpLY=;
        b=JkBzK8Oza7cBtMczV5NXcdTZNruoJ5kPOWQMArTkLm0JsX2+24d3hqZ7rTKLME45F7
         +26ItJOTGW5GYO5f6lTLeRXSngiv0R7IHEvqjqnu1+IuViqR+PhAn61FwopLhX/SLeWU
         u2AXcC/OeIeBClukj8JEWTKVrtQIssU07SDjen22UVOBmbnsnjLwjaxGN0WrKnEvPSc0
         XlsTqkGPl4Dft4Uh8r+Voqp84RPqHtFJlvU9BlHvuxxngsI9OlF2bLTCE7e15CtmVG4W
         MzuT0wY+touplupdfhpsYYsKUucvdd9uKnd0zrjmTRhaCLNpvkTIPleUzQUsOrMVJjJN
         uhtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiUq+JJI1vypIGMgR5EwLfx80w01/kmrDnrfilcHIgOBnLNm2AVAvjiYbKFsdKxlIve2JP6nhuMagW@vger.kernel.org, AJvYcCXzCV33V13OFLYFlPENMt0JpK09uPY8bcguMdxhtTnetj6dhXV+RV+qv1lGyBvb7pTot8hu10JYcwiAlX8/@vger.kernel.org
X-Gm-Message-State: AOJu0YydsITv57XJ1uzhMr3TpG5dJlWRqeyhCwD+Jl1oU9YhM38M16rw
	KQL6+zO2GVcnpbeApVgoLsQOgPPXzHDclu9p1vGCu4qcR5dXBb/w
X-Google-Smtp-Source: AGHT+IFgpXhTCw9bnvM+W4O2h0ESs+kG03V3IH6mJ5Z2SwnhdEua6LkpMf8xbCydTu9rUA0LlgwQzw==
X-Received: by 2002:a05:6402:4308:b0:5c4:14db:4a69 with SMTP id 4fb4d7f45d1cf-5c8d2e8678emr4440458a12.6.1728307887432;
        Mon, 07 Oct 2024 06:31:27 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb34csm3193089a12.59.2024.10.07.06.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:31:26 -0700 (PDT)
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
Subject: [PATCH 7/8] ARM: dts: socfpga: remove of generic PE1 dts
Date: Mon,  7 Oct 2024 13:31:14 +0000
Message-Id: <20241007133115.1482619-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241007133115.1482619-1-l.rubusch@gmail.com>
References: <20241007133115.1482619-1-l.rubusch@gmail.com>
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
 .../devicetree/bindings/arm/altera.yaml       |  1 -
 arch/arm/boot/dts/intel/socfpga/Makefile      |  1 -
 .../socfpga/socfpga_arria10_mercury_pe1.dts   | 55 -------------------
 3 files changed, 57 deletions(-)
 delete mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 51f10ff8e..1561f0164 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -31,7 +31,6 @@ properties:
       - description: Mercury+ AA1 boards
         items:
           - enum:
-              - enclustra,mercury-pe1
               - enclustra,mercury-aa1-pe1
               - enclustra,mercury-aa1-pe3
               - enclustra,mercury-aa1-st1
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



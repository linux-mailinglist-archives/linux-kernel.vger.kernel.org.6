Return-Path: <linux-kernel+bounces-381596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7731B9B015B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480421F22C53
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AF82022DA;
	Fri, 25 Oct 2024 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNgIBclE"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAD21FF7B6;
	Fri, 25 Oct 2024 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855772; cv=none; b=uqICEud5X9ZYFZSyGJXPyV/JY3XHHCwpv8I3s/DyswJ4dmezTGrUCEFE1PFs4diHzSoR4AwiBk+WEpg7Zmg12EoDIlA5uDH7wUt5DtPeKKFa+3u3wKY9b4OC5jWHtBlzrxMmg3m/wyCEDzhq9QD+HKRjiw6lckbSkRUAWcaxVvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855772; c=relaxed/simple;
	bh=87fe6LyOWpzovx3oYFKK37OvJnUOEY5BbVLnYdhKEy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CP3FnymiBfvVJgVeY5BldM1BIArwD2W1eiIbyMFvxofNaO8R8PX20CswYEW39oRZ0ksLD+xy/rTROE0TUEu5V/zcFJJcv7UwlbhMtUOuGcV6kBI23FrvTMYHv2tDgRWEdLDPGC5gkY8SBCnahRxFH9sFg4GpT3XkH8nOpHTptI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNgIBclE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e59746062fso1500352a91.2;
        Fri, 25 Oct 2024 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729855770; x=1730460570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYrXumY7HgWfJSOA6I3P0i39HkYnIijU1OfOIgv7Pes=;
        b=MNgIBclEQcGr1ABvJjIVI/Ea4Mz3T2A3nxl/rd4baqWRT5LUdPC9lCXBfZsKyg2rSV
         9z8pIs5t0z+82khAJvhYf1DjZyvSYw52EawqDTmSeebCrRsSJ9sm4WObJCB15hpTL9DW
         u22M9QfyC19FEYSki/tsigRfsku79fs6dX8RSi7lgb7x2Y2nefKarMW7DH6tqvBYqtzr
         8Z83uCDxiVmupjhPSi+0bnklMrvK2oWU4OO5DUunSImQ6xqEFttAyhoXMnoPP2Iol6rS
         K8T1NfaELb7r2xAjVlSNChf+gNC4vcPGyX7nLTWc5fep/buVGExseziCluauDn/xKwhq
         0QaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729855770; x=1730460570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYrXumY7HgWfJSOA6I3P0i39HkYnIijU1OfOIgv7Pes=;
        b=dbLYIZYCSfPzdTEiGqEUBBJQkcqxOYlNDbrjNrTrHd2MijkyeH4dlBKBhjG1gBFWS2
         7CYNbsz34SZn7FoDq+LkmuavTLYOwJhSaHdrtRKfeKy/cSHdoEMCb2zVqLThJWyY7XfG
         Mny72hrfL8ytjxKE85cnFITejTijslZKY4TlfdIfUiRCZHAbGe1jYEKior63R9illWjg
         /QIc1rFUll4LrKerwoGgax7QX4uAgTiWE6xDI4xlWtZEQzO4WhCqD3KW1wWkJn7uJqYw
         TUzXSHc4i7U/pYIvL0bX7jSUdxqnImnMSClEyYvUTv+LQ8yDgo/hrT3B4s0N/cA5NUgL
         6U8w==
X-Forwarded-Encrypted: i=1; AJvYcCUWcQV8qSxOg87dADjculdfZFsYKaFtuE93BRA9z1uGNEQNqh425FskuDSZels7U36zDXY2IJIbgSHYUE+J@vger.kernel.org, AJvYcCXpiflJsc0Yo8RP+x778G8w7z6tOPWGQGCxQJDVEb/C3JZ3V11QZqNhR0g9BlhFqCDydlYJNowg4SQv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8T+QHejgM1/vKThwP6m/D3Z1gGimmqQGcxDJ4bLMipmu7NYka
	0qys+PcGn2k+pfXahGPoov5f9vigZEdiNkrJpxeuueT6SDw815B4
X-Google-Smtp-Source: AGHT+IE+tBsWv5oc0Db0V+04UACjLf3a+c+NXelbG9Pyc+UgNW9JpAQrRFY4XfVu8yX+7kdORHF7Cw==
X-Received: by 2002:a17:90b:3512:b0:2e2:cc55:75b6 with SMTP id 98e67ed59e1d1-2e76b6ead44mr9891288a91.31.1729855770036;
        Fri, 25 Oct 2024 04:29:30 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e36dc3e3sm1172555a91.33.2024.10.25.04.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 04:29:29 -0700 (PDT)
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
Subject: [PATCH 1/2] riscv: dts: sophgo: Add sdio configuration for Huashan Pi
Date: Fri, 25 Oct 2024 19:28:59 +0800
Message-ID: <20241025112902.1200716-2-inochiama@gmail.com>
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

Add configuration for sdio for Huashan Pi to support sdio wifi.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts | 11 +++++++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi            | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
index 7b5f57853690..4ea27cd357dc 100644
--- a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
@@ -52,6 +52,17 @@ &sdhci0 {
 	disable-wp;
 };
 
+&sdhci1 {
+	status = "okay";
+	bus-width = <4>;
+	cap-sdio-irq;
+	max-frequency = <50000000>;
+	no-mmc;
+	no-sd;
+	disable-wp;
+	non-removable;
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index bef89979df78..c18822ec849f 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -319,6 +319,16 @@ sdhci0: mmc@4310000 {
 			status = "disabled";
 		};
 
+		sdhci1: mmc@4320000 {
+			compatible = "sophgo,cv1800b-dwcmshc";
+			reg = <0x4320000 0x1000>;
+			interrupts = <38 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk CLK_AXI4_SD1>,
+				 <&clk CLK_SD1>;
+			clock-names = "core", "bus";
+			status = "disabled";
+		};
+
 		dmac: dma-controller@4330000 {
 			compatible = "snps,axi-dma-1.01a";
 			reg = <0x04330000 0x1000>;
-- 
2.47.0



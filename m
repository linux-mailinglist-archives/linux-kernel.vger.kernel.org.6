Return-Path: <linux-kernel+bounces-538523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB380A499A2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF98173188
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E614D26B95A;
	Fri, 28 Feb 2025 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3uOfZ2j"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E76126B2D3;
	Fri, 28 Feb 2025 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746453; cv=none; b=qBM53cw1TsDRv0wONNGFb+qfVTg3HylRJvXceOAoN7frwE/3FIua1MyofbYrz9RV0UbU+4eg+ZvXDzrvEIkGVp0L+B446aqpb/22+FvtMYGgFFwFqyZQIjZf51Rp0OqWL69xKBh8MVTHt9KZ+RHxQHmzliOh3s0KwAIwVkpQ2Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746453; c=relaxed/simple;
	bh=pPMhzcYM3CTCeeRM3hVc0R8I+4MebI7ljV90QEYY07s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XN5nIMnv660HePMYAGbd7vZH7w2WkJuuXnOpFnuBOfQ+WSTtuc5SqHbHjSdFa2ftseMk3dTsYTt/JZsd5vIFSvmrTzrjxX0KCBi9hyQjCvjD1Bek5XQeTyXZp5iEZtNqUoZiKM7EF7BAcK45C3FeQkYGVLlqG9VIhXeM4DCfgGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3uOfZ2j; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22334203781so47407645ad.0;
        Fri, 28 Feb 2025 04:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740746451; x=1741351251; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zaPjgAHsPYLWvjG1+7VgSdE4nc17PmUEpTLjntHG71c=;
        b=A3uOfZ2jMe+S4TB7T4S22CuvANrduR1tOMFtSlHyKidk1HlOPk4ryi3XAqcf1WOtdQ
         5dh04HFxMOk2swb6REGpzJQYkW3Q4YY5znxFrtZXLX+nKKm66Pmr1Pa9pSamQG59ffrN
         P5WoSDGZiHf46qXWHuHlE8+GJfo0X2mnKXMhwbht8XwhAJWkAFmTqlMY5DrLAEZ7lysx
         1KyGCm3thSlSHIStABLVJwZRU6KpOSydqkbsqC0ynTcuT8kazAZTuSTkVO1iJlsma2P1
         KBUB8yvOuoRN+YOxFL7bUmY67xWm0iTiMeR9/T0/RgM7YeyZgcG3qC8gnGghsmu4ale0
         aO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746451; x=1741351251;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaPjgAHsPYLWvjG1+7VgSdE4nc17PmUEpTLjntHG71c=;
        b=TRTqHCo7AZ1ZRgv4Vk1BZy4L5J/ol0uj9dG+NzsKt8znPat3mvvhsPHSUl+0RQznpO
         zgOvuS8vAE1my7AN1wn8GEW4DtFpkwqVecQizf4/lWSWL5K3qEzcVqmOBYl1bje14QdF
         U34pzkkntPZ7XhAc8szILRPUponjdFeweuAtS61AvNAltOMgo77NmKVW4VWg1biqFwPz
         LXqI/5iASsjan3ZIaJynrUw+059d90oXx9okGZBRGYyymX3BUJn/KdtosJ2u86qkltN/
         X7dTfFU+1+uKUwjhwKPoGmYLXr9flO/vCURSMzZoN7nExMkgTDDOKl+h3xQ2AjEsAelb
         jCSA==
X-Forwarded-Encrypted: i=1; AJvYcCU0lxgap9JbhZgq0jDzW/ZAmbFZGVGi2DyChATwTYz5chn88Ayr/f+ZupXuA1shJNvfRO0GlR9NHYagG0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FaDWclwS7r9p+c3ad22edmcsyRW7DGz1utSAI4uoCgjw4eLx
	EyzMXCVVbquSzRsWn/lm4PHM34OAhC6r1xzfh42V+3XVkPy5jU3fKunciUy3sWRvVBNa
X-Gm-Gg: ASbGncvL73r1JkrIA4GfHOvD2tG9pNHzpj8mOiJcH4WJb9G31yHN8Tm/FMeSx+wG3k4
	zEZzHhSltVDFv4JhgVq/v6Hno6J5x7focHrWxFREnbBB0Hl4i4m1Owzt0FhTleTQ3ems88zP+1Y
	L4xQl+qj9SLvEtpJFpJXuIIfCDI1EDcJTucyOExgBF1YttdJLA6FPNFMXv/FwAXNTjw4spFOMWD
	GH6oDYtV466Bb9LhAuI0x3PO3LtF6O8iQJPqLdN7PumdmOx/ZS48A2hnrSdTiaY0MjvUrjozFtK
	8ro0wksu99SZDw==
X-Google-Smtp-Source: AGHT+IG2oguQtkP0baYvz7DFJRXL72Jyi0nbCU+efrgTYtEnyx8hDBEi/ILU1lDlG5ECXjkwwcxA3Q==
X-Received: by 2002:a17:90b:498b:b0:2ee:8253:9a9f with SMTP id 98e67ed59e1d1-2fea1346613mr12045174a91.11.1740746450459;
        Fri, 28 Feb 2025 04:40:50 -0800 (PST)
Received: from [198.18.0.34] ([2401:b60:a::698:7eb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea676c55csm3624891a91.19.2025.02.28.04.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 04:40:49 -0800 (PST)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Fri, 28 Feb 2025 20:40:23 +0800
Subject: [PATCH v2] riscv: sophgo: dts: Add spi controller for SG2042
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com>
X-B4-Tracking: v=1; b=H4sIALauwWcC/2XMywrCMBCF4Vcps3YkGRUaV75H6SJNJ+mAvZBIU
 Ere3dity/9w+HZIHIUT3JsdImdJsi416NSAm+wSGGWsDaTopohaTD5g2gT54smys8rYAep7i+z
 lfUhdX3uS9Frj54Cz/q3/RtaocTCtsTyaq9H6EWYrz7NbZ+hLKV//58KnngAAAA==
X-Change-ID: 20250228-sfg-spi-e3f2aeca09ab
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, chao.wei@sophgo.com, 
 xiaoguang.xing@sophgo.com, Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740746442; l=2729;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=pPMhzcYM3CTCeeRM3hVc0R8I+4MebI7ljV90QEYY07s=;
 b=MXqgr2mcGpw61fx8C5ZrYZfxi0VQxHbEiCtbasaOy/l+UsC9ySW1oMZiECMbe7Z6EzrpdMDf3
 8e33dSukgSJCTHvc6ot+tBqGiX8pxcZzdamJjhsWdceYQTAQyZI5FqC
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Add spi controllers for SG2042.

SG2042 uses the upstreamed Synopsys DW SPI IP.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
For this spi controller patch, only bindings are included.
This is tested on milkv-pioneer board. Using driver/spi/spidev.c
for creating /dev/spidevX.Y and tools/spi/spidev_test for testing
functionality.
---
Changes in v2:
- rebase v1 to sophgo/master(github.com/sophgo/linux.git).
- order properties in device node.
- remove unevaluated properties `clock-frequency`.
- set default status to disable.
- Link to v1: https://lore.kernel.org/r/20250228-sfg-spi-v1-1-b989aed94911@gmail.com
---
 .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts |  8 +++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 28 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index be596d01ff8d33bcdbe431d9731a55ee190ad5b3..c43a807af2f827b5267afe5e4fdf6e9e857dfa20 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -72,6 +72,14 @@ &uart0 {
 	status = "okay";
 };
 
+&spi0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
 / {
 	thermal-zones {
 		soc-thermal {
diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index e62ac51ac55abd922b5ef796ba8c2196383850c4..500645147b1f8ed0a08ad3cafb38ea79cf57d737 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -545,5 +545,33 @@ sd: mmc@704002b000 {
 				      "timer";
 			status = "disabled";
 		};
+
+		spi0: spi@7040004000 {
+			compatible = "snps,dw-apb-ssi";
+			reg = <0x70 0x40004000 0x00 0x1000>;
+			clocks = <&clkgen GATE_CLK_APB_SPI>,
+					<&clkgen GATE_CLK_SYSDMA_AXI>;
+			interrupt-parent = <&intc>;
+			interrupts = <110 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <0x01>;
+			#size-cells = <0x00>;
+			num-cs = <0x02>;
+			resets = <&rstgen RST_SPI0>;
+			status = "disabled";
+		};
+
+		spi1: spi@7040005000 {
+			compatible = "snps,dw-apb-ssi";
+			reg = <0x70 0x40005000 0x00 0x1000>;
+			clocks = <&clkgen GATE_CLK_APB_SPI>,
+					<&clkgen GATE_CLK_SYSDMA_AXI>;
+			interrupt-parent = <&intc>;
+			interrupts = <111 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <0x01>;
+			#size-cells = <0x00>;
+			num-cs = <0x02>;
+			resets = <&rstgen RST_SPI1>;
+			status = "disabled";
+		};
 	};
 };

---
base-commit: aa5ee7180ec41bb77c3e327e95d119f2294babea
change-id: 20250228-sfg-spi-e3f2aeca09ab

Best regards,
-- 
Zixian Zeng <sycamoremoon376@gmail.com>



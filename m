Return-Path: <linux-kernel+bounces-200259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBEA8FADC6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24041C22F92
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C403142E89;
	Tue,  4 Jun 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp5h0MG9"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D747142906;
	Tue,  4 Jun 2024 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490504; cv=none; b=kbaxgvpz6UG1YHpRdGgkVMvKP0ZiLZef5Dc07A/EGnGv3NZWgpP2C2D8G9LixuOo19U+7GynuJjnVOcD8kSWGvwHjgylOARUII7VBEHgPAq2BLxwxFAqaj9VOKLhxk+uicGVZR8sYtBxqOO1HmGWWCFbiBkLas3Mg7e295ve9G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490504; c=relaxed/simple;
	bh=sBNvRH5TEd1tQdvf9rrNMajCAWgqpaOwtjRYOaUk8/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oJuGAx5Kooh6zGwYnxciZ48zmRXS59PLhdn1t8hlB4ODIN5E0q4FhLVPzqxBBLFcagasLqnzgxv8IZIjtO0Z+ePvRmunIuvZy4gcRPyMmg1VepkUV/N+GyDbe+q9MNJnqsHvM285doI5LDuASAPzn/+3yEV1SLF7G627G+rtcn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vp5h0MG9; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6265d48ec3so553485166b.0;
        Tue, 04 Jun 2024 01:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717490501; x=1718095301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fgqvf7dSV2wg1wNnuZIK3NfsH411d74v9AFFfs0leYc=;
        b=Vp5h0MG9CMIYYb27z9bGNhO2jqERzsnrG5BrJKgwESqNAcMkKGJwi43AJ+RpXlzoye
         0JwvlQB/w1YerSY+rI3pm5qJ8hpokZJIdRwhA5aoqE9rv67swiW3gZTpti8dec+Amisd
         ejGPiv7jfakAomNZj4nbPrO7o6Acrcm0ZP1LA7oANtDvwiqE0px+b2VD+cM32X63P6Aj
         +PJrkjmXuzSJhS4RCQwA6ewiCUj+U+9DBtaYkOaI12cG6JqzQtNY6Ao7T25i7oJ398Eo
         8/l+EDI9VLGvFnxOlP+tMvEwMRGdLLJpYgQj1Ul4S7iLRKR+WGvh/HpOpooYiY/2G3of
         GJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717490501; x=1718095301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fgqvf7dSV2wg1wNnuZIK3NfsH411d74v9AFFfs0leYc=;
        b=mN2k+4Cabt+T02rJOz08uGuDNgCr8MzTr3ZxV1MFr2Kqdf0d/0sgzhP/6Be159j+sz
         7GnhsGUEAWh0GF3l5R1sBJ00+HHdCeTChT9FvSzhU9blzehZxWZlafTssSQXqTTqLTPD
         Cs1S6Dxk8e7/NakpVQ3PyjI52rj0nsxN0W+uSrESOSwrun749FA56ngmgr8Yin5gAz5B
         v786NFddRum9KqGUfTFVioAON4rMEib9Qb6ir4BIPRSxLb2hrtkB6eKEgiRnx01dXf29
         DWra5reTScThBPmJgJiJP8NV77t+Wf8le6USq5BA3skCKyuPaigeJ78Cpf8k6FQCXEnX
         yVSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYSNELxWYvHOjEomXdl90NvZE0FbKCi6WsxaWG9v1QTmZ3WN3UWIqgePeNws2T9gHCagvjPTC4v7wCxFJD5N4ZSVdZgHLBzWXWvCCGl5XPHOjlxErRY4yIh9KyHcD7ahS7mYrsYfLWYg==
X-Gm-Message-State: AOJu0YwFGhhAY/N4Ybklam/ecR1Lm4oU/9OLmLA2O4gKuVur2JQbEs0m
	aDltMaPHDJIrmMxJ1wtv7qkFllZMD3vGpLFI15WUSQqszHgCqKV+
X-Google-Smtp-Source: AGHT+IF5RkpOyKdBjOA7FhxkRqHcjGiGJP05hVM1+o69oyRQ6HrXgoBqgxpOdIC/4HMia/nXUvIFQA==
X-Received: by 2002:a17:907:9708:b0:a69:2553:92b8 with SMTP id a640c23a62f3a-a6925539323mr273452866b.34.1717490501265;
        Tue, 04 Jun 2024 01:41:41 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a692ad28816sm166550966b.31.2024.06.04.01.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 01:41:40 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/2] arm64: dts: meson: add GXLX/S905L/p271 support
Date: Tue,  4 Jun 2024 08:41:34 +0000
Message-Id: <20240604084134.3315841-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604084134.3315841-1-christianshewitt@gmail.com>
References: <20240604084134.3315841-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a device-tree for the GXLX Amlogic P271 (S905L) reference design
board. This is a low-cost design similar to P281 (S905W) but with
silicon differences to omit VP9 and use Mali 450-MP2 (not MP3). The
SoC is marked with S905L and "2" (believed to denote MP2) resulting
in chip distributor stock lists and Android STB marketing sometimes
describing it as an S905L2 chip.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
NOTE: This patch depends upon the following submitted patches for
VDEC [0] and SARADC [1] support:

[0] https://patchwork.kernel.org/project/linux-amlogic/list/?series=858514
[1] https://patchwork.kernel.org/project/linux-amlogic/list/?series=858525

CHECK_DTBS generates some warnings for pre-existing issues inherited
from common dtsi files. The patch does not add any new issues.

 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../dts/amlogic/meson-gxlx-s905l-p271.dts     | 51 +++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxlx-s905l-p271.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 0f29517da5ec..0746e01b5853 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -62,6 +62,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc-v2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxlx-s905l-p271.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-gt1-ultimate.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-khadas-vim2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-mecool-kiii-pro.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxlx-s905l-p271.dts b/arch/arm64/boot/dts/amlogic/meson-gxlx-s905l-p271.dts
new file mode 100644
index 000000000000..1221f4545130
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxlx-s905l-p271.dts
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Christian Hewitt <christianshewitt@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "meson-gxl-s905x.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+
+/ {
+	compatible = "amlogic,p271", "amlogic,s905l", "amlogic,meson-gxlx";
+	model = "Amlogic Meson GXLX (S905L) P271 Development Board";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+
+	sound {
+		model = "P271";
+	};
+};
+
+&apb {
+	mali: gpu@c0000 {
+		/* Mali 450-MP2 */
+		interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+			<GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "gp", "gpmmu", "pp", "pmu",
+			"pp0", "ppmmu0", "pp1", "ppmmu1";
+	};
+};
+
+&saradc {
+	compatible = "amlogic,meson-gxlx-saradc", "amlogic,meson-saradc";
+};
+
+&usb {
+	dr_mode = "host";
+};
+
+&vdec {
+	compatible = "amlogic,gxlx-vdec", "amlogic,gx-vdec";
+};
-- 
2.34.1



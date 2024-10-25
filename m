Return-Path: <linux-kernel+bounces-382074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB9A9B08B4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFB41F274E3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501AE187321;
	Fri, 25 Oct 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgToPfiD"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7F15B130
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871012; cv=none; b=j8C/MqwaQPSsfp9XHAePFFR2iPck6WGv+0c2zL6Jy3oy89QiaXfCKfr3w3EBnwdaqI5r1IATXQaczNjN46HneYYPq+7QjfJriaNembEtWrEcJtSt3kCx2XTKHbVPbolSnjCCJp0xUwaAzfFlMXGN1bHjxyE29kuTetwIPKKh79E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871012; c=relaxed/simple;
	bh=CjgCGF8KDBEgjUprVnwaPw0NVN/4TSImNIlCw64dsCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVkNKM6jcRfV6KAWuAiNj1dTC+4S582DmzlBQxJYVU4uUxasZnEon/NQEDHRYiMeZbWvjHFjcRX7Yw+lSarplY/7gKZ7UGkFH7Xr9IGA0D+4hSbMFQBJrnu4lS9D2wlUmjMK9Pm8ytJRpdwdvf/HOgO9u8R/e6sbV6urAw5OYuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dgToPfiD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43152b79d25so20050335e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729871007; x=1730475807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGqv0lAx0Oo2mFI1vmKjI6WnegojsRi6EofkIgma6Oo=;
        b=dgToPfiDTN2IvBx2TyK6RqszgmLtG/3yta3t73yMComKLDwJnZFj3NqgU5sYvcZSeG
         oviypjYBE0yUqW415DIaINj0seO6pjZ76xK5Rh+NQTnx6H5FXunDCkatwJzr5vHl81LS
         48TP7iqZnfXPKB6T2OB5PaiMcZRSvQi2PFRsqQ5cDPfvjddDSioukeyh+6hYXbRAeHgl
         DLdUTYXmqxElMt/Vn2mXuwHXk7lPHnWwAAv7QxqcY5hb8pcccumiXacjApBXF9DOJxbC
         bcB2oxt19W6ly2iWwHDtnZJ/2YoTXQOrEreVgrQUDdpkwAm+iSIuM+ljJvYDWCLBMua8
         52Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729871007; x=1730475807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGqv0lAx0Oo2mFI1vmKjI6WnegojsRi6EofkIgma6Oo=;
        b=iRUym/Rx5Nw3dcWIcTd0XiuN0z02Sh2owqyVUBWvM3iCRKN1vGHKjXh65UNjLZ4CTD
         EUndbpU0+ZSTM9oO5TyZVFYKTZATGQigmFL6IW+iYe4Yxr95SzISIexWMjjTYBE52bKa
         v3ZgGtH7hQ5L1PE0Wf+ooyl0ruhc8ZuKzXT8UHYKmdFk72K4k6FVc5J1m9S7FzEcQhnx
         hcFYNKLP7wC82hA6h52GWch9WjQfH/JyODlGqfrujIwmk3z1T0fJm0UOoROWc48WnfOT
         /OfTXwJlyoF4PibaAAenfa6pyQuGZ6uqoNsM5dENFFIRToNQTzbji184SkBYVc5pr1aI
         uBlg==
X-Forwarded-Encrypted: i=1; AJvYcCUMpcqA+8y+5MQiIWCUTX9p6xfJbp0ebjMu8SVFTG1B+Tsu3iicl2Lq74+mkpyVURRwHsrIZL42s5e8DsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv9jcFEahujhBGxtRQaEFqIvDl/l8A9d+0hRwjfJ4Bf0Y4ezbQ
	HSDxtNbQ+xxBnIRr//IFWueKzZ+89EV4oWDbPFnYdfTOCIV+SM6Scslb5cwd4IACW70k7bUCioQ
	zc20=
X-Google-Smtp-Source: AGHT+IFHECj8EUQyf8YhHo3IpCwoRjMToLWTTJ77dLtZvc1gyMZs9S343YFJmQHzzLlYGaKwZuE0MQ==
X-Received: by 2002:a05:600c:46d4:b0:431:60ac:9b0c with SMTP id 5b1f17b1804b1-4318415c989mr73914985e9.20.1729871007272;
        Fri, 25 Oct 2024 08:43:27 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b479ffsm1829092f8f.49.2024.10.25.08.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:43:26 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 25 Oct 2024 16:43:24 +0100
Subject: [PATCH 2/6] arm64: dts: qcom: sdm845-db845c-navigation-mezzanine:
 Convert mezzanine riser to dtso
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-2-cdff2f1a5792@linaro.org>
References: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-0-cdff2f1a5792@linaro.org>
In-Reply-To: <20241025-b4-linux-next-24-10-25-camss-dts-fixups-v1-0-cdff2f1a5792@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Depeng Shao <quic_depengs@quicinc.com>, 
 Vikram Sharma <quic_vikramsa@quicinc.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-dedf8

Convert the navigation / camera mezzanine from its own dts to a dtso. A
small amount of additional includes / address / cell size change needs to
be applied to convert.

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # rb3
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile                                  | 3 +++
 ...ation-mezzanine.dts => sdm845-db845c-navigation-mezzanine.dtso} | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 7145748afaf53c816e7b3efd8d5f583a2efbb82e..1660c8a95f677847c405bcee42cc5e26d8a98d51 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -211,6 +211,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-cheza-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c.dtb
+
+sdm845-db845c-navigation-mezzanine.dtbs	:= sdm845-db845c.dtb sdm845-db845c-navigation-mezzanine.dtbo
+
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c-navigation-mezzanine.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-lg-judyln.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-lg-judyp.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
similarity index 93%
rename from arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dts
rename to arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
index a21caa6f3fa2594df2f08e48adeeaefd7a33396e..d62a20f018e7a7e1c7e77f0c927c2d9fe7ae8509 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
@@ -4,8 +4,10 @@
  */
 
 /dts-v1/;
+/plugin/;
 
-#include "sdm845-db845c.dts"
+#include <dt-bindings/clock/qcom,camcc-sdm845.h>
+#include <dt-bindings/gpio/gpio.h>
 
 &camss {
 	vdda-phy-supply = <&vreg_l1a_0p875>;
@@ -28,6 +30,9 @@ &cci {
 };
 
 &cci_i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	camera@10 {
 		compatible = "ovti,ov8856";
 		reg = <0x10>;

-- 
2.47.0



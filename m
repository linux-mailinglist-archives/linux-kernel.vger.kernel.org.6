Return-Path: <linux-kernel+bounces-354002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA36993603
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FBD9B22A19
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4161DE2DE;
	Mon,  7 Oct 2024 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PsWncHAy"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9B41DDA3B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325387; cv=none; b=KzlQnQe/1uhGg9UdymxDI0IP60SVkRVJ7J02msZBpUiXqs4KUb1WeOCAocd7DAyrfF66sH3LXIpXF0QJXCNhqnMw1DnST4Awbx7VU7iAQtYDWaGISJj4QWPvSpWzbbpQsJKt6n9SC58h1vBbxdtdTxv1WHcP1z2H7BrL38a8YwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325387; c=relaxed/simple;
	bh=9i5n6TqCj0k1ThHHBY3k/t7afoVnNGJdMEiA0JI+g9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nA+skEMgpDoAz98FIvVqpNbL5aXyjP3RWtLkjE8UGEwiYXwkla/KazjnA+gxjKqsJh1EZA8sNyUbUCQMKyv1gwUi/d5yStXLzeP47AgDugwHrDkipCDRd830t+ENsVWxgy1g4IPaOwD5d++iA6GOnsj7v9ZfamAWAvL2pHOvCDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PsWncHAy; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c89f3e8a74so6647990a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728325382; x=1728930182; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KboijkeIl0WHBQ71mVXnbHN7cxUj6HXnHwgMJMxu0d0=;
        b=PsWncHAy78X9kYwn9ZRbo+o5tg6U1dGAsWx7cY3LkXVo+0tqR2Qq2u3H4liRQgR3PX
         kONXEfoRPomZXlpdstHCCQ++GKrjgqOY+fYh39vSNy9RXA55altD14XGGg4RT7Ge15Qu
         pWuHtSlJVdQj4XqltSZ34BiJVnO8nfDA9wkxD4BR7NcW0i+vhbSG6fEa4p1lrfDNf1Wr
         Ho8afsJgk5x02GL9jQ/+U657jwgz3SVkRad3bq4wnoqlj4+UlgVxj0wZB6rqxL/5edEu
         YR19CoOffG82b7tjBvME5txEbHXGVMIRgLyo+qTVrr98zQi+SS1NBBlSB1hMJpdYVUJc
         Ppyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325382; x=1728930182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KboijkeIl0WHBQ71mVXnbHN7cxUj6HXnHwgMJMxu0d0=;
        b=MiB/Sul5mb1shqxGzXxeS6AgjavoOpe6So1Z+U6doDApUMPSyb65nZq7N+iLXUbP+k
         cCvZxC9I6pVGVEfWwLfMIO2fC26FdCt8peF38DU/OfvtLdHA07jZa6zRRhFhi6enW44o
         ZG68jOoOLrDZW9S6PdhuCWveB33teWXKoMWjncwVmu7sGcXTk4oxFXF+fh9cPFzharL3
         FueLd6vo2PuaRrlQrL+rBvPdaP/Eu9mnIPvJj6deMrxRSBYFf2l4lxnu+lvWtZrUyADU
         8EV51k3+4B7oFVjKAQAM987M6/P6MiWrxru1rHbC3qlSwIoDKlSUOVRSW0XmxsdlTg7i
         luRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi2LNz8SmpCTMUQe+tOI91ztUfl3HeWJgx4foKHQ6Ac6JXn/5L+Z49CCCLLEi4+XqOJHSQ0q42MVlE6N8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1MipHMh675mIf17kugXxx1jXSImjtFim9ZEGoc8c+7jNkrrIx
	zLtiya1J+zMk6daHpy6+IwGGmr/SX6B64ln4WyQ1W+CsCNWGXmIk/wM5MsXiNZg=
X-Google-Smtp-Source: AGHT+IG9ePfC+8NUvoRvs49MolyA7tHJU076KVG84tGKTi/fiABzVTM7dNZXMWu0De7eDcpHggXOlg==
X-Received: by 2002:a05:6402:518d:b0:5c8:9515:cc1 with SMTP id 4fb4d7f45d1cf-5c8d2e1e315mr10086236a12.7.1728325382059;
        Mon, 07 Oct 2024 11:23:02 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef40:4109:b8c2:873b:4a28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb34csm3452963a12.59.2024.10.07.11.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:23:01 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Oct 2024 20:22:25 +0200
Subject: [PATCH 1/3] arm64: dts: qcom: x1e80100: Add QUP power domains and
 OPPs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-x1e80100-pwrseq-qcp-v1-1-f7166510ab17@linaro.org>
References: <20241007-x1e80100-pwrseq-qcp-v1-0-f7166510ab17@linaro.org>
In-Reply-To: <20241007-x1e80100-pwrseq-qcp-v1-0-f7166510ab17@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.13.0

Add the power domains and OPP tables to all the QUP-related UART/I2C/SPI
nodes to ensure that we vote for the necessary performance states. Similar
to sm8350.dtsi, the OPPs depend on the QUP instance. The first two
instances in each geniqup group need &rpmhpd_opp_svs starting at 120MHz,
the others already starting at 100MHz. I2C always runs at a lower clock
frequency and therefore uses a fixed vote.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 178 +++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 0e6802c1d2d8..06d27c65dc11 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -679,6 +679,34 @@ smem_mem: smem@ffe00000 {
 		};
 	};
 
+	qup_opp_table_100mhz: opp-table-qup100mhz {
+		compatible = "operating-points-v2";
+
+		opp-75000000 {
+			opp-hz = /bits/ 64 <75000000>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+		};
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			required-opps = <&rpmhpd_opp_svs>;
+		};
+	};
+
+	qup_opp_table_120mhz: opp-table-qup120mhz {
+		compatible = "operating-points-v2";
+
+		opp-75000000 {
+			opp-hz = /bits/ 64 <75000000>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+		};
+
+		opp-120000000 {
+			opp-hz = /bits/ 64 <120000000>;
+			required-opps = <&rpmhpd_opp_svs>;
+		};
+	};
+
 	smp2p-adsp {
 		compatible = "qcom,smp2p";
 
@@ -833,6 +861,9 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma2 0 0 QCOM_GPI_I2C>,
 				       <&gpi_dma2 1 0 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -866,6 +897,9 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_120mhz>;
+
 				dmas = <&gpi_dma2 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 0 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -899,6 +933,9 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma2 0 1 QCOM_GPI_I2C>,
 				       <&gpi_dma2 1 1 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -932,6 +969,9 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_120mhz>;
+
 				dmas = <&gpi_dma2 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 1 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -965,6 +1005,9 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma2 0 2 QCOM_GPI_I2C>,
 				       <&gpi_dma2 1 2 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -998,6 +1041,9 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma2 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 2 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -1031,6 +1077,9 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma2 0 3 QCOM_GPI_I2C>,
 				       <&gpi_dma2 1 3 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -1064,6 +1113,9 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma2 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 3 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -1097,6 +1149,9 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma2 0 4 QCOM_GPI_I2C>,
 				       <&gpi_dma2 1 4 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -1130,6 +1185,9 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma2 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 4 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -1163,6 +1221,9 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma2 0 5 QCOM_GPI_I2C>,
 				       <&gpi_dma2 1 5 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -1196,6 +1257,9 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma2 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 5 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -1226,6 +1290,9 @@ &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 				interconnect-names = "qup-core",
 						     "qup-config";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				pinctrl-0 = <&qup_uart21_default>;
 				pinctrl-names = "default";
 
@@ -1251,6 +1318,9 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma2 0 6 QCOM_GPI_I2C>,
 				       <&gpi_dma2 1 6 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -1284,6 +1354,9 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma2 0 6 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 6 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -1317,6 +1390,9 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma2 0 7 QCOM_GPI_I2C>,
 				       <&gpi_dma2 1 7 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -1350,6 +1426,9 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma2 0 7 QCOM_GPI_SPI>,
 				       <&gpi_dma2 1 7 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -1427,6 +1506,9 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -1460,6 +1542,9 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_120mhz>;
+
 				dmas = <&gpi_dma1 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 0 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -1493,6 +1578,9 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -1526,6 +1614,9 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_120mhz>;
+
 				dmas = <&gpi_dma1 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 1 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -1559,6 +1650,9 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -1592,6 +1686,9 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma1 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 2 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -1625,6 +1722,9 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma1 0 3 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 3 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -1658,6 +1758,9 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma1 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 3 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -1691,6 +1794,9 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -1724,6 +1830,9 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma1 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 4 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -1757,6 +1866,9 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma1 0 5 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 5 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -1790,6 +1902,9 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma1 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 5 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -1823,6 +1938,9 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma1 0 6 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 6 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -1856,6 +1974,9 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma1 0 6 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 6 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -1889,6 +2010,9 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma1 0 7 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 7 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -1922,6 +2046,9 @@ &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma1 0 7 QCOM_GPI_SPI>,
 				       <&gpi_dma1 1 7 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -1998,6 +2125,9 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -2031,6 +2161,9 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_120mhz>;
+
 				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -2064,6 +2197,9 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -2097,6 +2233,9 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_120mhz>;
+
 				dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 1 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -2130,6 +2269,9 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -2160,6 +2302,9 @@ &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 				interconnect-names = "qup-core",
 						     "qup-config";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				pinctrl-0 = <&qup_uart2_default>;
 				pinctrl-names = "default";
 
@@ -2185,6 +2330,9 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -2218,6 +2366,9 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -2251,6 +2402,9 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma0 0 3 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 3 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -2284,6 +2438,9 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -2317,6 +2474,9 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma0 0 4 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 4 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -2350,6 +2510,9 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -2383,6 +2546,9 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -2416,6 +2582,9 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma0 0 6 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 6 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -2449,6 +2618,9 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma0 0 6 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 6 QCOM_GPI_SPI>;
 				dma-names = "tx",
@@ -2482,6 +2654,9 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
+
 				dmas = <&gpi_dma0 0 7 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 7 QCOM_GPI_I2C>;
 				dma-names = "tx",
@@ -2515,6 +2690,9 @@ &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
 						     "qup-config",
 						     "qup-memory";
 
+				power-domains = <&rpmhpd RPMHPD_CX>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+
 				dmas = <&gpi_dma0 0 7 QCOM_GPI_SPI>,
 				       <&gpi_dma0 1 7 QCOM_GPI_SPI>;
 				dma-names = "tx",

-- 
2.46.0



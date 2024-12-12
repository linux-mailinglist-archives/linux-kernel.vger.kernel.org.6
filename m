Return-Path: <linux-kernel+bounces-443522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0C79EF349
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4C9290D77
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0354022EA10;
	Thu, 12 Dec 2024 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/2yqmSr"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAD122C37D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022257; cv=none; b=DQdYX3kkO7U6ihYwiLHBidok+RT1wBwiIzPO2oMUMU5KP/IgBIqEZo2TWEHcl/XV8hv9KsX7JiIXnO/rHzMkNG8OuiuEfVbuWwaX3PkBCLAz0zgsDy4CSM+PYYiPfphFptEZn1QWFDsLD9yjCy+WJG393v/UrUXsJwW08cj3QoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022257; c=relaxed/simple;
	bh=SgtOEu5VxJF/itLH4MU4rr/m9XgReXZ60u/KyHa/338=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kC+nNA0FIRHeR/mLVpyzAhhR7TRpzF7MfCDs44sm8RPXo4q/DJ25yYIFyQFvccdrYFrcatDQoEbz3+7WOUUMOhFFPUgpWsyU7TsB5Wljxq+Q/ozBHjyLp9eTiAf+iW9PsF5/ZMbFIk4F+UEJMPjaFGY95wd19lS8zRfeTCEB5qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n/2yqmSr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so434300f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734022253; x=1734627053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWO0PxG5CXJ3EnRu0jeW5Q0WlKH2tVN14b+Xukv84GA=;
        b=n/2yqmSr7VxZ2Ezs9eUsfTb0MMwmvQw1aDZy14nXp3YfOt0/pnq36BfIdVqvfPBjJH
         X1OHAnTIip0hE75YAFhyOyhzLu1peaatudEWyuwSPDQIPbqAFtPoHvuzREb5uqi9sSRl
         hNziGZzxkTXO3nZiR2fUUpGOGi3dA3H8nxauZWy+hp95ytHn9hHSeIOU3BgpKGreaeRO
         WjqeC498eolhNJSCTuEGB7zs9N/yMRhaNEXHQZcsUWt42J7+dmx9O00ROSjdmZRjkoFQ
         9f3VCry/E74b0mSeODEuS3Zpwlw26scsxQxpKsFd1hj6aB9oianx7mpN/+Q/ZCtW478m
         QW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734022253; x=1734627053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWO0PxG5CXJ3EnRu0jeW5Q0WlKH2tVN14b+Xukv84GA=;
        b=XDc3NDbLdPuIFu7SpAXclC7SsnCtAyK3hSGfnmDEXq2YzAM0U6gtI3K45iD9yaOpgN
         y56ak44NgNeDSQ9HNo1hFkDYdfCbwPaF6AhMBSssR0VmCvf+Z/XcUxzUw1Nhhw2SKa81
         FDbxp2svF2TE+CnUCONubQBQq76zWT29RsdAGplBlr1PjPb2D1tTk4AnqRwX5ezhxbYb
         gghDTImUTXkqVFdtGu8TfKWNkIsau8WQn7wcL8Vm66tcYEYwOL+eEQwZehdE3vb7Q0Wx
         xdWj3w3uKSTzg8l+FPIDBiQnVTKD+H0fbKnQXssomKKmA+d1mzIoym0EhofEGETfk6HJ
         8YDw==
X-Forwarded-Encrypted: i=1; AJvYcCXp8ZO8DKBjxT40accwnZgSMhMCIyWFnhis04jCdT0vaA8XBKiMnUSOHdsVFpiHR+YE2DdvguqziTGN9+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxVY3zJjP5tsA4fOrpbhyIVrmJVkq+Ka/Uvvvbt+yB56LGv3gF
	Otfb4bBCHjYcVW9vPihkWmguHOSIcCcRB6KQKcHgfKxDWg1f2707gr3mKwMLmgo=
X-Gm-Gg: ASbGnctjyx6a6YFQ3/xmFsizgiWQvgHzTnKcV2ZkxWDK6tWrC4pSYYDJ0YQ/QzmNccp
	G2Ckg97MZWR7Ck+Sdp7zu+9nRCNVxy6Vgq5pq2E5AdsHHKPOoGSsNVjVApUZNXHL5x7bLBTraMb
	EyMyBNOSTOwazwPqzS0p+oynuW5cIzhoXfM7txDU4/rA9/8TkBOC6cxTt41GvXC/ODSEclfmBti
	EuJ3BuPZ7664qZ7L9DcJa/Lr5CpcqaHyA88v2DI1f7YBfnYlGaIyHu1
X-Google-Smtp-Source: AGHT+IHY2TWsulguCsig+J/FynQAHyw/rBTElycAERIMSbvDL8OlzaNxeU6By7hf9vIOaCo0zia5JQ==
X-Received: by 2002:a05:6000:2a4:b0:385:f417:ee46 with SMTP id ffacd0b85a97d-3864ce869d6mr6534579f8f.2.1734022253112;
        Thu, 12 Dec 2024 08:50:53 -0800 (PST)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4a25sm4518264f8f.27.2024.12.12.08.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:50:52 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 12 Dec 2024 18:50:40 +0200
Subject: [PATCH v4 2/2] arm64: dts: qcom: x1e80100-qcp: Enable SD card
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-x1e80100-qcp-sdhc-v4-2-a74c48ee68a3@linaro.org>
References: <20241212-x1e80100-qcp-sdhc-v4-0-a74c48ee68a3@linaro.org>
In-Reply-To: <20241212-x1e80100-qcp-sdhc-v4-0-a74c48ee68a3@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=SgtOEu5VxJF/itLH4MU4rr/m9XgReXZ60u/KyHa/338=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnWxRn96ySZHPblK1j2HeeG5CH1AXs6g7pp8DjX
 ohFIfCbjYyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ1sUZwAKCRAbX0TJAJUV
 VtQzEACtXSJnW7CJGeHK5JyBVivLpHCpKFC2iDGVMghmYrfquaftoVKlleB96k58GKXueMyTlHL
 GGA/Lf61WreUU1GcJ2I4sPVGUzqTU6ue0wtJKkE+Y8Gft7fyjTrcqC2v5exMHB9KH8l00sZbOEL
 z330U4OvYHRAyYycaidVkbdco8VHq2RZod6Wsf+W7pQK1boTiz4dFaCR4sy5ekz6XCeHOO8+lkA
 QWXgrHKCb0/QqWeHtzp3o9V1rek8p181BzcH39FGSl709Ks8dzIvr23Vbd+eDmftluNOyAuTGb0
 /zg5xJldv6u1kz3leWMHnzxeiupWEZbefwzABh6Prb1KunM59ff4o2qVsWrwuPZsTA7E8kbfQGY
 Pd2lzSn8ibS1yifnJ0I91Y+6SZDpjJrHgJROqTNy596C5eT2qSdPzJgvuV+A13MVnmxAMiDKcyN
 +klwJpAOVHJpr0GBMEy7w5Ppg0Xu9z+bwCNLugo9Q9V9XGC6BPf+Ab6bsq70BGbm6KhD+WqP65f
 xFtpzwkhtaJi4ZKDET20O/8ntlgPu06q6oEu3U6zV3HFfuz4JtCMOHJ160ZJL7ktXTGIvZvS6nW
 eJlcG4gF7nWuxIE3apQWm9/LU1KcQeapJsjUeBCxWXCTCjrkArLYNgVZHYaOEyQSdvkq+K7vERi
 NdLh9jbR+b0zT2g==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

One of the SD card slots found on the X Elite QCP board is
controlled by the SDC2.

Enable it and describe the board specific resources.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 5ef030c60abe2998d093ee60a6754a90cd5aaf72..efdf12d3339bffdca05cc019f12b67d681a6091a 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -731,6 +731,19 @@ &remoteproc_cdsp {
 	status = "okay";
 };
 
+&sdhc_2 {
+	cd-gpios = <&tlmm 71 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+	vmmc-supply = <&vreg_l9b_2p9>;
+	vqmmc-supply = <&vreg_l6b_1p8>;
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+	status = "okay";
+};
+
 &smb2360_0_eusb2_repeater {
 	vdd18-supply = <&vreg_l3d_1p8>;
 	vdd3-supply = <&vreg_l2b_3p0>;
@@ -872,6 +885,13 @@ wake-n-pins {
 		};
 	};
 
+	sdc2_card_det_n: sdc2-card-det-state {
+		pins = "gpio71";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
 	wcd_default: wcd-reset-n-active-state {
 		pins = "gpio191";
 		function = "gpio";

-- 
2.34.1



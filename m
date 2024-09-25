Return-Path: <linux-kernel+bounces-339719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F7A986974
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0301C20E27
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F051A4E9A;
	Wed, 25 Sep 2024 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3DO+t0L"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65C11A4E7F;
	Wed, 25 Sep 2024 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727306480; cv=none; b=Dzq8jxkR0vxN4rFgrVk5bl7nGg2b5SOx+kEp+qkosWVRGMkHNX6EtYrCtdrd/vtA41Ly4w6c/ws11XaZddC5vvex212sBEjPeDoHRk9KVMXQsvlEQ4Py4qrqJsLDjEe+C5wZsfKxSh/9cJja24K04Fvca4VzhQDzmZdPNQtZgpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727306480; c=relaxed/simple;
	bh=9MdjDmzaJSXdmEpYVFV1tpaG4DOpRWuJZAVX4CUD5lY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rzMVqfYT8RH5K4AKeLI+gjEI8ONqW5Fyc60up7QoJzDeLWspp6E7wUMitVdQOUvmGURiHJIWZQ8BI7qoiu6EnKUggtxktLV+BA/f+8EeYY4eSHX6/bItFwLtuYJDrdxiD1ANowiRhX1BL9zdmX5FhsmF3MubHQms766EKCLe43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3DO+t0L; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c43003a667so364765a12.3;
        Wed, 25 Sep 2024 16:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727306477; x=1727911277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Y0/b/12goaJOUtphQuMfAjI4BvBF9ykQVTYDGjgY+w=;
        b=F3DO+t0L88QEGkB1Q9ZPAYaWBERpTconWTZDAfCLGiubMXTg7j8FWiKwwioOUMOrN+
         tGbIjQEhaju+ntq4jQ0khLDyvkRcmkTdzGjPJbsyHm6hvVd8phnp+8LPTIZAkc2ocow8
         oM3jU53IxCfh+wL+cnl6Nz8IYnUENYEBymUiVZlZRNWGkb5vmAbPTqqwnarJtZa/ocJU
         O9vRr/1Om0fLh5ti9jyDHYBFK4xGaNG/Z5+S19fSdXt1YCgsss0D30cOl302+7AGVrPf
         hvk1/VFtzBLprdtftim4RuKCjvZquYDYDAB2KDZA74gj4THDvjsGZQVkmyXiWfnJNJpA
         w6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727306477; x=1727911277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y0/b/12goaJOUtphQuMfAjI4BvBF9ykQVTYDGjgY+w=;
        b=vPBaq8KyZXA5GpdqhfC8SCt5qFvgD9aygD+2WKW5gOveskvR+emVkK/Y8OOULktAej
         Ytex7BSHg1Y2yDhgmQzw2CbdpC5tRLt1+dAz7qfIy2bp0Sqqjhvz+IXhN1H1c5sPT7wA
         g8ZWPT3muMTVaOAahjvqMZuoOvFkNvHw3BJK3iQpjcf9TTUCxUtDyN+Gpxun0UDBYHdu
         wck80Uqnw6JJbLO0BnPspvJwLinUVKWO5MjUXk55cTacYEBiPPQ9GBcOlnphGwJ5f/Z0
         rPoodPqdMiUDDFFKu188IsIUyWXxRwwigvlYAX3LEg3KRRRid9V6KeaHnGHOQnbMv4ky
         jO/g==
X-Forwarded-Encrypted: i=1; AJvYcCWpeQ0cD/tclyyFpFepeIn/hgZZ9P/4erEblqZOpCLMTD+mtsYDoXIFl+dw9Txn4rlCXwkCouIuLejUMeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+aYAJheNiE2yiuJyXhQxMCWo5Y/bS160fgeBCDJa3klj9bW6V
	i2tNp7xYUh1TfnjcX2QK26kviRb2g9Ps5kk/dr3v5emMor/tA3jn
X-Google-Smtp-Source: AGHT+IEMfbfQnQA9qcYuWORwKKxs2GMl24az24OZdgZIQPCbXrTDPL14Gi7TSLFD2svMh9oBJTgYAg==
X-Received: by 2002:a05:6402:354a:b0:5c2:6311:8445 with SMTP id 4fb4d7f45d1cf-5c72060a8edmr3765685a12.2.1727306477046;
        Wed, 25 Sep 2024 16:21:17 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf48c315sm2481026a12.15.2024.09.25.16.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 16:21:15 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 6/6] arm64: dts: imx8qm: enable dsp node for rproc usage
Date: Wed, 25 Sep 2024 19:20:08 -0400
Message-Id: <20240925232008.205802-7-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925232008.205802-1-laurentiumihalcea111@gmail.com>
References: <20240925232008.205802-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Set the status of the dsp node to "okay" and assign and add
its reserved memory regions.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 62203eed6a6c..7ee69ce7b193 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -92,6 +92,27 @@ vdevbuffer: memory@90400000 {
 			reg = <0 0x90400000 0 0x100000>;
 			no-map;
 		};
+
+		dsp_reserved: dsp@92400000 {
+			reg = <0 0x92400000 0 0x1000000>;
+			no-map;
+		};
+
+		dsp_vdev0vring0: vdev0vring0@942f0000 {
+			reg = <0 0x942f0000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0vring1: vdev0vring1@942f8000 {
+			reg = <0 0x942f8000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0buffer: vdev0buffer@94300000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x94300000 0 0x100000>;
+			no-map;
+		};
 	};
 
 	lvds_backlight0: backlight-lvds0 {
@@ -640,6 +661,12 @@ &sai7 {
 	status = "okay";
 };
 
+&vpu_dsp {
+	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
+			<&dsp_vdev0vring1>, <&dsp_reserved>;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
-- 
2.34.1



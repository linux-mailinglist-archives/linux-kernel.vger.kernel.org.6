Return-Path: <linux-kernel+bounces-332873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7AA97C016
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301D9282EAE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCDE1CA6B5;
	Wed, 18 Sep 2024 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRwq2xZH"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33C81CB312;
	Wed, 18 Sep 2024 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726683748; cv=none; b=oTmkZ1ucU+TsDvkGIpMAQVNsuquzRMEUjsXANcqKWjal5izWHI+tT9c0KYYoj53fm409028sJ9wWn6i83s1QRmpRhLWDleQwtvhy7R1DSe5856RNrvmRNhb152TsUYFL0wSuLkVKc0KQIxGCq09CTi4gYXDUXri80OM1O7Iib+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726683748; c=relaxed/simple;
	bh=DCbRa/f6lAB68JZc/cfg6LOcGdUSng0Pa8LcCred/Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KaJUHDnVIt5cqHEyaqkGdPG2B2yss4JzUwissGQS2cgZAsODDx4vzG77Fb9krCtf5DWJ+zIV+k6DuxA+KO3qN4ZqtyEJXbhYj1h8TGZlh8OGXZvv9PABEiAYnDOCd/IHqbPmPvdrvdUF4shZNnrPOTRAhuhlr8fIOFy+VlyDBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRwq2xZH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3770320574aso5100342f8f.2;
        Wed, 18 Sep 2024 11:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726683744; x=1727288544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vwtyPA2l11CJb7SVjnOfGfynXGLzK7+CceW4ZxmWwQ=;
        b=GRwq2xZHL920ZkgCf4wCbfdX1jo00QVFM5Fyc8yUTH5TTORqYDkycv9uixkRWQ8QVO
         6+aJNDPa9rkQKZOXES2W+Fsn7astu6VYabOqcH6KRvZDkQ4DujHJKodnH4/m5GvA/vwy
         iYA8pYSvbThp3NtlYndRbC7WANJLqP0/ahWSreT3csP0n44rFJ8MD8K6znqyVj/HUcLx
         WPWMgbi+SNxGeedEik1znLO7aTPZcJ8Kq3mWpJpm+BfDuNevaRk3jvgcsNSwiVWkdvVq
         hnvh3SLh3A6IhNJsNiv3udVY5PLqYXL/GaYiNNC448R01qEoipZL5IqUSW2Cd56fUyPP
         baiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726683744; x=1727288544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vwtyPA2l11CJb7SVjnOfGfynXGLzK7+CceW4ZxmWwQ=;
        b=bKMj7nE27MBXO64USYF3d8WpC2GYzwOSMtn7LCC3x4nY9YuiXTPufxSk2Om1z1Mmx2
         fcjzPswoe6oqDS+O0sXQ7dJNHCN/wuNUbm6kSZ9Nuv7f4gjSN6WvsdRM6YcQZ8uxv5tl
         Zzwn/2f2hWsg2wnPXz/tbv1BRsrz6IwFiRdGRqcrHeSKa+y09iRcBQunFpqCXLz/aEy5
         uHx894DW8ROkV8lXHLcGCXPnWNjqs0R4no1B1tDJ7Fv0oGFsa4/HKKa53jLQycHsXUas
         3dXYtxb3zWrL2kGwznQ3qR3Co61p3J9S5ALOrDsPn4Zc7mf6narxmnMdxepB7GtB+RPy
         ZABw==
X-Forwarded-Encrypted: i=1; AJvYcCXWpxX27hUQqZHQvKJ0UzML6CpMFgFiJGDpdwlIRvLHTcBLNcBAwXDdMl/W4Z7BX7gJE9Z8JriO9aftbQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFdIAM30DfmgHD2ewew6EaGBdz5MKcZZhwExTScKPEcy4Hmqd4
	GBiZpXpOt3CrByTBiZZLcys3clfTaOoZiJ04JWNP4g4E36eUo4apRgDzFhyw
X-Google-Smtp-Source: AGHT+IFrPlkg7pCSWwwa+h63rcteR1uLcfkEtFxNrvhuLVGMph3cB8EcAFzN/c5f2X/C6FPmS+VNbg==
X-Received: by 2002:a5d:5c88:0:b0:378:fe6e:50ef with SMTP id ffacd0b85a97d-378fe6e51c7mr3605756f8f.5.1726683744042;
        Wed, 18 Sep 2024 11:22:24 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5312dsm5200146a12.23.2024.09.18.11.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 11:22:22 -0700 (PDT)
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
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: imx8qm: add node for VPU dsp
Date: Wed, 18 Sep 2024 14:21:16 -0400
Message-Id: <20240918182117.86221-5-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
References: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add DT node for i.MX8QM's DSP, which is found in
the VPU subsystem.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index f8b577ebdbef..ae0165a44dcd 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -581,6 +581,33 @@ mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
 		clock-output-names = "mipi_pll_div2_clk";
 	};
 
+	vpu_subsys_dsp: bus@55000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x55000000 0x0 0x55000000 0x1000000>;
+
+		vpu_dsp: dsp@556e8000 {
+			compatible = "fsl,imx8qm-hifi4";
+			reg = <0x556e8000 0x88000>;
+			clocks = <&clk_dummy>,
+				 <&clk_dummy>,
+				 <&clk_dummy>;
+			clock-names = "ipg", "ocram", "core";
+			power-domains = <&pd IMX_SC_R_MU_13B>,
+					<&pd IMX_SC_R_DSP>,
+					<&pd IMX_SC_R_DSP_RAM>,
+					<&pd IMX_SC_R_IRQSTR_DSP>,
+					<&pd IMX_SC_R_MU_2A>;
+			mbox-names = "tx", "rx", "rxdb";
+			mboxes = <&lsio_mu13 0 0>,
+				 <&lsio_mu13 1 0>,
+				 <&lsio_mu13 3 0>;
+			firmware-name = "imx/dsp/hifi4.bin";
+			status = "disabled";
+		};
+	};
+
 	/* sorted in register address */
 	#include "imx8-ss-cm41.dtsi"
 	#include "imx8-ss-audio.dtsi"
-- 
2.34.1



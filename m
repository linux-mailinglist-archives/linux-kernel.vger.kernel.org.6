Return-Path: <linux-kernel+bounces-426700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC60F9DF6CD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4415AB215C6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04DD1DE3B2;
	Sun,  1 Dec 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hPNFkSUj"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8904A1DE2D4
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075267; cv=none; b=ScuAhkOJaxU9g2DdRNM60iHobeZqu84Ii6UUv6QevWKLvfDyi000u2KtAGnrfHfGUPf3BIwFlO9ccA3P/rHAFpptwaLBu4erNZF+AgpmGMGiX7WWoDSokH2rIuXjB3RXz8ZYnZFG2Q+icEeHjlvyAF0uPHXJUM4sURyRr+2DG+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075267; c=relaxed/simple;
	bh=b5sQPSBRgo47tB+ebeagJ2XOKAg7lFzF2AsAXWJ+C/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CR7jGSb8hbOiPmUMjN69IlrD9/lcd2fu9r/TqCX5TU2LuBhahq9Y6WrAVLrc/aG+VRGbFf4WcLlhHPmO/3DTQQC41ZqOvz7PvBibiS8awfXGPy2OSqOL+hIYYgket4Xy8qn5ggIGJEhVROELl7BH3ZzODj8xdWerSv8HZw/Ipjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=hPNFkSUj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so627221866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733075264; x=1733680064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/0iXUlDnHB4vmCkCvqYino8rMZyy/qKapLkvYLstbs=;
        b=hPNFkSUjAPjJUcejSQC80M0Kw+iwjQ63s25Kj69VTsFkD6UT1riEL1Oeg/CnAPQje4
         IZQd7kFjWtAR7ULcy2VPaz7Kq6p4ozQcNgrRaeczDxxF8gfCzsN1oKUaA7eEIIOYuAzs
         GstBHL1MN0zfRVujaC2DtV6TZBbqHR8/BKytE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733075264; x=1733680064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/0iXUlDnHB4vmCkCvqYino8rMZyy/qKapLkvYLstbs=;
        b=doFw9eV1lauB9uwdSlD+EjMYVrlt19p9OmiAhU6XY/q/eD+WOZPg3D75ZvFC9WdX8r
         4T24BvhbLQFb0HCz/kXh0Owr+wjZcShO3/aeDvqVbj81TFqhnb4PO9TMdK34QlFbW/MC
         0oR3kffkQAIZgCRbnT3R10L51z/0ooWsdmWmBa19xRbUEbrmHKKCaICHPpofmhAbcxF4
         Fsx3ZTJ80Nw4L6a/AZcr3H1qi67E+nGioYgBkusFJeL6gSdLUCn8kqNVTyg7lERCJRpP
         D6b4dCTJfmWLmkhOU2zu6sTlQddyGkAQAP+MuGJdncDroybBpHqjL4ox59fGGIIFhx+G
         A5rw==
X-Gm-Message-State: AOJu0YyNc9ECmSX/WWJOX7MNYkYSHdO11yKxM8TPRIkVwE6WzbWHFJ2j
	0MV4Nexl9ntSw8ZeU84hyCOlQmFQDLB3S7LhmvRQ3SRHPZE8gapdPy5N2z5ps6imqnxIJ6xifEh
	V
X-Gm-Gg: ASbGncubn6kb6uzDVo7pLNZ7/ZnAUln03jyDaqNudot3y067cFXktkjFjeDyHbNTGis
	3pdjbkGZ4Ti3KLlxSAiEfPDfW8Oy/NxLTpv1EiA5e8miP31bAMRio7eXg9cNVdEk6fdN0A2nF9R
	qtb6d/tZZ6ESsxQtIy2bgIip45u3GgMMwg9VVvBoOcw8iFMVGsr3fv6aWi7pPVFw/sf8gbe8pFz
	oLw4LUL3pgekHLzZPQK42ZWg9GOU1UezyqGLWLdLkMU60Qp1GeYx3Y6juUck2WayzmTmstJYlCQ
	IIcU2D9paFySlkh1GPtw76IneWgZNgaPHin9Zd3zSAGaQDNAME9j3H7cOZe5YSI26AjvFtqMlZo
	hCIgj6eJoLjAKNaE1
X-Google-Smtp-Source: AGHT+IFj8fxBbCctJozB81f2fryKqDo2iAN8X7SxR3YpQJadp6U2uwo7YTwRhSu0ED8hkicMtVTnog==
X-Received: by 2002:a17:906:3cb1:b0:a9a:5b84:ac81 with SMTP id a640c23a62f3a-aa5946e6d03mr1472151766b.31.1733075263673;
        Sun, 01 Dec 2024 09:47:43 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a78esm415220066b.163.2024.12.01.09.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 09:47:43 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 14/18] arm64: dts: imx8mm: add PLLs to clock controller module (ccm)
Date: Sun,  1 Dec 2024 18:46:14 +0100
Message-ID: <20241201174639.742000-15-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
References: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the PLLs generated by anatop to the clock list of the Clock
Controller Module (CCM) node.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

 - Added in v4

---

(no changes since v1)

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 597041a05073..0b35aecb6755 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -642,9 +642,14 @@ clk: clock-controller@30380000 {
 					     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 				#clock-cells = <1>;
 				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
-					 <&clk_ext3>, <&clk_ext4>;
+					 <&clk_ext3>, <&clk_ext4>,
+					 <&anatop IMX8MM_ANATOP_AUDIO_PLL1>,
+					 <&anatop IMX8MM_ANATOP_AUDIO_PLL1>,
+					 <&anatop IMX8MM_ANATOP_DRAM_PLL>,
+					 <&anatop IMX8MM_ANATOP_VIDEO_PLL>;
 				clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
-					      "clk_ext3", "clk_ext4";
+					      "clk_ext3", "clk_ext4", "audio_pll1", "audio_pll2",
+					      "dram_pll", "video_pll";
 				assigned-clocks = <&clk IMX8MM_CLK_A53_SRC>,
 						<&clk IMX8MM_CLK_A53_CORE>,
 						<&clk IMX8MM_CLK_NOC>,
-- 
2.43.0



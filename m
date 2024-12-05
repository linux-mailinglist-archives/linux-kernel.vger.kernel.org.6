Return-Path: <linux-kernel+bounces-433083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F659E53B6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32291626FF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFD71F8ACE;
	Thu,  5 Dec 2024 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="McA6RZSv"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895C31F707F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397609; cv=none; b=Dk008gSVOOHiZBTGHpUBMBZt/D4yf1ey0YPTFfb/Yg64U3G0136scoOWr/BWV3uUcSaR7NntJVC03i1WH8XwiV5sxGCl7QNw8TbeH6JwOEEHuFLACYqw1pT23eoWgylBvKyMxWyuha9x6ClnhZNMbHo88aOlD9qQG2LoR2/H0+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397609; c=relaxed/simple;
	bh=2JhFTNbz+mPx9HqCC7mp/y2AepFst/c//AlKmHPYdgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4jTVL9OBm8w/8aLNaaoJtQIMACvQBIc7VAqSm75qE2azmBfn4hbOzW9SHw0gw8F9N5uAgq34raWDOWpbrk+uUlNLYm6NSLpdnLiQ3Vmahx2WJgaBpkP40pvl+14YsVXqO3/IYCNoxZG/Ir+3cgQ79lu7KPwGrPkByZcXisVic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=McA6RZSv; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d0bf80972dso968818a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733397606; x=1734002406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2hCs9DBY1WcnrRGyr88Evw8OuCDQNrA4ENDf/4vgOw=;
        b=McA6RZSvpYf3irTm2wXrEaIK55Rl+qwJG+y6yzSF3coTmbaio173b80qSqRN1ZakRZ
         A43thRDc/05bwDeNerF/k9gaihuOmqynWQ/F9X4e7xLZITkkIZLkeuntgTEmXbtkin8o
         dVclunzwR+WMfi1aAlISZblEdn4G61/9Br1uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733397606; x=1734002406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2hCs9DBY1WcnrRGyr88Evw8OuCDQNrA4ENDf/4vgOw=;
        b=kx97v/OnKojcnnXDClCzCGryCBejNhR+Bt2NtjCsd0iG3kF4QwOjcvnRwZr3Fikeyn
         T4B1u73ja31V+JUSEUBLE3mGfpQWuArnsznHYVrB0861nJlf4600oMrpDFCN9e3YrZ+f
         5mmAonHVseEIjOUnY1zt+anCPOznorbG4P/O8e0tMvoeRPzmxhkQl8rDSMy9H7D9JTU5
         cG6wR6vsZA7ArKZuSlCnC/16sVgIqyHH9IckK2mOsZCZ6QioLaDntzzRMRPcasiUtRLg
         8FcFxtRucbcgjNpay68o0v1vsoTfcoR+Euo4DhVUG2P2/Guh6xQDOMcuje8xDZRydMPt
         0OXQ==
X-Gm-Message-State: AOJu0Ywh/zkdxse/wrMy9GdXVa8MkkxG+9KMP9YMWKUG6q3nb7BVz9Zu
	Q0cbCP4lkaFB3/4WuTRJ+zd6JLusxqWIHo9dNAYId0fwty5WsWD5Hf9hNaGMxrFgGPkr27vmbbW
	W
X-Gm-Gg: ASbGncu14b18eN/HboK3muV88YNs99Ap2Nv0H64z9nvwInC/8CpYRFxXoXh0Kiv0CbQ
	KypDYm6PHLOCyxNch91rUtWYNYlalptf1ncl0OwJwRhRZ/mHdz2j+MBEEGlaVAu4ow6VKy7PbBh
	jzqjTyUSS9Puuku3UQSdMi4H6kGKhUbtlpDYnCieQA+xrjJOiZgRqbAUYl+tYsF3AhQon7hTcit
	r+SHrkpXF2TAyJcYvggrEFvivqR3wNECZ1ez16iPhlufN1E2X+oRYv6c6Y0nBHGd1KkEyRhWvUc
	9DoZqrb2lf24bpXINowpmR4/5Iug1z6K6iabgMPzUxbrAw==
X-Google-Smtp-Source: AGHT+IGLZBaBqNRrXV0+VIf1ktSUUHHblEKAcaf8kiN8Y4lBfRjDCw12pclWyLXl1FgMMkHkUf47Qw==
X-Received: by 2002:a05:6402:280a:b0:5d0:fb1a:afe2 with SMTP id 4fb4d7f45d1cf-5d10cb5645bmr16989909a12.10.1733397605738;
        Thu, 05 Dec 2024 03:20:05 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:61a1:9bc8:52c6:3c2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eedcd0sm77505266b.87.2024.12.05.03.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:20:05 -0800 (PST)
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
Subject: [PATCH v5 16/20] arm64: dts: imx8mm: add PLLs to clock controller module (ccm)
Date: Thu,  5 Dec 2024 12:17:51 +0100
Message-ID: <20241205111939.1796244-17-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
References: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
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

---

(no changes since v4)

Changes in v4:
- New

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



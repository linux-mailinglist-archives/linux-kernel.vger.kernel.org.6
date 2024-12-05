Return-Path: <linux-kernel+bounces-433085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC059E53B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400F9163DD8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4AA20E03B;
	Thu,  5 Dec 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="G7IOtv9G"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6EB20DD6A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397612; cv=none; b=bS30hnV+4ZCe9NAfO5tbNJW7Yv2nUBoq7jRqoxnZbFtnC/vjZ5pl/EQOZrL3063bDztDjmHVaDAMqGPrWce+89EDadOmHe8k9fjbgWOFI4RJLgmLnco/0cwzXinW97NT9jupxc794g6mxcB5wRV8ByPZUEzBUn+Pd+Q70WeTJ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397612; c=relaxed/simple;
	bh=esezWmna9GVq9r7yCdcGJZGlaSCNF6WPrEuO3eSEza8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGHVyKK1d/yV8kB8FzkrFujV4xYC2GC6u8PGlBS2BJKtJVYCcwSWjEL6lyDHncGSR/GiDRR2rZCJTlMUEVzgYWPxG5l69lJiEeitOXNhho2D2lzPeQTOpK/fJ73fU9PpKyFBEUKDf+TQ2loymL22PM1mswhYalRNDVcjgFZm4x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=G7IOtv9G; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e28cf55cdso38213e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733397609; x=1734002409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biWMPay2nyJxiRsIuM7kfYUrVvGohPt2+JFfoRTvr08=;
        b=G7IOtv9GcsIv/G+1Y26CEEPqkjLwdqZd7bw3Re7sbjg9mGtZzZ3m6PwFS/qKiE7v4N
         0DZQEKoQv1YNdAoJrqzhbCHhG1dxPsY3vdRNJLJFb6+yeOWx5SgGG8XXj7vQ8REM6KoH
         cBxMtHrAY/aLo5v5bm3jDzql7ITQCe7hgmKEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733397609; x=1734002409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biWMPay2nyJxiRsIuM7kfYUrVvGohPt2+JFfoRTvr08=;
        b=UPDOmYipjEEm+ZwriEjX2x8F3YEjTKDWzzgKdKvJGpquXirExvAdjJs1AePNgQ6l9a
         gWhnEiBqXP6yGxvvgk0AJ8/De/wdgvy3AftbZyQm72FnWA+bTVklmm0H+UkzkE8zNJr0
         htJSrI5Oy5l2Xvv4HlFWLMzlsw1N5mTfgYfEJB0EJfrehGSXIXxg2Cm3Fyn/5O0AIfbi
         hk9LkR0ZW3xS488XYggKT5uOLPOmWbOQWigynWs8/WGHleCNOxwnai80ZN1skmgaYpq0
         6TR7UaAMGwm7BLA8mhxLqm74OSHTYc8EqloHx9ha4ZrebNZJmfVgtMx1m+bP8pUr1Fx4
         DHng==
X-Gm-Message-State: AOJu0YxQaAIn4dVXWmGonjGjaL3QsonadWfKfL1R2h7cTb11hhWfyHhb
	2Bckiu41uLwyYreuPdSFDfJSkXM+Eubdz/os0RS/itLxmOqwDxO5+CbXuL+mA7O/DZPOCmctb0d
	B
X-Gm-Gg: ASbGncumKZjoXzRGpmMwmCLAN8dcDHx/skTmfwnz28z9pLliY3GKLyqGpzh0A7V5Sno
	xh8QE4VYXUW+pCpydXFk3eu5sVqlrjpTNxgyrlp/kws02vKXnl/Lkqt/AyUo5Ewx/pchks30ASk
	FLRRB4CTFVYUzdZhl3tub89mfcL5+22X3D1ti8xNdN3yaXaSaBvHkrLNZwViFtSo4EY2iBDlbxs
	LMASVhS7KHi5I2wEizbo7PvLn2R+yIaFKsfHgFUYWONXfpcqul1hX9limyqCAGQGJD5Yx+iYKz1
	HiSWn/QRO5xUOCQ4BjAo/kksOtGsn1coH7J/+5H5iB4CNQ==
X-Google-Smtp-Source: AGHT+IEWp4UoDnwBUpXtmDUlrG4M6Gl9Nup3DKpNDi+ZT2s/ZJqbnUNyO4bcuE37hxKCpJ5erMuTvA==
X-Received: by 2002:a05:6512:b14:b0:53d:edf6:c560 with SMTP id 2adb3069b0e04-53e12a05948mr6199533e87.29.1733397608945;
        Thu, 05 Dec 2024 03:20:08 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:61a1:9bc8:52c6:3c2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eedcd0sm77505266b.87.2024.12.05.03.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:20:07 -0800 (PST)
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
Subject: [PATCH v5 18/20] arm64: dts: imx8mp: add PLLs to clock controller module (ccm)
Date: Thu,  5 Dec 2024 12:17:53 +0100
Message-ID: <20241205111939.1796244-19-dario.binacchi@amarulasolutions.com>
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

 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 0b928e173f29..861bd4f4dced 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -751,9 +751,14 @@ clk: clock-controller@30380000 {
 					     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 				#clock-cells = <1>;
 				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
-					 <&clk_ext3>, <&clk_ext4>;
+					 <&clk_ext3>, <&clk_ext4>,
+					 <&anatop IMX8MP_ANATOP_AUDIO_PLL1>,
+					 <&anatop IMX8MP_ANATOP_AUDIO_PLL1>,
+					 <&anatop IMX8MP_ANATOP_DRAM_PLL>,
+					 <&anatop IMX8MP_ANATOP_VIDEO_PLL>;
 				clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
-					      "clk_ext3", "clk_ext4";
+					      "clk_ext3", "clk_ext4", "audio_pll1", "audio_pll2",
+					      "dram_pll", "video_pll";
 				assigned-clocks = <&clk IMX8MP_CLK_A53_SRC>,
 						  <&clk IMX8MP_CLK_A53_CORE>,
 						  <&clk IMX8MP_CLK_NOC>,
-- 
2.43.0



Return-Path: <linux-kernel+bounces-548804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F22A54990
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901DB3B17E5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D09421ABB9;
	Thu,  6 Mar 2025 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pwKcsgsx"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9A9218ABC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260659; cv=none; b=lhl5DbsOk/NQ+MiredKpiONili1Kcj4pE3I359jNxR2/6Qj5cPD/PT8RCIVGxKKIaqcSlj4gpXLuNJNr1q0DDsHxGziqwanQwrRHj65h+0LQVs0wtdn+GTcTg+pYXBlJH3t06Opl0ulzN0ALXX9VSNFfxP5+Dzu+7oyK1DcxWak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260659; c=relaxed/simple;
	bh=gzAb8Vev7F0m4l48I407MYxa8qXR/pteEzI03GTE0HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVyHT1wggyF8IvcatAVUuOqhFfBq2BkS9EO+Sk1JBl6JnpCa4abGzIdl4HLJfx+aORwxNxAO2VInpcrRakjbPcg/Y8PTT46Qbvy2lww92688g29FEu07V9I1qMn4k1YHWo2u2feMoD0nexWVMF4GSPheAqy/GHCddwEr/TQ9v/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=pwKcsgsx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390f69f8083so521618f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1741260655; x=1741865455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS59gZd32BjVBMnl0y8BuCd7aMfa22x1ZHu9pei4qQQ=;
        b=pwKcsgsxF6MN1VsdsfZVVBUDKMHdq57SmRxTS+nEU9TthWtw894Z/42yEZUg2rIVjE
         JoP969eRLKuum7zoO1YODhPM4mXuZ8qRCT4cu1O/GwX5WSSgzLf0fmlrx8Xb4vXI5eEI
         VbcoqHquDBqtQSo48YLmBostmIZcetrE9HM2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260655; x=1741865455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FS59gZd32BjVBMnl0y8BuCd7aMfa22x1ZHu9pei4qQQ=;
        b=lBjiHLG+9UfejDwvMrFBPhpqkIJgwuvZGQF32Q5Gx0aY6dqvPyB7pnDKl4EZPWux6s
         PuOTiuROPgj9JK3uVun4DkeA7dC6jv+QPDnebk56sj1Iye1uaIBRixnht4nnLWMPGyaY
         6q32uX3h8uozoKosJHLF6UpVBQAU9NaOsLejPpAdUwQdW0bOVrt3t55XeD5PpgRksWOS
         1xsElkOfh7ru8fPbj9v5+BvPSsSS/9bePXSrR1LCXfmlxokUTekZfThFa+hv2YIYkVBA
         WrynjfSq0/mOkY0vwS478ITR2ca7VDG8Gjkzld6LJyfKY/V7InQPE0J837mlIW1qvCDJ
         2I8Q==
X-Gm-Message-State: AOJu0YwNLfif7vTZDH/LU2+9iNdF+I/qNqG/q+zfZEjJN2Sml4B3WIdq
	roaMDGrkfTkcOrG31GaQ2XhdgCC4e52KqZzF8wKHxGte56RGQNzmmNmsD0l1txxm/odOjgQXq4R
	b
X-Gm-Gg: ASbGncuGQR9C/tKHjEoLaSBnrQeQ63xZYu2PgI+z8VGEUOxG0vJzfvWU3AIJI4D++sN
	7KjVlAKyZXbXJdRKHEOJdKZWmpJ13K4QPP+m5R/lVR7P5i8doGrj0jBN7+IfLNCVGIkqOIWOB1k
	Pxa0YzisgiQO1sM0tYBsEmmmiM4dgLqDE6upkbtbzTk5QfQfg+Qlrxj/O3eyroTt6ptJ7nQqEFV
	ZJXyQ86zQOXxIkO0dIzcSVxhgPY9wpR/T+KPivfHTPS7p9l8+hIHgYbXdZkf3DprDughdlYK9E1
	VtohkDIl6uaIhwvNocDk5BCw1g3sK+7aCysxZeErH6RnwKClgkplwfszibL8n5HsiYnsFi1js4c
	DfNzBEA==
X-Google-Smtp-Source: AGHT+IEZn/9kHcDhx+uHLD679Aq/6iWA+3OuKqlfoSyRAz/qXxji0vn2yOVWqnfvegWeGGNMCqwuaw==
X-Received: by 2002:a05:6000:1788:b0:390:f9a5:bd79 with SMTP id ffacd0b85a97d-3911f74e675mr5508637f8f.26.1741260654829;
        Thu, 06 Mar 2025 03:30:54 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:4703:aa8c:6eab:8161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79b9sm1749650f8f.3.2025.03.06.03.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:30:54 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>,
	linux-amarula@amarulasolutions.com,
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
Subject: [PATCH v10 16/18] arm64: dts: imx8mm: add PLLs to clock controller module (CCM)
Date: Thu,  6 Mar 2025 12:28:05 +0100
Message-ID: <20250306112959.242131-17-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
References: <20250306112959.242131-1-dario.binacchi@amarulasolutions.com>
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
index 597041a05073..79f4c1ae7d8b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -642,9 +642,14 @@ clk: clock-controller@30380000 {
 					     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 				#clock-cells = <1>;
 				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
-					 <&clk_ext3>, <&clk_ext4>;
+					 <&clk_ext3>, <&clk_ext4>,
+					 <&anatop IMX8MM_ANATOP_AUDIO_PLL1>,
+					 <&anatop IMX8MM_ANATOP_AUDIO_PLL2>,
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



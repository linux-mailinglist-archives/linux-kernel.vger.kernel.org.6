Return-Path: <linux-kernel+bounces-433084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54279E53B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B88D1633C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2AD20DD7C;
	Thu,  5 Dec 2024 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="M2kPdPNs"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FF51F7583
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397610; cv=none; b=LicWYiNAyRaITjbkQLFQJFOc+hknwE2EmTAUTF0ybAyfkHZGqI12VTK7uC658xtbaE0q99AddBlTEzFNlNKnztwv/L2s2mGpSE5BnP3+EOCoa9wju6O5kjYB864/5Oh4raQdu+PB2JBx0CI/mm+sM99QoRAfy8PMBe4RPxsRQJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397610; c=relaxed/simple;
	bh=UMdg/7HEARC6ZgU2mWDyh9m6gc8+etDqX0OWe/Oj1Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBv9B7tamXU1jQOZvFO4eJ2S06eeGM10KqN73GLl0m2B0BLEO5lIMHOepn8PFIDl73UkLhsyK9R5sgP6+lbgs86x39cxDJYrTx5X+s3aF0C7kM8uJjhZy3SXtjKHE4XP77hTCrzE5dM7IR7yEGndZEabLkp3pqyP7KHGQArZ8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=M2kPdPNs; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa54adcb894so134849066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733397607; x=1734002407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deJRTkp3cj8LQIAgwHRGE8nfXmDlGN+dwLVOnyJ9CpQ=;
        b=M2kPdPNsTX0t5qT1HjXGxLhKL9Nu10TmVZTI7XTEJo5trFetD5/BluJ1+r34ckRnKB
         P2ZMbTy/dSP7dJoGzZsFPyQNDAmA6Msadkbc1St9WiQGl3U5WJer8SGKz0L/d4EkBDf6
         CRJWFNgSpH2nx4NWGdWFt6wWuf7POrJt7SL7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733397607; x=1734002407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deJRTkp3cj8LQIAgwHRGE8nfXmDlGN+dwLVOnyJ9CpQ=;
        b=lrgYQ3oKDr2TbGpCDUfEJ8hnb1nA5Ys7ECbqt9TFaxtgxPC4qa/WYuS3G75jnB/mOu
         vMEkkVhh1eHl9cEu/sd07k5whio8fqF1pOKXLJguJqmuEnQ+8iTK2ud2iRwqyXeG6tFW
         jhcv4sarhVyJvFtsRqk0GRDngzI3tLK2r0NwAsyjWyZQbi/O7TtzTxhEOL4BxAHb3Nm0
         Q0pmAAwi3DqPnLCuEpTHXD99stKN5L+8fZJ3RRKn5ztSGd7i3azGVd100QDumcdRaGsR
         tLc3mapzopBrVxVjFn+kfXV2uLSl+e1hA7N/pbYo/2BXjfGLkm4B/+2MDT/cegOyJeoY
         TYcw==
X-Gm-Message-State: AOJu0YwN1Sys8JRmIlk96X/eQY9nRRY9/E2JsjWByCdFe16gZAO+tWdd
	+rC4OutrNPQIznZJyLU4H7MbpcqdCTmaObwV2foptAKWUBth5EDv/OOQCg7VBwRZVFoEKnL3Qa9
	u
X-Gm-Gg: ASbGnct2Mh29tHQ05cYpJI/f9THLf1xil26xv7Bf3bc+UDVhbNqy8G4ik1pyUaDWh3R
	GnJiF8h5/UHj4E3RByJgEMp6R7eDN2goNc3gxi5LKnd3KRGY9J+zXX8fd6Dvty03Vdky/YoXakt
	c8021R27DClvIt/Zg/z+N9Ik8+ZjjbvJuA3669TiiTh5G4bdX1evdAwZCfL6M4UGJ5dx9fPVej2
	YcF5EbfL9zrILFfzwiY0icBvjwmBDy3rYgADA5GeAnBGBCe8yyZyqWoRSNRkGZsYJxboKyapgRN
	UBhDSThFJbM/oFdZdbNErV6MuVsSQ8gCuIG5sZ/xUQN/mQ==
X-Google-Smtp-Source: AGHT+IEDfHJCy4mKgveNLG8+12l0nNuJTsz+6IEw9fSTRFtpyymfLeQoj2SsxUuqEuLQtMZgkWDydQ==
X-Received: by 2002:a17:906:328f:b0:aa6:25c4:7a71 with SMTP id a640c23a62f3a-aa625c48787mr161327966b.16.1733397606942;
        Thu, 05 Dec 2024 03:20:06 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:61a1:9bc8:52c6:3c2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eedcd0sm77505266b.87.2024.12.05.03.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:20:06 -0800 (PST)
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
Subject: [PATCH v5 17/20] arm64: dts: imx8mn: add PLLs to clock controller module (ccm)
Date: Thu,  5 Dec 2024 12:17:52 +0100
Message-ID: <20241205111939.1796244-18-dario.binacchi@amarulasolutions.com>
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

 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 49be492b5687..aaa179784717 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -643,9 +643,14 @@ clk: clock-controller@30380000 {
 					     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 				#clock-cells = <1>;
 				clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
-					 <&clk_ext3>, <&clk_ext4>;
+					 <&clk_ext3>, <&clk_ext4>,
+					 <&anatop IMX8MN_ANATOP_AUDIO_PLL1>,
+					 <&anatop IMX8MN_ANATOP_AUDIO_PLL1>,
+					 <&anatop IMX8MN_ANATOP_DRAM_PLL>,
+					 <&anatop IMX8MN_ANATOP_VIDEO_PLL>;
 				clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
-					      "clk_ext3", "clk_ext4";
+					      "clk_ext3", "clk_ext4", "audio_pll1", "audio_pll2",
+					      "dram_pll", "video_pll";
 				assigned-clocks = <&clk IMX8MN_CLK_A53_SRC>,
 						<&clk IMX8MN_CLK_A53_CORE>,
 						<&clk IMX8MN_CLK_NOC>,
-- 
2.43.0



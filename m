Return-Path: <linux-kernel+bounces-426701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBB49DF6D0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99921162C84
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D249B1DE3D8;
	Sun,  1 Dec 2024 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gwhF5jqa"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A382A1DE2AB
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075269; cv=none; b=n0yufAh4JcYd3P97puUFYHjZOIb2Ze3zmXekB3iVcjpR7hxGwcD4+/9qts0Wioq6fDNnPUN1a/FQisBzfN6BvCBWabHJ+N2zxabGlMFITgvwwwxRH+cFJtL6VGVDMqZ+lkEamhz8UFIwu3Y/hMe27uCM2a+e4L83lUpWB/ik+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075269; c=relaxed/simple;
	bh=w6n4rfeNbc+MoInkCIZ53r/EnS7ZauG85YmurhB5mWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZHdYSwz5JMq9PhfqAa4dVp3HAtE9usEeZMp7eAzzvyGve+GDXsiRnR/yMp4Gb03i16qp9H2U9YmGZWC/VrA8YD4p4QdQmt4fqawPVTckHgE+LGTe1gsUBtjRFvPYwUugAULScs4kYng+gDuwpedzW7HEzqX/qvWJOe5uygh2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=gwhF5jqa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa549f2f9d2so446382466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 09:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733075266; x=1733680066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxJsjMJwTSMPDYd3KHgHpJeZxzAqqmLbUkKQAeNGZLg=;
        b=gwhF5jqaRJNoB4BTXJ1xo4k4vuoM0u7pzr+yJs0GxaLlpog5a6RteWN3e6CIjuT/Iq
         XZYqoIMKJiKJ3g+UDj9xnzmN19WxEZcN3OP3OupYc6+LUfurNURc5A3cwbFIJutqChuO
         rPyBCzacKON3f340en7/D7If5RnQ4SiqDoIek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733075266; x=1733680066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxJsjMJwTSMPDYd3KHgHpJeZxzAqqmLbUkKQAeNGZLg=;
        b=csdUOCChlAbaSeAIWbpTQwIO5lFwkveXAGaj+T4X/hkc+UdQpW+HDMtBUt/riLsQcT
         jj7hhy179H2rsydwun1GeWHb8gWt2n8mpWxZR7fRELUKw0c0exQN/kkmL05y08ddrMcN
         WgKFoV4ZrfTiFMw/sFSeICG16csDsnoYH9GYkm+ryu1O4WAtBsP2Atb9Dwy0DjMED/eS
         Gip8kNFpcjxB4HsNsCnPNB1nI3Snawd4ABbk33MRaTWqjgDT3KDlJv07m3peNkLokEYH
         1PfDUk/KCqWXk/sw9rH1iAvjclXEvUk5pPE1jKQ2fIOLOz0WdBCo+7PLqUp+4/36/G9y
         u3uQ==
X-Gm-Message-State: AOJu0YxgmurKhJm4ZetGh0HO3QbNl2wgtavINJP02zoNC232MxrBKhkL
	Nfjn4MSg2kBr+X53uh8W8UbVYWkc/1fVR0lJSZ6KSaYvordlgU6MbcaUWQ4afoSaZfrArNf6/Dr
	1
X-Gm-Gg: ASbGnctQgYhemOAnyLO4pgTXDiJuwY7vknfyYA17we3TDZNlR3H0E6ZFQzxZu614oMf
	LR/3cIwxjSEXyg7QLRiWKd4qcv9xTV3DRHzq9/E3Gh2uJqsL+3LhaiegOL4rsx9utXLEggnkYiW
	Zk/LVNl+zbAOwl3+QTR+R1uZS+ZGUMSJBFT2QgoRoVP5O1EDFPscjMQVx4gg4AyCwMCgW9KX+AV
	Vq3TO8pQ86UHuerLd2WRLT18kYDphvcAvh3TzpFIE1fyA8rqWdHqPPNbcQRQRohlypKhVvR0vVM
	p10if+Pzk2nDdGRxVFFFS9AfT/aaQl+C164D8DzCP8331aTvIO/pobm26AwqNb6yRCsCbEEbddR
	Nv5lOlHiKDH4y+enV
X-Google-Smtp-Source: AGHT+IEMnDbFieUd095y2eErzlydo05nTceNj0JCkVkJZiYgYFWL+9eesGwhsPTyw1VD3PBNGdcTHA==
X-Received: by 2002:a17:906:5a56:b0:aa5:50b6:a612 with SMTP id a640c23a62f3a-aa581093a27mr1555171566b.61.1733075265912;
        Sun, 01 Dec 2024 09:47:45 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a78esm415220066b.163.2024.12.01.09.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 09:47:45 -0800 (PST)
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
Subject: [PATCH v4 15/18] arm64: dts: imx8mn: add PLLs to clock controller module (ccm)
Date: Sun,  1 Dec 2024 18:46:15 +0100
Message-ID: <20241201174639.742000-16-dario.binacchi@amarulasolutions.com>
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



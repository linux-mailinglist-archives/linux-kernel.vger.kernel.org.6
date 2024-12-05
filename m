Return-Path: <linux-kernel+bounces-433078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F489E53AA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8E0188218D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683F820ADED;
	Thu,  5 Dec 2024 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WVXaWZQB"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9778A1F541D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397602; cv=none; b=DRxe4KhBiiaUKS2heegygmHzNXN2zpAFC2Ckm3Vj9qQPwr/NI2RXyWB/BnHrFScofhHZG7SxO6RPO36dVZiH7pMYGeevpwsPW1AXKjU2A1iZhokX4kEEIhOs6jYn6F1k83OtQMhOtN45rPDWXckG4w5X/pH5P/gm46mnzu6rzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397602; c=relaxed/simple;
	bh=g9IR8hiEt4nusxY1z0lDRA+5+CXB9FZt8hxI+KbiIg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HryNelJ1VGf5q+WgTMzPO+Qw39EHs/6dX6AHAH6D2DrjZV9nZfkfbs7Mk9UNc3Pz2BQgah7AE/qduq/nsAX+e0fMBPXT2J6pLiNeK+MrArK5YZtcMevkruzcfCNjnfJol45mBygg0rotC6r4sXqTOffc7jevMIuSN+BHUADBJ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=WVXaWZQB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso95336066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733397599; x=1734002399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOY72MHaxAftY+kPZT4cz9mX5QyWQyee4eQ/HvJFX/U=;
        b=WVXaWZQBFKIrCU4wKSPiMjsVfmsPBHtjknXcCedv3t3N0f1NfiRgJFnuSNAD1caZQU
         9CqdHMOTlxJrU9TORlQKXN2fLFRMe47grqgzXx1USsY0Nj6zmC94yR+xQPfZxbYYeebk
         55tfBHfHx31ShGdlgSuKzMB/rDDGjItN2fXGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733397599; x=1734002399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOY72MHaxAftY+kPZT4cz9mX5QyWQyee4eQ/HvJFX/U=;
        b=lGoPNSgaUTEGiss4Ll9S71nLivR86+QxoN3iE+Mb+D/7OsAk6kYH7qQxNNmdPy3PLq
         kXB+FpxdIMu0DCF/RnTY+/sX2NpR7aQx0YGkUrgWwFrGzw9KXXo0W5fe2j3GGSFtM7vD
         LDOmrRX34htvV96UfGrYke60+cKLmZ+lh65TB5UXxVhl41rUObVR633sHIfUprQuGmTf
         8ksi7NUyL+yShbc4LOmfkbNvtywC5xGJc+79FYwoACU5iqbsjzcc4PXjX4Ml5ho/ydAK
         pKDP5Zsps7uIknFGyRsGf88Jz7pw4MkqiQEOrhum1+smLp7O1IqJyG2HfJe5FLMtvy/M
         bwrw==
X-Gm-Message-State: AOJu0Yy/GHm53qA5vPCtQTjVjRMwzfepcpe7dZedOhkTokkf4i9ijb3j
	Wt1iYa+fTn0p9I9h9ysvpd6bLi2NK8X8oNvy/O/J7pFldtFZNkOI64E7mTr2CX1dezBLxp9TtJX
	M
X-Gm-Gg: ASbGnct2hMVZSWbjt3wwLKFWX/00hf+EIHaNhzrQzY2V9DoQ890yGrDvTTbxYK3TTjB
	X1b6e3JJF90scb32ehcX2uYCn3QS6cPwzkuzmJ2hesdwqkdSM2EIq8axiFYmaO9iOvDtjMcJTCY
	HrU2hNJ6lc/7QbGT3Ty2Nga5iXlsIy328y5DtfBjA2NxVa7Ear9P4ENL0/WyrrQNz+g9wBoeSOS
	g+G6rW33MzH8lDpMNaZ/rUEj0B1GvOteMXHNcUc17rGmWYnLlx3ewmj9JQmKEcfg2vOfNVTG3Z9
	JHD1R0xmYEN+uBO3N0/0bNK3Sv34yHB3OTLv0Xjm5Z4s3A==
X-Google-Smtp-Source: AGHT+IFXJcxKOle31pOcIopdUkkB4lCAoWI6FX+oQCGDMC4yR2Zx2PMfETB1WKVrtpXVsIUvtR8jAg==
X-Received: by 2002:a17:906:4c1:b0:aa5:f288:e7d8 with SMTP id a640c23a62f3a-aa5f7de5826mr706812166b.26.1733397598755;
        Thu, 05 Dec 2024 03:19:58 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:61a1:9bc8:52c6:3c2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eedcd0sm77505266b.87.2024.12.05.03.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:19:58 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v5 11/20] dt-bindings: clock: imx8mn: add binding definitions for anatop
Date: Thu,  5 Dec 2024 12:17:46 +0100
Message-ID: <20241205111939.1796244-12-dario.binacchi@amarulasolutions.com>
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

Add the bindings definitions for the anatop node. The patch is
preparatory for future developments.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v4)

Changes in v4:
- New

 include/dt-bindings/clock/imx8mn-clock.h | 67 ++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/include/dt-bindings/clock/imx8mn-clock.h b/include/dt-bindings/clock/imx8mn-clock.h
index 04809edab33c..732ff87a16c2 100644
--- a/include/dt-bindings/clock/imx8mn-clock.h
+++ b/include/dt-bindings/clock/imx8mn-clock.h
@@ -267,4 +267,71 @@
 
 #define IMX8MN_CLK_END				235
 
+#define IMX8MN_ANATOP_CLK_DUMMY			0
+#define IMX8MN_ANATOP_CLK_32K			1
+#define IMX8MN_ANATOP_CLK_24M			2
+#define IMX8MN_ANATOP_AUDIO_PLL1_REF_SEL	3
+#define IMX8MN_ANATOP_AUDIO_PLL2_REF_SEL	4
+#define IMX8MN_ANATOP_VIDEO_PLL_REF_SEL		5
+#define IMX8MN_ANATOP_DRAM_PLL_REF_SEL		6
+#define IMX8MN_ANATOP_GPU_PLL_REF_SEL		7
+#define IMX8MN_ANATOP_M7_ALT_PLL_REF_SEL	8
+#define IMX8MN_ANATOP_ARM_PLL_REF_SEL		9
+#define IMX8MN_ANATOP_SYS_PLL3_REF_SEL		10
+#define IMX8MN_ANATOP_AUDIO_PLL1		11
+#define IMX8MN_ANATOP_AUDIO_PLL2		12
+#define IMX8MN_ANATOP_VIDEO_PLL			13
+#define IMX8MN_ANATOP_DRAM_PLL			14
+#define IMX8MN_ANATOP_GPU_PLL			15
+#define IMX8MN_ANATOP_M7_ALT_PLL		16
+#define IMX8MN_ANATOP_ARM_PLL			17
+#define IMX8MN_ANATOP_SYS_PLL1			18
+#define IMX8MN_ANATOP_SYS_PLL2			19
+#define IMX8MN_ANATOP_SYS_PLL3			20
+#define IMX8MN_ANATOP_AUDIO_PLL1_BYPASS		21
+#define IMX8MN_ANATOP_AUDIO_PLL2_BYPASS		22
+#define IMX8MN_ANATOP_VIDEO_PLL_BYPASS		23
+#define IMX8MN_ANATOP_DRAM_PLL_BYPASS		24
+#define IMX8MN_ANATOP_GPU_PLL_BYPASS		25
+#define IMX8MN_ANATOP_M7_ALT_PLL_BYPASS		26
+#define IMX8MN_ANATOP_ARM_PLL_BYPASS		27
+#define IMX8MN_ANATOP_SYS_PLL3_BYPASS		28
+#define IMX8MN_ANATOP_AUDIO_PLL1_OUT		29
+#define IMX8MN_ANATOP_AUDIO_PLL2_OUT		30
+#define IMX8MN_ANATOP_VIDEO_PLL_OUT		31
+#define IMX8MN_ANATOP_DRAM_PLL_OUT		32
+#define IMX8MN_ANATOP_GPU_PLL_OUT		33
+#define IMX8MN_ANATOP_M7_ALT_PLL_OUT		34
+#define IMX8MN_ANATOP_ARM_PLL_OUT		35
+#define IMX8MN_ANATOP_SYS_PLL3_OUT		36
+#define IMX8MN_ANATOP_SYS_PLL1_OUT		37
+#define IMX8MN_ANATOP_SYS_PLL1_40M		38
+#define IMX8MN_ANATOP_SYS_PLL1_80M		39
+#define IMX8MN_ANATOP_SYS_PLL1_100M		40
+#define IMX8MN_ANATOP_SYS_PLL1_133M		41
+#define IMX8MN_ANATOP_SYS_PLL1_160M		42
+#define IMX8MN_ANATOP_SYS_PLL1_200M		43
+#define IMX8MN_ANATOP_SYS_PLL1_266M		44
+#define IMX8MN_ANATOP_SYS_PLL1_400M		45
+#define IMX8MN_ANATOP_SYS_PLL1_800M		46
+#define IMX8MN_ANATOP_SYS_PLL2_OUT		47
+#define IMX8MN_ANATOP_SYS_PLL2_50M		48
+#define IMX8MN_ANATOP_SYS_PLL2_100M		49
+#define IMX8MN_ANATOP_SYS_PLL2_125M		50
+#define IMX8MN_ANATOP_SYS_PLL2_166M		51
+#define IMX8MN_ANATOP_SYS_PLL2_200M		52
+#define IMX8MN_ANATOP_SYS_PLL2_250M		53
+#define IMX8MN_ANATOP_SYS_PLL2_333M		54
+#define IMX8MN_ANATOP_SYS_PLL2_500M		55
+#define IMX8MN_ANATOP_SYS_PLL2_1000M		56
+
+#define IMX8MN_ANATOP_CLK_CLKOUT1_SEL		57
+#define IMX8MN_ANATOP_CLK_CLKOUT1_DIV		58
+#define IMX8MN_ANATOP_CLK_CLKOUT1		59
+#define IMX8MN_ANATOP_CLK_CLKOUT2_SEL		60
+#define IMX8MN_ANATOP_CLK_CLKOUT2_DIV		61
+#define IMX8MN_ANATOP_CLK_CLKOUT2		62
+
+#define IMX8MN_ANATOP_CLK_END			63
+
 #endif
-- 
2.43.0



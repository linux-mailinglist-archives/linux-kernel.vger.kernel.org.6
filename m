Return-Path: <linux-kernel+bounces-433079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6CA9E53AD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88425164F41
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25D620C004;
	Thu,  5 Dec 2024 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ifYk2VII"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB98207E1A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397603; cv=none; b=uuZtSYeFXcx18gwgOM8WJgrm1mIGss+LL4jFf3cGvP3M4TVOPf7UIZ34JBgJ7jp8F6Ep1dw7rQp1V3qmF6Kw1Zi/VTXSFs+5OZrtMdzZtcVlJUwZvRPQZ2TSizA9OcczQQPBTTuEehN5H2/0xln7yr0vYmtsTFynbBQH0oMYwME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397603; c=relaxed/simple;
	bh=pfUlSptnbjn7DLvsRIow/u7XIOc91MQ2X6DWWwf8p8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlsy2rwk2m2TK9h7VsR8X3H+aGTZnQ8N3FPfyWIsWc2NydTtA41yefeq5alEAXrDMDGboZ1qLdE+ySBfJtlUXzVbsKlYCaa70ys7p9l5nvYwWToCTgYgc3kv8bmgug48ZMOZ5dMB4X4ndLYcu3+3RxqxP/sIVX16ooxrA1WtJLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ifYk2VII; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa545dc7105so134510466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733397600; x=1734002400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQV84YY3kxNcx24ekDyafnu8RIJlZ6f4/uTM5oPtiQA=;
        b=ifYk2VII/Q8/8lqyxqmN0okvjTLgOUDP/UAzFrLqOF33wp8J6dSrGQw/Pqs8rU/SBM
         1fvJMcCF5mU3uDVDwcGwMElnhUPpvzIZLhP4sxjj6mT3UNp6XVrBDocuFgm3+vTaP3hX
         fqmpbHPhQEFO5F3jpzBob9BruBscVJfzi8K3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733397600; x=1734002400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQV84YY3kxNcx24ekDyafnu8RIJlZ6f4/uTM5oPtiQA=;
        b=xABJLtDaQwm7UIqaxJOex8WFjmNkt6Qr5iu5tph+aU986pd5AxVsdEznvfsDzDJWQy
         HfZ/eB5bxtL4JSxIjjrFoMsZsOcbfyBhxFp3FdInIeXx93GiHwlZSzARCLRhXW+w/Psg
         vqQzUFkX4zG3uQxp4MYoXSDBqh+ox9dbugjkTSz5mzh9sJYIY293Nog5G1SCXxNu0+gW
         qdHkHMWJ0fYlwJ4+cu/kx9+KpqazfMprGUzaVIPZS1WInAkRJPrQPye+hd+Em7fcp9CJ
         vTDMiX9ey38CY0yAEcFhDvonaDSPPmrzbYkUXMuNx0Y1qqD/tnpmmhg48B3gm2EYj6DG
         NXmQ==
X-Gm-Message-State: AOJu0YxtxGjzpfKX9nmtH2FRZmC+WbWPyKQnYCg0/gOOobR844YDcShx
	o9VGT9oS9CIHczbF2A1iFAp9TODsLyz77ZI2JGxCxIVzbrVkh/qV4pZNY3mK7QKthw5iyF5WzEZ
	w
X-Gm-Gg: ASbGnctssI/sz1KjtX9VvV+Q4lDneR/du11Rwqvyw6c4K8IT4v6rt69Sx3ntxfXRiwG
	fW+5bTZX3n5R1ijsrJPIun3VzEwvRcG8W165g5T3fBvPWn+9hXHXNbLo2hSVu9rg3qAm5AP/XGy
	bGc3aBMCoCGCDlD4npQzNupE14S8kPTuuPZIOJ40ddaIWdl1nu4IaWpX/T8l6FUCWq7REf60ilI
	ot/vvOPf2t/vFX0pMrBzN81dMYFZfT6giDDgWwE9iJDA2PY3N4/2KBzuZ8qN2njriM6aoHQwEZR
	kszJnzLZwbvT8SXXc1dIA5nUC6+sfgr/ybFLGhN53H5lrw==
X-Google-Smtp-Source: AGHT+IHYmzsfUE5nnaORiIrX4Eb1tu8QF4QuJLvLBDRHYiwoP2v5WElgFEFGC9Kt0r3kBSas5vWKow==
X-Received: by 2002:a17:906:308c:b0:aa6:2cad:2d61 with SMTP id a640c23a62f3a-aa62cad2dc3mr99811966b.19.1733397600072;
        Thu, 05 Dec 2024 03:20:00 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:61a1:9bc8:52c6:3c2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eedcd0sm77505266b.87.2024.12.05.03.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:19:59 -0800 (PST)
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
Subject: [PATCH v5 12/20] dt-bindings: clock: imx8mp: add binding definitions for anatop
Date: Thu,  5 Dec 2024 12:17:47 +0100
Message-ID: <20241205111939.1796244-13-dario.binacchi@amarulasolutions.com>
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

 include/dt-bindings/clock/imx8mp-clock.h | 70 ++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 3235d7de3b62..c2acba5d4555 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -402,4 +402,74 @@
 
 #define IMX8MP_CLK_AUDIOMIX_END			59
 
+#define IMX8MP_ANATOP_CLK_DUMMY			0
+#define IMX8MP_ANATOP_CLK_24M			1
+#define IMX8MP_ANATOP_CLK_32K			2
+#define IMX8MP_ANATOP_AUDIO_PLL1_REF_SEL	3
+#define IMX8MP_ANATOP_AUDIO_PLL2_REF_SEL	4
+#define IMX8MP_ANATOP_VIDEO_PLL_REF_SEL		5
+#define IMX8MP_ANATOP_DRAM_PLL_REF_SEL		6
+#define IMX8MP_ANATOP_GPU_PLL_REF_SEL		7
+#define IMX8MP_ANATOP_VPU_PLL_REF_SEL		8
+#define IMX8MP_ANATOP_ARM_PLL_REF_SEL		9
+#define IMX8MP_ANATOP_SYS_PLL1_REF_SEL		10
+#define IMX8MP_ANATOP_SYS_PLL2_REF_SEL		11
+#define IMX8MP_ANATOP_SYS_PLL3_REF_SEL		12
+#define IMX8MP_ANATOP_AUDIO_PLL1		13
+#define IMX8MP_ANATOP_AUDIO_PLL2		14
+#define IMX8MP_ANATOP_VIDEO_PLL			15
+#define IMX8MP_ANATOP_DRAM_PLL			16
+#define IMX8MP_ANATOP_GPU_PLL			17
+#define IMX8MP_ANATOP_VPU_PLL			18
+#define IMX8MP_ANATOP_ARM_PLL			19
+#define IMX8MP_ANATOP_SYS_PLL1			20
+#define IMX8MP_ANATOP_SYS_PLL2			21
+#define IMX8MP_ANATOP_SYS_PLL3			22
+#define IMX8MP_ANATOP_AUDIO_PLL1_BYPASS		23
+#define IMX8MP_ANATOP_AUDIO_PLL2_BYPASS		24
+#define IMX8MP_ANATOP_VIDEO_PLL_BYPASS		25
+#define IMX8MP_ANATOP_DRAM_PLL_BYPASS		26
+#define IMX8MP_ANATOP_GPU_PLL_BYPASS		27
+#define IMX8MP_ANATOP_VPU_PLL_BYPASS		28
+#define IMX8MP_ANATOP_ARM_PLL_BYPASS		29
+#define IMX8MP_ANATOP_SYS_PLL1_BYPASS		30
+#define IMX8MP_ANATOP_SYS_PLL2_BYPASS		31
+#define IMX8MP_ANATOP_SYS_PLL3_BYPASS		32
+#define IMX8MP_ANATOP_AUDIO_PLL1_OUT		33
+#define IMX8MP_ANATOP_AUDIO_PLL2_OUT		34
+#define IMX8MP_ANATOP_VIDEO_PLL_OUT		35
+#define IMX8MP_ANATOP_DRAM_PLL_OUT		36
+#define IMX8MP_ANATOP_GPU_PLL_OUT		37
+#define IMX8MP_ANATOP_VPU_PLL_OUT		38
+#define IMX8MP_ANATOP_ARM_PLL_OUT		39
+#define IMX8MP_ANATOP_SYS_PLL3_OUT		40
+#define IMX8MP_ANATOP_SYS_PLL1_OUT		41
+#define IMX8MP_ANATOP_SYS_PLL1_40M		42
+#define IMX8MP_ANATOP_SYS_PLL1_80M		43
+#define IMX8MP_ANATOP_SYS_PLL1_100M		44
+#define IMX8MP_ANATOP_SYS_PLL1_133M		45
+#define IMX8MP_ANATOP_SYS_PLL1_160M		46
+#define IMX8MP_ANATOP_SYS_PLL1_200M		47
+#define IMX8MP_ANATOP_SYS_PLL1_266M		48
+#define IMX8MP_ANATOP_SYS_PLL1_400M		49
+#define IMX8MP_ANATOP_SYS_PLL1_800M		50
+#define IMX8MP_ANATOP_SYS_PLL2_OUT		51
+#define IMX8MP_ANATOP_SYS_PLL2_50M		52
+#define IMX8MP_ANATOP_SYS_PLL2_100M		53
+#define IMX8MP_ANATOP_SYS_PLL2_125M		54
+#define IMX8MP_ANATOP_SYS_PLL2_166M		55
+#define IMX8MP_ANATOP_SYS_PLL2_200M		56
+#define IMX8MP_ANATOP_SYS_PLL2_250M		57
+#define IMX8MP_ANATOP_SYS_PLL2_333M		58
+#define IMX8MP_ANATOP_SYS_PLL2_500M		59
+#define IMX8MP_ANATOP_SYS_PLL2_1000M		60
+#define IMX8MP_ANATOP_CLK_CLKOUT1_SEL		61
+#define IMX8MP_ANATOP_CLK_CLKOUT1_DIV		62
+#define IMX8MP_ANATOP_CLK_CLKOUT1		63
+#define IMX8MP_ANATOP_CLK_CLKOUT2_SEL		64
+#define IMX8MP_ANATOP_CLK_CLKOUT2_DIV		65
+#define IMX8MP_ANATOP_CLK_CLKOUT2		66
+
+#define IMX8MP_ANATOP_CLK_END			67
+
 #endif
-- 
2.43.0



Return-Path: <linux-kernel+bounces-426696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A80909DF6C4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2105AB22153
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12631DDA3D;
	Sun,  1 Dec 2024 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gJYrbosl"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8C01DD526
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075258; cv=none; b=KQDrRLiDBJP4GqGdcCubQmSVrH2YM+Y1XVZ3g+bcju+yiyfjudyHaX5WVWcutTvAASIft6S2hrNJVydl/YKHOQSPvtqolbK2WLAQbJI1em8CJgBpqOMfyjA6Jop3gPtKAlvdhP+ixhQsi1c1/SiGxlYMUn55S1zcvPIjNGLFw2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075258; c=relaxed/simple;
	bh=FgS3VPSUb3LX7ZxAviEc5zpx+vimv7Cxc32ZpCChiWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uu6+JtI7AydUUYoh+Hbe3HQYnVcv8dpsdp/WcPs7XQcQyd3UvroiaqnLoimgshwlA3oNekeON6L+BFt1z7hGg9WOgQaOhK7CBOcidYBuxnp8LADxIi/Vt32vLVPMHdVpuZNV4nxYOO15l7NwkEMf/7A2WNk0XAN5mRaPDThqj7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=gJYrbosl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa520699becso581434066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 09:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733075255; x=1733680055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9ECY73UG8ehnqT2joX/xp2njmIlfmPxWimrFTqyoco=;
        b=gJYrboslG1VqpZUncM458LGw1SIbQn5hUP1Dw/ovO+0WSFANfviYJTOFrBy9OmZyw5
         BI68V7JE+M8igpI+T40+6g/VlsKYNHWLRjYrX4o82pSAGLqkE7Xr9IdvUCyATQwft3QX
         CYxGJbqlg2q7k2xPf7GvCfIqrJipxfjAHyO5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733075255; x=1733680055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9ECY73UG8ehnqT2joX/xp2njmIlfmPxWimrFTqyoco=;
        b=Od8mYIT2tcL3K4fwwd/1ksl43Ql/sgulHmm7cWBLRHbUHtRgx3psYo063RM1rc+dUk
         NIsAE+sEO+lvyuYeGSsu72DlFK3zPWKrveq2hQA/P0f0vnhfr6YDk/khj6XL/EEDh/gz
         txgcNw6tiWqfZ5wlso6suaYbZ+FTqAhcdvt46TMlizf8L/tRH1hbGXdYsGvHV032IivB
         YHphEATut12bTyLHjvHhKValAdx8teQ82qwdVY9bSjXGzND4tyTcwwGo4ircQkmpKX2F
         J+5aO6+RhQX/ANsSCbBqCw+su8qz1AOkdhsFaRoi8PuCUf12vv2M0p/8Cdhjx4TyN8Ur
         jM1A==
X-Gm-Message-State: AOJu0YxutPTGxqggZk68rDioyI29yw/yqJ23MH8CLvvSsWjHim6bUR7I
	efN1FoBMoppp2JQP4mnFIUdMIuHk22LMolo3LG5xtit4diWaQIiUOjJ7oMvpNJWIhjrxyaQ6dhy
	n
X-Gm-Gg: ASbGncs0uv5NpLQlfPdcXXSC3JnATyvQJQu9R68XKBDvrHlTzx83O+NzndGn5XbsdGB
	A3OddZw6fz3mMmSZpYJZTIFszSzQV7nftx5Pct5Oc6lqfXRVaXU/EW9Mi4LHukLX7o3jeUeaIRE
	GuML+6KqYlyOQbDq1OAKfoGh2hjDfLGn2FL7/6gQLEVapQOyKH36PruBzocfj+gJodFrJpqKkxP
	Ty+no8wh68Vy/ZF9wpdCcgBz8WC2iE0gDNsGBBeRuEAG2ZAAcct+p8v8bSjHTQlKNO1F/qelmoW
	tG9sykXastA+wOn/iRtUtidzAdb/YTgEHGasI+WvDQCib8a60q3oSN9e89cz7wPm25Euy476Cf7
	h6wyJRrpNtt3qxbDa
X-Google-Smtp-Source: AGHT+IGWip9V7SPf/QghX0+OWBObLNjALVbM+OpWM2YdiKPU4MTIDv5I0WeF92pbW/fXTxQeu5Tp/A==
X-Received: by 2002:a17:906:3d22:b0:aa5:11be:5703 with SMTP id a640c23a62f3a-aa580f3a76dmr1448724266b.35.1733075254737;
        Sun, 01 Dec 2024 09:47:34 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a78esm415220066b.163.2024.12.01.09.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 09:47:34 -0800 (PST)
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
Subject: [PATCH v4 10/18] dt-bindings: clock: imx8mp: add binding definitions for anatop
Date: Sun,  1 Dec 2024 18:46:10 +0100
Message-ID: <20241201174639.742000-11-dario.binacchi@amarulasolutions.com>
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

Add the bindings definitions for the anatop node. The patch is
preparatory for future developments.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

 - Added in v4

---

(no changes since v1)

 include/dt-bindings/clock/imx8mp-clock.h | 70 ++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/include/dt-bindings/clock/imx8mp-clock.h b/include/dt-bindings/clock/imx8mp-clock.h
index 0601df6c8d38..39e4ad470927 100644
--- a/include/dt-bindings/clock/imx8mp-clock.h
+++ b/include/dt-bindings/clock/imx8mp-clock.h
@@ -401,4 +401,74 @@
 
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



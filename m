Return-Path: <linux-kernel+bounces-426692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B91E39DF6BA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0121630AE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31771DA63D;
	Sun,  1 Dec 2024 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BCRYhjhe"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A964E1D95AA
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075252; cv=none; b=NPFZY6MoWO/9IqKwjEF5n8rRJCz5bjcE4R/YaYuU/FUUCCEq0CFt6rD5V3jVLDSDQ10ecqeqYxrARtzXvLaM+EFRYHn9kfH+ehGorrK4HjrJLLwspDdcaqwfeuhNNswkeN+nTGPQ99I3BmkFM8vg+K3sYbn5shebK6luGpxyjnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075252; c=relaxed/simple;
	bh=Ac4blgYWf7CVzjbS2BlFj/S4aCoc/+2YA3/WYpgya9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVsRDBlo8hVRWXvBKEaCvHC3Oy7XkMqNS+QpSrmyWuFHWQgCEnGqLGi/W07XuZR+QuvXkezg3onIDsE8JYaltcFYuH76U97nN0azzaIBAWnalgQ4/htEWn3gIRtfr/8P2A6s406vngFQvmdHt/rHBYggC4xkmzmAyHajClIqm0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=BCRYhjhe; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa503cced42so519224866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 09:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733075248; x=1733680048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYgi3gWsFZ6bxt2QyzESPfQwAyIPmeSWspE8fxXg91M=;
        b=BCRYhjheXnEUeISKgl1r1QINcE5GchNUBbuVt2yfNm+YVZAgSTFrpw9GuwF4brQekp
         zKV1hpfbFuOAQqRlStSIxFofSis4TNkbNqoVgVuB8Zq/UlpyhKHMo1Lv3iwIC5iO716I
         HaHDreP1CtbP5l3l7/o2OHFB27kKhz4OVp2w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733075248; x=1733680048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYgi3gWsFZ6bxt2QyzESPfQwAyIPmeSWspE8fxXg91M=;
        b=DBk7xKXGJKUJ7pccHhAHeII9GEpPcQTYqls0xHdR6M5awM77iLJBtxou4aVxHt42m1
         RZnGU5D2sm8IMIvtt4D2aVGWpVPfMvDh9yrgo8jLzklJnvpfn6Z6njK6aFPTkzt9IDoh
         bM4NLi18NBt4swbqqdJSB4pKwZYEnz4gKRVVYOVd7Mh6b0U8fyCJg1w+wvEU82KRkWkS
         0EDSncRLD3j4fcGLmLE2jFL2sdywqRx9S46uEwpp04BWqQ884wuoDCpe+qZQskLErJ1i
         3i/quu/hykAiL4Q9YYrk5rWulb4DxbTFA9xpV/DesJcEGe+Fo743QlaSCQyyxK3nKjQV
         nJGw==
X-Gm-Message-State: AOJu0YwBgtwT0s1Au70LvDpC44Nij8u8JosPJx0ydkD5I/iONrMOxlBX
	jt3R9n3ZntZTfhPwfefl0zUoKt8kaGDWW42Uwhi99WChsgUZXzcejk+Fys8RAq/V4yvpbqp260q
	t
X-Gm-Gg: ASbGncv1LHwwaMAUYpdE8P297e4lnHGob8dVCKXBnVpyu60ghFzP5pbDFIhgS6XVYx5
	tegJssCzio1SkjIL4AaYGHM6tOTaXDHUOQserCYZBZ5YfQj6xW/oj1JkXNrRuTUK4JwYuatOc6y
	ezBzDTZ165a33ktsuOc2XPUlJ9e+LDyzeOS1WHjg3ABqVkWwBuEfpVt6OFH3mg9839FBX6dBayw
	wefBKALOz/MN83CWsFGcdTbdiGO5Q4aKeYrRJ032je3dvKo0eyUOeEPQRO1nI55VA7ZUBhUtKgx
	P4RsZMh8kqlWXv6+CddOTIGKHNNPIPF5lRwRl53uPZBvFHjQW/xLEYqAoZ1rz6UwiGMaeiNd/J0
	Aa6M+qqfLYOuU9riP
X-Google-Smtp-Source: AGHT+IFEnqfNEU+rcacBAMtddOncowvVosTxbTcww82LB9zIQkVF6gwcSPLsVyk8WzQcN3keRGes3Q==
X-Received: by 2002:a17:906:2932:b0:aa5:396a:c9e8 with SMTP id a640c23a62f3a-aa580f27899mr1226207466b.23.1733075248682;
        Sun, 01 Dec 2024 09:47:28 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a78esm415220066b.163.2024.12.01.09.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 09:47:28 -0800 (PST)
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
Subject: [PATCH v4 06/18] arm64: dts: imx8mp: add anatop clocks
Date: Sun,  1 Dec 2024 18:46:06 +0100
Message-ID: <20241201174639.742000-7-dario.binacchi@amarulasolutions.com>
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

Add clocks to anatop node.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

 - Added in v4

---

(no changes since v1)

 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index e0d3b8cba221..0b928e173f29 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -709,6 +709,8 @@ anatop: clock-controller@30360000 {
 				compatible = "fsl,imx8mp-anatop", "fsl,imx8mm-anatop";
 				reg = <0x30360000 0x10000>;
 				#clock-cells = <1>;
+				clocks = <&osc_32k>, <&osc_24m>;
+				clock-names = "osc_32k", "osc_24m";
 			};
 
 			snvs: snvs@30370000 {
-- 
2.43.0



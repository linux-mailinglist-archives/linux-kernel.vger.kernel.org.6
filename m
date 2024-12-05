Return-Path: <linux-kernel+bounces-433076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 027129E53A4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45B41882D37
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472DE206F06;
	Thu,  5 Dec 2024 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KTrQYe9P"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA23206F33
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397599; cv=none; b=XF3HBTgBAmcjnb3yaRrxFhhp7TcBU8vPSvFvhbzUAx9SEyu7weLkVVvqjwXlrzsZkDh1GmKxYSXVWqoR7iNOynfguPYVJbABmcuW41BLDTsRCJ8Q3PzljLAB1qwkXqOL60X8E5J2xlnVTQOHSNwiw4Fs4X7jAjt6o4xh9vp4K2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397599; c=relaxed/simple;
	bh=vc25/TFqvg0Ekr2Sm4G/VkkviBdPeMF5e7FdTWNCvAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsUx1QHLjlXIwGGPz7qyDZgRTi2ECa6fS70VM7UpbFjp/8dZMIdDyqe44jilLqmc0Ty4V1E8XwFYxDfzIwKZIZguXG/Je18oy6169pEi+NKu4vU9mh8mmg2rtiH2HuYx/0pU5TxlZyS2ecT0SRGyil1rvoNw0UfXbgjqfdxnlFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=KTrQYe9P; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e224bbaccso756158e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733397596; x=1734002396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHj8xJJDjB/nn7+FV+WNgNcGZHPneQlK/63TZumKERk=;
        b=KTrQYe9PwLiXd3Vt7b0XYvmC1/FImxTaqLeRJyrUOy56ehjvAOctWGJ2JfwmiAsgvq
         5few4RgmwLR7QY6yIvUnXz9j2EFUpCKfWhgsPCThAls7GK+rma9bE58S7An9/LEGZpG0
         loaEHZZ244eDqbSyavkaagjSi3gTyxwDo27uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733397596; x=1734002396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHj8xJJDjB/nn7+FV+WNgNcGZHPneQlK/63TZumKERk=;
        b=G1BTOTRujAAyvEMA5/njgR4WDnv8pNt0uNbnjsMqb0VGqbcjolCdoHpM7c35xlnemL
         cjcGXPmEVydIpBcoeSISZFaqV/De4PuL2bWoAbFL4Y3T0ZSABRL5fr9kn57mYhdUpAjE
         kxkfTHNONSD5S52/Tff6QTg0POOt2RnfDp1fha1CYtl5+O7K9XZgkQQ1BwiuOjwxnoJf
         cxMgfE/41biRFDo/BTj9wgwFgF1mwL0LiJR3R+0oo5QQ0VYDBAx2hCS/Z31DSdaBl/qa
         yocLS+XlghoTw2Qke3i95YRrXjHkpLU5VUvP2vaUgg7D3T0MrM0/pNIFHQ5q1Y1D8XEn
         QB4g==
X-Gm-Message-State: AOJu0YzH5FREep5QS10FtBFfeTjomhysRsfolaVwHovhGK+BXJHBjE1p
	4CqCfwVn9yd2eAkyo+o0Xin9wkGLhzf9yNn5TaQLir407M326QLueOqwGMBhYv5urZlBYzSR9fv
	l
X-Gm-Gg: ASbGncs8eUZhPhEX1MQ8xkqptr8HfYhqUY/xK04+2FLkNlRE2KDj7DrNryZGqFs7SY8
	60/ysUroxELFGvi+o3Sq2ISe92zXG5LCTcIGFPnuMu6GAT92CfCxLggbouzn120cpzUmVLsIwn2
	UjKexK3vTUhad3Xt7UNHu7KDHq1PBNcXSYjxp8fpQC4k5rYV/8hQ9C2YnturL3D7ijdkoLtdiV5
	V9VLUAYyJRfRo75F+GnBxpK75ND6odY0RYsAaC4zZ2naOiW0gg/T4+Q50q+lKKtVHl9hzXPt8/7
	6py+osE4ryddVvHgrVWXy3745CjWkOOEno3MC1tKMptDyQ==
X-Google-Smtp-Source: AGHT+IEtuduGBZsALDR63XXUfmp8mk6Ffl1qQAFy8dFjE8C6ALJJ5nV+WsPlwDq8/o6BI50yiETcjA==
X-Received: by 2002:a05:6512:3ba3:b0:53e:284a:70e9 with SMTP id 2adb3069b0e04-53e284a712dmr306591e87.57.1733397595775;
        Thu, 05 Dec 2024 03:19:55 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2001:b07:6474:ebbf:61a1:9bc8:52c6:3c2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eedcd0sm77505266b.87.2024.12.05.03.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 03:19:55 -0800 (PST)
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
Subject: [PATCH v5 09/20] arm64: dts: imx8mq: add anatop clocks
Date: Thu,  5 Dec 2024 12:17:44 +0100
Message-ID: <20241205111939.1796244-10-dario.binacchi@amarulasolutions.com>
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

Add clocks to anatop node.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v4)

Changes in v4:
- New

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index d51de8d899b2..1d1424a136f0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -817,6 +817,8 @@ anatop: clock-controller@30360000 {
 				reg = <0x30360000 0x10000>;
 				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 				#clock-cells = <1>;
+				clocks = <&ckil>, <&osc_25m>, <&osc_27m>;
+				clock-names = "ckil", "osc_25m", "osc_27m";
 			};
 
 			snvs: snvs@30370000 {
-- 
2.43.0



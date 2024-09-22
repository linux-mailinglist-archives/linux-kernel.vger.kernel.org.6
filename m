Return-Path: <linux-kernel+bounces-335225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA5197E2CF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 19:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36CA1C20D14
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 17:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F0D3BB30;
	Sun, 22 Sep 2024 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c198BLR1"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5418F482E2;
	Sun, 22 Sep 2024 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727027016; cv=none; b=q73elEyDX6HeSI7yQ+7+D5RRIbAphlZ29TCc7vTnaU68lm0XgrRkZKccsEFFdV1jcWH0KRzlJRnOj3PkOwUnfXCeK6T5xmEIS7uYBthaI4y2pFYCbhdriqUTni+fegGkumEqJb1y8l7JyuX3LjMXlKSnIhT8Gqp2aQ/1mAxjEdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727027016; c=relaxed/simple;
	bh=yy9gl9pQz3F5fgfnipmdtFV0zJl13QipSJnEg+3xNDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fCTQIwtgFKFODJVCASD+SI91hS7wjgq2ieK/UUwGI63rMoD+pdrvwXpa32bZAI/3zy/oN12nhmoVsME7EoOvGu4JgDcIs1+SukQC5yn76A09DI8jlF9d1N2Lr226uBfjjcbDOVFziCjx10oBwSHZbBmtGIbn6wbB15O9c9ZtgHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c198BLR1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso31759925e9.2;
        Sun, 22 Sep 2024 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727027014; x=1727631814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXLPtmmwbw0kH9maBt8kI0QUZhZ3U60BovT7L6yY3xs=;
        b=c198BLR1AJpnOAz31J9rRuxTuLQjRol54f2Vbaa3SHHXU0bK5oW5jqQLrOmq/gfJUi
         AhIJThAcfD+53aZFAVHWP/9VPh/+8hL4K91jQfpQUuwWbHhyBOMokFwHJoiDPIGFMXsy
         Hg2yD9/dL47npRz+sDWuHeZlA2hXPFGmewtZjGT6dXPe/6bL67Z+76dWyhOFULba87Mn
         d8rKpkPRpx13Q7rQwaEgv2lTpLE8OnwgXd6TT0/FOi+ltjI5blrBx3a3CQDfkMcB4vLO
         YkS5tr4xG9REhNieMhQg2sm9UB+nVcYw0kdGIeOaLgH/LNAPVhp4nA6Mcp0TZU5WkrlJ
         ILNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727027014; x=1727631814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXLPtmmwbw0kH9maBt8kI0QUZhZ3U60BovT7L6yY3xs=;
        b=C4YIdCSFf//uwj50Sx1P1WYxKUIUmQBH0DQKsGm2xGdT7v+7HqckaGUTm4F6yMQqz9
         rNezTPOPCXYhT09g2VCx64Wr6HcASP0Cf+S5QjomrFuDBxhsqREQnunY3qaRxBcUzpZk
         3U6NQ7WS8yFW+hR6bayoAfD8fAUY7b3OIaoKxXvwnMn6BknTGr2GvKPnqKplE0oao48i
         oG2KHLeK95LpUP8UuwK79cIwXKlyPQh4jZgxYtMPUocAsBEBWxCJ9LjP58Q5LwrCfcEO
         AWos4XG63/7RqFsfjLU2RNa5su8A6gWkmcjsIfvK/VCUOWIx1v+FpC4KABum0A0c47dP
         w2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0Duc/Hfh4RQGaAbE+yGVsSJx2YDBzxzoZJuWVyZpGu2VbiOLNuvCg9sXKWEGWyC8rF/YSAzVvMOl4i8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9iSaW5qmkmJGohUF6goJCf108p61mrbJmM3I84Bs60lUsbHiy
	u64uha90biIfHXQFnEXtpEofFgUNv1vHu/393MgXSWTeolDQSCJp
X-Google-Smtp-Source: AGHT+IHphXu0dGNfZ9BDNAw2gAnN60BBDuqllWZxOcm2vfWqG7Fy/AldhWq3sNJHPEbqGKEbIpHQ2w==
X-Received: by 2002:a05:600c:4695:b0:42c:ae30:fc4d with SMTP id 5b1f17b1804b1-42e7abe12b1mr74954615e9.7.1727027013486;
        Sun, 22 Sep 2024 10:43:33 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7ae60ad0sm80758535e9.1.2024.09.22.10.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 10:43:32 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] arm64: dts: imx8ulp: add AVD-SIM node
Date: Sun, 22 Sep 2024 13:42:25 -0400
Message-Id: <20240922174225.75948-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240922174225.75948-1-laurentiumihalcea111@gmail.com>
References: <20240922174225.75948-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add node for imx8ulp's AVD-SIM module. This also
includes its children.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index e32d5afcf4a9..1ffa4da23042 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -614,6 +614,19 @@ per_bridge5: bus@2d800000 {
 			#size-cells = <1>;
 			ranges;
 
+			avd_sim: syscon@2da50000 {
+				compatible = "nxp,imx8ulp-avd-sim-reset", "syscon";
+				reg = <0x2da50000 0x38>;
+				clocks = <&pcc5 IMX8ULP_CLK_AVD_SIM>;
+				#reset-cells = <1>;
+
+				mux: mux-controller {
+					compatible = "mmio-mux";
+					#mux-control-cells = <1>;
+					mux-reg-masks = <0x8 0x00000200>;
+				};
+			};
+
 			cgc2: clock-controller@2da60000 {
 				compatible = "fsl,imx8ulp-cgc2";
 				reg = <0x2da60000 0x10000>;
-- 
2.34.1



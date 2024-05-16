Return-Path: <linux-kernel+bounces-181572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01738C7DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F6F2B2216D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2438158D6C;
	Thu, 16 May 2024 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjS/hsgi"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF90158A1C;
	Thu, 16 May 2024 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715892098; cv=none; b=j9TtnSl1g1juI8jSznlYXWIxZJgSgg24nNdwl5bNm4/4KP5aoOxH+lHa3OhjI0YALCSUKj4d0sVLqksdW3gBtsmqiB1f1In09RfdwpFz8xKf18nRLPrLEiIEWuAfNOaWbdCvq6GUMZPU1mLIHxEH7vpeVgjCW3dlvsEIMExYR/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715892098; c=relaxed/simple;
	bh=4oadGygxYA7bjkv7TT+WWegMW5gp9hz2kjni4oNe4jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GraBeKmfDqEBroeElnNvTNRO5BRGgs9BX63Loi4obvwHP1AHd4UgpgAeqQd/cPbZK/wqWnWAFO6aPrZVmjeFX2n/pUG28UJ39in/MXo7r//sx/NuvTTj7HEITdA0kb2gH6vIq+MwzAbUHFn5+0fivTeCqr07hs9seUjvZcejJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjS/hsgi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42011507a57so42890365e9.1;
        Thu, 16 May 2024 13:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715892095; x=1716496895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Kwo/PJKWqwFR8G1QKaJWay+TAo/b1R/praQRuQi8t8=;
        b=gjS/hsgigOsaA04kuRHUv54zYJ1+IPXEgyX0RK6HSOLWBZC1rOhBEzJNAs+OcX1w1G
         TaPFBl1UF8F3pAVpKYslfms4yTq2YOBSn1tN1KR/Se0jPsXi0sN+mka1+OibcJxtivHS
         gQ6bi2L0p46NASNa1XHFH08WIwD7aM1UVENDc2kXdLcLnFo1rsspwy1BUISuTOZ0eLa8
         ZOX7dJf7R3GPOX/w1HnOrhQP5DjZ1uAUOFRnkAAvFFz2JLhel2uHNwGgPDnbnGpREevq
         s2+nV5LSnAcLzMRFXX8SsNnZ9zCfjuVK2olpC93SZV7rotwhAfItv/gIXmjhdJ1BBzZm
         u8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715892095; x=1716496895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Kwo/PJKWqwFR8G1QKaJWay+TAo/b1R/praQRuQi8t8=;
        b=G40JXb7V1kRRnpvCgsCC+RGoSXp+2eaI4mvN7XXJK43EE81tjq3V7q4Q9AgezPso4h
         FykPCSylTNgW6lPHG4O/eqtx5amAmAi9QkwQ42dN3C3C+rFjsnDOKAZj/byNBegPf/UB
         Sd0VZ3KN2ckehqvIkrSpCC99GNpOqishEZR1OQGhyb3BEz1Lh0+LFqZZFMnwsQWosRi3
         T0QlwmcilAaflITnkd12zGCCQf8qTAxQJT7y3nhKLOSJmYZ3yiReVo4aJfAEVHJ20CRm
         5zFyb8MAQ4OcPN5GRSjz/mTbdmb6mumFywGT52rQ9sMRvzggN0wTw3L0+3EabmchTP3H
         GkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI8Ri47RvtT8ZILRgSjdogk1yiVpFISXFBDcKbUGye3eQtYBEgz+R1BZf72RdFemAYXHJ0aJdvltcT3UWrlgKt6khWV5bsY+fXOqKSLoiFQ9R1BO065S84hQ6G2HzpwAv0PHuL5e2a5A==
X-Gm-Message-State: AOJu0Yy0VAxsy1Xvbc5TH/Quy4H6QyrfCpQyTqRJxj6ByJ7L8VckEmWQ
	WKZTBzbsa/e/L5PekxJYJwPlOeJ5WVJ6o+RQBhB3iTDT+yA9jf5k
X-Google-Smtp-Source: AGHT+IFNas3/3kPAsfpD5yX3BBvTnf6Ycfw16x5JhHOqISi3MwmXqWdKiNWT3OlLuArijC+XTR2qiw==
X-Received: by 2002:a05:600c:198a:b0:41b:fc3a:f1ef with SMTP id 5b1f17b1804b1-41feac5a3damr136908115e9.33.1715892095152;
        Thu, 16 May 2024 13:41:35 -0700 (PDT)
Received: from localhost.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2b8f7fsm10859828a12.66.2024.05.16.13.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 13:41:34 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liu Ying <victor.liu@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: laurentiu.mihalcea@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: imx8ulp: add AVD-SIM node
Date: Thu, 16 May 2024 23:40:31 +0300
Message-Id: <20240516204031.171920-5-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516204031.171920-1-laurentiumihalcea111@gmail.com>
References: <20240516204031.171920-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add node for imx8ulp's AVD-SIM. This also includes its children.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index c4a0082f30d3..5135d98dc6f2 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -520,6 +520,23 @@ per_bridge5: bus@2d800000 {
 			#size-cells = <1>;
 			ranges;
 
+			avd_sim: syscon@2da50000 {
+				compatible = "nxp,imx8ulp-avd-sim", "syscon";
+				reg = <0x2da50000 0x38>;
+				clocks = <&pcc5 IMX8ULP_CLK_AVD_SIM>;
+
+				mux: mux-controller {
+					compatible = "mmio-mux";
+					#mux-control-cells = <1>;
+					mux-reg-masks = <0x8 0x00000200>;
+				};
+
+				avd_sim_rst: reset-controller {
+					compatible = "nxp,imx8ulp-avd-sim-reset";
+					#reset-cells = <1>;
+				};
+			};
+
 			cgc2: clock-controller@2da60000 {
 				compatible = "fsl,imx8ulp-cgc2";
 				reg = <0x2da60000 0x10000>;
-- 
2.34.1



Return-Path: <linux-kernel+bounces-374705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CFD9A6ED0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB892836CA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0192C1CCB4D;
	Mon, 21 Oct 2024 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGpyTIfp"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C8D1CDA0B;
	Mon, 21 Oct 2024 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525989; cv=none; b=Ki0aNVsoXHZO/W6RSFel9lyX+XHs7cWfBPqfBRsEB83DhXGSXQIvzLSGC663rvZBYQWvzn/wAMt/vdFI+HMVdXcjYnYp8t3Gr6IpZqN2/qXaHRCY9w3irf3V/c5daTWXToXj0AOYtl+BV3m99fBCp6i8RK7ytJ9D+8JUb1JqOVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525989; c=relaxed/simple;
	bh=Sw1Bzb82rcjdsOFSPq5AGlkPnJMB/ljcdy+n+JSSh2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A7a8Tyz9X7nKiLefOeB5WMzn3lqAy/ZvY6PPPYJ39qHZUZJXQu978DEBVi7xqljO62kWomwZoYwGfz01OeYZODyIWc9a7+T5iZ644ZyS2TeiuU2mblYGtJhEsFUtjXstL9bOYrXAxGoz+FaDn34BSlso6fl7wpnKSn3L+CsADIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGpyTIfp; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso71881491fa.3;
        Mon, 21 Oct 2024 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729525985; x=1730130785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hh7X0fydqIufhtd8PZzP/EIASN+FGLQT9ALrXUwVIA0=;
        b=SGpyTIfpA3m+40JDXTZVR1Zl/kSCTDSVEUQSjoVdoynO9LLiy+q6ASccYd7XyxeT7b
         yZE6XScrk08Zm2Gj7OHqHwUUxSBtVsBPqAZdIZ3jwsPujBtjKIu3CVNykYr7gS72zAjk
         7YitRJPsu7xX0tdThLcU669FEavvvvNLOPF5I9Os1Y+2ejVb9HI8JhvsgzlE6TEnFkmj
         eTUCD6GuJ2RchRmlYxzr+YM4THom2asax8Bp8ulcWqgXCDbsQnyaf0if+nm8l8H1G709
         KYbpvh6sf6498GmDvpWVWuzfngG4F1m0BjJBcVcf3IGMfyaJWyDS6fbVRCDFnFnEB26o
         YQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525985; x=1730130785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hh7X0fydqIufhtd8PZzP/EIASN+FGLQT9ALrXUwVIA0=;
        b=idQI9rtbaqnK0oZFo2W6WQqQ/rZaeRvuYEVaYrVALXQs/j1dG1q1D8Dz30w4g8eQyT
         6KN0/3GSU92KONmMqBOAfmly+6q20WB0L9YlSJjyTj7yLfP6o+ohlZvR4uQKzxc0wH9c
         ZnTPnSEHeo/WuIwdpQI2hK6bDppJc/erpGBOHnuiXt1w4ECcAUUBOa5l/2vozdAjqtFn
         mMo6gbZpa7/ib9/HRrLvrXqzU6Zjz9Wd3RR0BT+ByABUZrJQo3s50q78t/40RNjteeDa
         VTERl8u4sjQNADE1MK9gWirkOv/nkhoeBLAX2Eq20sIvdCJFM3trVbmmF3OY/JeTS5QN
         oiJg==
X-Forwarded-Encrypted: i=1; AJvYcCWDMk51KluP9ptuCcO/9eU5++uTN5YRAtDD/pJcW7riDhEefCu2iJozAj00OpKzuYsBvA9J+BJeXHxZWPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7jvjvb6eIS2lz+AuXGv8Gv7uH7zvK5QUWhz52O3ufpnpyikep
	Cz/jMWput4YoWak45LzsONSSLJ0KZUN2bVYvgl4mEpuh20dXVPoA
X-Google-Smtp-Source: AGHT+IGYrgG25Z/I0gGtpppxwAYbzIVLhyYw2kd6/eNRNxaHCAl3YECg5/S05qSKVfqTqP9ANYFRZg==
X-Received: by 2002:a05:6512:3b20:b0:539:901c:e2e with SMTP id 2adb3069b0e04-53a154eb6famr10055650e87.58.1729525985072;
        Mon, 21 Oct 2024 08:53:05 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edfd0sm218614366b.67.2024.10.21.08.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 08:53:04 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Li <Frank.li@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/6] arm64: dts: imx8qxp-mek: add dsp rproc-related mem regions
Date: Mon, 21 Oct 2024 11:52:18 -0400
Message-Id: <20241021155221.112073-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021155221.112073-1-laurentiumihalcea111@gmail.com>
References: <20241021155221.112073-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add missing dsp rproc-related reserved memory regions and assign them to
the 'dsp' node.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 936ba5ecdcac..4c4e71d39bac 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -21,6 +21,24 @@ memory@80000000 {
 		reg = <0x00000000 0x80000000 0 0x40000000>;
 	};
 
+	reserved-memory {
+		dsp_vdev0vring0: memory@942f0000 {
+			reg = <0 0x942f0000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0vring1: memory@942f8000 {
+			reg = <0 0x942f8000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0buffer: memory@94300000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x94300000 0 0x100000>;
+			no-map;
+		};
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -63,7 +81,8 @@ sound-wm8960 {
 };
 
 &dsp {
-	memory-region = <&dsp_reserved>;
+	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
+			<&dsp_vdev0vring1>, <&dsp_reserved>;
 	status = "okay";
 };
 
-- 
2.34.1



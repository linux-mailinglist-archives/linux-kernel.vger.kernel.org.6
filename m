Return-Path: <linux-kernel+bounces-249039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC7992E568
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5848CB23379
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5C115AAD9;
	Thu, 11 Jul 2024 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gzKPQJOh"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A8A14A4E5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696041; cv=none; b=Qjoui+X97j7ftd3rkW8mQB3Ugf1UoJizjgltmgVpCHRqEO6FOcxV2D5gk2hQOYb+naMeFNdL2EiVY96Ajh/NCETvvuNrSiVLNH3dvVuKH4kgrArlzlAL/WLAu1yr1c5BeiJbvjYe160jjMWEIYMPslpPcmzquAhnPI2db7RchlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696041; c=relaxed/simple;
	bh=wnWDB5nejne8Pd/cb6YS18Vh8Y2+qTrhoxUlqW4sty4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCy5p65LI0qVlfj1zmoziCfWeld7LzqWkHoGxoac7HXUPN3Q8CyABt2FT/X4aeHHfWRbKwV4KIQJgahJV6n5bK0doSOiaw5wiFVQIxKzMMB9rim1kdzbMX9mxb1iepDB1So9tl/mHKjnQdwTvNDVbfBT+JP/dksGiyqUNlQKIJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gzKPQJOh; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ea34ffcdaso879339e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720696038; x=1721300838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYQspj63P8cbNmxsmkFzZLYMMBvuBKUGyS24iSaOQ/0=;
        b=gzKPQJOhwWyTH5sM5CSMlLQurXralCs/dpAXjrpmJjwvfQFXA1RsVw9STGueczkQhM
         Z4h57pF7xg1c4h3DM3piKXM/c3+HSJJXQtnb+xe4tbuaCTlGwWma4oOOnD8rHy1oX90N
         5klG9u33O3veS7m/WaKnWL8vPEaNgv7WoibeIBZ6m08O1qG4L9yYGPTtXiD/WLfGfkxR
         dUT8RPZfdrHjkGnX5a8POM49sOz+dJpPkl/D+FUXKAw3EBaUxXdWKHRttOJ7xaEUrBT2
         rnDWwb4aS55Qkzzdzu5ipPXhHr3T5u2gZiIL3dQQNI5lcaZwDFZq5VvSQV3mnJdlVY3A
         w5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720696038; x=1721300838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYQspj63P8cbNmxsmkFzZLYMMBvuBKUGyS24iSaOQ/0=;
        b=Dw1zsPpP21VlfFvhuZxaHyhfruEB8acyA9zPb2yvZn5VyihElFSi81JX/U7ZREBsFz
         VownduKRHctiDvP9thMymWWhLBf5cChdUnitnbf7uKqiDU7/FR02K0fkUrXO+3v/Qrro
         NHnLymJ8eAsgKNDMJOhmJ4fX4H1n2a/sf/QgPIyvnq40U8jDB9yTTjxojQH6T4i7gyFI
         NMhWMM8yrdXO9wBnjaS83FBALKRfg+QVOkIUGVKm7usQ7yf2zW399KM8VHteeGMwmRMB
         85IqtYxjf+6VWUTkqLXZqsn9xg3iqDgVtlpDaYO400OQbS42YofQtgTZ0KRpOMDuv8lG
         0hbg==
X-Forwarded-Encrypted: i=1; AJvYcCX4E6w0jUn/9h/yayRIoT13WzFVMxEgVitrhvdaF6S1V6gDPvtqTm/J5ogSrANl3e2DJ0pVeltPpdbokgK8RH+L+zlQAeI6oUge2GN2
X-Gm-Message-State: AOJu0Yw+lWdOv/UyD05TwCevKOMr0m+W/uuYSfPlhvrlywbWbEU5e51m
	hswVM/Ul5nwM9OBEJ6hDuiw80tVND6mn1VVLKL4zMW+6Bx1hN1fTg+0QB41n9vHEbYVx/M9HNgr
	U
X-Google-Smtp-Source: AGHT+IEmiTexL9y2JU6kpSqK/FycmvWYPZBv93UvuVGYDXAgHhf7NjFAX/K7loJT0/eeCqfQQrujig==
X-Received: by 2002:a05:6512:5c4:b0:52c:dd0c:4c57 with SMTP id 2adb3069b0e04-52eb99954bdmr4009491e87.27.1720696037889;
        Thu, 11 Jul 2024 04:07:17 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e097bsm115686685e9.6.2024.07.11.04.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 04:07:15 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: linux-arm-msm@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/5] ARM: dts: qcom: apq8064-pins: correct error in drive-strength property
Date: Thu, 11 Jul 2024 12:01:38 +0100
Message-ID: <20240711110545.31641-3-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711110545.31641-2-rayyan.ansari@linaro.org>
References: <20240711110545.31641-2-rayyan.ansari@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "drive-strength" property was incorrectly spelt as "drive-strengh".
Correct this.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
v1 -> v2: split from main apq8064 patch

 arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi
index 7c545c50847b..107fc19f1331 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064-pins.dtsi
@@ -11,19 +11,19 @@ pios {
 	sdcc1_pins: sdcc1-pin-active {
 		clk {
 			pins = "sdc1_clk";
-			drive-strengh = <16>;
+			drive-strength = <16>;
 			bias-disable;
 		};
 
 		cmd {
 			pins = "sdc1_cmd";
-			drive-strengh = <10>;
+			drive-strength = <10>;
 			bias-pull-up;
 		};
 
 		data {
 			pins = "sdc1_data";
-			drive-strengh = <10>;
+			drive-strength = <10>;
 			bias-pull-up;
 		};
 	};
@@ -31,19 +31,19 @@ data {
 	sdcc3_pins: sdcc3-pin-active {
 		clk {
 			pins = "sdc3_clk";
-			drive-strengh = <8>;
+			drive-strength = <8>;
 			bias-disable;
 		};
 
 		cmd {
 			pins = "sdc3_cmd";
-			drive-strengh = <8>;
+			drive-strength = <8>;
 			bias-pull-up;
 		};
 
 		data {
 			pins = "sdc3_data";
-			drive-strengh = <8>;
+			drive-strength = <8>;
 			bias-pull-up;
 		};
 	};
-- 
2.45.2



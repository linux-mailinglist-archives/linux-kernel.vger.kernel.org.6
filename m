Return-Path: <linux-kernel+bounces-255005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05898933A63
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364961C21FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEE717F369;
	Wed, 17 Jul 2024 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EPdazVsK"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D22517DE29
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209903; cv=none; b=nHDXheSZpcqub3Za2+kjZtQdg80blk0/Ht0cBkLDNu/Igzgt1WyQqmY6PwNjJEr5R7srrTwn9zL+tG7HHoYyxJlU/mDJpZS3y7mRtERz+sIn6PQCXNLeI/+uwSXH6v5YCPxsJ8/90iI3N0u6h/KzEhTnHDop5ebNfizcSYMzvlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209903; c=relaxed/simple;
	bh=XjPO4Ujl3TqO0ehaFLTH9wqk7RVaiNdwo+utqr7DVQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hw7M5ifXXhesrOQ9rC87HiZdk0a8+u1sJ4JKQqxOOMiaB6EtevarVVswabEMfYx4RPmyd3j/f1nDgZFQOQA1YaUJRxaesF/WEctXn3W5hriAgmW+1B/PPtnPMvR+jkN98kg3TnvxEppp8uW6fC9gq6jkNibzzk7dhfV9N1pekJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EPdazVsK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-426717a2d12so3584275e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721209900; x=1721814700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KrgfBcfXJnebqfMYE7lcXwUabsHP1Gvn4fS4TLr/7sc=;
        b=EPdazVsK1pzee+fn+PXSdVPdTouEXH4U9lEFCUXeLTYYwHS3DhnF4kaDPW9cUzMRyH
         kUvEQfcCfPfcjymWVry8UfHTuygB6gj0ntyJwvFTaEJmLXvSekxKDwIP7ZCHgmO3mU6+
         7snuwzmiNH+PCy0eFbal2tm/0FtsUmJik73Q6nXs9FxQTYwJqjTbKAScF6+1aUSK3Lyt
         3MopZsgRnxW8FTNEyA91i8VElEILMNAXsQc+dBqjVK6ASzQUdg3kOSBGIwnjPWiGL3CZ
         +GBLr0N3ffj/cejnW6Br86LqMz1AD5awW7ozy7wS8Z1/AV9G4lfVvIy5ib5SpHw3z4S3
         BSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721209900; x=1721814700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KrgfBcfXJnebqfMYE7lcXwUabsHP1Gvn4fS4TLr/7sc=;
        b=UcKvwAd2mU/2O5RW74YpF++ITOZp/9xUHPsius3vXJfAPAOJ+P0TDkkB/E2iGGkYeg
         M5FFO7Hp9f+gT1hRyR1Yo2HGvA1kWSWGT6H7JaV/keihzoRCaIjesOupM8PUQilVXf57
         sfPdDRZHnOgvhOH0j/HWj7FPvI3WQR842lmx9o1QfIPUWXwxYD1yyNDS9ZaPPeh+jZJc
         3AWrsZl4/7FbE/56jxT5q+wW/q2hRNBklj+7YBt6MGckQWXZlIJNQDtWQPbBsbYFGmLY
         L5VnchoaCCh2muaEumuPSLIY5yJX/NS+IlsysvERO2vWgf7bgF06nB+Q0LI2o7YcoNIR
         xc7g==
X-Forwarded-Encrypted: i=1; AJvYcCUVDwZJ9p8IpnowOiX/UJ0vqyJakuVi83bmM7e2X5UOZX1fPV8m0UB0rthQqPBjJ6sW4APUiqePngsEFFFVTwB9CZmwecBqdG+v94v7
X-Gm-Message-State: AOJu0YwQe9Kt/JVWldnlNQqr/1UFAL+946iDvJup8uJSIfBf1ODnxzXV
	S0LhHy8W6kSjgRVUIbOyPr3XFs05ObwtAgYGkZFsBUP2O5NAesz8kb23A7tVDgA=
X-Google-Smtp-Source: AGHT+IHt87UdRCgV2hI8InjDLgAXNmflrFtTlkgJQLWAM9c6YH0WpJaeBwuCRentm5LDb2Gd9eIfcg==
X-Received: by 2002:a05:600c:5121:b0:426:618a:a092 with SMTP id 5b1f17b1804b1-427bb8e85c4mr32743525e9.13.1721209899817;
        Wed, 17 Jul 2024 02:51:39 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5ef4617sm162447795e9.41.2024.07.17.02.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 02:51:39 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: linux-arm-msm@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: qcom: {a,i}pq8064: correct clock-names in sata node
Date: Wed, 17 Jul 2024 10:49:14 +0100
Message-ID: <20240717094914.17931-2-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the clock-names in the AHCI SATA controller node to adhere to
the bindings.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
v1 -> v2: split off from patch series (no change in patch contents)
v1: https://lore.kernel.org/all/20240716105245.49549-1-rayyan.ansari@linaro.org/

 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 4 ++--
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 769e151747c3..be42e93bee1c 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -890,9 +890,9 @@ sata0: sata@29000000 {
 				 <&gcc SATA_PMALIVE_CLK>;
 			clock-names = "slave_iface",
 				      "iface",
-				      "bus",
+				      "core",
 				      "rxoob",
-				      "core_pmalive";
+				      "pmalive";
 
 			assigned-clocks = <&gcc SATA_RXOOB_CLK>,
 					  <&gcc SATA_PMALIVE_CLK>;
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
index da0fd75f4711..dd974eb4065f 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
@@ -1292,7 +1292,7 @@ sata: sata@29000000 {
 				 <&gcc SATA_A_CLK>,
 				 <&gcc SATA_RXOOB_CLK>,
 				 <&gcc SATA_PMALIVE_CLK>;
-			clock-names = "slave_face", "iface", "core",
+			clock-names = "slave_iface", "iface", "core",
 					"rxoob", "pmalive";
 
 			assigned-clocks = <&gcc SATA_RXOOB_CLK>, <&gcc SATA_PMALIVE_CLK>;
-- 
2.45.2



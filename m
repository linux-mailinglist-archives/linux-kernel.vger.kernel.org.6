Return-Path: <linux-kernel+bounces-370869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 054AF9A3315
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364F71C221E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F4516BE3A;
	Fri, 18 Oct 2024 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxwK9aFW"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842A16631C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220103; cv=none; b=FU9E+GdHYbSnH7x4H/BtzaCWoAHz037gItwoeze2czh9bLwyBVeKZrTyyfzCBqUoCfgUvEofv4k0Y4dOHHw63ySF/BcMO1EpVE/ai2ExLQkrdPYFTEoKl4JAkfAwS6kA8UoFoPblaroSXpqSEGgZWzUc+dj6nLrQAZjZxaMRk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220103; c=relaxed/simple;
	bh=hqXupY2ADGb8Cnb+Kj4tt/WRXJGRf0F1nR1WKfBvTWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hV3HueFMYHLIX869zCD976vn73HYVW9hlEWNvgE0gRuJnt4TD0XfscgrP8HGnFeJXW2Xh+glDJVD6mzyNXxD1IGZmPOwrr3C2tu5sBP3B0L31ki+dn2Pyec1rJO3KX1fBegIv6Ee3OOGWDA6NjMTgYC89cOvfUN+8x0ESo6cTrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HxwK9aFW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43158625112so15007125e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 19:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729220100; x=1729824900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsLzVHKzeV33ogJAzMy8zA1MEbSeiTdl6VMX9FoSLcE=;
        b=HxwK9aFWA94Bllt1RONM1mjdDQp591JwN4XSvZnF1scXl3QTsyhRWaVc5L7tp2MUpz
         jP+zHDqPv77vHrevSNjBAXfKe3754lX/yjUQ1QVA22nXhLEt71WQHJCyrogV7XOuBaCT
         y3B45RLFiE8R0IcAoPj9rmfcb5c2BRyphybK5frMGO0sR7vE8e++i3DBjc2QBPxSiJ5d
         JtEhXGJaoUpmBlwatkHmajNHiSQirz2iOvejOu+rDkF4NBbKWqfglpg3ebIlR5zRF+WY
         P5TM8E8kpg5x0SGHC4cqgnkCLQ+b61sW6q1sgS0f0AMFlirYIho8KpFnfCr66Q4p/PeG
         hkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729220100; x=1729824900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsLzVHKzeV33ogJAzMy8zA1MEbSeiTdl6VMX9FoSLcE=;
        b=fNnAbMiYKZZ2TzOztXvKV0MxvJm9kJVjx8GEV52M65CcZ2e6z6VkHIsxwJ2+QJfPqq
         NTeJaIA4K7kh3nuD9PZuwpEqHt7Lpitva+I3reytADzAFNPLYGYrEkR3r4lsgdEjTdjv
         kzly/QmTZ1oIDJ7nduSX55WAhIXWxbK56voodt/6ndJkl9LSQPsEwhj5Vf5jSRTGh3op
         ImVKC6LMyrpoxj0G7k/BahKfFkt/aVzdwLXzpP7oDDEZQx9Iqk3ih7An/tzxEFIZZ/g1
         SLWTORT61X/hLIg68szX7wTwVeF06WXsVDeu7ZijPrFOzgRz9FFjltWIyJKAiPbqO7dL
         iIQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRLtTKWs3GOt9DJoHXDgDozb/vNGv1OSbo7YaM6Oocmlvlc+JGb4zKoGwqcXWer1S0HjQ9EwaCsjz2UbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk2dwaQNbEto2PG5gkjE12Ht1jqcRSZ2nhPcbDMLm5Gv+UURzD
	2MM9MZ5SdjLNpzP5V6rjbWU0hFcfsRw8zo/i6X661UkxSedw6uSUhaMkaw8ukOc=
X-Google-Smtp-Source: AGHT+IEsD5yXDxfUzoFybsXIoglRfcxdQJaSnddDjdvvdYbQFhGwxOX6rfJqovbrZKbUlTb+tgHFTg==
X-Received: by 2002:a05:600c:1547:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-4316163c947mr3908555e9.8.1729220100333;
        Thu, 17 Oct 2024 19:55:00 -0700 (PDT)
Received: from localhost.localdomain ([2.125.184.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf0ed599sm596135f8f.69.2024.10.17.19.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 19:54:59 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: linux-sound@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	broonie@kernel.org
Cc: lgirdwood@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski@linaro.org,
	caleb.connolly@linaro.org,
	linux-kernel@vger.kernel.org,
	a39.skl@gmail.com
Subject: [PATCH v3 3/5] arm64: dts: qcom: sm6115: add LPASS LPI pin controller
Date: Fri, 18 Oct 2024 03:54:49 +0100
Message-ID: <20241018025452.1362293-4-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018025452.1362293-1-alexey.klimov@linaro.org>
References: <20241018025452.1362293-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Low Power Audio SubSystem Low Power Island (LPASS LPI) pin
controller device node required for audio subsystem on Qualcomm
QRB4210 RB2.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index b211a49982d6..4fc6978d105b 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -16,6 +16,7 @@
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
+#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -810,6 +811,20 @@ data-pins {
 			};
 		};
 
+		lpass_tlmm: pinctrl@a7c0000 {
+			compatible = "qcom,sm6115-lpass-lpi-pinctrl";
+			reg = <0x0 0x0a7c0000 0x0 0x20000>,
+			      <0x0 0x0a950000 0x0 0x10000>;
+
+			clocks = <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "audio";
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&lpass_tlmm 0 0 19>;
+
+		};
+
 		gcc: clock-controller@1400000 {
 			compatible = "qcom,gcc-sm6115";
 			reg = <0x0 0x01400000 0x0 0x1f0000>;
-- 
2.45.2



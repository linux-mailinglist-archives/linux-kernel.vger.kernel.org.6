Return-Path: <linux-kernel+bounces-442433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2447A9EDCB6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC5E283642
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8CE1BF37;
	Thu, 12 Dec 2024 00:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P8X5pHkK"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F7126C17
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733964463; cv=none; b=KolyvEBTy6wNvFFX3KgiMDJPbqZCp1NDXLFpsVmodh8ZhWaORp9iipJag+ppgAE50+R7FbPZOKx//ffvjx+n8/I6z+qLx4m8G/qyjZWlIlINOlozZo44Z0rJNFuDWSPzxZ0DXxVGiK1ZL3BPX+pAjcdS3CEQ7RPknRWsvYZTL+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733964463; c=relaxed/simple;
	bh=KYn3uuYZj7NpZtiTkHvPGGaN8yS+R6O8JQi1SN8+UfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pR9gOD7/60jVbDcP0xoo8wEF6T+HqneewBpdnjrGMzZ+if+OGlVCcaXE4LAwBNeZ6WkxCbynuNstAsLZO2/SuUW/LKudrzeao/S8YpeaHGUPPinM+GxcPMumatjPU8A9W8x2gIde/Ppem5T1s4i+tUZI1Hb5U7nDSODwiy9kEIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P8X5pHkK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43622267b2eso513005e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733964460; x=1734569260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrR6DiKypyiSRNkIPUHsCZVzuVT+9VDdCizIFEiX0fc=;
        b=P8X5pHkKaapQm5/0VngGGSBDrJtx8b89/suvo5A7H4wZ4/6g9xQ0Yf1EZeXJGgRJDH
         NcjPo3nZ6Wd60bMuWsfXHVrNslfDAE7SWxL0uQoVuNnhAaDMKo3XgT/y4XtTbYiAaQTY
         V+xb8fi8+0Qr0cb9ICn+/Nb2kzbtJ7Wkgi4WMyHQtFpCOOf4H3kRvVJqVdVtCe+Kl9dT
         whLjValdX3GpbxOGEd5aZB3h/L56H9mImFcjzrOsaP85moHCKtk0tPQxaPem/kzEjqsz
         j5xDRokQY4e1PFq5QsbvSEQaqydMXkK6pjplrL+EK27ZKGh04I2pbZYbTFcuAX1W4F4f
         IK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733964460; x=1734569260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrR6DiKypyiSRNkIPUHsCZVzuVT+9VDdCizIFEiX0fc=;
        b=EICzvRzfz33rpnj1rv/GFyY2YXqM/atoX/Qva2PW+LovmWTyaZ+iXJua3d1T5HQLJm
         7XwmTTkCSdWVe4GJf9MJA0MTzFAkFr/BaDN01A69UJ136aYTVrxs1Opa0vGSGSeVGSYx
         5LheG0kcOFln2ueC/eIlxMrVLtZNCsqAvz8d/25uLwv8w/FVkEW3tWa1QVvseMZZYrQL
         u1fB/yQgB2vx0Cb5qWifVu5Aeqbty6/jMxwgwJaC0dM4bcLSr8bQpzE/Ot7cXtKHWUOM
         IujJr56S4n7prUA2zVnqpQku2G4JoFlQz7UjNOZcfPGEtUCjF053VWkqMPT8OBkg5B8n
         Iwag==
X-Forwarded-Encrypted: i=1; AJvYcCXHBNpb5QZxwi9nYwLox7HP/CZnrxXgkC8yiWil9JLOR3C1bfU46N6gXMm3UGJLkUZkknoA6ZLNjYCaK0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwHNq3hMKBcV4GEuQeuds132MMW7mPCGdNZGN4awHBqfco2Cz3
	zWCZNcGMQr5wH2mkza8Trv0IU/J8DMBIluYy0SjLoY7t2O1ZoigcjBFQFB0rlCg=
X-Gm-Gg: ASbGncsXVFueeRdQYwUhby0PUbiQfJB1hVR82R7O0KEew2IMdo2gohOlKkSZe02/uZ9
	aSQ3+rlp5uSYQhjKZVvL74ogrfjuBlzeid4aH0QfJcVl+X9DcwJl/LIlJ7F4BMCDJlJpt/9VGRU
	ykipaAarsAz8bb7eaMAaTmmfmoSA5SNzLlETcOJqMrdSCsDGCC5oxWvSc5QUJvyLiO1BoXruPzL
	DyoX27zWCi4nfqWQwKLLAN2wIrwaj9KeHSJOR3SBXlWmBi7xFJsVJ7RIh2Gte7HL8jk6Oj8
X-Google-Smtp-Source: AGHT+IGkBmZlNH90HFm8x5XhlTxKfUTueo4mDUUf5V2mYTwxmdvnSzy08A+89Jn4AKPGnkZs6ppvcA==
X-Received: by 2002:a05:600c:4446:b0:434:fa73:a907 with SMTP id 5b1f17b1804b1-4361c3723acmr38051395e9.13.1733964460449;
        Wed, 11 Dec 2024 16:47:40 -0800 (PST)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4ef4sm2459660f8f.39.2024.12.11.16.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 16:47:39 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: broonie@kernel.org,
	konradybcio@kernel.org,
	konrad.dybcio@oss.qualcomm.com,
	andersson@kernel.org,
	srinivas.kandagatla@linaro.org
Cc: tiwai@suse.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.baryshkov@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/14] arm64: dts: qcom: sm4250: add description of soundwire and dmic pins
Date: Thu, 12 Dec 2024 00:47:18 +0000
Message-ID: <20241212004727.2903846-6-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212004727.2903846-1-alexey.klimov@linaro.org>
References: <20241212004727.2903846-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds data and clock pins description (their active state) of
soundwire masters and onboard DMIC.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm4250.dtsi | 62 ++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm4250.dtsi b/arch/arm64/boot/dts/qcom/sm4250.dtsi
index cd8c8e59976e..723391ba9aa2 100644
--- a/arch/arm64/boot/dts/qcom/sm4250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm4250.dtsi
@@ -37,10 +37,36 @@ &cpu7 {
 	compatible = "qcom,kryo240";
 };
 
+&swr0 {
+	pinctrl-0 = <&lpass_tx_swr_active>;
+	pinctrl-names = "default";
+};
+
+&swr1 {
+	pinctrl-0 = <&lpass_rx_swr_active>;
+	pinctrl-names = "default";
+};
+
 &lpass_tlmm {
 	compatible = "qcom,sm4250-lpass-lpi-pinctrl";
 	gpio-ranges = <&lpass_tlmm 0 0 27>;
 
+	lpass_dmic01_active: lpass-dmic01-active-state {
+		clk-pins {
+			pins = "gpio6";
+			function = "dmic01_clk";
+			drive-strength = <8>;
+			output-high;
+		};
+
+		data-pins {
+			pins = "gpio7";
+			function = "dmic01_data";
+			drive-strength = <8>;
+			input-enable;
+		};
+	};
+
 	lpi_i2s2_active: lpi-i2s2-active-state {
 		sck-pins {
 			pins = "gpio10";
@@ -74,4 +100,40 @@ ext-mclk1-pins {
 			output-high;
 		};
 	};
+
+	lpass_tx_swr_active: lpass-tx-swr-active-state {
+		clk-pins {
+			pins = "gpio0";
+			function = "swr_tx_clk";
+			drive-strength = <10>;
+			slew-rate = <3>;
+			bias-disable;
+		};
+
+		data-pins {
+			pins = "gpio1", "gpio2";
+			function = "swr_tx_data";
+			drive-strength = <10>;
+			slew-rate = <3>;
+			bias-bus-hold;
+		};
+	};
+
+	lpass_rx_swr_active: lpass-rx-swr-active-state {
+		clk-pins {
+			pins = "gpio3";
+			function = "swr_rx_clk";
+			drive-strength = <10>;
+			slew-rate = <3>;
+			bias-disable;
+		};
+
+		data-pins {
+			pins = "gpio4", "gpio5";
+			function = "swr_rx_data";
+			drive-strength = <10>;
+			slew-rate = <3>;
+			bias-bus-hold;
+		};
+	};
 };
-- 
2.45.2



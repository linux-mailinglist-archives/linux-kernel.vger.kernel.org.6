Return-Path: <linux-kernel+bounces-331597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1186C97AEB4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C8C7B21B05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF43D165EE4;
	Tue, 17 Sep 2024 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHB/VKoC"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3B15D5A6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568843; cv=none; b=WyL2LLjVsjc9od95hki0EJVIOdU+0xphs6zofU3VXzDPZh2I6eTlcwwXeaCiWWzkWmN+1MEQSs5PaOktHvv52ORSNTvZvHzIfBEzQXID6f5foDRfwla1sreFzngEel4yjNIYVNz3at/jEhfAqGo7ekHPT/Q1yynDR0A2xGwwdzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568843; c=relaxed/simple;
	bh=RQUyVCVGKvk955KD/oOhxw77fHG83o7vjf2LfrYMi3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tgf5qezdI2a1IPSlUcvIECejhONrwwFAEdtV73lUUpUMiKqg68p9965U28/fozmKsenFzjFa0oZtOKrbfXSSsYI+422jWv/Dcv4vinG2AvNLTAC7ZH6jkBL65EjwuprSsGapRdafWAfaq4eupninPqR87jZnszW9kgCHCstGsNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hHB/VKoC; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374b9761eecso4378736f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726568838; x=1727173638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O3BbujuHzO/RAMZvTpQiB1Pqjgm8cgnsqTGoSPy3nXg=;
        b=hHB/VKoCSJEgXT5RtxJduNcATFbNzOUn5Gx7nJJ3Wfs0w2Dr/Zhpz9ZxvaYAiSyNZY
         puYz1QrxSvUAp0bq3RkVKB3iSPbEsIL2/O5+6RgAG3o98rcpxNK0UqDY5T5JaKN3AGhu
         AvlmNrKadHbHN60gkAHi6xI0ttXW3o2zBIU97UlpQ3/EivqbRIVSf1RxI5HoVuFnNGVn
         kK4e+14nhbxZPL2d8xiMtF5fCGnLhEYtH/9nIiXCu9iz2GamSpdDQgQ9I9PLseywswO6
         FTdJUhXLJeifNqoXs3QcX8FyKP09OtmKktz1XK6cLNKEwWpNuEkLNGhfRmTAowfC0qR+
         /MJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726568838; x=1727173638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3BbujuHzO/RAMZvTpQiB1Pqjgm8cgnsqTGoSPy3nXg=;
        b=c110CTZ+y0IrtUWYlNOImiYYa3c1W7d1urxQyqlD6MNgB+isWZnCYS2JGb6s5Bzlo0
         ILwxMR2Nqq2cf+fdpBOrDL5X/dxNeljYWO06gQjjEohIgnhv6tFRosFy9VFty/RaSfqE
         +9pthugW8M333d1hSxlGXKDNg364mUk0KlR3kWTbOLYgKq9YiBMEloYaDo4EStW3AHyA
         7ySIJgGLcu0Osxgs5obn/Ao+Ky3bZHYDVykdMBValP58y8+MdlZoTABqicYG6j4mr3GX
         VcyATYaZG5s2JPxsb7dgBxgAGoyXIA1wDhcYpq7bzLx8MJfvGH0hmDZ7gbJSMX+Y3Mqd
         okMA==
X-Forwarded-Encrypted: i=1; AJvYcCXaVxD7MnFa9VUR4+UbqofL8Hovhx2GeQJdpLHBCztL80GfCPxWbxd4dtuCMzw6/KH46gh6CTXZahqx38Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJJBQdGcCG6p1nYb4cP05jO/zg1yU2CZ0XyD2Bre0vS58C0aGt
	fwSYPgX8g6HRc8/MKDqWDmP8UfVhEn5kpmIZM+eck8zKEp0rsE71Xh6wlWMEI0c=
X-Google-Smtp-Source: AGHT+IHV5sT6le5zmGHifYAmMMnHu84747/30MSIE35w1b7lr7DQVM5IDV37QwsVD4o4IxyZXamNlA==
X-Received: by 2002:a5d:61c2:0:b0:371:a60e:a821 with SMTP id ffacd0b85a97d-378c2d4c9c6mr11217648f8f.38.1726568838503;
        Tue, 17 Sep 2024 03:27:18 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780031esm9151096f8f.84.2024.09.17.03.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 03:27:18 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: andersson@kernel.org
Cc: konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] arm64: dts: qcom: x1e80100-t14s: add another trackpad support
Date: Tue, 17 Sep 2024 06:27:15 -0400
Message-Id: <20240917102715.4096-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Trackpad HID device on some of the T14s Product Models 21N2ZC5PUS is
at I2C address 0x2c add this to be able to get it working on these laptops.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts     | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
index 941dfddd6713..8468f99d9bed 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
@@ -467,7 +467,19 @@ touchpad@15 {
 		wakeup-source;
 	};
 
-	/* TODO: second-sourced SYNA8022 or SYNA8024 touchpad @ 0x2c */
+	/* SYNA8022 or SYNA8024 touchpad @ 0x2c */
+	touchpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x2c>;
+
+		hid-descr-addr = <0x20>;
+		interrupts-extended = <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&tpad_default>;
+		pinctrl-names = "default";
+
+		wakeup-source;
+	};
 
 	/* ELAN06F1 or SYNA06F2 */
 	keyboard@3a {
-- 
2.39.2



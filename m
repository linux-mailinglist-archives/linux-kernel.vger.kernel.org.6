Return-Path: <linux-kernel+bounces-391512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFA39B8812
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A3AB2234B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101973A1BA;
	Fri,  1 Nov 2024 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEff+MXH"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1F9381B9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422781; cv=none; b=FeeVO3ZZAgCT0Oq3mjDUJ7n2TxawxYw+/4MMc4Ev9/hG8ERc2umCW8m4GJuHLOkE9DODxZKYwRJUdZCmGt7yOCFBnDPgSTPIxjTy4ErYCFym20+MD5CXkfX0GQdVofEhGXzPXMQT0aB54KD9gZYAn6FdsVcTOz3RowoTk0tvwlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422781; c=relaxed/simple;
	bh=8jzi7goouC0F0vMAMEG36fTCcOdTha50V0ZwGgyacJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFMTJ4wOpxa7TIwMcM4vawyDHJm3zQWV8TV0DMezLBEX7QaIJEfbMVRZo2iLGGA/E1AbrYQ19I9tb3OsxtPqPJD6iL5BbxN+Xy2sTxd0S05fHxHVnUcwOQYk7hB80Xs7P6tL6VDv4h7znqD63fJxooQ6trLxd/fFfSfUAUvldeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MEff+MXH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43163667f0eso12650425e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730422770; x=1731027570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8czlapoIlZ5pdYEMSWJZvbQIt9HlIJv6TxurfVEny9k=;
        b=MEff+MXHez4WvfbrRzIiwBFAiw4gQTwflNxPJUKhASZTwNDKsXZ0SNl9SFV30Ld1vi
         Ntdt6rcsZQQcKwoDjZowz8jaednZnTc3DzucIiKes9DIR7UitLGHVk3FESGvlE3xEuPq
         mt1QhVO2icz17NNysHBaF+6ulwUAUiKW7++B6Xc1RU+L5GdTK3Dp9SJ2m41fYqUSypdB
         inYKrjqJATE/F3JHPgLd1dibAii0at84qP5uQnbsOx55YzygzTQbhA9nwid9DG2Gu6oz
         oex0jr3TDy9jxQRdJLXjKb7OTppRVMzKKM9btE8tZnhaDNcCjD18Ekmdoj/LOVuJhCMF
         dtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422770; x=1731027570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8czlapoIlZ5pdYEMSWJZvbQIt9HlIJv6TxurfVEny9k=;
        b=w4n29IoWsSL6ETR4ntbTpTtGjwTB3K9oRyeb8vm3pmbsGBfMzYRA65QffBFf7oOfxu
         esHtZMYyW7/DowJwfX1w653QHkY1Zx+Ifcf1iZzbGYKYeCPnKJ1YxweAIJqKevaOzQZh
         zqu54hB6njPioWmE3UL4G7kBPc7Grt+wRfFz5iJf1BA43zmAk2V7v3aCjN1DMxTDVRO5
         8uSIJ0+3NMd3OrVimmn5QjH+d+DXkLpJPcLktOBbLaaiCrW2YFxuTZpDcy5cTgqJodgf
         bjM66d246Fx8haOElYeyqSHsjrOCb8/5p925Wmx9T44Vc/342qZvUBFoGFQc7JDYr1kp
         06Xg==
X-Forwarded-Encrypted: i=1; AJvYcCU7TbsGF2xNv6wD1RPs19gYFEh0xNEYdOW5kOyILL1aCeu59TTt1bgraCNNph96S7QHdSi+lqAU5OFHTxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdFdq0V7hKbhqrLUsQM4jNvSyFxz/pLW8OxCQRXMZNdOE4oVJ/
	uwoOFq4e3fQRh1TsPgbChI8qxzOd5rDjRf5VVLIoGk8CuwmRHmJBexEGIvqjEJQ=
X-Google-Smtp-Source: AGHT+IHNmbGczY/yMUPeVNxztuRCdAbNfOSvimTFvs+b/4euVT3yqHIhW9/gkTLGqGhtJcb5Kw6Qkg==
X-Received: by 2002:a05:600c:1987:b0:431:6083:cd2a with SMTP id 5b1f17b1804b1-4328324d6bfmr13211975e9.15.1730422770399;
        Thu, 31 Oct 2024 17:59:30 -0700 (PDT)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947a9fsm74208035e9.22.2024.10.31.17.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:59:30 -0700 (PDT)
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
Subject: [PATCH v4 3/5] arm64: dts: qcom: sm6115: add LPASS LPI pin controller
Date: Fri,  1 Nov 2024 00:59:23 +0000
Message-ID: <20241101005925.186696-4-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101005925.186696-1-alexey.klimov@linaro.org>
References: <20241101005925.186696-1-alexey.klimov@linaro.org>
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
index 816b8331933d..df2241237b26 100644
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



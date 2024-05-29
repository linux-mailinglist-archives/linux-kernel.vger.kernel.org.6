Return-Path: <linux-kernel+bounces-194311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3B08D39E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9721F251CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06379190696;
	Wed, 29 May 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9HQNy8v"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A8618410F
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994038; cv=none; b=SluYUczZMdw12enYKn/PfBaHeUmKi0mPH0rmMQ1SX3Z3/dsgCMGMArN9yaSC9LU1683LV2iTldHawjAeOUTexPiwCh/5hSOOQeREKSI4N+vMDYwtT283XKCsh3AtgQzgFhNjUfKUwrePCDSk6LBgslsGYs+HJXdwqCZQt4/Jri0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994038; c=relaxed/simple;
	bh=rRrgn9wRVOiElWPDaUjrdPE8GcJ80QnHEQvUPT4yYv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8LQ1thT0SpjaoHRCa219HOPwbD6GtG/Dz7A27RvMtxffssPE/RTm5N5TURmljDayJmy4dIex4X7XnRY5zgbWLHinXSOTuigIZ34a5YFuS/G1GO4UJruPgovZ9PciwzTf81qQeLugbVsga6ADCVXUOXldJ2IgiGnP4lIsL7BzKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y9HQNy8v; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e95a60454fso23919191fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716994034; x=1717598834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X52tPGcJvxkBvOLIf8hl45B+JUSUGh3EW6f1yVnQtag=;
        b=y9HQNy8vjmms9ec4u2tU3csXNSqHfnduv4gmIAkU136XgKGvxW5s00YuERwfKznhyK
         La/FSXQ5SlPoD+3ROhWzDwe4Cuyq+3LGsHbexkdMYaRkPIK2MexIQqT5WLeVZTGcEP7J
         kTQhFdgOVBLrBo30sfxxbFitqyypH8h6Oqr8/KpEkdfA0hbrt+v/X2rwxkld7UbqtHjz
         02JuJ5+3H0nfWi88Q8qeqVFnoser5JGZjBY+LBAYr6DgssTvBvJlQ2fmapn3wTKafvbv
         XrZiHbr8FfDEsvdgUBIlty35Q71tHkaxM3X0DY2HwXwZStZFLU/LdkLGghNHoOI/tULy
         BkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716994034; x=1717598834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X52tPGcJvxkBvOLIf8hl45B+JUSUGh3EW6f1yVnQtag=;
        b=l8SeSZsUnwsVq1ZpakH60hmT3EHXVoMZ/InToYzBuZBXod6U45xivoD+ouaIpFjnmO
         UPEDKAFW7tTvumBGjkCB1uCL1sJltqxHq8akvidvHtthrQHmYtSZW/IEZqdjrZ0WNKdE
         RfYTHffY8+TsMkea6W1JjsqcfMnM08N2wv+AbVxRd83eB4ydC/6DzT3XXjUtc93ASU5L
         iW4GCe+h4Mhvt4yaaFGkR3AN0h4lQfQUPIl9afuEnR9kXp+33DqIn1KgAynmsbl8ao2j
         ZQY9t4SZfAHo/Al/CHiy52knBYUDm86jcCC83nySSNCMA9TDbxBhA+qFYgCvBVb6wlHe
         zZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCUytJXuqqpo7lafXtNzAvOsdQiQrUxCZkYOFD70Ens/TgDVSgnBC6/OP7WSfJuyPr18z224r5gFVUez1ZTFuG/pArOzHlcrbH+VrJ1d
X-Gm-Message-State: AOJu0Yyf2kHoTyfUwnlUBV3OOsaIOKDADJk/7LiZn/pGBNX4PpDmSLXc
	gaV1SKjXfloALjgdIQWO0QD0IKVuslQHcvc1vGp0zbIBLPg3piXP0K4LCB523nw=
X-Google-Smtp-Source: AGHT+IGYEB+r/Y5PhcdO7PfWCYTe1vY0pU3giP2wNNgI2jwTx59a4are9xsNbtaMPNNW2G6p4t0D0w==
X-Received: by 2002:a2e:3013:0:b0:2e9:84fc:32eb with SMTP id 38308e7fff4ca-2e984fc38afmr36284301fa.47.1716994034269;
        Wed, 29 May 2024 07:47:14 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e98c45df0csm3791951fa.68.2024.05.29.07.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:47:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 29 May 2024 17:47:12 +0300
Subject: [PATCH v2 14/14] arm64: dts: qcom: ipq8074: fix GCC node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-qcom-gdscs-v2-14-69c63d0ae1e7@linaro.org>
References: <20240529-qcom-gdscs-v2-0-69c63d0ae1e7@linaro.org>
In-Reply-To: <20240529-qcom-gdscs-v2-0-69c63d0ae1e7@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=737;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=rRrgn9wRVOiElWPDaUjrdPE8GcJ80QnHEQvUPT4yYv8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVz/mI0ik9cKZl/9SuqJ+p8yQWhrIMDSNMV0OP
 fuaSU3f/BeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlc/5gAKCRCLPIo+Aiko
 1WD+B/9euLN7JRxLEjwdqITHOmrE/YulvXTtO2q7Q/Jd+9OO3nBBX7EKmNtb1HVb5xaLjsm1sZm
 1hJOcvuuyT+AcMaLiZ6SRKN8Yg1P6WBR1K0BCBc0P+mdoDJ1tM6n7QgatxD4TwlPm77HASxJ5LP
 WK93PR127/AEP0iq0og8tXg0Pc6oOLQ/+KwlxLHcDnngFWVVXZteTl/l39R5J7iJ9eY8SCoPCBD
 5Eq7G/JvZkzHLPL5oJC7ur+F4ho/JcPKMFGafh1rKZnoQcxYjhSdVwp/fIpa7ePGpl+pUz6WsGp
 dUA6ex8ME/3qOH9U4UN4+6Qu8xl5Nr0TsUUtNgybI2TtRock
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Device nodes should have generic names. Use 'clock-controller@' as a GCC
node name instead of a non-generic 'gcc@'.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 5d42de829e75..27cf8d50f254 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -363,7 +363,7 @@ qpic_pins: qpic-state {
 			};
 		};
 
-		gcc: gcc@1800000 {
+		gcc: clock-controller@1800000 {
 			compatible = "qcom,gcc-ipq8074";
 			reg = <0x01800000 0x80000>;
 			clocks = <&xo>,

-- 
2.39.2



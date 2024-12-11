Return-Path: <linux-kernel+bounces-440916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A8D9EC668
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A141886A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD2B1D5CFB;
	Wed, 11 Dec 2024 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXiSvNgg"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDE51C9DD7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904203; cv=none; b=bT4mHnAzGhI7PyIlX46tJF/H0SkyoeR4P+lBB5QHGP67c3NQPAFLa/zUX6PVyZ6h/8Qo7Bis917u6cVOHrJvVy5t3AQXsASMQgPBBt/uYr2Q9DyjQemgrmEfLvhaa6j+y18HWvCb1TGkJ0pRhDL2ze4SeNBshSMrczWaQ6J172k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904203; c=relaxed/simple;
	bh=jGLTAugEoSXwKu8aklCQX92hP9mnmqNNM/X8hnjjVXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R1hSMU827cptCrtkc6MJweSRsMZi99rzxT4gwxSHcb5KWc7mbfYOUCUehFVlDDHW05MtGrdblTQyyVAoYuF2EKJm/A6iI9cIUQEdQ6PnbTzbrdM91yhXAQ0iAArlb4DshicrXOu7zy2rnDsPziB8D0/M6l4mhG2Jl6FPfeV7Q6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BXiSvNgg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43618283dedso11963695e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733904200; x=1734509000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ka9OJ0lCnfA6ALixeFrsKSZhUTbEuLvcviSCATqki7U=;
        b=BXiSvNgg5t2CFNMgSUyuSmgNIoIp8Wp15UrWu94I3fbZiN6/HHjOkrF5cyWVn2zjR+
         XSCsgW1RIQAqJKSvrH/mtLGqAQ4CjczpQ4hPVhPsG3NiSKlQP9bw6AlyLt09HKT1rjAc
         RsQLT3Oa18nnEmUeI+1qGUr60fo6a0ET00xQOZD1laU7WPlUYBKsLNYBeivH8DjLxmKO
         eiqJ/sjZ3+LqIBdeyAceP7AFTVRaen7u3ZsmeYqMRsiZnfYa49/H7eEDR8r8+jlPenSJ
         aCJd1CcPiJbV3VLxOjBnSrC8/QUdW5d1NipOv0UWcXa1cGK/NR2xzxK/Lzs7FTVeu4uT
         7FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904200; x=1734509000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ka9OJ0lCnfA6ALixeFrsKSZhUTbEuLvcviSCATqki7U=;
        b=VQwuAEKKd6b+4+WZHx3vfRsEDEQoHIDTYdRMomHBH7d+qdO6z7dSXn04ahYdk3/7Tq
         qDHabfDD6HtN2Z+lK0uXNO/S2WaZ4diMkfznNk1HiDRpy2XJw76dwd/geeoX2J3ARWPp
         8DkvIwpsoYTQp54ZnkyoLFzXD5MtmkVRhlg86BRcE6P3cR2ot0948PjSkQirVhD4+7BC
         IjeTaDiFyRq1xCbUDi2nT93eeEJC35Uc136OrioPZJAR8BG07BvXqW1iqZY1p1DDXYc9
         +7iuw8TuoKo7t5HTXsUANHhR9T4s4RNPvBsGqlG3KL811tbuibHjJ/NQ5x6rrFBBSLFx
         M9rg==
X-Forwarded-Encrypted: i=1; AJvYcCX91vo/zyj1yGYDXSG6/AKtuw2gCLI0F5Fz8S/ZRBapiVc3FPI39tRYh1jZM34yn+n3ycizyf9LEuESNhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUZUEcPlaA2A19xbqOkxLO2Ezi7+uRtk/znJFhDnn0zJGunaj2
	V3+qX8NolC8r+8PGA8a1Yxxk5I77l2pwbJ/1DKadvbiBw+VC05L9CypfpcZ1p8A=
X-Gm-Gg: ASbGncv/ulRMuK8VIb1ZIzCVjqq+UWT9naAY/TJt9/U9twPEvH8hSkcM9WV5f9yrVAZ
	Uli+tD7rtoYIksuUe2y6yCjOwVRMAOlegToXvCJJPJ7+tc1ch8aeingmf5fiPzKrllUzgdp9Tuy
	pDPSN1p+/wOuv81hyWv26SC8AyAS83JAQhr4xwrJ2nasvedfK8NywDq4XcdwF/S3L2fsiRNeBBN
	czDKw9K/oMthsbeMVs5MSJkXKvQyKlYmzGnj+Fh8+MGwEWvQgh3flxC2cDx7MAMvEM0ZiO/geQ=
X-Google-Smtp-Source: AGHT+IHWSpWWPAgWODOqNYAQeqXwV4M6/qa5IG0bcfsOVvPNnC7nYc9Q+AsrFujhHWryMnDX6OGU1g==
X-Received: by 2002:a05:600c:1c82:b0:434:f819:251a with SMTP id 5b1f17b1804b1-4361c396f09mr11655815e9.9.1733904200332;
        Wed, 11 Dec 2024 00:03:20 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361b09fec0sm24205795e9.4.2024.12.11.00.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:03:19 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Dec 2024 09:03:09 +0100
Subject: [PATCH v3 1/6] arm64: dts: qcom: qcm6490-shift-otter: remove
 invalid orientation-switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-topic-misc-dt-fixes-v3-1-010ac10529b1@linaro.org>
References: <20241211-topic-misc-dt-fixes-v3-0-010ac10529b1@linaro.org>
In-Reply-To: <20241211-topic-misc-dt-fixes-v3-0-010ac10529b1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Felipe Balbi <felipe.balbi@microsoft.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=988;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jGLTAugEoSXwKu8aklCQX92hP9mnmqNNM/X8hnjjVXU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnWUdBCUq+ziFgPhHwzu+bghr1Tb1Cfu/8HA9RMZFz
 egv2Za2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1lHQQAKCRB33NvayMhJ0QHbD/
 wN46TWo5MR3OuoAvw4EEBrinwNE3D7zZe5J/HBTMEWYtJujT+uBtpd20+TGQDpj1oz1lgkdlsTFwxV
 BMiX0qUf/8GoKYk3DRK0UHOByBOYTSUxPdh6ZEegSAkqixxPKRwrsh88wfN+mVt/20ETUMo9MrN/QS
 J+687o72/LeyNL10iZ9vi3moXo4qm+EXspgVp3bOZE5bkCnD8X2Dbj7GltItLR5G8p5G5NBcjcmSV4
 IuIvrkJ2CKFwzDl7SccjspPMhYpi0rUjufbkuUwk5nJKgh05XWb8mN+E4gDMI1amfpGEI2HXhbbMQC
 5XT2PSs1zsC7gH/EcfhK4MT16B17csoFGkse0810w/Cpvz/mUXsEm3m5gN66FA93FjK9GXyInuA1iI
 WVTN4aUDi2K36rJJHLzscTiWZ2aU5tHfNVjJakYUC/uIu19UBWenDs2plHMXJ3qp0JuSs+auL0APcd
 XSFafc415Q8Z/TW2gqh0l4VnlgCcJWxkq87JvSH8XFLwG5buisXwzxVpfx0ChzIzjTRVRle3G9Uqac
 +R4sVRRBYehjuRkLin+n1rpfpA79UBC2aK8ev01UiTEU/ULRq5DgkNHFmNVtV+Jyla4f/QwuwlWDZp
 Ihog/7hDstdGCpeoZzuCO9Kgdaa2r7UkRVJi3aUrV/XxYaR3PsRxWTTP4VTw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The orientation-switch property is not documented in the PHY bindings,
remove it.

This fixes:
qcm6490-shift-otter.dts: phy@88e3000: 'orientation-switch' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/phy/qcom,usb-snps-femto-v2.yaml#

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index 4667e47a74bc5b0f01a53beb49993d238b13c4ea..75930f95769663f6ac3e2dd0c5f7d224085dda40 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -942,8 +942,6 @@ &usb_1_hsphy {
 
 	qcom,squelch-detector-bp = <(-2090)>;
 
-	orientation-switch;
-
 	status = "okay";
 };
 

-- 
2.34.1



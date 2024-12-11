Return-Path: <linux-kernel+bounces-440919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F099EC675
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A970A1888DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9A31DE2B6;
	Wed, 11 Dec 2024 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sNmY+z6H"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F113C1D7998
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904207; cv=none; b=BP4XDXlqHNx/CQSwMEm1qn0OiXiSwghlyGTXXXZCa3LBqV9chaQkzOM8HjR6y4srrJFGA6tzgwiKawrgQmpc3DEQxX422hTIg/dgU097ZYv7g9nsP8qOfswp/TfuSDaleL2jdsf6kdELZZn1v/JDLZ+5AtuJEBVd1maQQQluqts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904207; c=relaxed/simple;
	bh=MjE+gCPtd3g9S1tORrv2JHiLOE0a8BYC25RRtAjy814=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O4xyR/BfChfh9CGfNRSC2Kj53IWNjzxYIC7WgCAvKrU3gyCURc8Uco5M6WZBaSSXETJTjoBOUIhSUsSfMhgqUotN/3wA+1FsUdiHYaLte1aoTgZKgt1M0yXG2eYEL9X1kFAVbjrXyJY01xd5jhyHseEbyZwuKTUNs6hPrzog5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sNmY+z6H; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361815b96cso8388815e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733904203; x=1734509003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDLpHZqYoth1wOxgJJwZS3j1+oo/RlvEJVFdtpMBXi4=;
        b=sNmY+z6HeT4QesELUN2UvMaXAQ4crCNh2CXJqMTtvpQrDqSMz7YnDv0aDS0Rsx+LkM
         I3qTjPBfIDRFvtJG/Ikl7KcBLJuKY/V8ig6hyEYLv5+abPiXDaTxWCXvjJvjP0I2dmsL
         ebkARQZU7v2ymgZrniajsU2bDIQ/THeJp2kXwsqT8F1Ru9D1MQ6MLr5HLbJrPnCYR0qf
         g0tCaM/Fin/99G9NAkikY2vtvmxxIdRPpycRfQ0aqsW9iiFTONUg0KpO7gMkbwqC2/EB
         IEDTxuXzbZ8LYTXxBzhUMBxPu1AFyuVd2SVMJC+5iaicKeP6V1gK88A/H0iQ7hW5rV5C
         ymNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904203; x=1734509003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDLpHZqYoth1wOxgJJwZS3j1+oo/RlvEJVFdtpMBXi4=;
        b=cRCzA+yKJ1j9styz5umZi6ewlhqeQ6A9mzyHNoMrjqOI3nWpbwiK65V6vsU4KtMr3X
         nwZp7xf6bHifFCkFF2Egx+hrdOQo3+qvqDTCAFM4EvPJ1/Q59daNvcKIAPbwSvMxbgbU
         h1MNRsEBneM9aBcOHPZADqFwPiRlfEWv9PIOGXVOA4S7G8YGfN9NExKs1go9ACmx4jOH
         mHM3AAA+gzYBLqJ7O5E8SXsjbDYbBZVBhmjoFqz7iZIbrU0KDV0zgliZuJ9ZcW8b/XwR
         oqdKB26hqVfy1OSDGFT6Im/neJxUynM3Gmmio7n8PH5xnw7q/7Hz4UkYUKEEzBZOe+qy
         uH/w==
X-Forwarded-Encrypted: i=1; AJvYcCXjdE34GTHqx6jfbYP/Aj1Evz/h0WWbq045bcA7Gf3p0i7ym8ZCvVbNiM0Bay2zfFIhGyJmiEUrJCgV8ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRZILOiB4sfaAncwxaXxVAZ03Yuzr+27tD/hGAAsz4ZHzzP847
	a4s/4jOWOSbwr+NVrvr8Oe2FnxOeVPyKYMdBbhgKgzVjJLZxj0ePr5OolGWmfsQ=
X-Gm-Gg: ASbGnct6vqZTurVEqQ9naZ+rIepPYFxU/nQMT7T+buQYoYg01kX3qGVcj1kOD5/C5ZH
	lBDmdizVQWAHalAVWobVB5UEkdUGHiPQmjzk5HPyFsCb3HV3T+PoApEf8iGYICXIkYRc93HTkKo
	rZy+XcRQ+cH+B3BPsFRPfc1b8BFNLPWTeo7v/k9kcJdQDOXubTPenCYyTXm/S0b7GGj7v2x+pJj
	fVj02aD1Q40a4eT3zAYT7DL2egDbnEmIPZIfdYbQGhoVy0j9yrH0iIQGNdQnK/QdlURMjCiH74=
X-Google-Smtp-Source: AGHT+IHMX9b26V39pIn8+UNC9rmWDLmkYADSjVq/tbVMrYC09QU2FzrgKGswQwCW12k3jYanhUCrwg==
X-Received: by 2002:a05:600c:4450:b0:434:a7e7:a1ca with SMTP id 5b1f17b1804b1-4361c3e1cfcmr10245555e9.20.1733904203396;
        Wed, 11 Dec 2024 00:03:23 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361b09fec0sm24205795e9.4.2024.12.11.00.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:03:22 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Dec 2024 09:03:12 +0100
Subject: [PATCH v3 4/6] arm64: dts: qcom: sc7180-trogdor-pompom: rename
 5v-choke thermal zone
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-topic-misc-dt-fixes-v3-4-010ac10529b1@linaro.org>
References: <20241211-topic-misc-dt-fixes-v3-0-010ac10529b1@linaro.org>
In-Reply-To: <20241211-topic-misc-dt-fixes-v3-0-010ac10529b1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Felipe Balbi <felipe.balbi@microsoft.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1244;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=MjE+gCPtd3g9S1tORrv2JHiLOE0a8BYC25RRtAjy814=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnWUdD3UC9CZtgoGQTC2/tEks5rLX1+Dt0swd2ZyU0
 jFYiYQSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1lHQwAKCRB33NvayMhJ0VzMEA
 CprxmAVyahbKdnAtoKh2MzF1apys+BMFORDIn9lO58Y7qkNmj3ck/GZziIxCZTDtwx+r/BcKIUrgef
 c1G9q94neAbPy1C6tWh2E5y2PH+S1p3HUutabSvq9X4MnCK5SvjhIdhuZKsMjAYhs1VVil8qIi5nTj
 9B256KuKePMI/zzmcAOj+64tw+D5YhonqxGuXU3RS9yljZicXKMWay+DmPTDFOfJv2Q7nNClkUk6mE
 phggazlAzozuoYYzkcjjfT/QsJuQsraAiB98aMKle1whs1DcsYGztwey7wzOZEnF7KMATSeyeiophf
 QQKLyEaKKEy+LzTcUjie+oiJlVXF8tTjjyfQ0l5R4VomVVEVvHp66hwB4CbPvbdYjYuOiJ8sv2CbYF
 2rmg/EPtOwdJRbCpVl+l8piqHsug+fvJ9/r/HXU5fhpyOzcjeZ1S8tuC1B2b4V3t6sLXYRy/mVK/rY
 ngOeOvtzwPOo7q/cdQbstfUwRHzOeYoyj0uboC6pELVw0Q4Z7dQDamNimafQ/v9e4DSjR0j4tAnA/V
 GEenCEaFSB/YfVQ4xl1TM+kRlesCNSky3whKgtJjMrlxlniV1vWt48G/pJKNICVwIsYdozOrx7gCvz
 Vc5txMlSYUFogtmP6dJZBwm1un7cUedu0XxvbkvPHx6zlkiQwbb5ghcI0r/g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Rename the 5v-choke thermal zone to satisfy the bindings.

This fixes:
sc7180-trogdor-pompom-r2-lte.dts: thermal-zones: '5v-choke-thermal' does not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,10}-thermal$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index ac8d4589e3fb74b9d9105a8ca2b0cce72de22d86..f7300ffbb4519a7973c74198fc0f9ca2d770bc3e 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -12,11 +12,11 @@
 
 / {
 	thermal-zones {
-		5v-choke-thermal {
+		choke-5v-thermal {
 			thermal-sensors = <&pm6150_adc_tm 1>;
 
 			trips {
-				5v-choke-crit {
+				choke-5v-crit {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";

-- 
2.34.1



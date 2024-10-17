Return-Path: <linux-kernel+bounces-370257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0BE9A2A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8A6B3117E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44B41E1322;
	Thu, 17 Oct 2024 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I6sPWUwC"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BD31E0B99
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184231; cv=none; b=f46451jefrHKKl23aLcgZetz96oUUjaGBwkuTsGjjaRcyJAOW37Wzqx+Y/fxnYTZvScmwb4YyGTsY6Ium3O0XtEaDBq455y23zz830AXuc1xhoFWCUEsEHGGqZ/KKlFPVFDRwX/XbqJJWCJxVeKE3RBJ2vqBW2sExgi527Ci/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184231; c=relaxed/simple;
	bh=2RlnfXAvC+5RWHBwXyBuZ+I/mjr57HcoH5Usgs02gbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kO0yTAc0oOvdwKZWV/tyaxmClkIli9bHvt7bv7jaHUvCFXeFHH15EnGbweYwytiQw/+lPkAKtr6hghwqM+j+DdqqweJo8HjQviSwybon+uEFmWs8n/vwCQrvt5oVzej2//Gf4XeREcjXEdwhSl971ImGQZEtUs51IBRnxlYln4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I6sPWUwC; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f6e1f756so1561836e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729184225; x=1729789025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ow27IoNsvgkUupzx1K9O1/iQYpLFAAkG+OJE9/un3uQ=;
        b=I6sPWUwCwYRRoJyoDzg0CGuW/HXUToUPhsjogltVOm+9QcqTHEBu48l+qswUXx5nSt
         YmBTv27cDvyxYIyg0tSxMH+hRBLR8jjLwhjkr+qASvge300gOeJANL6On3zjanyuvkwW
         DlNk/dr53/18kH4iL1pgPuE88B9RzMydX5qnpJ2eR0ptjXB4+mZAXRYP0Zm1qTEsG7Yc
         SXHIkg2Wi3dkS5mVUMa4guG1CIpMkU3QArtbOXWscZWsb7MXM7iBAwYzPlbikSG11hFy
         8fU9A2VoryDgP8W91GMI/Hj884Dgci0FUFNv8xZx5CAc+wtK4yRtJvMglBx+fxnAK7A7
         /77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184225; x=1729789025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ow27IoNsvgkUupzx1K9O1/iQYpLFAAkG+OJE9/un3uQ=;
        b=CHQctIOOCJ4l8qcBzrY7gHMM2z3iDb26ebAnrSiGOlnLLx9f2VtlzyM2M3RSrzGsLr
         3LjErRlXEW30TJCPFp/nUckLeo+0uoguTCDEs9PWS44UsKCEDhCXhMZHXiCCyhAfdsd7
         0kE/S3rt5EbhYAehlOGDYqJTSfK+hs0q+O2/ODe1YzWdW9Q5oavh7YSmdPZpMPnlow7J
         SENiK6sMgeug9da8r1fHH58IIsnqvakAIHB8oENXt20peJc9mNUQxwmgNR9tgNXWKCKs
         32yqzTC05S9LahwjNhMLarJ+S59V+sxVcILqmYQ4tLtjIKm2SO2C3iy18eyJ/KiJxKdF
         2CXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfbWnyP7mgaIjMpFtDC5nzBzCv3xs2yhbnuchCtmUZF7McLFnDnnw3KV6kwbCuHgo7mpwEGE5+yA/wP/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfKTg6DSpXE+vEdR2XswbHFrVQnQ3DnyVmSDHY5+xu1oHa5MSp
	MFvnkCnb85mt5en2Jk3NbcgbWy+rhl+FrNgynIT4PVqJ1tghd48TomZiGc4AOpE=
X-Google-Smtp-Source: AGHT+IFc4ig7f+6vzcYDgZZvBiqAMxNCfru1pY7VxzHxyGtbBc8iE+1KHZ3X/1EqGkdRsZY6VWQI+Q==
X-Received: by 2002:a05:6512:158b:b0:539:fcba:cc65 with SMTP id 2adb3069b0e04-53a03f19aadmr6114709e87.17.1729184225472;
        Thu, 17 Oct 2024 09:57:05 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a00007078sm821563e87.212.2024.10.17.09.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:57:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 17 Oct 2024 19:56:51 +0300
Subject: [PATCH 01/14] dt-bindings: clock: qcom,rpmhcc: Add SAR2130P
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-sar2130p-clocks-v1-1-f75e740f0a8d@linaro.org>
References: <20241017-sar2130p-clocks-v1-0-f75e740f0a8d@linaro.org>
In-Reply-To: <20241017-sar2130p-clocks-v1-0-f75e740f0a8d@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=2RlnfXAvC+5RWHBwXyBuZ+I/mjr57HcoH5Usgs02gbI=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEUHZtvURDf55P37zDxb8LACSerxh8RPQFpM+4
 vxtlrrjT8iJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxFB2QAKCRAU23LtvoBl
 uCd6D/9ucuKiZe99n9JqqOAsDKH743m2Ki2WWapxCHDR/ZEiIrwHImb1+3ic0JfXWXkjGOrj0CA
 8UOvt09T2fJ8ODtTdZ0DbHnEU6aOr63yHc3gTksvUtanWfg2MYEB2mqmlCPLmGKOgsxd1ljeUmr
 gAGVtgFsEryzAgko6tRckm2q/uNMM+AJmlxHvmq/kjy1SU7CTmyioiranWVB3c1XLMMDMrUouJ/
 BKMkC1i9P2KF4strZAY4Xa0pAWiNiaMxLy/ClEiNXb5bfPXgRaMBeK2t7jT9yusNG3GV6KwrApa
 zoSGblN54EYPKi+u13Tas0zrgC2JnVNHV2asVdxSPkq3QJs6rZ/f9qOsoeekyw9aZruWxy1jHCy
 h4/cO4r7Vm2fqSq+QY/CjOmmdx4c5Pc7COockLvRgFWa97K1m5V8Aqaaa46wowdZm3Y63j8v1wZ
 HyuneXkADqDery6LG7XJRRWcfYV9p9Hs6X6Y42+3V535jGcssN8Qmc3ApjE9MCv3CfucVKxYVhL
 2ngo1Ohpbykufn2qFr1/AurQ7eXFiBPvDlqRWRFnjkukUhplL874ZdKZRK1HYdGpWLSVLZBgN2i
 Oh2jPwkiBKWQSWZ8JJNVuCA5e34uffkabL3mI+286bAOkc+r2B8xEZx240dQ+s+vBoJLNI3EilP
 2DnewJO3lRtdgAw==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Document compatible for RPMh clock controller on SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index ca857942ed6c08cd4b906f18f6a48631da59ce9a..a561a306b947a6933e33033f913328e7c74114bf 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -19,6 +19,7 @@ properties:
     enum:
       - qcom,qdu1000-rpmh-clk
       - qcom,sa8775p-rpmh-clk
+      - qcom,sar2130p-rpmh-clk
       - qcom,sc7180-rpmh-clk
       - qcom,sc7280-rpmh-clk
       - qcom,sc8180x-rpmh-clk

-- 
2.39.5



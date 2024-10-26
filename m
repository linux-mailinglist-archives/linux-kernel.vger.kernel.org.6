Return-Path: <linux-kernel+bounces-383281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6554D9B196E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F081F21B5F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FDC7EEFD;
	Sat, 26 Oct 2024 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+uCu3K7"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492361D4609
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729957636; cv=none; b=O/e4WqIMv//XIzT28ogGJUteUhy61vDuUQNiX2qFNFZMyrzC4DhgM7WKGrHr3aBEjYPGbn544xWhKsGIvBkEyDZRLaABD+aMlpIRLYvvDV17TRN6uvfRVcoAyfVMSr1GHs1Q/dLSxjHMbiVlC9oGgxMPBeDWY7c/FjzrN5qvy4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729957636; c=relaxed/simple;
	bh=mHXA679fTLSBfLWh8pBmR4AEa9V2nbcklgPIdka6VnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JFKAAzHipJ9qs6flH8rWVRTljQFKdPQaHm2T3Ih8N8AMgeW5msGiihzDapD7Y5mmHhbzpvGE3S7y50ck58oyGwWA1CG+JTlEmkGIryGa3v0htTh4mkgkl9fVh+L2ilfM7/L/lBegmJZgRBSQbjhwLHqkBN9MczFh8O2BGZnARP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t+uCu3K7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb49510250so30355771fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729957632; x=1730562432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yljl+967ibX2I7aSbp1Ln8dspkbFoWgzBqO671H8u2g=;
        b=t+uCu3K7XYz83WquvyTKrUMAPkvmEZE3VEpNI/Bkw6wTngymsMBEYFCN2xqDEFoNpc
         efzmAZql6ZSZcZoqZ2q3HaKtlqf+/OMOOhUIpkDqNGl+58kJ1l/Z4kNEZOY8PQcWAoPQ
         3bkxL6XcTGfOv8NLv/gcMPY9igLi2lsAld+hhiwuteLDsZWTsZzGodfNJAc2YuM1r5hE
         hMZbI+ohtLED+C+Tc9jddKw4CHA/5m7pmcJIqIL3v1Gl16keswo/qnuRpdbIokPxVKA0
         7xNu1Um4VdD3ijuKJX3pCqC8oOcjcV7nbOo9ioVYKuJmWJUKlFzy2/nai76K9VfKQQ28
         eFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729957632; x=1730562432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yljl+967ibX2I7aSbp1Ln8dspkbFoWgzBqO671H8u2g=;
        b=UHJAAqibl/iCRARk02CWEVpBeL/2/9cCRkDZ0AGSjBt6e/vOdbRowpQ+2NvCOyvIpz
         WlCVTSIslaT2J7pe/ydhD5A73sxjgaCrnuiE8P/K8OpoYMY4OXke1+s+UxXN9r0QOIX9
         GM1D0YEWHQ3sTW72F67llg1OSbMiv5EJGfXS7Z+0C8DjLC/dxY39oTwdTODxwP7OLULK
         JDxCv0+IP2AhdK0kosykIQtICg2U4fFjawnrZZjghOrmE7KGA2eET6gml736Ex7PHQvi
         Q5u1g9KbvmbL+NlV30e2IqauJfFHYKVdiOMgPRMTcjqd2btsW76ZTIgeTWtnQhJC2w1M
         tJWA==
X-Forwarded-Encrypted: i=1; AJvYcCUUftVnsGU/n9ZYuKF5lQREhRlOaJ8DE58/6wYMsDx7YB3dkpNt7htKSPryc4xuqdJGZilhHwqpjLZMfrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fO1c9OfNu/ELR5Ml62SeipKZ/KF2CkUKeJJr2iFamQK72XJv
	9+HZEz8YD5jmX3wuE8Di2LpYPdls4wi0NVoNEGGBwcssqsdCyqOUuIwbjwVwjpc=
X-Google-Smtp-Source: AGHT+IG7SjY/uoQEMsZIL9JlFDFXGggEqshc8CI8wWu7o8eHbauNCe90Ohk98eSx0DViMZHrAZjliA==
X-Received: by 2002:a05:6512:1189:b0:539:f23b:59db with SMTP id 2adb3069b0e04-53b348b5080mr1342432e87.5.1729957632368;
        Sat, 26 Oct 2024 08:47:12 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1c7cf4sm532188e87.184.2024.10.26.08.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 08:47:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 26 Oct 2024 18:47:01 +0300
Subject: [PATCH v4 03/11] dt-bindings: clock: qcom,sm8550-tcsr: Add
 SAR2130P compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241026-sar2130p-clocks-v4-3-37100d40fadc@linaro.org>
References: <20241026-sar2130p-clocks-v4-0-37100d40fadc@linaro.org>
In-Reply-To: <20241026-sar2130p-clocks-v4-0-37100d40fadc@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=992;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=mHXA679fTLSBfLWh8pBmR4AEa9V2nbcklgPIdka6VnY=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnHQ72m5nckJSIOYFaKh/F4W8sUgGtESsVwxrEf
 Fzx+qxal7eJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZx0O9gAKCRAU23LtvoBl
 uLEJD/9LiP6Yqf4x2qlyjIBXKRR43uEr0TsC5MDcubqN3Y/tKBpopSQcyVn8glrJeDEp/I2nXI5
 PqnIz7jmG/kvB1dgIKBdlxArk+KPT67qX5ovQZddWPFd85TweQYPYkzmKQpge2pAcic7JQ+KyFB
 Cb19oUKNSZPnPMyl6s/NP85w7nWoHm/TD82dFjNe0kydBacLso3s0MVAjvmuUzY7/SHfhVXCl/n
 hyApRqFm/Tx9NlCrhq5kEbPLiJtcK4KGlYcrOcHwPlqF2rBTzQfGhYikvTjifX8ckfTaB1TSjQG
 c/a4b9Fjpk/5od+QxlZ42ELwdjJC8LjAHb+yXhsye3/TkvoaujaUp8zwAkirvYnxkFDCY9jgGcB
 kzcAhdZygK5/bMMzqvmg8NFHKfCMSEqIHveidPl3b3H6AVz6LxaMq8TWtMB9jqr4uWiRPf2GhUa
 oDZsocGnSpcAGsDWkoO0xgHnCfLHftu9iikyehzKshywn/yoj++OVjG3G0ujAxtiE62BXrzLqid
 myqdJrtOkqNXmHnQD+8j40ZrLUdt7ve4sLmons7P4r4i80LcW5dYwCrCW/taXV1DpR12kK/Ihxk
 tBkOr6chjDY2G0OZgfkfnK2WfkO7v1CJeZBaYcNPi1Z4jt1tJ5w9b6mjoOz/wQ6JoEG7NLHpobU
 Bp1jhYYIeB93sag==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Document compatible for the TCSR Clock Controller on SAR2130P platform.
It is mostly compatible with the SM8550, except that it doesn't provide
UFS clocks.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
index 48fdd562d7439424ebf4cc7ff43cc0c381bde524..3b546deb514af2ffe35d80337335509e8f6a559d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
@@ -21,6 +21,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,sar2130p-tcsr
           - qcom,sm8550-tcsr
           - qcom,sm8650-tcsr
           - qcom,x1e80100-tcsr

-- 
2.39.5



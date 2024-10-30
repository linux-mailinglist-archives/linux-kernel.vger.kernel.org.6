Return-Path: <linux-kernel+bounces-388627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488E39B6247
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8801C217DF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0369C1E47C3;
	Wed, 30 Oct 2024 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="whm3yS11"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC711E5723
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289066; cv=none; b=iNLxgoXNcjZhTMLoM/c6y0Tl/zFpNYGbsT5qR87jBtQNnWhMdBJTB8vJpVWbB2MkL4twsZO55pfifxpXVd/J/+170r2uStj7evonLGwqqYmFzJ0J6jwTLxLWOVZo+0Qzv6TbK3XPLM1XjwZkOq0xf9HV9dfS2rANLG12RoJ0oJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289066; c=relaxed/simple;
	bh=/m4eEeH/K4gVgsor+dioESR28ChoPLKFbc+zI6OiNzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Va3TbBq9vCnA4QuVoupXNAirJmQBHoI1m4WXrEEOp/XHO7rNXgdA5ZdJZgsTaE4ZOYuSYH0J9N1DMV1cGS/mUik1XBUB6SYqbYmmfEtNhdNxeHoIJf3Z4RZRIuRx09F2c6gU3CRTL243onCiljhTVDlvhbFyJolBDjV+GWbpiUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=whm3yS11; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e690479cso6477726e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730289062; x=1730893862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEPqrg+2k56fMzsfJgsEKMFhYFCOknVp80XNEhgscRA=;
        b=whm3yS11Zd20rZ7b40q7yTfOdL0Az2o2hF7kpgXS5wXN4XFcOJ3bt6bhqKdcRaFW8W
         cQAIFESbqGVDVzy/cw54xVpAMRvc/7S5nc+WwHk+k0gLtL1aP9guwB9i0FCSXhotTCwv
         ZQekmLPe2J8SWh775vuXPamIhWmrmK9TMYxEFfuS/TlXfsc6eTiW12T7ecGydZlbhblo
         9inkZ/qLshCylgcs+1KqEyNsSBBIrr0pyZdHYTaoKzfb7YBhETI7Y2RKw4zq/NfGievl
         oB6RaDKcydGTd7ZLb4eAM90TiCp+Hps+6qcv8nQI6A35gSgtQBksi9aHDL7y1Jm5O2Lk
         JDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730289062; x=1730893862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEPqrg+2k56fMzsfJgsEKMFhYFCOknVp80XNEhgscRA=;
        b=qhAYYXJZjl3L6f2q5059nXHqOw4+DQZu3UPhmlDmmAG5YVdfIib+SvD8rS/klMCMDW
         zSvy/TBFq6XWkfWkepQdrcePKfFTHiRUUz5MljC/whu3gPATjAkLeGel322McsGqS+zo
         JwIhtYXv0iN5oVEmesEGS1HnFdk5IRFW1YWnrrGYremKJwaOQpZKFefyddyjXU6UhaFy
         jyvVukQVYNhsBrCeTpcdPOwDB9GN5fLcAmwkAOKCnlv05/1rjR1FhsgMPTMmVV4iNy84
         FZzPiVQ1Z4O9gGBg3txWHFBAIiUsw0pP6DdxINGyjjnF97iaP07JcaFkUzfvoDDfasEq
         Vmww==
X-Forwarded-Encrypted: i=1; AJvYcCXPMO8ZekYaDiTNEP1wYViDVIRqdaAZFSkRpHhxqKDkEe7Qm2e01xaLJD7fKsbML7qtUgmibagC27+3cfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd+A06RMPB1m3GQYFYNDv8pj1YqUjz5nUP3Di1vEV1IgtF/ZyG
	l7xHY6Q74x8FCcnTG1KBd6mTOQKsHIgaL5VgC4bolz6JPrN46Fb0vq1A1lzVTMg=
X-Google-Smtp-Source: AGHT+IFfsSDuF8yjSH7MrjK7alR8o3pQZJSBe3ew6+bFZBlQOYzUeCVYWB6TBGFds0mLUxqZc2A6gQ==
X-Received: by 2002:a05:6512:3b2b:b0:535:6aa9:9855 with SMTP id 2adb3069b0e04-53b3472951amr7793508e87.0.1730289062472;
        Wed, 30 Oct 2024 04:51:02 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53bb81a5760sm233049e87.84.2024.10.30.04.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:51:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 30 Oct 2024 13:50:54 +0200
Subject: [PATCH v2 1/4] dt-bindings: arm: qcom-soc: extend to support
 SAR2130P platform
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-sar2130p-dt-v2-1-027364ca0e86@linaro.org>
References: <20241030-sar2130p-dt-v2-0-027364ca0e86@linaro.org>
In-Reply-To: <20241030-sar2130p-dt-v2-0-027364ca0e86@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=/m4eEeH/K4gVgsor+dioESR28ChoPLKFbc+zI6OiNzA=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnIh2he7Cjxfo4pJ5Rx48TkRWwgoLIkL9HqERaU
 TN4ASQK/SSJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZyIdoQAKCRAU23LtvoBl
 uKk6EADAuMe5tcrgS4CqYrx78W9Z0PAhuY0pWPyY4yNbFqT4SqjM95oCi9GhSspWMDv0hHHeF6w
 V4Qb+q74NGJHg9dMfYMp3EA/nODJFWlHLE/DkT3BiwMmmoNFae8WI4T0yf9VGrsayE1xlUKoV9T
 hAsL9WEH1kCz2OmVKjwnudTxvQpVnbaQ+KbOmilFiN7Ke8RSaJzie5EmbPk8VTON9bsVTIduxUk
 7A1amX60rncZkkE6T71Nd+EK54fN6PeLIfVHTqiKGyODchosl5rx+lahwL5tVTsTxr2q/KNaSKd
 lY1uZUOhIu0iM1XtrEAVSN013wkbCVn02mmgQHtOOR9s+ApwK1ae9YebYJ/kDQUOFv6QM+jdkdC
 JkW3TyF3iedRuvD5ESDr7F1wHGuaWkEXvyI01L4SjuQ/pP69llN/FFu14Sq+sEE+nq9J6Q/0zpJ
 gbFCWhWme3mBe8cLDRTMxTCc2ccGmXOVKsex8uD+gwervaiqZbn1+s8x88HRbJrmBCrVyl0kLGO
 CmEGEa2fYe+W0KmzfliUAkJK7jJYQBUMjrBM+ljcUXMzZr2+7wP+/zQf7o48c+Sdx2G19tMvQNJ
 +Bgt8fKcTSN+aSg6zdvshgCZMNDOzz7RgcKntGQo8mFW6+FohSub/n207KShRD7q/91UfjXJfgb
 VwgklK/H5zO6ucw==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Extend the patterns in qcom-soc.yaml to support Qualcomm SAR2130P
platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom-soc.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
index d0751a572af39eecbbd2f8323a6c3c94b3fdeeac..1add7267f541a24e82e0cec62af6f0c839aca267 100644
--- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
@@ -23,7 +23,7 @@ description: |
 select:
   properties:
     compatible:
-      pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1e)[0-9]+.*$"
+      pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sar|sc|sd[amx]|sm|x1e)[0-9]+.*$"
   required:
     - compatible
 
@@ -31,7 +31,7 @@ properties:
   compatible:
     oneOf:
       # Preferred naming style for compatibles of SoC components:
-      - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1e)[0-9]+(pro)?-.*$"
+      - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sar|sc|sd[amx]|sm|x1e)[0-9]+(p|pro)?-.*$"
       - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
 
       # Legacy namings - variations of existing patterns/compatibles are OK,

-- 
2.39.5



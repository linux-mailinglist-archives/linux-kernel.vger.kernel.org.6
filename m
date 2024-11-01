Return-Path: <linux-kernel+bounces-391502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AA09B87F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41581C216A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5736F146592;
	Fri,  1 Nov 2024 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3MmYjoE"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5866B288DB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422180; cv=none; b=Dyl7shmbcOQJI1xtyw16jvScKu/rCHLobk3hAkpKfVW0UPhJ1Sh7UXuc3csXr4QPMheDZ+TFxZ9GQU9B0Fua/oVAsw9SFcD1l9bF6id1zhCQpXTp5+96nrZUyV/qJL7k7fPpIdgcXb7A2QdqjoX92oJB7E3inqa1dcULusAC5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422180; c=relaxed/simple;
	bh=zcM1aHQYb28gPOVZ0wEf8ewRZmUMyO3eFjxSaGLZXBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pdIrBP7DVgkdwwrv5B3UyeJmkgwFyAvs/1w+rRACjLEHnHTP9OZnbDwh2Y3XeDWRNERt1Hr7ackAiiXCJSrppMS5bsP/LWyI2nZe+3M612VdVQezYrXHSibsQ1aLvw44gnBltoJslXefW5iqMktTEMoAa0CkaiXoOYd2V2EbopM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g3MmYjoE; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53c779ef19cso1827798e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730422172; x=1731026972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/e0gd3zVp6cTvvyF3EOIt0/nD+72AfihXakLkWnGh/A=;
        b=g3MmYjoE+zHvwJ70S5ZCFEvtRdFyJl1UKiOkCGL0M4y/h5hCtQTQSXQgA25vxkY4Qf
         Acl23Bs5jZ2rTgvBoiEEXfbK3h/TJ9mm2CZYR7A9kct0c99pfTTBXuhyrDAP9RRXXsRU
         0fkIVnnPoMYQNH4EfLF4X+2ge0L4YiIy5Dwpt3dzwAOUm2KvPkHn0qBdWSpPJsl4bypi
         d2BM1oHSpUmOg/550MaNJztrnS6FnyNqTA8md5PiXDZhRRD+SYq/t5AmfZXCk659tbZT
         hWxeGAgrAWNs2koVtnSpjXWBWiUzsHrvWB5rz/vwptoCwQPcYH976PIkZZgOsSutN8//
         u6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422172; x=1731026972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/e0gd3zVp6cTvvyF3EOIt0/nD+72AfihXakLkWnGh/A=;
        b=PL21E9pl2gBxiU74gMTCdYbyJaZnl3JqK8nV/qPPRfsElXbu26iVFlVweORUp8pzR2
         92Vr2QM/GSnfF2RcYt5QXICIkxreivysCljhuPmmoQB8ShfCy/SB3LN73WK+VduCEIXb
         X4dRdHF/8rE8Ap/ZDkobOEc2GDjHtreqNAnv3ssqTV6XC32MclzXTu/z1xRVzpavL4lm
         tPs3Ujs/cThrvnbFUyU4Dbw9cZ3NJGIpmKUCGIR45nQRl/f9dus4TSNbKwfqXxcmZNHi
         Na2mQteYNfxigyQs8OF4caBnHBg7oF4yUnQ3hK6sMgk0+uCjVz59i8zYYNx7BsDgTecs
         CJeg==
X-Forwarded-Encrypted: i=1; AJvYcCVpVKAJyG8rgyborZQU/3/LhfDKsqX2Q+2CxY8But1O1y354H7RWOrqEP9uQJbNX4XW631xrFSVRa1+CRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo8wMC4i1H66rGQI/7B86HvpevvGWSzYddxw3or2patnzq8Z9h
	mny/DygXUYIAxZG1mwdPPF9rbvk2ir1RNazI8r4rAmLEzaTuKrsTnUtNBQuaMsKUxucL8tGIfUD
	t
X-Google-Smtp-Source: AGHT+IHa7ZZlYjS0LM7ksxCIRwWRnxpaFR1qej+SwC3mJbOktHRBCm8m/2h3a9AG1Xjj37cv3s8TMg==
X-Received: by 2002:a05:6512:acf:b0:539:f496:aa88 with SMTP id 2adb3069b0e04-53c79ea6c68mr2919492e87.53.1730422172088;
        Thu, 31 Oct 2024 17:49:32 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc958c0sm374510e87.28.2024.10.31.17.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:49:30 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 01 Nov 2024 02:49:23 +0200
Subject: [PATCH v3 2/4] dt-bindings: arm: qcom: add QAR2130P board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241101-sar2130p-dt-v3-2-61597eaf0c37@linaro.org>
References: <20241101-sar2130p-dt-v3-0-61597eaf0c37@linaro.org>
In-Reply-To: <20241101-sar2130p-dt-v3-0-61597eaf0c37@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2491;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=zcM1aHQYb28gPOVZ0wEf8ewRZmUMyO3eFjxSaGLZXBM=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnJCWUCfG9+eiWcn/clpUMZZDiHhY8JHuE2g3Yq
 W2zV4kf/86JAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZyQllAAKCRAU23LtvoBl
 uNX2D/4sbyb4IH0jVvh5UE+wk5ysRw/EvJgsv0NA5LoryGReHYHlSDxAaBUn4qF6ymMh8g8yyt3
 3lxV08/9Vj+dG/fPWOVNooB9US1jdfX30Yvsr0J4cb2JfLiH5p7E1WhnBTr4Nn6r7WtVsti3tvo
 5Xg31rfwGhZxvsEE5ng7OhJgNg76Jm8vvjA1CMrd/vl7qALpuIk6ZbknYKdtdLRKhm9AYtbYyN1
 1K7Ut9u89t2zE/0fMTlpepsVGyLN/7qAulMDksXa1gDmKbSaj9d4nBwDMEBB0FvxQgf3BmEEkXd
 J+9Tgv4lPngCjWdcFf2Th2ETd0tARf4kT1MwoGHASC1zjCwoqMPbUHq2eNn27bQ1JkaMWsVOLOK
 ZQXwP+FgKkEf1xu85FDJS3GncRrwtr2+UFtfTjzt9uU5puU5G03R5NNxnMHxOBSHkrbxCl+mw+C
 Ctjfev+Bzd2gRwfZiSF3AfAfilJBzdrLwnbVwhhzTmVWaJFUk1asleoCYBrH+s5sMGIVxbxXITt
 Dc39RJ8+je1OniRZ7dT4qNlyIH03uiCyjywCxYvidRd2iHpwUQtw5o1CU3bBYmfmZfutDdCPMAH
 dhBhTAOZlTmm/NntFC7As82yh3YaiB2xARjoT8L64dN7B16R0Vygv1h/1cyS+fLMr8qyGbGPJX7
 /ilUS2KswjtjjpQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add the Qualcomm QAR2130P development board using the Qualcomm AR2 Gen1
aka SAR2130P platform.

The qcom-soc.yaml chunks use explicit 'sa|sar' instead of just 'sar?' to
be more obvious for reviewers and to ease future extensions. Overuse of
the regular expressions can easily end up with the hard-to-read and
modify schema.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom-soc.yaml | 4 ++--
 Documentation/devicetree/bindings/arm/qcom.yaml     | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
index c67dcda4c8169dd72e9b5d5ca4926991a730f67c..1c164e57fe9c8f911852b0222bd229452d1d71b1 100644
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
 
@@ -33,7 +33,7 @@ properties:
       # Preferred naming style for compatibles of SoC components:
       - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1e)[0-9]+-.*$"
       - pattern: "^qcom,msm8[0-9]+pro-.*$"
-      - pattern: "^qcom,sa[0-9]+p-.*$"
+      - pattern: "^qcom,(sa|sar)[0-9]+p-.*$"
       - pattern: "^qcom,sc[0-9]+(x|xp)-.*$"
 
       # Legacy namings - variations of existing patterns/compatibles are OK,
diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 0f18cb35c774aec48967eddbef4b4480dbc8edbe..02b2379ccf7741a0fba345d83d0ce7db731a3772 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -52,6 +52,7 @@ description: |
         sa8155p
         sa8540p
         sa8775p
+        sar2130p
         sc7180
         sc7280
         sc8180x
@@ -407,6 +408,12 @@ properties:
               - qcom,qru1000-idp
           - const: qcom,qru1000
 
+      - description: Qualcomm AR2 Gen1 platform
+        items:
+          - enum:
+              - qcom,qar2130p
+          - const: qcom,sar2130p
+
       - items:
           - enum:
               - acer,aspire1

-- 
2.39.5



Return-Path: <linux-kernel+bounces-388628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A739B624A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94541C217DF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211F41E8820;
	Wed, 30 Oct 2024 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LL2v/CQO"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD11E573B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730289067; cv=none; b=mSILWXHPjW01CijL/QEjQJX0W8QgLWsC4uisqnB3qpb/CipmZ7+DJUjjHVHjhG0lgidbXwJYbUqkrV9cpJmybFSVOctusnoQeTNqbgOQRgzgP/ogkUo4uynjbYSvzFOXxFtwz3xfpBFPLArMd1Q0JRGUfpWncW4AkmPshhb5KOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730289067; c=relaxed/simple;
	bh=duYFt8Q0C4vKJ4Lf3qNH8Wm3mLtYsrGkrMgLYNj4tBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lsFIrwBtWBokfY6Jm54XDAjHhKwPDWrEuFjvamd51Jz5E8qxIi+zvyUUQPJwHVYlB7tp7sP3AjnwIodngrJPF/PKcadYxkNg8NWdTe/IVScBmmDRQob22deELok62zpcyNciS04gdeVuxI6lCK3mqSlozxXxhK8F42IwwYmuI28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LL2v/CQO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f72c913aso8578311e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730289063; x=1730893863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpAziabp30p+RBNnX93wZXhdNGxeor2ysyS9kXYTFiI=;
        b=LL2v/CQOuXU2GhSxFr+pmMBShRqn1xEBd0vjTmZ+tj8mdEigcDGsXpgpl4kHghRql9
         7Rtf/uFV/G4cXicRSOaj464EqUW3Jk2kTyfWqemrOnWY6BcOXIi+iI3mGL7Gd0NGfwa1
         uk9juGBbfpnCb5B0HGp01HI58tDMlQQDMOHWNNAfvjCqUgMPjc6XKZS4KfLr5rBkiHdK
         qIyfHDtaBFl9JYDGOegioL4fgqw7CzofUMonVk2OmlFsBvamI3CSsjEKKaGSt0GBwMUf
         PxO+IOKaFTui9bf8/oUULDj1t/Mwj2RGdFcJJOq8JfUUKv+ihuyMKGsVEtw7GKqky24W
         OcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730289063; x=1730893863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpAziabp30p+RBNnX93wZXhdNGxeor2ysyS9kXYTFiI=;
        b=BPHGWnN2qCafMigChsQWBQhRXEbQRd61eqmGsb6ptqrCVSI0pEzLkOilkEr9xbo4R5
         rUOLJhumScDwz7x4cjExIGowUjaQWIUPjBIeRElMqyjILvynPnebCEu0s7SX9NA6FXgL
         k0fWg7M3KqiBiX+8K5enho7MY1VUrQdFvGYKDBA1yexfH4p1clZsgsTYnrpG/3LEL73t
         YVlaDLeceJ40gfTyzks280MDHfxQ34Ky/BTzA86lHSKrtx7umm4bUsu8W9PG3IT/o3Ug
         AoRh5o05/aNSl9uwLOQSyQtFnYxo/rFNgqC/9D18wPefQLzv2n4lqyoSpWOT0AKBR55F
         Z/1A==
X-Forwarded-Encrypted: i=1; AJvYcCUmKF7y0z4mzTI52YRDvEppwXeMS5IYFRNmz2dbbAc9KSl1WYA1Aa9HVgdcLl9do2JiNcr7j4P8IQ416+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoN20JM4J5abjRZ0261fevYw6MQvGBTWgYMPgOARvO1hVdlQfA
	q0QvWwhT7HfkCDIg9yd+GvtmE9YtLCr83CAtOFEb7t6GLPCETIRrfvFXS4B3vfY=
X-Google-Smtp-Source: AGHT+IHY9JW2b/YItJcHdenvxCAuapOpAkE3dqnGLJLznD7jgD5Oja0UEtlCX7FBBKufABf0x1//1Q==
X-Received: by 2002:a05:6512:33d3:b0:539:e7b9:df03 with SMTP id 2adb3069b0e04-53b348c3954mr8108808e87.1.1730289063451;
        Wed, 30 Oct 2024 04:51:03 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53bb81a5760sm233049e87.84.2024.10.30.04.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:51:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 30 Oct 2024 13:50:55 +0200
Subject: [PATCH v2 2/4] dt-bindings: arm: qcom: add QAR2130P board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-sar2130p-dt-v2-2-027364ca0e86@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1089;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=duYFt8Q0C4vKJ4Lf3qNH8Wm3mLtYsrGkrMgLYNj4tBg=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnIh2is0qis1P7VOMATTGVVsHT+igukqXXn1Tiq
 91o9n3OBCSJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZyIdogAKCRAU23LtvoBl
 uLUQD/9YvPm+jZPUMLpI4UPOT1SMKdc18M/1d3Awol4HqZRg9UvR6aFZos+hMh/5xnFyjqdac6L
 JWuq0fHnp5u5jR998rHBSy3ibVZER0wvmYAuwhgWWdXGyk3vJkhaQWa8r2ppQmeNf5hRqmMs7nv
 TINIMNXgsLrdc3mgoT6IBtM04Q2V9OBOLofFqXrXo/dNr0PFkoYZ1pk0GwdiSxtu30Kh6p/OHlD
 Vsp1OzLujoGlNyfQxojGd9mFmR56Um3TjUEXIi71SIoIE5bAcA4XQIR615mo2qJGXc701Z5U27A
 NSM8hL3TTuCclVfRzBBt3H2auJFkkshNvzAeeV/eHVow05MznWw1XidwTaWUXVrF6kLzJuyXc/B
 9phLmH+6tEp4LA/yQ7d/cIed1TB8IuN+FsOOB4GjQCplrHE4ZNfFF1eKzgM5YN4l64NEOh5Bskw
 diBoofZC2ERvYCYnNAU+PEnrbtuySxngXyCAU1L4SGQmIouoeAFonndV+9VSZMAF+ddB/PtqHPf
 lcW7H3FqwoKTXQU9tEVjk8kx5OtQfGW8wCR9Pi7EgxAgKHYOWJ5XbpTUhTl5b8d//N3SMhZXnd/
 wqgi2TEi00HBmP2IU63PEUoR7FIM8ryL8XXV8SOk11qQcsNeHbe1hKE7S3lHPkjGqq8eeXfPLwn
 HIyeL/oEhoAdiEQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add the Qualcomm QAR2130P development board using the Qualcomm AR2 Gen1
aka SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

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



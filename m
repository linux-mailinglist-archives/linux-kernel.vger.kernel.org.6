Return-Path: <linux-kernel+bounces-253983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163ED9329AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CA02869CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5A219D88A;
	Tue, 16 Jul 2024 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="efPuzL5W"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF9198A1A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721141330; cv=none; b=DGSI9urR6SHeaw8jBqiFgBtIsB1LtoNR0bLKxunOkIWPrGP8LaPVBInqZ+77r+rErHHFaC1NmyGabtxk+PjIIe8PRkhIX7QZ+PyjBRdDtIrykYLpCA9vI7CsbqIVkqiK101K8HXNZVp4zxmQ0kgHv5vYzmF8QZ6saiDVCM3zp5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721141330; c=relaxed/simple;
	bh=bWuhf1ICw3I2jwagK6LuZPJ5kgY086Z9ZS82Q9meJUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=toW+yOUjsQF8xb1O7++QlAj8pwaMjd8PlodKSTao7D3vPPOIo/H8SK0/YE14rhidHP2S2bN3IeVghcNjrtGlrIDLEtmeifA8YWJpvDYI4TxH6fUouQUHnJgR/wXSPf30FoC7tXSCsW48zV3RThdB90zyCOHFrFnxQvhi+DUSdrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=efPuzL5W; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so38613045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721141327; x=1721746127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8i31+WVNl/nD6EKdwlewPxCt2fUhKOj0/YKykgGnpWo=;
        b=efPuzL5WHy+Hxe6k+fUFNWh/4Wgi7wHojEOFTVsLLGfZmRkX1reodISk5M3z6AqKgE
         6zTfrXirEoYK1NvJ+v9QmlVNUGkvn9m0lpNKAikKRguIEZZ4Zq0YLPC23tNZniUlUU40
         sC1bgszmQXmrUzb4osTXbfOhYPDI2ruA2RQfRvZ6OkIK4G9+qGfhvVUUrSnk1seIBzpu
         pPItp+VjXt5GoUjXWbtzlrJFRSd1XcVCWbsgwaBi1bWchxuNuKFzICTVSNFTv3ym+h78
         5iBLYpRdqVjHThTwIOzNKf1mhSS4OKkgeuhmjBNWD2auGw8EWaFaIj8y9oXxswbgCVLf
         JkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721141327; x=1721746127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8i31+WVNl/nD6EKdwlewPxCt2fUhKOj0/YKykgGnpWo=;
        b=DlDklS58s7YjaMlf2r8OnY7jx31mu5msh70KCia87h0pSWM1eWiWD2jK+DDsj0PA5H
         8Tr7zPbf8gURBL46gFdfxsgdqz59hsY8iuhkOaAE9JB+BK7HN7CtLGx6p/GlskL93sFL
         nrFyGSp6r9aokQnjnspmnkFlyqcWghACbF8/M4BmkqZEYzY8IZvYyoNGWmJLio8gvxsa
         3DI1nkd7vzcIeMCcmDngarlfrDR/TL0aeczCOfBPEHGsmNlvZbHqrdi4UbKt9hij+Rri
         78N4+oFbna0X8XW3O8bEKJibtBmOxwoUXActpxm6mkD3Y2HqcUS9eTTrkR43JMdt70ZD
         XZMA==
X-Forwarded-Encrypted: i=1; AJvYcCWYiEX83mD1Cf2+Hi4ytmHl2K2XtekgFq1upvAYra2XzMnT2w68vtcCXo5hwdOEm24v+EH5Rt8AwXudVjfgK/SyArbAv486iwUsysk7
X-Gm-Message-State: AOJu0YzpvSbfILuK1ZiH7qgtUrSvy8Uj2c4KpgCGNr5fBa+VNhgpVmTP
	ZJImQzlpa7i9W0mB6VI5xyGaDFP3UWsRGRmzm0oBXsDST0ywAIoDbC5knzLrxcw=
X-Google-Smtp-Source: AGHT+IFSyftMP3yVlnEcZDbvmlEYg59teKQ9FJhUnZ0QnL7q3XwsBMSuMJCTplBqZIJLQQ2kqfK6+Q==
X-Received: by 2002:a05:600c:4e52:b0:426:597c:7d58 with SMTP id 5b1f17b1804b1-427ba72af91mr18038825e9.39.1721141326863;
        Tue, 16 Jul 2024 07:48:46 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5ef44b4sm131907145e9.42.2024.07.16.07.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 07:48:46 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Odelu Kukatla <quic_okukatla@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: interconnect: qcom,rpmh: correct sm8150 camnoc
Date: Tue, 16 Jul 2024 15:47:38 +0100
Message-ID: <20240716144738.109823-1-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sm8150 camnoc interconnect was mistakenly documented as
"qcom,sm8150-camnoc-noc", for which there is no reference to in
drivers or device tree.

Correct this to "qcom,sm8150-camnoc-virt".

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 9318b845ec35..0cb4f7154844 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -71,7 +71,7 @@ properties:
       - qcom,sdx65-system-noc
       - qcom,sm8150-aggre1-noc
       - qcom,sm8150-aggre2-noc
-      - qcom,sm8150-camnoc-noc
+      - qcom,sm8150-camnoc-virt
       - qcom,sm8150-compute-noc
       - qcom,sm8150-config-noc
       - qcom,sm8150-dc-noc
-- 
2.45.2



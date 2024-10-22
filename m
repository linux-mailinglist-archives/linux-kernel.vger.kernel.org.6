Return-Path: <linux-kernel+bounces-375734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4819A9A26
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50F51F236B9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7769F145B16;
	Tue, 22 Oct 2024 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r72Rw2co"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DFA14659C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579365; cv=none; b=twv1fKJjaDS0DeoyQ9Eo3JSUk3EUHFdMmjMimVccYjtg3qneYDPjJ7BBud4ZT0jMcTRsZIK6DQiKD/vppdh7sTtfO3dY0LgBgjF3nmK6V1YHxS5GkCb2e0qFclMA/HA/QMc5MKMRQURBOmoQ4Z4r7R0WFtuYIZu0lGofXcvKOCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579365; c=relaxed/simple;
	bh=sFZw47jjW0Crp5XE2dnpAeSONWmy9BMxx8vlmvab/Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RzDJ25okNXt5Sw1NKCycvBvlYpOzdcnkf6BrwEsUGeVCH3NJFcX9ybsENVJr+5ozXIk/NrGZuHjTLsnjCPhMUj+YLW8R4xDbUjvIg7RkYrsuNrOGhcTUvm8qbuYDN/yi/Jquz+vRKqJwQNTMsl4Uo+A3EJTre0ANtwixnBAa6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r72Rw2co; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d4eac48d8so485777f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 23:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729579362; x=1730184162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bBF5cNkqgsxi1vrXpB4/gcyNu2LJ4ywbdnrTlXnn/Lg=;
        b=r72Rw2coC0f5oJrCLGYDoHpieGeVArKSTRCt1Xr+OlqnR6QJOGMPlu8JNLHoOmuB9Q
         ksepzCdGsWmIHF0QIndxlf5+lCC5WXTw5YubN72pINj4L6cH45hvFB5oMs9TCcf5mEIK
         yMVT9xlTUmx0mJg/5KR1JWs4nv+qn2VmByz3Wq9G3CKiI7G6tyydNOF1O3BBHg+EKBtB
         eeesRw0tXGBHPWBp9lb09u7NGYg+O6u6VxsrjCZWD10qSAB8g0e2rbhhNAz6bxDdrNpJ
         3PhebGHD26g39FD5rqITfngAXMqRGGZJaj6KwNKd8rSaD4iWkajkU8oWHRqJ4IWgTqcg
         Plxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729579362; x=1730184162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBF5cNkqgsxi1vrXpB4/gcyNu2LJ4ywbdnrTlXnn/Lg=;
        b=gYSaAJuYjmrMdIu5gsbWQJ71PK5RxMo8efCjPvaBms3gJD1Y+8af+FUuUi3CWX826L
         4x9Eo6mg1r9n+mDaHBVBFi9beO0NCuBgX54i12ndKKEypIkHO4vqxwT+2S5j3F59ItiL
         h93y3FtUVGYf3otlqMDdVDf7wfKlH+wwsaaTfn4m8I0aY5PmO43Rvp5MoXGt8mtSFewn
         rOSYDPU4xuHQU6BEoLR8f8mhp2U7QflJj5SPSLzQhUSGXMwoXP0WrabB7MbZ7uFKUMMY
         npQGTwK/JZEzL61RWoLTZbcfDtJj5aITHy7ScSoi6n67xUVChpA7Y19mqbSeikk+jRyS
         +llQ==
X-Forwarded-Encrypted: i=1; AJvYcCUInGPocCu+NisqLbvM1Gxm1YRU/H/G9S2wzqH9CaDZrvem/UoS48VT9/ZEOBwCLTgjBUkkMPmJjzPhzno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6zhSb/aTYpmaAxXQle63tTph7jebxKEmoIceiY9VRP8zVN/m
	3TMGtmqAe42Q2BZovs7+y1tsS/W+oMEAZGzOOz1IElobrhhcj6WwjrVXdoLdXmM=
X-Google-Smtp-Source: AGHT+IE8Pctc+SMNjOm5uqaCQn81QsnUvzzHg3ERtmeM4tf4V1+tucptfz2X/EcGNcR470ylu7wQDQ==
X-Received: by 2002:a5d:6c63:0:b0:37c:d0d6:ab1a with SMTP id ffacd0b85a97d-37eb488c77amr4471765f8f.12.1729579362217;
        Mon, 21 Oct 2024 23:42:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37bb5sm5914984f8f.7.2024.10.21.23.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 23:42:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] dt-bindings: mailbox: qcom-ipcc: Add SM8750
Date: Tue, 22 Oct 2024 08:42:38 +0200
Message-ID: <20241022064238.22941-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document compatible for Qualcomm SM8750 SoC IPCC, compatible with
existing generic fallback.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Melody Olvera <quic_molvera@quicinc.com>
Cc: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index 2d66770ed361..ae574ec30918 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@ -38,6 +38,7 @@ properties:
           - qcom,sm8450-ipcc
           - qcom,sm8550-ipcc
           - qcom,sm8650-ipcc
+          - qcom,sm8750-ipcc
           - qcom,x1e80100-ipcc
       - const: qcom,ipcc
 
-- 
2.43.0



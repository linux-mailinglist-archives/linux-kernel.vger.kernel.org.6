Return-Path: <linux-kernel+bounces-375733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B0F9A9A22
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD201C23F08
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36211474BF;
	Tue, 22 Oct 2024 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U5jpijqS"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C911465B1
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579354; cv=none; b=REmgLCuppXsopjF5udOm1LDSnBNOZvtKHsYAr5Qp+S60ZysAeg+wyqKGjnkzCp5vEWgiNUII2sb2G4tzmyPikPQrNO/VR1tFjfrW/BulAAKFzL1kfKZcYAGivV+T27qooHknRmHgZRp57azX04F0rSYSrrRs3BAVIzRN/xvgZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579354; c=relaxed/simple;
	bh=F/1AckOYpDpGQHp0y9iQKfxsX8A7HmSxmWRROwni/jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OcbPxyFmAZRrB+aAnDifMXpSzguNaYZbOTqynHIG1OznzQKCEm+/Ifm8+TZPTwmgGGA9J+tC3M2XGpkkWdRIPemjXY1HbkMsCLwWHxK5MZgddkJR10i6ndNWRFzfQklhz8ocS7oLqhUM664x1srjEj7+FwMH71Ovyj+00rDDHyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U5jpijqS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43155a6c3a6so7160595e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 23:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729579351; x=1730184151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P+s4T88prdpWLg5DqwQ71V3KjY1OGawDQVsKowQtLs4=;
        b=U5jpijqS8F8GtdkhmtoVMQK1sGGnMnOPtCcmWR9y7Ar9iL6mSxdo9P2Oqi4GGTHH5n
         LloW2GcC1Mv6mwT4bkJJMji934GDkFC5rEJT0kf9ktKg25wVeVYmyXmg7xpmjWwqLq9C
         GVKx36ad2iOFsaOvs8ATL+jbX1v16M9+I1YqpTcO8khJMLDXUvLiPKkPRgz5aigdCy0T
         E2bzwrIVfCuwZ8wDilXaPa2i6Oxr6gRJSOE7DgyKgmE1n4ck3KFPJScnD5vN2J6cA6Ne
         ObERXZD2TSQUZRVI6+18BmZlIMXZ7VHBji7oZBuDi4Yk3Tq099v3sTzQc7sMLWiKcoxe
         aatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729579351; x=1730184151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+s4T88prdpWLg5DqwQ71V3KjY1OGawDQVsKowQtLs4=;
        b=iApM2MoCjPXrqGp4AFElXN8faGwWzAcEN0xnDGiRLGYxnAtmaygpiadWxnD5Rj7lpb
         xfn4lDND0kYe1FxbXKIHLKbLrqLDIiZDMa1wvU37jw80gQbFPewl8o2GoCgKyns51eSh
         ZkEOKku8BcGJ1EmYgG0ft4wyQcKQMhzsry16s1Fu+HCJx6YUWKeQUqiKIa8fHT5WBpRD
         8ar9Yh+nASlfXS1Ix4KwX38W4BR+hBUVN/NfnLvWKSU77ZtUy6GualkIoTMGHZRfdUGq
         +CiyvKPSJIuC9sJ4DFwmKk39FctpSfR26sia5wUHOBcT7M/xv9UwZfNQW37oJeBJg648
         cEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGFUdd7mZbNuA0wp4rpt03HTuf3d6pRKKPlgf/vhN5lwkImbGIfYjlRakcX/7/u+eRNy1U6qxrOjez6rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwCBQPgVXT7s94zhODHZHbPdE4XCZAEHg/LBOOL3cxOAAzbAR9
	G22iU7sO2sTUO56/2+lXabYt5V0gh0SBtNrr8+xIpiChjV5HMxLDwLsAjq+UyKI=
X-Google-Smtp-Source: AGHT+IHg3bKcy1Oyitoi2Czv/YW5n7GwdCJZBqX4GqsSCVT1MX+iLaofIcy5Mu1hGFlWMheumQOMog==
X-Received: by 2002:a05:600c:474e:b0:42c:ba6c:d9a7 with SMTP id 5b1f17b1804b1-431616857d5mr45780365e9.4.1729579350607;
        Mon, 21 Oct 2024 23:42:30 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57fe00sm79353395e9.20.2024.10.21.23.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 23:42:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] dt-bindings: soc: qcom: aoss-qmp: Add SM8750
Date: Tue, 22 Oct 2024 08:42:14 +0200
Message-ID: <20241022064214.22868-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document compatible for Qualcomm SM8750 SoC Always-on SubSystem (AOSS),
compatible with existing generic fallback.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Melody Olvera <quic_molvera@quicinc.com>
Cc: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
index 7afdb60edb22..2b90cbef9600 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
@@ -40,6 +40,7 @@ properties:
           - qcom,sm8450-aoss-qmp
           - qcom,sm8550-aoss-qmp
           - qcom,sm8650-aoss-qmp
+          - qcom,sm8750-aoss-qmp
           - qcom,x1e80100-aoss-qmp
       - const: qcom,aoss-qmp
 
-- 
2.43.0



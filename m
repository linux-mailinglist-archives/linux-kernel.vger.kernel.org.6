Return-Path: <linux-kernel+bounces-196931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6581B8D63C7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FA028D1C1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C26318398D;
	Fri, 31 May 2024 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZPeN7KX"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F315B54E
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163591; cv=none; b=oUq3fjJTLvuwcF0Bb0I4EV4coE+HSHWwMmaR3Wc4xYdSTtJPAZv1MgHiD/hpLyiZg9wQPeRVRYvS/j0YUML75Z5d/H0/0kyO/Xr0PKnqzD6mVLAD4zSLSmkZzBFmxfpxMiJ5PjT8VyWaWJOgQiu+2xmtOH+qcCfvJhKnfDsRRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163591; c=relaxed/simple;
	bh=ksw1dGtcuFGYmqV0VwqlYR5ZUezhxW3IRe2STnM77yY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JdhEsEC4oG2JL89d0z7foS55lM4wibzXv96xp0SK9lz0U7fsZH7eGdrFIYM9EQLEb55o6ayuzYkhJPeCGs4/RFExCBxCFg6sr9/RkHSglFSRhysTxQOTFuN9gjwF0yh5/HGqPfXLEG0fCzDXX8qdm8p6ocwRl8qq4y1EkdSyzn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GZPeN7KX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42133f8432aso720825e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717163588; x=1717768388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=su/OgBx6YfPX3DIZ95pqxfeUtNbtsthTdIU3wY/p9Xw=;
        b=GZPeN7KXahZhEesHIUZOg3tNu5ZXcCVAktXl9156zCNdEZZD76tulXJaNMHVeZLgP4
         b8+NGc36f6dSVInbF/v7ASj3vYLEoIBtVakOacs7tx5LzqjS84HQRjbUZaZOmKvB1Its
         tZbyLOUqHV4ocm9tk8t1duAtn3VBgjU6x8LCUP4MYTwh1Y5WtUJBKflKvApn4lQ0pLEj
         qVjY0/xTFxGKEdoHCF2YqU6YfQDOt0iC54k3G2VELx15/h3m60EcYnfQRv+2JohLTnhm
         KZf+P6+xBGJnVEhNizWeqwm9hrtIBJRoF7bJwQNuIoad+Aa8fW0KaVhZs0U77AmnwYsb
         zHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717163588; x=1717768388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=su/OgBx6YfPX3DIZ95pqxfeUtNbtsthTdIU3wY/p9Xw=;
        b=IY+1Q9enRQTc4Yk98PkYSbpzK/spFJydksugAlswdntb4S0OvEFAgDhd1KUfIxDQ+o
         2iRfi/RtTIVcW0CpwA9Rwtsatcj0dzhSBGjDxhgrmLuCYUGFaQeCTQ6LJ43qDleEsiKT
         khrc9qmYghDEFERWX8+QFcxQbTkNCUn7LnvyVrvNtowb0HWGMc6PdFj74BW2iaDbbSd8
         ezMgiANrVBIswaSJGL+jo2X0u+M/V5qhP7U+4OLqUYoNXYUbH2T0z+VLrcsGWWArqvgW
         WapWM5E2P/zoNzvArxmLGPLkz4+4hY9LIgpq/LsnD8pbwd41Zlt1eqOIwurMiXf6/BDm
         qFVw==
X-Forwarded-Encrypted: i=1; AJvYcCX0BlyDB6UXoiSwBXEYXv3ou1de5gMK30+OlE+NBxwxWrhC+1umPqCCUn4RuvYR6Jjt1hwr5lxJhCKRd5BFV5vALSybAkV0aSbvlZb0
X-Gm-Message-State: AOJu0YwbPzXS72Nwu68wRIkEmNd2W03PMOyMQHIN7d2nMHfLUn9eFLS6
	+qPG7+AqiSI3vxM75UKTlcdC8aEKu7+hTI4fGj7E/nAIfxiMtbumNjOfYeAu5H0=
X-Google-Smtp-Source: AGHT+IH5YfFRUYxD/8yJ2A9rKYJFA5nkcR8Qt3qr75QsVnAa8JdDuC+ghCwHgluvg2pVqFBPMNHcxQ==
X-Received: by 2002:a05:600c:1552:b0:420:1aba:5030 with SMTP id 5b1f17b1804b1-4212e0cbc4fmr13903845e9.41.1717163588028;
        Fri, 31 May 2024 06:53:08 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b85ec87sm26762735e9.27.2024.05.31.06.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 06:53:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 31 May 2024 15:52:32 +0200
Subject: [PATCH 14/16] dt-bindings: clock: qcom,sm8450-dispcc: reference
 qcom,gcc.yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-dt-bindings-qcom-gcc-v1-14-b37d49fe1421@linaro.org>
References: <20240531-dt-bindings-qcom-gcc-v1-0-b37d49fe1421@linaro.org>
In-Reply-To: <20240531-dt-bindings-qcom-gcc-v1-0-b37d49fe1421@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>, 
 Jonathan Marek <jonathan@marek.ca>, 
 Del Regno <angelogioacchino.delregno@somainline.org>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1440;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ksw1dGtcuFGYmqV0VwqlYR5ZUezhxW3IRe2STnM77yY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmWdYirH2g+dMm4KrBh7mmI5pPI8qw/09KYdDw3
 AEUwaNMKpyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZlnWIgAKCRDBN2bmhouD
 17rdD/905nupPjJ4kEUvXUaeqglhRKD2NU8HNzuO4eIz9/aS8UT0l10yIE9lHgOoXMMnln7hkjL
 FpEhEK13TAZaaRCgu+9AMIQAf5TmUSs8L5dPP532NF2mWHbjyLy8oxWah/8WWq3lroFE2k7X9CF
 jZFHO2QhkZmN0qHlyx0rEByp3ee+xg6C7Uu9WDIYFWRyXUHZvwH2WCQaouJuFgvLFaDVYrJcBZL
 jkXB2YUBBo0VK3aOOmz/XB3519TKwjBSSjtnokfCmqujCjO4LvbWJSFXW5GeTQK7rT8Uxk3oryX
 P09Mz/R5DTKtwYfAeznVRGMBMK8jH6acR5uukv5Gwc0AnrAGYTM17a/hlri/2IwdnPtbVZmwduo
 Noob1bNeTwP1GQllOG0dG2znjNgPg3SyZlA1gR8YnViZ3HDhPjW2wWbEuw3jWgk5FVDjo59eE3L
 2cIhoWwbMgvphIZ1LAlxg/BCNgVCZEuwLRloYo7czyc8hOjUdZquBDRvD7bktvqbHwDnztPZbot
 dHy7cEVsqivw1OQ5So0VdtUBSAvVmMnAI6yZqBCMRiSfagAip6CxOj8dVVfswzSpsAI6jwGOhpb
 xxTWLm9vnoeO7siEwpnGwbz5MUSFBBgb6TKnnIxhhUpsfcSytyiTIUIgXi/9HKdpPQMj10lPSlS
 Rk7NSshb9Hi7Wqg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Just like most of clock controllers, the SM8450 Display clock controller
is also some variant of standard Qualcomm GCC, so reference common
qcom,gcc.yaml schema to simplify the binding and unify it with others.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,sm8450-dispcc.yaml           | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml
index 2f22310b08a9..4794c53793a8 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-dispcc.yaml
@@ -40,18 +40,6 @@ properties:
       - description: Link clock from DP PHY3
       - description: VCO DIV clock from DP PHY3
 
-  '#clock-cells':
-    const: 1
-
-  '#reset-cells':
-    const: 1
-
-  '#power-domain-cells':
-    const: 1
-
-  reg:
-    maxItems: 1
-
   power-domains:
     description:
       A phandle and PM domain specifier for the MMCX power domain.
@@ -64,13 +52,13 @@ properties:
 
 required:
   - compatible
-  - reg
   - clocks
-  - '#clock-cells'
-  - '#reset-cells'
   - '#power-domain-cells'
 
-additionalProperties: false
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |

-- 
2.43.0



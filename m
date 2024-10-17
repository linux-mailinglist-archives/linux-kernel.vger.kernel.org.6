Return-Path: <linux-kernel+bounces-370405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F729A2C02
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1FEB29BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973C01E0DBA;
	Thu, 17 Oct 2024 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zerbRrtP"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D01EF923
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188951; cv=none; b=kEebzB+03oFXsPej91yslea5ckgX0mUzQl0HT2OlA/s3RYzaWdlDI4ofwE6Zzl/DWcvTEd706zYKTRLxoPfQuNlUpHEYbekMvphWMikmJkPYE5Gek0OOTZs6SzGTsHaMBqTWbzU1Bkm6BB2OYITyF4O4D9K74Y+oVDNYBjjrRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188951; c=relaxed/simple;
	bh=oTUz/VQn7UklM5M50weS61/LwJNX0gzLAsrslEIBg28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=USINhJLr2xguzibNjKeLNZd0wsJ+BXo/3TXwMYbdUTatJ+Iqii/aOFO2HiQoFCEq0gZNVVpUzjSlZd9FzBMJ+2z+hlyv7TAybhfT7CrskY6LDH5ajO868Pnwn/Q9Fj3MYUIoC3jS16Es7R6sIVC/ZQ6JVqviGBVA9rYFnA0Qmr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zerbRrtP; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so11785271fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729188943; x=1729793743; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=maudRK96GwrbNZg+HV+z+1R0VXUFq2cWemaNzcdsWgY=;
        b=zerbRrtP7pmzySwASEdOTqybe8kGYikoCY7Fnn8IlUswLXAwxYlgPm834OmKWk+MsQ
         YmqK9lKTpOaIpF2ciBEmU6/L8oRbt/xSt26LBbYYSYIDDoDXabCs8sJR+9P6CWIHDew5
         7K18FVZ0I9CriHmM+Xv80Hdaz+Q/AQ5MrGIpS6y2PMRL4sj7w7bbB6sjggCoiqj8V5e3
         EmdvglGXvFk1DHih4zvFWQ6lnHKDNp2cVUKMFK1XDlS2PDcY3UEtipduhCPU5vxrXxH+
         dzlN18b4mWhIBCIHl7UPy/X4EhyzXI1Ddty5RJgDY+5vDMAxeAFOKOUz+oP3Ll7+Yq8R
         N8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729188943; x=1729793743;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maudRK96GwrbNZg+HV+z+1R0VXUFq2cWemaNzcdsWgY=;
        b=j37CCmiuMLrshiBqEVrrrJ8awDVmDkuV1z+hTkJKBumJzJk8XuhwavPtWyUy0jPiij
         tnzTbiw9HvtxgRex1LSoopdEvPKVegAmTwSXLiquZoBUSfOyKodIHObOlvewJFat5EZL
         GAKi8H9EIDWaLdc7nJY+xYrxnuEP2av2yfvDDymkGq+9E2CzQXpukZrhUr11J/ceMKAq
         bFWRBKapLuTtqRtHfz9osQiQRL9Yiilpz7F/VY79pD0K4t+wj9cjEC6VDvE821l2V+Zt
         W8KWh14e9iGY7myuTgwmldSnT96QUQBEwg2JoQzKstQ4e+yp6gAP6SQdY3MdY3q9aRkb
         NDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDEv9IG2yNsAIXt/Sf0jbsz3kDeFtk1wZwUjpQ+m8fyXInLM/0KRC9yalOxMuXLESzKWxRrMLtWTskAhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsv1BmJsJ9jqrG9w95LilV+owN9QuqX3QSuXtOBDTBwlWCFWcF
	rFbCxBNxVDmeW10ArH4jGb3V0AqebRdlpLxjpzgTD9lIbp8dxr9zjflnWKvqh6S9Yp5dsyg2WU1
	Ex5Q=
X-Google-Smtp-Source: AGHT+IGdawn5Jaob6iPB4C/w0/7QS92Bbp6N8Yq8tVyNvT29MkavEawl8TpSWQ8D6QE2vRWSpxWWRg==
X-Received: by 2002:a2e:a986:0:b0:2fa:dadf:aad5 with SMTP id 38308e7fff4ca-2fb61ba2de2mr61779961fa.28.1729188943494;
        Thu, 17 Oct 2024 11:15:43 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb6259e026sm6498881fa.133.2024.10.17.11.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 11:15:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 17 Oct 2024 21:15:37 +0300
Subject: [PATCH] dt-bindings: mmc: sdhci-msm: Add SAR2130P compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-sar2130p-mmc-v1-1-c84da16a001e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEhUEWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0Nz3eLEIiNDY4MC3dzcZF3zNIskYyMLC8tUY0MloJaCotS0zAqwcdG
 xtbUAkAT2v14AAAA=
X-Change-ID: 20241017-sar2130p-mmc-7f8b32889e31
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=oTUz/VQn7UklM5M50weS61/LwJNX0gzLAsrslEIBg28=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEVRLpxJmuaX9LvRPCf6aGdEkFFAK8GqzotRHP
 OiQQIO7YGyJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxFUSwAKCRAU23LtvoBl
 uNppD/9AqW5dVkYb7y1iJw72O3CbS/xvQi+luYmZAWmfUVRWTQMVs3PdsGaIjuNQIEyrVRqpvOi
 r2SNzkrd8mqgw9KiaiTTJd2kPI7W0e7GJ/xDK33lZfv5wn9OgPK63Nl6OD84NJG5N+MJI4ktjpA
 UEBhRX+FCRIvomcMxMblpueUJrASs/QfryitXKOpkUKwTHwTcj/DNrQU1NNzChPChLdDiKR2dty
 qTr4C5066ClCjgV0RxJSY/OGNhJvUd9Mr5gbTxpTgfOmJiQghnaGPQC2tJUs5W93Hjh/oNnom7H
 MaumtVjWfNRyIZlLfZPKcJot494NPKmgRyqDG8+itPFnKgK6KwAflh+8wt4F80cQzVEYnxRWPSE
 m4QQRpU7wljzH2sxSLngsV3zaE+MaH/c2wXRtEGIiQ2nytyJQ90NitvYwWKv6VRck3TKamd+YAf
 XalQkB0ymOnqbGsOGDHotS0v35oLfZdL52slHD7I1lE2/mxyTeWph//27evJJ47GQp7VnHQ3Uvb
 RYPlZsqBTBuGcqkwWepn0gZf7CTAdnpAgObzIO2Rk8VwBveh3k/WVieN7OZ5ARyWp55p5NmmV53
 Ihf15b0tH/nw72g6ijWcxPH5HEOnGc1FmY6SFA+bH+mlCe67P+fKzJk2NJ0vZCu6d0F5PpfIyAX
 2WqLCgmccZ8Ni4g==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Document compatible for the SDHCI Controller on SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index b32253c60919eb68f3cc0e1a37381f8cef748728..f2215de02e1b1f40ea9b11cb39f1ebc39d78845f 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -44,6 +44,7 @@ properties:
               - qcom,qcm2290-sdhci
               - qcom,qcs404-sdhci
               - qcom,qdu1000-sdhci
+              - qcom,sar2130p-sdhci
               - qcom,sc7180-sdhci
               - qcom,sc7280-sdhci
               - qcom,sc8280xp-sdhci

---
base-commit: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
change-id: 20241017-sar2130p-mmc-7f8b32889e31

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



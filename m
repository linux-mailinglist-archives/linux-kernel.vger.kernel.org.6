Return-Path: <linux-kernel+bounces-214560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F05290866E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5431F23972
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDDC19048C;
	Fri, 14 Jun 2024 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/sD3oTa"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E60B19006F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354142; cv=none; b=er041J3HasuVsvBKlzGZP71m0rsmPakhY8PMbYYkmjsBemgOVnBln4WdAd/QYeENKHgv8VW346vkodfUcdkDWAqZ2PtUj9X7/GgHuT6pmDrw4N0/L+JSYlJLUT5UlEHy7vTJ/G7RBOqDkHEI0Bd2uXdXVXAA9JMVDYeMe1p0AFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354142; c=relaxed/simple;
	bh=5IhnbDeMfhrQJFjppRaXrqKXHovo12yYiCutUlaZxUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SmrOlg5DxUeRYBLkSpNRDl3TIPHXt2JAnNa5qWSi4aVbqFfgdE3mxu5H8AhE95st5OitkLJkUInmHUC1ce0apji0MUrdH82lsE3ce2i3SFEan/u6oPQCQU08/9tStq/Ri+beHqK/vEpBjv737ny0LlDJ/lGUMRHqVcpiVl38Dqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E/sD3oTa; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b7ffd9f6eso2005923e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718354139; x=1718958939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9exy3tODP6D6SB8BPoapzrGAVV2VEaTDfn4vpIL8sTA=;
        b=E/sD3oTaWJ30p835EJX8x0cel0YDP8vnrCERxmBjwOYUFv4LHRto3/VV76tKf99sEa
         0W7rrmxzPIFd5/PCK5xkY3BtCJPgFOt20uThoJdw1hLar5W4GiIZ4HqUHKw8oZjY2IvT
         hCAfO6dDB7otuFi3C+8AcA/jtkgYFgCWRSIYVPP1sxiLBp6dMC766IXoowR7e9COcEol
         TR9Qm4+XESizw4FekknD8mERNK9B2/xH0iTlndb1PHFLJ6p+gVG+Uq7ZxDa2HT9tNAxM
         hQhponhI5Lenvo7yEZOnxlBGF0JHROKgVWi5LxoCFQ5PJY/seJ2k+SsS8iCCND7dRAXY
         xJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718354139; x=1718958939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9exy3tODP6D6SB8BPoapzrGAVV2VEaTDfn4vpIL8sTA=;
        b=FM+HYrqYh1xcWLceKeO36Oez3Y/n8zhLFPfCdQe0fEVagW6Qi3SxZ33M0wrIX0WTpJ
         hSq0cqGjURo/2oa1VMuR54YKOVBTLYjW8GPMkM4U8lode8A4B2OWpDQHvSrlhLWJ9Uya
         z7NuVAKoVA7FTp2oktunpy7LT4mvOqqpkeul8cfzuFBVe7wjtG7nFD5fP4jP/mBVWi8+
         9yWuJ1orJQQ+6npyW8QzEIdYDXa8TlIJNejTegN0iVilurK2mizhurOagBdcb4gDSkyT
         qG7stYuBX4pqbLpMQ8baBfGuXt8i5h5i5YnYhAkQ3n4aWMqBRMsHC+QZ0aHYGL+JJB1G
         Lw6A==
X-Forwarded-Encrypted: i=1; AJvYcCWAzKTc0ru7poRxyDdJVCcqy4tR4Oc7ckr3yIZe0lKLam+EvWSVCc9QgJzqDhhwHzqOOp0DV/5Z285g0fSyC70H56vGbS5/Tma1lwLh
X-Gm-Message-State: AOJu0YyOAxns2KYVG26jGAY825XCcp5XO23kw6VnJ2s01737z8HQCizn
	glilYH4sFBnHxxWD/95BCRFjtO/n0hvoKTgHtyvTqNQ+nps/3rgM8Kb8AZ2l61k=
X-Google-Smtp-Source: AGHT+IHTbmeczb/9lcCgLK16cJp1SreY1FK+nJgmHVIjpUBegYARLy52/Iu4pgHJLW+a67FN2MKxHA==
X-Received: by 2002:a05:6512:1313:b0:52a:e529:16bd with SMTP id 2adb3069b0e04-52ca6e99a33mr1603420e87.58.1718354138727;
        Fri, 14 Jun 2024 01:35:38 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282f1dbsm444776e87.110.2024.06.14.01.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 01:35:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 14 Jun 2024 11:35:35 +0300
Subject: [PATCH v2 2/2] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: drop
 second output clock name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-fix-pcie-phy-compat-v2-2-990863ea53bf@linaro.org>
References: <20240614-fix-pcie-phy-compat-v2-0-990863ea53bf@linaro.org>
In-Reply-To: <20240614-fix-pcie-phy-compat-v2-0-990863ea53bf@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=5IhnbDeMfhrQJFjppRaXrqKXHovo12yYiCutUlaZxUk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmbADYaE9TZu9NEvq7Nc0XurtFlswavE28Gqrn+
 08e2niAvR6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmwA2AAKCRCLPIo+Aiko
 1XGACACjyFeiP1G2iAmP7ZCpeanYDEvJ9RCTKWgAuxN/3fxI8NnL5GjK6s93tmLoI+lSflRCXnf
 n7F+5T01SlF3tnRAvYc6sDG9zBqu4po77g1qi7GcncqjtYWemV6rZoOhpvWRvVGQ9Ws17xesRTv
 9yam18U2ubqTtFp90x/T+WEO0qPZpxSzOoK6nvTJb+moCmQO5mWng9mw3dTexw/bFnFpV41UMBY
 q4o2uD+9aDJXXbrj4Wu4ksmME55R5Tc8o+xDP2PwXEflg85EDZiD+9EEB2y3kuYssYEn0/EmNBx
 EobPu9qSVlDXE2QTaV7Ztvg8MLnfcpsjbJKlXuHeqzwm+VTA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

There is no need to specify exact name for the second (AUX) output
clock. It has never been used for the lookups based on the system clock
name. Partially revert commit 72bea132f368 ("dt-bindings: phy:
qcom,sc8280xp-qmp-pcie-phy: document PHY AUX clock on SM8[456]50 SoCs"),
returning compatibility with the existing device tree: reduce
clock-output-names to always contain a single entry.

Fixes: 72bea132f368 ("dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: document PHY AUX clock on SM8[456]50 SoCs")
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml        | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 16634f73bdcf..03dbd02cf9e7 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -91,8 +91,7 @@ properties:
   "#clock-cells": true
 
   clock-output-names:
-    minItems: 1
-    maxItems: 2
+    maxItems: 1
 
   "#phy-cells":
     const: 0
@@ -222,14 +221,10 @@ allOf:
               - qcom,sm8650-qmp-gen4x2-pcie-phy
     then:
       properties:
-        clock-output-names:
-          minItems: 2
         "#clock-cells":
           const: 1
     else:
       properties:
-        clock-output-names:
-          maxItems: 1
         "#clock-cells":
           const: 0
 

-- 
2.39.2



Return-Path: <linux-kernel+bounces-185420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBFA8CB4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEEB51C219EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BA1149C7B;
	Tue, 21 May 2024 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FzgKnagN"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA0E54F91
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716323452; cv=none; b=ZojPhYnJwhczSJzA15zWzFGYM7xXYnAcTg0a4Ien+H/r8jBMRwXzk60aOaZ01lhcxg3Z7qmSYBXA6IIhgaVvEawTqK5nE6H195TZjAfo4KwvBVkz/2xhLRWc8OWjrn6b3YSLi2zfWl84oLMCnM7VtAdeqF+jG5SLTj+cQZC0J6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716323452; c=relaxed/simple;
	bh=mMkzAyWz/qVN9O2XMqdjyNpMMewXubKPHRJ1nIx25Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kYSKxU9O3TT4c3L4By6mVK3DAOnIQLdhGWIGmOk/Q+KplCFK/lBkOfK0rATUmh5nL5/AbRP4uso3Yq6AJXWneiucgZEgOD6h/okelCoE5NasAwZECJfS82lawrd3iB0N7+ZGFVJBPYz7RnJekc7HZxfg09Gbwx8yBS65W4tO9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FzgKnagN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5241b49c0daso3716378e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716323449; x=1716928249; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pp0wgsOf+otlTEcxeglIqsX7pRYpEdZKxDMC0pyUGd0=;
        b=FzgKnagNn332CgOgZlxGOZxxV4fDLxEM7R4iRSH2GsI6kZ50HFodr/ELTEzt9NlerI
         9BopCnNit6OmxNVGZoQEdhT8eKoB6bv0cmtIOElQR0vi2aVC2MTUP379XfI7XlpK1mYE
         AY9AlVgNnupjCf4cvjGJK5igSg6USlHBsg0/kj+qeCQI8oGOQLW7clAl+Ga8KIjHLNAw
         qgTI2odD3cMCQ1l+sUn9GzaYzHOZWp0cy2pX+YZgA21/7bWWvHecB4/ORr3gRUf3tXiQ
         FG+B0QD8hoC2Z1iu1hjADLROnR4229G1V6mS9OiMzcno0ZV/Y4D1DUqIXoCDQN9OXTza
         +nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716323449; x=1716928249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pp0wgsOf+otlTEcxeglIqsX7pRYpEdZKxDMC0pyUGd0=;
        b=lfurwRpytgu912TcGWUhF9IeDYUMcPGX5jmgYE+BupZDO4wL34UPoY/KjS1z2MXGEC
         P6Zo44xepnteiQ8pA2DqfVx/CsB+yD+FZV29tNgU1v+yMiKbbO0sBZRgmgmdFKGw0qYx
         5ENnOv7dB4+co/o3tr3HxlUDL5BTHU+G42oYDP98+pqnSLsNThFKvrDk7PX6ebJpQ/Ax
         LqbA5v85c1u+UwE58te6bi4kisLsx/Yps8IJJpPXP0qhZ/Hei59RPK9rwTFHWs1abmcl
         Mg5mf2EwYb92cyybGyeXRSAVwOTZMDMh8mnUKu+VhRrRysX58kItpeba7dYdFts0JkZ+
         z8tQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6EldBSmjPxvrqB9cm2Q5V+KsltfTls5sxfbxkZolIasx3jAuKfPMo0/lJdGa4Bje4tA+XUekBc41WJNPMlaq/VvZZibDdUUs10sN6
X-Gm-Message-State: AOJu0Yx/OlFZsRHOv29MITQlEtX3ZBBtHPuzpS+rOoShIM0NpitGEbRh
	UhxhraW39+eo2GCJVSv6L8OhNbZkCrkNsD6aAuw5VE1H2GwhIslyX0Wik7P94IA=
X-Google-Smtp-Source: AGHT+IEx8QHVp0uTJ2cLWhq4ftpPXl3iBNLrS/c1OcCJiaHJ6hbKc/1kI1/oPi+SIpmEttUD6fzuZg==
X-Received: by 2002:a19:2d0e:0:b0:51b:567e:7ea4 with SMTP id 2adb3069b0e04-5220fc7945cmr20433710e87.26.1716323449129;
        Tue, 21 May 2024 13:30:49 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5238ec18fd2sm2538664e87.155.2024.05.21.13.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 13:30:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 21 May 2024 23:30:46 +0300
Subject: [PATCH 2/2] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: drop
 second output clock name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-fix-pcie-phy-compat-v1-2-8aa415b92308@linaro.org>
References: <20240521-fix-pcie-phy-compat-v1-0-8aa415b92308@linaro.org>
In-Reply-To: <20240521-fix-pcie-phy-compat-v1-0-8aa415b92308@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=mMkzAyWz/qVN9O2XMqdjyNpMMewXubKPHRJ1nIx25Rg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTQR2ydgr373/+ZrReuBiiCPXPsnPvPUpPweIk
 +4iPSaWE9qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZk0EdgAKCRCLPIo+Aiko
 1XXhB/4mZQjQ8rLR/uJtqT2Pi4rQQ8eH+AKYTjGYWRIhpsGtkGy1LeqMfQCnMFUpfQg7c8dWDWa
 yqDNA3P5D5tnmknhaoH6yEFDYmqoEiATcnZHvevWqpqmrUwr3pYKLU7jsp739WyZLbJxljZholR
 P8rIhnhnNzw3rAs+1i18LeUkqjbhzgJWrnZRN0O5u+HcrZh9jpKSZciUtrEr9SlKsNsE3PgNHNS
 sIVbzJk/PM2HrFWAGvYTQJViogzeQuKWdENWW6J+5aTwf1K/7eNjQr9IZEd8wPKrOv/WO5+dW2r
 G5Fiebvg29UJ3A0bYdISOnCukq1AM0os/84vW2k6ycze5vVt
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

There is no need to specify exact name for the second (AUX) output
clock. It has never been used for the lookups based on the system clock
name. Partially revert commit 72bea132f368 ("dt-bindings: phy:
qcom,sc8280xp-qmp-pcie-phy: document PHY AUX clock on SM8[456]50 SoCs"),
returning compatibility with the existing device tree: reduce
clock-output-names to always contain a single entry.

Fixes: 72bea132f368 ("dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: document PHY AUX clock on SM8[456]50 SoCs")
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



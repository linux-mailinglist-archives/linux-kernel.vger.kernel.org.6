Return-Path: <linux-kernel+bounces-196932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6E48D63CB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA4228D74E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3728183A86;
	Fri, 31 May 2024 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgqTbEZL"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BAC183090
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163593; cv=none; b=tvW3sVm25aIwNrjVSGrIV5kvmvcCF7Wf4qpGWfFa3U5dxJpTPyNRaqzgKrbDMRoUb9UYNCDtK+LNNymyNdijXQeJFFovGPxaHDJG4QZ5qJRcwgAT1FIF6I8vb5pSdTsAj7wMJpdJvj6/BmV1s3/W9rrFqJ6CqKdiudRFOC+W+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163593; c=relaxed/simple;
	bh=MIaxzgtf3EYIItNiY++ERQ6Pd4LPhtKrW4IMau7KU2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fUbQifKPDgON2aGMq0Jn94wpDdt4cSgluisdVZsLngmYAWAq/ti7aA6iHYTqiaDLMPxgEgNe4HZm8akqIHKuyZnaD3/C59+rcjb99x9fBivS62d6Qv+VqfVP5wPlcRL3AjXTN/kI8DvwpuTfu0f/G5KtSvAC0ZNpC5mD8GQdmKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PgqTbEZL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so11716465e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717163590; x=1717768390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5OXVcp0wB8GuWTPIzgNl5UAtIeDHTf4posfRNOxK/eI=;
        b=PgqTbEZLUZ/02/7K1zXF8+JzKkZYBjAj5+/K+u1n2EgOj3NlrHGSqCcEkilKXA61lm
         e8bd4gGFMiPnbI27PHlqoTajCeQHW0yVfYkIVAVNmuWwQCFB3dYISCoiGufbGLJFEA0Q
         jsG1RxO9KNxPdYPEIZbGPCg7OP9x4E0deH/85SYIVZoWWzqAO2s9OAwF9Ma6vNKid4XG
         4z+MOijnaxSd5IWv2OE/NtfQcEpTCEPwxFnL4NVyig2KhBTKWJDTrzNTOXFZfJB+R8i9
         APACu/aGKjGRRfT+vyxNr6p27ldhVK5XOHsEXvIDg9ZG2PhK6/smtrrsDYqLunkOAspG
         v3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717163590; x=1717768390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OXVcp0wB8GuWTPIzgNl5UAtIeDHTf4posfRNOxK/eI=;
        b=YrXTFS+BK6SCzYpRiexqRu6uinsqvB/0WU50fx0IoHzQ3/psgN9MHQ1aknNgKs6ql2
         /XnenkBnMxWUkJKcF/il9rZyHkSLOxNFH1g+fVWKs5CA1DbG+kgd71KTTN5L07uQtt+3
         SgbjqkG9jQgEB2g0QEJxTuUkFeaNNp3VzkmnEolzLTYr0diRERDgHZID1GSe1mo0et0e
         bbLkAkxJsqb6KcPz0m45ralS7aWRShhmI4sirXvwPldTmQnQyspBn6sPXnnrAH2gzlhf
         NZJBvkEkQzZwup9Ey1wnOIv45s1fauUQ2DcWDdCff8uo16SmM2MmDQ4NhVi0hjHw0oIR
         d5BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqA68W4gmrxCdmWsK03C2Dw6XRXCUzoVkS8tQPh58A9nPZixDdtDsqJRPalijGBh86oZ5F5OvpLv1nJoQ9DpGW+TNDpGdLtZhPISIT
X-Gm-Message-State: AOJu0YyBwMH6ahoFFo4ft5037Eq/RCfa5MQ+y58/kHNiOGl2NuaWZDJE
	ItzmgQD+Ai+Cex3rJSHT5rD7hzgWxCRb1K4jP2M15rM5ZszN9FThtZ0oFGnLQwM=
X-Google-Smtp-Source: AGHT+IEFUMyN6QnsSdxOLQTAWiOYAhwbJdYs6BUJf71ZhRK/cAwHXwfgq8MV+YaHx/u1MUfZL0frQQ==
X-Received: by 2002:a05:600c:444e:b0:421:29c0:b6c9 with SMTP id 5b1f17b1804b1-42129c0b9bbmr37121455e9.12.1717163589843;
        Fri, 31 May 2024 06:53:09 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b85ec87sm26762735e9.27.2024.05.31.06.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 06:53:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 31 May 2024 15:52:33 +0200
Subject: [PATCH 15/16] dt-bindings: clock: qcom,sm8550-dispcc: reference
 qcom,gcc.yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-dt-bindings-qcom-gcc-v1-15-b37d49fe1421@linaro.org>
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
 bh=MIaxzgtf3EYIItNiY++ERQ6Pd4LPhtKrW4IMau7KU2U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmWdYjLRTjpbRhTM/J+VWoCZm7uBcNd3YjNEWMR
 aOUdfWirrmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZlnWIwAKCRDBN2bmhouD
 15cGD/oClJnVvKMmuIaJtu0zDlkhQtVHYYxNJoXu50LnXorj5v3P7P0rLPo+7lUi4YkkXhcYk46
 mHuP5gi68RiBmJHYBKOUqgVmjmD7oz0B347urQSXWh539AEAOVn38Uanxpge+jL+r1nVcC+AuUP
 21MFdjMfo5ZfSntlEvizLJirnA/Q91BmFa6htIhiHXlkbUKbEOniVsrTLrG0Tf/nLdbOk+7sGcS
 kqSk/p/LDZ6GQpmsdRz8+eESPpkhw3SC7DXOBibfOfX9RvkouhWHN2F+YCBcLH+4iJ5QarKTTav
 eeDowAYLnp5n9Mcx6QVeJsb0MmBhYmjgNq9N0ka37VVmjrxaUes4FQleds895FAJf8uY+VS8tOj
 JRWxsqFQ04U4VzV9Y+wU7QZzY615VMWWSoriQw8Fpd74Y4Y3KDrn6JQr/FzFc3rDiL22SytJcA3
 POQA9F+oyJZopadugK1LmJ6KxuRjLp2aWkaDyqnKkWSDifeMlheU3S9K3F5yLA2av6eDk5UK6id
 q7PRnQya9BaFABrgg4aos8S5l3BAkPU7rLijJ/8dKZdqoBHiGsagQ84L5M0W+Ibtd8Z9MlITfA4
 yXaFlZAFN283w/OsfzvfaKpIblXwy+d/zU3pgcwqksHXk+Q5mloSqkDOlRVvG52rhdqs1JPJw3d
 AT491BaxB9g644w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Just like most of clock controllers, the SM8550 Display clock controller
is also some variant of standard Qualcomm GCC, so reference common
qcom,gcc.yaml schema to simplify the binding and unify it with others.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,sm8550-dispcc.yaml           | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
index bad0260764d4..c17035a180db 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
@@ -45,18 +45,6 @@ properties:
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
@@ -69,13 +57,13 @@ properties:
 
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



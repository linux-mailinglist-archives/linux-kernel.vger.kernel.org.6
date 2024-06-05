Return-Path: <linux-kernel+bounces-201942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 146B28FC5A3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9221F21139
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841BA194A59;
	Wed,  5 Jun 2024 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjGCZT14"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C31A19412D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575022; cv=none; b=s+5qLjch2O9aKg6G8ibGxCYxJuYdBUmw8gqxYqVRfF7DHTp+vo29DZFInmiVpTIInYlLkCQ9whGd8+8aiIA2YlnIrVYGQjzrXffu/EgxsGxBw+3PkjrHlD5n1hvjTb8CHvIvQHtnCoxgL2G4pNvMMFYvNT2m75g+Ge+MVz7v1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575022; c=relaxed/simple;
	bh=kUWoTixLjB8NM25jgDQ+TcjXdSTW/JBRNzZSeTyTwjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lTr0d4F7NjwG897gMGgR+0DxpO7xBA1g3ZIEbHdnh/temz4uqeXC48v7U3tofLmGYefcyb3CpkX6QrN3gsmvGp0VagDTcQsXGo31XEMRmBFLr75gBjBogikzQySYUnFYbla5HAmVhvHzdv+dSjs+41xrgKeVsKqmX+Yp29reG00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IjGCZT14; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42155143cb0so13281305e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717575018; x=1718179818; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrI7N/nvDUeeq2XP/BV6oylhW1yj8ceWyw3UOWTZvo4=;
        b=IjGCZT14lmuoGLlX1ZyTmhSxhnRU75o+KV0DV7V+4JqdK5zmnU6W12FPIU1CK8GsPP
         gswiZHOg0zs+zycSJoVxredcaqQK6iFOdDvEKodKOCDYTubRcempXXN0KotqzbHcEBVc
         E2ldSWrY+qnJ3VxWIvgVyldB2aY2BMyayyxaZQ6am8tRViE9rpYwiTPtMpk4nF3IqlDO
         9I513HvRQvz9HWSZXzfyT8BCih93ohKiDF3kKDYu94WGR32Vxif6yZlP8Kb3zQORZm1J
         SZilIz4LMJtYw+i3kPfomjAQS97DHdn3JndLC/XpeYdyXrdZC4lrkLh6k1ZQAo7Igs1l
         pkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575018; x=1718179818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrI7N/nvDUeeq2XP/BV6oylhW1yj8ceWyw3UOWTZvo4=;
        b=MZWnS7qqd4tW3hVQG5V/F3TrbweADa5IcXybu+qp/+0b0sZZtuvpdHIM/sr34SDl30
         rZxHU7m/eC+Fqsbn8Jj/tBBSMWEY36O2nu+B1oYvCrw8T4TIzkWY78YJZjXJfqo0fE1V
         jZItw2/XMAi0i7whBHcPAC1xKpiy9KH1iArsubfDqOjcCJxDg671sZSZmUhax/pwyVkv
         GBa7iouqXW/tTwF6NMNMutXVISr7o4JcQZRMBX3rcCKg0pRMMnFWPmIUuDECqhJaX9rz
         WAFvvEOptRBlR6LH8wMXZNRJv8gkDvDyLqgHu/Yv4jBA4q65AA5CoghrXVa4bjcsJw+S
         VxTg==
X-Forwarded-Encrypted: i=1; AJvYcCXMvYRphD1b7KF5H7XP5qvv92I+QExaUmOOyvWMwSmu2TEh/kOoOzKJ+MqiYmJRgHw2Qq/HiYdQHiXo4w7lIl9uQERfozgk1U853AyY
X-Gm-Message-State: AOJu0Ywec5CxmHIQ4keZsL27mu5iHzRIL2vfdKV7uMSL6FPR22aqrWUd
	U0V7SICjSAo4vqJOCeJDo6qs0P8yf0bBk823zfHw03wTeVmCJKSV0TYHM72BS38=
X-Google-Smtp-Source: AGHT+IHxnrQko6bMf/91s2g4zUrV4qCF0nARcaQRjPnXGh4Cf4wtwgxL6djUSvJiKg5iDeosA00T2Q==
X-Received: by 2002:a7b:cb90:0:b0:421:2429:7e46 with SMTP id 5b1f17b1804b1-421562cd308mr16214735e9.13.1717575017021;
        Wed, 05 Jun 2024 01:10:17 -0700 (PDT)
Received: from [127.0.1.1] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421581490e5sm11025585e9.34.2024.06.05.01.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:10:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 05 Jun 2024 10:09:38 +0200
Subject: [PATCH v2 11/16] dt-bindings: clock: qcom,sc7280-dispcc: reference
 qcom,gcc.yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-dt-bindings-qcom-gcc-v2-11-f947b24f1283@linaro.org>
References: <20240605-dt-bindings-qcom-gcc-v2-0-f947b24f1283@linaro.org>
In-Reply-To: <20240605-dt-bindings-qcom-gcc-v2-0-f947b24f1283@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=kUWoTixLjB8NM25jgDQ+TcjXdSTW/JBRNzZSeTyTwjA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmYB1RAnULAv5TQg6LGQACCPyt4jjxN5Yqd0Ok6
 ZhfUjEI9TuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmAdUQAKCRDBN2bmhouD
 18/zD/4/8nMDYkGrl7F+4SH0pWMGLUHZIbGhAJCi1l9wommn1ekCs+tP/zyDdiMhv81/iPjUFh/
 3QhRRlmJFCmbjj0ReCH24GZcpE0UCa35Om2jr2iD4P3iY9j2mCPxPVgMOzuGI3tzuaWWLzYIiwx
 FLgeCUyajEyKBUi2SCt787MWc9aMDopGJfZ10rzJkrVIcc2KXO9KkrNE5uoKUN5R6FUwjr0wlDk
 txLxz+BSRCEa8UQuAXQmARRqYBdYSG6w5P3QPJx3qnHSoNK813jB0b+1KnnzEFWhygco62pZOAg
 Rt6hv9kk4ZMvdJ7YyTkjj/XUq2ejUoakZfAqsM2zIOx7hILA400kTFUWkzLooMyZW0sPhs8wQ0B
 VR5zLUpKMoI8+p6xioOz+0PJlxrptx0OuW0DGPT5DdDhOdI2vbigoa17uH3rwOIo4wVc6qXJCVB
 J3cq/Khj7c9xnGkzGILTVL570WeJs/NA3UDc0LvQ4miEUTiXoufgKdoR7CS1KsWmYZyY0n7DVVW
 tomQZ236ZGwN6HolI418MH7GWbug+r6ttxzVcYM9osUMXdt3TyTfRTCjHwFbxor5fEz7+6IIhe6
 7WkqE9Lk4oiLL8G72SYKZog9/BG5Kb6M847z/dRGhkxRJgtVZ8I1o4506yfrq5jjeDcp4GFAGSm
 HpYV/oix2cs1bpw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Just like most of Qualcomm clock controllers, we can reference common
qcom,gcc.yaml schema to unify the common parts of the binding.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,sc7280-dispcc.yaml           | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml
index c42b0ef61385..23177661be40 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml
@@ -41,28 +41,16 @@ properties:
       - const: edp_phy_pll_link_clk
       - const: edp_phy_pll_vco_div_clk
 
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
 required:
   - compatible
-  - reg
   - clocks
   - clock-names
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



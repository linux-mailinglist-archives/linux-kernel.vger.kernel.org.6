Return-Path: <linux-kernel+bounces-244314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E3F92A28F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F2A1F22819
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A4A82890;
	Mon,  8 Jul 2024 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/gIXr8W"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5CA81720
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441383; cv=none; b=p/DXFoPXJacE7Bq5h9JmED31O+ZS9RQKuuuhV1kOfD3lhMsqi7REk+V2jsFfPbeMv4j5o6M/+NQaRa/toSoYqwY6IQ8R4Xi2tyIG+3ghfkwfOqt6tatsGjBoOLtlXuEj19XRBYb78r3P8VHUVXVzFnObIswfF+plw8YxEp0h7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441383; c=relaxed/simple;
	bh=YS331u/IScHChATk8p7aL3JRzn+3f0/zhE16HH8SRSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eHSKjqStc95PFxMskrODcRi4Pz91CjFgnweGCHsMvGvTIeff+ZnnRdWzWIBqmI/GGzNq3goMkTadesH9WsdEKCPSBWnyV0H0lIgob3yM5gPU/xcJNxr10Gcrh4B9a5xYC1+J4pfQcEXRAf9FBfOl1kBDX1Yi/qo9HIWb5NLIbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M/gIXr8W; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6fd513f18bso363258266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 05:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720441380; x=1721046180; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuoGIEtLY+sG9K81klkUtIfsNH9bTZF+T0WBDkLiP+Y=;
        b=M/gIXr8WAFooNn7+uWmO8b2rRBTL4a7nYJmhoZUGMukLF9UfZ+sHiATOGF3z8Ykooq
         hCOs+FQyicG4eQIjFKd1JmB3WQUKwTN2DX4ySFgqEoELa4iKtWC4RPU6UKjO3eR2rfaO
         pI9m/qS9sK/GJ5KnT9rSckYd/2ffBTc5v5QN6UwHMhMdhmA2jt9TGonDAgQKUXWKzENv
         FGEvdLfdqETkgOzpEw9H1ilGJo6eYGUmdQoZ7ul0Yym3sQp2lWmvIPc1gKSeKxLyhiUD
         bXgfkIQX5nOqcRMPdkoDK8HN96X8IcH4kIKfx2RWF2Mp0wo51dGCam8ed+ImqPFsLwFF
         DNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441380; x=1721046180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuoGIEtLY+sG9K81klkUtIfsNH9bTZF+T0WBDkLiP+Y=;
        b=RQeOdhczAn3R38ONlqDU+2mVRsiXqoJ/2bV4gsU0d5EW+RiQ+P5+GMMGhzvj1yFwvX
         jDCkvjfvQGhRTSSQwQxiCDXio51k7zeBxfb8ECKQBnhW0321XbtV8uNNSM7UebvfUSQd
         GG8PZLvVK0nnW7AzTz7t8rM97kZEyehK3zs5ll0XMOvVFcLYLS/JdA7WmZzaBaAF+8aC
         V9acujdpk0Kffq9f97ZzN2sOzwy3DiXWowVIbLlNIOJFqxQoSkzBRyWXzm0+LLiLJ79R
         Ay2Wt1JNUwYVBVy6rFhQiN7CrG693+m8HaNhqWeqcrnVeSsefRvg000yumwiFpIF2nly
         acog==
X-Forwarded-Encrypted: i=1; AJvYcCVK80UDlwOXL2OYO/H89SaSQHxQHLgILtqPawggu7oVGlPYvYjkoUNo+NQf04Uxjg6B6+2k9pmmnCVf1fyWd3WWoVYwQSjF+9MziZqt
X-Gm-Message-State: AOJu0Yx8mZ1NXkp+OEHrW1ecX+ha8sVqvAYPp1bWCxPnc7pVzHj0jKmI
	MlLoov+gnyjPE3Ls0yUjTqiOkrX/4rVvqrUo9z4TRpUPU8kq6q/092bNIcmd6Ng=
X-Google-Smtp-Source: AGHT+IFsv0xnzPRSLt3WVV1W7Q5iYcFTyqb19d+OrVEXe8LFZ/SMKdneIgEa59nbjfQgeGZ1WzSZDQ==
X-Received: by 2002:a17:906:b11:b0:a77:db36:1ccc with SMTP id a640c23a62f3a-a77db361dbcmr561338666b.24.1720441380037;
        Mon, 08 Jul 2024 05:23:00 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77e52ccf19sm208983666b.147.2024.07.08.05.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 05:22:59 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 08 Jul 2024 14:22:33 +0200
Subject: [PATCH v15 02/10] dt-bindings: opp: v2-qcom-level: Document CPR3
 open/closed loop volt adjustment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-topic-cpr3h-v15-2-5bc8b8936489@linaro.org>
References: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
In-Reply-To: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Niklas Cassel <nks@flawful.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720441372; l=1573;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=YS331u/IScHChATk8p7aL3JRzn+3f0/zhE16HH8SRSg=;
 b=uNRqYMh/GkR9tuyunemDFYhU/xn9vIoAkwNKZTtZ5batuz+sXQqmlvlrnW0DwTRPo0MvR9slD
 8EjaugTz36YDu9o6x6nZj536R7z0ZkcUzz5gAvMEgu6ZL9IiR5sv1Kk
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

CPR3 and newer can be fed per-OPP voltage adjustment values for both
open- and closed-loop paths to make better decisions about settling
on the final voltage offset target. Document these properties.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/opp/opp-v2-qcom-level.yaml         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
index a30ef93213c0..b203ea01b17a 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
@@ -34,6 +34,20 @@ patternProperties:
         minItems: 1
         maxItems: 2
 
+      qcom,opp-cloop-vadj:
+        description: |
+          An array of per-thread values representing the closed-loop
+          voltage adjustment value associated with this OPP node.
+        $ref: /schemas/types.yaml#/definitions/int32-array
+        maxItems: 2
+
+      qcom,opp-oloop-vadj:
+        description: |
+          An array of per-thread values representing the open-loop
+          voltage adjustment value associated with this OPP node.
+        $ref: /schemas/types.yaml#/definitions/int32-array
+        maxItems: 2
+
     required:
       - opp-level
       - qcom,opp-fuse-level

-- 
2.45.2



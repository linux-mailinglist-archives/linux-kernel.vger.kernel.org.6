Return-Path: <linux-kernel+bounces-526002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3CBA3F89D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADC7703BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4971215051;
	Fri, 21 Feb 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="efBoMt0N"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D5215052
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151505; cv=none; b=lYMfGlo2Y8nxr8/R53kg9csazkP1Rqyxt3NtkcOymkV5YTTQjpWEMr5CyIiHlcWOsIxSuX93N0KPDrtu7dIerbfQiXNlIyH6MGlDpEwLh7hEyEDQkSFaJQE+g3NqzfKHooWtW7jsJvY6hwc3ETZAW+8WJiUz42ojm74p1XjrGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151505; c=relaxed/simple;
	bh=vM/Rhh3m/LDu1luem1JmpPvieCwNMZVHKpBxAm5wGsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGKUl7Y1/eKU8GcY26RG+rOjNrBa5l4FVkQIByFhyZSumOig86mBBEVrZsY55OXQdSujMagIm/35deBIxp8nWgEFx/WAvkAc5XGrPMbSXm0nqJV5DxrR49DyY2OFLtLPikf6MJP0530OP+hy5uXZRvCfar4U6FWMxft8YnS8gq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=efBoMt0N; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abc28af1ba4so3127166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740151502; x=1740756302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FX08Ji8HI3+KbtFLo37LoGENRgVWTP1rrMFXfNP52RU=;
        b=efBoMt0NLPT8jrQQfyVgmzP5oewRUdasxn12YU6jseLk/TE6SMVvhjyk5lkFVaYAgb
         K3YWIvnZ6l8/dk+xvWHu3ibPkYypp7eBWgy0nqWeXWZSv4eVb2glnkafCiwrWdOnH+2s
         Hd8FaiMn/Ym0XBD4x1Ii71N4CMl3AcCV+fpzuGhH5SLjd68RLiDVw+TJHSMh5ld1zaUD
         5QXdltpK5kLDIDgJEyJLE0xUGaMxtfoF5My0iHv5zySqZrOs14GwxMTDvAODeUVWadsO
         VrS/l5EcD4EkuvISBfZwNCLql2m3NNNGJVO4NOEqoetg7IhiD0gkK9iPZWtZ3UkNYWzC
         n1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740151502; x=1740756302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FX08Ji8HI3+KbtFLo37LoGENRgVWTP1rrMFXfNP52RU=;
        b=UDU9KO0qsZBFwp6cSOqmLXPVvXgsR3P26GRqQX3T60HY2BdDAET39Q33hgHpZOKW+t
         SzLYcgg195z4MeExZN9uyT0vtnlOcM3/8cmGGUKVBafgPxpNqMG7Jl0+b0He/Z/8Gw3i
         Nww0v6MpnjT+2BBZWtRDxKLaIgBRwnpoOVH+zfI6KToKyPOD4B3fe8Pi/OEUEVWN1xEb
         ZSWze7QjAsd2mI1VDtRFKrA15GWZ3yMNfzB+RYODwnfMUZEOswK2qjjQu3UMMCkiSbXZ
         FysUsTitocNY+3peIR8Sxv1f+sAvSQZ7xBYDaDKPn28lznPH6pXuSO+V/TfEYJRX1qV2
         uwHA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ47oEEkOuNsaTr7+xTxR2n4xMd4lDVOEaevNAPeen6VotBs2CwuWd4gdF18uTzJ6JA/+om3hkia8YS6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJgCZ1hnBWtopOX/ic/WARykFJDklaqfNc1EZdkPUzdhNw8uW
	2/F5chFURTs9hiBhCIOSvIVbuWa0BhxIwId2SKfXkYNnrgiYJ+wGc9/pgFWG3cU=
X-Gm-Gg: ASbGncsQSgDulXLgwQl86u1meaPEqQwwY8pLuM2gOmlrlXPYh81HXyLPCC9SXg6fXXL
	wIh/PZ0W0x76uD4TdHPkLVPsh9QYPK4SQIMZqTR5tIbINeJDNmu9WypHexRc5aSxBoJWLICUbby
	V8iqm6uDJIGZxiupgQPaeWV20UIP2rWhDHPGYjPplWlXCtZQlmtpg4N+yz/Y2KQCozejPhUBW5Y
	1yJC+iD51vi39yRmjEw0oZhgdKBmpf2KoAveWK9F6HDs4GU0Lw1yehGB5C/Dq7sFevvExS+MK6o
	CyUQO/z+spJdqxbcjjuDq18W1JGkrwTW1GK82ZtdQtdk32KVM7eYm/Am2Bzs4YELVa3YEFL2Mny
	H
X-Google-Smtp-Source: AGHT+IF8JcIcNLGFatnCq0HaW0NuMPpymfwFQbEEmh3gv2V8ShCQQ5aDqao2hSWR/5S30IuJoRYTIg==
X-Received: by 2002:a17:907:3d8e:b0:ab3:2719:ca30 with SMTP id a640c23a62f3a-abc09bcce60mr159917666b.10.1740151502274;
        Fri, 21 Feb 2025 07:25:02 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbaa56026fsm865456666b.113.2025.02.21.07.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:25:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 21 Feb 2025 16:24:16 +0100
Subject: [PATCH v3 06/21] dt-bindings: display/msm: qcom,sm8650-dpu: Add
 SM8750
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-b4-sm8750-display-v3-6-3ea95b1630ea@linaro.org>
References: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
In-Reply-To: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Clark <robdclark@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=943;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vM/Rhh3m/LDu1luem1JmpPvieCwNMZVHKpBxAm5wGsQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnuJqxZqvLkS7Sm+pYTmPzyxyD1ah6V8UqL7LVk
 Al+B54YAxOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7iasQAKCRDBN2bmhouD
 14yRD/4hpTeve5G8gpNhRpsfE3K2tTI8bAm17okgIjLbmJY23bAm77DYOU+IcwU5VTIX+1ULQ36
 WayQMxJNrIp79EZQpLnwa2CIqN3/GP6Cts43HcA9M6kgu+nZ82zRLxEpGbMmCbvd71nR77S9KC1
 kH12EHfJAQ3FFbBkjgIdIo9of80KkfXoJjpefixITeHLMUpjekpCfupRGWzaRYEXIVW2ngfEVSG
 o6eifaDoXymOLra2l7sUZgsyv8Skk4lU/VowYgPq5KjHjmzWBVuR8vXNEbLUp0YZv7B3RAlD6vO
 4rIoqo6kBn9CLIRydM/lJmAHyXWtCCbGQLOtvNEMH7CQmok/ZZF9UAAn9EMYHY60tXSh0JiNvDQ
 FkkysUSPmNQ8nJd0wOBZg2I9C80uQyoe7EQL3DGrXKZbM5MD4tBfh0PVNjoiCtNeYFPpNaq3yqY
 8u68VBeehIKcpHPcgZe1JXmfdmsM7/172jbTkkISwcf6K88rGd6BqtpnDWFnr/0zpDH985s36TM
 CBx4LpwdSq77hY2BfPpmHUaGSu5dOgpxujzk7poef1twZJ5TBbP6M2FXQ1cLkspEjddfVe5hRwD
 c7qYE7zzyigGubfK58FbKxzyy2azap7z/epPZ7eEM1um62pbzqAHnx4/DnvN1VdnubRkLFSz0Jx
 BbN0FwMN1cttThw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add DPU for Qualcomm SM8750 SoC which has several differences, new
blocks and changes in registers, making it incompatible with SM8650.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index 01cf79bd754b491349c52c5aef49ba06e835d0bf..0a46120dd8680371ed031f7773859716f49c3aa1 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -16,6 +16,7 @@ properties:
     enum:
       - qcom,sa8775p-dpu
       - qcom,sm8650-dpu
+      - qcom,sm8750-dpu
       - qcom,x1e80100-dpu
 
   reg:

-- 
2.43.0



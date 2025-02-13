Return-Path: <linux-kernel+bounces-513447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BBEA34A62
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF8618983AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA162266B7A;
	Thu, 13 Feb 2025 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w7LwYRK+"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68DE242922
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464089; cv=none; b=VFWAfUfVt0ydXydK46TbDyzGz5qbetODxJeunBg3l/JrjKf4u8Oa644gLkzG+6ObtpY7V+UyWkeVb5wRNQLvI48j7RYRx/ZiGFKE37ibW31HYlRE/SiRiGRyowEJRbTZbExXovwq7Z/1h/Vs3rba/qpi4MS76Y3T1q8YFFuKwZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464089; c=relaxed/simple;
	bh=my+RB9Jrip9aPGRvZHAD/1/UpXRs0+h6VzBYQ3PsJO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nmYZMki+Xde8d5ljq7Uem0rAcSR29Akjj/O71B4zB+DsHghfCusvQUq4LxuXljBOaIVJdb0UkZ/VgoZ5kNIHw0rYHqpU/4CXIN9eWHMgZ3tpGkwBLcR/2jCecN1FAW1uiC+nkZF+2ycR4FgZxGfr+IWgohWPMtSTHAWuZRCdRtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w7LwYRK+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38dc1dfd9f2so873415f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464086; x=1740068886; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDc93kMEYWIE43KW8M1DQx0zrLSt7yqt1TtwJm30k9Y=;
        b=w7LwYRK+uXZAOyPIid0n7u7N1ejfpPwANfXf9ElIZF6rZS31Mr48Ep0y75Oa0owNRF
         hP1ecq7c2iAKEphQOilQGgI9nGtOWGIdhnUlIr6uKMUU7YvjQUdh6V6GjZ5Owji8j/gl
         bhtYLJyGo9sFieE7pn++2gciuoadPAK6SBk7cL7v3uHjiMtQp8r5kmv7pKYkp/uN8tF5
         /N63LIf7NZ4dpi/kteZplOpxD5pMc7xSgMU3eagZprbLjrDjNbPsZ778mM4NJ9nPZycz
         y9DKDWTb2dKoUdb/95LQ7Acu5hd9OzZRJGIEhgovNXl+ceOXkusQr3dkH+xXP4VL15td
         E4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464086; x=1740068886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDc93kMEYWIE43KW8M1DQx0zrLSt7yqt1TtwJm30k9Y=;
        b=fhHkik8SDWvNhH/ngRmjpNPhCbJA0Y2Q2Vx1/6/qsARYgACAzBZzLzEgWtur6hj7+c
         l8hhI1BL3prHZ6wZr1OJkCXdJQtoZseyy2K7a3F966VeF5hnYL9Vj96Pl5mR1o2uEj+y
         aXdArjEFnrhaDyX9wGEHwOGGIPqzRDZ2vhnKIAF1psiQPsUwWKiXfl4UDi+i55zgYOxx
         Ccwt/X/EESx5zzdx34cGChbnwaCn+f2C2Hk4/LE+wp9utScWyr6HtFKCA0CDbRGXIVMy
         mwL7l28zBu6mAw0OIxzH/KdGJzlFlf8jAlx1iCgvwS0+WWj/UvKHfGRmgsRSB+bDUJeY
         RumQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSalEspnpQvDK9vfydA41JVcPgIJsSUpkr9hrfmiCHstL8MmU4B+l1UiYAjtgI8Zf6o5ngvGz/B+YrCv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGhCZvath5nlcDX5pu2l5N89eg17yirc4FMMj0eX8uTUp1hP7u
	WP+X2ab2o9B2Q4SvGUbMCB+wa7gAQ7g1wof6bIUI1BwgDLwtcMn0jo0uNbRuNsI=
X-Gm-Gg: ASbGncu4Nj2ZQSwvCdshR+YdoU1vGmeYNHPOqo4+DsRtajpTzA8iMDZ+FIfvXgbtci3
	TRV4YH22yaA2POpPFbJCa2QBIFa5Y+c+A9cgBVOJP/J65GeYAu9w8J1f440QTnFMzwI9fS9eYYP
	K04GFlu3JofTzes7PECYrwelNcm1tYuonN7onKbrcznytXzTACaFMdQGWT7lnFoVETEix0RB87Y
	Xtoh1BJUgceRC1efy1b9bkilzvivdC0m18pOqQPI0Hl8iNcSa8pJnbD29vSY8xa0jVlmuURqnPR
	qpj3oL0H7vIf7eY4rmU7YhLKnH2OtSBa6/pO
X-Google-Smtp-Source: AGHT+IFU/9Ezw9WpHOEwKFHI3agr//zJrArAr/XSAw2dHqAeOMUzEQHlgonTqcBFZjTTclKxtAjURw==
X-Received: by 2002:a05:6000:186d:b0:38d:dffc:c134 with SMTP id ffacd0b85a97d-38dea2eb4bfmr8227417f8f.39.1739464085999;
        Thu, 13 Feb 2025 08:28:05 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b412esm2274382f8f.1.2025.02.13.08.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:28:05 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 13 Feb 2025 17:27:59 +0100
Subject: [PATCH v4 4/4] arm64: dts: qcom: sm8650: add missing cpu-cfg
 interconnect path in the mdss node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-topic-sm8x50-mdss-interconnect-bindings-fix-v4-4-3fa0bc42dd38@linaro.org>
References: <20250213-topic-sm8x50-mdss-interconnect-bindings-fix-v4-0-3fa0bc42dd38@linaro.org>
In-Reply-To: <20250213-topic-sm8x50-mdss-interconnect-bindings-fix-v4-0-3fa0bc42dd38@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=my+RB9Jrip9aPGRvZHAD/1/UpXRs0+h6VzBYQ3PsJO4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnrh2RyIwuxEyQJnCqN4BQzwBgsz22oIe5p3/foBpN
 3ycZJKeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ64dkQAKCRB33NvayMhJ0Z4JD/
 9QWqppUyEnVCwdINgX9VFB0i8zoyuyZeu6IuDCoC9ZEqWoOs8NkpPN3ASdQr13S8PSIYLl377Y1oyp
 5eeA6/WQAaEysK6t2aXfsQ3/ReD0a5Ac3DdRrNmleh6ZlEeaU0+AmQIoTygKbsAwZPRni9ZA9K98fl
 /NQ8weA+fwoAs+dY4XyM1Mh3m1kA/oq27fC/jiAe8K4S3OS2WaLDRZ3B0SmJMkY82b2fjv73YjqBRV
 3htFOiOZTllEcFeMvAT7w+fE13umvRgT/kXrTsnd36VAvyDaZFltGUz6ymHB4kJVzytzc0UwLEMDmL
 E4z5cc4mtjo6iEE2Xlc0uY3OQz9pQ/Ni6m4RckyzTQ2ZackPXKh8WuINx/IwLSGFtY4K6i7OgB+YlV
 49QaGlZgn4Ns7+BI/r8wuaAZHnijxZ17M1a0871JFon21oS/3XOfIDj+PIqVQH9bWGnV1erkdHce7R
 XJK8ffMPB/BQitgVl+Mm3J4mGbVgoTgfO9yjSi3fsoejYJGmspR9wnA5mDszU6zgeLiqYpeOD+hPSy
 hlcMhtnhos8K5RDwdhWfZ7yj/fYr9K4Rv5hxb8jbgxyLbaBMVqXVI6MgSA1Ya5MJnGDI/7uioYE4wW
 GTZlXhTPjsoFcf9wfs4Ga5/nJ/HJjdfx/ymjSsOzPSybrYUrT5wB+dYZxK6w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The bindings requires the mdp0-mem and the cpu-cfg interconnect path,
add the missing cpu-cfg path to fix the dtbs check error.

Fixes: 9fa33cbca3d2 ("arm64: dts: qcom: sm8650: correct MDSS interconnects")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 483ae63e6032823e8cc13e8aeb6db70e3948f02d..1737265d364601494c329e79174c082c98e4d0ec 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -3997,8 +3997,11 @@ mdss: display-subsystem@ae00000 {
 			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
 
 			interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_ALWAYS
-					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
-			interconnect-names = "mdp0-mem";
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "mdp0-mem",
+					     "cpu-cfg";
 
 			power-domains = <&dispcc MDSS_GDSC>;
 

-- 
2.34.1



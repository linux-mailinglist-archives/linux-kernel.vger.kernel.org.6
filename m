Return-Path: <linux-kernel+bounces-513446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97ADA34A21
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E337B7A3FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9772698BB;
	Thu, 13 Feb 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L5nOpMV1"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BED266B75
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464089; cv=none; b=C5s1OYWwcHPkMXwuzK/szqJ/TIywcyX5U84S48gKljt6wA+j3HzHylFg+IZEBy4Gp1hJkOva2jXkdXKBInRUfaTaANuSVrngsQeTpF3KAI7xGH9z6hEoRLaauhuCHWj+X8gxfDkShwGnRPJZNk69vOBg98dUYMQH1F2mG6KzRiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464089; c=relaxed/simple;
	bh=B+nNvYhySNexLKydqT7QpvKu738di2JmZvO+HTQoLr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mDchMHhez5kT1qRvBJu8/o1930uhX1Zdo+U70cVv51z07qNxjsy6V9epuqPf3dCcjU4aQ7M5YC1fOYGFkISFINLoisE83QOUMkTo6nWiFd5IVi9w838r1pRMAlVpavCQ3xVSko3lGqonOs6aa/9qcGyLLRkkyhoZoWSAKWMee04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L5nOpMV1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38dd9b3419cso590515f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464085; x=1740068885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gMAdHe9nCOW/Day5SH2O4Yeg0Jtw2UhdUPrNQzwgmM=;
        b=L5nOpMV1N7jl+sqQHNvVQvortYvWJ98OpE9sqDycbBkug2ynlGAokyrY8W8l0tnTOn
         uoSgbGHle2br9psEvR3dSPPgQOEoTZCTzz+O0B9X9PmI0QnoEYCjAXow18dZIggs4Ly8
         H/fWuLnHMjyuVVRoIw7HiBE2CgTELaNxRuhB+cYUEJOvw95z6ftqs6tHtYd5Fpb/Mr5c
         wPjimZNwtk8JbAVLBf+RGoZESt1sg3GFa69O3AOiDveOpBcHlOdY9BvT/fOAqNmJ8AHA
         OL3sRXAiqTXG9UKVZ+qPKxo/1ddCdEYtEL7DvfplXCJLWOfSFh125Y8AU97oDbSlX8uG
         Fzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464085; x=1740068885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gMAdHe9nCOW/Day5SH2O4Yeg0Jtw2UhdUPrNQzwgmM=;
        b=aXpPWkV/wb+xAerUDAyoiJBX2f41LWPkST8qud+xWp2xAWKODKJk25GFxfRYldDRWl
         Uh/TMj6eE0TA/8/UJIO63booOKOcEuAVIFiBf8mmAg/UAg9+OA6NpieOWGqP95j+gGg8
         tMIoFTDRZdEF7dC6wKDfnoiKqzW7SiBqK/ljVfWUtgYDtluTIYIAztfn4FOaftkcS8Fk
         XOJxrqfOoc09taTROh68DFw438bjJ6jQ+PJo/xtbr3df5fiaNQ3VU4pCE6+DDcb/o0ei
         fKKYKe4bcb12S/n4cAQMNDztKNFIKANfYm+KuQ9DGmoNr4FCNPosfeCaDsoMtMI8pZWP
         jM0A==
X-Forwarded-Encrypted: i=1; AJvYcCVWz6IkMvZ1AN41yHL0tIwm4an+xzmHDn7SJgT1OnVQVzKqKIsA1Eiz61SEMDcm6nT1JPkld2kuY68Wnu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNfV4aC2KFlV4TpChxNXxj2j0lpysng1SWFSZJxHViXPqhGXGY
	+AyY7Zf9syXeC/yHKH9SsdJCZn8McoBRK26b4kZ/T5Mt0FsUcB7GER+gKK24HVY=
X-Gm-Gg: ASbGncs5dqfZp5+efRpD7TfypsfRCdzponvfSAzy7coy3N8c2ht/lKqpph15NvHqqFC
	OFSy1XCQ9h8+LLXksosabc/EovCR1gdUD90uMH5gM6ZVCCd6fJR8c/Yw9OMOpccG2lu8rUuoCj9
	L8u/Qp6Iz/Nv9m+BzBSUDKgWMZMVWJ5kGB+QeZmqdPKoyiHCBJOtGHSM4hrHywXUggLYt/Re0Sq
	m2bTHqSYfjlXYbM0h1F22wC1PWq3ZNILYjfqEL40sByEeSiWNhPw2cTVJHmyLsAvDTczMw3SLK/
	LkZQzMESsNwMom9Jr6JLExODyKESw8hDGu7Y
X-Google-Smtp-Source: AGHT+IFN783jsD0vQkyJDEQHVJ4b5BYNJDAUaJFST4P5psjOInvt96maC/O+1aofJniD9funT8GdTg==
X-Received: by 2002:a5d:514e:0:b0:38d:c771:1a21 with SMTP id ffacd0b85a97d-38dea6047abmr6092021f8f.50.1739464085106;
        Thu, 13 Feb 2025 08:28:05 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b412esm2274382f8f.1.2025.02.13.08.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:28:04 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 13 Feb 2025 17:27:58 +0100
Subject: [PATCH v4 3/4] arm64: dts: qcom: sm8550: add missing cpu-cfg
 interconnect path in the mdss node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-topic-sm8x50-mdss-interconnect-bindings-fix-v4-3-3fa0bc42dd38@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=B+nNvYhySNexLKydqT7QpvKu738di2JmZvO+HTQoLr8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnrh2QZVA90nkLoZwErzoHAU28/LMQBUONhlSRd8mm
 +v9RaryJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ64dkAAKCRB33NvayMhJ0STcD/
 0VPlaHGL4tFkrxQcs22SwBCAgnmP5Gz/6xQZ2K+9Op90he/hQGUDx8o0iUnBMgtYHmoQUuWFynRzP6
 b4LJEbEdID3qff7+XGtOTKMoOIScpX6Ms7puODsLDyUe7uy/140wZ+jfH4p0UUOMaKyHZL1voUD8os
 fryMG37r66Da9Ks7u3JTI7jBNZT1jZC84/XN2T/qn7QVqBlCQabfuYIp4eNp+L9dsvVNZIQgO4UYFb
 uAVMeTqc5MmI9PTUNhFBHrsf+rCl/4U0JwmRBpmUA1jE4KEaELb71SpJLcxCv6D9yjXdBQnVw2SCNr
 Wtcts6oSJaD7jUE52JSwk680GaCtZbAabuPBGa4o5PGV80X04dPfUwe7nypRudYC0QBcPUN/HpGL9g
 W6E9FdgA7oHYMh2lv6OpzwqP+Qp2V1DIpmp9AgYeApwAGfEMqi/4z5/B37YymORg0MhTJh9Ur0Mi8i
 ozMbHBR9ysNH316HeD4bxeYYj+Z5ucqdPWYTidrqONzNutQxnr4qh7rgqRzu1hhkAPbjSswOg0NJ//
 JXeO/EP5HlYRQE+BSorlRBevO+L3QDcDC5gzshdDrwMLZRWI/5VndDG/Vtxi5rjfE/rm4z9DyUAwNd
 k3iRf9VhXTSCjtOTFtteqD1FebR1E1l16cuaZhgIciLFImeCg7RsJRmDdVIA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The bindings requires the mdp0-mem and the cpu-cfg interconnect path,
add the missing cpu-cfg path to fix the dtbs check error.

Fixes: b8591df49cde ("arm64: dts: qcom: sm8550: correct MDSS interconnects")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d02d80d731b9a8746655af6da236307760a8f662..18bcb4ac6bd8433a0f10f4826f4c6958444c080f 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3355,8 +3355,10 @@ mdss: display-subsystem@ae00000 {
 			power-domains = <&dispcc MDSS_GDSC>;
 
 			interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_ALWAYS
-					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
-			interconnect-names = "mdp0-mem";
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "mdp0-mem", "cpu-cfg";
 
 			iommus = <&apps_smmu 0x1c00 0x2>;
 

-- 
2.34.1



Return-Path: <linux-kernel+bounces-226404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8867F913DF0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD482813ED
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 20:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7E31850B7;
	Sun, 23 Jun 2024 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nkSmZ0oy"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABEF185E7B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719173014; cv=none; b=C8ieUPW7AGU/NBgVVGDDUXGAcJ+C04/H486d2UCMDR+t6NgT9JQE1M5OGZszdvTvkJKc0MZ16VdoopyQyGerd64hrGeLsGU4Z4ULNK66g23N5Tlxg10Xfs9eFM0Tkn4Rz0H55rY7QHQaoA4ywfHsayV4zuJYBIo2iapsYXbqGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719173014; c=relaxed/simple;
	bh=uYQQZshlwOKHfwbC3/MKr6ThTNfJ0nfXfyifQvYX5aw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mPxAI5ayxWNqcR7pw6X27jxfx+Zdc1V2HqdsdSQnLpF8R7/usZOz2JW10kcudRPVcTJxdrTu5LqSU0KlW52nsxTjw0lRnUGFXJTP73tLLTdoXREra3F+Ip2xT4nUowf0t0W2Rt2VKx2LVlnQOzil/HfUr/vecm4E5WqKNGu8Xc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nkSmZ0oy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so20924725e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719173011; x=1719777811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ow/UhD/hlWMO1wQnP7yw4KEZ9Zhh7chAKMjsQ2L54M=;
        b=nkSmZ0oyXO8mlQyHxhT6RnBu2203ZHg2TZjOVe7UeIFH1BfRHHDeML/DPDiFL1cIpk
         qC/oLUY6HTsCrjGSpps1qnH0ryk1JXUDrbhzbGWG5zusBOYsW66/pSp9yBgubKiV71jY
         9XBcqn1Gn+TzmSPCwdOXrgFaFKhUjYeqoKoczxrhl6Q5C+qw1DDvJRGey5cYnyZpn2an
         Y+nfjkhHHn3V7n8jlbl04bjS1k+7f9pFAETNNajXyq+Gm8uBA8xHuD7f7gIWOWBXg+AI
         oIS2nqVLgi1sbdOmM7dh/WnHyv77EWyD8Ax89mjHJ5opCGgtlNk1/KrOPfdy3eeOw3CR
         p2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719173011; x=1719777811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ow/UhD/hlWMO1wQnP7yw4KEZ9Zhh7chAKMjsQ2L54M=;
        b=Zn48TYdpSwNL8HOE1dWunHq0Pg5TpzOxlRH+Biaz2/kRNX5MjS2rL3IZ2fdHZz8pIw
         Ll0lxWSG2VAWzMJCrXiQCjMDxhgzGBgEQnlgQvJMQI3iWHEhb1fWl0Z2xbaqyrKbviIa
         VVAZ6tlS7jinojp9qu7RyayjUhu/OhEqXp4zYft54IPCLiz8SQOZlTGGK/i+3za8lLkW
         ZyfpXHWOmp1YZRh27CHhRZaVbi3Awcr3kMNvFxCpR3N+xwEzVMUiumnw+3kI05jUgcWC
         az3UgApm7FpHnM+IuQQoqeIKlRN7yrqCdjm8O2Xc/wQ3SpI1bfuCqMdTuvTu8v+NpGb6
         LXzg==
X-Forwarded-Encrypted: i=1; AJvYcCWLWfIxkgUGJpqcBYFXxBfr2iSyx0UdTlKALuRvVtQaXfeiREOvJrBHVPvVDu4Z1r6+g+s73f02oqpkrkWApliBged94G969AZYp6Dd
X-Gm-Message-State: AOJu0Yw+J+ZC0hh7IjX/Ttb67138+vWHB5qJifsnaEDDAXsH+y4irv02
	gti4hmYSRklf5GtLTQWdx4zW9X+MnrJliLKjsqWm4Mjv6ZWOpanNGoh7Umlxk6Lr67grYjwiZEL
	S
X-Google-Smtp-Source: AGHT+IHrrG07tlhKq0T0Q79qbLjtMFRHlvGdVpaV7mYi8SG2IESOG+UD+fskJ99LX6kwwDcvImU8NA==
X-Received: by 2002:a05:600c:511a:b0:421:b906:8088 with SMTP id 5b1f17b1804b1-4248932858fmr38166325e9.0.1719173011286;
        Sun, 23 Jun 2024 13:03:31 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c54c9sm150685345e9.27.2024.06.23.13.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 13:03:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 23 Jun 2024 22:03:03 +0200
Subject: [PATCH v2 4/4] dt-bindings: display/msm/gpu: fix the schema being
 not applied
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-qcom-adreno-dts-bindings-driver-v2-4-9496410de992@linaro.org>
References: <20240623-qcom-adreno-dts-bindings-driver-v2-0-9496410de992@linaro.org>
In-Reply-To: <20240623-qcom-adreno-dts-bindings-driver-v2-0-9496410de992@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=uYQQZshlwOKHfwbC3/MKr6ThTNfJ0nfXfyifQvYX5aw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmeH+JCn5CmF8odDAYUWyh3ZfkGfRdXyfcRPrJC
 IUygQKvOO+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZnh/iQAKCRDBN2bmhouD
 1+3WD/44hZ2+Ejzsx7aMXg7D/6Ygl8Izp702yxIeltA13k0IeWn+kA+5s2BTVil3rTgt/eg87Ow
 pNEQEF2kPTwsKyWTK0Bwbx7IK3JSLwM3aO2Uj1616luFBxWM9iVZwbuzBB+QTZi9EkOA2kLNKqb
 cbaBPJnQanCj2mWNljqDNzqTdKI7jQz//kb3+lwgiyUUQAdlyJ8ADEWhIyzi7UMdJ/zxtPkOkM5
 o5HLek/GG/EHEUbmwfDVCbf5pY8hvvSN+67LfWH4bVhHuwWohjw9HyJZtKgsYGML1sgywvSxW9v
 pNp+lTs5c9YNRSZthyT/h3WaAM/l/8Jtn9jappiCgUVs9GZr3A8O2wt+8d7HhSWZC9d17JCVzVp
 Uop25wBsZd/YFGz8kpUcbhfkWl+1Sv4th0n+VRnKamr2a0s8sxRssNagsSIeqb89dUgxhDexXbA
 zeNwrh9uuRvimJXbSgDGsYEYUo1ElgfTAz+pMCwNEliycnK3lhhIVswP4dIIT4iAKHHO/CLldnn
 pO5RPMxBKYpHl5w9i+Y2uEG1JM7h/5AxcWKzmfhY4pnSrEBqnhcjS0YShfrTBOzjmXZebLKO3qR
 jmrwZayAczdOZrTwDuHNN7p4irlhLZqBNytEjqQJVghirPOHu/Erx6xpbOtHu7zanf/Q9sP8Xss
 vcRgKjFhttepKyw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

dtschema v2024.4, v2024.5 and maybe earlier do not select device nodes for
given binding validation if the schema contains compatible list with
pattern and a const fallback.  This leads to binding being a no-op - not
being applied at all.  Issue should be fixed in the dtschema but for now
add a work-around do the binding can be used against DTS validation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This will uncover issues with DTS, which is expected and fixed in:
1. Incorrect AMD compatible:
   https://lore.kernel.org/linux-arm-msm/20240623193420.333735-1-krzysztof.kozlowski@linaro.org/T/#t

2. alwayson clock:
   https://lore.kernel.org/linux-arm-msm/20240121194221.13513-6-a39.skl@gmail.com/
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index 03aaced1abda..6ddc72fd85b0 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -10,6 +10,18 @@ title: Adreno or Snapdragon GPUs
 maintainers:
   - Rob Clark <robdclark@gmail.com>
 
+# dtschema does not select nodes based on pattern+const, so add custom select
+# as a work-around:
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - qcom,adreno
+          - amd,imageon
+  required:
+    - compatible
+
 properties:
   compatible:
     oneOf:

-- 
2.43.0



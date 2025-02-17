Return-Path: <linux-kernel+bounces-518082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4D8A389BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 374A37A23F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E678D225790;
	Mon, 17 Feb 2025 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAQXYcuz"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53400225794
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810511; cv=none; b=KuMEf+UI8GLQbJT9gyRCZv52o0DgDPabDpZ0BWj7S4aSPuY39SzwOtGfeOJV10BP/dQseofahtjSwHKUHnE++QK5JfRVqTdhLTqiSS30uoxVqzPzUPr0RrAsAokCS2pLBw5WiZkk1xlxCJq5zW/wutY/fK/O6QV2pJ5XVMdscrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810511; c=relaxed/simple;
	bh=wf+CuC28ypTqu4EQD5hdI+GDr7Fn9S7Y7CIcU8MS5oE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J64Z2R3EHJnzgbtYfaX1FxC60qKf+hpuFjaMB7mxVfKqaA4niU2ZVUJwtJvpeRxJSkEbeJoYylvX+T0qMIAT/mT7oczkqN0CVObQuWwQjxleog9UEO/KNIaxNS8IFc1pAWrq5N5k7L6cIIodEqOWd4xBx12Wdn1ewElI6AcnSl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YAQXYcuz; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e064eff5daso94891a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739810507; x=1740415307; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+5aoDlUUPJ10rJqXrmf7ktYiK86nyUI9p9lZazil40=;
        b=YAQXYcuzK3d3zcIy4adFGxBrL986+c9Q7UIL6hV7Y3x3PnbCAK+juh5ApHK8zXawct
         wm+CtKToK6Zw/xemDsDiwH1R2oi7netAaWM6vyhwT94zID3PuukUIqsgy5LChhGc7IUe
         7Xi05+7uoBVkrtGlvk/UM2Zc3oxM2QTDkOHAyMfhMoHf0FmR0sB+QJ9KSFqDWKsXpi1r
         vWrqDkYDdCjhvjJS5rLGFKHYhwBItmG6k97T1eE8YStP43w6eNkoXmKykoul+81iIdWL
         HeCIXUT5+qUWcrbpoImxvmK6Vs33WwdwlQErhWash0wKxypbLlquHecVGtx2byOB4zC4
         /6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810507; x=1740415307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+5aoDlUUPJ10rJqXrmf7ktYiK86nyUI9p9lZazil40=;
        b=Anxaug/2Sgp/44dR0Bn4Tyq6tWSdiamfse5mJELVFnrL0IHlLqGw+JYgcQOkEcPfMH
         wQfuX9dvZ98CT6/AHiqjjcmMDc1zAHUkN/RicmF8jsl/A5G16gZMk+i9/DTHY+N6w4/S
         30l9C4OhRgOUPWGM9AWrKWjmlsOEW44E9+qzac1XYOz9WMOz1TBK9xNcTfOtxKKiz1Mh
         wh2k7UMic6jGsrsMiJjdEqz063t8jKsQoShTJu5PLfGX9hI6qm+0K3G83UEPTAMJdN84
         /lKMRJGFFRw/c7qILJ2um3bIgQFZm3BhwlQyKQkIFrHjWg7JJrTwJRVR1k2NEYgR/tfq
         ATeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKAVbzILJ8LoYQg4lTdtGLwYCBa8s0IPc/ZUkq6aquu7eA6EEHerMrLz/QGth3E2a1QhY9rI5jkblO440=@vger.kernel.org
X-Gm-Message-State: AOJu0YziMXt7ji6fFuuRQCLwBxphENOPecqRaAX4ZEo23KNLa2JY7pFi
	cG8MV+zy/HxYaUd1nsKVYaPFDUWhVsHRNVDJYzSOisOynub7K9FLWn88sETUTP8=
X-Gm-Gg: ASbGncsR0ecnody57AOoV/IIordVJHXHfQU3rsEHRoJwla/06Bm/XoUx1HNa4wjGtCY
	NmLXA08yseZ+H/xfddgilYbFOlH6N6run+GNb+j8VFRkwLY7SWO3APQKNyKSd+xtAMeR34k5rJW
	srKFA1OTnC2fNsJSFxy9ihKG6k/niSAamHKmSyyp+saMh8IdZUriDkS6SkYz33qcmkrA0zskrIP
	/y2tYxtYnVa8yc8i3HAJUQjcfIBc1Zvyx5wYjRPDxpc1CBKDmVfal25Vk3V9n4LhxQxiUpR3cyp
	q8LoWPgEYEo4+NcWCQtyfoScs3XxPEs=
X-Google-Smtp-Source: AGHT+IHRBktJ2CMWFcJl7zTzhiegmw14O+ej0MwM1UHqZCG86dEftz5Cx0FG4ED7AqXi7Fd5goBe5g==
X-Received: by 2002:a05:6402:5254:b0:5de:b604:355e with SMTP id 4fb4d7f45d1cf-5e0361b8ac9mr3287589a12.8.1739810507589;
        Mon, 17 Feb 2025 08:41:47 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbac781b78sm82647966b.60.2025.02.17.08.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:41:47 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 17 Feb 2025 17:41:23 +0100
Subject: [PATCH v2 02/16] dt-bindings: display/msm: dsi-controller-main:
 Add missing minItems
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-b4-sm8750-display-v2-2-d201dcdda6a4@linaro.org>
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
In-Reply-To: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
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
 Srini Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=wf+CuC28ypTqu4EQD5hdI+GDr7Fn9S7Y7CIcU8MS5oE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBns2a4hP1oKS+5fk1zOVCpOHjK18I1sB8j5kDHF
 64DS60m7cOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7NmuAAKCRDBN2bmhouD
 16czD/47KDXygwBuqAB7VjF3Nql/EcBgYmDNCQH4Vs9GqJpR/YCiOStKlTsIY6A1WCHPP2arpML
 ojcquVoxXC8dRFfPRP/YjI7pLQBU4oKV9C9P/cfdWSS7uKCjKp0hlfhnlJ1rYVc9ekvDTgu0egr
 FqMKaiUncDx00ORd4/IYAAJIrtfJYsmEd7MlC079iIJDd5JxwTiRvoo/5p6AJOWRQho+aIkPje9
 BVzoCrWGm+ZcqMErfsYTVSJpgjHY/Vf1sDl17MFejYyEXPo1VcQyNNblxsrZ2NwghOgXsItXXIC
 ltZuyEsoG3n+eisguigZElJqHvSBU/+btT+qDZOlP609DaYmw0wjDPl7hG80perADV0fhnocOJX
 /LI8FnN42wi3zxxhX55/ZkhX9eCzKB977V+pbOMiJeBxZBBPKXkEKdL15BIK9UzL9oT0KFDtN3u
 QcptUq2QZANSehzBqMJEQhDCW/4J642FUT6UZKYT6eOB4LVvXnSTFvK72KVohvYqkoOXARq2FMd
 GFHIqugLpTSp3EmuaUgA30u1gI80jpK+9X95fL37bTZLkp/ptIAPRcVp7ml20DYHmm9KL69wpJa
 L7wVyFHHsyKMNuwOSpDizRAw2AqmLewg9LLQhC1QfejxGtnEBYkKeGzytxIeUKAphRlyJXSC9kW
 JCeb2pfpCCbcZtg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Specific constrain in if:then: blocks for variable lists, like clocks
and clock-names, should have a fixed upper and lower size.  Older
dtschema implied minItems, but that's not true since 2024 and missing
minItems means that lower bound is not set.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index e496e5430918d54b2f07f1d5b64de85d29256951..2aab33cd0017cd4a0c915b7297bb3952e62561fa 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -231,6 +231,7 @@ allOf:
     then:
       properties:
         clocks:
+          minItems: 7
           maxItems: 7
         clock-names:
           items:
@@ -253,6 +254,7 @@ allOf:
     then:
       properties:
         clocks:
+          minItems: 6
           maxItems: 6
         clock-names:
           items:
@@ -273,6 +275,7 @@ allOf:
     then:
       properties:
         clocks:
+          minItems: 7
           maxItems: 7
         clock-names:
           items:
@@ -293,6 +296,7 @@ allOf:
     then:
       properties:
         clocks:
+          minItems: 7
           maxItems: 7
         clock-names:
           items:
@@ -328,6 +332,7 @@ allOf:
     then:
       properties:
         clocks:
+          minItems: 6
           maxItems: 6
         clock-names:
           items:
@@ -347,6 +352,7 @@ allOf:
     then:
       properties:
         clocks:
+          minItems: 9
           maxItems: 9
         clock-names:
           items:

-- 
2.43.0



Return-Path: <linux-kernel+bounces-525998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E94FCA3F88A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6A1423C22
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D002135DE;
	Fri, 21 Feb 2025 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iwldlfbi"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BCC212B10
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151498; cv=none; b=HGOsERMXpaG9eMo0nlNAebYs5LeLIDqlRPWVzlMaUTOgJ/BxKrkiVz/Deq8TOwnREGo5AF9cR5kZqW0pEYRWNQ6VWXSCvKYWi+1xlxzFljMJK18WEwhEi83cf7abxFWythXJ5Q9Cdora0Q7QUJcDCzW9W11tORFAEfqpaNWmCZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151498; c=relaxed/simple;
	bh=bIJmVQhUPgDWhOxkXZXr441zWOXIC11HBHyQtQ4C9AI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KBskqR7gBNbbKD44BTN/zQsZF5VICGkrYnCthrC6o2eVbELgZdr/5zLbEcXpBh5eG/VUVank5F7dIGqC72g80bxOX1rqTqkqqeG4ed/qRbCflaa2erz3qGe7+RzIgofR+L/vUoZ7Svv3XkYgfD4WZ0u/tcZEpN0JvVW6j82fuaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iwldlfbi; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dc191ca8baso450279a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740151495; x=1740756295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ve17j3mm/abtdUOwnmohJ1b3/R5tZ1e+gOy6d8tNk6E=;
        b=IwldlfbidIHh44vWWVZ0OhJIvRAnqkNSUK3stGwsoW3jf2wQjZlo0su965kunv48s8
         i5EKyE5Kex9B0d/bdN2dF0+RS8QoxM24MrZkJE9U6uzS/oeRljKjKzcgCkGA3OVa2HL9
         oGf0Ylk6OYmGFt1EhDnbnUF1qaXSrEc20Wb+F2huyZtVy7biqj4qPNDUuJvBD7YvFGOB
         Dapt2yCXAXcg/LnHbyq5QVrJAPOnUy68bkd/7u5brR6t+UvStay5QuE12yxwUx6cwcQc
         WhppTcUJrcC7ix90trdlHohVo0xUJJ6RkdRRusgYq0pVJhqg+qDHPZrwERe1HAn3mwbp
         +Wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740151495; x=1740756295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ve17j3mm/abtdUOwnmohJ1b3/R5tZ1e+gOy6d8tNk6E=;
        b=EqHozu5sTgKLkKlkEmT/kWSUue22TA53iC7+hHcSmzwiBD+RfP86i4IpvtvRIYvr0p
         rrIaNa9fFnYS/8IR9A6n4Qo7A+hFbOnO5F6uT1Q7l1lNENWjuUGBcM0o85z/hytbU5pf
         SdKPCdwu/Mn2sPhFu5dEp7SoJNU8VuBhNNGktmy/wOBW+XnzBEljPmnvP3RnXsMvzIND
         Z5/Es/+ykrKrQKcMdWYgZg5Qjl79Y+3KK9JD8UKXOTeOICCCUFUWrDqkWyA24ScbzYpd
         0APMvG0kQ0Sfgclpu73LOdY0p5HMvn8ZbmJ7UNgh+0cAx/vR/jRx8cy3LSUzCXrdoK5J
         urIg==
X-Forwarded-Encrypted: i=1; AJvYcCVK7g6E675VffG1etFqUMumcQjBtx8jBdEmIYq5AK+/rsrp52kY4s4cf/nVOxOQaf9F73BPGXIfl9AiJCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sS1zZkfhNea6aRORcb6oR6CSNVfIbPwjMLtQPMmkfruPV0ix
	wiby64k5VVjrwjIqBFnJ+v1qXGZfTUrnccvhDpnEgxPWZiz/oPxuyU17Izcy2F4=
X-Gm-Gg: ASbGncsc8PcrH4LYAv14EQq3dG1Z4hxBbwPzhK6lBLM47ttWF6zib2KJ/gmFRjX1zBy
	zc8nNwtyw4pfCDVMQDDPEoiMrJCwbNVeTqt1d673UdN8KvmxgTH3Av+C+ptYvbHgg7F/cBZtJZO
	J2dwxIbaDphhXAELEskezsBM9wnGdbf4t9epQa5sjLpqzBkcEDdd5VkoxYQCq9xx95EsasqEhNJ
	bP1UrgWt0/NvEaCD7zjm24nAT2LuMS6wkc88KKH5OuZAXIsJ2KI9AzdPBoGK6irzqbn1arCG7F7
	EAsYhCxmhbuICuS5356415sEc7JpSRB+RYlQnFkWkt5lmHZHBkfck7fAIBWlb5tuv/g8TrSz5cv
	E
X-Google-Smtp-Source: AGHT+IGThcFZG5h6nyf0Wo4R9pbuzagN/g7Q86hCwRQ07ocY0fsI/LnRjCQ+ln/jckB/H3+qTrieVA==
X-Received: by 2002:a17:907:7f17:b0:ab7:63fa:e35a with SMTP id a640c23a62f3a-abc099e1dafmr140767666b.2.1740151493681;
        Fri, 21 Feb 2025 07:24:53 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbaa56026fsm865456666b.113.2025.02.21.07.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:24:53 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 21 Feb 2025 16:24:12 +0100
Subject: [PATCH v3 02/21] dt-bindings: display/msm: dsi-controller-main:
 Add missing minItems
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-b4-sm8750-display-v3-2-3ea95b1630ea@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=bIJmVQhUPgDWhOxkXZXr441zWOXIC11HBHyQtQ4C9AI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnuJqtl/dJu9saPm64cDkotdIPNx/NMuosAvWNm
 I2ba2uSO8iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7iarQAKCRDBN2bmhouD
 168UD/4soLQMowTp96PKFERzDIPLIBRahxZNBzCNEQBX0rlr1gS10d2jJqUplfH8osgbTis/4sU
 R3B15+PKFAy2ol7Fb8eO9svK7dbJWZ3aNLVQ1DjHKxryodaeai4UhmRFSEe2mVKoVncQ5Phdzi6
 HF9gJdr0ptsIsalibfNCEiXevMyu5rBtcz0TsmeY7BimEG6qWlsuWYyfclVjAlkXHMsV4LYl6kY
 RbqDDsatU6wIw/ft8Z7Rt/L4MjKrF0LibxtmKdp5hTXi10by2V2PS05ysEJ37QUzFvTntouZMPs
 /35sGIrCSBFtujJ8THjXdc3n4dL8ifDigHXraiOa10Qbe4C46tEFP+saQYBKMwr4I0KMLG9g4Vh
 PhhSva15QOGSw+83ZVNv7Ozu8sZDcwd3OYaeMn8tK5bONBjSKCJacXk607YFllITGbV//rJl05j
 J7sUmaG1jo1AYlUeGRv8QkFNqh25b/z7Ir/Xnd8F4u53RnOjAnFCBIIQuk1pB5e/hAqXvyfCrxS
 hm71NzAq7XTyR9gU06Z0Sl9lJAnoEkGUck4PkrzQ99FRsOrUre0qDqe7q5Zyai9viRPuHnAyfSk
 vYnIZyjYq3lg6Mr3SvySVbMx5blM7ZgW3u4rjbA9XOyciLbs2m4DdeLuBgket3YHcCEaY5qeMta
 87c/5O7v0NKq0mg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Specific constrain in if:then: blocks for variable lists, like clocks
and clock-names, should have a fixed upper and lower size.  Older
dtschema implied minItems, but that's not true since 2024 and missing
minItems means that lower bound is not set.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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



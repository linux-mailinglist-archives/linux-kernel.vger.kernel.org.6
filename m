Return-Path: <linux-kernel+bounces-226107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ACB913A4C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 14:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7A81C20CC6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FD9181BB9;
	Sun, 23 Jun 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="necivQJv"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90E118133E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144034; cv=none; b=PTfp0Lpo2KA3QsgrE4vwp9FIuZY35JVGaTo9yw63vkJnzRme+cyHlnLmIFprNl53Lmn+JIHcRa0lXL8btItJE1d0Pw1e5x8k1d1ve17x/FzvoHmF5oKVW3qEKDe6NFmbkXxEUJid/GpLAooF3WWuhgc1Gd3PVp2XxUZ+xzk50gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144034; c=relaxed/simple;
	bh=w7QmicMOY3gkCg20Sf6J+bR20DHpDJ/1/bdy0XRaFQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeiqdHnpCd9YnmvnuJ6+fnsfPwifqpxm8qznSWGio7xyDZvBEidcHJ5hj8Gc4wd1/gn9/2cA4+x1hgky9FhBQY52Oqqpna31OWLh50Hehgb9bHtKmEl4xQ0+Ge3biUT3IRTZw8ZCUI/aR1bY/YgBj0ffck/8SDlbWObMpPqRpuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=necivQJv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4217990f997so25304495e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 05:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719144031; x=1719748831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5pRySu+ARf8jWv+YeotUn57i8P3KF+qPMZ7wIjslP8=;
        b=necivQJvFommC63knwOs+2OKBfec0oP7Fm6NH/8S0fbaBl8cxNpGekpZZuKxTlBgTb
         0iJ4H4HsOdPVmLINmqpMzTiV4W0PFVBFcXAKBGQ1mGHffRhR+hRHY6TZjbL0YwGm+Rn9
         dF4rjHCEqlgMDCooytESL6NYl5M/W1Ipkq4WMXJoO4H/+CdyKbKtf3Onm8DsZSPV7tLh
         8bTclQ40SbE6WyKIPf9kOPfDjqPZK+lP+o/fJ1fNILNtyKCYrZp0JjV0Kt0iyTkWAfqa
         ObtHgTwsL0ztvpZnD4SjCglOjPX7rqQdY9UnwKy4/P7SiXgYABeeq67Lw/JCdlZ5fSYs
         G5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719144031; x=1719748831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5pRySu+ARf8jWv+YeotUn57i8P3KF+qPMZ7wIjslP8=;
        b=pyRC36di9ChFejXq5ocwbINzuCPX5WqT687KCbFI5lXhdpa+IBjzJXIfVdz3sctlBZ
         s3h6h72M/y02vKH5FUB9XizEAY5IKN6qkgOpIKOpLppYRBL/Iu1Yezit7WK6F5Da32Fm
         y2nyfgMkj5JtRc9icNTzNBHFBmZ1QFExYVrZMl945+rCfNzRlWnFjzT34APsYqLxDGNN
         bplNEA3laFtMX6vfcET4aeAsNycEj6Q+aNAumF58psMG30E/NGN8ONcNqfp8gNLlJj19
         oDGZAHCIzSy3Mb6QBOvQJEeBHbu5AqQ9BXmq2s1sgd9oEvRsUFWVl1kJIEN0ndkjcMnX
         SYIA==
X-Forwarded-Encrypted: i=1; AJvYcCVreVmwKBf+c1wQUgve5YEIQk27kKUP+yyLuLvnCeeASsadqDfpcPQyp6f7HMm+zM7rgUtc6ILTI6YSd45ZTvudqDwAA1QiJdNHHOb8
X-Gm-Message-State: AOJu0YwKx7hKDNg4LEVkoXV0BctlqRslLCYkqWmKLRoJRdF4p+2ogvo7
	iFKh2DS6xx6zluSHSLawXOaoNCjUUDjEn1zs6Q080/weXbhLO+YHhccbcJ/y4+E=
X-Google-Smtp-Source: AGHT+IEXP7AJ8wGYP4P3O8ghUgKEsx/NMem41iq5obFqMs7hv1GsRgZtKTmlmuq84/7vHtVQVzL0xQ==
X-Received: by 2002:a7b:c4d3:0:b0:421:7c1e:5d70 with SMTP id 5b1f17b1804b1-42489e3ab62mr20397615e9.16.1719144031293;
        Sun, 23 Jun 2024 05:00:31 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248179d3basm105465515e9.4.2024.06.23.05.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 05:00:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] dt-bindings: display/msm/gpu: define reg-names in top-level
Date: Sun, 23 Jun 2024 14:00:25 +0200
Message-ID: <20240623120026.44198-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623120026.44198-1-krzysztof.kozlowski@linaro.org>
References: <20240623120026.44198-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All devices should (and actually do) have same order of entries, if
possible.  That's the case for reg/reg-names, so define the reg-names in
top-level to enforce that.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index 253e68d92779..baea1946c65d 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -46,7 +46,10 @@ properties:
 
   reg-names:
     minItems: 1
-    maxItems: 3
+    items:
+      - const: kgsl_3d0_reg_memory
+      - const: cx_mem
+      - const: cx_dbgc
 
   interrupts:
     maxItems: 1
-- 
2.43.0



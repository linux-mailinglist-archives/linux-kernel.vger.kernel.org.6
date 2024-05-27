Return-Path: <linux-kernel+bounces-190049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7681E8CF8D1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2BE1F219FE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96355DF55;
	Mon, 27 May 2024 05:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="llzHtWdZ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56141134B6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716788333; cv=none; b=O1pKGZ1ysGLpYzuL1PEEcV+2+dAg+1h4t9OGnbGCXdjyE0fiuMCGiaIC+ETSNVyLz+DSUSV01Uca1JrQTWwZml2ZaixoN8OrIqHR5LG54IH+kdaCFP5MxHxzlp80mU849qSickhvMRcL+0EuqE9nhq6LIljLKPzfURHQFvO7Ook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716788333; c=relaxed/simple;
	bh=rPfFrJBnAulSY0rHFnC89I3kUqU3f8YhptHrQUiyOjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ibWznGYNK2GMJPlCRU4ZubQB1zQhBe3795Xd6XymGlUpPl6e48TPwQPhz9uYh6LRK1RPV6VJER3Vu1xSp0i16rpjkkqxlpyQmfr/+qrfUOfyvsYqzRdd+r4FBPoUF9CxPNZIDlvJCBOHmdsnS9dy8RfC0Xe/BddKgKfHrOBJj0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=llzHtWdZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f47784a2adso6820795ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 22:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716788330; x=1717393130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaoVf9eqjsot1BqIU97nmYIfRRMIaK539UE6et7+tDo=;
        b=llzHtWdZETdpjrArQzPaOL8x9iLXERTfQOyOlSOAdDTxNQtLxlSEqBkxqOUA65h6YV
         31lY3M1FXCB0NqtIAWt2be4mGVU0c0WLQF+FxjSlSgz/649c/3rUjvJiUmMXjchQ6vGH
         Gb+Atf+uSmCxHP3yN0Hb4cb28+XeUBdEMi0PRqfzZfO4rh0yal9SJvr+eJHUb7YKEVOz
         ZZpSECMqB0w84qft7cMSi2kDPv/IZ/XR4NKNqFl8ILsNmv9i/yEAiaFOnCI8LYJ2x6NA
         rZf7l95Uq7StT5zBbYVhMbO42B2nW2ynb6TibWXsYURhKygwjl5rfHHugCcX5+vqYOb0
         c4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716788330; x=1717393130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaoVf9eqjsot1BqIU97nmYIfRRMIaK539UE6et7+tDo=;
        b=PEhks3IjEpmbR2dAFPapXjporL3T47amaEsgGfVQ0T4Op3GSXptpr/SKC3aZDifO6X
         SmOnPdrbuQk3EsD6FSAdZAWC90vVPIPwvWGMSYkIJpyXRd7SVC1IFJLFYhMAnC9lUBWy
         E9zqgxOdg/UY08WTofj4BEgkm3ngBpkCrHp6DEcbKHi8bXS3xU0w1uZwNr5YgMQAre0M
         kb3Hz+FT9bEmxkLakood0it6BABmlTD63Qos3VPLuEZGCi9uKsm6Qp1i4XwTjjKCcjDM
         AN8s8zas5TWZ7HbeeQsshNUvB2DkQUzzQ1CfmqmliDIE90KfuzWnrI3xrSZHTx6Um2hm
         BIyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXphy4Vy5HknGL2CwezUtjmbKHh8hVdv547YtJjiSzE14O1JRDrxCqAEJll3hB1vDkV045BnDdP1s8U+EVTkEJme4S6/UUlOl5+JDi+
X-Gm-Message-State: AOJu0Ywt3QGIV6lnfnqigrrgna2eC7rx1k2hCnu+EoPGlsbR2ruB54ug
	HrXM2U3w8kjZL0swb1CNxcjZK4USKxpuO6z/0xykGX9lDJNJFntPgAV96j5C3hA=
X-Google-Smtp-Source: AGHT+IFgjVG9f3Ott/fxxmfPHjXa9BW1PEsQItCSb61Ct/TUAu2hJBRMUrECg2TYxwxIN8qtRkc9yA==
X-Received: by 2002:a17:902:c946:b0:1f4:92d4:d126 with SMTP id d9443c01a7336-1f492d4d135mr31439365ad.28.1716788330623;
        Sun, 26 May 2024 22:38:50 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9684ecsm51903745ad.177.2024.05.26.22.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 22:38:50 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	stephan@gerhold.net,
	caleb.connolly@linaro.org,
	neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org,
	laetitia.mariottini@se.com,
	pascal.eberhard@se.com,
	abdou.saker@se.com,
	jimmy.lalande@se.com,
	benjamin.missey@non.se.com,
	daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND2 v5 1/3] dt-bindings: vendor-prefixes: Add Schneider Electric
Date: Mon, 27 May 2024 11:08:24 +0530
Message-Id: <20240527053826.294526-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527053826.294526-1-sumit.garg@linaro.org>
References: <20240527053826.294526-1-sumit.garg@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for Schneider Electric (https://www.se.com/).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1a0dc04f1db4..4ef38573e411 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1211,6 +1211,8 @@ patternProperties:
     description: Smart Battery System
   "^schindler,.*":
     description: Schindler
+  "^schneider,.*":
+    description: Schneider Electric
   "^seagate,.*":
     description: Seagate Technology PLC
   "^seeed,.*":
-- 
2.34.1



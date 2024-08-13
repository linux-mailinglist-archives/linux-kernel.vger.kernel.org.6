Return-Path: <linux-kernel+bounces-285371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DE7950CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C04B282848
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841791A7044;
	Tue, 13 Aug 2024 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IGSMqVz3"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F257C1A4F0C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575520; cv=none; b=ZovYGXvOkfk7TagSRUorpuTJy9SIttMwOrXjLXQAkEoe9hE7hEXVCRh/9Ksp336IUHzMOYefFBPh/mHr/AYMg/zyxJ3h4VCrMa4KaukrYJ5uRFUpzWDB9suUfJrThEL6P4wSVqZQUYilSgVW5EQK9stJiD+SGN5LWAJTkJiXQYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575520; c=relaxed/simple;
	bh=xb1X9sTHTknaC57AtSXTIM736W5+uYqdz9zT5MxOnyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmMLlanzN66bG8hQOgpO554SwceHhaHfjCXYuDdYlq60wRp3BEdOebDFK/bdIi9IwcIvwraUEKCaCjRX/ph3Zvgd0P1Cj9/Cf9Qouj/0PFRPii9C3ekv3Hgq2UqRWs7IvqPP8YvDl0QqNIDCf9pFZoIriDI8DUiOfgXBD6OqvnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IGSMqVz3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso41145105e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723575516; x=1724180316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcl3zA4FgRUdr5ZygdjxphfXY88eP/BhUP2PF01mf3E=;
        b=IGSMqVz3j3o7Njp+C3V3Ye80h/DhvoNkUkb/ZcF/ntlbuackWFZ6dJh8lZIbUGBSd4
         gwRtfmdJi7qOP86kODA1lYDuK79ySjlB7lDrFJi5fbu5BvFj9tCU76xYof14SbkqKzRj
         WX7lJKkFm/NjnqtzuT4t5vb+hmGP3l5F/rvO61snmVbxixRpa+4eaN2GriMnjs7a1ESH
         b2YvEULEctPoRCiwZ0trEFOQp+PP8Tuudu5+5490Ry1L71wuN1nz7m7H7vpl+9HPojdF
         QM12XDppZC5i5pai6G5JMITL60LNksTvJQBJdWNyOewC1sIH6isFSAXRj6+WCDf3Vh+O
         3Pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723575516; x=1724180316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcl3zA4FgRUdr5ZygdjxphfXY88eP/BhUP2PF01mf3E=;
        b=I9Qko98VjJID8pi+CiMXnTkIp2e6EaAHZidU8+p8awYLaRdYB5gJrt8/uJC0E5oCMm
         xbFUQ5zRFtPIxe+Qn6qiGMS0ahu3aKpmquWt1TV81bvS60m2eMXVcZbcSGMIWM5NzBDd
         cLgo4AOT6kOcq5Kx2xlfzkE9w5IFzRQ+ylnHQeZok2EWWhgALkw5VKISpzrlQt7LLJLm
         rbNYQMKVEa0Vh/pvxAOmBhVa8ITUgapH+CWCFMVzq+MlpwgRt5UJjufeAlivDVvs5LJQ
         153vH4ekDvkcfozIFJwhA0JA40gK32fK8n3jEFWyGruiq6eh1dQjlmS9TA0Eu9YRUCdJ
         ia0g==
X-Forwarded-Encrypted: i=1; AJvYcCWY8QmU438ZRlWlnReQyjLrnfT6MEZ2zXePw0IQ2YVjD97FQnBWSzzwIGtHTZUPTJiQGpLJeuOfBYEdRiy9Y1FKnqEvR5fg3oeWOjD9
X-Gm-Message-State: AOJu0YziATry12B5Zr3q4k9eKpWpNI1aor3lwkgPUBE1wl4JXNnnY2gZ
	0cg2A21JrV2HLyMNaKHKcGb18l/Op+iYG+dGtszM7YaJPoTCG2JbN95fmkHromY=
X-Google-Smtp-Source: AGHT+IEgq6CVGttTellTVTWy6Kc2fSeSu7jNW/zDzxvJpBlhy4KnmTkocYLGHxOASyuobuObba4jYg==
X-Received: by 2002:a5d:420c:0:b0:371:6fc7:d9d9 with SMTP id ffacd0b85a97d-371777714admr373145f8f.23.1723575516292;
        Tue, 13 Aug 2024 11:58:36 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c775c509sm151208145e9.44.2024.08.13.11.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 11:58:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/3] regulator: dt-bindings: qcom,qca6390-pmu: document WCN6855
Date: Tue, 13 Aug 2024 20:58:26 +0200
Message-ID: <20240813185827.154779-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813185827.154779-1-brgl@bgdev.pl>
References: <20240813185827.154779-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add description of the PMU of the WCN6855 model.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../bindings/regulator/qcom,qca6390-pmu.yaml     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
index ce7771f9fa36..6677939dd957 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - qcom,qca6390-pmu
+      - qcom,wcn6855-pmu
       - qcom,wcn7850-pmu
 
   vdd-supply:
@@ -104,6 +105,21 @@ allOf:
         - vddpcie1p3-supply
         - vddpcie1p9-supply
         - vddio-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,wcn6855-pmu
+    then:
+      required:
+        - vddio-supply
+        - vddaon-supply
+        - vddpmu-supply
+        - vddrfa0p95-supply
+        - vddrfa1p3-supply
+        - vddrfa1p9-supply
+        - vddpcie1p3-supply
+        - vddpcie1p9-supply
   - if:
       properties:
         compatible:
-- 
2.43.0



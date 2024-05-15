Return-Path: <linux-kernel+bounces-179781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E6A8C653A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792C21C21A67
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F8364CE9;
	Wed, 15 May 2024 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pIXpOC54"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A310627E2
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715770509; cv=none; b=aJTxw78tG4T9A0P0r1k4CHyNFFhpub8pIPe2wJfgmJNTqjxzgAeZTOXoHwim1O4UT3m4IzjdgRoPae3dWs55nOF+bXYKN7U3F8kf3PK8TDUnU8KC7XAaninkjNAOFvhICkuDTEhUD1LOoUN06euEKcTMuIFIRjgpGAPFMCvOACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715770509; c=relaxed/simple;
	bh=rPfFrJBnAulSY0rHFnC89I3kUqU3f8YhptHrQUiyOjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e8wdxE/ELt/RMLRr2LLEXz/5vcuUNcgFwyDa5CmCfu1A2uZzPrhJJ0ymo0Tz8QNCiKdJiknfKU0DPOfucn3wupAi/9icNQhJAVTCOgBuKyRFnjLlgGbgNYkzzoXpapax0XrxhhST4e3bcyNsKInLvyGMG99xi9OY0tyfmyqtgH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pIXpOC54; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ed41eb3382so48464405ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 03:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715770506; x=1716375306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaoVf9eqjsot1BqIU97nmYIfRRMIaK539UE6et7+tDo=;
        b=pIXpOC54bmlwDCLhXRjCsoFfUnXAEKVxcCWFG/hQmlbXh+D/8VXALYiYq+VvzbyPuk
         rjgWwTNBqCH3m4020kXnllUQ55Jymj0q4GNlIffR9QG9diZgo6WU7OFqcWXKu1U8RIse
         +ylc9pep+8d+jOP+raEQ9G8X7Vf6i8Yk7ViMLlv8/qy3ubDowHfwk8EqHxYJAre2tgDb
         J7ywtk0fGF35eeMuYxB/RMsX6Dh5JHv7b2LHnuqxtUKPtfeL6kAbAG60WXH1PGd02aIs
         77H7Tr8paYy4Dfmhe0xuPgHMwfP6tGRNL/7Ovtegli2NJHnKHuXSrogLi/XFrUcJaBws
         dRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715770506; x=1716375306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaoVf9eqjsot1BqIU97nmYIfRRMIaK539UE6et7+tDo=;
        b=uZZ34aWaCz5rhieE7dh9hYHSe0+swhBgDcZ/UOSafzQNNAtpaSMwNUVuJz5PKcAfTT
         eKSwW+vm04zGDfm+054RzvLXM0bmxBblB3FmZt4Ly+MhRNm/ktj5udg1SnBLogaiaLNt
         1YnCYaQV/8AVBEwM16EK6NR1bQsQQBAzNm+7S2XczXthxLujsfUyRXdsytl88UUpY0SI
         Pn76Fggltz2b+PQwniLMCMiAeTcCyp2qmdyCQYY27J4pLpkw4HDRgiHgT5ceMtK6vdRz
         XM7wpuyOWxLR+7qztkejtDdxrj2Q6GO8BWtdTzkpKGJ8e21jw/j9K4YOT6WmXnxiL96A
         ybCg==
X-Forwarded-Encrypted: i=1; AJvYcCWH50bVoGpz5EH+kymS30Y1zgR0fylxFaWII1ntx8PthQ6uo8XgUJUf79W6ZuaZ050E1ls9O0SfWgT2AFRoO551AzSo6ZnuTPXUVe2J
X-Gm-Message-State: AOJu0YywahhtYEs5rkdnw+LjwTn5HaxTs3C1npDS02ATSgsVn/liXVz7
	kvrfy08QPREoX2fBamsFWS3XX3ctX/hdUwP9Fn0/F5kV8ssYcWPQ1bOYlNPaJnk=
X-Google-Smtp-Source: AGHT+IEa8cD+NHaZ6nWyKLxA++Jr15uCVPBvC4soQiOj+YCFTQkTKTvJ2zwwy6AZreOga57EltuXGA==
X-Received: by 2002:a17:903:182:b0:1e2:ca65:68c2 with SMTP id d9443c01a7336-1ef43f4e240mr259590415ad.51.1715770506339;
        Wed, 15 May 2024 03:55:06 -0700 (PDT)
Received: from sumit-X1.. ([223.178.209.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30bb9sm115092425ad.135.2024.05.15.03.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 03:55:06 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: robh+dt@kernel.org,
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
Subject: [PATCH RESEND v5 1/3] dt-bindings: vendor-prefixes: Add Schneider Electric
Date: Wed, 15 May 2024 16:24:44 +0530
Message-Id: <20240515105446.3944629-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515105446.3944629-1-sumit.garg@linaro.org>
References: <20240515105446.3944629-1-sumit.garg@linaro.org>
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



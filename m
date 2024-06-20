Return-Path: <linux-kernel+bounces-222377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9649E910085
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497B71F21AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F1C1A4F13;
	Thu, 20 Jun 2024 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nho1i5EE"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F1319E836
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876403; cv=none; b=Kh11BG9JFHTWAOx/VbVQZGvsR/Qn4PXvfuJsPHlXsLDC6EkRy+z9J7sHL/v9QTYooSwgPCy7QDvS1I1WV8covcTNCWHgdDWD2xsKaEaYiqXIXBcSSjcIXdVn6bDW1lBCQh5KJpv7pEbGAURx0mYc/5ur8UtTh2E1ZlevjWwQ3cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876403; c=relaxed/simple;
	bh=Walj97wSsqVGHJAT8pPpKAaTgesF2cJK7dEcktibO78=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lE4/Q3eMuafvh8kusbbiLDHktosaD2VFfdHiVigt/c/MG669HtmfvjvGziQrsKel86en1pgGfHjoecIFOAdDy7wBMkFl1vtbUfS9ny36AA+rbJ62+w8XkLju72EGPQIJqqxwyZYyp7P4IbylJj8fej+uCIjkGM9sou3fkgt4MfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nho1i5EE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bc335e49aso697201e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718876399; x=1719481199; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aVEy5UHk4sC2AVpNkrrSDVd5sS/vl8MpjibWGCbOkQM=;
        b=nho1i5EEb356y8p/IDCj/iV/HN/oZ13bZD084W7D7fa+9Kv8KTCK6LY7RMx2FKOkPw
         KUzUjw8WDZAc8aNlFveAJ8DmIFDwiVkVnbJhz5MZ4ETDKp0+N3h7yTaqG4qZZC5zln1b
         lWjxTjmff8RwD2sd5dLc+yytqtvZJUiJMbqZSB24cSRBY2mkrse3lHVOBVRLrlhJukXA
         BH62HKMmNG+MQKu0ZvnY9srTun4RYRavqyi/AQ+kIYtge77PrJIXlVWnF8aPrrJr7Upz
         3vQW5cTFnZ5swHebfHR7beMHprMLB1uypDjQDLAi3TJsHjR3+4wTljOns6OdaozFcawJ
         yg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718876399; x=1719481199;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVEy5UHk4sC2AVpNkrrSDVd5sS/vl8MpjibWGCbOkQM=;
        b=jzMGDF787RvwTR0ltnfglRTWiYjgA5rgygCa4foyTw9WWoTcitidAacPQ+4NeSfsuH
         aMrbiduii/+Wl2NddBSB6OzJy2/5iPkxDJwr6KrvW/shbFgvXAhzxc5dqqhJ0Gzavmor
         kDJHTXgUi9jMbc6saM402pXG+mixsnx0nyS6NnqsjmYejptwIfQqTVEEC7bK7juVqNtX
         VDemadDXzq1oz3XdqMx70YV0+HfztmrzKHD0Mbb73n5esT69rW4KLG6XPXCYOo9ZhCEH
         sQ+bQ650STRUjo9A0UMkrSVgewHtva3OCBA2o0W3WCAR8saKv5KxaIFBROPDtsJx7pxc
         TNwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2DPwYzWayfeyZpL4uoZjUO6jHrN/vy4DzLpVFSRvT/t7B/THb5MDACnwlsI5Lg0qTnTun9Flann9YeTsKaEkfa1N+d+6vmKpWkF20
X-Gm-Message-State: AOJu0YxbF6nzLQk/AJhUCsUm0tu1EJ4l7Fa4vJnm5wJ8aI37RRWsEouT
	g3M6riiHK/bCDdvfdpM7iw0nBIp4B9bvKGsA6X4Ua/CW2qN9CmR+FarCu7/LqjE=
X-Google-Smtp-Source: AGHT+IHp1cWWfdV+f7sdbsrSxUcUouIZ/mlQaqb8fzFWNu89aDMmGl2NcUNkSjvkM4CWfTdFMO69Vg==
X-Received: by 2002:a19:8c08:0:b0:52b:beea:a9da with SMTP id 2adb3069b0e04-52ccaa62821mr2778203e87.31.1718876399483;
        Thu, 20 Jun 2024 02:39:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d211ae0sm19366095e9.41.2024.06.20.02.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:39:59 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] ASoC: dt-bindings: convert everest,es7134.txt &
 everest,es7241.txt to dt-schema
Date: Thu, 20 Jun 2024 11:39:56 +0200
Message-Id: <20240620-topic-amlogic-upstream-bindings-convert-everest-v2-0-660985615522@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOz4c2YC/52OQQ6DIBREr2JY9zdg0Maueo/GBeIXf6JgPpS0M
 d691CN0M5M3i5nZRUQmjOJe7YIxU6TgC9SXStjZeIdAY2FRy1rLVilIYSMLZl2CK/7aYmI0Kwz
 kR/Iugg0+IyfAohgT6LExrVSocWpEad0YJ3qfi8++8EwxBf6cB7L6pf9vZQUSzG3qBm07KRv7W
 MgbDtfATvTHcXwBy67cxO8AAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1092;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Walj97wSsqVGHJAT8pPpKAaTgesF2cJK7dEcktibO78=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmc/jtj2VUdYSHucJV+DTuW+sUdOaBBBEJzYH9iH93
 hiRHzVCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnP47QAKCRB33NvayMhJ0ZF5D/
 4+pRZzXovKd7H7HMGEUL8t25mRbKEEXkI1wOifLVswLwSksIGi9zffTHBYE92J+a4jbwrYKLw+gte6
 6DQc0GN6GenQzf6ArhGmuKTWJSAlVdmRhJUYn2ETwI/wqRArZ0HbpKsbUxEnTp9ekkHh2xSlg5XMMm
 U4r2b/679mTXw7g+MW18RoSxuhSc26UoFDGBuHtlPEQzeMkKHpx29vijBImt2++hvREWchL4f0O5pk
 sH5hm/2a3mTCpLUVdqARqPwUOsAhhVNdm5UF0HcCLn/lD1ECPdFTho6tdN+WBMlyTuFXaeV9K4hZYp
 k9g5H6CoHRqlUD3EC8lJcA6Zn/jzoA7CvyWOf6Vg6FO12ClH1H7eA+Bxk6K3qoAQTSUlNG/JrVlPqx
 NuwAQmdUV/0CCNuoA74G+OhPeGvVUiyrFjp+d6YgN6uQHbkkIvSdAede+no03yQQF2U9dyz+A/Hjlt
 k/yzdhSFiVUg+p+cPxsQnREQvAE9oygrfY4j3R+/lWKgR7uHdjhQTfH2I7W95E4m+lA2+FVj0H5yB9
 ZyGdZcY7Ay2xyA0x4ObIOw7tx4uQ2ygIJhpCb+NK6GkMgktbqYfNxJJVU69aXXV+i7qSYI42VFCRbk
 UaAF3nzH+8J7QGereYr55nFE8lNFB6UgXRN4ICj4xnGkSvbaSHUlRNCISxqg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Convert the text bindings of the Everest ES7241/ES7134/7144/7154 2 channels
I2S analog to digital converter to dt-schema.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Fixed examples
- Collected review tags
- Link to v1: https://lore.kernel.org/r/20240611-topic-amlogic-upstream-bindings-convert-everest-v1-0-a7f9b4c9005c@linaro.org

---
Neil Armstrong (2):
      ASoC: dt-bindings: convert everest,es7241.txt to dt-schema
      ASoC: dt-bindings: convert everest,es7134.txt to dt-schema

 .../devicetree/bindings/sound/everest,es7134.txt   | 15 -----
 .../devicetree/bindings/sound/everest,es71x4.yaml  | 62 ++++++++++++++++++++
 .../devicetree/bindings/sound/everest,es7241.txt   | 28 ---------
 .../devicetree/bindings/sound/everest,es7241.yaml  | 67 ++++++++++++++++++++++
 4 files changed, 129 insertions(+), 43 deletions(-)
---
base-commit: c3f38fa61af77b49866b006939479069cd451173
change-id: 20240611-topic-amlogic-upstream-bindings-convert-everest-4d5a601e4ef5

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>



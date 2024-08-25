Return-Path: <linux-kernel+bounces-300364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B59195E2D1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2051C21150
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF2479DC5;
	Sun, 25 Aug 2024 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNcStfC/"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72F5763EE
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724576274; cv=none; b=Z20Rhe39QU1gdYL/lUXrXolzl96vUAXH86rKKS4rzP03q8MIbdmPLq/FobU3SXCnHiK3I89wxerGFs4ZbITLA0qyvJ9ZATNQdwulz74Yly+pSjfCaCrtPMDZqpR98vvdWOQDh6j9ZXbDYsQl/G1e6HwdFlveOLCvsaByQRWSUUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724576274; c=relaxed/simple;
	bh=1J6BWW2PKL0LZoDDixa5BAHxaPBO3B1K4JK5Epy75ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lY+VXvXSCrwt+LbBZN7mS8akQrlyzkbJthPNvwctPKYCXDU2pH8IloVwxHP8YFc6vxmvT95vc11BXuOJFHpaFe1TX2SWU27RXuolgMlNUIVNt43KxFg5iPfDpIdDJAIZNOBzG5WXmB2SwVi/CDQHorGSPxjaoibKCVzJJayGtkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fNcStfC/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4290075c7e1so4125355e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 01:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724576269; x=1725181069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJtwn4ZxojcRke0143CcWqq6cxB8ohpeltqblKHrcIk=;
        b=fNcStfC/XRuhIFy0TnXRT/LHECsxphyP9N3esc38VvVq+JqI9MLiLkU6ERcCjH1wJH
         dWjnQiawQOY4unvIaqjaZRQDqPfLLZm9ukR6xtTFX/ys3Jh94Hph4PJ4kP30+oviDUkI
         DLv9BH4hVAgxcJKJmI4ic26kO/oL8RZGiPKeUcd6B5KYT14Ye2WirWR7pqIAiqi3jGmq
         nRFxZmpDloUaFAH//gIML25Hx71qpLmBTf/0IhX0xHgdJ81xDnT1bkTgg0b+HztOW8UU
         9HKBIXpf3Nd6Dujw6FH/6JcyHGFuT14gV1vqjH5WecRQElHMDIhhM8LMyX06tat8+/dG
         RT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724576269; x=1725181069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJtwn4ZxojcRke0143CcWqq6cxB8ohpeltqblKHrcIk=;
        b=N6hH3lfXBGAROHSUAdewbFLuER7OxetuIoLKpSCZTFE2jqas0RCN0wz3HKBWHgBx34
         fzaaZNX9zsPK9qCTasAs0BfNTJaG6GaYJGay8ZPTm4zi1VVT0/xJ2J5SlFampuFuz+Nl
         PQsTBQsz8BXf+CLS1/F0dGB2NDc8yW4bmnf8P70aWbe+bM9taBZKCiJxoBIbfr4n3Y5H
         BHO1P/+GHqd8Va9ZSFfTPJBB9YvM3H6jdJNFC0H/wWSt8Z2sX4Ozg/YD0Q8+5e2fQxaw
         1dwWAMVd1PHHglqJACu4aEd/9UFJVPkcCrVPerv484L3Uo5keurbcZtkEngcAFnRAD35
         +/1A==
X-Forwarded-Encrypted: i=1; AJvYcCV3EQWM8Nb6s7r2pLMHIsMxKsbu6DsGW7GdWwNBpMIF9JkkQePHe9JcTTIQFr2NGWMcdo8f6n/lDWnnijU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSvNJ4LT+ZKkWrluepjZJ8s9YbsmrU+9reTpYDbi/S3JnHrV3K
	J7Lfc4PpEbpKunUyjuEuYJQCYwKCC2zSJXVa0UChY1b9XnbsPiKdg+lwXUdPnQtiovmFdku3s3l
	N
X-Google-Smtp-Source: AGHT+IH2giCB6AK7UOeGgPjHxZzeVMkrTX0peXsvssYIaa3ZOlWUGHmwGDlXFRjxw2dLm3mN2IDBOQ==
X-Received: by 2002:a05:600c:3b8b:b0:426:67e0:3aa with SMTP id 5b1f17b1804b1-42acc8d50f1mr30009775e9.1.1724576269155;
        Sun, 25 Aug 2024 01:57:49 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42b8a351d3asm57432765e9.13.2024.08.25.01.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 01:57:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: MAINTAINERS: Drop incorrect tlv320aic31xx.txt path
Date: Sun, 25 Aug 2024 10:57:45 +0200
Message-ID: <20240825085745.21668-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tlv320aic31xx.txt was converted to DT schema (YAML) and new file is
already matched by wildcard.  This fixes get_maintainers.pl self-test
warning:

  ./MAINTAINERS:22739: warning: no file matches	F:	Documentation/devicetree/bindings/sound/tlv320aic31xx.txt

Fixes: e486feb7b8ec ("ASoC: dt-bindings: convert tlv320aic31xx.txt to yaml")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6574b4910f8a..028186bb4e8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22736,7 +22736,6 @@ F:	Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
 F:	Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml
 F:	Documentation/devicetree/bindings/sound/ti,tlv320*.yaml
 F:	Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml
-F:	Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
 F:	include/sound/tas2*.h
 F:	include/sound/tlv320*.h
 F:	include/sound/tpa6130a2-plat.h
-- 
2.43.0



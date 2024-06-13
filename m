Return-Path: <linux-kernel+bounces-212649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ABA906453
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21E61F23A78
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48D2137933;
	Thu, 13 Jun 2024 06:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YjAzZdU9"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769C7136E28
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261183; cv=none; b=dVUnxBQ9xLT+SW8I6DYje9AwcDo9rxBrU7ZW/KwnCrqCGnFVkrXdTrPqIAOajqIqKGANTJEsntRfSf4o8n+06v2TccngASrZV2ZH54A6wyOwmBxOZTnHu100wOPrfzinbX0rs7dpK+Us7DoPo45odNc99iRNoec/lp7ClFEdusA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261183; c=relaxed/simple;
	bh=HnUwQRw8+EmmCDHeh1R9ekR2FkrfP6oRlwfxcSZqJAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lcjsiIjx3K39chDZYEelHJuJZ5RWeX+pz1qCP6i+ox9xbDnchyI4CoQ/AbHSWXuJoIZ3aajal+r/odQempivNnJhIb8FNIuhwuyDe6UINML/OnUT2KMopRCVvVNbDex5jXiG7o/NqqRrTHyZN8rgOr19yvTm0K9aUzhRqn/bR/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YjAzZdU9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so6283215e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 23:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718261180; x=1718865980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=waNyTEPgy/lTEeAKDYdYzjE9nxyt3V6KWTzJ9QI6IOw=;
        b=YjAzZdU9j+gF4pw8JDyQVPYIjYTvkDrCm4bjekZzz7wugv0MVciYjQ5Hq4miVJqC5X
         yvQBVPWG3LEXplvVMXtYAWAbJGcVVA9RV2/xubK4Uy+NBqnltGLoqKCLcIqlsh1dlQXf
         JYoICzrOh4554jhUzhreaB3KpGac7zFd4NnkDE1SLs+98cdglTrpME0YMo0NNRkh8U6m
         SadtfvgOaiTDfZCQKlpfbo+pHnf7/MG727zyYvgKcbj8lro1skAGp2oZP1kG3h67XlVj
         UwuDa9P0d4n307q3TrArluWVSeVVxzI2+Tf11PYzkF9JLEmL4hQuK6HP1Ek9HAsrF+Jw
         zD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718261180; x=1718865980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=waNyTEPgy/lTEeAKDYdYzjE9nxyt3V6KWTzJ9QI6IOw=;
        b=P+ZJoGrVllUkKM0hagt33fKwtEcQblWfMD06EkKy59N5pj/itcRtetBI17gaewit0T
         0tt57+l2ZCX3W/jSnLef4hgpE9yoZtq79XOnIcntafAFplphrl8ahcecskXFWTtRCcxg
         CT/oEWhBroY0wc50CNV5QtbveeUDWNWLEy3dtZiGbLvyr7W3U6wuvOaBvxur0nWJRSXP
         xRNm5bHgzS0jSDtnDY2e4BRnewqU+A1bXXWJATyEKFnSXK+ryzRnvBvpmpZrA7ri0+1U
         UpNMmaDcsquvmcV1rK6LsVApvutlh/3EQfXuXBt27jLWdDG5PXXnV/Lyf7IMEaDuFmlG
         BeHg==
X-Forwarded-Encrypted: i=1; AJvYcCXgYJ4zqcdlWgdaqYh9Nyd6RC5ciLMxc+laL7SxJur2U7YtONyHj3QNhgZQojdiofWhXgFIjm8lN5f/lmcLXv0n90RDErOIUgWeG29s
X-Gm-Message-State: AOJu0YzzNFLa0FXliLqZ+Q4dz8aCNzl6tuHtZtAs/DWgFgx3nxfbC96B
	lfRqqfyx8R/W6aJIbUbe0uxaLHDkPxeqjTFxRujMXWHBXW2k2cSNyo3fbJuUvPo=
X-Google-Smtp-Source: AGHT+IEMTAQD2F6lU9xN06fCFvo2d2TgXP107tWu/Kg76ffJSk29u7VUOkWKWUaQrQZ8NZ7/0IvxJQ==
X-Received: by 2002:a05:600c:4f02:b0:421:65a2:d84d with SMTP id 5b1f17b1804b1-422866bdaddmr31850525e9.29.1718261179754;
        Wed, 12 Jun 2024 23:46:19 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42284b095bcsm32291065e9.0.2024.06.12.23.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 23:46:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alexey Charkov <alchark@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arm@kernel.org,
	soc@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] MAINTAINERS: ARM: vt8500: add Alexey and Krzysztof as maintainers
Date: Thu, 13 Jun 2024 08:46:12 +0200
Message-ID: <20240613064612.8589-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ARM VIA/WonderMedia VT8500 platform became orphaned in
commit 8f1b7ba55c61 ("MAINTAINERS: ARM/VT8500, remove defunct e-mail")
and clearly it is on the way out of the kernel.  However few folks send
patches to it and it is nice to actually take them, till the platform is
in the kernel.

Alexey Charkov still has VT8500 hardware and plans to work on upstream,
so add Alexey as the maintainer.  Krzysztof will collect patches.

Extend the maintainer entry to cover also VT8500 DTS.

Cc: Alexey Charkov <alchark@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2
1. Add Alexey.

Cc: linux-arm-kernel@lists.infradead.org
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a472f48656a5..fb32a2fe3a79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3126,9 +3126,12 @@ W:	http://www.armlinux.org.uk/
 F:	arch/arm/vfp/
 
 ARM/VT8500 ARM ARCHITECTURE
+M:	Alexey Charkov <alchark@gmail.com>
+M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Orphan
+S:	Odd Fixes
 F:	Documentation/devicetree/bindings/i2c/i2c-wmt.txt
+F:	arch/arm/boot/dts/vt8500/
 F:	arch/arm/mach-vt8500/
 F:	drivers/clocksource/timer-vt8500.c
 F:	drivers/i2c/busses/i2c-viai2c-wmt.c
-- 
2.43.0



Return-Path: <linux-kernel+bounces-213366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A344907440
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423D11F237C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5631448E6;
	Thu, 13 Jun 2024 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zz/MVZS9"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07294DF71
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286581; cv=none; b=EVo4tOE7jVyS03wDUO1RgpvXVRmJgDmRdRvGrVBJgavPIjgtu4u3AjgYGhGa1NL98lvZGR3diZ8oPUDL5dv3SBlmIArdejTUVPlCxQ0/qR8kRbeoP0MMWC2mpzR+zBcINXMCwGRdSqFIP8wLDgkJJf3oYWN09GVJvNTlkQpWCzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286581; c=relaxed/simple;
	bh=ZqZ5SaCke+0+f3Zq0bwbTWT57JT0Y++Oi2Zpy5Uf27I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SaWdCmmoW2yGvxg7AwOlw0EOMkbtpLaY4rueTp61L1kHSRFGhT7UBVmBtl1k3NejrrHNr9Sjzj1Rb1GaFw6zywskOKcY7rE8vvOmHbfWS7juJzds6EZg22ml+jSBxpCnHNv9x4Ebp+on91lKnrAb6lEeOMg+1oxjPWJ/UYO+9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zz/MVZS9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f21ff4e6dso175731066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718286578; x=1718891378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yEvA9jroZsDs24LkJE27e1G6AbVYrGCtuXUJX4MNe1s=;
        b=Zz/MVZS9t3dUIbQHCVl1fiIqORRBTmPwWt44TZ59hXC215aqtGVLjAAYUay6dH790X
         aT07kvkVBtEyA4LDq8JakFWWPX6O+NiNr350Lw/9KNktZSRM7xtav7Ok6+xQiXuvmOgm
         JIqJ7n5AWSsJJLxM6/2aTHf3kVi3zhZL7zk1VeO6aCIQsVtVy1TXieuD7ooWSVShkY71
         /SV93pZPSqzhcY1JZN0PqXKVUIhTgr+37bT3YJ8PPTCI+Tyyn67FOtZ7NG1ndAD3HBk4
         RU5uvFeiV4wSpOOGGnSvlYc7dwJDYJ2UYg6Lsk2NVleULL1Pg9ItB69HHttEpkyQS3UN
         epAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286578; x=1718891378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEvA9jroZsDs24LkJE27e1G6AbVYrGCtuXUJX4MNe1s=;
        b=TAfIqLIISgqbWEKaYfB97jdsY7EvAOmZwoWXexyW7Z8/rREngLg0A7MX21G8imzi0K
         FPOzPLm5J0rKqRhk7ZuiN67vDa9nc0lsYfnwWN1RfMwsPeQslOhduzUME4F4e8sB9v3B
         7akecwb9j8zVOFjrayjFvcB2RlLsGRBiT9MMx7l1cUyQW3K/cvXQ1qDONWH2zZCUgk51
         3D6iEwrIFG6HDJ6YTenpMm8Jm03g5JlKkjAK0zNfigmTtEIjeQaaFgBXjjft01yT2TZn
         046zSwCy/s92QyCLI3/YKVm6GyHQHs3pWq+7Lkl8T88ibVBPcQ8xG8hR9qXY+4iet0PB
         U+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMg6HBg9uma5J0OV9veUji70Gk1g+fVsMzBqkZJXGSRjqHSVi1EHCNVIP2EBd2LodjqUsXu17ev1X1lt2hvezMD8Eo5onJ/KG714ZG
X-Gm-Message-State: AOJu0YzK58W92dnUtoAoC4g3PUVxaveXyoG3Ul0fBKrJZ8sL1PuUrhwP
	TtzebEj9bl09U1J9AwUmcnvbAKFr/rvN6Y+V608OQUIv2ovI7Xf+mqoqBVoxRCI=
X-Google-Smtp-Source: AGHT+IE8JSarZGMRvnKm1sM0hW1gVfIATdlYWc5pmUAEWGuxrgcsVbMkkFTyUXFdWA7D5wJfcseu7g==
X-Received: by 2002:a17:906:517:b0:a6e:2a67:7899 with SMTP id a640c23a62f3a-a6f47f7fc60mr284236566b.35.1718286578234;
        Thu, 13 Jun 2024 06:49:38 -0700 (PDT)
Received: from krzk-bin.monzoon.net (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56fa4030sm73785166b.207.2024.06.13.06.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:49:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: arm@kernel.org,
	soc@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] MAINTAINERS: ARM: axm: add Krzysztof Kozlowski as maintainer
Date: Thu, 13 Jun 2024 15:49:10 +0200
Message-ID: <20240613134910.7862-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no maintainers entry for the ARM LSI AXM SoC, thus patches end
up nowhere.  Add such entry, because even if platform is orphaned and on
its way out of the kernel, it is nice to take patches if someone sends
something.

I do not plan to actively support/maintain AXM but I can take odd fixes
now and then.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e7fd595b8f5e..60f2815f0453 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2127,6 +2127,14 @@ F:	arch/arm/boot/dts/aspeed/
 F:	arch/arm/mach-aspeed/
 N:	aspeed
 
+ARM/AXM LSI SOC
+M:	Krzysztof Kozlowski <krzk@kernel.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/arm/axxia.yaml
+F:	arch/arm/boot/dts/intel/axm/
+F:	arch/arm/mach-axxia/
+
 ARM/BITMAIN ARCHITECTURE
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.43.0



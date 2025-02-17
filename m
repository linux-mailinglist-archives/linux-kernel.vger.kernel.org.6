Return-Path: <linux-kernel+bounces-517223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B94FA37DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0787518855BB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAEB1A23AC;
	Mon, 17 Feb 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rbGUjWku"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F54F16F282
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783125; cv=none; b=X89jSkubiehmq+itdN4Xf+q0ufwwn/9yyfzyashZTYQmPrGtqPefeaXtLdBl2biBnc8eqf7QfKjtpOqLzylPbAv7+GsKOQzOBFr12KwUjBaIhd/GMljJ62yFc56nvWEckbZOmfoah3bbZnhsDmU9idLTbJJg76j3iYCtNCNxk7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783125; c=relaxed/simple;
	bh=OBVrMRKR2coUuMzaqQ/NC0Ds0+R4Lpt/Gnq5MZCw5TI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sLPXNAn0lnnp2Uu7x2UTgbWP+hW6C1AJVdtUd9UUM0R1csR9VqaVkS7f4EihVOykRlwYmArBR4uq1pTBtp01wwAe3eRnYMoQWMbHr0HacNaqBXYEyqQdwwB6MgWBAkCYkNWBpy0NXPqLZTaEjxyFXS3WY8jj3kq0l3CZKuFEyag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rbGUjWku; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb64620031so21227366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739783121; x=1740387921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CmyIFYQ0ZEfR9O2k5FWwdkgo72h3+vhymfD8Vqk6qXw=;
        b=rbGUjWkuiO5UeAZOZFsdulRYumVSUpesGjfvZhKtqwGuCcEWxMOVrFfXq1x7hGYkTV
         c8LooMJeAs4rJtSLbdXXvfiU1HCYkNbD+bN5JTK2OFdbTmS9AtV0A6gfHjEOvemP8I7Z
         vN5WHh0z6QifgbH8j1AXSAmad+qEFG5uKVxw+WzO1DSzpv9Xlx9WVPjnrmpaE68onbLz
         F3EO7iwEe7i6giB9U/NMIH2+NKgpoECeMbOX5vbm9dWNxvhrj+0JkpEXexhSKeXjtIHB
         I8M3gB8uW5m7tqyX6Eo90ICRkPi9AVE/hKUGHrBbHhgdBOxEjfOcApOrMVeug6e1o3xW
         CZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739783121; x=1740387921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmyIFYQ0ZEfR9O2k5FWwdkgo72h3+vhymfD8Vqk6qXw=;
        b=aca18lnxfTFu4NIh207/yAR6qYCWVmXIqrUsuH/Chp9uVmzEcGFO0AALAdTulQ+u3c
         eJOdQtLCeYtGRvY5AHtxU5WrT5jKdaZikG8d9E3gE/KuNAJf/73W1k4Wfk/kbEywx7Rs
         8WRFgKhuiYOQN8YT+H9z9rvrJEL3NVELXp7t6btL8NLejy4Hxee51Vy4Fbo6qBqGJxKE
         Apn1bJaUoZbbVp9l/dP8BvK6EhOnE7OK6zY0cKXhLTdwxx7AWFk6FHi1JnKhmJI+1jJC
         Ozi1ZBBbUSb2QCs7kuU/IE4RyXoV8ygngD/dSfxK4X2wiH54VWBnN9Q864oXjQOfUz+8
         U4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCU67OPHcL4vBIYMHaXuu7RfBhp2t+01o65TLhiDMUoBrWOf62zs5A9H77eO91g5ZuUF10euBO2h3gvNvL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhRyAB3lb5aupZEarKMGyk6XIITN8KIJB/D4ik14QvH7Sh/Ij
	ZlMuk1fHvLt7s0Bi0WOWMcJIr6LliLpjjwBzunnzY6lGnWqX0VAlfpyL2EKlJxU=
X-Gm-Gg: ASbGnctiTTXBPlQ4ShKehIaskfR4hRt43zzhZbj0Kxr5/jI+70MnlC5zqwyYbHAkbQA
	HMtlAqB/kp4oMoCqzDtDzHteWaKJDabgTOinkvAH0DBRO5XbdGX39eoYkRtyIlNKxj6+IOwbwaI
	hmLkuePM75bkxEDoq2oosq6mzZKhvRelHKBjdoqBBmZFDJr/6GJ7QT1ZUuJidOEjdAeGtUG/a2X
	uQw1H3JW01NiQfJYM+egrdvny71FOyn9Q8oss6PUBbk0wFS+UD6gF/J3mKm9QkQyGtwUGWMfXPI
	96+Jg+WIl08CFAfOxQH790M5hK4v3A==
X-Google-Smtp-Source: AGHT+IFUhQJFGvkV4VP3XiKSdG8YIKa8uiSi/ja19wDelIasVTPOFlIChwIzjHuRzd6GvUBWD2iWsQ==
X-Received: by 2002:a17:907:7248:b0:ab7:82a7:bb1f with SMTP id a640c23a62f3a-abb70d96de8mr341479666b.10.1739783121482;
        Mon, 17 Feb 2025 01:05:21 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8190d1b6sm368833466b.36.2025.02.17.01.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 01:05:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3] phy: exynos5-usbdrd: Fix broken USB on Exynos5422 (TYPEC dependency)
Date: Mon, 17 Feb 2025 10:05:18 +0100
Message-ID: <20250217090518.137606-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Older Exynos designs, like Exynos5422, do not have USB Type-C and the
USB DRD PHY does not really need CONFIG_TYPEC for these devices at all.
Incorrectly added optional dependency on CONFIG_TYPEC caused this driver
to be missing for exynos_defconfig and as result Exynos5422-based boards
like Hardkernel Odroid HC1 failed to probe USB.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Closes: https://krzk.eu/#/builders/21/builds/6139
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/all/3c0b77e6-357d-453e-8b63-4757c3231bde@samsung.com/
Fixes: 09dc674295a3 ("phy: exynos5-usbdrd: subscribe to orientation notifier if required")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Patch for issue in linux-next

Changes in v3:
1. Simplify and go back to standard optional dependency without
   intermediate symbol

Changes in v2:
1. Add PHY_EXYNOS5_USBDRD_TYPEC, so arm64 defconfig will have both
   symbols in-sync
---
 drivers/phy/samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
index 7fba571c0e2b..6566100441d6 100644
--- a/drivers/phy/samsung/Kconfig
+++ b/drivers/phy/samsung/Kconfig
@@ -81,7 +81,7 @@ config PHY_EXYNOS5_USBDRD
 	tristate "Exynos5 SoC series USB DRD PHY driver"
 	depends on (ARCH_EXYNOS && OF) || COMPILE_TEST
 	depends on HAS_IOMEM
-	depends on TYPEC || (TYPEC=n && COMPILE_TEST)
+	depends on TYPEC || !TYPEC
 	depends on USB_DWC3_EXYNOS
 	select GENERIC_PHY
 	select MFD_SYSCON
-- 
2.43.0



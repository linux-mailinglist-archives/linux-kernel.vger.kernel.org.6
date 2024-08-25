Return-Path: <linux-kernel+bounces-300518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC1D95E4AC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 027CDB212A6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367AF1741D2;
	Sun, 25 Aug 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByoTvzKt"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD01714D9
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724609159; cv=none; b=BLSYj4CYlaMJ4E5Ay9hEq28jUVBhpdJas26vBwL0gzQZEzQL/KyZClGbKaVQ0Nm10HiX2Edq4AjspyumSK1WXCA7OdAjC43rox5ROWor3jLffdFYuQZIii3lPJ2cm4y6kJMbGVVqUStMLH+2TrzvJid8qRhpM4PQ2JzsuXQHszw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724609159; c=relaxed/simple;
	bh=/iX2lwrQe9MmqSKr9pDmH8EVTSENP3ZuL4P3UVBcTPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=onhBrXyYuFxRaHujKQumgy4uKCt2I7U/RnSrpWXt11OO5I4K+4YSD6CDfAXWRQ0ED7wddsrzmeH35J/uCUwyKW5vsSFxGizPv2CNZTgBCAuvuGNdpARzWAsH4rgbc1CI2PZyu9tqCof2NIOH1ZfKsT7EJbaZfyK5uh1wWQfe6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ByoTvzKt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4290075c7e1so4511635e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724609156; x=1725213956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2fDrWsY1iZgM+nyCAHabCHTNPvbQeS69ZzWK0rFucpI=;
        b=ByoTvzKtReakfCSMoq9DO/vC+Rhp2qhYHh5VtEmhGtTf8p70oQqKh51izEovZ/SjCw
         LmUux1JjBCQahxC/9Mv1aB+jxitaBg3wG/HxuCxD4Q9K8Ef5iM010Yc6fu6x4DbJZG4E
         tn1vDOwK/lxjnXN/Kgup+vF7qC/gf7/Lma7ohHZ1DuuV1YWFu7DloY0I090al1AKBp1I
         HxidDqbJcFR6L9KOEVX4WejOUm7HNxZvr1fypdpCAAwGl+ic8hAbSRvv4LmUB1D9Ly+s
         JtEoBKh6u0bG7rW0kRvRfT0qdUeBPQygGaADmHxZd44ccWLqNc4Nqck2F86Q7lfmLKgU
         m12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724609156; x=1725213956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fDrWsY1iZgM+nyCAHabCHTNPvbQeS69ZzWK0rFucpI=;
        b=YbpZJIcjW4izpKDTRWBYu0HqxZOFitRDOw7K2Qo6yXVf3muDRXdTSgijl/cx8VLRlY
         Cga6xW7hJdam/ikSdhe5MAVybB41844fRXGM5OzPbaDrFvQqIok7ekJmljjsVpR4q2fW
         jG3EivPYjr2miqj8MXVbhXKmD/4sHIp5aQuxB7J/Bn08y/WWQl99I3G0VjGVqBInZJ/0
         hZhz9ElTbiNN6iabFyXp2THt5+OPVHRsPCsGN5Bx/3yIbi9271jr1ZPwQOVPsAS1LAx+
         RfZfZWhc+gGJUb5/xW4xBkqXWz8srDzy+x2rrlYOtKiLR0zvPhUz63yaNJ5v4+Ktcx57
         85lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEKP9VGyXTDl+O7JD5Ht+iJdiTOiJKpu1MgIametEbAPCe/UC07Rmp9HTvr/8erTJRkruOnMX3kvJnGhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Auci5cNzolcZIz/hkA+yotkrlGciVyakvzl9SjTmHHv4V2f5
	XH2EcTUNRgJ9d4OiUUZbwedxVJ7HjQbckVmVSH7VMDnB0qVYSEjPu/CseQ/YvDI=
X-Google-Smtp-Source: AGHT+IEDYNS7iJF8sbKwxKBJ35bmHiraIvVb0X9+WzzxjqXzAuTu70MfBmpEuyUqMcMxv7uaH6fBeQ==
X-Received: by 2002:a05:600c:4445:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-42acc8a7756mr33568245e9.0.1724609156014;
        Sun, 25 Aug 2024 11:05:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37311dca113sm6438736f8f.16.2024.08.25.11.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 11:05:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 25 Aug 2024 20:05:25 +0200
Subject: [PATCH 4/4] soc: versatile: enable compile testing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240825-soc-dev-fixes-v1-4-ff4b35abed83@linaro.org>
References: <20240825-soc-dev-fixes-v1-0-ff4b35abed83@linaro.org>
In-Reply-To: <20240825-soc-dev-fixes-v1-0-ff4b35abed83@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1712;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=/iX2lwrQe9MmqSKr9pDmH8EVTSENP3ZuL4P3UVBcTPw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmy3J6dz7Weq/ta3ekEdu3b9XYUa4uI5fiye4RS
 6JUBZJSWqeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZstyegAKCRDBN2bmhouD
 13hBD/wLP4PBvPVVbcABSQEE4DtJV2kF7Kk0LFiYeTx8O4xZb9nDIt/oQzKGYrwwIRBHmlvdSDv
 9ZMctbNkN+ArrhA39bSQ1nNjIjymsEaZaSe0tLnWn0GKu/MDdtbQOzYhSl/a15/33JUJxdSB+b4
 SIQNahan0N3O703qOJ5soQYAS5GCXop3nYfj1qniBwgllv9Le9dNRlTjjyWTltfWMxmqTncYvDI
 Xzgw8DkNi/q7SAqMm+HkcVVdxWl737M/XHsrFe1XSCqhmhf/RFf9dT2Pk7xj1lNZ6xig/f2YsIy
 nqb8yGZ0gseB07NjchxINBWOinC5WCJgp4vfnGwmaljn+y/JzUdcN6ELkgQR52Dp31uRDMkJ5rD
 fG3vT7pumB+Izu9zj5WVmZ301FrupehIXCRCg09ESXfXXjmov5VmBdO72RIUMznVxjgklW/keKd
 8AT+yYJT1BSP15gK8eBGi0Lnu4LKcv1G37O89eAa+OkPJsno0ups0XFZtunmHolYf/JzzhHkVr4
 oh+HqIZDDfWEV6Od2XXH0TMVzCh4b7/f745Epol8BsXbbq9y67hhX4Q02Il/oZJ7YibLtMWZVo6
 mB/pFRaMA68NiqoNhDPVNgXPv8A/kqQnSMu9ApU73jEe3RVeop0Rgi79oTRn/kelkcjYdk+9nwk
 hgaYGzoyd2i6K3Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Enable compile testing for broader build coverage.  None of the drivers
use anything from "asm", so code should build everywhere.
CONFIG_PLAT_VERSATILE is being selected by driver dependencies
(CONFIG_ARCH_INTEGRATOR and CONFIG_ARCH_REALVIEW), so directory can be
always added to Makefile targets without impacting other configurations.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/Makefile          | 2 +-
 drivers/soc/versatile/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index fb2bd31387d0..56f476a12847 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -32,5 +32,5 @@ obj-y				+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-y				+= ti/
 obj-$(CONFIG_ARCH_U8500)	+= ux500/
-obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
+obj-y				+= versatile/
 obj-y				+= xilinx/
diff --git a/drivers/soc/versatile/Kconfig b/drivers/soc/versatile/Kconfig
index c3792c0a84ac..7bbf54a8d879 100644
--- a/drivers/soc/versatile/Kconfig
+++ b/drivers/soc/versatile/Kconfig
@@ -4,7 +4,7 @@
 #
 config SOC_INTEGRATOR_CM
 	bool "SoC bus device for the ARM Integrator platform core modules"
-	depends on ARCH_INTEGRATOR
+	depends on ARCH_INTEGRATOR || COMPILE_TEST
 	select SOC_BUS
 	help
 	  Include support for the SoC bus on the ARM Integrator platform
@@ -13,7 +13,7 @@ config SOC_INTEGRATOR_CM
 
 config SOC_REALVIEW
 	bool "SoC bus device for the ARM RealView platforms"
-	depends on ARCH_REALVIEW
+	depends on ARCH_REALVIEW || COMPILE_TEST
 	select SOC_BUS
 	help
 	  Include support for the SoC bus on the ARM RealView platforms

-- 
2.43.0



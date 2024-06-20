Return-Path: <linux-kernel+bounces-222497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3187B910276
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D761F21B85
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0621AB904;
	Thu, 20 Jun 2024 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9dTn8PI"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E484A1AB534
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882693; cv=none; b=ihaSGEXE7SRphkC8w9FyiHRVu6AXAxtCQ5pm1SGHeVJcfAjUg6XQlUpMlKTX/Q5byMtI0qUXKMV4lhDR39mTmg8IRf66kQS2oPaSRMVzaTnryUkyugh6gwpjKF0KN5ULnunLmgZMKshC/aOm3PGL38tFN49Z1qWbu2ynjbKYugI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882693; c=relaxed/simple;
	bh=4ds6lgEBHypbXsdx34WZF0wcW2UxEYrxEDqsfQYnqds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CpuHDjMDsYjHWB9zdbO9pO7K8K79H3HicxKi5G2WseL7BV2f72d69vS7GaFNEeiWYbdKqOhvdn1rl1cDsn39IXV0raMcm3exn/oXJFgVG/f6ufyRp0fkQa2yN8bejdzCtIToTqkxwhYUX3Q0Qv3iYQ/ihdKqEW5EiCfVKKW029I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E9dTn8PI; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec3c0dada3so8715731fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 04:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718882690; x=1719487490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gCJG0Ja4O3W5+n0BOGZ+62h9PoJVQnw5m6Ruy1ZerC8=;
        b=E9dTn8PIif2iwk+5mcX7bV2SXNZvuYwd6vx1Vx/DoOfLHV5NaS2s8SPO7+vl/V9zVR
         fi33yjm9G7WPvD1GVcy2u180gLHLcYn8j6rPG0Ox56VDWoL4idt7fgpucV2SAOunIz/H
         zX2Vsd0UDqS2+vcH4nnFRxJuIvBswkj0FldqRdN4L97g6td+kc2YFs6iaSmVkKxuyeCt
         fyeh8qjMT66JClXV76TkXROK9Saz8ksUg56j7J01gkM7sFuSz4CkNCU3D+r5shrQldDp
         TTqhQpCwYad2KiVDQ4pPJ2vqz0boiyS9by6bVEwBIaFwJiAHzNb9dMki9b80T2g6RQH9
         GU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718882690; x=1719487490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCJG0Ja4O3W5+n0BOGZ+62h9PoJVQnw5m6Ruy1ZerC8=;
        b=FyN8l5eAiLJoT14+szRFBnDW4egGcWldmgi9gHm3VEr4vsWR85PAdCNsn1bhUTi1nM
         KHnNF8v4iKaTwWahOpvDMpsZqISVoSa3ukO2JS4Qn78i5Sz5zvgf4SKK4ToFp6+5rZYW
         XDXmojSZ1VWR50wiQgByrcAbEMil975C7bBhPbX83ctAvUBm1caANOzlGumrshL67RKo
         TzSFJgiVEkTbi3YW/+1wM2t3tI+KnL5Cu/TX6CWlfGfwvTG1DP73DMhkBA8R6Nvtruw5
         K/7hgPPED66hxalFeU9VkBtpEb5DF8tWCSXgNmiNkQj1NH7XJxP0LXMZN4vUFTkXuj66
         T55Q==
X-Forwarded-Encrypted: i=1; AJvYcCVT2MSMmeyCg6TRqLLlWzbTcnNguPgMjXvjONY0pO3QXCkLdpsY8CZCCfIC1FXK1PqqWxpmVM8nKDYMfimfrPX7U9QdrXKmko6FpN18
X-Gm-Message-State: AOJu0YxjMF2KH/LxyBbeG5URMGzrr6xM+/8mRUqXsfSj+U7xxLMkG63H
	rn6LTsKEpvXh3pPEKkev+qR1wO5T0TDbFWplvUJVdWfOy3Ckag2uMdp3VzGGDlQ=
X-Google-Smtp-Source: AGHT+IFa6EadGkjUelwniOpcoV8wjGzlajwf0CUb0A6oVYtvqsnZs3ZgSbMRkdrUCg8xWmBN7N855g==
X-Received: by 2002:a05:651c:20f:b0:2eb:f6bd:e4ec with SMTP id 38308e7fff4ca-2ec3cea1b44mr37772661fa.24.1718882689841;
        Thu, 20 Jun 2024 04:24:49 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510::3aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3647bf3092csm2025371f8f.97.2024.06.20.04.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:24:49 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: lee@kernel.org,
	arnd@arndb.de,
	krzk@kernel.org,
	alim.akhtar@samsung.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 0/2]  Add syscon of_syscon_register_regmap api
Date: Thu, 20 Jun 2024 12:24:44 +0100
Message-ID: <20240620112446.1286223-1-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lee, Arnd, Krzysztof, all,

This series adds support to syscon driver for a new of_syscon_register_regmap()
api.

Platforms such as gs101 require a special regmap to access PMU registers, which
in the existing upstream client drivers are accessed via syscon regmap. This
issue was partly solved in [1] whereby a custom regmap is created in exynos-pmu
and a new API exynos_get_pmu_regmap_by_phandle() created.

One issue with the approach in [1] is that it required client drivers to be
updated from syscon_regmap_lookup_by_phandle() to
exynos_get_pmu_regmap_by_phandle() when obtaining the regmap.

Whilst updating to exynos_get_pmu_regmap_by_phandle() was OK for exynos
specific drivers, it meant other drivers like syscon-reboot and syscon-poweroff
which span multiple SoC architectures could not be easily re-used.

In previous review feedback for USB phy and gs101 poweroff driver Krzysztof
requested [2] that we take a more generic approach that other SoCs can also
leverage.

The new of_syscon_register_regmap() api overcomes this limitation by allowing
a SoC driver like exynos-pmu to register it's SoC specific regmap with the
syscon driver. This keeps the SoC complexity out of syscon driver, and allows
client drivers to continue using syscon_regmap_lookup_by_phandle() as before.
The solution allows more code re-use and can be used by other SoC archs.

Notes on probe ordering

exynos-pmu runs at postcore_initcall, so all but one of the client drivers
(ufs phy, usb phy, watchdog) run after the regmap is created and registered.

The one exception to this is pinctrl-samsung driver which is also
postcore_initcall level. The exynos_get_pmu_regmap() and
exynos_get_pmu_regmap_by_phandle() have been temporarily left to support
-EPROBE_DEFER for pinctrl-samsung driver.

The longer term plan to solve that probe ordering issue is to enable
fw_devlink for syscon dt properties so they are correctly listed as
suppliers in /sys/class/devlink. I tested a PoC patch (see below) for
fw_devlink and that seemed to work fine. Once fw_devlink supports syscon I
believe exynos_get_pmu_regmap_by_phandle() api could be removed. The main issue
currently with fw_devlink syscon support is the wide diversity of dt property
naming currently in use. That was discussed previously here [3]

1248a1256,1257
> DEFINE_SUFFIX_PROP(syscon_phandle, "syscon-phandle", NULL)
> DEFINE_SUFFIX_PROP(pmu_syscon, "pmu-syscon", NULL)
1358a1368,1369
>     { .parse_prop = parse_syscon_phandle, },
>     { .parse_prop = parse_pmu_syscon, },


Note one previous concern from Saravana about syscon potentially probing
before exynos-pmu driver and it relying on drivers/Makefile ordering. I tested
this and even if mfd is listed before soc in drivers/Makefile exynos-pmu
always probes first due to syscon driver not setting a .of_match_table entry.

Once the syscon and exynos-pmu patchs are queued I will send patches for
watchdog and ufs phy drivers to switch back to syscon_regmap_lookup_by_phandle()

Many thanks,

Peter.

[1] https://lore.kernel.org/linux-arm-kernel/20240219204238.356942-1-peter.griffin@linaro.org/T/
[2] https://lore.kernel.org/lkml/06383015-51b2-4f4c-9fd8-e4f7ce12f44e@kernel.org/
[3] https://lore.kernel.org/all/CAGETcx-CCpaV7R0O0HpDpoX6KxQBuJiMmKdWA8nDE-5Qj2Sa7g@mail.gmail.com/

Changes since v1:
 - Collect by tags
 - Keep syscon lock held for check and adding entry (Krzysztof)
 - pass pmu_np not np to syscon_node_to_regmap() (William)

Link to v1:
 - https://lore.kernel.org/linux-arm-kernel/20240614140421.3172674-1-peter.griffin@linaro.org/

Peter Griffin (2):
  mfd: syscon: add of_syscon_register_regmap() API
  soc: samsung: exynos-pmu: update to use of_syscon_register_regmap()

 drivers/mfd/syscon.c             | 54 ++++++++++++++++++++++++++++++++
 drivers/soc/samsung/exynos-pmu.c | 38 +++++++++-------------
 include/linux/mfd/syscon.h       |  8 +++++
 3 files changed, 76 insertions(+), 24 deletions(-)

-- 
2.45.2.627.g7a2c4fd464-goog



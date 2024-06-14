Return-Path: <linux-kernel+bounces-214987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A893908CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09B31F230FB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6DEBA38;
	Fri, 14 Jun 2024 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRU7cHE8"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02FC7464
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718373868; cv=none; b=pL0VfsBaxth4SWzGl9UhKcq3JwXqMF1fMWvki62jObwXD6QhSJoOBT4UqokZbN9v+2gH75yuPIYWsISm7E8G7GJKnFvot4lP2OuU1THOms4uPc6qXKUOkCF4zawGNCJOo+pTuHUuPHXnp5m8KbvldG0fOq+/AeZRn8HkuhMaLpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718373868; c=relaxed/simple;
	bh=f1I2izaEwdrTKDYFgUwTYTY2ennzgeG3p5+KWbrZfU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QoOo6RFxxLxLqF2MBcy00+jfAkIl53nctInhQggeE7x3I/CblxdbSWBndDFQphKB84XWsJ5P6kl+iuK6eMJn1HtRRSf7UFtG4Tvx6DcrJwYcN8TSb6o1XNuUZIQ28cBKwfVFWJdIOWt2+KglXdGbzb8YjJKlK1CXyVCxkjamLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VRU7cHE8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so21148831fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718373865; x=1718978665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=db7sE7gdNSfDkTH/SLqMSnZ6L88Gths7vYb0/TqgdKM=;
        b=VRU7cHE8onUruAckfm/Pei/s14IHKQ76HTih5IKInperyjGpL4iylm3s+IUBvHMgKi
         LxJanpHIgQcJTvvTRGAp7TcXBV8byENsJQHZMzNbVJbrg7azXfzfjxN0OvBFRcpbW56g
         pkQh1vIIVHl4J6U13G3Mwqaky3FGieaYEoM6CNKXyg4XjneKDfwF27dxcENaisFLbZ6w
         CZyVyD84Wyq/fV/8XBq58tUbq75kWWwcRmYCysX6adH/+A+Eo/36qGlbTszJRZ89xIub
         6UtNB1iwDpCaMfAvIEM8UkGRoG3Q76DyrYLSCmjyc0Ym/8E/zb+dHHJcRzcQ+brQxkR7
         jATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718373865; x=1718978665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=db7sE7gdNSfDkTH/SLqMSnZ6L88Gths7vYb0/TqgdKM=;
        b=oYPOXsLW2vxrreHGbzb/D61pyfjsSO0+OLSMOQXoiTqBgt/09BdtWM16e3XGTdr+Jz
         qWovz2Kzu6L2krt7AIPd6WQIoD6O8svatkhQ3RNdKHO0tiuPrSHXORwXrSA/IN1c7YE9
         uOUJbMWsuwFWm86w4h8COg9tZ8kGhhHZXHwQigOfOxzTYuXtMYS47WPFliPPl89fGRw2
         CZTgiK1G2aH1A7eTD4/oUc8JAkpdZkQl+lbJZ0vz8KBkrsLG2NRbDJKzkwzssIeHpr3l
         i7nyrK6XsKRehSg75Z4ul/Es0CRvhH3SiUK0SBGcwbOk3WetYs9+qwV0IJwRpByyQR2m
         qnxg==
X-Forwarded-Encrypted: i=1; AJvYcCVjijvZ+Y1+uJU3qFs9Dm+iL2LOWg8xJIHqyFE0uLrbJ2K4SSYBTjof2dh7SHxb3aokCCkdmGFhCnVnY8EnvhmNmm9F2gt3iCInELUE
X-Gm-Message-State: AOJu0YzHX1fO+K5V1VGCLtbj7A0m5bH8qInqfqrlNuFjjjSpXaTZyxPP
	ZbWzrh4RVl+YibtMR9TPHKMxIU32EdIs7QUFfODRG48+U3JrwTWGf6VfbAQ1fHBYam5qqgPXHXk
	r
X-Google-Smtp-Source: AGHT+IEQ/9CdNafN3ICQ2QfdqLMQd7VY1Js0/I455oOeWFuzmq38dPh57KkFo8JhwUZcxnxpU6JvAA==
X-Received: by 2002:a05:651c:547:b0:2ec:f8a:6f11 with SMTP id 38308e7fff4ca-2ec0f8a702emr17969671fa.9.1718373864725;
        Fri, 14 Jun 2024 07:04:24 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510::3aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33ccesm61310525e9.3.2024.06.14.07.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:04:24 -0700 (PDT)
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
Subject: [PATCH 0/2] Add syscon of_syscon_register_regmap api
Date: Fri, 14 Jun 2024 15:04:19 +0100
Message-ID: <20240614140421.3172674-1-peter.griffin@linaro.org>
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
watchdog and ufs phy driver to switch back to syscon_regmap_lookup_by_phandle()

Many thanks,

Peter.

[1] https://lore.kernel.org/linux-arm-kernel/20240219204238.356942-1-peter.griffin@linaro.org/T/
[2] https://lore.kernel.org/lkml/06383015-51b2-4f4c-9fd8-e4f7ce12f44e@kernel.org/
[3] https://lore.kernel.org/all/CAGETcx-CCpaV7R0O0HpDpoX6KxQBuJiMmKdWA8nDE-5Qj2Sa7g@mail.gmail.com/


Peter Griffin (2):
  mfd: syscon: add of_syscon_register_regmap() API
  soc: samsung: exynos-pmu: update to use of_syscon_register_regmap()

 drivers/mfd/syscon.c             | 48 ++++++++++++++++++++++++++++++++
 drivers/soc/samsung/exynos-pmu.c | 38 ++++++++++---------------
 include/linux/mfd/syscon.h       |  8 ++++++
 3 files changed, 70 insertions(+), 24 deletions(-)

-- 
2.45.2.627.g7a2c4fd464-goog



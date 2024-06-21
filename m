Return-Path: <linux-kernel+bounces-224601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E41491248C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAD0284150
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8CA17554C;
	Fri, 21 Jun 2024 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P3PxiIeg"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B373413D615
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718970952; cv=none; b=FScCH2iu47+XmaK/LkFddBSmR9zqay49v5I58MIny02AZLcJ6Hj2cObUGYNmYjZQZNF539JgFCqtQm84CUE30m15Uogrh+Lny9jngHR7JpgrHuFherG3QHwVfme7q2LYW3S7UE1l/bVuJlyKSHmEBy+4y5MH6NaPU10zdsyYvFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718970952; c=relaxed/simple;
	bh=gIYUPaRLaqQdrTEadtQVbh9QzpoHT0q2BKQGmXoTq3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U82Eq1IYIDuX+m44m4z4VdBHm38NsoHg0YOoxJBGtxo5gKRLNP+t42kzLuC/isjB4oHcw4eOaY9/qrOTlAkrSdjX4FdiKp6VKoT2CM3/iNW5V2TsGt0C/g+EEIwbxla4vbqrkaavQPK2pUS2Pb/zKDBZb08QqkYBIyBFl45o+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P3PxiIeg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4230366ad7bso21848675e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718970948; x=1719575748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PCo1F6Ya6OR/yQ3uF5qfJxG3DZzXGFh5E4PjRee+Y8I=;
        b=P3PxiIegdjukZ5RoJbZ+iua/AQOSvTb0zI6+zw7D22mM5Um0EuRGYE1rY8cWrL/nyz
         ZRRAEY8BHfvA/LuV2dZjwd8HmiKLs5pwMBNUKExJYRYaiZgJ945N+5yge1CayIFsjHAq
         w8r33Ah9D9YrnXXU2m1g1gumm3tXvUwUKwRym3ZTorAvSLAcJUtpsZgLO6TUnZjQvFEL
         d2iQZnAfsa1GK6geFVW1WyVQxEaxQRbwoPYBNbHz2xpO08TlF52Xpf73vgAlRzL9Cx1s
         JRNMCmDn98yfHuCsRXfj6GtUk7vYBhocKiuev94M808sfI03Oz3Z5g32t9yMAqNQZkyx
         T7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718970948; x=1719575748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCo1F6Ya6OR/yQ3uF5qfJxG3DZzXGFh5E4PjRee+Y8I=;
        b=vB+6mpIHT/G9e3QqsOnMAAn6Ql8ywPlq9SD9KH6NbVqaWABddYcQH4BqFB4bDqL9hD
         X/ukHhylOTP8qbYroLQWmxuK3bPZUMRhdHKIueQP0tAyXZ2m/gyZ4SKNX2UyAvWdeAtE
         1507yrZSvVBw4V0pnsr9RQ4r8CLvgmQ/VCd6Tcl5kHW8BUqU4E/E3ode/jKDTIlniDIR
         /l/1FEb+9RlTW6LoHpEz70nS3yNOtRsLl36d3ndjZwPsF1d6Jz4h37A8apg6XMWNFP3Q
         3ZNjC2iI6m7rS+cssiqIHeabTE5At8NMADzs8vSDzV8RC2LI+ZuMfibx8UTEd9eBnx3p
         mI3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOPfTBOZHPSsz3ifWWgyUdFxlZR4I9Dxoem9MSM+Q4tHHQj7pb4dh/fY9HN9evdI61y97P+6Oj7c6g4WcJdzt1WS+Zex6Y2OE5MgXx
X-Gm-Message-State: AOJu0YyhAXyV80t51sUCqMae/dXIVmp6T/OiT0H7DRSPiFcKz4MiyPL7
	8bDjfc44DC4sWOqO5JhWMKAOdjfQQv4I0ujnNkLIZcI0jHRbV4g+w1vLRwYOtHM=
X-Google-Smtp-Source: AGHT+IG2ZzeF2yecrvNq84hEyosATlepWWCUYD4rioXxs0/RdSHjwr3JFRh5RYSXgIR/x10AU78J2g==
X-Received: by 2002:a05:600c:6a8f:b0:424:7b64:18da with SMTP id 5b1f17b1804b1-4247b6419ecmr62155565e9.0.1718970947732;
        Fri, 21 Jun 2024 04:55:47 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510::3aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208dcesm60386725e9.31.2024.06.21.04.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:55:47 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Add syscon of_syscon_register_regmap api
Date: Fri, 21 Jun 2024 12:55:42 +0100
Message-ID: <20240621115544.1655458-1-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
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

Changes since v2:
 - Move allocation outside spinlock area (Arnd)
Link to v2:
 - https://lore.kernel.org/linux-arm-kernel/20240620112446.1286223-1-peter.griffin@linaro.org/

Changes since v1:
 - Collect by tags
 - Keep syscon lock held for check and adding entry (Krzysztof)
 - pass pmu_np not np to syscon_node_to_regmap() (William)

Link to v1:
 - https://lore.kernel.org/linux-arm-kernel/20240614140421.3172674-1-peter.griffin@linaro.org/

Peter Griffin (2):
  mfd: syscon: add of_syscon_register_regmap() API
  soc: samsung: exynos-pmu: update to use of_syscon_register_regmap()

 drivers/mfd/syscon.c             | 48 ++++++++++++++++++++++++++++++++
 drivers/soc/samsung/exynos-pmu.c | 38 ++++++++++---------------
 include/linux/mfd/syscon.h       |  8 ++++++
 3 files changed, 70 insertions(+), 24 deletions(-)

-- 
2.45.2.741.gdbec12cfda-goog



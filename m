Return-Path: <linux-kernel+bounces-553318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E882A58767
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9EB16A44E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021911F874A;
	Sun,  9 Mar 2025 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ztMzmngd"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E625F1DF279
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741546571; cv=none; b=ujrUJt3oAvtDpCDJiaCIn95+HieZCNvG5UKEX0/K1aoAalqTV+vlhIJsomRiXBNK7ftsinNYy/njj5L1+2Z7iZLeK54rSP/2gh9fzhW1SvB1lzghD5XgkciyhM08KF6WClKY+twsK6LqkwuRLj45+v31UZ7g+jP+fFG7dAhK4No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741546571; c=relaxed/simple;
	bh=Wa7r3qkuu7xnz/VOd3o4Ss+BQayKG/5FMUt/lzJsU2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gblqqmhyuzNY43BGb0M6J4iN5FrQ//bN/u67B2vOTcw7OMn0mESEjFiEhKePk0xZizZsFhmwLRUJJB+uNUjA+IwTyp8bBh3qyYg0/+d5muq+m5pNJ64Vg9FItlSyWNYE7dG1sJ3rlafU0fRsCe1DRGsv5u1b7c9C9OgbwyJUi/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ztMzmngd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3912ebb8e88so239505f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741546567; x=1742151367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYpRuX79H42AyJwMpeb72MjPa6wN8mVoMbygXkMxqYc=;
        b=ztMzmngdVYMXFcJ9jUivm1CFFbjV4EG7hgbQ8r5OHrVu7S9ApBbUZ/V5uULjgZ+bWj
         NFiM625rgRt806580PuydULfC56oFnUo89uJ7De3VNdvwOVf5AOJHI90sK5vF6+ymkHW
         jEGBIezsTWjnOFKNTwKDuBHegCRpRJwqAdRoW2gVsVGYoCFXyjxfHG7dn9LVOL/uUA7G
         yLkaBrqUhgG5BwS++FkYM7b6PIDd8sUqSSOu0qLyDr3kvM9Vd25OSouQI7SIS/inTu3N
         1Mla66AJdSxDdeN3xhlnzI9uNTVPafNxSxdffhjP7akDB8fU44acxMDMT8mqjH8peB0Z
         YQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741546567; x=1742151367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYpRuX79H42AyJwMpeb72MjPa6wN8mVoMbygXkMxqYc=;
        b=u3mxHyy5/BptfvhHleSc/rDgxxAZ1jK+s8rvLD04UJ4NXYFbdMPIfQxw4uxuNhbz/E
         TA6RKh98WzvV/+ozYPDTiq75dnq2tZWQYN+1PA9Qs3+1WhK/dtivPQ0l2cF4hh2Wg/Dg
         D4nsOnG4G6bUTdkRGbJcLIv1G6HZXsUeKe7QCBARj9ou5m33VoD0fFBiD7W35Zjnj5bS
         8t73RuTyXW/9UlBks8ShIhyhwmcHg2KafcEmGgadpRdnwhwgFEnn/BENoNpRLeUQzIpH
         1y5uVMdZn+214gJtJoDzWUsx5KEo6nzDTJ+cHWvpA35lsfFA9CC1eXc4r2O/ulZpmThM
         LQWA==
X-Forwarded-Encrypted: i=1; AJvYcCXQR8oIU0OpscIAu1qm3quCmEI/lJ7W7HnABJF6H5A0BohgyT9BtXzUHcK3Qcq54VrFYqYZH9y9avAblck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6xl+44Qu1z0/pcMVqYCc6mDJSyJdR7B9x1EdR4ppnbNz83Z45
	2+ssfFVp2VtvOSzHvNM0KMQhdDGo8yrlJT5QRaq4SFa5TGTUp2MxWfNh2L5tQ08=
X-Gm-Gg: ASbGncvjIhGo3V8mZAlmPqxZKkGjcdHDUDUwgTVRlszasCITOlxmb4Q//7nNJwY6nr4
	BTzkWVLbAN456Y8q3yK5hhI4JP9CGYqh57FA3UqeWk2kGNFt/WrK4Zxn7A3R+3Uax+BCO9k+9+I
	FZfuVUpDx/D+Dq4wec63ZQaMeOMNLHkvfnZk0v4683hoXJj7CJg9Exfwo9ePGau1Xb+Sb6zuGd2
	D7PEwfeWchEOl4tiO4bbRNYPIOJo3LhKADZb7jw9wTxzVfyJvfFrUs9737Ymwdxt6rzoQUXW4AM
	wIPo9aYsFRMN+ligdAt+SfmJ85SD/J3W2FaMV2SYfZx4jQnyQyutifURW5Q=
X-Google-Smtp-Source: AGHT+IGtaEQwIFc/6TYT3DLRhe8XehJ9zBv7aECl0lbGZTSP5NvnoXEhZ0PSYiVFLI7kcHS+u3EmMQ==
X-Received: by 2002:a5d:6d8e:0:b0:38c:5d0b:71ca with SMTP id ffacd0b85a97d-3913ba438famr1345644f8f.0.1741546567145;
        Sun, 09 Mar 2025 11:56:07 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cee22c13fsm44263945e9.40.2025.03.09.11.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 11:56:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/4] samsung: drivers for v6.15
Date: Sun,  9 Mar 2025 19:55:55 +0100
Message-ID: <20250309185601.10616-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-6.15

for you to fetch changes up to 8f299df1b75ad0939f1340182c265de019eab438:

  dt-bindings: soc: samsung: exynos-usi: Drop unnecessary status from example (2025-03-09 18:53:34 +0100)

----------------------------------------------------------------
Samsung SoC drivers for v6.15

1. Add support for Exynos USI v1 serial engines.  Drivers already
   supported newer IP blocks - USI v2 - present in Exynos850 and newer.
   A bit older ARM64 designs, like Exynos8895 use older USI v1 block.

2. Add Exynos ACPM (Alive Clock and Power Manager) protocol driver
   for Google GS101 SoC.  ACPM protocol allows communication between the
   power management firmware and other embedded processors.

3. Exynos2200: Add PMU, ChipID and SYSREG Devicetree bindings.

4. Exynos7870: Add PMU and ChipID Devicetree bindings.

5. Various cleanups.

----------------------------------------------------------------
Arnd Bergmann (1):
      soc: samsung: include linux/array_size.h where needed

Colin Ian King (1):
      firmware: Exynos ACPM: Fix spelling mistake "Faile" -> "Failed"

Ivaylo Ivanov (7):
      dt-bindings: soc: samsung: usi: add USIv1 and samsung,exynos8895-usi
      soc: samsung: usi: add a routine for unconfiguring the ip
      soc: samsung: usi: implement support for USIv1 and exynos8895
      dt-bindings: soc: samsung: exynos-sysreg: add sysreg compatibles for exynos2200
      dt-bindings: soc: samsung: exynos-pmu: add exynos2200 compatible
      dt-bindings: hwinfo: samsung,exynos-chipid: add exynos2200 compatible
      soc: samsung: exynos-chipid: add exynos2200 SoC support

Kaustabh Chakraborty (3):
      dt-bindings: hwinfo: samsung,exynos-chipid: add exynos7870-chipid compatible
      dt-bindings: soc: samsung: exynos-pmu: add exynos7870-pmu compatible
      soc: samsung: exynos-chipid: add support for exynos7870

Krzysztof Kozlowski (3):
      soc: samsung: Use syscon_regmap_lookup_by_phandle_args
      Merge branch 'for-v6.15/samsung-soc-dt-bindings' into next/drivers
      dt-bindings: soc: samsung: exynos-usi: Drop unnecessary status from example

Tudor Ambarus (3):
      dt-bindings: firmware: add google,gs101-acpm-ipc
      firmware: add Exynos ACPM protocol driver
      MAINTAINERS: add entry for the Samsung Exynos ACPM mailbox protocol

 .../bindings/firmware/google,gs101-acpm-ipc.yaml   |  50 ++
 .../bindings/hwinfo/samsung,exynos-chipid.yaml     |   2 +
 .../bindings/soc/samsung/exynos-pmu.yaml           |   2 +
 .../bindings/soc/samsung/exynos-usi.yaml           | 100 ++-
 .../soc/samsung/samsung,exynos-sysreg.yaml         |   5 +
 MAINTAINERS                                        |  10 +
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/samsung/Kconfig                   |  14 +
 drivers/firmware/samsung/Makefile                  |   4 +
 drivers/firmware/samsung/exynos-acpm-pmic.c        | 224 ++++++
 drivers/firmware/samsung/exynos-acpm-pmic.h        |  29 +
 drivers/firmware/samsung/exynos-acpm.c             | 769 +++++++++++++++++++++
 drivers/firmware/samsung/exynos-acpm.h             |  23 +
 drivers/soc/samsung/exynos-asv.c                   |   1 +
 drivers/soc/samsung/exynos-chipid.c                |   3 +
 drivers/soc/samsung/exynos-pmu.c                   |   1 +
 drivers/soc/samsung/exynos-usi.c                   | 108 ++-
 drivers/soc/samsung/exynos3250-pmu.c               |   1 +
 drivers/soc/samsung/exynos5250-pmu.c               |   1 +
 drivers/soc/samsung/exynos5420-pmu.c               |   1 +
 include/dt-bindings/soc/samsung,exynos-usi.h       |  17 +-
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  49 ++
 23 files changed, 1359 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
 create mode 100644 drivers/firmware/samsung/Kconfig
 create mode 100644 drivers/firmware/samsung/Makefile
 create mode 100644 drivers/firmware/samsung/exynos-acpm-pmic.c
 create mode 100644 drivers/firmware/samsung/exynos-acpm-pmic.h
 create mode 100644 drivers/firmware/samsung/exynos-acpm.c
 create mode 100644 drivers/firmware/samsung/exynos-acpm.h
 create mode 100644 include/linux/firmware/samsung/exynos-acpm-protocol.h


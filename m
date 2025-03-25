Return-Path: <linux-kernel+bounces-574875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF012A6EAFF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D943AE2EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC6A25484D;
	Tue, 25 Mar 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mEh/Dx7p"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C31A5B86
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889775; cv=none; b=kKS+xZGm6FwYIts7c2GkNfuASiDY+n0XKUXH+QdOk5OhGVzGLIFuDz595mt7fP4BwrBHWRpS5ZH1I97kMURTE6oFOVXefEuXkh0i1br3QMIsckrkeoihlk/PDZG+M9580IANczDYo5wc2Q7oegkeuzKpCrTd6C7fMeYnglRHDLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889775; c=relaxed/simple;
	bh=fnJn1n5cC3lO5qK+yvd28vbfNIP+jolvcrh664PQTpM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Csuu0SCiW++aBc1+1AlNXzruFIfY3C9pkja9YYCv9Ria8KXL8PK0VTPJshUYVsRCpBD0Q2Dyce2MJL2xZtcz2mBh4bM9p7W23s/yodDU9QxyUbL2EzHszLz1m9GcUcstigh46JpBA5B/BFo4e5L9YR6+yKoOaeSkIQ1mcN6dxoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mEh/Dx7p; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso3649265a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742889771; x=1743494571; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KEEhhgNwBGBOp2aDar0YIKvMrukvujn7rY7eFpRmo7Y=;
        b=mEh/Dx7pYViWMsOITX8b6Ju+KyiQmO6cVhCaTNoW42xrGbM37KAAqmhVJaVnQeZtwP
         3oxgI9uJ1UfHr+8A/mO5+1YLfOsx/v35BzpPMGpj+1ZOL3GOp+huKD9yRs/QZnFukJ96
         +N4Imz+xep8Kx1A/dEMAVugE4nixHeiI0Uy0YafL/KAStXeZdMvH8ySAjlFSS/ay4r7S
         Lr7RX+PQxUTyi6fvSkxIasY08irUE1V7e2pydocJKJ3bC60VSQYf194TCRyryDu3GfT+
         dJtMEupWlDajPI13hLyX4RFfSGx1KHKltx2qTuCb+mH129Tn6Fa6IRNTlNhX+sdPW+tX
         z0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742889771; x=1743494571;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEEhhgNwBGBOp2aDar0YIKvMrukvujn7rY7eFpRmo7Y=;
        b=f0z9VFm0iujAGqDjFbPx+0tS3MXZWYTXPDWaRDlcmqejDBpd0F7SfMLstBHNvgOn9J
         wnTsn83UfXc8OYNJ0VLE1SlVtZAknQtQGB01boWSl204vNUr44qcT3Gl414wtD5rNmzM
         2+uHU3w57t2/E1/h7zmHmiSNSXhcN5hx+2ImewPUgSVVVkNQ2Ly5esPIVVFUgJDTTOSE
         vaZj1jwHUaMi2H2nDcJsvHGGOyTaKJPFP4vsH9YaqWjmvviApMOYmrWZcxojxqTovNdN
         hP2na0zxB332dVmzRf3z0Dpb4vjTz0l99ZnnuUAH+4d4I6rCDf2x71qxcd/4QrQFMtV+
         JDYw==
X-Forwarded-Encrypted: i=1; AJvYcCUEWAs5/ymcgjbDV9J366qR3RvJAO/NaeOsRp0HOVLs6IZ87VNEKNyI4UW9nbvfIQQBdUgy3LB+7QbciQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzg47/29hKKv0HIhwu2gEfVa4ojfViXoRkHOLU1nBSgZJA0Gp
	XI7wf20la7JA5Da+tx8rZz5zyS65danO/WV9Be43OJyspE5Xi6MelJ627OIzt70=
X-Gm-Gg: ASbGncueW7lo18LH4fAJ+KPpL5RY2Onj+KjqnVhPcevTDr3c0m9sWXDzUEdJEF3Xf86
	Uf7q2Xu+3UYw7ULcezUyVEOQidzScslt8pwoMulr5dKlNg1a5ArpG97UvzZF7+kNIidNl9Rz2dy
	pqSKmqvxKzzgyICO85pTyeH3bbQLK5vbzgruqR1scdSrbwgt7pycoLADoywwQGni3wNvYHTbXK5
	WdjAqyNdNsRgw8TPH2tDMnN0hpbkTGhZCjLxIgLAg4lC/BVhfARUTqdQ2Kn6b8l/vkDTUKTJkVH
	VhpoonybT5hkqP+Rq5zbDM0fq19x9A2Et0uPBkxHPqkoWNxJJdPOZJX3v7MGPB9Qhsv2YFeMrHS
	O9RzMHLdIlhZNs8bzMT3PJsfD1GR8
X-Google-Smtp-Source: AGHT+IHShC3wMV0FWHxrl7mVrEyihFCWXqhDiP8Dej8ATBjXvjSXNTJUgtgCgNUNuyPtbLpQHha0Dg==
X-Received: by 2002:a05:6402:1d4b:b0:5e8:bcf2:832a with SMTP id 4fb4d7f45d1cf-5eb9a017617mr19531945a12.10.1742889769098;
        Tue, 25 Mar 2025 01:02:49 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfb004fsm7446785a12.40.2025.03.25.01.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:02:48 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v5 0/6] Maxim Integrated MAX77759 PMIC MFD-based drivers
Date: Tue, 25 Mar 2025 08:02:23 +0000
Message-Id: <20250325-max77759-mfd-v5-0-69bd6f07a77b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA9j4mcC/3XPywrCMBCF4VeRrI0kk1vryvcQF5NbG9BGUimK9
 N2NbtSKyzPw/TB3MoaSwki2qzspYUpjykMdar0irsehCzT5ugkwUAxA0hNejTGqpafoKSIaFBy
 41UAqOZcQ0/WV2x/q7tN4yeX2qk/8ef0TmjhlFGyMQsfWM6V2xzRgyZtcOvIsTfCp9UJD1ahVs
 AGsY9j+aPGpm4UWVTMnNBgvQYH+0fKt67MLLau2LWu8Zto1zn7peZ4fA90ZRWMBAAA=
X-Change-ID: 20250224-max77759-mfd-aaa7a3121b62
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2

Hi,

This series improves support for the Maxim Integrated MAX77759
companion PMIC for USB Type-C applications using the MFD framework.

This series must be applied in-order, due to interdependencies of some
of the patches:
* to avoid use of undocumented compatibles by the newly added drivers,
  the bindings are added first in this series
* patch 1 ("dt-bindings: gpio: add max77759 binding") also creates a
  new MAINTAINERS entry, including a wildcard match for the other
  bindings in this series
* patch 3 ("dt-bindings: mfd: add max77759 binding") references the
  bindings added in patch 1 and 2 and can not work if those aren't
  available
* patch 4 ("mfd: max77759: add Maxim MAX77759 core mfd driver") adds
  the core MFD driver, which also exposes an API to its leaf drivers
  and is used by patches 5 and 6
* patches 5 and 6 won't compile without patch 4

The MAX77759 PMIC includes Battery Charger, Fuel Gauge, temperature
sensors, USB Type-C Port Controller (TCPC), NVMEM, and a GPIO expander.

This PMIC is used on the Google Pixel 6 and 6 Pro (oriole / raven).

This series adds support for the top-level MFD device, the gpio, and
nvmem cells. Other components are excluded for the following reasons:

    While in the same package, Fuel Gauge and TCPC have separate and
    independent I2C addresses, register maps, interrupt lines, and
    aren't part of the top-level package interrupt hierarchy.
    Furthermore, a driver for the TCPC part exists already (in
    drivers/usb/typec/tcpm/tcpci_maxim_core.c).

    I'm leaving out temperature sensors and charger in this submission,
    because the former are not in use on Pixel 6 and I therefore can
    not test them, and the latter can be added later, once we look at
    the whole charging topic in more detail.

To make maintainers' work easier, I am planning to send the relevant
DTS and defconfig changes via a different series, unless everything
is expected to go via Lee's MFD tree in one series?

Cheers,
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v5:
- core: incorporate Lee's comments (hoping I didn't miss any :-)
- Link to v4: https://lore.kernel.org/r/20250312-max77759-mfd-v4-0-b908d606c8cb@linaro.org

Changes in v4:
- collect tags
- mfd: add missing build_bug.h include
- mfd: update an irq chip comment
- mfd: fix a whitespace in register definitions
- Link to v3: https://lore.kernel.org/r/20250228-max77759-mfd-v3-0-0c3627d42526@linaro.org

Changes in v3:
- collect tags
- mfd: drop gpio-controller and gpio-cells, GPIO is provided by the
  child (Rob)
- gpio: drop duplicate init of 'handled' variable in irq handler
- gpio: use boolean with IRQ_RETVAL() (Linus)
- gpio: drop 'virq' variable inside irq handler to avoid confusion
  (Linus)
- gpio: drop assignment of struct gpio_chip::owner (Linus)
- Link to v2: https://lore.kernel.org/r/20250226-max77759-mfd-v2-0-a65ebe2bc0a9@linaro.org

Changes in v2:
- reorder bindings patches to avoid validation failures
- add dependency information to cover letter (Krzysztof)
- fix max77759_gpio_direction_from_control() in gpio driver
- gpio: drop 'interrupts' property from binding and sort properties
  alphabetically (Rob)
- nvmem: drop example from nvmem binding as the MFD binding has a
  complete one (Rob)
- nvmem: rename expected nvmem subdev nodename to 'nvmem-0' (Rob)
- mfd: add kernel doc
- mfd: fix an msec / usec typo
- mfd: error handling of devm_mutex_init (Christophe)
- whitespace fixes & tidy-ups (Christophe)
- Link to v1: https://lore.kernel.org/r/20250224-max77759-mfd-v1-0-2bff36f9d055@linaro.org

---
André Draszik (6):
      dt-bindings: gpio: add max77759 binding
      dt-bindings: nvmem: add max77759 binding
      dt-bindings: mfd: add max77759 binding
      mfd: max77759: add Maxim MAX77759 core mfd driver
      gpio: max77759: add Maxim MAX77759 gpio driver
      nvmem: max77759: add Maxim MAX77759 NVMEM driver

 .../bindings/gpio/maxim,max77759-gpio.yaml         |  44 ++
 .../devicetree/bindings/mfd/maxim,max77759.yaml    |  99 +++
 .../bindings/nvmem/maxim,max77759-nvmem.yaml       |  32 +
 MAINTAINERS                                        |  10 +
 drivers/gpio/Kconfig                               |  13 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-max77759.c                       | 524 ++++++++++++++++
 drivers/mfd/Kconfig                                |  20 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max77759.c                             | 690 +++++++++++++++++++++
 drivers/nvmem/Kconfig                              |  12 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/max77759-nvmem.c                     | 156 +++++
 include/linux/mfd/max77759.h                       | 165 +++++
 14 files changed, 1769 insertions(+)
---
base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
change-id: 20250224-max77759-mfd-aaa7a3121b62

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>



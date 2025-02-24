Return-Path: <linux-kernel+bounces-528696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F337DA41B05
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95559170563
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25DD2512D0;
	Mon, 24 Feb 2025 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RrIN+xNx"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698A24F587
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392935; cv=none; b=Hd2Qbh4GeCqEpu3AJfpJr1Ct7AtT9vpmxt/44wqpt9rJjcIWZplxzv6FQ/U8CwqtHy++mwIvenQdZ0lFm0Yil4gamBJRUEaYNpyk7UmWMrKVxbZ1H5hnzngPxuvJkIWiOAkWVu5VZcgVQnFH+mEE1V4pqqtGEpQjaiKTRaqFdPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392935; c=relaxed/simple;
	bh=wuWPXMJ51a0+BOXaAsVrmpeFTqSa4GiS6xaBMBQV++g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KlmZPCiqjX0UVUTvvUGl1mUXiDgc5lhc4UaOdTeLt0BGNof31xBhdFH0E4atU7g0odav1X7XVw3MF668rr4S8JhjNkQuW9pVS4lAE9/DuIXjKWYZQRGZIafA8xkfZN0tB5CRHjmoBFGTO4VqRDceAH/HONg3y0dqR/y7XUmloCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RrIN+xNx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abbdf897503so905630466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740392931; x=1740997731; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/LKdWNrXi/ziIQQKPOC6oaSjfMt73r4jud+vKrWkOnU=;
        b=RrIN+xNxfOWJnfuj4XWjeOMOtvsmz0Qed6Shehxiwt2TYyEZ9FR2MxTIN6CrpemP19
         dbUMQnEXHRDfvhVLnO1kjS73ViKvnZTyaMxZ9jYmkZWB3nYbEEvS5EIwBPS0bWtl2FyN
         pJDIjz3CUQ9IQ2fFnwK3WlnUSYXhv4EGx9qWp48ZRCkkw2f1s8CT2JxZboMxMg6+EMZ1
         aggp/CPIPZjP6mDQD1u1MjzBp0x2AtSch8Di0c5FuvSd4GkbBuYSjiKBd1j2R+MzD9Se
         5VCzFMLafkNq7YC6sFbK1mnysMipTLL6lmz1sMJ0V8GDmanILI4+tQ+Tgw8yx04T0RFx
         HqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740392931; x=1740997731;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LKdWNrXi/ziIQQKPOC6oaSjfMt73r4jud+vKrWkOnU=;
        b=RyzEtFtwoGSrTtXjyoggnt09G2fpM0Es00VhqwcaEU01BsyXZJtKQab2egWA/rlGcJ
         b2JoXYOlBaqp68Vy3vTuIJGpIIs6lfizuoKvuJ2V03u92JKxmd5Bm5TqTF/+Jbz8tSKh
         o4koPJlk1F4oeduc1eMfAi5+XiZCwk9AoBk3pAjtV7BXlWqD96NIZ0N0Qupi3aT8MqUM
         8Gi4HiASbChwWNQKqIrgorB1xHEZGtODz32uXrJkDYsFLu8osP7CBqD/P85Hh9+qxNrj
         JQ3mnTVsKsysB1lO6Dd6ySlGOERmFOJoaaIWImv0KByejuyVaOb3qB73bBL8dNiXDT1Y
         UHHg==
X-Forwarded-Encrypted: i=1; AJvYcCWUBiY1VVJiH0RoWr8uycLKsxcqe9DpNIpNthrwDGywY9AkjZjNngjHu0644CNpkDSh41BYjHQaECCc6n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLNgyMPVKrQGPDIkwLxXKK4ZMPk55Ud1LZj+SbPSbftvmFCLtr
	p9gGMgYsSWVlBvwFq5yD7lw8Hyb4VhvHjFVyFj7Iljf5t98JhHZM7a1ZuFH5Ldk=
X-Gm-Gg: ASbGncsq+nd/ABOng4IuNzEzTz6KFrao57rvNy18LEnkuyF1bDd93yPRg9MO05EvKVy
	KFvuc1Tn25iOLU/AOG0zJTM3TJ3TotTJWADQK8TO9fWwxl9sXO7bnWzq4tGquqNhkbYB2EygiQP
	E+kalwQrY1iPWHuyuWvtNXBT6rvq5hbZgn8fAAAsI0fBFft+C65yuUWLfdkvO28zfrHa3srb4F0
	OLHfbp5VYcpD8i8tTNEWCX2MpRJ/d+Yt8TVIH3uLme+EImknhv9jlAZ3AzjexzVNSxG5ZDiiLXb
	1eDFEaxQD6Zi64zIriwozMGXdmE9Js6tmiIkOOPdYBvrId3UJ27vXmfUTKxr6cyChcZUkw9BIcm
	z0K747npXQw==
X-Google-Smtp-Source: AGHT+IFjEjQbAl5+MZRgvPKOVBscOMs3LDuE1pgFfOPxdc6+aJHv4FO+a8f/Ju8qp2c9CNnwCl63TA==
X-Received: by 2002:a17:907:3892:b0:abb:b666:8e4e with SMTP id a640c23a62f3a-abbedf56dc9mr1785279066b.26.1740392931639;
        Mon, 24 Feb 2025 02:28:51 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbb186c5d5sm1349206666b.51.2025.02.24.02.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 02:28:51 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/6] Maxim Integrated MAX77759 PMIC MFD-based drivers
Date: Mon, 24 Feb 2025 10:28:48 +0000
Message-Id: <20250224-max77759-mfd-v1-0-2bff36f9d055@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOFJvGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMT3dzECnNzc1NL3dy0FN3ExETzRGNDI8MkMyMloJaCotS0zAqwcdG
 xtbUALORPYV4AAAA=
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.1

Hi,

This series improves support for the Maxim Integrated MAX77759
companion PMIC for USB Type-C applications using the MFD framework.

In particular, this PMIC includes Battery Charger, Fuel Gauge,
temperature sensors, USB Type-C Port Controller (TCPC), NVMEM, and a
GPIO expander.

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

This PMIC is used on the Google Pixel 6 (oriole).

To make maintainers' work easier, I am planning to send the relevant
DTS and defconfig changes via a different series, unless everything
is expected to go via Lee's MFD tree in one series?

Cheers,
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (6):
      dt-bindings: mfd: add max77759 binding
      dt-bindings: gpio: add max77759 binding
      dt-bindings: nvmem: add max77759 binding
      mfd: max77759: add Maxim MAX77759 core mfd driver
      gpio: max77759: add Maxim MAX77759 gpio driver
      nvmem: max77759: add Maxim MAX77759 NVMEM driver

 .../bindings/gpio/maxim,max77759-gpio.yaml         |  47 ++
 .../devicetree/bindings/mfd/maxim,max77759.yaml    | 104 +++
 .../bindings/nvmem/maxim,max77759-nvmem.yaml       |  50 ++
 MAINTAINERS                                        |  10 +
 drivers/gpio/Kconfig                               |  13 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-max77759.c                       | 522 +++++++++++++++
 drivers/mfd/Kconfig                                |  20 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max77759.c                             | 739 +++++++++++++++++++++
 drivers/nvmem/Kconfig                              |  12 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/max77759-nvmem.c                     | 156 +++++
 include/linux/mfd/max77759.h                       |  74 +++
 14 files changed, 1751 insertions(+)
---
base-commit: d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa
change-id: 20250224-max77759-mfd-aaa7a3121b62

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>



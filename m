Return-Path: <linux-kernel+bounces-557460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406ADA5D95F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30993B5E13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9306423BFA9;
	Wed, 12 Mar 2025 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7e/l9JF"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EFA23A9BE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741771579; cv=none; b=GSfyo8QEWR1bWmzOUa0+mrehMFQNi2qzLNb+tj39dF+PM4/sc3PzKWyRjj86WGot7Hx6GJgBx2Cyjt3czhPBzrIGAP6kv2blxq2Gb3JH5MR13XEeVGvK3y4o3wfQabK9FGwoj/v6dD7yGpsCnolQKvSf4p0NfD4z13QuvGtIZa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741771579; c=relaxed/simple;
	bh=WrKCHVU9WeE23NeOMrdhi+N2H8I570pU6Ew1AKLcPyg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Txu7MRszWJTNuTCjFmWtGnygibcou3twxmfn+YfVDNOHqwBEecUyoSqdh7/0m+V/K5pUoVhwlX9Cg5ujZolrRkeSPSTo2O45vNKz0DJJtcpOHQ46l1Hp8n+g+Z983f/OHKjoJPBKVxcWUutwlX5gP1SqzxdBQphPkQKpwrj07bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I7e/l9JF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1116273966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 02:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741771574; x=1742376374; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Lfobpgc3Deyg3z2F30QYKZenkvsowTCFz1IUvtrFV4=;
        b=I7e/l9JFBGWxUbrBYIb4KZpPlvnLot4Ae2gGS8Dso5uL9snVibcdocOt1MxJtC7BqI
         WytDUEZERenf/tCfvE8bzFofzLY4gBhXryEqMleBJXzdkqj1XxDHD8Buuy8L63tSF8ul
         CMO6fpN6yL+0AUV9SkUjYaZRfgTTulYyanMc9afNei7bWqJDKX9ODNH6rPDeZ/9Q4co8
         lxNuLUVNJDmetoIDzsnnZmQXf3zjpogJvnhaFVuS5iGVGk+8U8jJzYxZONjmT37orvHg
         b2IPJphha+8BsSl5dUPYwuFoMj3klPAxfgdk+Pcoa/a839CcYbL/S0xIMewgYbaCEkqi
         XGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741771574; x=1742376374;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Lfobpgc3Deyg3z2F30QYKZenkvsowTCFz1IUvtrFV4=;
        b=UsU96oe6YtsBvZwQ9Ym5BT5VpXToDu8r2CDgtV9eQhqtKqCUj5sOb/x78R9wr1h1ib
         8hHVO8U1l0wg7lNZne+LfKmYxQ6v7F2d2ys3JplUhAoJylfhfaeZAWLa8UJWycAvpmBe
         MUJPeExQI5nt8Cn2CJ+vgAtOGTl6QOo8Rg/I8HlYBJ5cYNjgj7ua1dUWI2Gal/iQL81n
         CvBgYuBkP1lV7ER5QBGgtw/h0uBGZnWaTdJV4j0yNzHyrtZly8m7lETv1pcUhn/1fzCC
         M7DkQzgYcuQ8BPFPIZN2zd2FIttCidc7N3Zvif04eBpZQvcMPbDUPzh+KP68/aMe6NC5
         1l+w==
X-Forwarded-Encrypted: i=1; AJvYcCWKhRna/r5mxBMxO45ycnlK4FFHIaDddo2xnL0X3M6PkbW2NZDi++UhE4uUBbBygK8k/N7sSYu9R+U55KM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8rxviDaN4Q5QGwm9Q6olJvpdkJGG10MQDCRmojHfXU4hjbAjr
	LQw7Z5FrMqqxWGr+tSniKvWleb7RaDbN745pFUYIXm524BIq9OudC7H6E38dby4=
X-Gm-Gg: ASbGnctHqKvQ0VU19DK2pptk5ZGAxiAJoZHsh/67cXNVhJ1Y1rlyNLC7Y8SNuDEIZez
	Q3v93QTB8pUDFMgMMyLP/UnMuzHnHsuZYJ8j/N2RRMPdX68TjSVZiwZytDo/sx+3+AnSt7MBoxt
	zW7ln9vr1cOIw7Q8TB+C6dYJMLl5wE6d24Cqb5x1nxQ8DsKIKy6qzJCysRPQq8+5V43eeSMDOaW
	IA9sYF6frMK6Zm5Ts1XmO6SR/tLRZDJAd5ozzH8dm5hkKakzO4vOrTsGBZifzG9YOmEzeinVcWj
	64e6wFrdIVTrcDVo53u8t67MhNw/yQ2zlRsRJK9tCRn7VrouC8ACMOQrAnzAILWfESA6MoqjsQh
	b1l7NH9CxxQNpCfrQ9iPUTSb7R+Xwt9Z+VpD1kK8=
X-Google-Smtp-Source: AGHT+IGMqDlLwT7rGvz8I6XYBpku/gmPdWmh/R1p3fJdAcAGTYdKy3MrEXnddG5CRbYlt4DioQT3/Q==
X-Received: by 2002:a17:907:828a:b0:ac2:c424:c316 with SMTP id a640c23a62f3a-ac2c424cd75mr606058866b.57.1741771573595;
        Wed, 12 Mar 2025 02:26:13 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25777c748sm894535266b.2.2025.03.12.02.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 02:26:13 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v4 0/6] Maxim Integrated MAX77759 PMIC MFD-based drivers
Date: Wed, 12 Mar 2025 09:25:58 +0000
Message-Id: <20250312-max77759-mfd-v4-0-b908d606c8cb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACZT0WcC/3XM0Q6CIBiG4VtxHEeDH4HsqPtoHfwIKFtpw8Zsz
 nsPPTJbh9+3Pe9EBheDG8i5mEh0KQyh7/IoDwWpW+waR4PNmwADyQBK+sBRay0r+vCWIqJGwYE
 bBSSTZ3Q+jGvuesu7DcOrj++1nvjy/gklThkF471QvrJMyss9dBj7Yx8bspQSbLXaacgalXTGg
 akZVj9abPVpp0XWrBYKtC1BgvrS8zx/AAKKFmMlAQAA
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
 drivers/gpio/gpio-max77759.c                       | 524 +++++++++++++++
 drivers/mfd/Kconfig                                |  20 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max77759.c                             | 738 +++++++++++++++++++++
 drivers/nvmem/Kconfig                              |  12 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/max77759-nvmem.c                     | 156 +++++
 include/linux/mfd/max77759.h                       |  98 +++
 14 files changed, 1750 insertions(+)
---
base-commit: 0226d0ce98a477937ed295fb7df4cc30b46fc304
change-id: 20250224-max77759-mfd-aaa7a3121b62

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>



Return-Path: <linux-kernel+bounces-525574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 807A6A3F194
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423701899709
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0322054E9;
	Fri, 21 Feb 2025 10:14:45 +0000 (UTC)
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951E3204F7A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132885; cv=none; b=u9OVV/59Q1o+iVrGKA1wTWdcRXHnB22uikhZPqmjVqx3iirqhrl4of2weBYbXXmIwvuQpyWLGlB3Atb2OVjDnbfk7usUNM7fug2wOm2MI5oOcArdOtOtMyCPipvbDM9Ik5YPKFHioyGtbhmV4JtvNQE690WcNVme0ojeR8htiR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132885; c=relaxed/simple;
	bh=bCQOa/TimHFKkucWMI7IGgeFSMMiFn7NMUIE/QL9MYM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U28fAybUfztQKGRN7Vl48UyNe9HUtVJjQZZx/zsLNDxUfIqLRQJ/hjhiNB9d9gB3yqc7NBSb11ZJgdmEwQVUFwIgA6vFcHYSloXED8OD9NYPNWt8rIia0pt5khAieGRh0Paxhdb7txdiNX+byYjXCxDQMjgcTifwgWqtPjP8FoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YzmFr0nszz81M;
	Fri, 21 Feb 2025 11:14:40 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YzmFq2mSSzM2M;
	Fri, 21 Feb 2025 11:14:39 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH v2 0/2] gpio: pcf857x: add support for reset-gpios on
 (most) PCA967x
Date: Fri, 21 Feb 2025 11:14:25 +0100
Message-Id: <20250221-pca976x-reset-driver-v2-0-a2bcb9fdc256@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAFSuGcC/22NQQ6CMBBFr2Jm7ZihQrWuvIdhUcogswEyJQ2Ec
 HcrcenyveS/v0FkFY7wOG2gnCTKOGQw5xOE3g9vRmkzgyFTkSkcTsG7m11QOfKMrUpixeC8d9X
 dutJYyNNJuZPlyL7qzL3EedT1eEnF1/6Chv4HU4GE1jdNR+WVKuJn6Fl1vbQM9b7vH/r3JY+4A
 AAA
X-Change-ID: 20250219-pca976x-reset-driver-c9aa95869426
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

The PCA9670, PCA9671, PCA9672 and PCA9673 all have a RESETN input pin
that is used to reset the I2C GPIO expander.

One needs to hold this pin low for at least 4us and the reset should be
finished after about 100us according to the datasheet[1]. Once the reset
is done, the "registers and I2C-bus state machine will be held in their
default state until the RESET input is once again HIGH.".

Because the logic is reset, the latch values eventually provided in the
Device Tree via lines-initial-states property are inapplicable so they
are simply ignored if a reset GPIO is provided.
This is eventually enforced by the Device Tree binding by making sure
both cannot be present at the same time.

Finally, the reset-gpios property is specific to PCA9670, PCA9671,
PCA9672 and PCA9673 so make it specific to those chips.

[1] https://www.nxp.com/docs/en/data-sheet/PCA9670.pdf 8.5 and fig 22.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- init n_latch to 0 again by default,
- include linux/gpio/consumer.h,
- update reset+latch comment to match what's in the datasheet from
  RESETN input chapter instead of Power-on reset chapter,
- clarify/fix expectation in commit log and binding around active level
  for the reset-gpio wrt RESET# line (ACTIVE_LOW means reset is asserted
  when the GPIO is low),
- rename rstn_gpio to reset_gpio,
- remove curly brackets around return dev_err_probe,
- use fsleep instead of usleep_range,
- use cansleep variant for setting the gpio level,
- add T-b trailers from Heiko,
- Link to v1: https://lore.kernel.org/r/20250220-pca976x-reset-driver-v1-0-6abbf043050e@cherry.de

---
Quentin Schulz (2):
      dt-bindings: gpio: nxp,pcf8575: add reset GPIO
      gpio: pcf857x: add support for reset-gpios on (most) PCA967x

 .../devicetree/bindings/gpio/nxp,pcf8575.yaml      | 38 ++++++++++++++++++++++
 drivers/gpio/gpio-pcf857x.c                        | 29 +++++++++++++++--
 2 files changed, 65 insertions(+), 2 deletions(-)
---
base-commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
change-id: 20250219-pca976x-reset-driver-c9aa95869426

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>



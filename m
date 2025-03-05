Return-Path: <linux-kernel+bounces-546475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB3CA4FB20
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C761E171653
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD44207666;
	Wed,  5 Mar 2025 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaDPFs9w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB43C205AD4;
	Wed,  5 Mar 2025 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168979; cv=none; b=fxRNV+qz8sqdjanGg3hNHYD+p+NpfC5YUW/jh0Y6xxM36EQMdXG7Rz3ilH6dDhgNlsRuaPldRU5CG4lyxjilKDvwmgG6xiZds4rSRc5iIfRWgrHTqIXz9V0b8RRUnBq+iqNjEwipesWn5JiCgZYCIjK/816GYrswqqiTh7RlJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168979; c=relaxed/simple;
	bh=1g440IuVdvferMaa49XKcEufmSsf3xpIra5Mss3ih/M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e42PyuDvMhbwRE+oXXUcBP7JoqcoIo0W+Qo9QilmJES8P/bhW6FzaWgpL/y2cXEK1gmQJ5St3KMkDdcD6MQiw8PB6Gr290seXBpOnvMClv+2uBZ9FmT0spkb6Ed+PYxJIglb4P0ugma7L27XdQgm3YYvgt5e9BP7mFY1fR9dCUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaDPFs9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EAC5C4CEE8;
	Wed,  5 Mar 2025 10:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741168979;
	bh=1g440IuVdvferMaa49XKcEufmSsf3xpIra5Mss3ih/M=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LaDPFs9wiyXd+cQgs4520fdnBGhhAjV20d6LnUj+PqKEniG1pw4GarBt2FldqrVQJ
	 +lYJPOEccq9GFKKadnvVMW87DwwQUPRnyko2hzfautgdcM6tLp3ZdJbEVAMKb/D1/f
	 aa6Yem9sqmNQGSZZ1DCQB5Qj5XUYjare8q+lfKv/QqktC1fxnw3/X3iPuSXk3EP/Lz
	 hAGJ1C2jsqJCkx40nqjzgfBnqfUkqnl8cJfuiX+qbXHXFzAweh/19tMd76k+89DGgE
	 0DiWy3DKpLMJSVdSFqVLSO22IDRPoayv0WWi6Y0xFimC4JmSa35fYx2UePIB4dNp2n
	 iAj8ZMXneFh+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05484C282DC;
	Wed,  5 Mar 2025 10:02:59 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v3 0/4] Add GPIO interrupt support for Amlogic A4 and A5
 SoCs
Date: Wed, 05 Mar 2025 18:02:55 +0800
Message-Id: <20250305-irqchip-gpio-a4-a5-v3-0-1eec70352fea@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFAhyGcC/23NQQ6CMBCF4auQrh3Tlg5BV97DuChDgUnEYmsaD
 eHuFlaasPxfMt/MIrrALopzMYvgEkf2jxzloRA02EfvgNvcQkttlFYlcHjSwBP0E3uwBixCLQm
 lVQYrMiIfTsF1/N7Q6y33wPHlw2f7kdS6rhxKrU57XFIgoaTaGWOd0W13sePd90xH8qNYwaR/E
 F3tIjojhNgoiZIaxH9kWZYvB3S4ZfsAAAA=
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741168977; l=1486;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=1g440IuVdvferMaa49XKcEufmSsf3xpIra5Mss3ih/M=;
 b=v148/pWMVfxrubeqy83sCyRkyelbM2gzK8tehnIW/gbWJObeuEoCq0Zbc/PIJGm6f6FC/EJx/
 AAG597zMpDNCrYpX6lGmZxdULCQv8lP/YooM/tKmazoT/14nKoPXuVZ
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

This patch adds GPIO interrupt support for Amlogic A4 and A5 SoCs

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v3:
- Fix warning when run 'make ARCH=arm64 dtbs_check'.
- Fix warning when run 'make ARCH=arm64 Image W=1'.
- Rebase file amlogic-a4.dtsi.
- Link to v2: https://lore.kernel.org/r/20250226-irqchip-gpio-a4-a5-v2-0-c55b1050cb55@amlogic.com

Changes in v2:
- Use if/then instead of direct modification minimum value for property 'amlogic,channel-interrupts'.
- Add register offsets to the parameter structure to reduce definition of a function.
- Link to v1: https://lore.kernel.org/r/20250219-irqchip-gpio-a4-a5-v1-0-3c8e44ae42df@amlogic.com

---
Xianwei Zhao (4):
      dt-bindings: interrupt-controller: Add support for Amlogic A4 and A5 SoCs
      irqchip: Add support for Amlogic A4 and A5 SoCs
      arm64: dts: Add gpio_intc node for Amlogic A4 SoCs
      arm64: dts: Add gpio_intc node for Amlogic A5 SoCs

 .../amlogic,meson-gpio-intc.yaml                   | 21 ++++++++++--
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 19 ++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 12 +++++++
 drivers/irqchip/irq-meson-gpio.c                   | 40 +++++++++++++++++++---
 4 files changed, 85 insertions(+), 7 deletions(-)
---
base-commit: 73e4ffb27bb8a093d557bb2dac1a271474cca99c
change-id: 20241213-irqchip-gpio-a4-a5-80c50a1456c4

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>




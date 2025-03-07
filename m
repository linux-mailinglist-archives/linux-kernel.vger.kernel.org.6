Return-Path: <linux-kernel+bounces-550684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E59A562EF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06FE188FD69
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D721B1E1DFE;
	Fri,  7 Mar 2025 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPwsIyEK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF9D14D283;
	Fri,  7 Mar 2025 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337364; cv=none; b=jHMGzeS9/tz70SczVZjgkXL60KcszGzfR8hAypOg/gAGbgNoWwV0AW7fP9creqvFXTjyNvRAr0VEyvMelZgiNkBtch2W9QcQI9GeqxA/09MmeyYC027ACOfIUBrtWpOgRxKQi7vStPRYEmyhKksv6lXvTcgAVb9iho6mSIM6iFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337364; c=relaxed/simple;
	bh=MqtpD5D8ho7ZkuHg72dZuTrsPAosUYbPrhtFmWLF0Xo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RDH17tjkQ6m86XKGa2hLm/jgvn29DGa8szZqOIVaJcGE7MH+z4gLY9buE4qBm/fA5EsaH/lm5O7GgGNqpEoY5zUBUb4IL/8gfXnNXrxWIg+AYRfPE3Dv6iAZ4x6RZtdmfxyu5EQvo6yK7Zd2YX+nXeyGMy2xioICWjrw+EtI6FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPwsIyEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F275C4CEE2;
	Fri,  7 Mar 2025 08:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741337364;
	bh=MqtpD5D8ho7ZkuHg72dZuTrsPAosUYbPrhtFmWLF0Xo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RPwsIyEKTASpZtHU13LSfVb2jq09Pt6tF0Pm9N1Od9wP2ifPD+fT6F1sBy5OiRAMj
	 xNK+S0QIQ3Xg8a0gkG7M6kEqJp+/gWzALLUTZXx0E/ay2ktqkcqLcL7TNNxqIpuwjN
	 ERX4el/4ZApEa5VFPpTwTA6slUk0KzRAoELdVReP7AENvAY4GzcXoAIXj8Pc01yZ+Q
	 OLDyxpHW1iiVnjd+TcZba5w5dRZ0gm9osEm8Faw8e0zbzO0igihPwMrKfquf18PeuO
	 DHlD01rSo4KZJF6RvzYFi7uHoPac+EiHt2Wp6wWfuYp2OJBrq1yPPtauA8bw4pDEw3
	 aQ/giQuJTr8wA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D5AC19F32;
	Fri,  7 Mar 2025 08:49:23 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v4 0/4] Add GPIO interrupt support for Amlogic A4 and A5
 SoCs
Date: Fri, 07 Mar 2025 16:49:21 +0800
Message-Id: <20250307-irqchip-gpio-a4-a5-v4-0-d03a9424151b@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABGzymcC/23NwW6DMAzG8VdBOS+T48SM7bT3qHYIxoCltWFhQ
 p0q3r2BSzeN4/+T/PPNzJJVZvNW3UyWRWdNlxLhqTI8xssgVrvSBgGDQ+et5i8edbLDpMnGYCP
 ZBpggukA1B1MOpyy9Xnf09FF61Pk75Z/9x+K2deMI0L0ecYuzYD03EkKUgF3/Hs+faVB+5nQ2G
 7jgLwTrQwQLwkStAwJuif4j/oF4oEPEF8SJ8At4wl7iX2Rd1zvpttjbQAEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741337362; l=1730;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=MqtpD5D8ho7ZkuHg72dZuTrsPAosUYbPrhtFmWLF0Xo=;
 b=jf2kjl2+fTJLAmql/JkT3VEHpbqntitDldAJPUz8QyCqBKYCjLRpFruPnhKEmVBw/RGfgz/SO
 wgJC8IuFyvcDp1wUcSQe8szaZvVptqOy7GprHofvxVqwwE/1tW7l5SH
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

This patch adds GPIO interrupt support for Amlogic A4 and A5 SoCs

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v4:
- Make minor changes for bindings as Conor and Rob suggest.
- Format adjustment of source code according to Thomas's suggestion.
- Link to v3: https://lore.kernel.org/r/20250305-irqchip-gpio-a4-a5-v3-0-1eec70352fea@amlogic.com

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

 .../amlogic,meson-gpio-intc.yaml                   | 19 ++++++++-
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 19 +++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 12 ++++++
 drivers/irqchip/irq-meson-gpio.c                   | 45 +++++++++++++++++-----
 4 files changed, 85 insertions(+), 10 deletions(-)
---
base-commit: 73e4ffb27bb8a093d557bb2dac1a271474cca99c
change-id: 20241213-irqchip-gpio-a4-a5-80c50a1456c4

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>




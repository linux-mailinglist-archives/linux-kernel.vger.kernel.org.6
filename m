Return-Path: <linux-kernel+bounces-555415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6C1A5B71C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C306170ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CC81EA7FF;
	Tue, 11 Mar 2025 03:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvpweZMC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86791DF268;
	Tue, 11 Mar 2025 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741662510; cv=none; b=tmp1/BoLe2LbbWgv21FaGsRM8ZoZJKCfJEokToMMl5B86nIbabWOelkgiBdtmz57s7yVl4cVOZQVZUmnHG+o7vBrczfqKeQO1CnbaN3d3boDj9zLRtjBBm1DZmtMW+7VtFODxZApQvmy8X9RmP0UplB0NhgHghOG4tq/Lwf2rQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741662510; c=relaxed/simple;
	bh=6YFlKkmJqvHypt4lt2xcZRr3utLgEQlOW0fxh7lNRnQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i5uojQMW0/uUJ2SBUh29qngHhu26FO5xAevNMnVSvDH2Pbc/88s5epuvY6uAI7WjhGeusIcMdQ2qRIjY2tINbpfuUhzLn8n+TxAa10GS8LJyHsSPW9qgHP1pAITkqv+RteOhx/w1ZSBS0Q5qSUY1uzQBoj94kEQPLdIxn6kGCIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvpweZMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5203AC4CEEC;
	Tue, 11 Mar 2025 03:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741662510;
	bh=6YFlKkmJqvHypt4lt2xcZRr3utLgEQlOW0fxh7lNRnQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=hvpweZMC7YwAnjQAJe4vr934bW6gdvtiy8YaZUPj7/AbPkF1AH9uvbsL8Z/mZce4i
	 0j0Kl3u/JUN0WMxTqLQgaZzVkjdTp2SVLtWKo1iJHxntziPpFXt2TnJ5gcWM7q/izK
	 le8bVbSX7WTlDOrWjzK+/Vo/lARHOAqOOkeQihHdaXZBwQnKas7KKoZ2sVcqb/nbSs
	 Tv1OXxpwGUu+YAGTrwx0DPhf4xPt26baG46MbRawDKHGG99ydHYJiSNZCLicdn6384
	 C8O+hxPfEtlNm52cvdal1uBk0RZzQIBNnO3VkpDoQwSFrgY8ZEnAENStIO2hANdwuz
	 feccazQM0Kbew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B20C28B2E;
	Tue, 11 Mar 2025 03:08:30 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v5 0/4] Add GPIO interrupt support for Amlogic A4 and A5
 SoCs
Date: Tue, 11 Mar 2025 11:08:26 +0800
Message-Id: <20250311-irqchip-gpio-a4-a5-v5-0-ca4cc276c18c@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACupz2cC/23QzU7DMAzA8VeZcibITux9cOI9EIfUdVtLbCkpq
 kBT3510F4bW49+Sf5Z8dZMW08m97K6u6GyT5UsNfto5GdKlV29tbRcgEAaM3sqnDDb6frTsE/n
 E/gjCkJB4L+Tq4li0s+8b+vZee7DpK5ef240Z1+nKMQQ8bXEzevBRjkqUlELbvabzR+5NniWf3
 QrO4Q4J+00kVESYGwQGaZgfkfiHROBNJFYEVeUAkUOn6RGhe+SwiVBFWojpRPWFjM1/ZFmWX6f
 P8BaFAQAA
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741662508; l=1918;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=6YFlKkmJqvHypt4lt2xcZRr3utLgEQlOW0fxh7lNRnQ=;
 b=3MveDm9G6ntXWpZhH6/St+ViGjIaVCdHUE+6VbXi9dIntkMm4Da3JSu+SLSFPuRx1RdkvfQhy
 0r385KlVEghDWnVwJUNckZRD/te9Ox+CdrYCQ/XHusuCljFuKQB1OSW
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

This patch adds GPIO interrupt support for Amlogic A4 and A5 SoCs

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v5:
- Make minor changes of source code according to Thomas's suggestion.
- Link to v4: https://lore.kernel.org/r/20250307-irqchip-gpio-a4-a5-v4-0-d03a9424151b@amlogic.com

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
 drivers/irqchip/irq-meson-gpio.c                   | 48 +++++++++++++++++-----
 4 files changed, 86 insertions(+), 12 deletions(-)
---
base-commit: 73e4ffb27bb8a093d557bb2dac1a271474cca99c
change-id: 20241213-irqchip-gpio-a4-a5-80c50a1456c4

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>




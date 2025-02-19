Return-Path: <linux-kernel+bounces-520990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35103A3B260
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE5518968FC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190B41C3306;
	Wed, 19 Feb 2025 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQGIpjjE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622619F47E;
	Wed, 19 Feb 2025 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950147; cv=none; b=O9jLCZfISC3rx9HfIJJptJH1i6/RadHbjNuLl+iYUdp8/0zpTc7IfU7wzkVn0QTLEDkqj0gM9eC/4mbxTxAkoYpiVnwe+Pq5zcMHPurFS1y7piCt+GIH5yts0ebIdnpmCR+9l3+ajFAwfsaflYCOTIsWlUyRM2HpPTMklJrp77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950147; c=relaxed/simple;
	bh=ImNpnsptW8WJoO1olJWkaeTDPYynu8aJPZ10S0NXgBA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bSsuFNynS77ZUmsyMZJjO/KBWnKVdEP9zltLmyOrR1L4ggPWFL/NYPwcb0IwSLss8bGoSoH5E2XUa39U0hnTmqXqQ2KRpMghWvw+mkxBLpx4FbHWQ9N9LWeQorHjwQTrcktDGERLHtU+52do6aqokb4GnFudMhzhd8xZ+nFvPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQGIpjjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2189C4CED1;
	Wed, 19 Feb 2025 07:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739950147;
	bh=ImNpnsptW8WJoO1olJWkaeTDPYynu8aJPZ10S0NXgBA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=nQGIpjjE8MunxA3EVXwvWneVxXkqthRw3GURkUTEkvix+4NvAlFmGnMa+U+d7ucvs
	 MucX/A+XZo/Me0dprIbCJCVQHauMZnzCq4eOS5M3Wo27gR6xbUTCmxUF+CVckBmRUo
	 CsMgfYm1qj4J4gY2Wj4dB69y1f94pO+Xxigx6r3PoQ2fdmo19YyUJJBvHavORTXWeI
	 k9Q/xg+tjDYfYukhyUPF+qYnmOgToMar1oKk+wWvPcYMHNoK7frYm63Ya46oDwlK63
	 YCv6coKSjdf3L7V/MmGySFlIAfKjcFb6c/3XDISv+UO37RlbCrl0xIeQWt3O5tb4+d
	 PrWa7jyjS3Ctw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02E2C021AA;
	Wed, 19 Feb 2025 07:29:06 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/4] Add GPIO interrupt support for Amlogic A4 and A5 SoCs
Date: Wed, 19 Feb 2025 15:29:02 +0800
Message-Id: <20250219-irqchip-gpio-a4-a5-v1-0-3c8e44ae42df@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD6ItWcC/x3MQQqAIBBA0avErBtQ04iuEi3EJp2NmUIE4t2Tl
 m/xf4VCmanAOlTI9HDhK3bIcQAXbPSEfHSDEkpLJSfkfLvACX3iC61Ga3ARzggrtZmdhh6mTCe
 //3TbW/sAeJI412QAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739950145; l=903;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=ImNpnsptW8WJoO1olJWkaeTDPYynu8aJPZ10S0NXgBA=;
 b=kBJy8i3DWBxIZsOOmE/IltkEkpIMhPO6n8vGPuyAvcvoNrKq3atiLHkfjy9kjHyRTRrWpPILK
 h7FUOk0a6/lBs1Dqwb5WzEfHSgZMzdE7hoJS3uooL02uyvXMD3vWlA5
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

This patch adds GPIO interrupt support for Amlogic A4 and A5 SoCs

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Xianwei Zhao (4):
      dt-bindings: interrupt-controller: Add support for Amlogic A4 and A5 SoCs
      irqchip: Add support for Amlogic A4 and A5 SoCs
      arm64: dts: Add gpio_intc node for Amlogic-A4 SoCs
      arm64: dts: Add gpio_intc node for Amlogic-A5 SoCs

 .../amlogic,meson-gpio-intc.yaml                   |  5 +-
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 21 ++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 12 +++++
 drivers/irqchip/irq-meson-gpio.c                   | 61 ++++++++++++++++++++++
 4 files changed, 98 insertions(+), 1 deletion(-)
---
base-commit: 953913df9c3ab6f496c6facd5aa7fc9f2f847ac2
change-id: 20241213-irqchip-gpio-a4-a5-80c50a1456c4

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>




Return-Path: <linux-kernel+bounces-533031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 129F0A45504
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E797F17A77D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6863A267AF1;
	Wed, 26 Feb 2025 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzLk/Bc4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90917DA73;
	Wed, 26 Feb 2025 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548893; cv=none; b=hv0RT/PS2cNCvqyqZ+1IR9Hv2vga9LvcdNCJrXsxyxYJ2dgfFOtR/ZexM1gnVjGgahMYg96YdP/ViakEmsOQL1J82dfD1OkQ5XNIpAykWRFrGoucZWd+rcGJJd07DLsc3vcMHkmkQlUDPwVTHpR1+gEUky7dniWdekP3ktGxXQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548893; c=relaxed/simple;
	bh=W4cG0I6SC0UXlixxjcHeRMiMZh89LfPef6m5P4FVaKM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BgdB9O9XlFhvr3txKOPy9wt6OTim0461roGab7Ze/M3i+MVk5c2yzP+3WBDugerhEIO2TDqCEBnwfLgoHia7aSEosJhXYA6eLU3Tr9Y2i+n7ZreG7Eiby77N8TpGupkemcP2vUah5qV3yX+20BLjpV635xzs2MQMjmYmSZqWT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzLk/Bc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C527C4CED6;
	Wed, 26 Feb 2025 05:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740548893;
	bh=W4cG0I6SC0UXlixxjcHeRMiMZh89LfPef6m5P4FVaKM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mzLk/Bc4GavyLp3fZELxMVE13UA5Xk/wVt2hPA2sPZgv0ePh3XGSDugTaBSzZ16Uc
	 lxStqO75MlaRKCm0FRVkVtc3GqhsqgGk3TEDhf3FSlxGM3wyi5ih0ASijPEwpRYe5M
	 qAnbTCJTmvmoc26lhCSoWI5j/hBHruq8PNzRIwTWIn2M0WJVEWVpPuGn56OVWOSgE9
	 4mSlGJgZ3UhGVh7naicQpdPVz/kMiHYwU3kE8ON61Fvsvrwlfs2UwKMZe3D+N1NhjM
	 WEER+s68Gy1fpSvYi0IiF9Dq6/kp+2pAFh22GIZrOvhtdk3AoXE5hIIW8sZVFTDnXU
	 wgwJ/r2VKL8ww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242A2C021A4;
	Wed, 26 Feb 2025 05:48:13 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v2 0/4] Add GPIO interrupt support for Amlogic A4 and A5
 SoCs
Date: Wed, 26 Feb 2025 13:47:51 +0800
Message-Id: <20250226-irqchip-gpio-a4-a5-v2-0-c55b1050cb55@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAervmcC/22NQQ6CMBBFr0K6dkxbpgZdeQ/DohkGmEQotoZoS
 O9uYe3yveS/v6nEUTipW7WpyKskCXMBe6oUjX4eGKQrrKy2aKypQeKLRllgWCSAR/AOGk1Oe4P
 uQqjKcIncy+eIPtrCo6R3iN/jYzW73XNOW3P9l1sNaKipYUTPaLv+7qdnGITOFCbV5px/BpKph
 bYAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740548891; l=1226;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=W4cG0I6SC0UXlixxjcHeRMiMZh89LfPef6m5P4FVaKM=;
 b=21MSP023vePsJIFViASdvu1jq/DZsq1/wWCZpFg1Gjyj6vbfksgiXFJtl7pyPUeCZ+NDXhfSe
 J9bXHNvSBO/CUOfVCpktz6AZhXdGcPn3xnCRxnAf7AywRA8IazHiP7h
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

This patch adds GPIO interrupt support for Amlogic A4 and A5 SoCs

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
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

 .../amlogic,meson-gpio-intc.yaml                   | 13 +++++++
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 21 +++++++++++
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 12 +++++++
 drivers/irqchip/irq-meson-gpio.c                   | 42 +++++++++++++++++++---
 4 files changed, 83 insertions(+), 5 deletions(-)
---
base-commit: 953913df9c3ab6f496c6facd5aa7fc9f2f847ac2
change-id: 20241213-irqchip-gpio-a4-a5-80c50a1456c4

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>




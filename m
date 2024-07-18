Return-Path: <linux-kernel+bounces-256161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2178C934A13
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A5C1F24210
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ADB7E0E8;
	Thu, 18 Jul 2024 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cZsqkc0D"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627D3B784;
	Thu, 18 Jul 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292048; cv=none; b=m9tXoZ5YybnNDMZ/D+1kygwBbuaCUxgLMAMenE0O2MfNoIoa3g6TRlSjAy4IcEYKREclxbLv3ntj+G18MWTdZcBBt5YA5vLSuqKvN9f8rsDxopd3SrMCe+iNykgGIxuHSiFvKYfo0AnJnsxcZm/X5/4wJhxG2hwkMdtfaS4FXTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292048; c=relaxed/simple;
	bh=LWPDNQt7jaDmjYGG8OeyUBMlJOqBeBXguSQsTVETVnE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bvd++dIz36IbjLrvlXGtArlUaVi8HoTqa42hqvx32GQMsPLCmOJADTTrCtqN+vKKCH54tcfSx2Oihl5xjgGT4XU8UESvRTlXIgHaNOcAeMu2zhIDsXcS3BBZA73pMXdquMizMMB3/l86KTHIcAcSWx4F42YwzZl9BIhsXAzsmrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cZsqkc0D; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721292044;
	bh=LWPDNQt7jaDmjYGG8OeyUBMlJOqBeBXguSQsTVETVnE=;
	h=From:Subject:Date:To:Cc:From;
	b=cZsqkc0DvtIIUS6+ljEe8K/DBe7T47JaEYKECmQQo1VJg7Kbf/13hlsb2OP4A8S80
	 etdTlQ4J0E1D87jxdMV8wBezbuGVO0GtCqNoToDcfVHXjVlInfsBA/ytdGc/IK5fld
	 0eSWIs7F5lcpi6vSQeLPsF/jEsJdmMFeYsaOaSFKpIy+qxYKh9fLn4ALeWRK2ypWrq
	 Fvz63rl6Mn6yuTG4kXv8PqCBjjd2oXtRhjl+rLxe4pxeAcc5fc5ZlxDUWhwjkUGDqu
	 V9w2f9Z5PoWyofHvMxKESyRl9SNZWtdTWMtreR9XmtwNTGbpUlIuNmzhCxYfnN3dAN
	 1jy2vCdZ0Tktg==
Received: from [127.0.1.1] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0DBF33782167;
	Thu, 18 Jul 2024 08:40:44 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH v3 0/3] Add support for Firefly Core-PX30-JD4 SoM &
 baseboard
Date: Thu, 18 Jul 2024 09:40:23 +0100
Message-Id: <20240718-rockchip-px30-firefly-v3-0-3835cdd22eae@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPfUmGYC/4XNTQrCMBCG4avIrI3kv9aV9xAXMUntYG1KIqGl9
 O6mXYkgLt8P5pkZko/oE5x2M0SfMWHoS4j9Dmxr+rsn6EoDp1zSimkSg33YFgcyjIKSBqNvuom
 o2je2Fk5XRwnldigzjpt7uZZuMb1CnLY3ma3rPzEzQomm1hknKBdGnG3oOnML0RxseMKqZv4pV
 b8kXiSqlWRGGVVL/S0ty/IGAtuwAggBAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Kever Yang <kever.yang@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>, 
 Collabora Kernel Mailing List <kernel@collabora.com>, 
 Christopher Obbard <chris.obbard@collabora.com>
X-Mailer: b4 0.13.0

This adds support for the PX30-based Core-PX30-JD4 system-on-module from
Firefly and includes support for the SoM in combination with the
Firefly MB-JD4-PX30 baseboard.

---
Changes in v3:
- Rename px30-firefly-jd4.dts=>px30-firefly-jd4-core-mb.dts to follow
  the existing <SoC>-<brand>-<SoM>-<carrier>.dts pattern.
- Change the compatible names to firefly,px30-jd4-core and
  firefly,px30-jd4-core-mb to follow the above pattern.
- Adjust some grammatical errors (with=>on).
- Link to v2: https://lore.kernel.org/r/20240717-rockchip-px30-firefly-v2-0-06541a5a5946@collabora.com

Changes in v2:
- Split into two separate files: dtsi for the SoM and dts for the carrier.
- Change devicetree compatible to match SoM/carrier split.
- Change device names to better match vendor's name.
- Properly model baseboard & SoM regulators.
- Properly model baseboard recovery key.
- Remove DSI panel (& related nodes) since "sitronix,st7703" compatible
  is undocumented & hardware is unavailable.
- Remove unused audio-related nodes.
- Remove unused UART nodes.
- Remove unused PMIC pinctrl nodes.
- Add node for baseboard LEDs.
- Link to v1: https://lore.kernel.org/r/20240716-rockchip-px30-firefly-v1-0-60cdad3023a3@collabora.com

---
Christopher Obbard (3):
      dt-bindings: arm: rockchip: Add Firefly Core-PX30-JD4 on baseboard
      arm64: dts: rockchip: add Firefly Core-PX30-JD4 SoM
      arm64: dts: rockchip: add Firefly JD4 baseboard with Core-PX30-JD4 SoM

 .../devicetree/bindings/arm/rockchip.yaml          |   6 +
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../boot/dts/rockchip/px30-firefly-jd4-core-mb.dts | 179 ++++++++++++
 .../boot/dts/rockchip/px30-firefly-jd4-core.dtsi   | 322 +++++++++++++++++++++
 4 files changed, 508 insertions(+)
---
base-commit: 51835949dda3783d4639cfa74ce13a3c9829de00
change-id: 20240716-rockchip-px30-firefly-59efc93d6784

Best regards,
-- 
Christopher Obbard <chris.obbard@collabora.com>



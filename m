Return-Path: <linux-kernel+bounces-255438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C91B9340BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA1EB2223E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9B61822F3;
	Wed, 17 Jul 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kFu+FVTF"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B80917E8FA;
	Wed, 17 Jul 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721234835; cv=none; b=CgT185jos0Mz8bvie2Ec648oRu5EXbjUnovuiv3M3CgvC8pdxU4WsG+48g061HAsNg3MYUuwxEAEVwxCU1TyxIVYoXlsULQ61KX5Y0v0xwiGU8IYhVHzyFNgy8pxN/aeRxCqAXsXYWcMsk/KQqbfUxpPrsxnUyAppkPggdihpnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721234835; c=relaxed/simple;
	bh=7/VlwMrzZKcazhdqh/NYPmp8rydn7Fr3YpN/2btgZpk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=omlhvMwvNmqlXMKFmLmXGEcBbXocNNpis5zB37GOx2AbrpZr8GUXQVlBOJ15Ahzo1BzHgfVDMk4Xemo3HeTnyL9P9zLNk5UoZTuIsUYLgfaMDqOqMP1GCJz2JYIphXzHtDtekwfV/DaNY6PdcAhNEpD2HgZOj1U5XrSMOvCBZWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kFu+FVTF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721234828;
	bh=7/VlwMrzZKcazhdqh/NYPmp8rydn7Fr3YpN/2btgZpk=;
	h=From:Subject:Date:To:Cc:From;
	b=kFu+FVTFofSadoVStjEIi4dKZvSejWuYgtv+izA/T4vLz5G/SEjzZUFGs1cTxMw7K
	 Isyrx94TZuPnEAwHVfkEj/WXUlLYxoLBFh2SFu+9XVtmN1CLImPrYLAwuJ4FK9/ChR
	 2IZ5tyTeGwcbOox89fTaAtWw8dkbBgiIlenK78TmnsiSW4C0d2TNaAMrkr05U5sNCx
	 8sEuHRaE+sQYBUbMLMdSRBNNljJr07aYnsIKv5HpNEgH7C/43pCpjVfZAaLVhMekBv
	 SL0fhknv2dbfdsOigHk5uiMqD/m50PYthWQLKR7iZdXT50IaBvfJjCBXMXiULjKG0u
	 wo+K3ZhLb62cw==
Received: from [127.0.1.1] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5BB143780B50;
	Wed, 17 Jul 2024 16:47:08 +0000 (UTC)
From: Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH v2 0/3] Add support for Firefly Core-PX30-JD4 SoM &
 baseboard
Date: Wed, 17 Jul 2024 17:46:58 +0100
Message-Id: <20240717-rockchip-px30-firefly-v2-0-06541a5a5946@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIL1l2YC/4WNQQ6CMBBFr0Jm7ZjSIggr72FY1GkrE5GS1jQQw
 t2tXMDle8l/f4NoA9sIXbFBsIkj+ymDPBVAg56eFtlkBilkJZqyxuDpRQPPOC9KoONg3bjipbW
 OWmXq5lpB3s5Z83J0733mgePHh/W4SeXP/iumEgXWgow2Skil1Y38OOqHD/pM/g39vu9fKN20V
 74AAAA=
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
      dt-bindings: arm: rockchip: Add Firefly Core-PX30-JD4 with baseboard
      arm64: dts: rockchip: add Firefly Core-PX30-JD4 SoM
      arm64: dts: rockchip: add Firefly JD4 baseboard with Core-PX30-JD4 SoM

 .../devicetree/bindings/arm/rockchip.yaml          |   6 +
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../boot/dts/rockchip/px30-firefly-jd4-core.dtsi   | 322 +++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/px30-firefly-jd4.dts  | 178 ++++++++++++
 4 files changed, 507 insertions(+)
---
base-commit: 51835949dda3783d4639cfa74ce13a3c9829de00
change-id: 20240716-rockchip-px30-firefly-59efc93d6784

Best regards,
-- 
Christopher Obbard <chris.obbard@collabora.com>



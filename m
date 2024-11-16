Return-Path: <linux-kernel+bounces-411614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65FC9CFCE1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 07:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FCC3B25005
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 06:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4E7191473;
	Sat, 16 Nov 2024 06:19:33 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F94A33;
	Sat, 16 Nov 2024 06:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731737972; cv=none; b=IHfKXS92drzsWJC2trkNrjKs5KYKDNhsXBuKHmwP5PYk6ubrsQgjf1CmBwzETRe6VSAJ64ghL/oaYp1xriQ4iFY3boSK6VJ9j/leP8qTQKd/H70J+fdy8Te9u8g7cCiZWQ81lwdKAPZLC84xMa39uUx6fWdMO/Xj07sV0SAwMRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731737972; c=relaxed/simple;
	bh=dWRxzl943f/IoxqFKT+mrLOC4thOFxH1f9VBnNH7dRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CYroPNLP4+r+88NfHoj5N6qVbjYzf2WzeNpLvWdplKrlrF/5QU1xmvltRwiUaFNQMdxteWz4MUUDirTcGorBg4UWh79tFdha3W1CLxRCrr/hU8P+3kLoGpDPdcNZt+ypaCcBUdVs9ckXA4WVhkbWyV3j9rGVwfO7h+xxx4bJJAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 654F9B4B0612;
	Sat, 16 Nov 2024 07:19:16 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: E Shattow <e@freeshell.de>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] riscv: dts: starfive: jh7110-milkv-mars: enable usb0 host function
Date: Fri, 15 Nov 2024 22:17:07 -0800
Message-ID: <20241116061719.36409-2-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable host mode JH7110 on-chip USB for Milk-V Mars by setting host mode
and connect vbus pinctrl.

This functionality depends on:

1. commit e10c52e7e064038d9bd67b20bf4ce92077d7d84e
"phy: starfive: jh7110-usb: Fix link configuration to controller"

2. Setting the USB over-current register to disable. This is done at
bootloader phase, for example U-Boot:
https://patchwork.ozlabs.org/project/uboot/patch/20241012031328.4268-6-minda.chen@starfivetech.com/

If the over-current register is not prepared for us then the result is no
change in functional outcome with this patch applied; there is an error
visible to the user and this additional usb configuration fails (same as
it is now). The existing three VL805 connected USB ports via PCIe on 
Milk-V Mars are not affected.

Changes since v1:
 - series name (was "[PATCH] riscv: dts: starfive: jh7110-milkv-mars: set host mode and vbus pin for on-chip USB 2.0")
 - adjust pin label to obey dtschema
 - use cover letter

E Shattow (1):
  riscv: dts: starfive: jh7110-milkv-mars: enable usb0 host function

 .../boot/dts/starfive/jh7110-milkv-mars.dts    | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
2.45.2



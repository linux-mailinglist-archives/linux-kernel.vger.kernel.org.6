Return-Path: <linux-kernel+bounces-412374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0136F9D0834
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 605DCB2185A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00D76F06A;
	Mon, 18 Nov 2024 03:47:55 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D07F634;
	Mon, 18 Nov 2024 03:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731901675; cv=none; b=Uf2r/PKeSU79VGqIyDO16ATdzPtf5VORNUklCJ/2fqpnwztVPYa+7qezoX6ZX+aPrI3b168VEQ/wp8W3dzb7qHRkHcsF5ro8yEIKjcpWqMDNvezMKe3c+O1eeCkjzdFQJQtg3xmNcX1imGYkTdWb9eL72jQ7/Peymo6/3y4XDV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731901675; c=relaxed/simple;
	bh=CX9fAmaRYr8k4O8NkxIKzZlP3Qn2fscrlws9Q5f19fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KZLf9m+HRYmWpVCJIrHuZj1JEfauA1iHHctJf82VqGFzDQhUpXm2SQ8emfE4bAIm8cde9kxMxyXCNh/pp/PD5gW/vMmVV6oi2VXqC6LhT30EK1/S5EkuSAFyYa/YfL2aTlT9RoP7APp+X5WWBM8S5RDJPprR9VnAYe2tZT4XDvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id B6601B4B0646;
	Mon, 18 Nov 2024 04:47:39 +0100 (CET)
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
Subject: [PATCH v3 0/1] riscv: dts: starfive: jh7110-milkv-mars: enable usb0 host function
Date: Sun, 17 Nov 2024 19:45:07 -0800
Message-ID: <20241118034558.43226-2-e@freeshell.de>
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

This functionality depends on setting the USB over-current register to disable at bootloader phase, for example U-Boot:
https://patchwork.ozlabs.org/project/uboot/patch/20241012031328.4268-6-minda.chen@starfivetech.com/

If the over-current register is not prepared for us then the result is no
change in functional outcome with this patch applied; there is an error
visible to the user and this additional usb configuration fails (same as
it is now). The existing three VL805 connected USB ports via PCIe on
Milk-V Mars are not affected.

Changes since v2:
 - Rebase on 6.12

Changes since v1:
 - series name (was "[PATCH] riscv: dts: starfive: jh7110-milkv-mars: set host mode and vbus pin for on-chip USB 2.0")
 - adjust pin label to obey dtschema
 - use cover letter

E Shattow (1):
  riscv: dts: starfive: jh7110-milkv-mars: enable usb0 host function

 .../boot/dts/starfive/jh7110-milkv-mars.dts   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
2.45.2



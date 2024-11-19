Return-Path: <linux-kernel+bounces-413788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F224D9D1EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70CA281526
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697BA14600F;
	Tue, 19 Nov 2024 03:12:47 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07513C683;
	Tue, 19 Nov 2024 03:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985967; cv=none; b=dMnVkxhjQDikylB3T1KpUx67mQacIFX2J7tKAeYVjBHDTJR/sxKmkYuphLtcmcOL/GQ5S5UNL2LYhLzA9KSPQkh4VTiPH5ASw8Kp6Gicl8jtVROebTUTa24eOA0awxZdsg0g3qoIgNGsmNJZ7MxA5vCLysGU/0KfXx+Kv7PKvuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985967; c=relaxed/simple;
	bh=F3bX2MmGSRD1fwkR0Iwqr3u8WyJ5ds5TDKEKgocQafA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fx1N7I68/UJ3FpIaCFrg5xsJcN/3OTJRJluVmB73w+TMzrQalzltOkZA5076NNXwUr2y/+VjmsRQdAkniFlqJIiAsF9dM4m0LK7XVn4jL9d2dlJqn8vIbLUrXRANCKY4irW6RGw1/uvqSY69FviFt8pMBJolKQv7ZTeeBM0i9A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 007E1B226177;
	Tue, 19 Nov 2024 04:12:37 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Henry Bell <dmoo_dv@protonmail.com>
Cc: E Shattow <e@freeshell.de>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] riscv: dts: starfive: jh7110-pine64-star64: enable usb0 host function
Date: Mon, 18 Nov 2024 19:12:18 -0800
Message-ID: <20241119031232.50726-1-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable host mode JH7110 on-chip USB for Pine64 Star64 by setting host mode
and connect vbus pinctrl.

This functionality depends on setting the USB over-current register to disable at bootloader phase, for example U-Boot:
https://patchwork.ozlabs.org/project/uboot/patch/20241012031328.4268-6-minda.chen@starfivetech.com/

If the over-current register is not prepared for us then the result is no
change in functional outcome with this patch applied; there is an error
visible to the user and this usb configuration fails (same as it is now).

Changes since v1:
 - Rebase on linux-next/master
 - use tabs for code indent

E Shattow (1):
  riscv: dts: starfive: jh7110-pine64-star64: enable usb0 host function

 .../boot/dts/starfive/jh7110-pine64-star64.dts | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
2.45.2



Return-Path: <linux-kernel+bounces-423627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF249DAAA1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9478DB20FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABBB1FF7D5;
	Wed, 27 Nov 2024 15:19:39 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F51FF7BD;
	Wed, 27 Nov 2024 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720779; cv=none; b=BgtffA1cVVukXElg4NwF9MhU0K3Sgi4boIi2a2sp+denOicc4XHM8N5SGYETovSakFDtjidAnELqdBNYuYtY22pqpuBNNmHEHUryv6OUCZWHKfMSjGpMSbVbWz020bEU6oz2UPzx9Ha8B017EYS6Xu0cCWESD6fW6rKmQf4Pkyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720779; c=relaxed/simple;
	bh=YSdBxIV/CXg0i4Is6e+8DtfT1c6uKMHBuxco1Jt1Ey0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQvH6D34OAxf1ideLmBpMYv7rTtfeE72Xju6p8+EW0siNvxLT8Vh2R1GEMQEC++PU8+TpvF89kD+IOAq6yFJ0F4jdkfHClKfNU+lBnJmz1E4py/LHn+0JlG25R+Rm7WKwX7Xh9SWC4IkkdSjJ+Q2ymFEd3oIdHpwZ+enbZ0f9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 70CEFB4B1D6A;
	Wed, 27 Nov 2024 16:19:30 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Henry Bell <dmoo_dv@protonmail.com>
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
Subject: [PATCH v4 0/1] riscv: dts: starfive: jh7110-pine64-star64: enable usb0 host function
Date: Wed, 27 Nov 2024 07:15:04 -0800
Message-ID: <20241127151843.70341-1-e@freeshell.de>
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

This functionality depends on setting the USB over-current register to 
disable at bootloader phase, for example U-Boot:
https://patchwork.ozlabs.org/project/uboot/patch/20241012031328.4268-6-minda.chen@starfivetech.com/

If the over-current register is not prepared for us then the result is no 
change in functional outcome with this patch applied; there is an error 
visible to the user and this usb configuration fails (same as it is now).

Changes since v3:
 - Rebase on latest master
 - Addtional detail to commit description

Changes since v2:
 - Rebase on latest master

Changes since v1:
 - Rebase on linux-next/master
 - use tabs for code indent

E Shattow (1):
  riscv: dts: starfive: jh7110-pine64-star64: enable usb0 host function

 .../boot/dts/starfive/jh7110-pine64-star64.dts | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
2.45.2



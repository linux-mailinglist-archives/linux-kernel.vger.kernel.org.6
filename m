Return-Path: <linux-kernel+bounces-329882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CC9979714
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BE4281E9C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6D61C6F69;
	Sun, 15 Sep 2024 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kxEeo9F9"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D611C6897;
	Sun, 15 Sep 2024 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726410263; cv=none; b=mfouJQojWH4Ap2xWzEr4+qVvmLwDZaEGQt5T/9zcXeoMpyV9KXpHCa66iomXNMJ4oP+8KEnJfvn9xslUAmR+rFLcYjcONI/QO2c+R65iFiOz1H1w9k5FXaHnaqiujcWUk9R1vil5/XniptzEbU55RfCf+5/Ku3Ari7oXWS8+8ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726410263; c=relaxed/simple;
	bh=sWnAKgucH18oeq9zYS40OQn7pH5zp57SRhJ7CklZ7Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mTJY0KD5rEXYep4TWGeZze8CNmOmwJDvCBe4gZws/bhWsKchJyK4uJtXm8mkszPpmQfx+8f3NYIDWxOl7XKjJUUvXPeaNEGpA8bmy0YKVdaGImRwpUD42e7AkELNYhE+QpLit2eKF4ZxLDjidqf7wWUDNtB7lxeCHOPWP0CVJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kxEeo9F9; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=TKFcsOdhek0MQQPDbf+d7h1KvB9ASf45xqz2FA0Pvtw=;
	b=kxEeo9F9quII4RERyftAooA6a1sJkTQAfSl47OAWc36+x1KG7EvXN/TjrEUBP7
	bf/hsr7c1j7Yz+D7G6UyCJlKSHHai1bg9GwaXIjDoij1ngUkT4ztAYBm0CtCLpeU
	thNnP0IzmpplGkfIwfSukHaEufUb4n89D0g6KnkbHv4O8=
Received: from localhost (unknown [27.18.168.209])
	by gzga-smtp-mta-g3-0 (Coremail) with SMTP id _____wAnblZk7eZmaNI2Aw--.11240S2;
	Sun, 15 Sep 2024 22:21:24 +0800 (CST)
Date: Sun, 15 Sep 2024 22:21:24 +0800
From: Ze Huang <18771902331@163.com>
To: linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, conor@kernel.org
Cc: cyy@cyyself.name, jesse@rivosinc.com, jszhang@kernel.org,
	inochiama@outlook.com, uwu@icenowy.me, zhangmeng.kevin@spacemit.com,
	kevin.z.m@hotmail.com, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	dlan@gentoo.org, 18771902331@163.com
Subject: [PATCH 0/3] Add initial support for Canaan Kendryte K230 pinctrl
Message-ID: <ZubtZKlxqejnCFx_@jean.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID:_____wAnblZk7eZmaNI2Aw--.11240S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFW3uFyxWrW8WFWrCr18AFb_yoW8AF1Upa
	13CF9xGrnrGr4SkrWft3Wv9ry3Can7Jr1Y93Way3srXF43ZFyqywnxKrW5Xw4DGr47Z3yY
	9r4rtry8Wr15AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziU5r7UUUUU=
X-CM-SenderInfo: zpryllqrzqjjitr6il2tof0z/1tbiNxxbomXAnRCLnwAEsq

This patch series introduces support for the pinctrl driver of the Canaan
K230 SoC. The K230 SoC features 64 IO pins, each of which can be configured
for up to five different functions.
							
The controller manages the entire pin configuration and multiplexing
through a single register, which control features such as schmitt trigger,
drive strength, bias pull-up/down, input/output enable, power source, and
mux mode.

The changes have been tested on the K230 development board.
							
The pin function definition can be found here [1], and most of the DTS data
was converted from the vendor's code [2].

Link: https://developer.canaan-creative.com/k230/dev/_downloads/a53655a81951bc8a440ae647be286e75/K230_PINOUT_V1.1_20230321.xlsx [1]
Link: https://github.com/kendryte/k230_sdk/blob/main/src/little/uboot/arch/riscv/dts/k230_canmv.dts [2]

Ze Huang (3):
  dt-bindings: pinctrl: Add support for canaan,k230 SoC
  pinctrl: canaan: Add support for k230 SoC
  riscv: dts: canaan: Add k230's pinctrl node

 .../bindings/pinctrl/canaan,k230-pinctrl.yaml | 128 ++++
 arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi  | 318 +++++++++
 arch/riscv/boot/dts/canaan/k230-pinctrl.h     |  18 +
 arch/riscv/boot/dts/canaan/k230.dtsi          |   2 +
 drivers/pinctrl/Kconfig                       |  10 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/pinctrl-k230.c                | 674 ++++++++++++++++++
 7 files changed, 1151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/canaan,k230-pinctrl.yaml
 create mode 100644 arch/riscv/boot/dts/canaan/k230-pinctrl.dtsi
 create mode 100644 arch/riscv/boot/dts/canaan/k230-pinctrl.h
 create mode 100644 drivers/pinctrl/pinctrl-k230.c

-- 
2.46.1



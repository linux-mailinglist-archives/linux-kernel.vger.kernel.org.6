Return-Path: <linux-kernel+bounces-227306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB00914F17
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E871F2196A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA7813E889;
	Mon, 24 Jun 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="eV82MdeP"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C24D13DB83;
	Mon, 24 Jun 2024 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236957; cv=none; b=svebFm1gnntPsqbO1xkIa1EgKlqTSF8ua2S4c6DYzVI2BuOM6thArWDmJ6LBJVIzvQfdXya53XKjxRWQugGqv61M/LD8ZDndm0OdktOR//7e5bqaMtE6wS2L0OaIJD40wzxDrwXC3roxrmgjHF6STFjynu4Lqs4oCCQLboAivGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236957; c=relaxed/simple;
	bh=0W+C73xFi10D1zyj9OdcL1ESKNG08JcwE4ZimHsEhBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V86QWgXMtowPCPH2vilwgIGsWgmaoJDc9laWq+zpuimW35fVzB1J10+H6I6onQav3yGJ6FkT1HWvNwoQDM2fLNkoRaW6Om9E50L2IqGPuAKwQv2cEhqxBuccJ+Wd7nddc39fa1DJVpS4nYH4fLrNWzlblwslm7DSAJeIORTQrnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=eV82MdeP; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8307E10000D;
	Mon, 24 Jun 2024 16:49:01 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8307E10000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1719236941;
	bh=1nrLHKRDeZOlG7iRG58yx2wRWxXJ1fEP3otaW6bOYCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=eV82MdePHKY4+5PfujA6iLId+JmoR8/qyNxs8zwwNYP5QLUcHCT/f1NqH4dfgdPKR
	 kdQB7pf8ZABRgSncq+bkldjgQiSljNaMHIcYX76DMJp3XD17LCdjA7BFKlWxjROXsG
	 19FQMMLBoxi4OsbDvTLSIjEh7hvefQo6e6E2zRA4VPeDED6lftndzH324OcfvpS2Pc
	 m64NreJwsgRiBhrRmeP26MWSpHLmGWZvPY0tuXXcumOuSbTSXFzuYRp1jV1Mim+2/m
	 xgVBdQeSDj43zZePtvj27iudeBm9gANJJKHvl04+xCZYc6w9Lz8FeckF/ks4K1KN7p
	 f2KjpgdcN0rfQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 24 Jun 2024 16:49:01 +0300 (MSK)
Received: from [172.28.192.142] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 24 Jun 2024 16:49:00 +0300
Message-ID: <f7b13cc0-6155-4b0f-9f63-c35d73c3032f@salutedevices.com>
Date: Mon, 24 Jun 2024 16:48:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] reset: amlogic: move reset drivers out of CCF
To: Jerome Brunet <jbrunet@baylibre.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>
References: <20240516150842.705844-1-jbrunet@baylibre.com>
Content-Language: en-US
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <20240516150842.705844-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186090 [Jun 24 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/24 10:37:00
X-KSMG-LinksScanning: Clean, bases: 2024/06/24 13:26:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/24 08:41:00 #25695455
X-KSMG-AntiVirus-Status: Clean, skipped

Jerome,

Do you have any updates? I'm looking forward to these changes so I can
continue my work on a1 audio clock controller driver.

On 5/16/24 18:08, Jerome Brunet wrote:
> This RFC follows the discussion about having reset driver in the clock tree
> [1]. Ideally those should reside in the reset part of tree.
> 
> Also the code of the amlogic reset driver is very similar between the 2 trees
> and could use the same driver code.
> 
> This RFC moves the reset driver of audio clock controller of the g12 and
> sm1 SoC family to the reset tree, using the auxiliary bus.
> 
> The infrastructure put in place is meant to be generic enough so we may
> eventually also move the reset drivers in the meson8b and aoclk clock
> controllers.
> 
> [1] https://lore.kernel.org/linux-clk/e3a85852b911fdf16dd9ae158f42b3ef.sboyd@kernel.org
> 
> Jerome Brunet (9):
>   reset: amlogic: convert driver to regmap
>   reset: amlogic: add driver parameters
>   reset: amlogic: split the device and platform probe
>   reset: amlogic: use reset number instead of register count
>   reset: amlogic: add reset status support
>   reset: amlogic: add toggle reset support
>   reset: amlogic: add auxiliary reset driver support
>   clk: meson: add auxiliary reset helper driver
>   clk: amlogic: axg-audio: use the auxiliary reset driver
> 
>  drivers/clk/meson/Kconfig                     |   6 +
>  drivers/clk/meson/Makefile                    |   1 +
>  drivers/clk/meson/axg-audio.c                 | 108 +--------
>  drivers/clk/meson/meson-clk-rst-aux.c         |  84 +++++++
>  drivers/clk/meson/meson-clk-rst-aux.h         |  14 ++
>  drivers/reset/Kconfig                         |   1 +
>  drivers/reset/reset-meson.c                   | 210 ++++++++++++++----
>  include/soc/amlogic/meson8b-auxiliary-reset.h |  17 ++
>  8 files changed, 293 insertions(+), 148 deletions(-)
>  create mode 100644 drivers/clk/meson/meson-clk-rst-aux.c
>  create mode 100644 drivers/clk/meson/meson-clk-rst-aux.h
>  create mode 100644 include/soc/amlogic/meson8b-auxiliary-reset.h
> 

-- 
Best regards
Jan Dakinevich


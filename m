Return-Path: <linux-kernel+bounces-182741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB81E8C8F3C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 03:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7B2283329
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64C04A29;
	Sat, 18 May 2024 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="IMf90iAc"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0181373;
	Sat, 18 May 2024 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715996641; cv=none; b=Ut/Wq9iUlNt8g4/JC358DNfrhpneX64XiHaX9Hm/WPvvr7FK3wIDpbcZjYxTqIW4dNf6Ivzr7sYTDxgHQwNxk+JZ69/ilJjZxGEEDVcHBwtE0QpU2LRbCWYy4qR1bkZgZWulj9UuNUXEWEFKWh3X0WGTLp1yIvc7k8QdrwTnRaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715996641; c=relaxed/simple;
	bh=HsKsucMsmS6BafeRf0/gX3JGyFGFDkR+bzzDzyWfx6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aznWy1aetaq9paASBC/XZpw6gFWaaT7H0ofCRxsLgDGPtG2hLnuAw4gNV69dSqV0d4TtfW7222vFys75kj5fU5S5PP4scLCyGwb+1d2gykTQqWjZ/L5jjAj6nZ2yMXaTjNqjBtA+wDxnu+pVKd4zdht0/KXpSEsh3Sj0qD7BIwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=IMf90iAc; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id BB146100008;
	Sat, 18 May 2024 04:43:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BB146100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715996634;
	bh=ciRY/oNH7Pr9VAZ4Mv/e3qGv1izWj9doEd37rAcP5cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=IMf90iAcoSN85RZyksX59dlMj9rPJKI1jtqcZgaIRUrqVMj+wTg42Ws8be2pJG7oA
	 18W2bAU12HxBvhxLOY07WeSIBO5ezTql8gIFvhkVGZ9Chh/ej9De7eFRJL4o/3AiQR
	 2mQUtooEDPzLjYvShSLKVNdagcYmF1gdjsBKWGxH5qEiUi2ne9CYhMPEqHbs/waSoe
	 QEdiy6xcttSndUVD8hBKXzcoRS1uvEozFjjr3kXgFQra8AdK7RNTFPn0At0velRA0J
	 uW8rFYg69KnO7Ug36X/awf8NIN1XxDKXgUr6OXvcXieUHMDeB48iEUfNBWvVp9XuuP
	 SFxHs/OOCskFg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 18 May 2024 04:43:54 +0300 (MSK)
Received: from [192.168.20.2] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 18 May 2024 04:43:54 +0300
Message-ID: <f09ae219-dec6-425a-b6f4-12732b186a05@salutedevices.com>
Date: Sat, 18 May 2024 04:43:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/9] reset: amlogic: move reset drivers out of CCF
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>
References: <20240516150842.705844-1-jbrunet@baylibre.com>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <20240516150842.705844-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185325 [May 18 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;lore.kernel.org:7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/18 00:39:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/18 00:41:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/17 20:54:00 #25244128
X-KSMG-AntiVirus-Status: Clean, skipped

This is a nice rework! But unfortunately after applying these patches at
least USB doesn't work on A1 SoC. My assumption it is because
RESET_MESON is now unselected due to dependency on AUXILIARY_BUS.

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


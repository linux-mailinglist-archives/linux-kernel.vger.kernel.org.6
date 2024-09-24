Return-Path: <linux-kernel+bounces-337200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6689846D1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A495B22A42
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141701A76D4;
	Tue, 24 Sep 2024 13:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=milecki.pl header.i=@milecki.pl header.b="H4Qq7VYD"
Received: from 13.mo581.mail-out.ovh.net (13.mo581.mail-out.ovh.net [87.98.150.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5CD16F0C1
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.150.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727184892; cv=none; b=qqlcQ3qlzO2Fl+ZWdVd7tfLlxcPzSRHxgIO2NKunMhnW6GHl3ihPhiqp8c9r1aiO8CuC/IpIyS0fs0w5ejiYE921rDeziP9JLbYgXSd4iepWXJ3qgh65coPhAdl4Ev1D9siPGrh6DUBrFff2Cvtlk7Zq2BQwwQP8XsTFrjQW1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727184892; c=relaxed/simple;
	bh=BnNTOClk37Yx5kmE3nkdR71wySOFIiN6hExvBSLNF8Q=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sMfkyr4hhma12k3WA2DKvGvaJPL5arstycIdXlzvjGpwHIWboiO7r+GTcQoTnahtDucmGanIaLExUMe4ChtPoNHyG/fZAAXjOLfEtDUcpFGyh/gNYXQae7Xx7oeWQ9lOgXh8Cp2nBiVAQKQMMQJHp/z+Tk5B6g9Fkkh9GKIAeeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl; spf=pass smtp.mailfrom=milecki.pl; dkim=pass (2048-bit key) header.d=milecki.pl header.i=@milecki.pl header.b=H4Qq7VYD; arc=none smtp.client-ip=87.98.150.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=milecki.pl
Received: from director6.ghost.mail-out.ovh.net (unknown [10.109.176.170])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4XCZxK6yC1z1Np1
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:55:49 +0000 (UTC)
Received: from ghost-submission-55b549bf7b-5q9lx (unknown [10.110.164.235])
	by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 3B7A11FE9B;
	Tue, 24 Sep 2024 09:55:47 +0000 (UTC)
Received: from milecki.pl ([37.59.142.101])
	by ghost-submission-55b549bf7b-5q9lx with ESMTPSA
	id AqzIBaOM8mZcgQAA+u7rcQ
	(envelope-from <rafal@milecki.pl>); Tue, 24 Sep 2024 09:55:47 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-101G004d3854881-9240-4405-bcc0-c07042d02785,
                    1AB79004D049CCABD2FE35BF073248474FDEF107) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp:151.80.29.20
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Sep 2024 11:55:44 +0200
From: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To: Sandie Cao <sandie.cao@deepcomputing.io>
Cc: Conor Dooley <conor@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Michael Zhu
 <michael.zhu@starfivetech.com>, Drew Fustini <drew@beagleboard.org>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dhs@frame.work, ams@frame.work,
 gregkh@linuxfoundation.org, yuning.liang@deepcomputing.io,
 huiming.qiu@deepcomputing.io
Subject: Re: [patch v2 3/3] riscv: dts: starfive: add framework dts
In-Reply-To: <20240924080650.1345485-4-sandie.cao@deepcomputing.io>
References: <20240924080650.1345485-4-sandie.cao@deepcomputing.io>
Message-ID: <75d4f0395187f7950e0450a91fbe087d@milecki.pl>
X-Sender: rafal@milecki.pl
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10134506538491882359
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtvddgvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghfkfigihgtgfesthekjhdttddtjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepjeejkeekgeejtdffffevffeivedtueeifeeuffegkeehkeeliedugfelfedutdeunecukfhppeduvdejrddtrddtrddupdefuddruddurddvudekrddutdeipdduhedurdektddrvdelrddvtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedupdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=jffzDI9wqpTBxYh402/WuPcxuVwvyleh09GDw3XTbs0=;
 c=relaxed/relaxed; d=milecki.pl; h=From; s=ovhmo3028686-selector1;
 t=1727171750; v=1;
 b=H4Qq7VYDRzRWv9WFaKeW1C47OolejEPczUMrO/b5LLTjo2+5Z3m5nY+1cHFcCufYPh5t/6hk
 oMrRFbUEq/f2QprP1TO9UxEXsV2uwjvrBk3XxOGOfYSh5lvYxK8q5do3FJoXGkBQVlCRRl3O1+G
 j3wAt0duT4a3RN+jaHXNimzKu2hN9qKAr153r4ypR60sYAP9fibB4gSaWR9PBsawYGFcpDlscQ4
 5UZk7IOgZuy4uu+Q+0HWZBAFmDEiCqhUShtiId4/icFcn0eloP/h2br97bFgUBxA3/YVg3IvwQ+
 qqLrPsjwzccFcyJdJRsf9qwltIPJWn42N5B7jCN4YUvKg==

On 2024-09-24 10:06, Sandie Cao wrote:
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-framework.dts
> b/arch/riscv/boot/dts/starfive/jh7110-framework.dts
> new file mode 100644
> index 000000000000..ff12c24ebab3
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-framework.dts
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + */
> +
> +/dts-v1/;
> +#include "jh7110-common.dtsi"
> +
> +/ {
> +	model = "Framework FRANME0000";
> +	compatible = "deepcomputing,fm7110", "starfive,jh7110";
> +};

Nitpicking: property "compatible" should go first.

See Documentation/devicetree/bindings/dts-coding-style.rst

-- 
Rafał Miłecki


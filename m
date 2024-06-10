Return-Path: <linux-kernel+bounces-208425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA7C902508
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A262283369
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D1113774B;
	Mon, 10 Jun 2024 15:10:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B697475811
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032239; cv=none; b=jRXaFa+umS5cufUZ8pKup+oitUGvDTpeGYYzrPZgLjf2tIi85g0DgUbmzEzNRvy2+AB1j1WiDgFklknu02DE75XiRjCSh0bLFG6JikEq5aIOjpUU6X/V03MdO5u/hV0Fzw/QM4Lmidd9RU0h18pK/7E2QKPCxIKauPcH6O+3YOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032239; c=relaxed/simple;
	bh=5r4ukgqEF1qj0bHPwSmTT8cznWocsdmxS7eFwAXP+T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQt5zl2uke2+i7n3krmb+cTcttPfhixeTNmTJbFay/svPfztyIFqekjcN7QjPX6gEcK0AGeICrLty3TX1ffy9eG49mTG7e6ZWAAiET9NlJmW5a/i+YbemxWdzpShd5hKVkMgRJXrYPyzjQIN4RTxbgcMYMSBxx9l6WJ87Of79n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D42911FB;
	Mon, 10 Jun 2024 08:11:00 -0700 (PDT)
Received: from [10.1.37.54] (e110479.arm.com [10.1.37.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A67E23F64C;
	Mon, 10 Jun 2024 08:10:32 -0700 (PDT)
Message-ID: <4f45d823-6ba3-4707-99eb-f8aa60c6b96b@arm.com>
Date: Mon, 10 Jun 2024 16:10:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ARM: highbank: Switch to new sys-off handler API
To: Andrew Davis <afd@ti.com>, Russell King <linux@armlinux.org.uk>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
References: <20240610125924.86003-1-afd@ti.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20240610125924.86003-1-afd@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/06/2024 13:59, Andrew Davis wrote:
> Kernel now supports chained power-off handlers. Use
> register_platform_power_off() that registers a platform level power-off
> handler. Legacy pm_power_off() will be removed once all drivers and archs
> are converted to the new sys-off API.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre

> ---
>   arch/arm/mach-highbank/highbank.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> index 5d4f977ac7d2a..47335c7dadf8d 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -143,7 +143,7 @@ static void __init highbank_init(void)
>   	sregs_base = of_iomap(np, 0);
>   	WARN_ON(!sregs_base);
>   
> -	pm_power_off = highbank_power_off;
> +	register_platform_power_off(highbank_power_off);
>   	highbank_pm_init();
>   
>   	bus_register_notifier(&platform_bus_type, &highbank_platform_nb);


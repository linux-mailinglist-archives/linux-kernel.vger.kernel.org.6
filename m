Return-Path: <linux-kernel+bounces-208923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D96C902AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F346F1C21963
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9F57441F;
	Mon, 10 Jun 2024 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="SsnNdOTk"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142F73464
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718055231; cv=none; b=ExT2WTTQ48bPNMGuXEWOaRo3Ze39P9k8z2IAAxR0PvQVe7aX+YOEw3/xV0XjUKkXTI1se543sc6AP0MsgK5xxzOhbp56hQFGRHpWywK8pQGifJcKm6HHeZpq1dtPYKCwKAMqiXSyeShyGt3AkxHgptnZ2VNFQjEw3hiHFDJ1LIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718055231; c=relaxed/simple;
	bh=f32KjrnsGTfLqF8AJMkxJbcM7cJ1SuuLl3l5ZRPemYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ch0D0uoFgYIr1Kohg5KVV6C1eKPM3EuTCMrqdP7869iOo7rVG3nFMZNhKdf486w7jgGz4eO30rQImRpvDT+oOQWcPSKh5mskGFrSicq1vNry1yVOYdUTLp7unZ1Xso+Ok7qrEieMnBo/3hQ+/ThnDERj9fB4BaQDmZvb2Qt72uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=SsnNdOTk; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B2362120006;
	Tue, 11 Jun 2024 00:33:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B2362120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1718055223;
	bh=OM7p7oWOsmuG64YjuqpD3mxXVAx1wWDU71+P9TUj9Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=SsnNdOTkc7YtsCtF0RbSGA7FibRa5ok+V73R+0ahgtPoSJzqkCxdHyqZrhyWNIAco
	 AG1BJtIlpwQCaIGYN6h0vxLF30uX5Es9XCDXe1tH3tgmH99544LGPJ7tRwWRWcXepb
	 RJ63yafJ4DDFmvOQBO2M4emzG7hKUSlnawDCBpcjjr/kns67fAy6hhDf4e2+L9GNkF
	 1n5Obz5YghqJVJDUKvYGW1Kw9h1oZvi5jMOfNHKqh8/UGzh6y2fTPHZMVQEiPtPlVc
	 /C3c9diD1NOj/po+w6pQh2S4YWflKWhNWr7cX31v8r7x1YE4f6ywYbe5IheNDOw9cT
	 tg5HYxQSdc/XQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 11 Jun 2024 00:33:43 +0300 (MSK)
Received: from [172.28.65.20] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 11 Jun 2024 00:33:43 +0300
Message-ID: <62c9b99d-f0a4-4207-84b9-2176823b9724@salutedevices.com>
Date: Tue, 11 Jun 2024 00:33:42 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] pwm-regulator with voltage table problem
To: Mark Brown <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>
References: <20240610120025.405062-1-gnstark@salutedevices.com>
 <Zmcdvm7XbtU1JlQr@finisterre.sirena.org.uk>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <Zmcdvm7XbtU1JlQr@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185847 [Jun 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/10 19:51:00 #25541519
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Mark

Thanks for the review. Sorry about the separate cover-letter.

On 6/10/24 18:37, Mark Brown wrote:
> On Mon, Jun 10, 2024 at 03:00:24PM +0300, George Stark wrote:
> 
>> The situation: bootloader sets mean cpu power and mean cpu clock.
>> but that cpu power is not found in the voltage table (value is between table items)
>> due to different versions of bootloader and kernel and the regulator core sets
>> the minimal power but cpu clock stays the same. CPU hangs somewhere during boot.
> 
> Why not just add this OPP to the table the kernel knows about?  Clearly
> it's something the vendor set and presumably thinks the device can
> actually operate at.  As far as I can tell you're only having problems
> here because you've got a software defined regulator but haven't given
> the software information about this configuration so it's got no idea
> what's going on when bootstrapping.

Actually we did a similar thing - we modified voltage table adding 
duty-cycle that was set by bootloader with fractional voltage value that 
is not used in opp table - just to make pwm-regulator happy.
But this issue was very hard to find. Due to deviations of hardware 
component's characteristics some devices managed to keep working with 
minimal voltage till cpu opp driver got probed and appropriate voltage 
is restored. Other devices got stuck at different places with random errors.

> 
>> The core problem as I see it is if regulator is bound to CPU (or some other
>> complex consumer) it can't be changed except by the consumer at any stage. So
>> the regulator driver (core part) should wait for the own consumer to init
>> it properly but regulator can't be in unknown state after probing.
> 
> If the regulator is configured outside the constraints configured for it
> in the binding then the core will bring the regulator within those
> constraints, some systems with regulator configurations fixed in
> silicon rely on this for correct performance.  Regulators with
> unreadable hardware are very much an edge case when it comes to this,
> what works for one system will be broken for another one so we just have
> to pick a behaviour that will hopefully work more often than it breaks.
> We can't rely on consumers setting a voltage since consumers are only
> expected to set a voltage if they are actively managing it at runtime,
> other consumers should rely on system configuration.

Of course such a behavior should be configurable. At the other hand it 
may be too much changes for a corner case that's why I proposed only a
warning patch just to simplify detecting the problem.

Actually we already have a hint that says voltage is reset:
rdev_info(rdev, "Setting %d-%duV\n",
				  rdev->constraints->min_uV,
				  rdev->constraints->max_uV);
but there's no indication this is due to regulator device  error.

Should I consider adding my warning only for "system-critical-regulator" 
regulators (cpu power regulator is critical indeed)? Although this 
property is never used in mainline bindings.

-- 
Best regards
George


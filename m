Return-Path: <linux-kernel+bounces-220267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C908690DEA8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0701C226AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2BA17836E;
	Tue, 18 Jun 2024 21:45:54 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E015D482DA;
	Tue, 18 Jun 2024 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718747154; cv=none; b=KA4TzC/cbTpDWlblkdWVWBMBY+FYT7bwo/p3rP3yyKV7Sf3OniNf6CPSLVqvJw8g98RF8NFjljb3p+p2bydbwtE47nT/BaOXrwzrNBZDF/Fh/d4+yToeSt+TB08xNd5RNSCzkG9JLw+7J2CoO4BmvpmCT1S15lun4eJYK6jgw40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718747154; c=relaxed/simple;
	bh=zm0VoCHvspoX3Cl0Nkq4VBXKqX7vSzlRo/EwxBbFU0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjPLRRym4qSSIZ9H53U7ZxuT9x55k/CtX4y6fBY1rcQA8yqM9oMOYvQT71M+gshDFyktry42oyTpzAVKewAzfTg5tEiKtnl5SipREjZj9OQq6v8EYfJottONmtfIqq3sBKEO+o7wWuKln4us/HsU6+FB4pzK7my6OaEBeZtI/ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af4b2.dynamic.kabel-deutschland.de [95.90.244.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9A41F61E5FE01;
	Tue, 18 Jun 2024 23:45:00 +0200 (CEST)
Message-ID: <9440d6f5-3164-40c9-95a1-00403b7f753e@molgen.mpg.de>
Date: Tue, 18 Jun 2024 23:45:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH v2 2/3] hwmon: (spd5118) Use spd5118 specific
 read/write operations
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Armin Wolf <W_Armin@gmx.de>, Stephen Horvath <s.horvath@outlook.com.au>,
 Sasha Kozachuk <skozachuk@google.com>, John Hamrick <johnham@google.com>,
 Chris Sarra <chrissarra@google.com>, linux-hwmon@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>
References: <20240618195348.1670547-1-linux@roeck-us.net>
 <20240618195348.1670547-3-linux@roeck-us.net>
 <a7f208df-4c9e-4fa2-9d17-80895db51182@molgen.mpg.de>
 <661def21-b0a9-49c1-937e-8526008f529c@roeck-us.net>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <661def21-b0a9-49c1-937e-8526008f529c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Guenter,


Am 18.06.24 um 23:08 schrieb Guenter Roeck:

> On 6/18/24 13:37, Paul Menzel wrote:
> [ ... ]
>> Unfortunately, it still fails:
>>
>>      $ git log --no-decorate --oneline -4
>>      7ddcff2d44ae3 hwmon: (spd5118) Add support for Renesas/ITD SPD5118 hub controllers
>>      e89136743324f hwmon: (spd5118) Use spd5118 specific read/write operations
>>      0fcc7279f0cc4 hwmon: (spd5118) Use regmap to implement paging
>>      801b6aad6fa7a hwmon: (spd5118) Add configuration option for auto-detection
>>
>>      $ uname -r
>>      6.10.0-rc4.mx64.461-00050-g7ddcff2d44ae
>>      $ sudo bash -c 'echo 56000 > /sys/class/hwmon/hwmon3/temp1_max'
>>      bash: line 1: echo: write error: No such device or address
> 
> Now I am really baffled. I don't think we could do anything simpler
> than that.
> 
> Please try
>      sudo i2cset -y -f 0 0x50 0x21 0x06
> 
> That should update the critical temperature from 85 degrees C
> to 86 degrees C. If that doesn't work, we'll be really out of luck
> with that controller (or at least I don't have an idea what else to try).

Bad news:

     $ sudo LD_LIBRARY_PATH=~/src/i2c-tools/lib tools/i2cset -y -f 0 
0x50 0x21 0x06
     Error: Write failed


Kind regards,

Paul


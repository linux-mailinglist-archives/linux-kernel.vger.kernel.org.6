Return-Path: <linux-kernel+bounces-220342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB7090E003
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F7A2840EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D53185E45;
	Tue, 18 Jun 2024 23:40:49 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38D15EFAF;
	Tue, 18 Jun 2024 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754048; cv=none; b=eiadt5lx5XK2qR3p35zEpCmY6FYRor11C5TNCqBQdIQI7M7j3vEOsCzdT28VV3T2pDHTWec2K5q3ctg+QEE6RxcUEqq2JKkN0NadinIKJyegtP34t2YOjNYqXwtfPZVJCcKmiFQR9KKYIxatylAJoT3znaLS5K7iu/UQfnazeko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754048; c=relaxed/simple;
	bh=PhVIethmpI/DLAqmGWjDLxd9jxBL8+RTgrvuFYs8qxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Qt9cK1cRiTlyTeQcHafuRE1+8ct4+CCwidB876IZ09v0jhnLrW+WZpFjm2i3SpjBg4w49Spk0XM1xLefVSquHEXzLh55M/0/89myvp5RS0AZmD/xj5PkgLYhwuX0JlPmpKq39inAtBcqETi1V0kQXZanxF8j01W3gLK9ljIhscE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af4b2.dynamic.kabel-deutschland.de [95.90.244.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 02F7D61E5FE01;
	Wed, 19 Jun 2024 01:39:58 +0200 (CEST)
Message-ID: <6845cc2d-c50b-415b-af49-bf57333ee939@molgen.mpg.de>
Date: Wed, 19 Jun 2024 01:39:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH v2 2/3] hwmon: (spd5118) Use spd5118 specific
 read/write operations
To: Armin Wolf <W_Armin@gmx.de>, Guenter Roeck <linux@roeck-us.net>
References: <20240618195348.1670547-1-linux@roeck-us.net>
 <20240618195348.1670547-3-linux@roeck-us.net>
 <a7f208df-4c9e-4fa2-9d17-80895db51182@molgen.mpg.de>
 <661def21-b0a9-49c1-937e-8526008f529c@roeck-us.net>
 <omsjeb6zbkcdhh4a3urjdrdeyj2kczb734tbhxwdcvngzlm7pe@dzdphvmm6asq>
 <4755d088-7eab-47ca-923c-db1fdf3611ab@gmx.de>
Content-Language: en-US
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Rebe?=
 <rene@exactcode.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Stephen Horvath <s.horvath@outlook.com.au>,
 Sasha Kozachuk <skozachuk@google.com>, John Hamrick <johnham@google.com>,
 Chris Sarra <chrissarra@google.com>, linux-hwmon@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, Heiner Kallweit <hkallweit1@gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <4755d088-7eab-47ca-923c-db1fdf3611ab@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Cc: +Heiner]


Dear Armin,


Am 19.06.24 um 01:28 schrieb Armin Wolf:
> Am 19.06.24 um 00:28 schrieb Wolfram Sang:
> 
>>> to 86 degrees C. If that doesn't work, we'll be really out of luck
>>> with that controller (or at least I don't have an idea what else to 
>>> try).
>> 
>> Try CCing Heiner Kallweit for ideas about the i801 controller.

> i am not Heiner Kallweit, but i found something interesting in
> commit ba9ad2af7019 ("i2c: i801: Fix I2C Block Read on 8-Series/C220 and 
> later").
> 
> Basically, it seems that the i802 i2c controller indeed features a SPD 
> write disable bit which blocks all writes for slave addresses 0x50-0x57.
> 
> Does the i801 i2c controller driver print something like "SPD Write 
> Disable is set" during boot?

Nice find. Yes, it does:

     [    5.462605] i801_smbus 0000:00:1f.4: SPD Write Disable is set
     [    5.468399] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt


Kind regards,

Paul


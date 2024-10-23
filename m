Return-Path: <linux-kernel+bounces-378070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E659ACAE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E87AB215DD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A6B1B5EA4;
	Wed, 23 Oct 2024 13:14:54 +0000 (UTC)
Received: from doubleyoutf.uk (doubleyoutf.uk [109.228.47.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199AD1AE009;
	Wed, 23 Oct 2024 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.228.47.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689293; cv=none; b=PlWH4f8wI7pcqC89j+FHTSfNKZYgPJKNMGuNlaXVgbBdGd5vVlZu/PDM4Sate3/sgjET/oi9vWOh3jusBl3PAwRx1nVUEB3FYtLEYzmxLPwmMvWAMmAh3VQFxc1P2l2alrV4qxmSGSoSc9Z7Ped3oKu3of0rTKrtX0CLM+9VAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689293; c=relaxed/simple;
	bh=3xJSqDzoh9jO3eGIqqaJaLyEIxwRhiPedi1c+PpAyiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PGCoCRGY13GR7JHdnP9VoMqeaoaLZxPbEd+04QdDXQra5CdHPkMQkq8EqHb+4qFb4vxjr86BD5STe3STbgH79IsBWJ144E+bEca2+gED/7mc5RAGAmznqWFqJcNBJzqUluyEh1/WvefwdfYyAqmoFSe0pCmluSIaUxdVfl5hAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khalifa.ws; spf=pass smtp.mailfrom=khalifa.ws; arc=none smtp.client-ip=109.228.47.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khalifa.ws
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khalifa.ws
Received: from [2a00:23cc:d220:b33::b56]
	by doubleyoutf.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ahmad@khalifa.ws>)
	id 1t3agO-00B41h-DU; Wed, 23 Oct 2024 12:41:48 +0000
Message-ID: <103a68d6-d0b8-4e6f-ac8f-c6186b340f81@khalifa.ws>
Date: Wed, 23 Oct 2024 13:41:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (it87) Add support for IT8625E
To: Guenter Roeck <linux@roeck-us.net>,
 Frank Crawford <frank@crawford.emu.id.au>, Ai Chao <aichao@kylinos.cn>,
 jdelvare@suse.com, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241022091319.82503-1-aichao@kylinos.cn>
 <6cab565f05820eb2e1a1c55644be057427ecdf2e.camel@crawford.emu.id.au>
 <300383ee-3ead-439e-893e-895f3ed49805@roeck-us.net>
Content-Language: en-GB
From: Ahmad Khalifa <ahmad@khalifa.ws>
In-Reply-To: <300383ee-3ead-439e-893e-895f3ed49805@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/10/2024 14:40, Guenter Roeck wrote:
> On 10/22/24 03:13, Frank Crawford wrote:
>> On Tue, 2024-10-22 at 17:13 +0800, Ai Chao wrote:
>>> Add support for IT8625E on Centerm P410.
...
>> Can I just add that it isn't a good idea to use the same type for
>> different chips.  There are some specific differences between the
>> chips, which mean that it should have its own entry in
>>
>> static const struct it87_devices it87_devices[]
>>
>> even if currently they are very similar.
> 
> According to the information I have, the ADC voltage is different,
> and 8628 supports PECI but 8625 doesn't. Most importantly, 8625
> has multiple register banks. There are also some differences in
> fan control; 8628 can explicitly turn fans off using register bits.
> 
> Just mapping the chip to it8628 may be convenient, but it is not
> acceptable.

Side question here. The standard for an acceptable chip driver is pretty
high (and rightfully so). But a common use case centres around readonly
display of information: temp/fan/in readings. Even just 2-3 readings are
better than nothing.

Example, I still have to use Frank's out of tree it87 for my IT8688.
It works perfectly fine for me, but still not possible to merge that
device into hwmon's it87.
This IT8625 is another example. The NCT6701D-R will be one more shortly.

A readonly driver that is configurable from userspace would help in that
use case. It can be configured for known devices without datasheets or
for testing new devices. Wouldn't even need to access superio config
space.

Filesystem has fuse, i2c has i2c-dev, input has evdev, ...
Would something similar be acceptable for hwmon?


-- 
Regards,
Ahmad


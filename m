Return-Path: <linux-kernel+bounces-517248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77534A37E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2AA3A5B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47BE1DDC2D;
	Mon, 17 Feb 2025 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0MbsOiO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A701DCB0E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783703; cv=none; b=Oh/uDUdy6QgrB+5hBkoXhKReDAsOwQzgtELo8YaG+S8n7aXJ9noF7AGVppg50Bqd+SLJqDTmPRYK6AoMfkmQVO+NPztYWt7l9EYOH06f8hB1FkLzn6eceLa/RwXFv5p+d6jNhUfxHPNoOlom3J5xjWKA+Y4XBns2e7Uv79ivD3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783703; c=relaxed/simple;
	bh=RBaTnzgFIeMRLwpnT5Th0IXCPfu9a4ENlIGJlefnHVM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aBLLQoMba3D1zl6FTCpDjYNg6KUa5DDJUkptX3Lv1bla2FGOgXZqmdfUTsh7fvlyE62Mu6npGqN+SM+peTovHY7J/86Nptn+zra4ud8aBsKjoDfPMJjnGiMtxYdvROQZNyXB/1tMQy54PfVlBgLzWlYtrCK7Uwogv5xDY+/mcpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d0MbsOiO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739783699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCSos055b7RIRtwHbFFGBg6SO3jbtKMWhwfC9HzBPyg=;
	b=d0MbsOiOuHcQI+Zdn8o+y5QyF71RKJVITl/sTM6qe+Vmsvp5rIlpiltn7acNnkhLoJxHHG
	dYUQ98U2tI6gHLdgfOJ10laZ3vrNlJQLRDvY7SuSqciYuRv3k/NU+aYqPC/2dfiWK9njxp
	KFQU8fGNRROinOAFdlXrzMF5UrDJ8ls=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-bJVOqLI9NxK1En2QfG52Jw-1; Mon, 17 Feb 2025 04:14:58 -0500
X-MC-Unique: bJVOqLI9NxK1En2QfG52Jw-1
X-Mimecast-MFC-AGG-ID: bJVOqLI9NxK1En2QfG52Jw_1739783697
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aaf8396f65fso434180166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:14:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739783697; x=1740388497;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCSos055b7RIRtwHbFFGBg6SO3jbtKMWhwfC9HzBPyg=;
        b=VLrRvUz2ZaBJ0YYRWrzk6M2Vpx2r9k3CYn2E405zEQUyiuHnf36/+SOAquPk7r/Ffe
         zmoZPxP2xiyF1aT0j2AvZLBKnJhl+bKiQoV/gLsjUyFvVkrULijD+1OF6I1XASNZZrKE
         ZstcDI5Vb+ktkx8gGSKvuEi5SnxHeRxQzmrWJnIEnZeFUzLPko/PnVlgnmEnuPbvSSp3
         cONtb8FRmONyG3yV/lT1G8V42fhi8Gu9sMjKq/3yrzwzGJ1syMOWMFr3s29XLKhZiRz3
         9WGV4L1o4294Amfyw8OLWNY4/3+rG0QHYzSswazm4iAaD+IyoGYPUvpTqYKfe0qTyegg
         8M3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQP1JgRFQawTNRi+9v2bnCkETcUOMV9ii8gOrRTbVNb70nZXdZtdapxCUSlfNWUCrY7b0Y1/Km9sV/DvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR/GboLdrBpufPZb659zcLRsU/WE8mLf7q0Qr/7sPfIGoe4aXC
	CIuxRyFcde4wFaPn/rFCMJbhq7uW0TvjC6egTtIkQLyIrRKT6nLnFk1DGqUbSOtyJigY3It9ui4
	ydZNfOWvg2Qg02J8EiaW1zkjDxBgWE/mSCaRUrUM6GXuj+5LdFY7beliWvo0/9w==
X-Gm-Gg: ASbGncvBYA8ume9+fWdzfuIGT+zh6fw7SWspzB2WL9LOiORp35MuO05L//8Tql3ybmT
	0STQf7Pth7buB1Hjm8pd/83ZO8nAnqwaZuxoN269cWYy8Aq9nKeXA6wnaJwwoWv48q9uKchZ5Sr
	HxsVDh4WXyxrYpgL/3n0/bB2ZPxs1r7w26qBHIKGXQQCsY1Gqu8yUMFZ/9RjPUu1C9YiMQTIL1c
	hdOK7LUInKlAf4kD7WfQAo8HWCBcNzOh11OGCWTnDFDlPWYqpDQq2A/TnkySOPcmjkKd0m0CnBe
	sVl8LYex
X-Received: by 2002:a17:906:3290:b0:abb:6e07:3714 with SMTP id a640c23a62f3a-abb70c3c56emr885117066b.10.1739783696800;
        Mon, 17 Feb 2025 01:14:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVoU+0OsoqnvHkuqxKwlREe8x7T5lLdCwlpfKmpIaerZpM/VH0bqPq5BOI1Yu2Kc/N4p7mww==
X-Received: by 2002:a17:906:3290:b0:abb:6e07:3714 with SMTP id a640c23a62f3a-abb70c3c56emr885113266b.10.1739783696403;
        Mon, 17 Feb 2025 01:14:56 -0800 (PST)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba9bd6e22sm50734166b.121.2025.02.17.01.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 01:14:55 -0800 (PST)
Message-ID: <1d0ffab6-1706-42f5-947a-ec20d39eca9e@redhat.com>
Date: Mon, 17 Feb 2025 10:14:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mei: vsc: Use "wakeuphostint" when getting the host
 wakeup GPIO
From: Hans de Goede <hdegoede@redhat.com>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Wentong Wu <wentong.wu@intel.com>, Jason Chen <jason.z.chen@intel.com>,
 Alexander Usyskin <alexander.usyskin@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20250214212425.84021-1-hdegoede@redhat.com>
 <Z7L4+YJcUaaz1kyG@linux.intel.com>
 <8c626c45-cab0-405f-8418-f36883fc7a38@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <8c626c45-cab0-405f-8418-f36883fc7a38@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

On 17-Feb-25 10:06, Hans de Goede wrote:
> Hi Stanislaw,
> 
> On 17-Feb-25 09:53, Stanislaw Gruszka wrote:
>> Hi Hans,
>>
>> Thanks for working on this, this issue annoyed lots of people.
> 
> You're welcome. Note I'm not convinced that this actually fixes all cases
> of the vsc-tp -ETIMEOUT error. Normally the GPIO part of the LJCA USB-io
> expander will become available before the SPI part and then we do not hit
> this.

p.s.

Greg, to be clear this patch is correct and fixed a real bug so please
apply it, preferably as a fix for the current cycle. Also please add:

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@vger.kernel.org

Regards,

Hans





> Could still be a rare race where we do hit this though.
> 
> Also as I mentioned in the bugzilla:
> https://bugzilla.redhat.com/show_bug.cgi?id=2316918
> 
> If I force hitting the race my XPS 9320 recovers after a simple reboot,
> where as for other users the VSC seems to get in some stuck state.
> 
> Anyways lets continue discussing this in:
> https://bugzilla.redhat.com/show_bug.cgi?id=2316918
> 
> where I have also written down some more observations from my ivsc debugging
> session.
> 
> Regards,
> 
> Hans
> 
> 
> 
>>
>> On Fri, Feb 14, 2025 at 10:24:25PM +0100, Hans de Goede wrote:
>>> The _CRS ACPI resources table has 2 entries for the host wakeup GPIO,
>>> the first one being a regular GpioIo () resource while the second one
>>> is a GpioInt () resource for the same pin.
>>>
>>> The acpi_gpio_mapping table used by vsc-tp.c maps the first Gpio ()
>>> resource to "wakeuphost-gpios" where as the second GpioInt () entry
>>> is mapped to "wakeuphostint-gpios".
>>>
>>> Using "wakeuphost" to request the GPIO as was done until now, means
>>> that the gpiolib-acpi code does not know that the GPIO is active-low
>>> as that info is only available in the GpioInt () entry.
>>>
>>> Things were still working before due to the following happening:
>>>
>>> 1. Since the 2 entries point to the same pin they share a struct gpio_desc
>>> 2. The SPI core creates the SPI device vsc-tp.c binds to and calls
>>>    acpi_dev_gpio_irq_get(). This does use the second entry and sets
>>>    FLAG_ACTIVE_LOW in gpio_desc.flags .
>>> 3. vsc_tp_probe() requests the "wakeuphost" GPIO and inherits the
>>>    active-low flag set by acpi_dev_gpio_irq_get()
>>>
>>> But there is a possible scenario where things do not work:
>>>
>>> 1. - 3. happen as above
>>> 4. After requesting the "wakeuphost" GPIO, the "resetfw" GPIO is requested
>>>    next, but its USB GPIO controller is not available yet, so this call
>>>    returns -EPROBE_DEFER.
>>> 5. The gpio_desc for "wakeuphost" is put() and during this the active-low
>>>    flag is cleared from gpio_desc.flags .
>>> 6. Later on vsc_tp_probe() requests the "wakeuphost" GPIO again, but now it
>>>    is not marked active-low.
>>>
>>> The difference can also be seen in /sys/kernel/debug/gpio, which contains
>>> the following line for this GPIO:
>>>
>>>  gpio-535 (                    |wakeuphost          ) in  hi IRQ ACTIVE LOW
>>>
>>> If the second scenario is hit the "ACTIVE LOW" at the end disappears and
>>> things do not work.
>>>
>>> Fix this by requesting the GPIO through the "wakeuphostint" mapping instead
>>> which provides active-low info without relying on acpi_dev_gpio_irq_get()
>>> pre-populating this info in the gpio_desc.
>>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2316918
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> The problem explanation and the fix looks good to me.
>>
>> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
>>
>> Regards
>> Stanislaw
>>
>>> ---
>>>  drivers/misc/mei/vsc-tp.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
>>> index 35d349fee769..7be1649b1972 100644
>>> --- a/drivers/misc/mei/vsc-tp.c
>>> +++ b/drivers/misc/mei/vsc-tp.c
>>> @@ -502,7 +502,7 @@ static int vsc_tp_probe(struct spi_device *spi)
>>>  	if (ret)
>>>  		return ret;
>>>  
>>> -	tp->wakeuphost = devm_gpiod_get(dev, "wakeuphost", GPIOD_IN);
>>> +	tp->wakeuphost = devm_gpiod_get(dev, "wakeuphostint", GPIOD_IN);
>>>  	if (IS_ERR(tp->wakeuphost))
>>>  		return PTR_ERR(tp->wakeuphost);
>>>  
>>> -- 
>>> 2.48.1
>>>
>>
> 



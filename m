Return-Path: <linux-kernel+bounces-517227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEB6A37DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760B2188D15C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD771A5BA2;
	Mon, 17 Feb 2025 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ch4A4q/n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC43383
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783218; cv=none; b=p7Q3cP5QQgnNNgmxzkdmszFcmV5n7laAWDdCLdZSpraurc7+qFJZQlYhgW48T4vrFgAFrSVyh7F7lHdplfz+RSSEmk0H2JDmh/eWhrzJNd55MbZuZr3WF/vnf3orakqvXIpjljqiXIbS2VdcL5n+wlI2vO66Ek6fRBMi9NdNh/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783218; c=relaxed/simple;
	bh=alRT004aA1an9rMoksap0nHiftoY/xNVo/qrlUgCVm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cq3hdhYzgXm8hUaEnGoH4W0hn1DpTihK08K5qDQ4GHWOf+7q8Bl6qgwYD6FlhzCcAP9vrzpWPbp1WPSbNrUM9BCM/+ccVV7sWC3N9chnqaIo3txm39M/Z+6talVEjxsCnf/x0PpWvpt76/1/ptFOVSYCOAmoztmMDVt66ZaFi9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ch4A4q/n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739783214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pXntm0L6k/PIYOFzvzsINuBz10BEYwHVc6P+DDqahOk=;
	b=ch4A4q/niAx1zZdJ66abxU6cPiqiOI4Z8YCxjMvs5ioc7NREwIy/7gKnfbOgsrl08XJC/H
	IfQsRXhqfMNTmWZAj73NB+QKEUwwpvQcNYb8f+IhAHyt4o3VqHUzFbj9qZHwnJq5PMfGxi
	40BmZ1RvuNI/cP1aU8NCRCEKiBATmy0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-nQgjttI7MR6HgzjkNN8XKg-1; Mon, 17 Feb 2025 04:06:53 -0500
X-MC-Unique: nQgjttI7MR6HgzjkNN8XKg-1
X-Mimecast-MFC-AGG-ID: nQgjttI7MR6HgzjkNN8XKg_1739783212
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abafbdf4399so211680166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:06:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739783211; x=1740388011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXntm0L6k/PIYOFzvzsINuBz10BEYwHVc6P+DDqahOk=;
        b=BK0OpdF/mb3M9x01VSZaOn7hQiJg37w8eFwStYL2yFYSiKl14eX6OI0KX3oBFZ2JT8
         wQ1EMvV5z6wRnelsGpuljOrDKSJccmccwb9tzipSmHvyWkRTKs4rLv2UH43j+TVUfRAZ
         0ni60T7QAiK/1vgB1OjTePGYtyIK/jx66h/gBGV2/nAVVKR5upA2yfPB2M1BLFE4HoYI
         tng04ge1LFl/kbSqfgfIImOH3MGuiF5chFvYrN56urBlVAofICGxS+CLemJhuNWWn/Ou
         vbptuYLWfQsKFmXhtLk/SoaosFmeVbMzMlRSvXwQpcu2q+Nkwkbe1hYemHDz1Pryi4a9
         OLSA==
X-Forwarded-Encrypted: i=1; AJvYcCXvfENKiF0GVsIf67Voc0NKI6HaVmZZ3LZEbTEcD+kLO3oafWT2VzbZoWQff/Y6v5IKKOlN3m8o+RGJXzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbMhqMwZZx008EwZxLDXfl31TS0NHTwwN7E0fh48e96zqa+5IZ
	EdXaO2S7omy8fjC7eGNT4bdjM54BVoAFconccwexM9YXUUppIDvto/cvdqEBKsCBaDx1xMAKwER
	fM5MX51+NT16PInZjEQsmpMDE1pjTMwKBbvHh56xcH1/M8JTu0zjnusQr1GsZeNQPRHNfFQ==
X-Gm-Gg: ASbGncvW+mVXA89UkC4o2Ar0BDU2lcGGdtBOI2jOhgcD887t2Frg7zQJXA6GX8SNZ3k
	emLWub0Wn03OMJksTfyyJD5t/jNmKLct8wUQzFgk22DiW7/O3qewh2DE/XHPajCKRLDcVh6JBmV
	589N6yI5MFOMvYKS0uGP/PjG99WCqciGom6Qyv84nkkTQx9fBOCCN9QxMxncVMb4ja88sNs+Zw8
	lcC6W5sV79kZLFvI48CVV55MmZJ1dzKeTpfrHFw+vp5h6d7NY2mOG0+LSQ4neiUu9P4ZjQs6EfL
	33Z/0QSi
X-Received: by 2002:a17:906:308f:b0:ab6:504a:4c03 with SMTP id a640c23a62f3a-abb70c7a410mr628298966b.24.1739783211379;
        Mon, 17 Feb 2025 01:06:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdcpuZ1e2YUYp06wmEX3pq3ghaYcS+GrxFZqLBvkbOGGCo50nss/rZN2y999J6hvM330Ybug==
X-Received: by 2002:a17:906:308f:b0:ab6:504a:4c03 with SMTP id a640c23a62f3a-abb70c7a410mr628297166b.24.1739783210877;
        Mon, 17 Feb 2025 01:06:50 -0800 (PST)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5339d7bfsm854591166b.141.2025.02.17.01.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 01:06:50 -0800 (PST)
Message-ID: <8c626c45-cab0-405f-8418-f36883fc7a38@redhat.com>
Date: Mon, 17 Feb 2025 10:06:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mei: vsc: Use "wakeuphostint" when getting the host
 wakeup GPIO
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Wentong Wu <wentong.wu@intel.com>, Jason Chen <jason.z.chen@intel.com>,
 Alexander Usyskin <alexander.usyskin@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20250214212425.84021-1-hdegoede@redhat.com>
 <Z7L4+YJcUaaz1kyG@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Z7L4+YJcUaaz1kyG@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Stanislaw,

On 17-Feb-25 09:53, Stanislaw Gruszka wrote:
> Hi Hans,
> 
> Thanks for working on this, this issue annoyed lots of people.

You're welcome. Note I'm not convinced that this actually fixes all cases
of the vsc-tp -ETIMEOUT error. Normally the GPIO part of the LJCA USB-io
expander will become available before the SPI part and then we do not hit
this.

Could still be a rare race where we do hit this though.

Also as I mentioned in the bugzilla:
https://bugzilla.redhat.com/show_bug.cgi?id=2316918

If I force hitting the race my XPS 9320 recovers after a simple reboot,
where as for other users the VSC seems to get in some stuck state.

Anyways lets continue discussing this in:
https://bugzilla.redhat.com/show_bug.cgi?id=2316918

where I have also written down some more observations from my ivsc debugging
session.

Regards,

Hans



> 
> On Fri, Feb 14, 2025 at 10:24:25PM +0100, Hans de Goede wrote:
>> The _CRS ACPI resources table has 2 entries for the host wakeup GPIO,
>> the first one being a regular GpioIo () resource while the second one
>> is a GpioInt () resource for the same pin.
>>
>> The acpi_gpio_mapping table used by vsc-tp.c maps the first Gpio ()
>> resource to "wakeuphost-gpios" where as the second GpioInt () entry
>> is mapped to "wakeuphostint-gpios".
>>
>> Using "wakeuphost" to request the GPIO as was done until now, means
>> that the gpiolib-acpi code does not know that the GPIO is active-low
>> as that info is only available in the GpioInt () entry.
>>
>> Things were still working before due to the following happening:
>>
>> 1. Since the 2 entries point to the same pin they share a struct gpio_desc
>> 2. The SPI core creates the SPI device vsc-tp.c binds to and calls
>>    acpi_dev_gpio_irq_get(). This does use the second entry and sets
>>    FLAG_ACTIVE_LOW in gpio_desc.flags .
>> 3. vsc_tp_probe() requests the "wakeuphost" GPIO and inherits the
>>    active-low flag set by acpi_dev_gpio_irq_get()
>>
>> But there is a possible scenario where things do not work:
>>
>> 1. - 3. happen as above
>> 4. After requesting the "wakeuphost" GPIO, the "resetfw" GPIO is requested
>>    next, but its USB GPIO controller is not available yet, so this call
>>    returns -EPROBE_DEFER.
>> 5. The gpio_desc for "wakeuphost" is put() and during this the active-low
>>    flag is cleared from gpio_desc.flags .
>> 6. Later on vsc_tp_probe() requests the "wakeuphost" GPIO again, but now it
>>    is not marked active-low.
>>
>> The difference can also be seen in /sys/kernel/debug/gpio, which contains
>> the following line for this GPIO:
>>
>>  gpio-535 (                    |wakeuphost          ) in  hi IRQ ACTIVE LOW
>>
>> If the second scenario is hit the "ACTIVE LOW" at the end disappears and
>> things do not work.
>>
>> Fix this by requesting the GPIO through the "wakeuphostint" mapping instead
>> which provides active-low info without relying on acpi_dev_gpio_irq_get()
>> pre-populating this info in the gpio_desc.
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2316918
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> The problem explanation and the fix looks good to me.
> 
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> 
> Regards
> Stanislaw
> 
>> ---
>>  drivers/misc/mei/vsc-tp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
>> index 35d349fee769..7be1649b1972 100644
>> --- a/drivers/misc/mei/vsc-tp.c
>> +++ b/drivers/misc/mei/vsc-tp.c
>> @@ -502,7 +502,7 @@ static int vsc_tp_probe(struct spi_device *spi)
>>  	if (ret)
>>  		return ret;
>>  
>> -	tp->wakeuphost = devm_gpiod_get(dev, "wakeuphost", GPIOD_IN);
>> +	tp->wakeuphost = devm_gpiod_get(dev, "wakeuphostint", GPIOD_IN);
>>  	if (IS_ERR(tp->wakeuphost))
>>  		return PTR_ERR(tp->wakeuphost);
>>  
>> -- 
>> 2.48.1
>>
> 



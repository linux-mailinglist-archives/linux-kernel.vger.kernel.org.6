Return-Path: <linux-kernel+bounces-413194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBE79D14E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3A52863A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588D91B6D0A;
	Mon, 18 Nov 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgKzLi4b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E564437A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945667; cv=none; b=Ghtt6e1CUVizsuD57TQEzfVTEKSQcK9pEY12aYJNL8I/+APaqMXWyCrq8WrPdWsQ/+X2ofI5apX8qzbahKr/Ggzrtn10VNBdXnGTBXhK8V7fDxCg+itaE2rbP9tMLZisFrZu0BLK1iufvDmuO3hrLgnl+t5PVn00I5gjGfB0UGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945667; c=relaxed/simple;
	bh=6CxnDZZB5+fdR4e7l6sVzjWdvSBxgM7hf9iwwOorE9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LowGesxl7A8LptnHpKEk4x/QapTl0fWmGXZZ1Olsf2jAVSQbBwC5yMiANTUnd5XOLVZQcSeIWe6gCdatQQ4XMmOkpY9U2n3EesBtmkFJhj+ha2CxolCrD4PYRSp3wHL/hRfc0zL2DJfzaXEVSrBTE8fsid8OGO/qSuf0FSjiaZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GgKzLi4b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731945664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTQ7nZFEK6S27THASdzt79L8aG7WYF9l5v4RJVcgEiY=;
	b=GgKzLi4bA7TuYFHtij77HftJgcUcMqeByFORwQMUv4uKYCKgFVcGyVUjWDSFWWwE8bXkO+
	MFAm29jFwPtpnvhuhS3M95FviSYjIPIRm2tMq6PVJ4gmOo0fhy2DTOcjov37aPUjmlfA0D
	F/P3KPJtr6qcuUnn8ObKzI5HqHAEzZk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-7s0qmYrLPXC2Cnw-ImkXDQ-1; Mon, 18 Nov 2024 11:01:02 -0500
X-MC-Unique: 7s0qmYrLPXC2Cnw-ImkXDQ-1
X-Mimecast-MFC-AGG-ID: 7s0qmYrLPXC2Cnw-ImkXDQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9a1b872d8bso110119866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731945662; x=1732550462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTQ7nZFEK6S27THASdzt79L8aG7WYF9l5v4RJVcgEiY=;
        b=gx8GacpLY00qF1fjY+nCv+MDOOUK1IJic0f/42ZmXSg3Nb6KmBdsuGAbSnjWOEGXSb
         yxnmLdrXM1DL+sSERLaBvEImNaAs55Qp31NJbz5CvxChAoxK3nZnZcdulK98zTgxt2qW
         8b3m2XQKqPQbr/d1VLmapFiV5YAFmMtrKo5Qffo6XiaC0bDuLND3/VOmak8GF9XM6M7i
         t5CeIQJK1gAzPse61sWq7hO9GSQrAad/arw2d1VaHn5uWNt0bEVhzYNhdkprAnmiYKaI
         XkoSCCo9l0jy9lYbBV9lBV8KsDklOJUdYRjez95kta6P/Q8g4efTMQKkyfH3tAhD3TEA
         geAw==
X-Forwarded-Encrypted: i=1; AJvYcCXj0j7LasF8lNiQpO12BQOtNKFMSOx5JVGED6RKIIlv3rXtVKohDtWSIn/TDGfnWfHu+QS9wWoz7HrS7/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3okFHuMh1OgGcBxU9k2f/Qi5lZ56nMFPJqVvjDdxJgK0kfYWg
	9n5bvPC0WIBSHmYNW4VlmK0v1OyDlmSB5ir6BgoMxQbo+JnuuJIS82PVuShKzF0xqE8VZQx8fF6
	6T2MT6xQwG11farxqvInqu+tn1P9geEnxz+3gFfjXyeb3i0et/rT2T5NWi4I8Jw==
X-Received: by 2002:a17:907:3e1f:b0:a99:d782:2e2b with SMTP id a640c23a62f3a-aa4834543e4mr1066979366b.30.1731945660672;
        Mon, 18 Nov 2024 08:01:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNnF8fyZ8McZ7orjpyGv0/+e8uHXZw3fjzm0xcHU4dbb/2riPdPYr4pbCQWFxrwTPDaBXFWw==
X-Received: by 2002:a17:907:3e1f:b0:a99:d782:2e2b with SMTP id a640c23a62f3a-aa4834543e4mr1066897666b.30.1731945653837;
        Mon, 18 Nov 2024 08:00:53 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e0466b4sm553253166b.159.2024.11.18.08.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 08:00:53 -0800 (PST)
Message-ID: <df1fa47f-7efb-4b0c-8ef6-100b12ab1523@redhat.com>
Date: Mon, 18 Nov 2024 17:00:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?B?SWxwbyBK77+9cnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Klara Modin <klarasmodin@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danil Rybakov <danilrybakov249@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
References: <ZzTk5kyPa5kUxA+f@goliath>
 <a5bafe87-e8f6-40d9-a5d8-34cf6aa576a4@redhat.com>
 <wxb4hmju5jknxr2bclxlu5gujgmb3vvqwub7jrt4wofllqp7li@pdvthto4jf47>
 <ZzdhTsuRNk1YWg8p@goliath>
 <5qjbimedzeertdham2smgktt54gzdc7yg4dwgiz7eezt2tf5a2@szhhpvzo3uhj>
 <Zzs1rw1YcoEEeW7+@goliath> <ZztABO3TyJBekZRs@smile.fi.intel.com>
 <ZztCB5hN2NBnPgiR@goliath> <ZztF7FKaBwZKs5dk@smile.fi.intel.com>
 <ZztQwLpoZDZzbi6O@goliath> <ZztjcntEj5Eo0Rw9@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZztjcntEj5Eo0Rw9@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Nov-24 4:55 PM, Andy Shevchenko wrote:
> On Mon, Nov 18, 2024 at 02:35:44PM +0000, Daniel Walker (danielwa) wrote:
>> On Mon, Nov 18, 2024 at 03:49:32PM +0200, Andy Shevchenko wrote:
>>> On Mon, Nov 18, 2024 at 01:32:55PM +0000, Daniel Walker (danielwa) wrote:
>>>> On Mon, Nov 18, 2024 at 03:24:20PM +0200, Andy Shevchenko wrote:
>>>>> On Mon, Nov 18, 2024 at 12:40:16PM +0000, Daniel Walker (danielwa) wrote:
> 
> ...
> 
>>>>> Are you referring to LPC GPIO?
>>>>  
>>>>  I don't know the hardware well enough to say for certain. It's whatever device 8086:19dd is.
>>>
>>> This is device which represents p2sb. It's not a GPIO device you are talking
>>> about for sure. You can send privately more detailed info in case this is shouldn't
>>> be on public to me to understand what would be the best approach to fix your issue.
>>
>> Here's a comment,
>>
>> /* INTEL Denverton GPIO registers are accessible using SBREG_BAR(bar 0) as base */
>>
>> We have gpio wired to an FPGA and I believe the gpio line is used to reset the
>> fpga.
>>
>> So the pci resources attached to 8086:19dd can be used to access gpio of some
>> type. 
>>
>> I'm not a pci expert but on the 19bb device bar 0 we use the below offset to manipulate
>> the gpio,
>>
>> #define INTEL_GPIO_REG_RESET_OFFSET          0xC50578
>>
>> The comments suggest this is gpio 6. I would seems your reaction would be that
>> there is no gpio on the 19dd device. Maybe our driver is access gpio thru p2sb
>> or something like that.
>>
>> Does the offset above make sense to you in the context of the p2sb ?
> 
> Yes, everything makes sense. Please, enable lpc_ich driver and forget about
> talking to the p2sb memory mapped IO.
> 
> /* Offset data for Denverton GPIO controllers */
> static const resource_size_t dnv_gpio_offsets[DNV_GPIO_NR_RESOURCES] = {
> 	[DNV_GPIO_NORTH] = 0xc20000,
> 	[DNV_GPIO_SOUTH] = 0xc50000,
> };
> 
> So, you are using a pin from the Community "South" of the on-die Denverton GPIO.
> 
> In EDS this called GPIO_6, while in the driver it's pin 88, i.e. SMB3_IE0_DATA.
> 
> You will need to
> - enable lpc_ich driver (CONFIG_LPC_ICH)
> - enable Intel Denverton pin control driver (CONFIG_PINCTRL_DENVERTON)
> - replace your custom approach to:
>   - GPIO lookup table
>   - proper GPIO APIs, as gpiod_get() or alike
> 
> See how it was done in the current kernel code:
> 
> 8241b55f1ded ("drm/i915/dsi: Replace poking of VLV GPIOs behind the driver's back")
> a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version of Siemens driver")
> 
> Hans, there will be no need to fix anything if they implement correct access
> to the GPIO, i.e. via driver and board code with GPIO lookup tables.

Agreed, still I'm not sure how I feel about us hiding the previously unhidden P2SB.

OTOH I guess it may have only been unhidden in the BIOS to make the hack they
are using possible in the first place.

Regards,

Hans




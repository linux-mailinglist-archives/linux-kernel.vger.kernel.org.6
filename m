Return-Path: <linux-kernel+bounces-274861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EB7947DC2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84506B20DE5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3DA149C69;
	Mon,  5 Aug 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiH50cLx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D02BCF7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870874; cv=none; b=nTbSDmdFpY56s5j+SQPu/lJVwabofqilwFcMxaxjpLsLiyECA9r/xBq/McsLev9UPSeRRnOK1sMwPj32b3mf4MtQUCGimSmBa29QfGcytEOMcPacK6Efo5bJzXYBqhAxD9ed/uN80KWjp5VCycYAcf6mDaNUTW3wsohUJllFVWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870874; c=relaxed/simple;
	bh=7OvJAJgVYRx1Z/arwi9q84O1QkjILFe2oIufbyEMxq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBubegZwQSOt2wZezNBE/nfbyDZoEXRdxWAhn8W6ySfb20oY1xJ+5qn6jhhHFYVrXdKfmMYCxz+uralCkVxHmny2DHFrIir1C5KF+tbU7LnFXnHcFd3BYeHiuuBzO234RL1eYiGgzn4vHaW5VPEU+I0Hd9NZ2M49YAu/lAaY8Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KiH50cLx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722870870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Zs9SN3PXCVdBxc7PU119vQ+FwJ4nQwvm9D43mIbl8w=;
	b=KiH50cLxrMpoPjqq7JUHmxGGYdmozxrT2vxgubJuiuEkrdGT9pIEFFuCXfBc9W9EJcsVil
	65zWnRA++MMhVnZpflBSIn0hxjU0OXs1RlrlSxzbmJmaC7pSoD5fc9UmSNERc5EBgMA+kO
	2+JHKyN5CmtDI5lmbXdHy9AVcv0duQQ=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-7EDpWU3TOhGAvbhM1NIG4w-1; Mon, 05 Aug 2024 11:14:23 -0400
X-MC-Unique: 7EDpWU3TOhGAvbhM1NIG4w-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f9504974dso1497913739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722870863; x=1723475663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Zs9SN3PXCVdBxc7PU119vQ+FwJ4nQwvm9D43mIbl8w=;
        b=KiS4TYFqTX9eKzX5eq3Dj7/fwKb4h9mYZ8ecl4C4rWUDv9IQUuXtlOSw+G1d5AeEyD
         bV4wHlqTS/hGcVGs9ClWsoUnUfYRWUfKXDcFyztDX9buNz13aL/YqPGJ9og77az/dzMw
         ksmgX0f7At4uLguxjXsZqJnQnJdly0BeJ1ss8ZutRsqkSKXDFYp1IU1+l3w/Glu/QC3A
         GfbzceJPw4+Yh/8XGD44Rqx8IfUn0AL5EodFi4H+Dy+1/hR6r5T+ClLASApcsD1kBWEe
         CiXwa1zqqsxkYI1ZKJi5sHKO9D0LFfm5swRNUeGBiYORuHVFUN4iMwcomYSHmxw3hoCd
         wKew==
X-Forwarded-Encrypted: i=1; AJvYcCUmvJbbC02pAcauFvfSvy+rKvlc50xQi5R2gPYdUtfSn09QMTg2YnDIUptu/4wBDCsKUzC9wHJP2K9Rp/9Lgb4KG17boZlKwuv7mmZK
X-Gm-Message-State: AOJu0YzQqkLVxGulG45csSJfZuBTN/AHleqGHaiKiyzy32P7LxgCUs5w
	Cs3RuLmPrM3tgCvREYab6zSrFx31bTGXCN3Pf+/ZuMvOpvGqTEfZ2sXsP0bXBDQG+hT2L9D8sXs
	xnx4fxqsFETZ/dN0Ln2PP71/374/JNIIFrED54xcHTUR4bo2akJr4LXGBGhy5HQ==
X-Received: by 2002:a05:6602:6414:b0:7f6:83da:dd12 with SMTP id ca18e2360f4ac-81fd43924d3mr1806525939f.11.1722870862893;
        Mon, 05 Aug 2024 08:14:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHp866FKs3N0GAgAGdS61eDS2I3H5Lna3kaCdTin0enIg/S6Ey8t4q8U4PgiqLnDyzbuWh+A==
X-Received: by 2002:a05:6602:6414:b0:7f6:83da:dd12 with SMTP id ca18e2360f4ac-81fd43924d3mr1806523039f.11.1722870862491;
        Mon, 05 Aug 2024 08:14:22 -0700 (PDT)
Received: from [192.168.211.203] ([109.38.139.91])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a27a68sm1755135173.110.2024.08.05.08.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 08:14:22 -0700 (PDT)
Message-ID: <ff683cf3-1b0f-4110-82b0-ed6889151bff@redhat.com>
Date: Mon, 5 Aug 2024 17:14:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: asus-wmi: Add quirk for ROG Ally X
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Luke D. Jones" <luke@ljones.dev>
Cc: platform-driver-x86@vger.kernel.org, corentin.chary@gmail.com,
 LKML <linux-kernel@vger.kernel.org>
References: <20240724222852.44378-1-luke@ljones.dev>
 <056b599c-4d29-a743-ad7b-055e951e9e39@linux.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <056b599c-4d29-a743-ad7b-055e951e9e39@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 7/29/24 1:44 PM, Ilpo Järvinen wrote:
> On Thu, 25 Jul 2024, Luke D. Jones wrote:
> 
>> The new ROG Ally X functions the same as the previus model so we can use
>> the same method to ensure the MCU USB devices wake and reconnect
>> correctly.
>>
>> Given that two devices marks the start of a trend, this patch also adds
>> a quirk table to make future additions easier if the MCU is the same.
>>
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>> ---
>>  drivers/platform/x86/asus-wmi.c            |  2 +-
>>  include/linux/platform_data/x86/asus-wmi.h | 15 +++++++++++++++
>>  2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>> index 2b968003cb9b..bac2945b0e48 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -4694,7 +4694,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>>  	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
>>  	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
>>  	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
>> -						&& dmi_match(DMI_BOARD_NAME, "RC71L");
>> +						&& dmi_check_system(asus_ally_mcu_quirk);
>>  
>>  	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
>>  		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
>> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
>> index 74b32e1d6735..fba9751cda5b 100644
>> --- a/include/linux/platform_data/x86/asus-wmi.h
>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>> @@ -196,4 +196,19 @@ static const struct dmi_system_id asus_use_hid_led_dmi_ids[] = {
>>  	{ },
>>  };
>>  
>> +/* To be used by both hid-asus and asus-wmi to determine which controls kbd_brightness */
>> +static const struct dmi_system_id asus_ally_mcu_quirk[] = {
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
>> +		},
>> +	},
>> +	{ },
>> +};
> 
> Why is this in the header? I see your comment but this means every file 
> which includes asus-wmi.h will have a duplicate copy of this array.

You are right, although asus-wmi.h is not included that often it is only
used in:

drivers/platform/x86/asus-wmi.c
drivers/platform/x86/eeepc-wmi.c
drivers/platform/x86/asus-nb-wmi.c
drivers/hid/hid-asus.c

But all 4 of those usually get build as separate modules, so it would
still be better to move this into a .c file.

Luke, the comment says that this will be used in hid-asus.c too, but
I think that is a copy and paste error resulting froom copying the comment
from the asus_use_hid_led_dmi_ids[] DMI matches array.

It seems that this DMI matches array will only be used inside asus-wmi.c,
in that case it would be better to just declare it there instead of
in the shared asus-wmi.h file ?

Regards,

Hans





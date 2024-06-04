Return-Path: <linux-kernel+bounces-200299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 504C98FAE38
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E4E1C211B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9411143753;
	Tue,  4 Jun 2024 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJbgljbE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0408F4E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491618; cv=none; b=saJHP/85lKx4AXuoWw0JngvDNbARvmyHlkod0ecIUaMwhmjoIqKj8BdFpeLjJ11logD7IG8+S07onxo/ElCId9wQQj1uLaf/4DHKpAeuPLwBWQdy0q/JNeD92blgyk7O+wQaR6zOeoOxc7n3s0XHRkBUvGRLu63qRDKt9JNGaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491618; c=relaxed/simple;
	bh=new+pNwLcD9lH3T0u5RvU2+JVeenHDibA7HvZ7u23XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPuFmU/RCPhyBvMKsnKLCSlVrn4TtTdN1PN82d08MRMqpEFacmHCO5u8ctvO7ufXC7VjGiJBIatob3PG4jwxxqAn4L4MFwB9gxnXCLoiapDvP9RHKobF8BYs/aM9/GtjHaAltMoAF9VcY+C1r10mTAEkyLNrq6E1R+mcfhFB5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJbgljbE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717491615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFpT3QUEMx9J9L0LrxzioAQBetBLlwnPOzlf7N14yZU=;
	b=hJbgljbEH7DNzPE9hwl23qu1uimFeVO9CCRUj+sOo3qG5nwEdAsUysNKyJZIs7fKz7d55X
	wNMrzZAvkw8JqMfhuLdf57FH2wzAkNeVJ1DwcCmT6mppYQYaUTKCyDuAFqDyxmYUpdtZD9
	W9I297o+lsM/536FreVjSsxI/Ip3BBY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-0gqVrizhNUaHJzpyO9EYtw-1; Tue, 04 Jun 2024 05:00:12 -0400
X-MC-Unique: 0gqVrizhNUaHJzpyO9EYtw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5786cf51b65so378113a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717491611; x=1718096411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFpT3QUEMx9J9L0LrxzioAQBetBLlwnPOzlf7N14yZU=;
        b=QwhROoZ9iCodafKIgyiN9oiQhaECk3ljNpU2aUxDnZv6xhVxjB/EKDFveuebfLzzU2
         2rWxGLh0sfXvclKpnmzRvus45mJU3la5k9bG/0NtPDpdYd5p1RHEHeBU9e0q8xtay3hk
         0pN83hdX4na4S2T416vQAhY0mr4pGaZ7lyrgv54BZ6zWSnyKgKXo7/MxNlUK0muPZLlB
         qRAqdyfISJyVMcpNXohUYpuBf+8Ma8reTZ1LgWAC/9bLxdnn9vJZ6/Sz24UBEkaqaMxv
         7uzBKnQV/xFyEAoZUCM7HuvUpZEVYyvi+KE6ZCDujbI2bF5UT2XrsWUnjlhLidzo7ouo
         v8Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUqNAP6/0PeKvThjqH1XYDI/7RW1Ss2Xx4V8Lb2SBEiRN4o64qtteVxj4d7ESyTWP3s3VOF5viuSDFshPNrJ5JmgJdSiYrD4gAbXA7Z
X-Gm-Message-State: AOJu0Yz4kAvvuIAFBJtL7L+RRHKyZsbcnYOmdtrRpr7CpEUxNqNyM+Z8
	qelKcXlJXoMYQfrP2w+eiXK6rWwAhR75U5seGywsWfT3ABrfw6w9FXI1xc4cEwvKLsHkiHHIe8Z
	rgBCJQAoRq7ZxfTP+s6h01qDO6KmtscJma5ku/JyGEpFDaTA5+gFPUsL2ZBtnjg==
X-Received: by 2002:a50:9fe1:0:b0:57a:2fd7:c2d1 with SMTP id 4fb4d7f45d1cf-57a365724d6mr5996657a12.40.1717491611614;
        Tue, 04 Jun 2024 02:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9HxdDDjXBkoNajgBxrl8Zq0njsbIpxZMJnVCH9evLqXT+aGsPpAtbO5jLY5O3yvm6yuy6WA==
X-Received: by 2002:a50:9fe1:0:b0:57a:2fd7:c2d1 with SMTP id 4fb4d7f45d1cf-57a365724d6mr5996635a12.40.1717491611111;
        Tue, 04 Jun 2024 02:00:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c6d594sm7045909a12.69.2024.06.04.02.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 02:00:10 -0700 (PDT)
Message-ID: <77625f15-e183-49e8-8496-b12002cc7dbb@redhat.com>
Date: Tue, 4 Jun 2024 11:00:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mei: vsc: Fix wrong invocation of ACPI SID method
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Wentong Wu <wentong.wu@intel.com>, Tomas Winkler <tomas.winkler@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org,
 Kate Hsuan <hpa@redhat.com>, linux-kernel@vger.kernel.org
References: <20240603205050.505389-1-hdegoede@redhat.com>
 <Zl42vYs40MJiPxl7@kekkonen.localdomain>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Zl42vYs40MJiPxl7@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/3/24 11:33 PM, Sakari Ailus wrote:
> Hi Hans,
> 
> Thanks for the patch.
> 
> On Mon, Jun 03, 2024 at 10:50:50PM +0200, Hans de Goede wrote:
>> When using an initializer for a union only one of the union members
>> must be initialized. The initializer for the acpi_object union variable
>> passed as argument to the SID ACPI method was initializing both
>> the type and the integer members of the union.
>>
>> Unfortunately rather then complaining about this gcc simply ignores
>> the first initializer and only used the second integer.value = 1
>> initializer. Leaving type set to 0 which leads to the argument being
>> skipped by acpi acpi_ns_evaluate() resulting in:
>>
>> ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments -
>> Caller passed 0, method requires 1 (20240322/nsarguments-232)
>>
>> Fix this by initializing only the integer struct part of the union
>> and initializing both members of the integer struct.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Even though this is a one-liner, figuring out what was actually going
>> wrong here took quite a while.
> 
> I was wondering this with Wentong, too...!
> 
>> ---
>>  drivers/misc/mei/vsc-fw-loader.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/mei/vsc-fw-loader.c b/drivers/misc/mei/vsc-fw-loader.c
>> index ffa4ccd96a10..596a9d695dfc 100644
>> --- a/drivers/misc/mei/vsc-fw-loader.c
>> +++ b/drivers/misc/mei/vsc-fw-loader.c
>> @@ -252,7 +252,7 @@ static int vsc_get_sensor_name(struct vsc_fw_loader *fw_loader,
>>  {
>>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER };
>>  	union acpi_object obj = {
>> -		.type = ACPI_TYPE_INTEGER,
>> +		.integer.type = ACPI_TYPE_INTEGER,
>>  		.integer.value = 1,
> 
> I guess initialising integer.value implies that all integer fields are set
> to zero (and so zeroing type set the line above)?

Yes I was thinking that might be happening too.

> Maybe moving setting type
> below setting integer.value might do the trick as well? ;-)

I was wondering the same thing, but that seems error-prone /
something which may break with different compiler versions.

Actually most code using union acpi_object variables simply
does not initialize them at declaration time.

So I was also considering to maybe change the code like this:

        struct acpi_object_list arg_list;
        union acpi_object *ret_obj;
        union acpi_object param;

	...

        param.type = ACPI_TYPE_INTEGER;
        param.integer.value = 1;

        arg_list.count = 1;
        arg_list.pointer = &param;

        status = acpi_evaluate_object(handle, "SID", &arg_list, &buffer);

Slightly more verbose, but this is basically what all other
callers of acpi_evaluate_object() (with a non NULL arg_list) do.

> It'd be useful to be warned by the compiler in such a case. There are much
> less useful warnings out there.

Ack.

> Excellent finding indeed.
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> This could be cc'd to stable, this warning will display for a lot of
> systems. I.e. I think:
> 
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Cc: stable@vger.kernel.org # for 6.8 and later

Ack.

Regards,

Hans



>>  	};
>>  	struct acpi_object_list arg_list = {
> 



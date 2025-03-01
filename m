Return-Path: <linux-kernel+bounces-539906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE55A4AAAA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A363B9E85
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 11:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471641DD525;
	Sat,  1 Mar 2025 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1WRrfQY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E511CEAC3
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740829007; cv=none; b=a8+cKzuctf9xMPLHBc4/0DErhvmcQ70eGc0JglGeZJYVjUxOvI/IfLxbt07heMWQkDMyr1KBf1C8kAB/pcpJxya6ykGMgo0ZuIEWLJ0O5EKmmMjQQDhe7NGdvxIfVl9z2QNwnvv+IRdESJVCUEBPGkzP5QrmpDs4U/Gn/duehwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740829007; c=relaxed/simple;
	bh=1N0XJWm2DllF8RnfekMenla1Kf7ixW0UheHRRT6WGPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYJ37z3wcVrZAbjrY95JG10H/rTOFQGO145QwNY5O/LT4Y/Mr7IqK9f+MXIiDw+Z+0Pk+AupDLbRk8KYi7BPO1BVoqFQuTzfICXTIhS2AiAXSAYJDNSNt68gpacdrcTWcDSLbxo2YETTLjFPWNixLBJYYt57OTbGcSb9Q1BXOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1WRrfQY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740829004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbORu6qgQcd6DUt/THQ0CSEvNH/qSwH/OAlOYxx8xys=;
	b=R1WRrfQYq57Zo1gSD7GDi0YfiD0BcFd81BzorJbsEQMlpZpE7qHqpjERqB32R6OiMnz8If
	aOkLAfRPLynuinnk52fQAdhyG2yMwj8elggNI4idQkX6Ii9esDtLmq3oNmIDHFPJ/8Y4Uc
	Jvqc7FY7MCZlT7y0d9Iy+PwtaaXZ4m4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-kmdUGAj_M7SrTCXy6_fw5g-1; Sat, 01 Mar 2025 06:36:43 -0500
X-MC-Unique: kmdUGAj_M7SrTCXy6_fw5g-1
X-Mimecast-MFC-AGG-ID: kmdUGAj_M7SrTCXy6_fw5g_1740829002
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abf46dba035so90653566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 03:36:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740829002; x=1741433802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbORu6qgQcd6DUt/THQ0CSEvNH/qSwH/OAlOYxx8xys=;
        b=jVAcFhYJQuDDmtxSY4wR0DmJBpS27B1nRPiRgRVmHk35yuAuAeFZP9XQyg+8kPaUyp
         wR7aDQptVqwToTmvflq7hswCp561DcY3p0IMma7yJnniaA3l4wsXNSbSjaLj54f892Mc
         JEW0K4wNPBYVkJ8z3pP6TlmXilf0erqAHM44rNjIfU885FjyZkLIAXih0xldMAMJtJTL
         Xt127hAbx2iTYHvzDJ3so9Ye4d+PhtcL519q4h7PorlyD+aQhGAuzY8Bl5HsstJ7B4jU
         gHv2EJGzpOCjfmzg2jLD3Iw7zqYQM8a2wwClXZ1wp3Liv7wppPkNMtJAvv7uTCVjSerZ
         XnFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+JNQpMl4FGEb/QMq0pQh00PzQwRVbWlJmmqLLeFSmrysagj+LFnM5LN0f1xgOoKDI9rWAQiQZktqAjRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO4Pt8L7PV3oElrfTkDOOdbL9DHqREa2JgaYvXSl4zeeWVqhoD
	5uOX7NtvYtV38tAVq2xXIsgyTm/CdySib3WgS6wNSohMzOpB/PnGUMF2bWRkyBJ/vw35vLTrYcg
	Uvl650h1krhOFfwPXMMHbHbFUFBhDr9TVfbPb+hyJk1s2KOr5+BTxLDk3klj0yA==
X-Gm-Gg: ASbGncsGjtGzakLHIvK7QI5Ib3klR8PHeIzB8t5IVaY++kUkjwRfAG+Wep8/bhYyRV6
	s9/4FK47lCjNt7+KCScmbuYj9729yLE85p/tlJOt9pQTO6qeF0UG3djIVi6jWMHjrqhV3Z4vTZ8
	618roCE6gGn5iyE8OnkVqnssWY2Ef434TYBJB/9KDmBSc7WlKvEY8IchlI6uQToXmjiTZcwNHB2
	eSNfZ+S53ED681/1TXsA9QhrZKcF4/LXsofi9up9Elmg81AOHR3mq06StFmUS8NC46SVThMeAeI
	MYkbn1N9hA4p66zsqfvF/YcWa3NjmGzsBzmyv2mewEqasEtWM7lXPCTsxqai2/vrvfyHKAxYu+J
	g2tx09QFW2P68b+k01vnIN6/QCaQ4FjM95IOcy1AyEPlCRGVwgjnNaoF4F/03MNUnpA==
X-Received: by 2002:a17:907:7285:b0:abf:2b4:c6fb with SMTP id a640c23a62f3a-abf2686a09amr843681266b.57.1740829002221;
        Sat, 01 Mar 2025 03:36:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPCf2wWBViuMG6idxiK+1QfLm7qmZEGg/zDdM1CgqlrIMVKlaPktbzXdcY8xCu+LIzOF/c0g==
X-Received: by 2002:a17:907:7285:b0:abf:2b4:c6fb with SMTP id a640c23a62f3a-abf2686a09amr843679466b.57.1740829001798;
        Sat, 01 Mar 2025 03:36:41 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b92d3sm463900866b.12.2025.03.01.03.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Mar 2025 03:36:41 -0800 (PST)
Message-ID: <72619870-bf83-47f9-9b66-6678e245364c@redhat.com>
Date: Sat, 1 Mar 2025 12:36:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] Plans for GDIX1003 Support in Goodix Touchscreen
 Driver
To: Weikang Guo <guoweikang.kernel@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
References: <CAOm6qnnhR9++REgtjhZpqNXkBbBAZsGAY8Oy89cXUF9S=Vy-9Q@mail.gmail.com>
 <8c7b5560-27d0-42bc-8f25-0797500fb889@redhat.com>
 <CAOm6qnmYSQz_YVaWw1c-fMm3NCVV9MoQhLQ0XGzK9o2RybLHmw@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAOm6qnmYSQz_YVaWw1c-fMm3NCVV9MoQhLQ0XGzK9o2RybLHmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi WeiKang,

On 27-Feb-25 12:36 PM, Weikang Guo wrote:
> Hi, Hans
> 
> On Tue, 25 Feb 2025 at 20:09, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi WeiKang,
>>
>> On 25-Feb-25 3:04 AM, Weikang Guo wrote:
>>> Hi Bastien, Hans, Dmitry,
>>>
>>> I am currently working on the Ayaneo Flip DS device, which I installed Kali
>>> Linux with kernel version 6.8.11-amd. This device has two touchscreens,
>>> but only one is functional. After investigating, I found that the second
>>> touchscreen has the device ID GDIX1003(confirmed by exporting the results
>>> through acpidump), and upon comparing with the current driver, I noticed
>>> that only GDIX1001, GDIX1002, and GDX9110 are supported.
>>>
>>> I have also reviewed the ACPI description and can provide the details if
>>> needed. Any guidance or updates on this would be greatly appreciated.
>>
>> I think this might just work with the existing goodix driver, just
>> add the new GDIX1003 HID to the goodix_acpi_match table:
>>
>> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
>> index a3e8a51c9144..4b497540ed2d 100644
>> --- a/drivers/input/touchscreen/goodix.c
>> +++ b/drivers/input/touchscreen/goodix.c
>> @@ -1519,6 +1519,7 @@ MODULE_DEVICE_TABLE(i2c, goodix_ts_id);
>>  static const struct acpi_device_id goodix_acpi_match[] = {
>>         { "GDIX1001", 0 },
>>         { "GDIX1002", 0 },
>> +       { "GDIX1003", 0 },
>>         { "GDX9110", 0 },
>>         { }
>>  };
>>
>> Note I'm not sure this will work, but is worth a try.
>>
> 
> It works, thank you very much.

Thank you for testing.

I've submitted a patch upstream to add this new hardware-ID
to the kernel:

https://lore.kernel.org/linux-input/20250301113525.6997-1-hdegoede@redhat.com/

Regards,

Hans





Return-Path: <linux-kernel+bounces-408023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD79C7901
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0281F2352A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65A016B38B;
	Wed, 13 Nov 2024 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEAi2Dzi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BA12309AF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515933; cv=none; b=sVod8U6L5u6a4vlgbYRmqyDGkMkHq7mrLagc/4CwwChbfw8EwdkIHJlrz2hRxYCuxknGzHAb+DTi0xHcJH2YltzGJTFqLkeK0B49+YTxIQjjKUF2APCPIyVPiW4uaQM5pBUB7U31t9AZAaxVsrsgj1+TlIMqC23QxnF16HnT0K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515933; c=relaxed/simple;
	bh=Sa/dJBIgKOD3CfAL/xLLYbVD7MvNKAtguZ1CHKbF5Ic=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tTCDZvsT3WbRmRKHEezincUxD7JpCEi9s/sPSEmY6CXmQ40nHsnCG/66JpTr6tjbf2u77wkKy3+dvYe+uyGw0Vt/fogB/azbjOkuH4U36ED4rCHn+0KPoXSJ9fMj71OvzF0TZRtj9kh8HEdODSjz+31YDYE9eKpuBWVB6GjcYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEAi2Dzi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731515930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qzB+LeXG5IhrY98l6K7JG/2iiGew0OdE+wgFYoWRqgc=;
	b=AEAi2DzipAUsDP14KO1HZmUUIAuES4rMbximkdhyI+q7fCGk02aH5XpRPKFx0UnUBZlc4Q
	g7ObTJcW8y8cE2JaNIvwG4LdpziqanSTAiaKLc5KoCjcjahgWjrYNQIqNm9R9AzFZJO1aD
	Nxljhzt90b51LWo3BNwkq1Ld/4huyB0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Dh7EdFMmNviHWgsYyn8iDg-1; Wed, 13 Nov 2024 11:38:48 -0500
X-MC-Unique: Dh7EdFMmNviHWgsYyn8iDg-1
X-Mimecast-MFC-AGG-ID: Dh7EdFMmNviHWgsYyn8iDg
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a99f084683fso661024266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731515928; x=1732120728;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzB+LeXG5IhrY98l6K7JG/2iiGew0OdE+wgFYoWRqgc=;
        b=Weqnpq2PWeb9m4yCYFSc0U3v5K0bfevtNj8LvjJ4m3MphFy/Cw2YQO2Y4Xz+5r7KkO
         t2a5zR5s12ShLkm3EPZ+8JqNG9fc+EgdT2bkAvpc1vVe+uCvV1PvLV/MgZ0LRdYt2jdC
         /XAM2Krf5ZuqSLc3pjpwlLR5O13NnyXst3+pYeCe7u7IT3XGnJr4lXiUUViPd/Oc1kMl
         kIqjyNZUuc7xDNLOKfXBDMxeUsAtMHEiCuzCmLggGFWlQswqnSPKOxE9YGJgY5ABLksV
         yhF2GLIRTbE0hQiZZjgVqL+qeMO6/9tm5LlDe0d9qVE//xo+V3gYVvI667IUVkIjLYrf
         OIxw==
X-Forwarded-Encrypted: i=1; AJvYcCU6fLzjMOUm4dwNKme04dw+T0lUPCxzd8gNAVDoBhWybVPNj7KcvfaHQiyINEwEemB7LjwTSGP1y1MnaQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztgjdmfECMVLrtewMfGEWjY6oRCpwcVlf9Ye3nLxlw0MzJ1ZVr
	nTHKSkj26+g7Zr8SEIq4YoFYwglmgp3NESWZm69RZ7fsab2J0nQcdzRPtK3EqoAC2Qi0dVYinqc
	Ye2MhynllytEs/ewb2QrWaWVSi8V9AGumNxDhU/E5cbO8KNwaZtwXmkGMyjGV7g==
X-Received: by 2002:a17:906:dc8c:b0:a99:f1aa:a71f with SMTP id a640c23a62f3a-a9eefebd390mr2082662966b.11.1731515927673;
        Wed, 13 Nov 2024 08:38:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK0CHDf38IDcl1jDSkcgus/oaTwQgyF2B+E/v3vqSUT/uhDGq/U/KWr6jfPvNSjnm5Ws0zHA==
X-Received: by 2002:a17:906:dc8c:b0:a99:f1aa:a71f with SMTP id a640c23a62f3a-a9eefebd390mr2082661166b.11.1731515927290;
        Wed, 13 Nov 2024 08:38:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def87bsm894583566b.143.2024.11.13.08.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:38:46 -0800 (PST)
Message-ID: <c373ca71-a0ce-4d48-acf2-cf4c7b6d18ed@redhat.com>
Date: Wed, 13 Nov 2024 17:38:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
From: Hans de Goede <hdegoede@redhat.com>
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?B?SWxwbyBK77+9cnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Klara Modin <klarasmodin@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danil Rybakov <danilrybakov249@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
References: <ZzTI+biIUTvFT6NC@goliath>
 <cd1cedcc-c9b8-4f3c-ac83-4b0c0ba52a82@redhat.com>
 <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 13-Nov-24 5:33 PM, Hans de Goede wrote:
> Hi,
> 
> On 13-Nov-24 5:24 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 13-Nov-24 4:42 PM, Daniel Walker (danielwa) wrote:
>>>
>>> Hi,
>>>
>>> I bisected an issue of a missing pci device to commit 2841631 the commit title
>>> in the subject line which was included in v6.1 stable branch.
>>>
>>> There was a later fix for a similar missing pci device commit 36c676e2 which
>>> appears to be for Goldmont/Apollo Lake. The hardware I'm using is
>>> Goldmont/Denverton. This fix did not appear to change the behavior I'm seeing.
>>>
>>> The pci device which is disappearing is a custom gpio device.
>>>
>>> I tested v6.12-rc5-next to see if any other changes had fixed the issue, but there was
>>> no change in behavior since commit 2841631 .
>>>
>>> When booting up the device is shown in the pci boot messages but the device
>>> doesn't end up making it to lspci once you get to a prompt.
>>
>> Please give the attached patch a try, this will hopefully fix things.
>>
>> Once I have confirmation that this fixes things I'll post it to the list.
>>
>> Note this will not backport to the 6.1 stable branch cleanly due to
>> changes in the x86_cpu_id macros in mainline. Backporting it should
>> be trivial. Please send a backport to stable@vger.kernel.org yourself
>> once this has been merged upstream.
>>
>> If you backport this, please also backport 36c676e2 first.
> 
> Never mind, self nack. This is correct for Gemini Lake which
> has its SPI at device.function 13.2 like Apollo Lake.
> 
> But looking at the dmesg Denverton actually has it at 1f.1
> aka 31.1 like most other Intel SoCs.
> 
> Which make me wonder why this does not work on Denverton.
> 
> It probably has something to do with these 2 messages:
> 
> pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]: can't claim; no compatible bridge window
> pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned
> 
> I'm guessing that this re-assignment is messing up
> the p2sb BAR caching, after which things go wrong.
> 
> Daniel, are you seeing similar messages with a working kernel ?

p.s. Can you also provide a full dmesg log from a working kernel ?

Regards,
 
Hans




Return-Path: <linux-kernel+bounces-411705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318B09CFEA0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 12:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAA1284DEE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 11:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A35F191F78;
	Sat, 16 Nov 2024 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PY2mw2zW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F083818A924
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731756903; cv=none; b=eQFDycyv5C4jT72SE+y0wVCvobQkRLKVWTy2ieiDy9vaP/Wn+9M9jOAALuEpiL8ppJm6yw/zGfw9PQ16nEnVYGtxFV4MpQ3MFltQEmgdswa4hfF4CZ8eoVj7nmo0P7+QYbItqGZ3fuzwGLRdG0bHcGD4SaImS3Yk7E+BxE+Fc+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731756903; c=relaxed/simple;
	bh=lBGgvKrBCVhZVdbtYnjPsN4MjB/9nAoh1Ca8vDpNEG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7IvPbHzms7IssherFFrXYwGfwD5ho56bMZ2j38BqA7GasfztPd26v7dmM1wPp3nZAF1r+67wt2R+Iujcs5MDcmdhY2mroYGAA4bxMpbW/lxxxKJgCBKvQgK8jABTTtD2iE7umUNI6IqRjXfzQp7+6VA1LI076PxL5S/i/C4Q4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PY2mw2zW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731756900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwIABSW/6MWtkXDIHEHHMfJJjSd+jsnaJwlLsBPFsg0=;
	b=PY2mw2zWZRaonPy5D6gxGTmC1h5H4qbx+hw2KDpaLJn2spdE3H5v0oTcPAoQulE81CoFnu
	FW0cqv6gpViJDs9BJzuoL+3IDpda59fOPhrhcjRh9pZNHU9mK9Q75zhZnT3Vays5AYh5g6
	ibgNbQsLirWmknb6Jy/oM2a6wxWUVv8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-PD1V44NJNy-heffZaNClsA-1; Sat, 16 Nov 2024 06:34:58 -0500
X-MC-Unique: PD1V44NJNy-heffZaNClsA-1
X-Mimecast-MFC-AGG-ID: PD1V44NJNy-heffZaNClsA
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c945ce3264so146382a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 03:34:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731756897; x=1732361697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwIABSW/6MWtkXDIHEHHMfJJjSd+jsnaJwlLsBPFsg0=;
        b=hzgRmAg4ppT2gdP5JhTjQ0mApalJbHNi7xjsFqUdPHYiQMciIsQXoVl1iCDIOARVXG
         fNxU60K24e9PKXgTI6lKvIouzivxQilZje3sL3U3Nee7MaLc2r6E0jROC7/Aq0Mt7LFp
         JgDNCAYuDcx8n5rq8LTyAzp3R/11de6+kYJvHzSilydGUiZ4qgNcR5eZmpMp9m/zGtnG
         4SdiqS8uqpqfZj3Yp78xE7jetO4Mq+R8pVgr3kZ6oodlbKpty/atfuKLpOCygYSrYDQj
         9yAePLdpeBHTcxOtxQQChM0RBrNDie7B2ITn3KqJIdGpXFd8mQf4HoAbGsdr+7tfOZXH
         /yMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaxvVHnXSWrdgllXPuJ1chvNjbHiP3A429swiYZCH/wRjzqZMOIsmEFLq3M+om2AGr5gDisEsGl4K7teY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycs79HrPOO4Min4OR7rVjZsZefrtvi9x8KpRx99quB5rMHzRoP
	PlFH92Y4Qtz24ssvoeg1u9TK36uE/XTAu3nG7LOQ7DBJARy9d2kD0bz3ao5ynrJ1Ytoowc9Dc4x
	5SzBuFwR6OTEnBcOuOa1VZDdIkAmyi5c8Ij2W7Pr4OJiVV1FzMTawUxJ7joTk0g==
X-Received: by 2002:a05:6402:2687:b0:5cf:9e48:596d with SMTP id 4fb4d7f45d1cf-5cf9e485e6amr4042673a12.6.1731756897227;
        Sat, 16 Nov 2024 03:34:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGosFKcQYyqvl6jNB+6sCO1LA3ytwmdyKpRWMdOwElTY3kIib/2limBSG6e0oRIh7YdVsT+gw==
X-Received: by 2002:a05:6402:2687:b0:5cf:9e48:596d with SMTP id 4fb4d7f45d1cf-5cf9e485e6amr4042649a12.6.1731756896915;
        Sat, 16 Nov 2024 03:34:56 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e043bc9sm291178166b.142.2024.11.16.03.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 03:34:55 -0800 (PST)
Message-ID: <30cb9109-baa0-4080-8fb0-fe535932377b@redhat.com>
Date: Sat, 16 Nov 2024 12:34:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Daniel Walker (danielwa)" <danielwa@cisco.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?B?SWxwbyBK77+9cnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Klara Modin <klarasmodin@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danil Rybakov <danilrybakov249@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
References: <ZzTI+biIUTvFT6NC@goliath>
 <cd1cedcc-c9b8-4f3c-ac83-4b0c0ba52a82@redhat.com>
 <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
 <ZzT7SPpBzOYxcjbH@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZzT7SPpBzOYxcjbH@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

On 13-Nov-24 8:17 PM, Andy Shevchenko wrote:
> On Wed, Nov 13, 2024 at 05:33:41PM +0100, Hans de Goede wrote:
>> On 13-Nov-24 5:24 PM, Hans de Goede wrote:
>>> On 13-Nov-24 4:42 PM, Daniel Walker (danielwa) wrote:
> 
>>>> I bisected an issue of a missing pci device to commit 2841631 the commit title
>>>> in the subject line which was included in v6.1 stable branch.
>>>>
>>>> There was a later fix for a similar missing pci device commit 36c676e2 which
>>>> appears to be for Goldmont/Apollo Lake. The hardware I'm using is
>>>> Goldmont/Denverton. This fix did not appear to change the behavior I'm seeing.
>>>>
>>>> The pci device which is disappearing is a custom gpio device.
>>>>
>>>> I tested v6.12-rc5-next to see if any other changes had fixed the issue, but there was
>>>> no change in behavior since commit 2841631 .
>>>>
>>>> When booting up the device is shown in the pci boot messages but the device
>>>> doesn't end up making it to lspci once you get to a prompt.
>>>
>>> Please give the attached patch a try, this will hopefully fix things.
>>>
>>> Once I have confirmation that this fixes things I'll post it to the list.
>>>
>>> Note this will not backport to the 6.1 stable branch cleanly due to
>>> changes in the x86_cpu_id macros in mainline. Backporting it should
>>> be trivial. Please send a backport to stable@vger.kernel.org yourself
>>> once this has been merged upstream.
>>>
>>> If you backport this, please also backport 36c676e2 first.
>>
>> Never mind, self nack. This is correct for Gemini Lake which
>> has its SPI at device.function 13.2 like Apollo Lake.
>>
>> But looking at the dmesg Denverton actually has it at 1f.1
>> aka 31.1 like most other Intel SoCs.
>>
>> Which make me wonder why this does not work on Denverton.
>>
>> It probably has something to do with these 2 messages:
> 
>> pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]: can't claim; no compatible bridge window
>> pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned
> 
> As I tried to explain in the very first commit that brings the whole driver
> into the kernel the P2SB mimics PCI device but actually doesn't provide all
> PCI capabilities. The BAR address there is basically a protocol between
> firmware and OS which gives the OS the first (most significant) byte of the
> address space window of 16Mb that P2SB responds to in HW. So, I haven't
> tested if the relocation actually works for this device, esp. if it goes
> over 4G boundary.
> 
> That said, messing up with that address is most likely a problematic there.

The relocation also happens in the provided working dmesg. I agree that
the relocation is weird, but that does not appear to be the issue.

At least it was not an issue before we switched to caching the bar
returned by p2sb_bar() early on so that p2sb_bar() does not need
to take looks.

Regards,

Hans




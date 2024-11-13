Return-Path: <linux-kernel+bounces-408047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6E69C798D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E00F1F276FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B79200123;
	Wed, 13 Nov 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cshi1HGY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31A613D2B2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517491; cv=none; b=cdji7iHmGnbvLW/VolSUg2z0fxHf+35OhZuf/QqQESU4qhHoGA7pBxABz11l8/trBDCn2by5fEkdZ5mJRa6w+QQLDguWy3s1KWctz1yJZqvsbXXUz0+2fg41ak3sC72aqDt5hJHcrU1PebFSPonlVEX8k0Kt2pfD+o7Y7VoyHD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517491; c=relaxed/simple;
	bh=Ue+lVrSPXVmnnwHwrId2yIWt6FhKWW1XNXg2HWV1UPE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DsuWPFLpFL47n0O+p4osCepF/2MfKFhZz9YrJY3Q4oixn6Eh9pCf27hNKdnDgjMCjARHJk1/nLRmpYpVZEDThYLeTokoih6NmvbEFtA4hMgo6ejWrD8uOEg9X4Ch3c1jQa+mwBGimEZ8inFJ4FQ9IYRcrM5QAMspCHkJ7MKjAwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cshi1HGY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731517488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4NUX2S3BqH7lqjltsNYaZxY0h5NGOHQLvsKhjmtcDM=;
	b=cshi1HGYDows4VlQtDhrLObI+ITORbi4UZ4O3/mGb14vU7yXrNqO57+iCe1rFIlTQjTJFm
	1FWZ9Bn7JzTUERuoWd2f45Z3HnPUNrd5dJONw9AmF1KDBtLq1XI5aCg6DYBiU/W9CmT9oC
	eRaSEUZxAuxwL1VGW/Me1eYQAKoEv/k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-7ZT2moVkOkKFfNCUCe7zlA-1; Wed, 13 Nov 2024 12:04:47 -0500
X-MC-Unique: 7ZT2moVkOkKFfNCUCe7zlA-1
X-Mimecast-MFC-AGG-ID: 7ZT2moVkOkKFfNCUCe7zlA
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a157d028aso560180966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731517486; x=1732122286;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4NUX2S3BqH7lqjltsNYaZxY0h5NGOHQLvsKhjmtcDM=;
        b=DKS9dQ7npXB7b8Ajj7LAYuWF79KF0PKSzDC6B5EClg0gUFT0x/8U5iUpHNKIeNXkz8
         QDE6Y1gTspjVQINS7RPsh9upDoCHWxTbOeVbphqCP02qxMId2ZPrcf6ZB1IxeouHpom+
         OrA5WPlAspmYC6E6QAcg65iGjRq+cdXKLYNF+e+EsdCf3n8qBHp7NAHxrQa4+nIuDGFN
         cT3A7MznLMKWCoszBU+BQh/XMYliaIEgQFAbkPEqWnAVrgioxkOQYYtyv6NVmbpVmRUz
         KJIQ+P854bxT9AEOES/55VANX91I0MF1T8qe6wjQjT3uvV/ZQBPO53lk+2HGkjYuy1LL
         CGwA==
X-Forwarded-Encrypted: i=1; AJvYcCXhHs09z90olOAfkLl+s3qsRubRYBunJniEsSNthtD4dTsoQGpsGOH8cTU7MBBlpxomZi8vML3SP06YwC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySSjVKhR6oSCbsIdvt8ApaHPo2wESZtBYLbuLmVIsEQEzprvzk
	XmmGchV2E2Vl9wrW6dkTczQM+G5AQ3kbWJvBLPw2KRoGtA/I+Qaiad+OOTYKtU2mj0cCra8IVW5
	WLBCB9vU6a36HUiqqIGXqQ8zx8g+FuPOYjw0rw3NzD6ifj5tog0dkEcTfuS1ygAAUlfJlqA==
X-Received: by 2002:a17:907:1b21:b0:a9e:e1a5:9746 with SMTP id a640c23a62f3a-a9eeff3932amr2263989266b.34.1731517485852;
        Wed, 13 Nov 2024 09:04:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEip0VlqG6Sxl0UxUypnAazDOHBxWWAurKR7Zal8QwZY7AWPIdYcha9cdDHKVs04fAFZTMraQ==
X-Received: by 2002:a17:907:1b21:b0:a9e:e1a5:9746 with SMTP id a640c23a62f3a-a9eeff3932amr2263983866b.34.1731517485427;
        Wed, 13 Nov 2024 09:04:45 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a194e6sm873308866b.41.2024.11.13.09.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 09:04:44 -0800 (PST)
Message-ID: <2c828592-dbdd-4cd4-b366-70797d63329d@redhat.com>
Date: Wed, 13 Nov 2024 18:04:44 +0100
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

Hmm, but that should be fixed by 2c6370e66076 ("platform/x86: p2sb: Don't init until unassigned resources have been assigned")

and you are seeing this with 6.12, which has that.

Can you try adding a pr_info() to the top of p2sb_cache_resources()
with 6.12 and then collec a new dmesg ?

If that pr_info() is done after the:

pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned

message then that does not explain things.

Regards,

Hans





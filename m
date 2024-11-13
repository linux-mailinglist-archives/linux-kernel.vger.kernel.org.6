Return-Path: <linux-kernel+bounces-408172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A0C9C7B47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A741F2357E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58861204012;
	Wed, 13 Nov 2024 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9e7HxXl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD59E200C90
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522906; cv=none; b=sTiaYq3Et6ihh8rG0HlS8FWBO6rGFwh8WtVqBZGroNl0+AqIHzTge5Cot0vsLV07Lk9o+v0rXYk/VSp8jwiSCOEX50uH/sfQCwVTbR+2vg5qPgqxIdvlmV8d+SkoPlAr7fcg2RlylBcOR2nvvQjNHUFNcCCCUABM1suojDXDSYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522906; c=relaxed/simple;
	bh=PC4hO0/REaUEGlOcIjQ36Pu/AgWwandEQb9we+5K5j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsn/M0Up0uycBQil4Np9Qtte0r0bZNIQodDHlfIifrWoClKgjARr4tIVj17GnoqVhu6Y+ACfQjwzxqnCjGxK8o8iHHAWPNNO5GH3iSryvHDAaQP4gxwF69ZHD0WjfmijAVFRatfnzTcBDYKlC7LiYbuQpz+EbjWF2p6PfIc8AVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9e7HxXl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731522903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=adBRElkHbzplxnx5Q2WFNHa3ypvnQxCAi5nOt87Bklg=;
	b=W9e7HxXljzlo2dxBd9aUgcREskiF0QBSU3sLH2NVBgGbbKjqxU/cMixBfVEwEMR1NYQaW/
	IJEItFS0oQbDSCSkaN63g/wJpZ9Y/ulcxRfBNK4D0KIN1eu2d1Ea6sV+ECify5Qyebc0qc
	55d6wVsXpoYG/z4KFbkc54tAESmejJs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-UkIWHB1ZMb28KYiKEMhRvw-1; Wed, 13 Nov 2024 13:35:02 -0500
X-MC-Unique: UkIWHB1ZMb28KYiKEMhRvw-1
X-Mimecast-MFC-AGG-ID: UkIWHB1ZMb28KYiKEMhRvw
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a99fff1ad9cso582179166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731522901; x=1732127701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adBRElkHbzplxnx5Q2WFNHa3ypvnQxCAi5nOt87Bklg=;
        b=qvHJo1TzupnxLc42JK4S0fTKV+okHPDgYVCBB1zY8UPlyw9Dnay3FVrYdF6MMb2zr/
         zjbyS9vQMSaOnRQ5BDk7VDyEa8vUNb+3o0kMT8Am/s5faiTBzxPNJEA1E5QCfC9TpwP4
         XsX4q6hLc4fHtDuFF5cCPosYz1U4/jCDKXl3rWskALYnjFjGitj1H17dtajX/6XCCUR5
         YBqLQUkpHUoU4MFIdv3N/9HwfocPxKxHC9KnKT3xv8+fR7AjptGtONEzBHmORMe8jZ6S
         4nljpMCHhdUsXZNmsp7BNyDfPrN4evxPZGDA5VFzlxKvjaiCepOVBTUQuOnxAKrfRX+B
         STvA==
X-Forwarded-Encrypted: i=1; AJvYcCV22t1ThcjCVfjKJLp+fs0Fgm7CzJ5woaaTViIVstow89Mn4Ryce5yxXz1Jk8Uux6USWmnGh5+gQleUU7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+sZx3KSab5Q5e9PGfVHH6Xk4NdipzeT5W2PG5TZT5fX8iARXw
	qKyLMsfB7isjB8o2D76H0KhD0AZolUqEDHgTfC4VszjuzSrCJmZkOaXXSZnSuYWIF7uBqcPiiOs
	4q3RNHne8VbOzkuiKSLGVtodVFFVCygOvOjdGB0BGwcBbdpjmtxT2M9ZM8dc34A==
X-Received: by 2002:a17:907:1b1f:b0:a9a:26a5:d508 with SMTP id a640c23a62f3a-aa1b1024dc1mr734009566b.9.1731522900986;
        Wed, 13 Nov 2024 10:35:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe56gMw2WAyVwgRznBhzB9DTxOLOUZnr1Lw+OIkSiNTOLxyz4QT2tTL7FDfN1Gugs9/dMeZw==
X-Received: by 2002:a17:907:1b1f:b0:a9a:26a5:d508 with SMTP id a640c23a62f3a-aa1b1024dc1mr734007566b.9.1731522900581;
        Wed, 13 Nov 2024 10:35:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def50csm903346166b.154.2024.11.13.10.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 10:35:00 -0800 (PST)
Message-ID: <a5bafe87-e8f6-40d9-a5d8-34cf6aa576a4@redhat.com>
Date: Wed, 13 Nov 2024 19:34:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: platform/x86: p2sb: Allow p2sb_bar() calls during PCI device
 probe
To: "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?B?SWxwbyBK77+9cnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Klara Modin <klarasmodin@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danil Rybakov <danilrybakov249@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
References: <ZzTI+biIUTvFT6NC@goliath>
 <cd1cedcc-c9b8-4f3c-ac83-4b0c0ba52a82@redhat.com>
 <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
 <2c828592-dbdd-4cd4-b366-70797d63329d@redhat.com> <ZzTk5kyPa5kUxA+f@goliath>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZzTk5kyPa5kUxA+f@goliath>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 13-Nov-24 6:41 PM, Daniel Walker (danielwa) wrote:
> On Wed, Nov 13, 2024 at 06:04:44PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 13-Nov-24 5:33 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 13-Nov-24 5:24 PM, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 13-Nov-24 4:42 PM, Daniel Walker (danielwa) wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> I bisected an issue of a missing pci device to commit 2841631 the commit title
>>>>> in the subject line which was included in v6.1 stable branch.
>>>>>
>>>>> There was a later fix for a similar missing pci device commit 36c676e2 which
>>>>> appears to be for Goldmont/Apollo Lake. The hardware I'm using is
>>>>> Goldmont/Denverton. This fix did not appear to change the behavior I'm seeing.
>>>>>
>>>>> The pci device which is disappearing is a custom gpio device.
>>>>>
>>>>> I tested v6.12-rc5-next to see if any other changes had fixed the issue, but there was
>>>>> no change in behavior since commit 2841631 .
>>>>>
>>>>> When booting up the device is shown in the pci boot messages but the device
>>>>> doesn't end up making it to lspci once you get to a prompt.
>>>>
>>>> Please give the attached patch a try, this will hopefully fix things.
>>>>
>>>> Once I have confirmation that this fixes things I'll post it to the list.
>>>>
>>>> Note this will not backport to the 6.1 stable branch cleanly due to
>>>> changes in the x86_cpu_id macros in mainline. Backporting it should
>>>> be trivial. Please send a backport to stable@vger.kernel.org yourself
>>>> once this has been merged upstream.
>>>>
>>>> If you backport this, please also backport 36c676e2 first.
>>>
>>> Never mind, self nack. This is correct for Gemini Lake which
>>> has its SPI at device.function 13.2 like Apollo Lake.
>>>
>>> But looking at the dmesg Denverton actually has it at 1f.1
>>> aka 31.1 like most other Intel SoCs.
>>>
>>> Which make me wonder why this does not work on Denverton.
>>>
>>> It probably has something to do with these 2 messages:
>>>
>>> pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]: can't claim; no compatible bridge window
>>> pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned
>>>
>>> I'm guessing that this re-assignment is messing up
>>> the p2sb BAR caching, after which things go wrong.
>>
>> Hmm, but that should be fixed by 2c6370e66076 ("platform/x86: p2sb: Don't init until unassigned resources have been assigned")
>>
>> and you are seeing this with 6.12, which has that.
>>
>> Can you try adding a pr_info() to the top of p2sb_cache_resources()
>> with 6.12 and then collec a new dmesg ?
>>
>> If that pr_info() is done after the:
>>
>> pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned
>>
>> message then that does not explain things.
>>
> 
> I haven't testing adding a pr_info() but the messages seem to happen in the same
> order in both working and non-working cases.
> 
> Does that matter?

The working case does not do the bar caching, we want to know if the
bar caching in the non working case happens before or after the assignment:

pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned

It should happen after the assignment.

Regards,

Hans


p.s.

I'm going offline now for a long weekend. So I won't follow-up on
this email-thread until Monday.



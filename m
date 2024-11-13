Return-Path: <linux-kernel+bounces-408019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3C49C7921
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1B42B269EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC001632C9;
	Wed, 13 Nov 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8u5gN/B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CB3146588
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515630; cv=none; b=ANyQS+0ZQ0rTkcGMZ7S3LOC4G4qdXnp3GuW7KyJR1g3oi5WRvE9lEiuVsTAlDDlvBHNmYslCwat8wjTSnlSb6UXRLz5J/RxmvYdyqwgOakAAfS/5QOo7aC0a1xaZIK/hCvSeDfDsO2GDxJUVFsof6sLpmfjGjg1lTGM9utOZVi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515630; c=relaxed/simple;
	bh=+GKq7RlqrLug5VmekER6JKJASTKpUx9dqxtikOCFAuY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dmgAXetjC1gKRxtVmp2+6xDdM++9KF7Js8r1n/43ACK6kQk7lLfEHtjmnHYk5xCYKSdgQhsV6qQRO2dn6xe11knilHOD1AQwJmBKKEuZyfB4Z+QUvfoL3RF3Oluyyk+xNLo9C+LIVdIQ+fcS8/PQGDzMO7ThYZTLKXs/3mO4iYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8u5gN/B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731515627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjxx6FYwNlzfgGMGa4kzuenO2u8qXtaO9L9q1BhyEIc=;
	b=h8u5gN/BEY0bsbL45smpeu//tHE7SJccKFGlD8NKVZxyzX8i7YnjvnvLzZ0Lea2cVgTSfL
	f3si/Dmo9PDkh0HJXL+sv4DCgYEtzDzuOA7EGkO/sJNLVcJU2ZBGWBfOF6M6B02b/nwcYy
	ZQsEBr4ZJ+axbIyeYymfpWElKacX0KI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-j9ff_-aQPYqXgbYgLO9jrg-1; Wed, 13 Nov 2024 11:33:43 -0500
X-MC-Unique: j9ff_-aQPYqXgbYgLO9jrg-1
X-Mimecast-MFC-AGG-ID: j9ff_-aQPYqXgbYgLO9jrg
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9ad6d781acso639859666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731515622; x=1732120422;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjxx6FYwNlzfgGMGa4kzuenO2u8qXtaO9L9q1BhyEIc=;
        b=Nyt50mDgwkfKF/VDPDNObBMjzHKfXJfAATQ39SVaWhjnblg3UJB4l2U0ikD7B22DWA
         CRglH8GxeJUEWapCqM/DVGXXnUGx0YeIFYRDjvQ6rQaNeFFHIbyjNoKrYlll/XuJHb1m
         R8GKs+3LhM5zddZMWYKXSQzzIABv/nXT50unaayfT+haDzYSc3d+e5+AL0bDe7j4g6ZE
         t/6WlPPleszXOH/YCwuqrvlyaNtQKQi/FU3pYe1QY0LKVX8pKSlhQ0+07hFZurQpUDX5
         KgXUHcETQUXmJ3HPazHBuL+KCHezRx1P8Cdw91MlmrDqSTvcKM6LVeIiO4PpiLC47JbX
         mPHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmplXhnhjZU107Evz9453iuBzTnho+LO7Lj3wN/BUHwoMjHyFebeHaELHVlo+wYnmN/wuwA0NCfOg9Anw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqv+/5ihmgUZK199nkIG/cgNk0/lrqlRD0s/jDmLpq8iGZa/jX
	SYQUbRn9ADT4GYp4mKluQh56G0mqGmFv3RQhDRuft1tG1dy8X1dEGHNU7X+DabdOIObes4Jazdo
	V19p8fdbB0Tzvl///0XsMJTTrCr50U16JajPWvwkpBjq/dTzmtx3O3Prv/Pgd0g==
X-Received: by 2002:a17:907:1c02:b0:a9e:d7e3:ccae with SMTP id a640c23a62f3a-a9eeff0dac2mr2087809566b.16.1731515622583;
        Wed, 13 Nov 2024 08:33:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEK/V5gUwompLrv0iNrHp7cnGG8sKBLBLoHRGrP7kcq5r9xf7qAwrHJGuPVYMAImIvNpbmYw==
X-Received: by 2002:a17:907:1c02:b0:a9e:d7e3:ccae with SMTP id a640c23a62f3a-a9eeff0dac2mr2087806966b.16.1731515622250;
        Wed, 13 Nov 2024 08:33:42 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2e908sm880255266b.196.2024.11.13.08.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:33:41 -0800 (PST)
Message-ID: <82ab3d06-40e6-41dd-bb43-9179d4497313@redhat.com>
Date: Wed, 13 Nov 2024 17:33:41 +0100
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
Content-Language: en-US, nl
In-Reply-To: <cd1cedcc-c9b8-4f3c-ac83-4b0c0ba52a82@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 13-Nov-24 5:24 PM, Hans de Goede wrote:
> Hi,
> 
> On 13-Nov-24 4:42 PM, Daniel Walker (danielwa) wrote:
>>
>> Hi,
>>
>> I bisected an issue of a missing pci device to commit 2841631 the commit title
>> in the subject line which was included in v6.1 stable branch.
>>
>> There was a later fix for a similar missing pci device commit 36c676e2 which
>> appears to be for Goldmont/Apollo Lake. The hardware I'm using is
>> Goldmont/Denverton. This fix did not appear to change the behavior I'm seeing.
>>
>> The pci device which is disappearing is a custom gpio device.
>>
>> I tested v6.12-rc5-next to see if any other changes had fixed the issue, but there was
>> no change in behavior since commit 2841631 .
>>
>> When booting up the device is shown in the pci boot messages but the device
>> doesn't end up making it to lspci once you get to a prompt.
> 
> Please give the attached patch a try, this will hopefully fix things.
> 
> Once I have confirmation that this fixes things I'll post it to the list.
> 
> Note this will not backport to the 6.1 stable branch cleanly due to
> changes in the x86_cpu_id macros in mainline. Backporting it should
> be trivial. Please send a backport to stable@vger.kernel.org yourself
> once this has been merged upstream.
> 
> If you backport this, please also backport 36c676e2 first.

Never mind, self nack. This is correct for Gemini Lake which
has its SPI at device.function 13.2 like Apollo Lake.

But looking at the dmesg Denverton actually has it at 1f.1
aka 31.1 like most other Intel SoCs.

Which make me wonder why this does not work on Denverton.

It probably has something to do with these 2 messages:

pci 0000:00:1f.1: BAR 0 [mem 0xfd000000-0xfdffffff 64bit]: can't claim; no compatible bridge window
pci 0000:00:1f.1: BAR 0 [mem 0x280000000-0x280ffffff 64bit]: assigned

I'm guessing that this re-assignment is messing up
the p2sb BAR caching, after which things go wrong.

Daniel, are you seeing similar messages with a working kernel ?

Regards,

Hans




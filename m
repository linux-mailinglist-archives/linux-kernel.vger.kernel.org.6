Return-Path: <linux-kernel+bounces-180893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7718C747C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A921C23C71
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850C71448C4;
	Thu, 16 May 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0nE7z2x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD04A14388D
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715854441; cv=none; b=iYSlV1FqJ7dkrTGi+etb0tUj3jPzBSfXjuGxWBV0Nzwz2SeYDUfG9zPWKJ0M5wbzy5YN7NPGJOplfSAEgGt7Ji8VLEMBjP3HSow21ZmXmAJjM/Y/Wbby1QJ5BjQLxmJJk2mNsjdv+zbI/20OTcvz85SyDu/AbaX8iz2/LWuYeTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715854441; c=relaxed/simple;
	bh=dpSnTE5cKNRfORfDcOScjr13JdXXzuQc/kzXUbq+S/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ernDsxzKdvn/J/mdvKl0C+mzUVyCAmzRsLcaS5hkchKv8Zti+K1xF3jJbdZ6/T/esaUIjqWwwbg/QImDGf0Bd209NWKJ/+kmc+eYlUsUm8ROITiLsQEk8dP+XY+MnZCpJDeKl+N/wc49Zlsy1alSo67/GrXL1Qemx7xjo/KBlCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0nE7z2x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715854438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFCv0XQtSQzy9qRNLd/SfLPXz3EOPSnTspnCEFQxF4U=;
	b=A0nE7z2xAxXM1D1G1DWqxH9XbL8yr2Q/wapeKuOnm2L9OcVGpbxlRPQhOvl1hAiQWn7Y0A
	7ojLDuhic3/dPyBU0KFW62AH4lE+8MBgH3akZv9JHxbOM/L6EiTNAQg8F/GeGVZq3W/6mf
	bgry/v9pna8mCknECdV2jVCeojk2QdY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-otpJkHmdNNiCxMHFpst9vA-1; Thu, 16 May 2024 06:13:57 -0400
X-MC-Unique: otpJkHmdNNiCxMHFpst9vA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a5a05c4e0efso493040266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 03:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715854436; x=1716459236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFCv0XQtSQzy9qRNLd/SfLPXz3EOPSnTspnCEFQxF4U=;
        b=fuVdithr/pe/6SDe9Usf3zRtvqEMtUjYhcM4JH0OS32zu3tg0h7KNMmq/l2PvUBkQc
         hJnugZobOsAsrMOrqP566iqhybHsPmp/1lxjjnM7f+skPmDvhLWulVXgc9ilpdQnOozh
         QOBXCQYDEvhn8++rzrKHZZGGln9T/mZP7zxS71XywgD9Jd0tfvQtFBPKIGUfNU0Pf6NO
         uTm9Tdwr/bQ9z+QZj+HGDsgmwGn4ReIn5NX884Sk7udroRd+v7nnooZVGcpzi+Z/ZvOk
         W4gf/cebH5dBGo0SLWgBedPErYe4JVQNMhS9mB3j0E567epKkGNXsOAS97h2SPHbmY4t
         Y+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVE7vlRrT5/OBldG8IC8ViNhm+4yaq4aE3vmxXrHFjllYOp+qL1HzA+Kt7ii+r1alkc57ODjZjNM9DtWsyJm7GwkO3nleIxIC0j9xVt
X-Gm-Message-State: AOJu0YxoJ2l5/VmBbjS+HZCbIu6Dnt2B4IBY29ssEtfbDgGt/jwapDY2
	SzLT5RD55KOecIMqsKwVhur8ZU1rhjdvY9CefXl28YPpCSVxvckcKNn8KuAXNDymvo3uTIKgntk
	RzWfugfL2jVPkmBlnQQbLa9op5wQPN9RWZog1Br1IlF/rpgEjwlxtPidoFO+bSA==
X-Received: by 2002:a17:907:986:b0:a5a:5c5:a9f7 with SMTP id a640c23a62f3a-a5a2d55a4bemr1502141366b.8.1715854436161;
        Thu, 16 May 2024 03:13:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjOimyeZISz2+Cx+C1ULkQurXDxrZa7vlq7k7hVr+yQ2h5kGz1o7CEEhnQyMJ8GvoRkDaKHQ==
X-Received: by 2002:a17:907:986:b0:a5a:5c5:a9f7 with SMTP id a640c23a62f3a-a5a2d55a4bemr1502139666b.8.1715854435744;
        Thu, 16 May 2024 03:13:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17d10sm961336966b.198.2024.05.16.03.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 03:13:55 -0700 (PDT)
Message-ID: <2e5c9108-9ca4-4d7c-a062-2a9a5baaf06e@redhat.com>
Date: Thu, 16 May 2024 12:13:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ACPI: EC: Install EC address space handler at the
 namespace root
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <w_armin@gmx.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <12437901.O9o76ZdvQC@kreacher>
 <5161bd95-d51e-49cc-bcbd-523fbb747e4b@redhat.com>
 <CAJZ5v0gf-oLcjT8dxnpjAyVfpUep5ST2mHDJy2dySBGCJwjMxg@mail.gmail.com>
 <b53b4fe4-e3b7-4939-a8ea-9eb55f0bece6@redhat.com>
 <CAJZ5v0i+ejMyj0j7RvVY7+g6eU8bQ9QLG=08fm78i9Ui1fEiVA@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0i+ejMyj0j7RvVY7+g6eU8bQ9QLG=08fm78i9Ui1fEiVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/16/24 12:09 PM, Rafael J. Wysocki wrote:
> Hi,
> 
> On Thu, May 16, 2024 at 11:50 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 5/16/24 10:37 AM, Rafael J. Wysocki wrote:
>>> On Thu, May 16, 2024 at 10:35 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 5/15/24 9:39 PM, Rafael J. Wysocki wrote:
>>>>> Hi Everyone,
>>>>>
>>>>> This is an update of
>>>>>
>>>>> https://lore.kernel.org/linux-acpi/5787281.DvuYhMxLoT@kreacher/
>>>>>
>>>>> which was a follow up for the discussion in:
>>>>>
>>>>> https://lore.kernel.org/linux-acpi/CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com/T/#t
>>>>>
>>>>> Patch [1/2] has been updated to avoid possible issues related to
>>>>> systems with defective platform firmware and patch [2/2] is a resend
>>>>> with a couple of tags added.
>>>>
>>>> Thanks, the series looks good to me:
>>>>
>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>>
>>>> for the series.
>>>>
>>>> I assume you are going to send this in as a fix for 6.10 ?
>>>
>>> Yes, I am.
>>>
>>>> In that case feel free to merge both patches through the
>>>> linux-pm tree.
>>>
>>> Thank you!
>>
>> Hmm, I just realized that this:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=for-next&id=c663b26972eae7d2a614f584c92a266fe9a2d44c
>>
>> Is part of the main pdx86 pull-request for 6.10 which I'm going to
>> send to Linus in the next 10 minutes or so. So that is going to
>> conflict with your 2/2.
>>
>> Options:
>>
>> a) You only send 1/2 upstream as a fix and I'll then send a rebased
>> 2/2 upstream as part of the first pdx86 pull-request.
>>
>> b) You merge the git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
>> platform-drivers-x86-v6.10-1 tag (which is the tag for the pull-request
>> I'm about to send to Linus) and rebase on top of that before sending
>> a pull-request for both to Linus.
> 
> I would rather wait for Linus to merge your PR and merge my changes on
> top of his merge.

That is fine too. I just send out the pull-request so hopefully Linus will
merge it soon(ish).

Note (stating the obvious) when rebasing 2/2 you will pretty much need to
remove all the new code added by:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=c663b26972eae7d2a614f584c92a266fe9a2d44c

Regards,

Hans




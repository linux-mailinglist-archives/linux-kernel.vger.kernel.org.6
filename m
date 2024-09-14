Return-Path: <linux-kernel+bounces-329447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30191979179
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BD11C215F1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0771D0483;
	Sat, 14 Sep 2024 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2xmhT8m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FEA1D017A
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726324208; cv=none; b=LRx2Jhz6P3F1grOaH8Cb0R998A3Ghx9Jr+KW4LBzZ7U4xTRw6/7Fvvb2w0SmH86LCiksHun7xcOlosfpAioEOkw6RYWQvB6aFllCwTCGtwrg218E4OUb9ZkwCBk0IQXSzTHSXnCzoA6LE8jvr0ItZwXUQMFGfo1Gl74wVvtChFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726324208; c=relaxed/simple;
	bh=aBqS8oRYDmpUse7CONpW8q8J1u2o64dTl5LjQXtnR7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gckxe71P+dBhP3TbICnf/cmGlPjuwSu/hn06Pg8s6s0qg7hSiGOjgxG920ilczbATPMjJaIq/Kb+SpjXf2eLW77fi3VhaLxAQaGAonw/kVV0SAGA4wjpS0IzkTseeQv7dOF+ZZ4rekUg8/v4oMoJR+/gKiAtWxbKuam4kPKSBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2xmhT8m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726324205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WUIYtHUwD2qXPpZmCiB/MrftrJ8UvdxuJ9psNc0DVHY=;
	b=G2xmhT8m2iurbqGQ0p3mr205/9dMEqGSe4T5Pw3V2mD+PTXouQhgZWlicyWqIGDwofbhiY
	A8TOD/QiXGK9/GpUIhVCSr4sMRvCZuKrOP9RGpFBNKqXZ9tmMbdv5VR+UpovwDqKs0KIyd
	HIBW1JAFdnRvJTN1QdYTyDNHtaiPlpA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-SXaGhO21OOaZpzpt-KB4KA-1; Sat, 14 Sep 2024 10:30:03 -0400
X-MC-Unique: SXaGhO21OOaZpzpt-KB4KA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c2486f1f14so1838278a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 07:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726324202; x=1726929002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUIYtHUwD2qXPpZmCiB/MrftrJ8UvdxuJ9psNc0DVHY=;
        b=Iy39w3ej/jAKRM0ujep+W5KGT3RSyo2VpwuUbXiKiqC74wV9A+PwP2aOK0/IHf2HCJ
         o5sHf05VayyRD+BP7nI5GjjHgBRieKVjNd0yypfoUcpjH/1K7gZBSMSJw/svzxVWeVx0
         AVKz1zasOnCSqIkAjwYxpXGXjzNJS2jbV/u+n0CxqrBVa2+dcx/E+8kxOVvIKRYnqRns
         L7ddmLD65CldfjMpvILggN5Q0jGt1WhGKntCZD9mS/NlVYzzwjjBCFI/YJxpvvzqx9Ll
         ugT9SwYUKg+FGunrVWzsmR0f+YK1tpdIyRFSah3OwfMZhbks+mncRk8XrBUyFnRbX4MD
         swnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWoPe4mgK4U/EmS6RRo8EIAXWHD6lPdoferzWQkIttitxi1JORj++698y3yL4SR0EmigTncBj5hE/1Q9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRKYmS+Keiu4IGrePiIGiRKmtLH26fm79YfMqpQWMH03Pw171R
	jYDC3hGhlaLIQXWaMvk6Nmkk5+LFkC8A7AfzJbTtKTg+gyzWjliOzns7XK7zUJp+cFfh9y7O3Hh
	EBeBHyJ+2ZbYMGDwtNPXCoYcpiDy8UYOk8rDlmLS19xlVG3Juiw0E7nI+J5nWSA==
X-Received: by 2002:a05:6402:278b:b0:5c2:480e:7960 with SMTP id 4fb4d7f45d1cf-5c413cbc723mr8817628a12.0.1726324202241;
        Sat, 14 Sep 2024 07:30:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdiyfNIjpIOF2G5WOhDqvmd1lRGQuKW1e1HHBMwGKghPop2gIR4CBehb2l09KJxrdfY/aYoA==
X-Received: by 2002:a05:6402:278b:b0:5c2:480e:7960 with SMTP id 4fb4d7f45d1cf-5c413cbc723mr8817608a12.0.1726324201670;
        Sat, 14 Sep 2024 07:30:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5fce9sm718371a12.56.2024.09.14.07.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 07:30:01 -0700 (PDT)
Message-ID: <95134eee-5000-44d7-8a8b-67a93a86c05a@redhat.com>
Date: Sat, 14 Sep 2024 16:30:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: light: ltr501: Drop most likely fake ACPI ID
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240911212202.2892451-1-andriy.shevchenko@linux.intel.com>
 <c45dd21c-493a-4e56-809e-85d6d7201254@redhat.com>
 <ZuQGcyrTFek1yExt@smile.fi.intel.com> <20240914152541.1c2228f4@jic23-huawei>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240914152541.1c2228f4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/14/24 4:25 PM, Jonathan Cameron wrote:
> On Fri, 13 Sep 2024 12:31:31 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
>> On Thu, Sep 12, 2024 at 03:51:09PM +0200, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 9/11/24 11:22 PM, Andy Shevchenko wrote:  
>>>> The commit in question does not proove that ACPI ID exists.
>>>> Quite likely it was a cargo cult addition while doint that
>>>> for DT-based enumeration.  Drop most likely fake ACPI ID.
>>>>
>>>> Googling for LTERxxxx gives no useful results in regard to DSDT.
>>>> Moreover, there is no "LTER" official vendor ID in the registry.
>>>>
>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
>>>
>>> Thanks, patch looks good to me:  
>>
>> Have you grepped over your collection of real DSDTs?
>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>  
>>
>> Thank you!
>>
> I'll pick these up in the meantime. Applied to the testing
> branch of iio.git.

As mentioned earlier today, at least the LTER0301 ACPI Hardware ID
is real, so please drop this one. The kmx61 patch is fine to keep.

Regards,

Hans





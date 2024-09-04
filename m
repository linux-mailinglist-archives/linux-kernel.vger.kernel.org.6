Return-Path: <linux-kernel+bounces-315081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C5D96BDD0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF0B286021
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294571DA2ED;
	Wed,  4 Sep 2024 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNJvI3GW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA41DA317
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455134; cv=none; b=jpFO9Gv7XdR40NpNSliOjA7VaTnGg92WpZj47rOMOpUjQu0SxiHoRk9jKPQPOEEXsYnf9vzv5lEBtMo4tmEd0+mnxQaOZUG377MkiTYvzbDSv7RIAwMzzgsAdpDLMAv+fb4WDQId6GCZeNiJLuLp1NQfbzkH5mZv3rPYt4Nrug8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455134; c=relaxed/simple;
	bh=Qog4/ckP5IwmWdw4kRSCmvkd/PPxpvrlQLCc7SpaTZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxE9i71uLDiZZhq3UfWXOckvL8OEeK4DxryDJBOfU0x5mPvHJ2s5FnTkxzg7n4qNemkLj2mjM2VWbG1V6kyWixuhVbK5mSImAtWtJPgF0BZa69T4ZLhIW1A9whLuMA7O9yVrA0yXch3XnkHpVJeYei+gxOOEmMo4fGOaSiGJvY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNJvI3GW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725455131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pc2eaZ47WJ4Q9gCOeP10UryjXtcCatn1vVORikLChL8=;
	b=RNJvI3GWRCtE2ArXPDKaRYm7PW1aJZIIgE3yoKg7HX1dOqmOJOHEkfBTxyUu/ACNQeXroh
	JukCHieP5Ub/xgSs2L9IPk5Io9pt9JPXpNkROZc8AmHhCPjSX0aISCg9SS4KOvoHbX0uaq
	neia4fVI/NzFM0TYwZY3tpzzD/Lnu5M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-1Vi-fdInO5yJD7GXg2_t2w-1; Wed, 04 Sep 2024 09:05:30 -0400
X-MC-Unique: 1Vi-fdInO5yJD7GXg2_t2w-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a86824d2d12so561582366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725455129; x=1726059929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pc2eaZ47WJ4Q9gCOeP10UryjXtcCatn1vVORikLChL8=;
        b=sYfTbM6boySCT+k2eypreIXHByaOUhcOg4P25Kfj7Oo0t61X1wjEPB/Gxg+2LyJL88
         oU94VydZj8nwBdDi8FfTh9upMBhtHZ0y7hBMRVNfBin3vHh2ONBswB3Zy5LarciViRGw
         7N+wTKkrHt4b8sPhix/TyQzmmTkgrc3ClSh9+aHd07crb4uBq975F3szsokLE1pICCyh
         H4xCl/grsCWJvirFxU+CbJ7HZR0fLhZp502JdGxR/UasKeBH1UNf45eahZmkIRB970TN
         LnN8NLBRz035VqJaCoLKEG1SRW+bVMPRX8aN09ck5e6ZitPkZTeFYLqhbLRVg09wV2LL
         FT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbsmQmR17b0SWC5yDIUJwGOmCcWBF/joFOZgK+zDBfbKfQH4XJ9IzT21IOT+9BS/4wCS3j71f9kryfTO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOC/MVQl/IH1NTd9QevToFmJE9TWFbOmykAkWAr/mpCw4M7348
	i2Lyx+BJcbyaLxuDMqVJqpQA9hMybok3i2kyqIuLf+aITXetBHWXy6wmj9b4ShAJk/dMQ4zHg5W
	TQ8oITwrywpLyJmPgxKh2SuWaXZf7/ePWb3nq3EevXL4we4h1b6rM50OBkDbiag==
X-Received: by 2002:a17:906:6a1e:b0:a86:83f8:f5a2 with SMTP id a640c23a62f3a-a89b94cef24mr1223955066b.19.1725455129533;
        Wed, 04 Sep 2024 06:05:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnOy/z2jyGJKjbXW7jRf8OvhsAv1mCemghSG6D9ZH9zkIUKoN0rHZO5VxuCCYQ+Z62Be36yw==
X-Received: by 2002:a17:906:6a1e:b0:a86:83f8:f5a2 with SMTP id a640c23a62f3a-a89b94cef24mr1223950166b.19.1725455128993;
        Wed, 04 Sep 2024 06:05:28 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb61fsm821951966b.10.2024.09.04.06.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:05:28 -0700 (PDT)
Message-ID: <ce292f51-b327-4f22-af22-bb6ed3d87d51@redhat.com>
Date: Wed, 4 Sep 2024 15:05:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] platform/x86: int3472: A few cleanups
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Scally <djrscally@gmail.com>
References: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
 <ZtWRGgb-ZsLp25np@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZtWRGgb-ZsLp25np@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/2/24 12:19 PM, Andy Shevchenko wrote:
> On Thu, Aug 22, 2024 at 04:05:37PM +0300, Andy Shevchenko wrote:
>> A few cleanups to the driver. It includes an amendment to
>> dev_err_probe() to ignore 0 error code. The patches 1 and 2 are
>> dependent, while patches 2 and 3 may be applied in any order.
>>
>> Assumed to go via PDx86 tree if no objections to the code.
> 
> Ilpo, Hans, the patches 3 and 4 are independent from 1&2 and may be applied
> separately, if you have no objections.

I've applied patches 3 and 4 to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
now.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




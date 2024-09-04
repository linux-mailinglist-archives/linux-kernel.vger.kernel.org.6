Return-Path: <linux-kernel+bounces-315684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D81AB96C5C2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D131C2150F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435211D6790;
	Wed,  4 Sep 2024 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEvgEQaI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9CD4778C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472275; cv=none; b=a2OmhAAmKqFajWrIQALfl1tRaH+HK5QwusvBx7bGzoBzouG3sPsj/2ZZ3Y+5w5GVdy/vsSvv/NaYDaY90rWgS2ToWcFa9Qv60aQrtIcNr5gmXXJT3kLmqcflB+UnocRLwF2abhXl9qJEG0TCpcV7JyjW6QCfiu4SdQNzbd/D5nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472275; c=relaxed/simple;
	bh=LGQLyd/+Aw5K1p8dY58/6VCzzrzjIX7s8gz3pCMOVjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ez5+u6eHrQXQahHVKJGWb/dxy1MyhDpIRJ4aRNLIJdMMCnASyfHdPGdZp5LOXqyyLI55uz50kRh93MD/gOmhfkwJxd2k8E0qX3VpN8Ay+npYKWvqQ2MvzuS5dcWzTwNrRP6NW7xyzA4s8P8ug7BdeHZW1dDz8EojH1q51nrgHvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEvgEQaI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725472272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftdH73Ix9wDNM7yMKsfpwwMJeknPg5Z/1RRp5Jzhr1s=;
	b=OEvgEQaI3DF8DA8YXjw0TrKZfVxZgtdy9A58yGsgUh1i00rmArPngKXbxas6V6Zs/THTi0
	vuRUtey2bPwX3BcJJ0aSzY7LTGOcYko0wU/mGCq7KSJ5PLuB7nYpFW2ntc5RQlgMa7GB4M
	NwA10wS++uRVKWYZYUuz/sloTN4DNHI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-byN5U8hdNJWXhUL18WVztQ-1; Wed, 04 Sep 2024 13:51:11 -0400
X-MC-Unique: byN5U8hdNJWXhUL18WVztQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c24f1e3933so3358625a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 10:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725472270; x=1726077070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftdH73Ix9wDNM7yMKsfpwwMJeknPg5Z/1RRp5Jzhr1s=;
        b=NMkBgm4ZX0tfcEjl+2IhOYwiYDcudxGWNGo4EyzMw6n+Nv5PtyaBc9VW8gfZxjs2tQ
         LHpH/3E9tAQWxEerM1bbCucm4lKwaT4PeKboFaldMIzMAg+25PUSAQ7XicZN2Y9OQgQv
         zn9LOkDmBdfmpEB3dQyMp/xeKhtUZux7eSSXxp7KF6m08n/R1h3dgYEERCHHS4Sn8weG
         BwVK81MD4f/D6+qmh6ItPk8rpGlkd8m4GvsLEvjV4T19B8jxrPiaro0FTynf88KDcu4g
         2IqsqVgi43jxG62QgfV7GKpyUjwaaaXuNjBwG5A7eZ4Bou4sHoTHNtEGiagGF0AnKKf7
         HaDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2WX5ojNQUVup5HqD/Ms/2ScuANR7E1Tok2JzrP2GdfwbXq6nTtzBsNXZADuAV28nRUsDziHH4PnKyyZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuiK3k4PUIHMcs5HXXmsoMcskdIJV6JS321pwTrWyvjAUJmjLm
	L4Ait4E69dfX90f258AZ5s5qlJgLxmPC8yRpEO2AfIvb18RL/ekPpvsFLTYHjP8/k9gPNVcduao
	rvmR0MGOyoO8/hx2aoei/153gLa3zWon0jtzImiGeu92PxoIkxKzpoaMONLOghw==
X-Received: by 2002:a17:906:db06:b0:a86:a481:248c with SMTP id a640c23a62f3a-a89a35a0a09mr1267444666b.19.1725472270276;
        Wed, 04 Sep 2024 10:51:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB8IC0UdlIJ+hJ0d9y5+/CBU4kSUxb8RZ30hHavApi1zOjLggaKC+EPD9xD4iWA/K0Gqc1Cg==
X-Received: by 2002:a17:906:db06:b0:a86:a481:248c with SMTP id a640c23a62f3a-a89a35a0a09mr1267442366b.19.1725472269741;
        Wed, 04 Sep 2024 10:51:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d26esm18871966b.140.2024.09.04.10.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 10:51:09 -0700 (PDT)
Message-ID: <d45d47dd-8a8c-4a70-a65b-eeb7bd815f8c@redhat.com>
Date: Wed, 4 Sep 2024 19:51:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] Documentation: admin-guide: pm: Add efficiency vs.
 latency tradeoff to uncore documentation
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Tero Kristo <tero.kristo@linux.intel.com>
Cc: srinivas.pandruvada@linux.intel.com, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240828153657.1296410-1-tero.kristo@linux.intel.com>
 <20240828153657.1296410-2-tero.kristo@linux.intel.com>
 <d4939d77-8fab-f4b6-f1f7-4af05951d3eb@linux.intel.com>
 <e1d7028e69cb226acf30ed5c316e5fea20546bc4.camel@linux.intel.com>
 <71e6475c99e193c4ae6e5d45b72b528cdf5f3f62.camel@linux.intel.com>
 <858a908e-8218-3925-ea06-f3da256110e9@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <858a908e-8218-3925-ea06-f3da256110e9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/30/24 12:12 PM, Ilpo Järvinen wrote:
> On Fri, 30 Aug 2024, Tero Kristo wrote:
> 
>>    1. On Thu, 2024-08-29 at 14:39 +0300, Tero Kristo wrote:
>>> On Thu, 2024-08-29 at 12:18 +0300, Ilpo Järvinen wrote:
>>>> On Wed, 28 Aug 2024, Tero Kristo wrote:
>>>>
>>>>> Added documentation about the functionality of efficiency vs.
>>>>> latency tradeoff
>>>>> control in intel Xeon processors, and how this is configured via
>>>>> sysfs.
>>>>>
>>>>> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
>>>>> ---
>>>>> v2:
>>>>>   * Largely re-wrote the documentation
>>>>>
>>>>>  .../pm/intel_uncore_frequency_scaling.rst     | 59
>>>>> +++++++++++++++++++
>>>>>  1 file changed, 59 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/admin-
>>>>> guide/pm/intel_uncore_frequency_scaling.rst
>>>>> b/Documentation/admin-
>>>>> guide/pm/intel_uncore_frequency_scaling.rst
>>>>> index 5ab3440e6cee..26ded32b06f5 100644
>>>>> --- a/Documentation/admin-
>>>>> guide/pm/intel_uncore_frequency_scaling.rst
>>>>> +++ b/Documentation/admin-
>>>>> guide/pm/intel_uncore_frequency_scaling.rst
>>>>> @@ -113,3 +113,62 @@ to apply at each uncore* level.
>>>>>  
>>>>>  Support for "current_freq_khz" is available only at each fabric
>>>>> cluster
>>>>>  level (i.e., in uncore* directory).
>>>>> +
>>>>> +Efficiency vs. Latency Tradeoff
>>>>> +-------------------------------
>>>>> +
>>>>> +The Efficiency Latency Control (ELC) feature improves
>>>>> performance
>>>>> +per watt. With this feature hardware power management algorithms
>>>>> +optimize trade-off between latency and power consumption. For
>>>>> some
>>>>> +latency sensitive workloads further tuning can be done by SW to
>>>>> +get desired performance.
>>>>> +
>>>>> +The hardware monitors the average CPU utilization across all
>>>>> cores
>>>>> +in a power domain at regular intervals and decides an uncore
>>>>> frequency.
>>>>> +While this may result in the best performance per watt, workload
>>>>> may be
>>>>> +expecting higher performance at the expense of power. Consider
>>>>> an
>>>>> +application that intermittently wakes up to perform memory reads
>>>>> on an
>>>>> +otherwise idle system. In such cases, if hardware lowers uncore
>>>>> +frequency, then there may be delay in ramp up of frequency to
>>>>> meet
>>>>> +target performance.
>>>>> +
>>>>> +The ELC control defines some parameters which can be changed
>>>>> from
>>>>> SW.
>>>>> +If the average CPU utilization is below a user defined threshold
>>>>> +(elc_low_threshold_percent attribute below), the user defined
>>>>> uncore
>>>>> +frequency floor frequency will be used (elc_floor_freq_khz
>>>>> attribute
>>>>
>>>> Consider the following simplification:
>>>>
>>>> "the user defined uncore frequency floor frequency" ->
>>>> "the user-defined uncore floor frequency"
>>>>
>>>> I think it tells the same even without that first "frequency".
>>>>
>>>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>>
>>>
>>> Yeah, it looks kind of silly. I think that's just a typo from my
>>> side,
>>> thanks for catching.
>>
>> Do you want me to send a new version of this patch or do you fix it
>> locally? Rest of the patches don't seem to need any changes atm.
> 
> That's up to Hans but that looks trivial change so probably he can fix
> that while applying.
> 
> Hans, v2 of this series seems ready to go (with the small change into
> the documentation patch as discussed above).

Ack, I've applied the series to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

with the suggested improvement to intel_uncore_frequency_scaling.rst
sqaushed in.

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans





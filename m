Return-Path: <linux-kernel+bounces-327223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA3097728B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3501F23773
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6977B1C0DEA;
	Thu, 12 Sep 2024 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ERdrurjv"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A81A3052
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726171433; cv=none; b=f1IFPEkHyiGv1ZyXBsrRj2yKAp8weq/m1Zu7QSvJTVT11tRlp9OeVK5EWRvlJAMLqXXA1TvWYWNjp1F9A2m6xtkWUl0Xu3k/IJn/ZgAasc0P3NEEvQ0xntXX22oPAaYmxiLP6HFE2ahEonIjALExwKDjUHs8ds5z7oEJks5+g/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726171433; c=relaxed/simple;
	bh=Z5N0iDAv7oS2kzYBkNiUHqo7E1DaTd02v/B+mHVEyBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWg573CLBRyv5mO2OXQDbta2gHrDzXkhWSEbIhWvR1nWNZ1jRQT61IM7M8wx8ucMn84FWUKG0kPaG2G2NFzVogiHVOPsMeI7Js1Jed0ddeGd5/gr3WcNd23mBFuRsBbZ4amtqyW0KH9UAYLxAsK+U3rfox0lz9eyuFPbogPzS8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ERdrurjv; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82521c46feaso7261939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726171431; x=1726776231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ZUw7ImOz/xW0/vF8QPIU2FDaMoIZ6FEl1tTbL5Zu9c=;
        b=ERdrurjvJQOd9bLbI3Z66F985Yj+84zy50A5qvxTumF8efXTbCQA85XxMD0LruEewI
         SY2clBeNfVCD5N4+1PUOMMYDNJxmCz4HJ/NLTD6Sn7rc+jKO5eZR7ctP9R5i9ZZFthgI
         UwXO0brYLo50wgrAXRup86LHuhIiNpTUv7cVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726171431; x=1726776231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZUw7ImOz/xW0/vF8QPIU2FDaMoIZ6FEl1tTbL5Zu9c=;
        b=EWAQKfkat73YoqebEuV22xevHEaE/bdJeF9Ic64suamCVFtEO4OZBK3pHzfH0EptSf
         wetuzuJVqyK43oSjjGVlrj343DoX7mQ7Tk0OEe8w9dHk1LP9p9/M0P7eLa+YhytyfBCp
         fhL8ojthK2wsr09t0ZKxqS5HBZmzQnSBzsg7La2qvLFFAA1r8iKZOltCmwE/F1OGyXc7
         FT9xdUXECD8aI1Dj4NOjJXENCXwqv2UyAynTvaROmdvXl4nDG9WNoQxwzDImz2SgbtRj
         BEIGx02hbRU3DqRlDZabKTjrONGV7IK3hhav895vZY0ho4mT0cvNkrfs6Mnm87sV93qw
         7wFg==
X-Forwarded-Encrypted: i=1; AJvYcCW/A4HIEC+J+Vp0N0LfO3hkiCTaJYs3UlHw9us1CHowISqdV66lbQvvp3wRjuCR4+Jkgkg6TwQ4MEMe2p4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5cAiHQCK9njjJmkuGUzZ0eym5qroaNBtzRKwe7ScnkcgY0hmh
	PmsEjWVkUScexKyAd4n4mbtsL1WJ9ixeUDJo//7IX8Hk2Nla+DEPcut6l8slttI=
X-Google-Smtp-Source: AGHT+IHroUZ0nDZDhbbhK4odPskHEvFmnGVJNutX2nw+ZRszt1sOQ+0M+D/Yf225WpVv4rad/FDvxg==
X-Received: by 2002:a05:6602:6c13:b0:82a:a76a:1779 with SMTP id ca18e2360f4ac-82d376d86a4mr91464739f.8.1726171430823;
        Thu, 12 Sep 2024 13:03:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f433d4asm774136173.17.2024.09.12.13.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 13:03:49 -0700 (PDT)
Message-ID: <b64402ad-4c0d-4f5f-939b-4be1a7855e4a@linuxfoundation.org>
Date: Thu, 12 Sep 2024 14:03:49 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH for-next] pm: cpupower: rename raw_pylibcpupower.i
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: Min-Hua Chen <minhuadotchen@gmail.com>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240912125030.19809-1-minhuadotchen@gmail.com>
 <5785527a-b259-42ba-989e-978d2e72ff35@linuxfoundation.org>
 <ZuMmqAmr62ErjqHc@rhfedora>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZuMmqAmr62ErjqHc@rhfedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 11:36, John B. Wyatt IV wrote:
> On Thu, Sep 12, 2024 at 10:31:19AM -0600, Shuah Khan wrote:
>> On 9/12/24 06:50, Min-Hua Chen wrote:
>>> This RFC patch is actually bug report. All *.i file will be
>>> removed by 'make mrproper', including raw_pylibcpupower.i, added
>>> by commit: 338f490e07bc ("pm:cpupower: Add SWIG bindings files for libcpupower")
>>>
>>> We can reproduce the error by performing the following command:
>>> cd linux-next
>>> make mrproper
>>> cd tools/power/cpupower/bindings/python
>>> make
>>>
>>> We will get an error message:
>>> make: *** No rule to make target 'raw_pylibcpupower.i', needed by 'raw_pylibcpupower_wrap.c'.  Stop.
>>>
>>> Renaming the raw_pylibcpupower.i is just a workaround to fix the
>>> issue above.
>>
>> I need a non-rfc patch for this. Please send a proper patch
>> I can pull in once John has a chance to review this.
> 

How and when is raw_pylibcpupower.i generated? This looks
like a pre-processor output.


> I have reviewed and tested and this. I am good with it being a stopgap.

I am okay with the stopgap, but I do want i explore other solutions.
> 
> Please send the non-rfc patch.
> 
> Thank you for reporting and sending a patch for this Min-Hua.
> 
> Reviewed-by: John B. Wyatt IV <jwyatt@redhat.com>
> Reviewed-by: John B. Wyatt IV <sageofredondo@gmail.com>
> Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
> Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>
> 

thanks,
-- Shuah



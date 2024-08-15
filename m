Return-Path: <linux-kernel+bounces-287789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D91952C96
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F591F22435
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15FB1D6180;
	Thu, 15 Aug 2024 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGEXCUWx"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE217CA1D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716974; cv=none; b=dJCV174/grdbSMuAH6O0Blnf1hRAczH/tnWYVhB5v712s/Q4NBTvBZEd0Q2W0K/Z0IO3JE+mN+AxHbE1ad/zeCqd3+4pwnStB+tX7L3y4jZqYrIRIrEfzapum315PeXcSHTHzWu2kN4KzypC6H48M/k7txnxz20EqnkyN+D1qp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716974; c=relaxed/simple;
	bh=brdrfssP6NoibHycHfRdkx5WDwfgw0nInqTWPDmxMjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaWk2nnjqkLQAA9rcrS6xPU0JL123n0+eSns0eSINybnw9c08zdTuOQBaILsMl9g7slTHFIh2qdt85iTrcUoyMowgJg0zfi6IAKVYCWzwHjZQsVDFyOR/3gQ+XphlM7wDQCjbYGPhDeHcZYWhM8JE5lAkOHckqxFusIZlvaKJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGEXCUWx; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e1168e93d47so57789276.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723716972; x=1724321772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dk0RzEuRrIry4pt+1z6GnZtGL+Y5YP1YwXQekbzb/aI=;
        b=JGEXCUWxLSAA8F5n1QFpuKlNr0XxwIa3H0bvPYoUuq/71flDjHLyTZZP2/A6q+74RB
         l/DJ6PTKM+b8UW5jPI0O/H6a8YqNkrpmAvOIiD+d9EOzntk8wj0wZlz9Te81YVdNIil5
         YBx3P8W3lbsyRPYKWO7jrgLJKYdnH4ma1ndH3hlO8JRR7/G42dOIwJIlyOmIVWl0yChb
         zbY7KV5Q545ia36IGRmJgaX+N62X47g3ijWwUSufxlRm3IiayQLWeof/HOcyMzgu/PBu
         SUPXF0W/tThRx1V5UQkX/Bd/HeTPsbZ9uAP3MkG2FxLLQEo+vMYMMiZxxu4txh7D5IJ2
         Lt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723716972; x=1724321772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dk0RzEuRrIry4pt+1z6GnZtGL+Y5YP1YwXQekbzb/aI=;
        b=su/tLe5kaI0D28DBTsFmFw/6i2wM+09ZDQW9ZlmZ5qnUZwZfKgYq0clu7JhtdsdJ2h
         6bwm6chY3B9FhFy2vvvQmnjaGx6mY8DtzDAosTyF6Y8tkduqv+PH7+IcE5Yvpu8jUTpG
         kaox+BjdbpZh92gNsQRsoIqDyuKdBvFopuTBrJcioEe1lrcIjd3ZubhFoVYWsso9pq1T
         nscWu3Eza43uOd5ofPKxhR0fAz/3hLEOC6Ys1PETbgprDczX7ujbUy3kw6SZXsYp5qlj
         WMiIlMMpdQTWnCLXy7rjO7v3nzcAgeoEuNfCbdzsdWCPF4SaB1IZvOTe2nRQUZjOJIFC
         mn0A==
X-Forwarded-Encrypted: i=1; AJvYcCUraGRagakI6YgDgMoqw6Nnj7AlJSNcFtyguKFai2oPlMfI+68QJ2i1HZtzmmRZQeNtuHA1pjjXxL14l9s+Oc2MblZyVcpvUZLIwXAl
X-Gm-Message-State: AOJu0YzdkTzUxehJIzGCTvoYUb4ALFkz9JB9mysTr+WjygB9LgD63tC9
	Nyf3whmqeq7kj75eX1s6WJlhcZJTY62NodEcL54sni+/lPzEvAgF
X-Google-Smtp-Source: AGHT+IEJtY86VaQnS91aLteL9eTiKsZ1fMg4UghTu4ArIOyJEBUlJ/0j6Uc7i6PhOl1j5nBTrp04JA==
X-Received: by 2002:a05:6902:2745:b0:e0b:b5e6:68cc with SMTP id 3f1490d57ef6-e116eed7b7amr934817276.2.1723716971734;
        Thu, 15 Aug 2024 03:16:11 -0700 (PDT)
Received: from ?IPV6:2604:2d80:4022:0:9007:a741:5566:7d2e? ([2604:2d80:4022:0:9007:a741:5566:7d2e])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1171e09efdsm237318276.7.2024.08.15.03.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 03:16:11 -0700 (PDT)
Message-ID: <9758e4bb-fe54-4659-9348-df0d404af35b@gmail.com>
Date: Thu, 15 Aug 2024 05:16:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] misc: fastrpc: Restrict untrusted app to attach to
 privileged PD
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ekansh Gupta <quic_ekangupt@quicinc.com>, stable <stable@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
 <20240628114501.14310-7-srinivas.kandagatla@linaro.org>
 <9a9f5646-a554-4b65-8122-d212bb665c81@umsystem.edu>
 <2024081535-unfasten-afloat-9684@gregkh>
 <362eea30-7b6d-4cd5-aed9-88c0d014dd91@gmail.com>
 <2024081513-aware-tutor-e119@gregkh>
 <2024081531-vision-broadness-daca@gregkh>
Content-Language: en-US
From: Joel Selvaraj <joelselvaraj.oss@gmail.com>
In-Reply-To: <2024081531-vision-broadness-daca@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 05:02, gregkh@linuxfoundation.org wrote:
> On Thu, Aug 15, 2024 at 10:41:15AM +0200, gregkh@linuxfoundation.org wrote:
>> On Thu, Aug 15, 2024 at 03:35:13AM -0500, Joel Selvaraj wrote:
>>> Hi greg k-h,
>>>
>>> The git commit id is: bab2f5e8fd5d2f759db26b78d9db57412888f187
>>>
>>> But I am bit hesitant if we should revert it because there is a CVE attached
>>> to it: https://ubuntu.com/security/CVE-2024-41024
>>
>> Not an issue if it is breaking things, let's get it right.  We can
>> trivially reject that CVE if needed.
>>
>>> Also, I am ok with changing userspace if it's necessary. It would be nice if
>>> the authors can clarify the ideal fix here.
>>
>> No, userspace should not break, that's not ok at all.  I'll get someone
>> to revert this later today, thanks!
> 
> Now sent:
> 	https://lore.kernel.org/r/20240815094920.8242-1-griffin@kroah.com
> 
> I'll queue this up later today.

Thanks!
Joel Selvaraj

> thanks,
> 
> greg k-h



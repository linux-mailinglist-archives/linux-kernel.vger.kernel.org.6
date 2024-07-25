Return-Path: <linux-kernel+bounces-262418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED92193C6D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40E81F22972
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8508619D8BB;
	Thu, 25 Jul 2024 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N6ihvnkY"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249F19D087
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922744; cv=none; b=D6Xvd+GcCOBCKKhF3ZY3JoHZlsCJoP2GWdbarZTVeOeG7lVaRaJA8S+1bIgXM3QLDHewNHXdptNGnhLaLdicXI8qHDvbWTFrXNAhYhQDmWAAvbw86dQjZ2a56DhKoGmodFsupA7xSh1sVF/G+utedf9mV3fKb0g7rqacCyTyB4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922744; c=relaxed/simple;
	bh=mo7q2/uoC4GEhq90NIoOuGRylVoOtZelBxC1FagUlWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQZOqao5osC7rOQeyrndvP3In+vhxnROPzPIaUyvMHrjm4F6ZlTnjZre+GmGat65mqbt/Snh0pPN3K3VCwLCo3K6RNcV8uFd9JMoLdQ6RcNPnLV0RKksSzLv9PNsZ8btm0KLWaYwoYLOiN3pFiTTSRF2NcTzoJqyLJXakKZXmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N6ihvnkY; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-804cba4c8a8so2122539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721922742; x=1722527542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S/JqN+pHcExrSb356L3vtrB44/14O6YEZAAfNBlaK60=;
        b=N6ihvnkY4Am59VPON1UN6LEMi24lWBE5RJJWPIFDlYZSFK1Yb8TrB9RAk+si5NwnEm
         TYfv71WxMUFC2K+/Sj52QIrktwCao72aJXxaJr9wJcXF+ywVXGtT6gd1kTEUTmK8dKXr
         GxStFdjaGWjyT5sZqAxe3Kl3CRRofwxvT43Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721922742; x=1722527542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/JqN+pHcExrSb356L3vtrB44/14O6YEZAAfNBlaK60=;
        b=w0BZcOamYiay1auGJYUfkEuQYDYkVxrlEaq9hmVPYwfRQfFE1HEMWQGsBc2BI6KWbm
         +SrM4ZO8vnjtoRGF6NHK8Xk5xyK8k+EvmKH7zTh8bKPFduqZLyjScz/zIwPWeGIGvMuM
         P64i4XZJm8odIHWi7yrnN4q11jaxAhS2x+G5uYSDXMXKZv8g9JQ9hI6ND6SQN9QE3XxG
         gp3jURVMj3o4VoVuYPZLHuKzcbWw1Piae272EDJ8gxYEuEY4s7cHHMNK5OCljlFy5mPp
         Ob0jzXipVdsMFM/i2e5EUkCBySQnf2pFBngWOUGE3MfKbmvsVo5EEQUGfK8qMzaB+vbo
         Qhug==
X-Forwarded-Encrypted: i=1; AJvYcCU+cN7yoY6+K9PD2V/RdI8GitHNcYiUinMR+bDlujWOD+jlAhkmwx12UmscvcLsOrGZdirWscAuGxDCxnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu1K7c0aB4HUNUnbHJnMczIE+zy5A0h+0qsftfTDD0x/hZwWIB
	IWPxVNg7QwnbJpIhjkdOB1PEy71a+YSpRtjexZB80EH9BS59aAA1/7q45DRXgHU=
X-Google-Smtp-Source: AGHT+IEqVp/oG+/InFGTAhbwWhUAvE4/fcFF2CC3JSSKpBgRYqaeQfyRqJFHexKt4gYsGUq+GQmjdA==
X-Received: by 2002:a5e:df47:0:b0:7f3:9dd3:15b2 with SMTP id ca18e2360f4ac-81f7cf031bbmr207094739f.0.1721922742449;
        Thu, 25 Jul 2024 08:52:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fa43ec2sm392272173.11.2024.07.25.08.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 08:52:22 -0700 (PDT)
Message-ID: <5339a20c-86e4-4829-bad2-2b998c184523@linuxfoundation.org>
Date: Thu, 25 Jul 2024 09:52:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kselftest: cpufreq: Add RTC wakeup alarm
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Shreeya Patel <shreeya.patel@collabora.com>
Cc: rafael@kernel.org, shuah@kernel.org, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240715192634.19272-1-shreeya.patel@collabora.com>
 <20240725035742.uahab5uf2kmv476g@vireshk-i7>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725035742.uahab5uf2kmv476g@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/24 21:57, Viresh Kumar wrote:
> On 16-07-24, 00:56, Shreeya Patel wrote:
>> Add RTC wakeup alarm for devices to resume after specific time interval.
>> This improvement in the test will help in enabling this test
>> in the CI systems and will eliminate the need of manual intervention
>> for resuming back the devices after suspend/hibernation.
>>
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>> ---
>>
>> Changes in v2
>>    - Use rtcwake utility instead of sysfs for setting up
>> a RTC wakeup alarm
>>
>>   tools/testing/selftests/cpufreq/cpufreq.sh | 15 +++++++++++++++
>>   tools/testing/selftests/cpufreq/main.sh    | 13 ++++++++++++-
>>   2 files changed, 27 insertions(+), 1 deletion(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Thank you. I will apply this once merge window closes.

thanks,
-- Shuah


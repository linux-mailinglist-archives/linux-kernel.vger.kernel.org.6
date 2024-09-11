Return-Path: <linux-kernel+bounces-325330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF109757EE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12F22831D9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0AE1ABEC0;
	Wed, 11 Sep 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M6teSROF"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD50185927
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070729; cv=none; b=hCo/8v8s4V+duvtXnaqKM7w9QPmy9BRDD/AygaeIGzuAN5HgZSf+6dBGw9c8FpgmFAk+jXLs6m51nvds1zXJTfGLK0zLLBbTlIgf0uBjsSWNT8Sb+QmgmFQ4QZfwf5QN9S9O0J5Y9hqa6G1tbnBw/WbmZ2q9lobBToZPiCW2jEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070729; c=relaxed/simple;
	bh=vVZnPoaE4LggcEZLAPIaQZAUImydt4yJz2th7TcSAng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYte6hZcUr9vBzEFmI3vU7rpUegppj4Luq7gQT/zsT+dKsvOKXPIcqa8zm2sH5FQZOyTOHptLCRwlP640R/0VCpFB12YvjMh+DNlaWuX2c8wnLKy/AMps9RjAbxWrtX/dqTETJXD4dUCSLjnZe2WYFKkilN7+DHC57fh7knrTcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M6teSROF; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82ceab75c05so172112839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726070727; x=1726675527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5Iw9687spOPNQCPbJFKxHUyq06TwqtAPtEJ5vZKod8=;
        b=M6teSROFNydjTBzX58tX+cL6vELBY8AUooloRjYO1frbc0Yvb852U6rxJs3v1uOtjl
         4wXU/wx0bc+FITuU7fOg7TbrtXU0oLtNigAG1PeYxoDvPubS0ig9IB0CZxJePbRSUqnw
         ZrPeHdJQ6s/L1hChXNbapujx+5cZdeS8crK5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070727; x=1726675527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5Iw9687spOPNQCPbJFKxHUyq06TwqtAPtEJ5vZKod8=;
        b=PxUs5YL9tSIQa/LQoA3tvMElAZPT/Z+nWNjSpSmxrHAma0B7jN5Y1kTLTR0k1mNrh1
         JWAtTARfkiD0iXiNmG1KIN3rD03YADl/hnzuAuf6XcVpy8PSkfB6myCw1ucPZwMlxQhW
         kB3mWRNFcwUbS3k3oSuWHpg5HIYh+LfX1mshNXO7ZK6OmE+BIjss8uFR1R9rNfijpSIQ
         672KpLNNgMQReoEAQW4H6h/i2R2DQc0xhL3TjMglZPuQDoD1H42tL+WCz9sdrCsqITjb
         qMV9D2AjwYawuA/B5w0zPcH4P2w3FskUdkk8D8a8qjgBadpqDi6zORgiv6CRVR9Yat+O
         S+MA==
X-Forwarded-Encrypted: i=1; AJvYcCX1MOjdDIFE4hb8SmOA0EBvI6cN9gj4p4uYgJNo5KIhTnD+V07Oy513J8jZG+aEi2QLJU+wxXulEYtX7TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcY721tZ+M0bMgDxRkGt0Qc9lAEm20NT3w77bXccVrY1jWcOsB
	3Q8gbVJTu0vXy8ab0HDCeWcwz9LjOCfj8LEr8NJMDvOuuRkOSqTUzGz9oxm/S+M=
X-Google-Smtp-Source: AGHT+IGEh7vjg7kq8R20aGT4OVcirpJB3SMMzymLEMZ/gLxeZmcW+d+B8YzJGPUgnDl45eazKCfULw==
X-Received: by 2002:a05:6e02:174b:b0:39b:640e:c5fa with SMTP id e9e14a558f8ab-3a04f0ce28cmr207759325ab.19.1726070727091;
        Wed, 11 Sep 2024 09:05:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f8da6e4sm54775173.124.2024.09.11.09.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 09:05:26 -0700 (PDT)
Message-ID: <67cac093-e50c-44d7-8cdf-16b6624765ee@linuxfoundation.org>
Date: Wed, 11 Sep 2024 10:05:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/2] ring-buffer/selftest: Verify the entire
 meta-page padding
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@android.com, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910162335.2993310-1-vdonnefort@google.com>
 <20240910162335.2993310-2-vdonnefort@google.com>
 <20240910124541.23426cee@gandalf.local.home>
 <14143861-bc16-47f4-ba8d-7d577e7a9dd0@linuxfoundation.org>
 <ZuFMK7yndArZo4pA@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZuFMK7yndArZo4pA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 01:52, Vincent Donnefort wrote:
> On Tue, Sep 10, 2024 at 12:49:58PM -0600, Shuah Khan wrote:
>> On 9/10/24 10:45, Steven Rostedt wrote:
>>>
>>> Shuah,
>>>
>>> Can you take this through your tree?
>>>
>>> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
>> I can take this through my tree.
>>
>>>
>>> -- Steve
>>>
>>>
>>> On Tue, 10 Sep 2024 17:23:34 +0100
>>> Vincent Donnefort <vdonnefort@google.com> wrote:
>>>
>>>> Improve the ring-buffer meta-page test coverage by checking for the
>>>> entire padding region to be 0 instead of just looking at the first 4
>>>> bytes.
>>>>
>>>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>>>> Cc: linux-kselftest@vger.kernel.org
>>>> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
>>
>> Vincent,
>>
>> Can you please rebase these on linux-kselftest next branch and
>> resend.  This patch doesn't apply.
>>
>> Also please fix the subject to say:
>>
>> selfttests/ring-buffer
> 
> Will do, but it depends linux-trace/ring-buffer/for-next which hasn't make it
> yet to linux-next.

In which case it has to go through tracing tree.

Steve, This is yours to take due to the dependency on linux-trace/ring-buffer/for-next

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah



Return-Path: <linux-kernel+bounces-249798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749F392EFFA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B42282F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA2519E825;
	Thu, 11 Jul 2024 19:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LcS4W0Ju"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ED516D321
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720727621; cv=none; b=RvU+uG1EKItqYZHVQaQh1YBbGUlHP4G4rRMkVzkgoXsdhiQKX4tCdMoJKuy6jG5nWow8RqkiU+IqVb2TD7RG9LW4wpsd0dreJv+p1Y1wBO7B3i+0sILhXQIyJkeh4zA2iFcfZrfVptC8kpu/5+MT8bkpZPm5oCpcc6Vt96rg87w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720727621; c=relaxed/simple;
	bh=AQRPgY7Ta8/25Ij5rCjtyYOD71SttvMXsarPss3wXYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpTR25TRIBJYQwTqAgW4H70jXbe248L96nQYLoNkag6BYLTGbqXHdS4jWM6w53BgtZBvf9nXxi9PsIE9JN9/1QmWjicXzoavaU4XMgRgmbMrETMXw3W2YAYfBg5Z9na35G9Ki2nHg8RdiUgEBA38+hWEuKhHPoi2C5Lx7ZjgY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LcS4W0Ju; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-804bc63afe2so5103339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720727618; x=1721332418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h7yeQY6SPtfR9A82LK11qYfHKg0VfLZL3MuMX9OJe1U=;
        b=LcS4W0JuDtjwdqEs8sF6QaGm7AQ04gojUPfoc/+Ydqc00+yXiSXzUHGcPdP0rgy86h
         He6FNZUUkwYoOESC22TECAYZLASxYAJXYiBD1omdRR6UD/0A4pSwgaG1f4hWjXgf4SO4
         ipjxj2Trvo+4tEk5IsJYriZYf1+FAKAlQ9sjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720727618; x=1721332418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7yeQY6SPtfR9A82LK11qYfHKg0VfLZL3MuMX9OJe1U=;
        b=SQUQkrA2IN7Y8EhMHsBugBX0XodbeLS+3kmhADywCQJD5uOHVSbTdF/bPY2xRp1Dwx
         wMEpLrEE7vdvIFd+d1ywvzpYHAexGm7HRyhJxz9Katk57CrRW2pT4ACxHN+5gpZpqbKe
         KKa1xWN9FYLDBcEltrhfDCgjaElbmVkQOB3W7b6txwVszXVL/dxIlTOgQAJPiO5ehPd2
         Y0Ugdi684R8wV5smdOmTZEqFwN2fJn5YaSTc9b8iggI3ovETVUYn5kBANX2d53T4yS5w
         TJ4vdZiwHIxw+1cTMEF+F20/adgmur2OrobDJqWz7GIE//F9/mupVq+akuzMa+ZscJ7l
         i4WA==
X-Forwarded-Encrypted: i=1; AJvYcCUeXcQAOtWktWV9xoa775q+8HNcnJ1Imz5vxNe6+hH0UppwfPWX7DpirFTZks8tWqBDUWXJM9PpbJtDFjhem7aN2CQrCDjNF2pkF0BI
X-Gm-Message-State: AOJu0YxKkxn3nWOFz+RuRo0PheZbhXJFv3uwU/BmI1LdA7k9pQTF9fwZ
	mPmRyWm74KOx61VOdY0A7/xfbG6vaD6yhtTrrbA9oTtEG+imoaocRhHMO+RQTH0=
X-Google-Smtp-Source: AGHT+IFrG6tcF3V+I0JwNgxdIK+071GY/2J/P0ieFHoPCC6LxFJ7MDumSBYvlTHYtzu5FY4n8WO7Ag==
X-Received: by 2002:a5d:9c12:0:b0:7f9:3fd9:cbd with SMTP id ca18e2360f4ac-7fff92c5c33mr837862539f.0.1720727618527;
        Thu, 11 Jul 2024 12:53:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1c2b576sm1991316173.177.2024.07.11.12.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 12:53:38 -0700 (PDT)
Message-ID: <e1e32c72-6bd3-4c15-b301-c5670690ba99@linuxfoundation.org>
Date: Thu, 11 Jul 2024 13:53:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] kselftest: Add test to report device log errors
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernelci@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20240705-dev-err-log-selftest-v2-0-163b9cd7b3c1@collabora.com>
 <2024071003-islamist-expediter-a22c@gregkh>
 <71c479fb-cd25-45ec-8dd3-0521ef951f58@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <71c479fb-cd25-45ec-8dd3-0521ef951f58@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/10/24 15:49, Shuah Khan wrote:
> On 7/10/24 07:11, Greg Kroah-Hartman wrote:
>> On Fri, Jul 05, 2024 at 07:29:53PM -0400, Nícolas F. R. A. Prado wrote:
>>> Log errors are the most widely used mechanism for reporting issues in
>>> the kernel. When an error is logged using the device helpers, eg
>>> dev_err(), it gets metadata attached that identifies the subsystem and
>>> device where the message is coming from. This series makes use of that
>>> metadata in a new test to report which devices logged errors.
>>>
>>> The first two patches move a test and a helper script to keep things
>>> organized before this new test is added in the third patch.
>>>
>>> It is expected that there might be many false-positive error messages
>>> throughout the drivers code which will be reported by this test. By
>>> having this test in the first place and working through the results we
>>> can address those occurrences by adjusting the loglevel of the messages
>>> that turn out to not be real errors that require the user's attention.
>>> It will also motivate additional error messages to be introduced in the
>>> code to detect real errors where they turn out to be missing, since
>>> it will be possible to detect said issues automatically.
>>>
>>> As an example, below you can see the test result for
>>> mt8192-asurada-spherion. The single standing issue has been investigated
>>> and will be addressed in an EC firmware update [1]:
>>>
>>> TAP version 13
>>> 1..1
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `model_name' property: -6
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `energy_full_design' property: -6
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>>   power_supply sbs-8-000b: driver failed to report `time_to_empty_now' property: -5
>>> not ok 1 +power_supply:sbs-8-000b
>>>   Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
>>>
>>> [1] https://lore.kernel.org/all/cf4d8131-4b63-4c7a-9f27-5a0847c656c4@notapiano
>>>
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Is this dependent on a linux-next?
> 
> Didn't apply to linux-kselftest next.
> 

I tried applying these on top of linux-kselftest next which is at
Linux 6.10-rc7 + other patches.

I am not sure what is wrong - first patch applies and the second
and third don't.

git am fails and manual patch application worked for 2/3, same thing
with 3.3 - these should apply cleanly since they don't have obvious
conflicts.

Please clean this up and send me updated series adding Greg's ack.

thanks,
-- Shuah





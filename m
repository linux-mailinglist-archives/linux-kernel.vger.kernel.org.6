Return-Path: <linux-kernel+bounces-269961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBAA943957
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF87E1F2217E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD99016DC31;
	Wed, 31 Jul 2024 23:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W1AQGcum"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF616D334
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722467991; cv=none; b=ERr1Bh7tLxRQXsJodvCOZpNpr+kLBE/T4qxWFdkhzeqAY5d3M2IXbhvcePmb3pxy83wavgbA/5Ce+Zg6ih00FNhsZarZYDNpsgm8+M1KS1z0aHagA3WnU7Kee2+p1dxLUqQ9k56wLGSF5QlBVvHMDVDPkHJacl3/44YPvt2j8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722467991; c=relaxed/simple;
	bh=4GwoRzclfzlo85zAvolfapd+CWdm9DU8Te+Ql1cnl+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRDCM0FmVYHulRPfyFIK27h/6Rct1KWMwzMuMJSsWGGk3JrcHRpxQhCzPBr0H7pe5xpfm/FRyCD2k1/DTr94MgmQjmjn6Die8t9uFEr468UwrWoqXaQmFFmpd8NNo1uZp0Q/AZpxxnrWsDn7FIHEp4BowblS5s0YmWDb5RjzLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W1AQGcum; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2644c1b07b1so794101fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722467987; x=1723072787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=etMvppMi7evDPjhbMsnAWhZBTxb0fCzMenZG1uh9MDE=;
        b=W1AQGcumAdhz6pJvWBBECkFBj7aecrDK8r8/UmUyktw2cCrDWTxj9usPq66vxcY0uz
         R2DJQOXm+7uZmyelMYs5IE4+1NbXHR1UYgLJ3eiO7GHCsElRhMh6oYbvkbxIoC6CdfRx
         ZOSePiErkenbM8MFWnOHmoxfwG90lYQoVBeXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722467987; x=1723072787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etMvppMi7evDPjhbMsnAWhZBTxb0fCzMenZG1uh9MDE=;
        b=uFNHsSYOaeZ/LsloafYFTgo3NhL0a53qKYHACBIg3G7LEUq8LET5vYKc8V7YT5W5FF
         CNWCPcNhAdCmmjvESdFu4iFPkdHw19iskITJAfk+a1ZdgYzoIzNTCXZmMtJL8+oadoUB
         Q49Hbx6a8Aj6B5BFlqcyuNmUzIF8SkV40QiPrYiJUJcXqZR8s/uz2new5+NabzvC2UOB
         d8B8IECtr37R3fXqsnD3kBAGMrV0dUNZSXM+cJ9RWvnhbNdctY9lMKzZGfewEUCXJGCY
         J1xJxtO5PdeVv5caYzg9boyHSsdTMxv2irv3mJ7AmGB1SYSAUCIuDoWs/aZrTlms9M75
         KQCg==
X-Forwarded-Encrypted: i=1; AJvYcCX+y5hvCzItrudQqgVRWrBnImHo8dH5wtUs6y4F2cy5RaO7K6SKuPwlHcNJdxe1WyijjYo1H31EhrQTZrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVe5+vhVWrx6UTjq4zrPH/G11u/uOvZtha6oyyRoVFon5yUlYT
	iXM+Z/WnkgNdSHTv4Tj+I3GMGCXCDcqW0ZO0I0JzyNzprOdMmq8oOPgHS0QJ5HA=
X-Google-Smtp-Source: AGHT+IGrdIeXgyWgztwjLDx8NrHnJ/zPFKpv/zS8lGiCJLsiszTxwKrySbmn38HXtASjPox9Bk+Ljw==
X-Received: by 2002:a05:6808:2205:b0:3db:42d0:7387 with SMTP id 5614622812f47-3db5122ed5cmr360052b6e.5.1722467986996;
        Wed, 31 Jul 2024 16:19:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db417ee4a9sm878004b6e.10.2024.07.31.16.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 16:19:46 -0700 (PDT)
Message-ID: <9d0b73ce-704c-4633-bb11-06ca4cb7a9a1@linuxfoundation.org>
Date: Wed, 31 Jul 2024 17:19:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] kselftest: devices: Add test to detect missing
 devices
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Shuah Khan <shuah@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Bird, Tim" <Tim.Bird@sony.com>, Laura Nao <laura.nao@collabora.com>,
 Saravana Kannan <saravanak@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 kernel@collabora.com, kernelci@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240724-kselftest-dev-exist-v1-1-9bc21aa761b5@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240724-kselftest-dev-exist-v1-1-9bc21aa761b5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/24/24 15:40, Nícolas F. R. A. Prado wrote:
> Introduce a new test to identify regressions causing devices to go
> missing on the system.
> 
> For each bus and class on the system the test checks the number of
> devices present against a reference file, which needs to have been
> generated by the program at a previous point on a known-good kernel, and
> if there are missing devices they are reported.

Can you elaborate on how to generate reference file? It isn't clear.

> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Hi,
> 
> Key points about this test:
> * Goal: Identify regressions causing devices to go missing on the system
> * Focus:
>    * Ease of maintenance: the reference file is generated programatically
>    * Minimum of false-positives: the script makes as few assumptions as possible
>      about the stability of device identifiers to ensure renames/refactors don't
>      trigger false-positives
> * How it works: For each bus and class on the system the test checks the number
>    of devices present against a reference file, which needs to have been
>    generated by the program at a previous point on a known-good kernel, and if
>    there are missing devices they are reported.
> * Comparison to other tests: It might be possible(*) to replace the discoverable
>    devices test [1] with this. The benefits of this test is that it's easier
>    to setup and maintain and has wider coverage of devices.
> 
> Additional detail:
> * Having more devices on the running system than the reference does not cause a
>    failure, but a warning is printed in that case to suggest that the reference
>    be updated.
> * Missing devices are detected per bus/class based on the number of devices.
>    When the test fails, the known metadata for each of the expected and detected
>    devices is printed and some simple similitarity comparison is done to suggest
>    the devices that are the most likely to be missing.
> * The proposed place to store the generated reference files is the
>    'platform-test-parameters' repository in KernelCI [2].

How would a user run this on their systems - do they need to access
this repository in KernelCI?

This is what I see when I run the test on my system:

make -C tools/testing/selftests/devices/exist/ run_tests
make: Entering directory '/linux/linux_6.11/tools/testing/selftests/devices/exist'
TAP version 13
1..1
# timeout set to 45
# selftests: devices/exist: exist.py
# TAP version 13
# # No matching reference file found (tried './LENOVO,20XH005JUS.yaml')
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: devices/exist: exist.py # exit=1
make: Leaving directory '/linux/linux_6.11/tools/testing/selftests/devices/exist'

thanks,
-- Shuah



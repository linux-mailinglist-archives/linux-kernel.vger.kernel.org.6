Return-Path: <linux-kernel+bounces-317971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AF296E690
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 01:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6B61C2309A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593961B86D1;
	Thu,  5 Sep 2024 23:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uj+ZTBRU"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0AD18EFF8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725580677; cv=none; b=NwlyoftPUsI4N6gk3u3qSPA7gS+TCfhHnQbImgHOt8G9KZiBxWze/CrhWDLua36LB20a5bV2EI6hQdo6q6+X1j6SHSAp2fGhhWiPp/Qvouh6Ytew51LR/s4UNhCIhRWmOCPrLKLtio+Gte9kxlpsO7dyGkLo36SBNjJbzLHq70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725580677; c=relaxed/simple;
	bh=vREP1gXy6kfNvH7zO3Q4yxdq99LwECE05jZKH30bfPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N46sPj0T2vU4jBVXpS/mewzLSgOuwN3dhFkS3L1Q5XOaD6xAaQn6WXRc7gGcqqMi9l/htY2IHoe38GYK/NHxxvLQWW1jLleVwZD3JCZ0uvAY8WhHYfsqhU7c9jgxKqVHUaO+/eknsmAGuaLtA4poHOERskcAQY45UeW6dAVh8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uj+ZTBRU; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7d50e7a3652so697168a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 16:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725580675; x=1726185475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zS1s+Zz6eeiQ6ponWFxj8RuA9Y1sHnZHqZ9NRyr9h3g=;
        b=Uj+ZTBRUVwnkpDluY3N8eBpwW+WiNy3j312LgozgSgMqKEu8iwElybYA6uJqQ1WgGH
         R5ADSpBNEvK5TNgG1kPMjwgwVpVbOAUQyU/cNCSVgPd14ZJq1oQDFGP3QX1/BdGkI8Wq
         MGGxXM3H0rPxDAxV6tq5f2LfFzdWL7t0HeyrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725580675; x=1726185475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zS1s+Zz6eeiQ6ponWFxj8RuA9Y1sHnZHqZ9NRyr9h3g=;
        b=XCX+0+s1AuGHeyWbc/A0SduQrJSAwwt8JPp0FPYPzVwD75mN3jOkCiPpBCL2LajdTM
         viXPZ5PQxuL+Yvcm/VbaM9bbLe6BjEys+N+vxm44vT3+MarmlqDyF2A4dZDSVTkBiaU8
         3vShm4Mc6EAm1zeSwfvqJBlQg6cBiV6NZ49nrahpFee12bI9a5hdVbsDUdCACQZRIBKZ
         V+K62vZ4Gk08gkpoLjyzIpay/gGAKMuK2KbuzxwHAtx/hjDSrM5Kxs8IHqYvQLc5ZVwl
         NtJ9+MUzqYNksLNbpf21KjJFukdJ2AK9zLyBxkoCQmEHLrXSouibRLzjhr14JD1PiEEU
         4sxg==
X-Forwarded-Encrypted: i=1; AJvYcCVLDTF1quxevPOuvVMReIwrokJmOyMM8RnWlS3qvRShVRTHkEK05CCfkzR/aubo+fRS171HjHf1UB6oJ+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvcDIzmYuUDajrnIHFYrnFtStHgtGl6sKX94UHUPv2aN3BfC/t
	7PsJduYC+patIH9sgqO76x+kBSptZ5UniGfG2QqLprXIWZjiZf5SZ7R//q9Eh9VfDIuAk7DhYWt
	k
X-Google-Smtp-Source: AGHT+IF4MesY89cUtiP5L2x/DJn7yC1CfZO0lABScFcLtfDIRyTBFjpVIYxclppvHySujBB0RHwCGw==
X-Received: by 2002:a05:6a21:7101:b0:1cc:dd58:e23b with SMTP id adf61e73a8af0-1cf1d05aaa1mr725091637.10.1725580674512;
        Thu, 05 Sep 2024 16:57:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae9131f2sm33885615ad.18.2024.09.05.16.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 16:57:53 -0700 (PDT)
Message-ID: <e36fb1f5-f370-4806-912e-d9d2f777a1bc@linuxfoundation.org>
Date: Thu, 5 Sep 2024 17:57:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nolibc for 6.12-rc1
To: Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <3b9df0a1-7400-4c91-846d-b9e28982a7c3@t-8ch.de>
 <9de5090f-038f-4d68-af96-fbb9ed45b901@linuxfoundation.org>
 <f882fa56-c198-4574-bb12-18337ac0927e@linuxfoundation.org>
 <9440397d-5077-460d-9c96-6487b8b0d923@t-8ch.de>
 <13169754-c8ea-4e9e-b062-81b253a07078@linuxfoundation.org>
 <e594db6c-5795-4038-bcb2-1dc3290bfb27@t-8ch.de> <ZtlOGkADy7OkXY9u@1wt.eu>
 <ZtlQbpgpn9OQOPyI@1wt.eu> <bcdba244-aaf9-4a06-a4a6-c521d4cfa97e@t-8ch.de>
 <Ztnd26IlnMwrywUO@1wt.eu>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Ztnd26IlnMwrywUO@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/5/24 10:35, Willy Tarreau wrote:
> On Thu, Sep 05, 2024 at 05:57:22PM +0200, Thomas Weißschuh wrote:
>> On 2024-09-05 08:32:14+0000, Willy Tarreau wrote:
>>> On Thu, Sep 05, 2024 at 08:22:18AM +0200, Willy Tarreau wrote:
>>>>>
>>>>> ./run-tests.sh -p -m user
>>>>>
>>>>> These toolchains can then also be used for direct "make" invocations
>>>>> through CROSS_COMPILE.
>>>>
>>>> I really suspect an empty CC variable somewhere that could explain why
>>>> only CROSS_COMPILE is used. I'll try to find time today to give it a
>>>> try here as well, just in case I can reproduce the same issue.
>>>
>>> In fact I'm getting it without any options:
>>>
>>>    $ ./run-tests.sh
>>>    realpath: /home/willy/.cache/crosstools/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-: No such file or directory
>>>
>>> It comes from here in test_arch():
>>>
>>>          cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
>>>
>>> Thus it's indeed related to the absence of the toolchain there. It's
>>> just that the way the error is reported (due to set -e) is a bit harsh.
>>
>> Ack. It should not occur with "-p" though.
> 
> Agreed, I was focusing on first experience for users essentially.
> 
>>> What about this ?
>>>
>>>    $ ./run-tests.sh
>>>    No toolchain found in /home/willy/.cache/crosstools/gcc-13.2.0-nolibc/i386-linux.
>>>    Did you install the toolchains or set the correct arch ? Rerun with -h for help.
>>>    Aborting...
>>>
>>> or anything similar, achieved by this patch (warning copy-paste, mangled
>>> indents):
>>>
>>> diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
>>> index e7ecda4ae796..0f67e80051dc 100755
>>> --- a/tools/testing/selftests/nolibc/run-tests.sh
>>> +++ b/tools/testing/selftests/nolibc/run-tests.sh
>>> @@ -143,6 +143,13 @@ test_arch() {
>>>          arch=$1
>>>          ct_arch=$(crosstool_arch "$arch")
>>>          ct_abi=$(crosstool_abi "$1")
>>> +
>>> +       if [ ! -d "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/." ]; then
>>> +               echo "No toolchain found in ${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}."
>>> +               echo "Did you install the toolchains or set the correct arch ? Rerun with -h for help."
>>> +               return 1
>>> +       fi
>>> +
>>>          cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
>>>          build_dir="${build_location}/${arch}"
>>>          if [ "$werror" -ne 0 ]; then
>>
>> Looks good.
> 
> OK thanks, I'll try to handle it this week-end if I'm not beaten to
> it. If you or Shuah want to merge it before, feel free to, no offense
> on my side!
> 

Sounds good. My system is back to a good state with the tests after running
./run-tests.sh -p -m user

My guess is my setup was lost when I upgraded my system.

thanks,
-- Shuah





Return-Path: <linux-kernel+bounces-321928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9471972153
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3878EB225DE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4CD17A586;
	Mon,  9 Sep 2024 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XVsCbqtC"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D8C1741EF
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904213; cv=none; b=M2NBzQB/iTobqFeswOt6ODX2EKfY6Ms5S+sRieq1ulP+rIdPapcB0JWkJWc9xdUkGfrynJUK924AXUdkjV2msQG+rjFbuTB/K69XBNcYhjFKSkz27WL5TXB+YTVrkXpQ2C3eOdCbBRc20cLt3jPrFjwJrR3XFQDjl2TziEB9BUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904213; c=relaxed/simple;
	bh=ABO6NbjkvsMRLlnJQN6mkI9X8LwjDGS7piWqqITe8Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItMMlb8K0FsC0imHacNae4xkjT1QLgY6PsemR617vwDIx4RxtN7gKB1i+Tt3Y1+WYVqt3NPgHIVqECqGh5R0AcFeJMtvDYd1AG1oOJvESmwzCdvM3chm0BOq89tMN67h0G/3utuDP/IFZ/u109lCPHbHlVkXNdr4jNo5zUIHNjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XVsCbqtC; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82ade877fbeso97181439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 10:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725904210; x=1726509010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9NV49eAw0EjDLUZ3ZdirHscgyRpQUf/hBPk7y24+G/k=;
        b=XVsCbqtC4NhlHoI0CzemWBoPAX4g57/3HAomEdtHK4yyncIT74CJGEdNpAKCwyvLBq
         F8Nk9f0rI7h1iVcKrrNFSJWYmRlrH6AS1024YoQO42fiB9hy9NAvkGplWnYU2TkOWsRA
         PokCB9slsMPD8FNRWzQnTgDAb5sZ7z4pxaOE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725904210; x=1726509010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NV49eAw0EjDLUZ3ZdirHscgyRpQUf/hBPk7y24+G/k=;
        b=IOAUzdC9Cn1QwlATvaj/TiecYNrxrGfOQVXdlE93x/xm7wUGTKd/MyOHPfzpIQdeQp
         qz1uW9WpHDlnruPmriiUquhRy8/dkRzJEazW3T8Ef3RfDG0XuEGqFUr213lsELHBP8k7
         dxUiX7QvpO00I0dHLz3OK1mAcaPAs2oVMndj5PBjPZQ2VbPF5+HYaDljy4ZFRUVLp2/n
         NUAelFmK6Y7Beim8jjfeLeQpP+t4SVcHvrcMp3IgGyIMTT8UUo8h/QI4MbxQpS4Fj2R4
         qJaA7MMQL4ny9ZZDuV6liFN0niHv1OQehY4DW5rHpZl9tNUrBN3GHpS5XI1oHJkpdSnU
         Lsuw==
X-Forwarded-Encrypted: i=1; AJvYcCXpTNg0Qa93FXBQznFhyrJzePLh6XrrfUV0Sv9WMSsv4uY7e8LA0trCR7WKkGH/D5TH0YqYgM+6Yo812cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw94KwcvZkBCiJ0xRB1B78QSvI8RxwfyDYeVqYEar3bmbrTQ6ae
	xZKv+8NUqkOUXF0arU0D7+PjEuvdjr7KHI0leODn/jhrHFWl72XVu6fZIZYpcGA=
X-Google-Smtp-Source: AGHT+IE8STMu/plMjIutpV6ltdcTsImCLOIZs48Yx0W0KpPVFxaKlyedvETfiMgcyF//kTBvqZmw7g==
X-Received: by 2002:a05:6602:6c09:b0:81f:8ae9:8f02 with SMTP id ca18e2360f4ac-82a96198c47mr1407238939f.5.1725904210467;
        Mon, 09 Sep 2024 10:50:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82aa736e108sm153995839f.24.2024.09.09.10.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 10:50:09 -0700 (PDT)
Message-ID: <62bd7bce-5bd8-4d10-89d9-958d7a8a1629@linuxfoundation.org>
Date: Mon, 9 Sep 2024 11:50:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nolibc for 6.12-rc1
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <9de5090f-038f-4d68-af96-fbb9ed45b901@linuxfoundation.org>
 <f882fa56-c198-4574-bb12-18337ac0927e@linuxfoundation.org>
 <9440397d-5077-460d-9c96-6487b8b0d923@t-8ch.de>
 <13169754-c8ea-4e9e-b062-81b253a07078@linuxfoundation.org>
 <e594db6c-5795-4038-bcb2-1dc3290bfb27@t-8ch.de> <ZtlOGkADy7OkXY9u@1wt.eu>
 <ZtlQbpgpn9OQOPyI@1wt.eu> <bcdba244-aaf9-4a06-a4a6-c521d4cfa97e@t-8ch.de>
 <Ztnd26IlnMwrywUO@1wt.eu>
 <e36fb1f5-f370-4806-912e-d9d2f777a1bc@linuxfoundation.org>
 <20240908102247.GA1175@1wt.eu>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240908102247.GA1175@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/8/24 04:22, Willy Tarreau wrote:
> On Thu, Sep 05, 2024 at 05:57:52PM -0600, Shuah Khan wrote:
>> On 9/5/24 10:35, Willy Tarreau wrote:
>>> On Thu, Sep 05, 2024 at 05:57:22PM +0200, Thomas Weißschuh wrote:
>>>> On 2024-09-05 08:32:14+0000, Willy Tarreau wrote:
>>>>> On Thu, Sep 05, 2024 at 08:22:18AM +0200, Willy Tarreau wrote:
>>>>>>>
>>>>>>> ./run-tests.sh -p -m user
>>>>>>>
>>>>>>> These toolchains can then also be used for direct "make" invocations
>>>>>>> through CROSS_COMPILE.
>>>>>>
>>>>>> I really suspect an empty CC variable somewhere that could explain why
>>>>>> only CROSS_COMPILE is used. I'll try to find time today to give it a
>>>>>> try here as well, just in case I can reproduce the same issue.
>>>>>
>>>>> In fact I'm getting it without any options:
>>>>>
>>>>>     $ ./run-tests.sh
>>>>>     realpath: /home/willy/.cache/crosstools/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-: No such file or directory
>>>>>
>>>>> It comes from here in test_arch():
>>>>>
>>>>>           cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
>>>>>
>>>>> Thus it's indeed related to the absence of the toolchain there. It's
>>>>> just that the way the error is reported (due to set -e) is a bit harsh.
>>>>
>>>> Ack. It should not occur with "-p" though.
>>>
>>> Agreed, I was focusing on first experience for users essentially.
>>>
>>>>> What about this ?
>>>>>
>>>>>     $ ./run-tests.sh
>>>>>     No toolchain found in /home/willy/.cache/crosstools/gcc-13.2.0-nolibc/i386-linux.
>>>>>     Did you install the toolchains or set the correct arch ? Rerun with -h for help.
>>>>>     Aborting...
>>>>>
>>>>> or anything similar, achieved by this patch (warning copy-paste, mangled
>>>>> indents):
>>>>>
>>>>> diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
>>>>> index e7ecda4ae796..0f67e80051dc 100755
>>>>> --- a/tools/testing/selftests/nolibc/run-tests.sh
>>>>> +++ b/tools/testing/selftests/nolibc/run-tests.sh
>>>>> @@ -143,6 +143,13 @@ test_arch() {
>>>>>           arch=$1
>>>>>           ct_arch=$(crosstool_arch "$arch")
>>>>>           ct_abi=$(crosstool_abi "$1")
>>>>> +
>>>>> +       if [ ! -d "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/." ]; then
>>>>> +               echo "No toolchain found in ${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}."
>>>>> +               echo "Did you install the toolchains or set the correct arch ? Rerun with -h for help."
>>>>> +               return 1
>>>>> +       fi
>>>>> +
>>>>>           cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
>>>>>           build_dir="${build_location}/${arch}"
>>>>>           if [ "$werror" -ne 0 ]; then
>>>>
>>>> Looks good.
>>>
>>> OK thanks, I'll try to handle it this week-end if I'm not beaten to
>>> it. If you or Shuah want to merge it before, feel free to, no offense
>>> on my side!
>>>
>>
>> Sounds good. My system is back to a good state with the tests after running
>> ./run-tests.sh -p -m user
>>
>> My guess is my setup was lost when I upgraded my system.
> 
> Makes sense.
> 
> FWIW I've just pushed the patch above to nolibc-next. Since it's not a
> result of a change of the last PR, there's no need to udpate it I think,
> it can easily wait for the next one (it's just a help message after all).
> 

Sounds good. We can add this later too during the release cycle for one
of the rcs.

> During the tests I've also got caught with -d which needs a trailing slash
> otherwise doesn't concatenate directories correctly. I don't know if that's
> intentional or not so I didn't change it (and it's not important either).
> 

It is good to fix this and give more information to users.

thanks,
-- Shuah



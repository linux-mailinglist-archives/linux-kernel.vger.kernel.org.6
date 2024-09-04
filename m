Return-Path: <linux-kernel+bounces-315986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A092F96C97A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556651F26477
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB171547EB;
	Wed,  4 Sep 2024 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GFZ9p0O1"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3C47F4D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484786; cv=none; b=GFBEg4qJ3L0Y/USB64tsBZP3QjSCWCK60wRzAnCOvuEe61QHI1l0VW/fD9xdy7muGVxw/sugNHMv7qQolo9s8NVjM1NiucZQmPGP0H76bcQkVb0isBkxXm8g92JSynImHj9kjmJVv+ruVjOIDYWcrVXZiV2v3eWNnz5dYS0aX8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484786; c=relaxed/simple;
	bh=Z2dQ7XwJj18P8R2l5tCNMA0HoK2AVDQwxrxohuhyOv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjTAPz/itQcDDLQeTPhsTXVOGIlIuajY7BZWCx5aPx5xMVAwQZ59z0AaBHWtvqc4aNFlAkHkOCsAmmzeRM4ifnpmeh47gzFyNkD1Ed1lFPRSG7QxeyKZoKbVWLIg8SO5pLAOspqDIytBR769MPCzrlaN7q96n/jv2CkVKB2pe+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GFZ9p0O1; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82a3022be9eso232075739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725484783; x=1726089583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0oYTPq+0PnnZwgq302bydeH1cK7aJJmhAAm0mLPzxOo=;
        b=GFZ9p0O1Bf4HfuKw07h2TN1jrOA5Y21gjfSXZAT/5VJO/byF+gv4rXItHx2nK+BTIN
         j6ga1FjkwHi4LhLCYhzXMRdwiZU22wMz9u7qGDVHegZbjPWbq/2oU/UOhkH3LP7Pt8kU
         RZ9Ba9+luLPaumJWoemhHnCRnvpGOfhXG0y3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725484783; x=1726089583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0oYTPq+0PnnZwgq302bydeH1cK7aJJmhAAm0mLPzxOo=;
        b=ieXdjg8I8iEcxAqOSO8oDOqGcluvu7supP+rzSfLngBvt7MVvim46qlTTV74pQm03+
         biicKalFLehIqutE4rQNx5YJtmp8zDrxdNeoueoiVVsjz7otZR6CS2AtODQJl6dJFWHN
         Dvos8Zdx6c4oCtFD0YfghWjzMjKgreGmcELhJfeAG1OiH+heX4VVTtP9UJ13ETaN3i5r
         1YIMChb5cvLb40rdWGu1jg/MGiAaYa4ilbkg3h5W5JdZuZZUFdElGrDBQKgf5F6NVFRb
         0X/FqB3ear70Fp0YQMrnXvaFdrFuiFwHjLwNa+chvRtk2/QRDXW5TD6nQ102lwIac+mv
         Qb/A==
X-Forwarded-Encrypted: i=1; AJvYcCVKULfF4jSkRqjUvM57csRy+Od8VpQ+YRPsAWvHdNqRQhKiC3TN4IVC8rnfteENGNSW/mekpFVBsKT0JrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO7J9IU6AZxW2q5xe6bUgGcQPVVAz8EWOXwhwYsOqsQShbJrwB
	E+KhHNqFKlVsNVtpe55a+69pWvxW42CWTvsqmTXvkdoMvfNyqRUwdtzyoR5UYFA=
X-Google-Smtp-Source: AGHT+IGA0VbvEWXPQaFWjih6/fY4cg5V106oUcWnQduZQDRKtQ1jFTOxNojlZ2OiejvyV6zvjcGv8g==
X-Received: by 2002:a05:6e02:1d8b:b0:3a0:4392:4169 with SMTP id e9e14a558f8ab-3a0439243c9mr28285205ab.12.1725484783614;
        Wed, 04 Sep 2024 14:19:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f54d7fc5esm25031025ab.23.2024.09.04.14.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:19:43 -0700 (PDT)
Message-ID: <13169754-c8ea-4e9e-b062-81b253a07078@linuxfoundation.org>
Date: Wed, 4 Sep 2024 15:19:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nolibc for 6.12-rc1
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <3b9df0a1-7400-4c91-846d-b9e28982a7c3@t-8ch.de>
 <9de5090f-038f-4d68-af96-fbb9ed45b901@linuxfoundation.org>
 <f882fa56-c198-4574-bb12-18337ac0927e@linuxfoundation.org>
 <9440397d-5077-460d-9c96-6487b8b0d923@t-8ch.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <9440397d-5077-460d-9c96-6487b8b0d923@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/24 15:13, Thomas Weißschuh wrote:
> On 2024-09-04 15:04:35+0000, Shuah Khan wrote:
>> On 8/27/24 06:56, Shuah Khan wrote:
>>> On 8/24/24 12:53, Thomas Weißschuh wrote:
>>>> Hi Shuah,
>>>>
>>>> The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:
>>>>
>>>>     Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>     https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc-20240824-for-6.12-1
>>>>
>>>> for you to fetch changes up to 25fb329a23c78d59a055a7b1329d18f30a2be92d:
>>>>
>>>>     tools/nolibc: x86_64: use local label in memcpy/memmove (2024-08-16 17:23:13 +0200)
>>>>
>>>> ----------------------------------------------------------------
>>>> nolibc changes for 6.12
>>>>
>>>> Highlights
>>>> ----------
>>>>
>>>> * Clang support (including LTO)
>>>>
>>>> Other Changes
>>>> -------------
>>>>
>>>> * stdbool.h support
>>>> * argc/argv/envp arguments for constructors
>>>> * Small #include ordering fix
>>>>
>>>
>>> Thank you Thomas.
>>>
>>> Pulled and pushed to linux-kselftest nolibc branch for Linux 6.12-rc1
>>>
>>
>> I am running sanity tests and getting this message:
>>
>> $HOME/.cache/crosstools/gcc-13.2.0-nolibc/i386-linux/bin/i386-linux-: No such file or directory
> 
> This indicates you are using 'run-tests.sh'.
> Pass "-p" to let it download the toolchain automatically.
> 
>> I tried setting TOOLCHAIN_BASE to the directory I installed gcc-13.2.0-nolibc
> 
> Not sure where this variable comes from, but I have never seen it.

This is from the notes I got from Willy.

> 
>> Something changed since the last time I did the pull request handling.
> 
> In the test setup not much has changed.
> Maybe you cleaned out your ~/.cache?

Not intentionally ...
Guess I just have to do run download.sh again.

> Or it's the first PR with run-tests.sh?

I have been running the following successfully in the past:

 From tools/testing/selftests/nolibc
make run
make run-user

./run-tests.sh -m user
./run-tests.sh -m system

thanks,
-- Shuah





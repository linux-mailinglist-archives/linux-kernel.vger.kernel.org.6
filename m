Return-Path: <linux-kernel+bounces-325436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF0B9759A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D1B3B211EC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E42D1B3728;
	Wed, 11 Sep 2024 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AMV6oX8L"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF711A304A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076509; cv=none; b=Cy0UQNJpvhmzVpKzC6YteJ4xc0zaAwgw+PGiARFxbzdg+Wo4Pa672FJVOWcWJsjZTc8gosRSCrXn63qi90P3PEV/Plq8FJQmRQIC7iXtbPoxPFBPZcr60gCi6EoREf3m/SHH4Jx2Oge8Oqisx8hxIsiWspJNje9pDDI+yMisu5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076509; c=relaxed/simple;
	bh=4MLw3w+AyWXYKNzizJpKkr3qxd0kHTmFnrxreF7e6rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCfDsVnQvLSST52RfszX7vu0ro1ZOT2ORNaE7RrbydI2JEKK+wLicvxrmy8E7UcMEVa7HDHq0DTA2ZhDiP0652DuLqBK521bdllga00gjAwpeBAu7pQcUJtXWtcTHiSl9a4+ED3V5z2qheIYdSOvw0owoIxTXbUOc/LTQFxUsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AMV6oX8L; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82ce603d8daso2496439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726076507; x=1726681307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/Evpj4ztjn5sSYeRX1VYm9ZhgH1mvXmTv8yveHVyJ0=;
        b=AMV6oX8LNsQvtNikWJawXK3wJpP/MlzsuXg7tFTWfsITaw8aA3lF66KjoJb9NzLfTe
         3rzCOH6I3HRkOUBjc0VJ4Z5EJKZAgcgCD5ryC+7AqgzdGCLU132JuL2/1PSgaf+yByHi
         umJIafL2hX6h/ZZhnyzYu4iukhAbOrICJTBU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726076507; x=1726681307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/Evpj4ztjn5sSYeRX1VYm9ZhgH1mvXmTv8yveHVyJ0=;
        b=POSb42FANdZzCG+5wT18qpHdd/VkMnUCopgZlhwFMl34/4osH4ovrZbCLcjLhDd0Uc
         h7TNtnyHL3xWrvT0kMeZoFVPVfsd51SZ7/BDjSrOrx4NpWbX81Ama56V81JaLV72IZDp
         nFJhoSBBPMcHAV21oU0laCssWXUBzTMb0Ix2EpsuOezMLGm0BKmCB12sdK95OOeZxBjW
         JMfQH+1YrQHQXsjzISTvVzPrPmk9MKH5SG2LZ6B8TqubvY5vAGi2FfIoRjlcK574YBb5
         z4oXuGmbRTWYuy4QMNH4vEoLSA3Tt/hYrEBMdGuuARMGUNXXIiU8YQl3Gq9gv4ICPEbz
         9WiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR61LK+T1ZuDOWTz+WcdPS8tnAGL+E3jWFZVFrqayzjexOxBXCFDSQzQF3P8mpkU+j/u30TzhSAgHfJ/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdgXcPGJNf7WuW+8JQwLlRLly7PkRdnnQBDGVYb3MG2loo8C10
	LglImO4TBt8bHQw1KilX0A1bz6hxUyI+7UUwe+7SvSL9/Kqy0EvV2gT59NU9Sbs=
X-Google-Smtp-Source: AGHT+IGFmDEYu28+n/w2kkrEpd8aFfbcheCsyGwcyD5LEwqOedHuJ+I2YPLNuin7DXlUtBx55jN3Lg==
X-Received: by 2002:a05:6602:26c7:b0:82d:b5a:b050 with SMTP id ca18e2360f4ac-82d1f985155mr52957039f.15.1726076506789;
        Wed, 11 Sep 2024 10:41:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f8ff048sm98878173.152.2024.09.11.10.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 10:41:46 -0700 (PDT)
Message-ID: <449d19f6-5869-43c6-81d3-7f77d4e4d449@linuxfoundation.org>
Date: Wed, 11 Sep 2024 11:41:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: kselftest: Use strerror() on nolibc
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, Willy Tarreau <w@1wt.eu>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>, shuah@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240911044230.5914-1-zhangjiao2@cmss.chinamobile.com>
 <1c94b9bd-78d1-433a-959e-420a456bd40c@linuxfoundation.org>
 <16611552-10d8-46d0-8163-460c0cbec2e5@t-8ch.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <16611552-10d8-46d0-8163-460c0cbec2e5@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/11/24 09:44, Thomas Weißschuh wrote:
> Hi Shuah,
> 
> On 2024-09-11 09:36:50+0000, Shuah Khan wrote:
>> On 9/10/24 22:42, zhangjiao2 wrote:
>>> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>>>
>>> Nolibc gained an implementation of strerror() recently.
>>> Use it and drop the ifndef.
>>>
>>> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>>> ---
>>>    tools/testing/selftests/kselftest.h | 8 --------
>>>    1 file changed, 8 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
>>> index e195ec156859..29fedf609611 100644
>>> --- a/tools/testing/selftests/kselftest.h
>>> +++ b/tools/testing/selftests/kselftest.h
>>> @@ -373,15 +373,7 @@ static inline __noreturn __printf(1, 2) void ksft_exit_fail_msg(const char *msg,
>>>    static inline __noreturn void ksft_exit_fail_perror(const char *msg)
>>>    {
>>> -#ifndef NOLIBC
>>>    	ksft_exit_fail_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
>>> -#else
>>> -	/*
>>> -	 * nolibc doesn't provide strerror() and it seems
>>> -	 * inappropriate to add one, just print the errno.
>>> -	 */
>>> -	ksft_exit_fail_msg("%s: %d)\n", msg, errno);
>>> -#endif
>>>    }
>>>    static inline __noreturn void ksft_exit_xfail(void)
>>
>> Adding nolibc maintainers for review.
>>
>> Willy and Thomas, please review.
> 
> Acked-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> I did the same for another kselftests function when introducing
> strerror(). This one was apparently missed or didn't exist yet.
> 
> 


Thank you. Applied to linux-kselftest next for Linux 6.12-rc1.

thanks,
-- Shuah



Return-Path: <linux-kernel+bounces-234532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ED591C7A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618721F21838
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D382B824A1;
	Fri, 28 Jun 2024 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZsTbAIrS"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8452476046
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608185; cv=none; b=DOExoPi6zByS+1JhbY2GPGpagF8GQtfAJnbf/yzoGTFwCnc/eE3exeYowyM0HE9vAWxkOV1dTdheQjMXmrBJJnJt2ZMTpFP6my19D3nQZVpgGsF2EhafHC3Vbu7xckex1XC1zr0z/Qe32qv0P32I3xNOfeKIWbVRwH9DoW471YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608185; c=relaxed/simple;
	bh=sVVLZyRz+Y2ocJx/Z/miUk7woF9fQ39aiLjmsqWPRP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5GngvLY/GW6rPNvKNUuVssexRh6Xbq9ujZdW1L2gU7RE+8jUj3avAX9KCSG/ya5wSTVUX/QejU3dWySlyN8rGFpCe4uA8rArWq+uQrYwviXedf5cI+fV+9fKkqYLY9HVcdxXTB1l/15/0hJ1th4oBihZAOz/eo2lHoEmkZooCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZsTbAIrS; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3762c172d94so627125ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719608182; x=1720212982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cxBzF/3g//5unyTrsCD2pQgSwnKMNUq26lWEwzop2AY=;
        b=ZsTbAIrS3wCSckC4P8tps8DvInI9VbQF+hW0fFVJFb3uxc/k2eGXSppFyVRcxk084B
         SkMqwFz9Ghsb+QAqXIOx35r63oqdXiQclntRwowwZL1+Oxcn3R1EjGE0+gYS5BFW6f+i
         ZIX+w03B7NIVmd1mnyZkYWUTuPzX4QDITXV54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719608182; x=1720212982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxBzF/3g//5unyTrsCD2pQgSwnKMNUq26lWEwzop2AY=;
        b=e5HdFCTozppqe2TmRb2ZfEHQtgsZCxPq5heUqanwItsrlfqVzZ9IqHFkwS3Wj8NIDY
         XCIH2x0hKSTn/CYQr4b7Y3fvCpvUng05FtX+1xDYYqOweN+CJ4UeuT2jU/834ZOhiaB1
         kUSBBM3CKWtU+oN2GzxSPgQbCiR/hs/yimmcHSmq89WPaioh93rBlQEY0EtqOyh+mAGC
         OBmaSTmrtugB5i/Z711DRB6L4MbYEI6rf8uhsCqGY4ddH3kv7NWxPCDycRxfotvJ3ZpD
         cJcUAZPDsx7uf0MiNdD12p6Ezge065Jmzgkkk7Pdd9chRJ6fLqhw1v8RajJdsKbr1NIA
         wcww==
X-Forwarded-Encrypted: i=1; AJvYcCXfW5RjSrSMCi+Xq8LDOhoFj7VeneJG5pOZ5qLReEU3XXUjMTCzJ+gmBRA5byBmZWV4kxkAofp4t86nEFiW+7FpPoCoopLCFIYr6VbE
X-Gm-Message-State: AOJu0YwLxWnzb6pcmEoeg50ZiTp+rw5w5tmr8Ot84sbUFWMCDygKuGsi
	K5G1OO1PsV3HDCciGEfJim0dUoewbwbcVJ3CgjxsuvgyLdmoSYZIA5kZOotaWYg=
X-Google-Smtp-Source: AGHT+IGhg+mM7B81Awx2TVEDdIc2OvHNDuUeXlc6e5PUETIM5puxKztiIZ1KRgU0iKtgkuS9BUjEFg==
X-Received: by 2002:a6b:4f0b:0:b0:7f3:cd61:32f5 with SMTP id ca18e2360f4ac-7f3cd613354mr944356139f.2.1719608182677;
        Fri, 28 Jun 2024 13:56:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb742b1acfsm710492173.123.2024.06.28.13.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 13:56:22 -0700 (PDT)
Message-ID: <4e02d3d6-935a-4184-b8aa-cbd537633783@linuxfoundation.org>
Date: Fri, 28 Jun 2024 14:56:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests: kselftest: also use strerror() on nolibc
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Shuah Khan <shuah@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240426-nolibc-strerror-v1-0-76a4c9c5271d@weissschuh.net>
 <20240426-nolibc-strerror-v1-3-76a4c9c5271d@weissschuh.net>
 <56ea48ee-e278-4f37-a80f-9fd70d9d8d3b@t-8ch.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <56ea48ee-e278-4f37-a80f-9fd70d9d8d3b@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/27/24 10:11, Thomas Weißschuh wrote:
> Hi Shuah,
> 
> Could you Ack the patch below to kselftest.h?
> 
> Thanks,
> Thomas
> 
> On 2024-04-26 13:08:58+0000, Thomas Weißschuh wrote:
>> nolibc gained an implementation of strerror() recently.
>> Use it and drop the ifdeffery.
>>
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> ---
>>   tools/testing/selftests/kselftest.h | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
>> index 541bf192e30e..f4bfe98c31e4 100644
>> --- a/tools/testing/selftests/kselftest.h
>> +++ b/tools/testing/selftests/kselftest.h
>> @@ -161,15 +161,7 @@ static inline __printf(1, 2) void ksft_print_msg(const char *msg, ...)
>>   
>>   static inline void ksft_perror(const char *msg)
>>   {
>> -#ifndef NOLIBC
>>   	ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
>> -#else
>> -	/*
>> -	 * nolibc doesn't provide strerror() and it seems
>> -	 * inappropriate to add one, just print the errno.
>> -	 */
>> -	ksft_print_msg("%s: %d)\n", msg, errno);
>> -#endif
>>   }
>>   
>>   static inline __printf(1, 2) void ksft_test_result_pass(const char *msg, ...)
>>
>> -- 
>> 2.44.0
>>


Sorry - this git lost in my Inbox.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


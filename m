Return-Path: <linux-kernel+bounces-269657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8632D943573
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF8C1F22062
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA9C3E47B;
	Wed, 31 Jul 2024 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FEg7gBcY"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E482030A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722449578; cv=none; b=eKFKd/vb1PGNjvn1jGnUk8j9WI8wkqbxE5Nejp6j4XeeNpEbaIQA1wVC9fvVa/SSQXJKLkwC+EGQWcz7kEMVxJhm7aZZiT92Ynupytns2tDr62/uWBmAJV59F3HK+u7Iu1zUB4chbqyr5d8M8YhVUYzU6jQjMEjl/7cxOsUZyow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722449578; c=relaxed/simple;
	bh=S0MQ2z3dmBqZt6+3Bx7AfL2LRp26WD88yxieDIts1Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brO9NSmZ6sChZ7G7gxaxe4qNFvsPMG8W1Lfx9OG+RDDSuJntgFj19hWNZh7ZFDlhdNZ3e8hKj7EwKMkXh/EAlYN8Vvi3YCWfGp3Hl4TgsU9ErmR7NKt82BTCXTa1IotqMGK8fzd+AMlZtn5Foy967O7CKNQpwtG7tfYHRRCgxiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FEg7gBcY; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-81f7faff04dso38391539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722449575; x=1723054375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJBncn61k4ebAYF7HIFvMqHJSlvpAG+JPwvZ+JUXIck=;
        b=FEg7gBcYfVqzAGS6Hm3oV6gksLCgq/Ds5aI5wY4H+Uuvk6gPAMPNm/rFmyTzV4jgT0
         cDqPUeLy89MYPvh/E+YhsOB5Goq9iO29oBwORseNaM5vpmYtn4fQnBpemZQlY1oGcMaA
         s9oeb+AjUcPEVpff/qVhs8qlnk7ozdO91faN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722449575; x=1723054375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJBncn61k4ebAYF7HIFvMqHJSlvpAG+JPwvZ+JUXIck=;
        b=dmD9fq2/MRo+hK4uzQQI44DAuyKOu1ED76Ae5/rmdsVWslXZqlmkXwhDIhjlhElzaG
         PFsIPV12kivWD0taa55448HuqQ6uzkgGbOqzaGnJU25yU946uD6bp1JrDPA3D57denVl
         B9WxcLHrTSeMWwvGvOajs3/3xDuRQmMJtfgU6Qd2RRogPSvG3p6U+EaTaLj/cl6KiDll
         GT3xTia1CxqxQChNBGXrrTMLJG9qj1Ivc+lQhM/HdfBS4cAdIMUhIJwpBzH1C8VxoSbD
         Z6vi/UpsgiVu9v6MeulZHI57qx0sp5urmqDj1+hFGcdb5fkU9b/18rXNm1l5IKW1sf7O
         oKyw==
X-Forwarded-Encrypted: i=1; AJvYcCWziVounv6LjnkbRayse8CblpoYBt/u72gqu6UIMVwTNbckKNZE5l45pMe2cxZPgt1eNQf3KUrkjIEypv0mKWsQgW6k9K+gyOwHi+rx
X-Gm-Message-State: AOJu0YxFrH42QAttHAUQTqBFmrjNx2XfWOVAeWNU1hXj3B6xPmL1fWaM
	NtcyKMpiMaP5y7o/aOIuXug7vKYBvfZTOYrB9AGaJP01hdIftcXx6oxM5bwCr/o=
X-Google-Smtp-Source: AGHT+IFTOL9folxvmqsGsGihzUJMIxe01fGordOndxhE2uHPb2+FQ8qHMfim77CH3RRL6kK61zayGQ==
X-Received: by 2002:a5d:958a:0:b0:803:f97f:59e1 with SMTP id ca18e2360f4ac-81fcbe581b4mr12908339f.0.1722449575146;
        Wed, 31 Jul 2024 11:12:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7d7ae876sm416014139f.32.2024.07.31.11.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 11:12:54 -0700 (PDT)
Message-ID: <a0b7f869-ac4f-4cbc-857d-a186497fca14@linuxfoundation.org>
Date: Wed, 31 Jul 2024 12:12:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: user: remove user suite
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Kees Cook <kees@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 David Gow <davidgow@google.com>, Vitor Massaru Iha <vitor@massaru.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240725110817.659099-1-usama.anjum@collabora.com>
 <23d0926f-293d-4a8c-b503-bd8b2253b7a8@linuxfoundation.org>
 <16f14d1a-56f2-4c2c-8180-74ad9bee0182@linuxfoundation.org>
 <5B0BBE86-C3F3-4CA3-87F5-49F0DB1B28EE@kernel.org>
 <6d903772-2186-4d52-8391-df5ac2682b84@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <6d903772-2186-4d52-8391-df5ac2682b84@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 23:13, Muhammad Usama Anjum wrote:
> On 7/31/24 7:33 AM, Kees Cook wrote:
>>
>>
>> On July 30, 2024 3:36:11 PM PDT, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>> On 7/25/24 08:44, Shuah Khan wrote:
>>>> On 7/25/24 05:08, Muhammad Usama Anjum wrote:
>>>>> The user test suite has only one test, test_user_copy which loads
>>>>> test_user_copy module for testing. But test_user_copy module has already
>>>>> been converted to kunit (see fixes). Hence remove the entire suite.
>>>>>
>>>>> Fixes: cf6219ee889f ("usercopy: Convert test_user_copy to KUnit test")
>>>>
>>>> Remove fixes tag - this isn't a fix and we don't want this propagating
>>>> to stable releases without kunit test for this.
>>>>
>>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>>> ---
>>>>
>>>> Thanks,
>>>> -- Shuah
>>>>
>>>
>>> As mentioned in other threads on this conversion to kunit and removal
>>> of kselfttest - NACK on this patch.
>>>
>>> Please don't send me any more of these conversion and removal patches.
>>>
>>
>> I think there is a misunderstanding about these particular patches (for string and usercopy selftests). Those were already converted, as desired, by the maintainer (me) to KUnit. These associated patches are cleaning up the dangling kselftest part of them, and should land (with the Fixes tag, which is aimed at the commit that did the conversion).
> Yes, this is misunderstanding and these patches should be taken to remove
> dead tests in kselftests as their corresponding test modules have been
> moved already. So these patches are fixes.
> 

Thank you both for the clarification

Applied linux-kselftest for Linux 6.12-rc1

thanks,
-- Shuah



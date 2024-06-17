Return-Path: <linux-kernel+bounces-218200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71AC90BAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8141C22109
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296EA1990BA;
	Mon, 17 Jun 2024 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RcM5b/Jk"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955A364BE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718651844; cv=none; b=icH84igeyPqtS3ehI2SRrrKJoMIoFsomDRTQBRqZ/UblDKayOsS8zXZmrjPjeZWRaJDJX8XuAXFVG4UA8OerOZjgWRy7EbQSE+l/dl2g3IXdzu9P3BLlRsD2UqXCwD34As6DsIgUNGP7W0pDYuvjht9yefR8kSaWkNQCeeg3Yso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718651844; c=relaxed/simple;
	bh=jQKjgH/IeJSbhbllaf+iVIq0r/CllhXzET0SeRnnSRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZ7KQZw3Oy5Os4HcJQfuzW4A1USlu/32JTSlJ13mIiKuB8mV2gZTfOHDDCNjUy+TbQcVghmsBx5C8o6qSI3SRpyQdaXUBoacuH+4XpLfFXXf19LLQZnHyOZBidhwJhes8WQr7d1Hi52iPCsQYTphyECq7cik3g1GR7BJldw8zys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RcM5b/Jk; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7eb73444661so13504739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718651840; x=1719256640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxDCmX69tkQkw7FEhpYwJ22/GtNZFk3dnE10Jhs2Vfw=;
        b=RcM5b/JkvHHb/X+dWLUVatx1pvkpDokDo4WXM2E0UUG/zyLXEU5nFFIPTq0AM8SVaU
         WUkZCzfcmILe6DnBN7D3HrtCNae98AiwxylcD4S1rm+bksha3YvsA+DB7NHf118o1hZZ
         0JpEioi60kD9gMpFiGyjQcWZy/rVeERVhTrdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718651840; x=1719256640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxDCmX69tkQkw7FEhpYwJ22/GtNZFk3dnE10Jhs2Vfw=;
        b=dl4O7GgUaZKa50w2BcXRlnuEwnFo4F6o8zy0JirzlMQKAV0cnHn9wRkqRR9LP/oCzm
         BSATVudY4UrjyLHXgRpgZm2ZbQBbxQdJDehGkmpJDwmTs2kRcbndBQsHjlErnpb9Nomf
         4HNC//PAyNTOdd4tYZyHhtj/MQ9r/t3L2+JDhx5CXOvsUNlhat4bcZSY/PatmTJOCTtE
         TPr7QwWal8b6mHJc5nuiTcT84c3Hy71LtkVqji3UVlHG5BOTHU6kd4jV4AwKKze/v3rD
         RG15Q7afZjTIB0IxD6O635KBxTV0yPUnqI2JYoCKtoiMN6EQJK0afqzn7kIF8lrl+urK
         j6VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiL+zvMMyq9kXNNLThUSnAPv+1CM1mfNHwe0Lb3j8fBKM4fG9d/x55e0rnbleRT5RBDCJJUGnQasAOW0B4OZPco6S7RDJPxyzu7eME
X-Gm-Message-State: AOJu0Yx/c0/dPd6Rv9ApPSNXq5oiRS2vX4OJvg2Bi9iOs/wK8gNAH2fG
	xZHAJEd7dhUPSUvnRaPnmr0v7AZyKJL/CeK0kqc6X0ic1Kn1c/mQyIISyHQLu/M=
X-Google-Smtp-Source: AGHT+IHOg3FPItf6+cCu8wcgQmloKpiojh3fisdmWTlg+Lr2TYt3VwBpFvvZ6liZuV86R4UCrSrAdA==
X-Received: by 2002:a05:6602:142:b0:7eb:66a5:d1c with SMTP id ca18e2360f4ac-7ebeaefca76mr980500639f.0.1718651840458;
        Mon, 17 Jun 2024 12:17:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9569ef5a4sm2733310173.117.2024.06.17.12.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 12:17:20 -0700 (PDT)
Message-ID: <93ea1bde-4dac-409b-8c3c-0f6c0239bb1c@linuxfoundation.org>
Date: Mon, 17 Jun 2024 13:17:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] usercopy: Convert test_user_copy to KUnit test
To: Kees Cook <kees@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Vitor Massaru Iha
 <vitor@massaru.org>, Ivan Orlov <ivan.orlov0322@gmail.com>,
 David Gow <davidgow@google.com>, Brendan Higgins
 <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-hardening@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240612195412.make.760-kees@kernel.org>
 <20240612195921.2685842-2-kees@kernel.org>
 <90e61842-e933-4d6f-a3b5-c802382fe96a@linuxfoundation.org>
 <202406171157.A97ACED1B@keescook>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <202406171157.A97ACED1B@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/24 13:00, Kees Cook wrote:
> On Fri, Jun 14, 2024 at 09:50:05AM -0600, Shuah Khan wrote:
>> On 6/12/24 13:59, Kees Cook wrote:
>>> Convert the runtime tests of hardened usercopy to standard KUnit tests.
>>>
>>> Additionally disable usercopy_test_invalid() for systems with separate
>>> address spaces (or no MMU) since it's not sensible to test for address
>>> confusion there (e.g. m68k).
>>>
>>> Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
>>> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
>>> Link: https://lore.kernel.org/r/20200721174654.72132-1-vitor@massaru.org
>>> Tested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>>> Reviewed-by: David Gow <davidgow@google.com>
>>> Signed-off-by: Kees Cook <kees@kernel.org>
>>> ---
>>>    MAINTAINERS                                |   1 +
>>>    lib/Kconfig.debug                          |  21 +-
>>>    lib/Makefile                               |   2 +-
>>>    lib/{test_user_copy.c => usercopy_kunit.c} | 282 ++++++++++-----------
>>>    4 files changed, 151 insertions(+), 155 deletions(-)
>>>    rename lib/{test_user_copy.c => usercopy_kunit.c} (46%)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 8754ac2c259d..0cd171ec6010 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -11962,6 +11962,7 @@ F:	arch/*/configs/hardening.config
>>>    F:	include/linux/overflow.h
>>>    F:	include/linux/randomize_kstack.h
>>>    F:	kernel/configs/hardening.config
>>> +F:	lib/usercopy_kunit.c
>>>    F:	mm/usercopy.c
>>>    K:	\b(add|choose)_random_kstack_offset\b
>>>    K:	\b__check_(object_size|heap_object)\b
>>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>>> index 59b6765d86b8..561e346f5cb0 100644
>>> --- a/lib/Kconfig.debug
>>> +++ b/lib/Kconfig.debug
>>> @@ -2505,18 +2505,6 @@ config TEST_VMALLOC
>>>    	  If unsure, say N.
>>> -config TEST_USER_COPY
>>> -	tristate "Test user/kernel boundary protections"
>>> -	depends on m
>>> -	help
>>> -	  This builds the "test_user_copy" module that runs sanity checks
>>> -	  on the copy_to/from_user infrastructure, making sure basic
>>> -	  user/kernel boundary testing is working. If it fails to load,
>>> -	  a regression has been detected in the user/kernel memory boundary
>>> -	  protections.
>>> -
>>> -	  If unsure, say N.
>>> -
>>>    config TEST_BPF
>>>    	tristate "Test BPF filter functionality"
>>>    	depends on m && NET
>>> @@ -2814,6 +2802,15 @@ config SIPHASH_KUNIT_TEST
>>>    	  This is intended to help people writing architecture-specific
>>>    	  optimized versions.  If unsure, say N.
>>> +config USERCOPY_KUNIT_TEST
>>> +	tristate "KUnit Test for user/kernel boundary protections"
>>> +	depends on KUNIT
>>> +	default KUNIT_ALL_TESTS
>>> +	help
>>> +	  This builds the "usercopy_kunit" module that runs sanity checks
>>> +	  on the copy_to/from_user infrastructure, making sure basic
>>> +	  user/kernel boundary testing is working.
>>> +
>>
>> Please carry the following line forward as well to be complete assuming
>> it is relevant.
>>
>> If unsure, say N.
> 
> I've explicitly removed that because it would be repetitive if it were
> included for all KUnit tests.
> 

Thanks for the explanation.

thanks,
-- Shuah


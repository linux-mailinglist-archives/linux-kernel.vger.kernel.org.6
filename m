Return-Path: <linux-kernel+bounces-257525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41A5937B53
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474DE1F22C64
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8D5146595;
	Fri, 19 Jul 2024 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hS7uJHX3"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D963145FF5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721407951; cv=none; b=BndKOIiGdGnOn4KeqSm6iJ6xbVSRPIDpgpnIDjG32p/hJTRm2iUOUftalBMZ9MFjVXza4sjFrV+kcn023vujjQulGAecNh78JRoCesTuBzfHqY+6nCi6176Fx7IJ7IFaT+9pAJNXrlQD/DI8A4d9ySqm71svRgJRcOSxhW+JE+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721407951; c=relaxed/simple;
	bh=dg1joDe0/WUb88mYgCUkL7XuYptXLnLTx1EcIUM7iOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r11Tik+iknkOgdsnD93OgzYD46SgY+tHo+sINJcuFQrxuhkxmbdEnWO4HQy+Kmr3jDOeanJqs5kvNSlb2LT4MjJ1NKT9zf+PLH101bdaJXZBg/p9AzBsWAOngtQ/ymDJRln0b8Awyu2h4edE7+r6JrK6Qqf7Xze89BEzgayjEHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hS7uJHX3; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-810ca166fd4so10405839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721407949; x=1722012749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YVq9rhxj9KY6lJ4PBSRcpWJVfsDjX1sxbslbCzgCcX0=;
        b=hS7uJHX378RFWgI8EU/P9e5d530AUvQUwUAFtL+D3s0OledG0a64WE6CniFvu7W2Ea
         ra/q/aHS3wMwf62Wpp16VHJkqv4lj0BVyHBd/yL2V2pTE5I0CSzyeHgpo8dAOmo+DuKg
         s1x2uXXQY7lSEV7SCR3WL2aHKJ6NDonrUbKNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721407949; x=1722012749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVq9rhxj9KY6lJ4PBSRcpWJVfsDjX1sxbslbCzgCcX0=;
        b=QBfartMwWajeB/2CcFXFZvT/WFot9ibGDPoU5Nn2fOimwzc9JaSJYGuNODMdjXyCTK
         QKZlMJY92oCXwVJ4lJrg7I/zgA7g8FGB9B9xVjits8sLf/Pqd1YxiAmAYPyB2Ha+zQnW
         S4q4u0G7DVSEEApzWiHc59qBllnZeMlY555YF+SUiScRbM9HSaaHZ/Ciefcy/SR176Vc
         YiIhK4Iw8drOU4jmK6aJf0d+TelaXVbwfuqSWKvvdG5ctt+yE3t3UwspMcf7itGDAxPj
         7cngPaVs6f4FoTJzz+uV4N7F6AA1h/H7FRV+uy8aOSVPCZaqE/eA3t333vVJyv55tWbY
         1JMg==
X-Forwarded-Encrypted: i=1; AJvYcCWAkeJkXwx8Ak0Dm2Y9o813mMafMG+JJKW8UFjnicvq1kTEDQZk9fV96n/w3vewvC79lkrO1HV5MPTjnTl/OSnSTrcBzR8S2akWh4mc
X-Gm-Message-State: AOJu0Yy+/0mv8/lY+YqKha3CbL9+eqpN0EQXThtL1w29g8xmjaPwDbnT
	X3FDv+5Jgb9EetJsoJrmrG1gS2Ks/z6fVB8nbQC5ce5PGv6APoFw55wsSECf4fk=
X-Google-Smtp-Source: AGHT+IHVEUg0Voj3rtft2eRgoH6rsC+fbA9+GE/Ee5VZUgWo0KTcgsQcScKaLOeA0Ec4HMnGwE9IsQ==
X-Received: by 2002:a05:6602:1dce:b0:7f9:89a2:b846 with SMTP id ca18e2360f4ac-81aa66d679cmr32392239f.2.1721407949048;
        Fri, 19 Jul 2024 09:52:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c2342f120dsm390031173.68.2024.07.19.09.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 09:52:28 -0700 (PDT)
Message-ID: <ac945077-928b-42f1-9f38-9d26c8672711@linuxfoundation.org>
Date: Fri, 19 Jul 2024 10:52:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] selftests: x86: check_initial_reg_state: remove
 manual counting and increase maintainability
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240718113222.867116-1-usama.anjum@collabora.com>
 <20240718113222.867116-2-usama.anjum@collabora.com>
 <6a477f29-3425-434d-88a7-b3d619fef2b8@linuxfoundation.org>
 <7677dc6a-3162-4ca8-ab73-f5903ad820c9@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <7677dc6a-3162-4ca8-ab73-f5903ad820c9@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/19/24 01:28, Muhammad Usama Anjum wrote:
> On 7/18/24 8:48 PM, Shuah Khan wrote:
>> On 7/18/24 05:32, Muhammad Usama Anjum wrote:
>>> Removes manual counting of pass and fail tests. This increases readability
>>> of tests, but also improves maintainability of the tests. Print logs in
>>> standard format (without [RUN], [OK] tags)
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>> Changes since v1:
>>> - correct description of the patch
>>>
>>> Changes since v2:
>>> - Update description of the patch and add before/after output
>>>
>>> Before:
>>>     # selftests: x86: check_initial_reg_state_32
>>>     # [OK]    All GPRs except SP are 0
>>>     # [OK]    FLAGS is 0x202
>>>     ok 5 selftests: x86: check_initial_reg_state_32
>>>
>>> After:
>>>     # selftests: x86: check_initial_reg_state_32
>>>     # TAP version 13
>>>     # 1..2
>>>     # ok 1 All GPRs except SP are 0
>>>     # ok 2 FLAGS is 0x202
>>>     # # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>     ok 5 selftests: x86: check_initial_reg_state_32
>>
>> What's the output you see if you were run this as:
>>
>> make ksefltest TARGETS=x86
>>

That is what is confusing to me. As mentioned in response to your
vDSO patch, this change to add ksft_header to individual tests.

When you run the test from the wrapper
if you want the header printed for q

>> How is this different from the output from the above command?
> The above before and after output has been taken by executing this above
> command. I've copy/pasted the snippets for this patch only.
> 

Yes. That is the problem. Youa re giving me snippets as opposed to
the header. When I run it I see TAP header at the top of the test
suite. The idea is that the TAP header should not be printed for
each test in the test suite.

It is printed once for test suite. What is the point in printing TAP
header for each of the tests in test suite if there are 100 tests
like in the case of break_points test.

Even if it is desired that each individual should have TAP header
(There has to be a good reason why - not because we want to see it),
this change should be added to
   
tools/testing/selftests/kselftest/runner.sh
This makes it uniform and maintainable.

Sorry. I am not going accept patches that add ksft header to individual
tests and test cases.

thanks,
-- Shuah


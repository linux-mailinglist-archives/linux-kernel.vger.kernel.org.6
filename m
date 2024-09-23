Return-Path: <linux-kernel+bounces-336049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53D797EE7E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FEE2828D5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987C219E982;
	Mon, 23 Sep 2024 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PArgJNDQ"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F9199923
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106515; cv=none; b=LZixx9BZ/+ieXK3wuXpdoh+IeqTH1PhKiJTKogSyjEJ61eESQ3N5fDxQ0SiVJnmFoXvnHsY2FK0UbX9tPPGhuSpC6Rh9A1oZkvhKt3dWf28oQvJR1JLDR3SmJm5oZobMA9nJQXRQTrpbUGa4PNpDd4dtBE6GkR2FxKgqJJt2LPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106515; c=relaxed/simple;
	bh=6AUAFawZBwEYX6wA6R/JHVcKxBorO1W5/vjMhI5Fnz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqkA4Y2R6BZ2p9fROgBxpBLcXty5hGbsRh/0/EidPrPOjR/fH5Oxi/Kf+4ioLmvNRSpi62KnNAkCzSWXt+q1frpRqE76HkXR1yDU8yC0KuAN4iYYA205m0hZwzeVhRPU6vim7EdcBxeX9rLWYCuWwT1Sd2sMFyvjbh79zmCsjQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PArgJNDQ; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a08dbc6019so20157565ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727106513; x=1727711313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XfewFcLEr2Hab28qFyt3LChk9UsqxcJHnv6Miiyoqbs=;
        b=PArgJNDQ+o10JbxeAE2CcWmGtDnnJ7fwpvYNVhEI30Z80CGDjXOXcrARULYNEcVx5f
         HXYaBPmNfrA4xGZcOpvF1eOuZBrcPUe7URS5C/2rGQ2K2Mgau1S6UfL4e/6tJAnSubtX
         5z4y5AVfYxY0fCLiKzheU8lu7oiLpjVeMXTUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727106513; x=1727711313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfewFcLEr2Hab28qFyt3LChk9UsqxcJHnv6Miiyoqbs=;
        b=vLi8cVxOO7j+4daJJwruWKrE6yUSOId4wRAAsUodo21gsPiiWdpVE1ZsjQCbQW2yXe
         yw3F+JHPYEcY8toA3fOxwCKARak7M7dGowzrsw37wZDW4JpGiO/65oMLB64GfPfPhwir
         gqbd6IZ7tAd4VW+MD8HZUbgcT5NkzHFugXZ83d86vOEevFQcPQ/BLhqJKaAOqWdAjK6s
         q5YbsFBp7/BrFYSRTOjroai97axnPvC9KB9oLyM22FghdPBpJPE2W9k0e4fu2xJ3rRv8
         o1Wq7Fjyu1prAAGVm86LypO+VdjSyOqApV8XsFeGQxmVD90hg26MUl/c9e0qDINpN5SG
         /Tpg==
X-Forwarded-Encrypted: i=1; AJvYcCUPdsOW7AObtozu73eZf89nSMEnT5rjeCPgIjiFwt+ohXAjsChmu0mDZN9a12fZwanazfdbndwV95dhRME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTnGtYkkQHvTqrqOgljCliS9fztkoL3d0Crm9oC+V7tEwN0Ebc
	bvOAqJQUl2hgnSkqpLR1Cf9F/+9aaT0UMa8siLP4DNzJl2VUZEfFJCEpr9pmURg=
X-Google-Smtp-Source: AGHT+IGWKJbuVpZdyroTo8OcMbSyZTxXo1Q/AjVDwq/pPrFbUHte/UKcaVbflle9CKdeqDONU09fGA==
X-Received: by 2002:a05:6e02:2163:b0:398:39f:8b4d with SMTP id e9e14a558f8ab-3a0c9cd0a71mr112974745ab.5.1727106512847;
        Mon, 23 Sep 2024 08:48:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a0c9f22728sm26001055ab.83.2024.09.23.08.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 08:48:32 -0700 (PDT)
Message-ID: <3276d15a-9865-4387-84d0-bff062a159de@linuxfoundation.org>
Date: Mon, 23 Sep 2024 09:48:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] Add KUnit tests for llist
To: Artur Alves Cavalcante de Barros <arturacb@gmail.com>,
 David Gow <davidgow@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 n@nfraprado.net, andrealmeid@riseup.net, vinicius@nukelet.com,
 diego.daniel.professional@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240917005116.304090-1-arturacb@gmail.com>
 <bd5eb792-124f-4eaa-9ff9-a99765d1ef73@linuxfoundation.org>
 <CABVgOSmNcmnRCn5Q05U1wBebSGTM=OdUXuT7SA-poHXUgKubaQ@mail.gmail.com>
 <ce313b67-416e-44fe-865c-77388883556c@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ce313b67-416e-44fe-865c-77388883556c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/20/24 20:49, Artur Alves Cavalcante de Barros wrote:
> On 9/20/24 4:10 AM, David Gow wrote:
>> On Fri, 20 Sept 2024 at 00:01, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>
>>> On 9/16/24 18:51, Artur Alves wrote:
>>>> Hi all,
>>>>
>>>> This is part of a hackathon organized by LKCAMP[1], focused on writing
>>>> tests using KUnit. We reached out a while ago asking for advice on what
>>>> would be a useful contribution[2] and ended up choosing data structures
>>>> that did not yet have tests.
>>>>
>>>> This patch adds tests for the llist data structure, defined in
>>>> include/linux/llist.h, and is inspired by the KUnit tests for the doubly
>>>> linked list in lib/list-test.c[3].
>>>>
>>>> It is important to note that this patch depends on the patch referenced
>>>> in [4], as it utilizes the newly created lib/tests/ subdirectory.
>>>>
>>>> [1] https://lkcamp.dev/about/
>>>> [2] https://lore.kernel.org/all/Zktnt7rjKryTh9-N@arch/
>>>> [3] https://elixir.bootlin.com/linux/latest/source/lib/list-test.c
>>>> [4] https://lore.kernel.org/all/20240720181025.work.002-kees@kernel.org/
>>>>
>>>> ---
>>>> Changes in v3:
>>>>       - Resolved checkpatch warnings:
>>>>           - Renamed tests for macros starting with 'for_each'
>>>
>>> Shouldn't this a separate patch to make it easy to review?
>>>
>>
>> I think that, if this were renaming these in an already existing test
>> (like the confusingly similar list test), then yes. But since it's
>> only a change from v2, I think we're okay.
>>
> 
> Yes, the renaming refers to some test cases from the test suite that I'm adding, with the purpose of resolving some checkpatch warnings, as suggested by Rae Moar's review[1].
> 
>>>>           - Removed link from commit message
>>>>       - Replaced hardcoded constants with ENTRIES_SIZE
>>>
>>> Shouldn't this a separate patch to make it easy to review?
>>
>> Again, if we want to change this in other tests (list, hlist) we
>> should split it into a separate patch, but I think it's okay for llist
>> to go in with these already cleaned up.
>>
>>>
>>>>       - Updated initialization of llist_node array
>>>>       - Fixed typos
>>>>       - Update Kconfig.debug message for llist_kunit
>>>
>>> Are these changes to existing code or warnings on your added code?
>>
>> I think these are all changes to the added code since v2. Artur, is that right?
>>
> 
> This is the case! All changes are in the added code, so it doesn't introduce any checkpatch warnings that were present in v2.
> 
>>>>
>>>> Changes in v2:
>>>>       - Add MODULE_DESCRIPTION()
>>>>       - Move the tests from lib/llist_kunit.c to lib/tests/llist_kunit.c
>>>>       - Change the license from "GPL v2" to "GPL"
>>>>
>>>> Artur Alves (1):
>>>>     lib/llist_kunit.c: add KUnit tests for llist
>>>>
>>>>    lib/Kconfig.debug       |  11 ++
>>>>    lib/tests/Makefile      |   1 +
>>>>    lib/tests/llist_kunit.c | 358 ++++++++++++++++++++++++++++++++++++++++
>>>>    3 files changed, 370 insertions(+)
>>>>    create mode 100644 lib/tests/llist_kunit.c
>>>>
>>>
>>> You are combining lot of changes in one single patch. Each change as a separate
>>> patch will help reviewers.
>>>
>>> Adding new test should be a separate patch.
>>>
>>> - renaming as a separate patch
>>>
>>
>> I think given that these are just changes between patch versions, not
>> renaming/modifying already committed code, that this is okay to go in
>> as one patch?
>>
>> The actual patch is only doing one thing: adding a test suite for the
>> llist structure. I don't see the point in committing a version of it
>> only to immediately rename things and clean bits up separately in this
>> case.
>>
>>
>> Cheers,
>> -- David
> 
> Thanks for replying!
> 
> I'd like to reaffirm that the patch is, in fact, doing one thing: adding tests for the llist data structure. All the changes in V2 and V3 refer to the code that I'm adding. I'm not modifying any existing list tests, only adding new ones.
> 
> [1] https://lore.kernel.org/all/20240903214027.77533-1-arturacb@gmail.com/T/#mc29a53b120d2f8589f8bd882ab972d15c8a3d202
> 
> Best regards,
> - Artur

Sounds good to me. It was a bit confusing because the v2 and v3 change
new and code which wasn't clear to me.

thanks,
-- Shuah




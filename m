Return-Path: <linux-kernel+bounces-334443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4BE97D755
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624B91C21A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F190817CA02;
	Fri, 20 Sep 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dATlL6U/"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7136D17C9E7
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726845041; cv=none; b=iLqgSc8uYhOUxDu1rZYNfPjaw0pYoog87RhYkOrCxePygzTXjca4xOQcdXtCxnW1h3Y/u0Bt/QoPCBysgAkIe0ANgVU2wRN6ySguc1/cs0fCvac3mb16JWzfgrdLzh9LqrNZGAbQnPStAJvlqrLGR3tz5v3y73G14gjW461gtFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726845041; c=relaxed/simple;
	bh=m64zunrpTT7clJ4I9TXVRY5xts3FGhLA4W4pYySMktk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghubOz8kqjs4qbHVpqfEHEpzO7WSGkKeToW3C4bFTltwBqrlimaDXyTCQR7h+JJBrhQons3niIAy3YJ3yCXbJHMZ70ghva+Qcul6bD4QSqEUgu+D3lYfd0ZGsYrXkskiIMgIt2NJVtLZpGMUgroj95tTslB4wDHL9fJnsPsQeYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dATlL6U/; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82d24e18dfcso112066739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726845038; x=1727449838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DJJMb8RSS4AQiwxpzvIgvhQjhF1XMXFRTCcE2Om75mQ=;
        b=dATlL6U/v+2GeN31SofkuPALf6Hi01JCzMIKircd038ebje/fsx7IhnQn8V+YKo4R/
         le4SF6HvQTYec2RhT6o8cCV8qe7D07QkcrpHtach5CJJDtSt/lFIR4EbmIICx27BzMmJ
         GlIXlx5AVPdWO1YoXyfc9VMhmypgOBBwzl/x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726845038; x=1727449838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DJJMb8RSS4AQiwxpzvIgvhQjhF1XMXFRTCcE2Om75mQ=;
        b=Gaxz2gEiTsVcTwmcpXt3LA2Den9bMSuYZIyL6CTNIuNv2M6yaAYVebvC2tUL7vKGkg
         uVhO8iBxpWG8bSWQMKttKQR8DGmxWTGrBy7n4hsfMmPxcGJ5hlTxOTZ9wd/33PBSQt4W
         iksJTGLqc1yunscz1TgpoTRYlrupDnsS5liM6x/FdPXjXwnubmAGG/u1LmYn1h+Sz4mn
         u5Ah4IMzlrsGTT5ZAiDEcbWjvUTwV9/LBCNZu5GSgbLuK3YnxNsLyfN9xxWxFexq1D8c
         ehTVkEOzaWOfWVGNBrNj7/rw0g74YQug70bcPA3MnYLDzPVLKHvw93NcmMohnCAkXXez
         h81A==
X-Forwarded-Encrypted: i=1; AJvYcCUxjXVGvAciUefuFNlEq49KtGaJkspmhHM8sLXiCoQAIogqLH0tR79WEzKItk40kEyR5ah78w9v1XEjRh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrrDMlfTFpl2tT1xyW2tFSZab0ZggLXGna3URAUdZFni5owur3
	8YMejTNiXOgVdcpJjE2xbZhff7/MZaLbW7400v8mLr1SsucWmysIAwnrhvor9lw=
X-Google-Smtp-Source: AGHT+IHeudTP4G0KwruXvq75Uj6FmS+FTUetpEU0+/iBmXwgBmFFWT6xfJOUNZbgWuHMf51VOQGj8Q==
X-Received: by 2002:a05:6602:6c17:b0:831:fe52:c602 with SMTP id ca18e2360f4ac-83209eabdb1mr409460239f.15.1726845038296;
        Fri, 20 Sep 2024 08:10:38 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ebf483esm3601957173.10.2024.09.20.08.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 08:10:37 -0700 (PDT)
Message-ID: <f641378c-e729-4c5d-bf55-24a7fc96b623@linuxfoundation.org>
Date: Fri, 20 Sep 2024 09:10:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] Add KUnit tests for llist
To: David Gow <davidgow@google.com>
Cc: Artur Alves <arturacb@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 n@nfraprado.net, andrealmeid@riseup.net, vinicius@nukelet.com,
 diego.daniel.professional@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240917005116.304090-1-arturacb@gmail.com>
 <bd5eb792-124f-4eaa-9ff9-a99765d1ef73@linuxfoundation.org>
 <CABVgOSmNcmnRCn5Q05U1wBebSGTM=OdUXuT7SA-poHXUgKubaQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSmNcmnRCn5Q05U1wBebSGTM=OdUXuT7SA-poHXUgKubaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/24 01:10, David Gow wrote:
> On Fri, 20 Sept 2024 at 00:01, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 9/16/24 18:51, Artur Alves wrote:
>>> Hi all,
>>>
>>> This is part of a hackathon organized by LKCAMP[1], focused on writing
>>> tests using KUnit. We reached out a while ago asking for advice on what
>>> would be a useful contribution[2] and ended up choosing data structures
>>> that did not yet have tests.
>>>
>>> This patch adds tests for the llist data structure, defined in
>>> include/linux/llist.h, and is inspired by the KUnit tests for the doubly
>>> linked list in lib/list-test.c[3].
>>>
>>> It is important to note that this patch depends on the patch referenced
>>> in [4], as it utilizes the newly created lib/tests/ subdirectory.
>>>
>>> [1] https://lkcamp.dev/about/
>>> [2] https://lore.kernel.org/all/Zktnt7rjKryTh9-N@arch/
>>> [3] https://elixir.bootlin.com/linux/latest/source/lib/list-test.c
>>> [4] https://lore.kernel.org/all/20240720181025.work.002-kees@kernel.org/
>>>
>>> ---
>>> Changes in v3:
>>>       - Resolved checkpatch warnings:
>>>           - Renamed tests for macros starting with 'for_each'
>>
>> Shouldn't this a separate patch to make it easy to review?
>>
> 
> I think that, if this were renaming these in an already existing test
> (like the confusingly similar list test), then yes. But since it's
> only a change from v2, I think we're okay.
> 
>>>           - Removed link from commit message
>>>       - Replaced hardcoded constants with ENTRIES_SIZE
>>
>> Shouldn't this a separate patch to make it easy to review?
> 
> Again, if we want to change this in other tests (list, hlist) we
> should split it into a separate patch, but I think it's okay for llist
> to go in with these already cleaned up.
> 
>>
>>>       - Updated initialization of llist_node array
>>>       - Fixed typos
>>>       - Update Kconfig.debug message for llist_kunit
>>
>> Are these changes to existing code or warnings on your added code?
> 
> I think these are all changes to the added code since v2. Artur, is that right?
> 
>>>
>>> Changes in v2:
>>>       - Add MODULE_DESCRIPTION()
>>>       - Move the tests from lib/llist_kunit.c to lib/tests/llist_kunit.c
>>>       - Change the license from "GPL v2" to "GPL"
>>>
>>> Artur Alves (1):
>>>     lib/llist_kunit.c: add KUnit tests for llist
>>>
>>>    lib/Kconfig.debug       |  11 ++
>>>    lib/tests/Makefile      |   1 +
>>>    lib/tests/llist_kunit.c | 358 ++++++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 370 insertions(+)
>>>    create mode 100644 lib/tests/llist_kunit.c
>>>
>>
>> You are combining lot of changes in one single patch. Each change as a separate
>> patch will help reviewers.
>>
>> Adding new test should be a separate patch.
>>
>> - renaming as a separate patch
>>
> 
> I think given that these are just changes between patch versions, not
> renaming/modifying already committed code, that this is okay to go in
> as one patch?
> 
> The actual patch is only doing one thing: adding a test suite for the
> llist structure. I don't see the point in committing a version of it
> only to immediately rename things and clean bits up separately in this
> case.

I do think it will help to separate the renaming and adding a new test.
It makes it easier to follow.

thanks,
-- Shuah



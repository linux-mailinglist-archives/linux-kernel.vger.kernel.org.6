Return-Path: <linux-kernel+bounces-358628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A14ED99820F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8CC3B2A897
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26C11BBBFC;
	Thu, 10 Oct 2024 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehEAcb64"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641E71BC9E9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551500; cv=none; b=HTDbWQNhpwErtNMnEqlPCmbhvLc1JtVTmbDhIOW3P3uEAQhNtgdqv/zQ0+BqYbe3R6E8spQzh47iP2Rdhyd/90nLW9xao9m5VBzOAuSDwrjVnsFBq2OCpvwPWeJJbM/+e1yDHyn5KTLrh+A4eSWdguKKGB+TtvP4WYC8iDEQcUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551500; c=relaxed/simple;
	bh=lop93zME/MAk20ShSlwDXy/fimaoKZNuh+nrwS45zjg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FYCcVwh7uSUOlF7p63K9zAzFUObVDrAroozZUQC2uedZ0RF6DcQ5Pss68P5B4aTr7g0VPOnAWw8gKiSNhJt8PsV4OLP6u/IgToHWO1PYYLPLOCj/V1mV14Jg6h1g3spHyG1qc2Skzgt6RnFfMHYZeHk+hP74wyuu5Y0c5C/NacY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ehEAcb64; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43057f4a16eso5809195e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728551497; x=1729156297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h6JTCbobwY+WrBm4quxkMy51PYIhzCK3wsE6+gxsIc8=;
        b=ehEAcb64UnshT16y44TkcqXdXwVkFeWfTF39alQVQCdQAzQMkf3JhY/ieA8q2leSxb
         wJZVh+99TyAvHMvSmZrUj8wS0WuCYT63oaUv7trM1zlq28nS0v41EnjIr0UBHYaYzlc+
         Alw/0wF7vHu1sPB40FGCO5J25qYqu7h6ThR0qolCAC9fJlgEZfGlD6xWd7KOnmj5mjhA
         82PXhVi2C7Egmv6xftpu1X2eMFTACWGxcIpeW1AJ2awuZchikt3uG0zq9IBnFutPrrF5
         WdQvTYUxwnfUpBTrR8o/q7cCBYi76P8rl/7LeLLdUGwOv/6Rw7ZuAF2SqkXqoBuo1LmY
         lRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728551497; x=1729156297;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6JTCbobwY+WrBm4quxkMy51PYIhzCK3wsE6+gxsIc8=;
        b=DG0l8N5dnQRAn+F0Oc+eM95p9p6buxzHZUgCZUmT8qzvoMKvpOAshwEdKOY83wCdKq
         DsS0z83gV1aUa0h2VslRTZmEXb98E/lCs/W4Pr4g5ceQfOwO6CC2Peg76F909wFdUkAv
         QAgOY4c7zMurrtpDCNzzBpb9w/mSe8P9yK+43VqrlwIaaWH8myfKic4WrZYpZu6XCnRl
         cOxzsxhH5hQ84H2Wrqib0nDRx16JiFRFZxIuG5Miwu+PInoJ7vyMuWnZn3X7CWb2bOaL
         ACM7XIqr/pQ9gstO6wTny2yYsLaJP7GjxFCUlGMdJDl1CqGC108xv1/cFtFhZOrsxXVy
         nOBA==
X-Forwarded-Encrypted: i=1; AJvYcCUeRLKEZoKF3X3ARBBsDDABQtgeGoelgRJhFrMCA2/u6rDZewhIfUp8ZKZOy2Csc/FHbdgqdiEIcgNmmdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYS6xDiM9NpZlfxOEJNh0NO3CXKjxbWikZRCnp+21gsZKSyPo6
	P7AlMjOXCvrZFuqIzgc5KB5Y+1HIZR3Ra7mFOB0SqXGtg9oJyIDre1ZjIqMASKw=
X-Google-Smtp-Source: AGHT+IFBsRb0rbqSkjKUmR415ghSYtyxxKX74L/CjXBW9IVAWKIH/NxpFP3toMV1RSim/i2R4l25gg==
X-Received: by 2002:a05:600c:a00a:b0:42f:75e0:7829 with SMTP id 5b1f17b1804b1-431157f436dmr24289665e9.30.1728551496657;
        Thu, 10 Oct 2024 02:11:36 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431183565desm9878205e9.32.2024.10.10.02.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 02:11:36 -0700 (PDT)
Message-ID: <5f3f55a8-a378-4e16-8e5b-6fff329e75fd@linaro.org>
Date: Thu, 10 Oct 2024 10:11:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf build: Require at least clang 16.0.6 to build
 BPF skeletons
From: James Clark <james.clark@linaro.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 Namhyung Kim <namhyung@kernel.org>, Howard Chu <howardchu95@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users <linux-perf-users@vger.kernel.org>
References: <caad2d84-a8ff-4304-b8ab-04642ea18323@linaro.org>
 <ZuL_0V5jgaaEUOY_@x1> <49fe18ff-827a-429b-9d74-9d8ed02ac409@linaro.org>
 <CA+JHD936J-q0-7LANQ3aW2G-PEmFP8PnXQ-TF-AMs9MtrCqfew@mail.gmail.com>
 <CAH0uvojUEXiT2mk1pknLS1nc-gA3Py+AjmEW22ETiCCyOLLr8Q@mail.gmail.com>
 <CAH0uvogXyYP1LqF3fbjZGHHDL6BFZ2ZKu5JAASnK_brgnymf0w@mail.gmail.com>
 <CAH0uvohEozKixjDM9_jJ5FFxYK7agsqVO-BrAsm=4hCTDQAx2A@mail.gmail.com>
 <9bbfe425-1f2b-4846-a5a3-a31618742e9a@oracle.com>
 <CAH0uvojJ1rME4hb6NfrA4NPj2XmGMDLOLP3wEbHh8B5-qWGvFQ@mail.gmail.com>
 <CAH0uvohW7_st0i=ek8rc_SucuQEQUgs+fWt12cc3jqiYfxAjmw@mail.gmail.com>
 <ZwcnVKn3wVSSMcaL@google.com>
 <CA+JHD93JgJL_4GJFcFUNu-FpNfFOoyDRJ7QuvO82M8G1EwM5pQ@mail.gmail.com>
 <bcf50648-3c7e-4513-8717-0d14492c53b9@linaro.org>
Content-Language: en-US
In-Reply-To: <bcf50648-3c7e-4513-8717-0d14492c53b9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/10/2024 10:00 am, James Clark wrote:
> 
> 
> On 10/10/2024 2:20 am, Arnaldo Carvalho de Melo wrote:
>> On Wed, Oct 9, 2024, 10:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>>> On Tue, Oct 08, 2024 at 12:27:24AM -0700, Howard Chu wrote:
>>>> Hi Alan, Arnaldo and James,
>>>>
>>>> This problem was solved in [PATCH 0/2] perf trace: Fix support for the
>>>> new BPF feature in clang 12 (Link:
>>>>
>>> https://lore.kernel.org/linux-perf-users/20241007051414.2995674-1- 
>>> howardchu95@gmail.com/T/#t
>>> ),
>>>> sorry I forgot to cc you two.
>>>>
>>>> Alan's thought was correct. Thank you so much! :)
>>>
>>> It'd be great if any of you can test this change.  Now I only have
>>> machines with clang 16.
>>>
>>
>> I'll test this tomorrow.
>>
>> - Arnaldo
>>
>>>
>>> Thanks,
>>> Namhyung
>>>
>>>
>>
> 
> Tested with clang 15:
> 
> $ sudo perf trace -e write --max-events=100 -- echo hello
> 
>    0.000 ( 0.014 ms): echo/834165 write(fd: 1, buf: hello\10, count: 6)
>                                             =
> 
> Tested-by: James Clark <james.clark@linaro.org>
> 

Should have left this tag on the actual patch. Will re-post it there.



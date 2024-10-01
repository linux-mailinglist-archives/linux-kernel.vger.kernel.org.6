Return-Path: <linux-kernel+bounces-346048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D1A98BEB6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7F31F23A7D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A9D1C6F43;
	Tue,  1 Oct 2024 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcyJSRnK"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211E21C68AF
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791070; cv=none; b=Ci1NWWPhKtTA+9aXDbnRJyBC4UZT5467sOOs54vqZ7KQU8eeQJii4WGAfN7+WE2tkAbGjIdbgvXtlyO/BYsLi/IwyIlwK2CGG99ZzxofjErQl6Xy5I0pRArIo9hIRj9y+61Rzuhm3oEoHD+l9lMi3kOfJhRm1XH8ZHY8L2KY/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791070; c=relaxed/simple;
	bh=jvTeJqdjVh8BbYEjs3qIqtSoQPkfpt4ys9h85rINLo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWC7mdcnzg2ecayHmifEV4N9405o0XVZIEvRkDzFr85YsG9oWIliH+06k059JL/nSwprlcuMSrk8cII/tbe8q5Us1qdooND77MHjlo4zsODDcxoGDXT5PLPzPmD5C9FvoJA6l0xL9cuojFxIL05Ygdkm+19apmsWZ8pgreAtBYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RcyJSRnK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so1219781366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727791067; x=1728395867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UzrewytZX4x2Dhm5y4nov57RSswWXBHTu+zxZpSsOaY=;
        b=RcyJSRnKhNLysk1UcrxkD62gdyrik3GMm+vimWN9RdELLkVhj5Da0Y0KbjTg1ydV9T
         tODqwcSKSPsEcP7jJZOwL58tzzCHDGdsSL9PxTzOwcUsDy8leGbFZeRDVYT7rs7dlK+d
         yg9OiGAM3SqvVCu8BoELnWk1tf0e7oaEP35qWghJdR3Y88V6CNMkDHJiZkkaaszNlvjr
         1J8Mc+p6aDH/zjsJM36hRLfhiws+PevWknu+p/J4/ADeOCd/Q12G++LiTJqfDg0GzO1B
         MIMCWloK+t3OWYkuhXNvpDaX6hzjKQwMyZ3owKiighYb3Dk2S5rFYWz5XJHSvRH9Sbah
         1RNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791067; x=1728395867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzrewytZX4x2Dhm5y4nov57RSswWXBHTu+zxZpSsOaY=;
        b=ou1qCdRDkSl0Nzv/hRiPTJiVcOTfoYR4JJgyFVmhUp7v8wogGOeLOKajf1zUT1mX5z
         IAYz+uh/PagC0u8XxYU00ejO6a2dxiMCgt9yrgdKQv/G2z1bigmVTrx6ROqL7icao5Dv
         /KBy3GPS875wEC1ZrYWjmsxKQonQ96ooHkTSrzbReZMyfHVaYePMLwEdUCv0+ZOdSeYj
         WX22Am0ghaF6MaoZqrb8kiF1bOsWa9xYWgG6bEErGXxQ0GoxGHeuAaeeqsP5jVZpds5z
         31qG1h8d1uVsG+dKFU0+nnogMT0ciA70/61zkez1w74vR/IKfI1Vab5H98iXQLJsuMwV
         j1dA==
X-Forwarded-Encrypted: i=1; AJvYcCWtqcbhROciUkwjhImc2aWudS0pLhozpPgYnURVcct7K7sxf/c/lebBNzEyzjkJpv5sEb27Mp59r3KFvWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF2tpAqcll3lRHClxkiNDTPTVmZNC/WjtrjCmaYoTpt05pZzoP
	/nLWypVbL6rQ7Q4KEHzSTktkEzC6DxPH2TfhYbZLkez9lpb8kptqAEfkTsIP5Vk=
X-Google-Smtp-Source: AGHT+IGgYvloqWvCe/iRPFkUzCxEs/DaBdxvqoYrIA4evpeVeZO/xxTaBJ+9VJvbL0CddUVZfeqBCw==
X-Received: by 2002:a17:906:c52:b0:a98:c4b7:7971 with SMTP id a640c23a62f3a-a98c4b787b9mr227638166b.32.1727791067439;
        Tue, 01 Oct 2024 06:57:47 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c58fbsm715322266b.56.2024.10.01.06.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 06:57:46 -0700 (PDT)
Message-ID: <abfe5431-4845-4bf8-89a1-331f68f76d05@linaro.org>
Date: Tue, 1 Oct 2024 14:57:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf dwarf-aux: Fix build with
 !HAVE_DWARF_GETLOCATIONS_SUPPORT
To: Ian Rogers <irogers@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain
 <kjain@linux.ibm.com>, linux-kernel@vger.kernel.org
References: <20241001123625.1063153-1-james.clark@linaro.org>
 <Zvv9eBDrquBHBHhF@x1>
 <CAP-5=fX3X22NS35YQwcMgv03Cw9acjDC_AC-Yocm-zMJXpBg4g@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fX3X22NS35YQwcMgv03Cw9acjDC_AC-Yocm-zMJXpBg4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 01/10/2024 2:51 pm, Ian Rogers wrote:
> On Tue, Oct 1, 2024 at 6:47 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>
>> On Tue, Oct 01, 2024 at 01:36:25PM +0100, James Clark wrote:
>>> The linked fixes commit added an #include "dwarf-aux.h" to disasm.h
>>> which gets picked up in a lot of places. Without
>>> HAVE_DWARF_GETLOCATIONS_SUPPORT the stubs return an errno, so include
>>> errno.h to fix the following build error:
>>>
>>>    In file included from util/disasm.h:8,
>>>                   from util/annotate.h:16,
>>>                   from builtin-top.c:23:
>>>    util/dwarf-aux.h: In function 'die_get_var_range':
>>>    util/dwarf-aux.h:183:10: error: 'ENOTSUP' undeclared (first use in this function)
>>>      183 |  return -ENOTSUP;
>>>          |          ^~~~~~~
>>>
>>> Fixes: 782959ac248a ("perf annotate: Add "update_insn_state" callback function to handle arch specific instruction tracking")
>>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> There are a few variants of this same patch flying around:
> https://lore.kernel.org/lkml/20240919013513.118527-4-yangjihong@bytedance.com/
> https://lore.kernel.org/lkml/20240924003720.617258-4-irogers@google.com/
> Just a heads up that we only need to apply 1.
> 
> Thanks,
> Ian
> 

Oops thanks for the heads up. Usually I check if it was already posted 
but this time it was so small I didn't do it. I'll check next time...

I don't think the fixes commit on 
https://lore.kernel.org/lkml/20240919013513.118527-4-yangjihong@bytedance.com/ 
is quite right though, so maybe this one is slightly better.



Return-Path: <linux-kernel+bounces-443342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B4D9EED7D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A5C2898AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887522210E8;
	Thu, 12 Dec 2024 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vejWZShE"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0755B221D93
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018360; cv=none; b=Wdg74E0Pmx1FUSolXDVbBexY7AKmqpZeBQRbjg+OOVS3mgB0AH/mRZBP+3gYsebikysuRHjfHOP+iz9IxWIuaP5iSwX0RHqTTB7BOhm/V6UuUSLnNol7cHu1v4JFEwypcyaKQg3xWMLbAv8X/xvI1LZ0oSP7420oASO8I/da2Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018360; c=relaxed/simple;
	bh=7CZj15hBqctqnSbld2qny0agH0G5KAVCp5x5TNafiRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oC+kGTA9mISy8tDKSgw2ktSDvcknsdgVpjQkce9fViImP/o0Sc/Xp96CShDMA3KCz4cflz9P9VLMnZP6Oppc6qtQ4nfwUCuJQ+l0lJbQsG6y1+DJMlh8ZhBkZPGRUIEBGkrgJIwwCeD0Y862o3CusdCOaH5MKUoHNs7DzwdvwqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vejWZShE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so421852f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734018357; x=1734623157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6a1zDSEYLXc+eJA0b3qVc7acpkK4+miJnhJ0ZW+WWX8=;
        b=vejWZShEZ+dK9+YsiBgY7GoOMHVKp9tkYSKGEU/cgn3lLy5SRuDIFsmKUp4VTsCNhq
         ZbtRDZdHdVzzXANMoTxN7PLeIDWQpDbctgWjw9uzUV3cX7NirpPFcKQpwLyd2/ApDcbr
         cNgStaNbALoWFAE63O3cleBPoda3nV/WxUZM8s4+ldceewiCvtckYOtXr618zAlPWgqQ
         lshQVpMILqqaNSni6Mzt0jUZyyZy9sf3yOQRc3Sp3hpNsTQugurdFu2e3Gap4oakGI1/
         F/yZ9VkjS67GgXG7p6f3qDjDVsQwbb30rj/8OaDnOeblfIsm2K63kn9Tsy5C7g5n0Dq+
         VD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734018357; x=1734623157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6a1zDSEYLXc+eJA0b3qVc7acpkK4+miJnhJ0ZW+WWX8=;
        b=bZYScxcq3h3J5DWysA3SCrm6K8MpCk1kJJiFA4MCRph4hJIygIlE4n7F0OdRlwzKL4
         2i2GgndRzrytijguUT2ymbApH9pdtjKb95P+gBTDBO8Y2ZHewpSNo/UaO45oxuNm7Bj+
         If/l4cDNLESs5FhxlUFmmcI53zTnYbE9LU1i19GAtQfl1CgbRE3DqStSdZUsVTxIkYl+
         Nl+YQJJoiW8L50DwQp49hmKAwcjlCK9tKOPVQ0SSThAcN8z7TQBccN4s6u+x7mZ+cTSB
         K/pfAJyUEhqLiAurnxsu6IO9ETzVxnzgBXAfIJ2M8YbDZP0pymb07pdcxT2W5U6w7/KT
         Asew==
X-Forwarded-Encrypted: i=1; AJvYcCWTgKCFL2zVOaXNFO/Kk3xyhnnbLUWAeiI3+QvE49ZL32IaR6F56rATarR5ONmFmSA/2PDk/oZ/B4Wq4XU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiWSYpxOG548FoUSJI6Y8/MIMNgfNke3MSCtaMUCMaQhnBQm0T
	jvktexbYd9iCQJsdqqEnOPicbbtTlk0maBHvOkcddgMiE0yvLixSG9SoLXnEdjc=
X-Gm-Gg: ASbGncu3+cDZFgrWduSRMT5nNSNmBXRHXR9Vd3yhb1v3Cx0y4KKZ9aAD1ftQKSXN2UC
	YNvzp4hpCjCn6xt+5dgJ2Wf2mCxCsgcqoiOuAQhO68GDOzrU0i45UkOmTMSZMpUCmMHNZIqLFB0
	Nq1TX1uCMJ7kl6PH2VZvF4PPG7BTEhgnpBtukI5NJGUcVEdefOD6FZzDHn2ns+lm0YtfucCtHRA
	GyQ+N8kIB3We3obTVK9TcLnbGi+0CyD2HlSu2JhRA8LcpBrANqy/PERm9WEYiXQOmY=
X-Google-Smtp-Source: AGHT+IFTDlMjXTmHhNf213X7LLWtzJR/Hkn4hyuAJCLqqxMOf4mdJJzUGGOYyWTGWfD2Hf8SJQAU+w==
X-Received: by 2002:a05:6000:1f82:b0:385:f56c:d90a with SMTP id ffacd0b85a97d-3864ced1f55mr6224618f8f.55.1734018357326;
        Thu, 12 Dec 2024 07:45:57 -0800 (PST)
Received: from [192.168.68.163] ([145.224.65.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387825296desm4316543f8f.111.2024.12.12.07.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 07:45:56 -0800 (PST)
Message-ID: <f37cd857-7577-4275-b799-1445fd31d321@linaro.org>
Date: Thu, 12 Dec 2024 15:45:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test stat: Avoid hybrid assumption when
 virtualized
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241211061010.806868-1-irogers@google.com>
 <7c118b40-3b31-46d0-8967-e7c35f6a4868@linaro.org>
 <CAP-5=fVxPaSYtB62ZqcLOG1F9Va-0rwBWUCiVNdaBpmsGXUVaA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fVxPaSYtB62ZqcLOG1F9Va-0rwBWUCiVNdaBpmsGXUVaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/12/2024 5:58 pm, Ian Rogers wrote:
> On Wed, Dec 11, 2024 at 1:50 AM James Clark <james.clark@linaro.org> wrote:
>>
>> On 11/12/2024 6:10 am, Ian Rogers wrote:
>>> The cycles event will fallback to task-clock in the hybrid test when
>>> running virtualized. Change the test to not fail for this.
>>>
>>> Fixes: a6b8bb2addd0 ("perf test: Add a test for default perf stat command")
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>    tools/perf/tests/shell/stat.sh | 10 +++++++---
>>>    1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
>>> index 5a2ca2bcf94d..60cea07350e1 100755
>>> --- a/tools/perf/tests/shell/stat.sh
>>> +++ b/tools/perf/tests/shell/stat.sh
>>> @@ -165,9 +165,13 @@ test_hybrid() {
>>>
>>>      if [ "$pmus" -ne "$cycles_events" ]
>>>      then
>>> -    echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
>>> -    err=1
>>> -    return
>>> +     # If virtualized the software task-clock event will be used.
>>> +     if ! perf stat -- true 2>&1 | grep -q "task-clock"
>>> +     then
>>> +       echo "hybrid test [Found $pmus PMUs but $cycles_events cycles events. Failed]"
>>> +       err=1
>>> +       return
>>> +     fi
>>>      fi
>>>      echo "hybrid test [Success]"
>>>    }
>>
>> Hi Ian,
>>
>> Isn't the distinction between task-clock and cpu-clock whether the event
>> is per-cpu or not?
>>
>> $ perf stat -C 1 -- true 2>&1 | grep cpu-clock
>>                 1.49 msec cpu-clock       #    0.917 CPUs utilized
>>
>> $ perf stat -- true 2>&1 | grep task-clock
>>                 0.30 msec task-clock      #    0.366 CPUs utilized
>>
>> The test uses per-task mode so this change makes it always pass, even
>> when the number of cycles events doesn't match the PMUs.
> 
> So I'm confused by the test, but it has caused a passing test to be
> broken for me when I run virtualized. The test is checking a cycles
> event is opened on each hybrid PMU, but this is conflated with
> checking perf stat's "default" output. The cycles event will fall back
> to task-clock in per-task mode but we also open a task-clock in
> default mode. Should:
> ```
> if [ "$pmus" -ne "$cycles_events" ]
> ```
> be something like this then:
> ```
> # The expectation is that default output will have a cycles events on
> each hybrid
> # PMU, but in situations with no cycles PMU events, like
> virtualized,this can fall
> # back to task-clock and so the end count may be 0. Fail if neither
> condition holds.
> if [ "$pmus" -ne "$cycles_events" ] && [ "$pmus" -ne "0" ]

Yes it might make sense to skip this part if pmus == 0 then. Namhyung 
suggested to always assume 1 PMU to cover platforms that don't publish 
any PMU with the cpus file, but I suppose that breaks in this case.

If you still add the fallback check for task-clock it covers hybrid, 1 
PMU and virtualized and we could even rename the test to 
test_default_stat_2.

> ```
> 
> Thanks,
> Ian



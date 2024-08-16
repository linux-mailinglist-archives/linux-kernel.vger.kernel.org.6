Return-Path: <linux-kernel+bounces-289326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5DE9544EA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E01B1F2462B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDDC13B286;
	Fri, 16 Aug 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rXn2nUSQ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECBD13AD3F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798664; cv=none; b=Ow4ic6Jry0zjXNvxQ3ShXR7tcj9rdP9NiF1m4uz8YTkO/Catoa9tuegoRkuaFuyoQRu3MVJu/KFmpwCp9J5L0QIvJ/BPbxqi9T/ZkDV3et1l59xX4uKg92ZzBxXvzBEtjJdkvtFg/GLPfh1WEvDKjZ6UbYuagGW2FBDjMpuDbCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798664; c=relaxed/simple;
	bh=fETSMc2hQRMfQ2Q133dwwdGv+eoSJjlO71/zUgfQKn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bd4EBsGS2S9dvIhbWi3SkdxkLMts1EyBkXz6ZypGvRrcORTpH2lIzDIiKv+R+FEHUTNEYW/DYjP1jCwQYacOcg2z0gKGyM3VDhgmzIEl8Q13NEUG7xt//qBmLQjNaK7HPFQRhD2k3EiY3GVvo2fA+4nf6gaEY6je5d1OtRzbWsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rXn2nUSQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso12694855e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723798661; x=1724403461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pp9E1jzP/7LqcZV9OE83mHHXcT7BGqq4jDbXGUvR/tE=;
        b=rXn2nUSQqmqKpy1Z9/NPWXV4hYgLUVBwmHPzUrJrGWFZ1G7FaTZy3Hcaqba2GXuzEX
         ARJsHSGLBU9IDaAzSc+h4U7FFmQWslTYgHpEGt5pwFx1Wu8PpPuBZ1Chy5fE0ccl+Gi2
         L9TXW9P4BQucz++ASBpNaFhbF6VYrbossASXGxohtB5eIvnrJMbEOuFroxlYUd+Nk0dt
         /t79lgid2wLNv4mDtMYKsEl03qF1NPfS4FFKIOqV+fbrOlOZU09Kli3Wloid39uwF5Sb
         DUJ4bjrzo8M+WCsok2W4bM58CWb/ddxkpo1h6GZDKoI8lJMJxA4wiqVGHZ1kYfAT/o0b
         P0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723798661; x=1724403461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pp9E1jzP/7LqcZV9OE83mHHXcT7BGqq4jDbXGUvR/tE=;
        b=ZyiNs+sjQM4LlLI4dbodk1eR1DLBkLLWF8Fp/bwT6phDTOBlTrOvjhRlZU/97lPOL0
         JyLbR2UXce0/4hVg4gjVNoHJn7FXdus8w8cagq5N9LlsM4nnJKPb5fYMoe8UBmswFAfE
         BrIZuMbOcdZOd+UTWhEZz1hgnUEN9EZhwM5IYM1lZqujO1/rxzlD8Fdzc0LMNiDxjffq
         Pu1GN6SglvxJxX+aq+fC2DiORR3ohtTFtk/flnxY46LPEpQfbOtwK6i+82htRFFqhlhX
         txUjK/O8RQZ0Fjulo9egeufcTErIKtPEn/ofyDflHvMYLMdfOkVK7Yf58wTnpBE+Zefa
         La3g==
X-Forwarded-Encrypted: i=1; AJvYcCV9f9QCyi2O36lURRH0Jua1ylcZj/hjbQ39LPz4OzaSq2s5GUc7fZTLidVUyne8WfzWF9Horwsxx5OGbLuflRq7JYDTInnUO+TSC+dI
X-Gm-Message-State: AOJu0YyJKKeuX626zytVynD4lKdygf0qsptlU4ZjVnDxdn4zwyU3Ngh4
	MEr166TKH7rgo/zkEtclrPBYi546jmxgIrvTMs2+9R55awFgnQjI6yg1DH4FLgo=
X-Google-Smtp-Source: AGHT+IGz56bQpjBbGo0uOLNED6Eyr940dKNOhXmrjPU5vtmy0ylGk957l6Yh8SHw3K/Bcwg+P9nRjQ==
X-Received: by 2002:a05:600c:1f90:b0:426:6960:34b0 with SMTP id 5b1f17b1804b1-429ed7bab7fmr13192735e9.14.1723798660662;
        Fri, 16 Aug 2024 01:57:40 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed794640sm16916315e9.41.2024.08.16.01.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 01:57:40 -0700 (PDT)
Message-ID: <88cea92d-98ee-4a1e-8a44-a7c6a247ba2e@linaro.org>
Date: Fri, 16 Aug 2024 09:57:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Ian Rogers <irogers@google.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Linux perf Profiling <linux-perf-users@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 James Clark <james.clark@arm.com>, "cc: Marc Zyngier" <maz@kernel.org>,
 Hector Martin <marcan@marcan.st>, Asahi Linux <asahi@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <ZV1AnNB2CSbAUFVg@archie.me>
 <a9c14dfd-3269-4758-9174-4710bef07088@leemhuis.info>
 <CAP-5=fXqx_k1miPTkcAmS3z2GBPt2KeDtP5fknmdDghZqxXPew@mail.gmail.com>
 <714ed350-0e6c-4922-bf65-36de48f62879@leemhuis.info>
 <0de3b572-f5f7-42e4-b410-d1e315943a3c@linaro.org> <ZrzeRM3ekLl9zp3z@x1>
 <348ea015-eccf-4f44-a332-a1d9d8baf81f@linaro.org> <Zr4eWd6HWLHDcpC9@x1>
 <Zr4kZTxgvD6bmi37@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Zr4kZTxgvD6bmi37@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/08/2024 4:53 pm, Arnaldo Carvalho de Melo wrote:
> On Thu, Aug 15, 2024 at 12:27:21PM -0300, Arnaldo Carvalho de Melo wrote:
>> On Thu, Aug 15, 2024 at 04:15:41PM +0100, James Clark wrote:
>>> In one of your investigations here
>>> https://lore.kernel.org/lkml/Zld3dlJHjFMFG02v@x1/ comparing "cycles",
>>> "cpu-cycles" and "cpu_cycles" events on Arm you say only some of them open
>>> events on both core types. I wasn't able to reproduce that on
>>> perf-tools-next (27ac597c0e) or v6.9 (a38297e3fb) for perf record or stat. I
>>> guessed the 6.9 tag because you only mentioned it was on tip and it was 29th
>>> May. For me they all open exactly the same two legacy events with the
>>> extended type ID set.
>>>
>>> It looks like the behavior you see would be caused by either missing this
>>> kernel change:
>>>
>>>    5c81672865 ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability")
>>>     (v6.6 release)
> 
> What I have now is:
> 
> 6.1.92-15907-gf36fd2695db3
> 
> It was a bit older, but 6.1 ish as well, I'll try to either get a new
> kernel from Libre Computer or build one myself.
> 
> - Arnaldo
>

Thanks for the confirmation. In that case you may not even need to 
retest. I was only wondering if it was broken from v6.6 onwards, but 6.1 
not working is expected. And I'm certain that you'll find any later 
versions working.

>>> Or this userspace change, but unlikely as it was a fix for Apple M hardware:
>>>
>>>    25412c036 ("perf print-events: make is_event_supported() more robust")
>>>     (v6.9 release)
>>>
>>> Do you remember if you were using a new kernel or only testing a new Perf?
>>
>> I normally use the distro/SoC provided kernel, didn't I add the 'uname
>> -a' output in those investigations (/me slaps himself in the face
>> speculatively...)?


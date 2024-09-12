Return-Path: <linux-kernel+bounces-326785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF734976CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D07B252D0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A811AD27D;
	Thu, 12 Sep 2024 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TX+Q0AIw"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ABE3D994
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153242; cv=none; b=lmYHa4Od2oDMvzalimRbuI2G8XDfJ29/SBv0ECraaR0LlxloPlmrWzaRvDurFeC/drNOouaoHN3ycCrPlccFPv/tcTxWHg/Uku4g6Kt6CPpAYCs+hLwYMCbsTkqz6rnVuiwQ8tP+zC/Eq/9UilAiKTZlLzAraCYgkKHr0RqRZ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153242; c=relaxed/simple;
	bh=qp4tup2O1mnu9IXtGzVcuYfiHWi5bTJU4SY95s7YP9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPN2CCPPXMQBN7a/fVlMTZI9rGAn01Xg49R1T/wIkR6y8X8tqoQIIWHIgWL5m2949L6fgPIrCbBGHLo6ZHG+q/wiczQJoeDhVvy1LVSA1GKoS7wOpSeRq6AAu+eDaymuOTlWjzwcxDPvCL6BbcLsEGk8SnBJen+wXwnPlfxLwLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TX+Q0AIw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c6187b6eso891633f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726153239; x=1726758039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MY8Q22WrN9A6BKqFuPJeUqXRj2azetZ70kLGvEilHa4=;
        b=TX+Q0AIwanEl8jcNP6xC5YJ3aYCZES6dk7uNLFkdOONXayuIcNI+Cf11grO3xC/I+d
         +DyohNQkeQmBf2BTRp0zbaa+nXgf00U7MctqqXEC5Aq5SlLZyVrdz9JQOi1/quP1Y1Hl
         Ct6zzAolIogtr0Pt8lf16Bb1r97Ret9MVzh+ipcQqA2350zUzIbWuu3xY5SEx4Qn6zA4
         IMn8CVXXYY5ND9ZHqG8y4cDIPe2T7Qtb3PA7BuoKbjAM4E9nRekUXtLkMp2b0nuiK/rl
         enyQ2oLyCxt2PD/HOZS9L8DkUKkitnyuL6XyPRb32DozwhparXCnsa3sYPzTe/5T7vwN
         q3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153239; x=1726758039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MY8Q22WrN9A6BKqFuPJeUqXRj2azetZ70kLGvEilHa4=;
        b=goG1ORQDW3lC+0MNnvbDeDmLb4VbzRgGP2mLhH1oLHyQ03AQ63ho09IUUKg5QK9d63
         Y5qf3KLeqbTbZ1tpcBdKc9X1+UCcAI2auZrga2ZO+hi58BTXIqxnpnC4BqWVxtebqcsU
         5K7085+6sRmq4ppKyeA3ogy9E1EyPBY5WXcBhxn3836eVnCy8zOv+PLzujK5RUyfEk7J
         WD0q1wNtPtQ3Y4nf9Nyec4fffX2V3e7RIAr/IY9byxCzABJGcnLLxaAWXQ2ynaEUOn+7
         2Kz87gTCuxDaM5zlJXDkaLZc+At+IRNGfrtyQ9OJhl59+m90RlSrd0T/gNyrVwSAGDSg
         j9Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUPV9eS8GdWEb0Tz/SzuHw8m3kgT6kYDG48a/BrGeqcwdOSwayqy9DmYsaLTPKy20bGp1RgdsV2tlMBHLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8mKqj5AbjYGu0XJypv8/ZDPJMWwV8qH4z+dW2UvkHTb6zaGMr
	GTzcy+lLDZCg1m0LWeHImy5bhO8QFF3PdhsXNKCUk6c+9b2//67lqid8nOV1B4E=
X-Google-Smtp-Source: AGHT+IGt2LV5vxwZxZEoCpaKVdX6X/qt4lXoMCZRBVwOgBfiAVMXupPwaDud3LSNSNf2EyLbJ5DHgQ==
X-Received: by 2002:adf:ce10:0:b0:374:c15a:8556 with SMTP id ffacd0b85a97d-378c2d620d4mr1879565f8f.50.1726153238625;
        Thu, 12 Sep 2024 08:00:38 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956ddbbbsm14419453f8f.93.2024.09.12.08.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 08:00:38 -0700 (PDT)
Message-ID: <71023502-b38b-44f9-8b04-96324b3bb461@linaro.org>
Date: Thu, 12 Sep 2024 16:00:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf build: Require at least clang 16.0.6 to build
 BPF skeletons
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org
References: <ZuGL9ROeTV2uXoSp@x1>
 <caad2d84-a8ff-4304-b8ab-04642ea18323@linaro.org> <ZuL_0V5jgaaEUOY_@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZuL_0V5jgaaEUOY_@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/09/2024 15:50, Arnaldo Carvalho de Melo wrote:
> On Thu, Sep 12, 2024 at 03:40:32PM +0100, James Clark wrote:
>> On 11/09/2024 13:24, Arnaldo Carvalho de Melo wrote:
>>> Howard reported problems using perf features that use BPF:
> 
>>>     perf $ clang -v
>>>     Debian clang version 15.0.6
>>>     Target: x86_64-pc-linux-gnu
>>>     Thread model: posix
>>>     InstalledDir: /bin
>>>     Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>>>     Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>>>     Candidate multilib: .;@m64
>>>     Selected multilib: .;@m64
>>>     perf $ ./perf trace -e write --max-events=1
>>>     libbpf: prog 'sys_enter_rename': BPF program load failed: Permission denied
>>>     libbpf: prog 'sys_enter_rename': -- BEGIN PROG LOAD LOG --
>>>     0: R1=ctx() R10=fp0
>>>
>>> But it works with:
>>>
>>>     perf $ clang -v
>>>     Debian clang version 16.0.6 (15~deb12u1)
>>>     Target: x86_64-pc-linux-gnu
>>>     Thread model: posix
>>>     InstalledDir: /bin
>>>     Found candidate GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>>>     Selected GCC installation: /bin/../lib/gcc/x86_64-linux-gnu/12
>>>     Candidate multilib: .;@m64
>>>     Selected multilib: .;@m64
>>>     perf $ ./perf trace -e write --max-events=1
>>>          0.000 ( 0.009 ms): gmain/1448 write(fd: 4, buf: \1\0\0\0\0\0\0\0, count: 8)                         = 8 (kworker/0:0-eve)
>>>     perf $
>>>
>>> So lets make that the required version, if you happen to have a slightly
>>> older version where this work, please report so that we can adjust the
>>> minimum required version.
>   
>> I wasn't able to reproduce the issue with either of these versions. But I
>> suppose it could be an issue with only 15.0.6.
> 
> Interesting, that complicates things, probably the best way then is to
> try to build it, if it fails, mention that 15.0.6 is known to be
> problematic and suggest working versions?
> 
> - Arnaldo
>   

I'll try to build it and see. But Ubuntu 22 only has clang 11 to 15 so 
making 16 the minimum could be an issue.


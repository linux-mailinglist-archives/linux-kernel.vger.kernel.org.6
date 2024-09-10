Return-Path: <linux-kernel+bounces-322771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C64C972D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6761C24562
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C70188CB6;
	Tue, 10 Sep 2024 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcjHLrcw"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A2B183CB0
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960431; cv=none; b=SMdg3pJh1MiZlzVNGPST3iZ+V4X/94k8bc5ejNrrVsr0RTLurGDDixJHJDDrtwEeJmjLsQhwkTDDwhgpi4HqheyjIzZkPuqB1AzNvyLQTSZmUCAM7QEAuQjWtLpJ9lBR58GwbsHhJbBGyKuyFkx36C7HIR7zjBva0k0/q9W4GCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960431; c=relaxed/simple;
	bh=RE9dfDh6uRSP27iyUBTSLq78I6DFJENc6hMNha/gAZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1CsyWJ5jYWvahanbZGCFz97Oyjq+M9Ni1X21s2WlXkmORU8/ld1p3LJaQXLt645IjukI8d3I6fkslTJn3tKN/njL8r0HGwbav2YDWZ7Y7P0a5LYcSQVUoe1cOXhbDObyoCRiNhZOBsRHIdx9+tE5ka+/+UgMwulW+PgecVOQJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kcjHLrcw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso12030815e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725960428; x=1726565228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ChPgvOW5+NGSApSDi5o4RkOv4a3E2yiO8R7EMr0wM6Y=;
        b=kcjHLrcwaKhEAT4BMf2alPhPQjvmw85FBbn72U34rhrtSJiMxiK/wWSfT6KjTNkaTn
         nud0f/GeQ1Pm95iDi4HN4Dah4F6mg+fPHFKNXMpX1EpZIJlAYnLxa24PuYgr2rzK2QQh
         Gx3fbFxg28YW4C3q3/bGQfMGiATIDQo8jwSGgePNdNnWQaSCVAcOas2QIEApkY4ATKQ2
         hm/YMZ931X2y8R0WRAcf4jTcK7LrKmJ5TcqxGdLL2+ZGEsSXntruJlo0jo6kHi/3mnWc
         L8XhGe5DVA3C3Pa1IyN5tfA4/ZtfIieBmbksTDj+v6tB7ioZz5ThyUIeykJpqd9KobKp
         uT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725960428; x=1726565228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChPgvOW5+NGSApSDi5o4RkOv4a3E2yiO8R7EMr0wM6Y=;
        b=v0nLRx1CyvE1pctiqcMwsfGSyGkjLQE0DdPOVyGYJIH9sjNMDdEIlImgbYToSe6Tvi
         HjQe1V25e/3zLnvIilnstPeE0TfU2n+cJaC81xKGiB/LvPjPuZWOp+TDSBt+ooMhnM8y
         yKOtlxb0JOXqpZxXSkW4KY1aiHoJ5Ovl37C+11ra8sWygemn/P2WhXehO5EqOZIiJf+E
         uX9x6bN27a37mI5ZScEWrEJG/cW7VSEU79v5shB1vfZbV2nDS5X1YB3CbDnGdCMQIn3k
         jINq/GWfsZQnaYFp2IuuqZxgD3jhjg+pwP+lxSYbTE/daMe1aSS9xQB6U3VL765tzriz
         Q9bg==
X-Forwarded-Encrypted: i=1; AJvYcCUXa1MGC/ZyZkXkj0NzvMw1M4n2TCaIEnLwvSjio0Xr0HNVf93f/RS6Vu+syD3ioKkV0Xi89RL8Fbq4AGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWR8aGjWoq7/aYqKFgkjeyqQpNbp264Y5fTVCu7m0kluF+6F3O
	KaiUxfmHavY0oYs+O3isgHzkJlZEw9jzvHndhWPnL4fA/5GMM40uez8i+pqQXvw=
X-Google-Smtp-Source: AGHT+IH3slDyTSbNHrlV/Tt0a0lXWVPbbVWJp5/DmekUgqAL4lhzSyaC42Bi0iG5W4R+gMIBwSlN3Q==
X-Received: by 2002:adf:e5ca:0:b0:374:bf6b:1021 with SMTP id ffacd0b85a97d-378a8aae173mr1186643f8f.27.1725960427531;
        Tue, 10 Sep 2024 02:27:07 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb5a66475sm74901955e9.44.2024.09.10.02.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 02:27:07 -0700 (PDT)
Message-ID: <a87f5d39-0d61-4316-a2ab-01201f9d0ccd@linaro.org>
Date: Tue, 10 Sep 2024 10:27:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] Event parsing fixes
To: "Liang, Kan" <kan.liang@linux.intel.com>, irogers@google.com,
 linux-perf-users@vger.kernel.org, ak@linux.intel.com, namhyung@kernel.org
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Weilin Wang <weilin.wang@intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Yang Jihong <yangjihong@bytedance.com>,
 Colin Ian King <colin.i.king@gmail.com>, Howard Chu <howardchu95@gmail.com>,
 Ze Gao <zegao2021@gmail.com>, Jing Zhang <renyu.zj@linux.alibaba.com>,
 Sun Haiyong <sunhaiyong@loongson.cn>, Yicong Yang
 <yangyicong@hisilicon.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240903102005.78049-1-james.clark@linaro.org>
 <8133d432-7674-4d07-bbb5-4131fe5d474e@linux.intel.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <8133d432-7674-4d07-bbb5-4131fe5d474e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/5/24 19:20, Liang, Kan wrote:
> 
> 
> On 2024-09-03 6:19 a.m., James Clark wrote:
>> I rebased this one and made some other fixes so that I could test it,
>> so I thought I'd repost it here in case it's helpful. I also added a
>> new test.
>>
>> But for the testing it all looks ok.
>>
>> There is one small difference where it now hides _all_ default
>> <not supported> events, when previously it would only hide some
>> selected subset of events like "stalled-cycles-frontend". I think
>> this is now more consistent across platforms because, for example,
>> Apple M only has cycles and instructions, and the rest of the
>> default events would always show as <not supported> there.
>>
>> Tested on Raptor Lake, Kaby Lake, Juno, N1, Ampere (with the DSU
>> cycles PMU) and I also faked an Apple M on Juno.
>>
> 
> The tui mode in perf report is broken on Intel hybrid machine.
> 
> $perf record -e cycles,instructions sleep 1
> $perf report
> 
> Without the patch set, in the tui mode,
> Available samples
> 7 cpu_atom/cycles/
>                                       ◆
> 0 cpu_core/cycles/
>                                       ▒
> 7 cpu_atom/instructions/
>                                       ▒
> 0 cpu_core/instructions/
>                                       ▒
> 0 dummy:u
> 
> After applying the patch set,
> Available samples
> 7 /cycles/
>                                       ◆
> 0 /cycles/
>                                       ▒
> 7 /instructions/
>                                       ▒
> 0 /instructions/
>                                       ▒
> 0 dummy:u
> 
> 
> It looks something wrong with the uniquify_event_name().
> 
> Thanks,
> Kan
> 

Thanks, taking a look.



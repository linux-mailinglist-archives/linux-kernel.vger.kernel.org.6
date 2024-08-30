Return-Path: <linux-kernel+bounces-308322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC43965A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3529028D6B8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAD949625;
	Fri, 30 Aug 2024 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrirVqYM"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7556816BE2C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006596; cv=none; b=BgW85N5P9MCD9yKHxC+YAn+w4Pf0ifdFBTMpV+o+6uTVukJnry553SLjzdlhgua1JNvfhs9isUee8S8S16MflnQagW8OpnaB+CKsfIlM9Expwtkx4XnB5O9FAYoSvm696wKWlysAM81fFp6pdgcRfUSd+a4sTp26W5KA5lS22hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006596; c=relaxed/simple;
	bh=PEOIxs5LjJjG1TP88VrEzuRawH5lO29+HzEvL0DZZMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmlcpJZi2yPp8OK6U0DRF3RV+YQANVcdV+nacWpgmwV8oVPMrmfpuA9hM4Q/33yUf2q2J8NIjNXo2jahIkOG+QmJSnxZtDoYtej4uQLR+ZPoM1d32908asjf+9jAQgQdax3Te6B830XEeKHtnIUIUueqQKgGRHwrox6LVpWF3sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WrirVqYM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42bbc70cc19so2537205e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725006592; x=1725611392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8bFM4m8jLEQPCLvvCmN9XubuaZ9hTngOviE1bkHqrs=;
        b=WrirVqYMgeiosKofactJWCeRyAJ4eQEGxXRmcy8HlDHNlhCiDoW4uxwo93nZV76Stl
         WaS0oBvhQu8t5c90Q9tW82uV1VXLZ2wo/kjwa2HNlN6TAmqS20kjSjL6l0nI+JcG1F5+
         mKojTmSnDSw3idQ/FPJ2guAsttzbQ1I4XsN1eLhKRgPuuGCWeu4PHuTTvrRqlu9Gtted
         N5MTlGgSioQQ2LwFzBTjCQnzAgnSvXxS3R6q8wvA8JdcwWBLWU4iEAo6PYfdNyzDqFun
         xMPR6XTeix/CQVWH39huKYcfhcS3+j03uEToCFsOjb0Nq8x7VXYRQULPrDWj9xRdfcHQ
         WUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725006592; x=1725611392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8bFM4m8jLEQPCLvvCmN9XubuaZ9hTngOviE1bkHqrs=;
        b=pXsYEK9xnoB02HXRAlsdUjNA7wC3gQPsJpOn3PmMwhaYUibDL03grIN8HgzRV5adhO
         ALjKA3+1CVuMqkV3JIyojk6KzPYmG5nuaWmc+M5qlJDs0DRknUKwfYgWMnEux0a0Ro1N
         Qkco6Pcw5dj9ZQaxyP9MUNmKx13DMuc8PWd4frP0m9hl8KuF36w1mYPCVv+MG21DI/Ac
         UbJt+Q1BbJxopyl/ZQ0oVKnEi1k3V6kayGkx0oes5l/D01w4HrAFJuf4bOLsQCfemDyo
         sj+K83LiKFsl03iDxGeX7o3wbHWCm/bzd+le1WPSYiayoi8+HDrywvaUnecSV7u4TqOm
         C0sA==
X-Forwarded-Encrypted: i=1; AJvYcCU1sCJvyOm0ZqznW7zx+wBB+NWOLgJbT//fDxorqUfSsbRgqeZMn1n31Do6y6FIL7qM4dd1Zjtj206CU+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg/UDvawL75t0cGwp/pCSy1Pt7nWqryX0JW8Kdc141RSoTYchq
	1JOJa4LGQW08dYCz42PrlLvNvKuquCX0Ff1HUb6x3h93i8lanvR4UkPbx8oMb70=
X-Google-Smtp-Source: AGHT+IEobN+bHBPjf1e2A/qY63oP+9QONb1iyLzUpttiXiN+oD3C491CC8vj44GHn2p7po01axW+Iw==
X-Received: by 2002:a05:600c:6d8c:b0:426:5dd0:a1ea with SMTP id 5b1f17b1804b1-42bb27a1015mr43610085e9.28.1725006591184;
        Fri, 30 Aug 2024 01:29:51 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42baf7fa745sm53174145e9.31.2024.08.30.01.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 01:29:50 -0700 (PDT)
Message-ID: <52de8df9-4554-4bc0-9735-fdbd197dbb7c@linaro.org>
Date: Fri, 30 Aug 2024 09:29:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] perf test: Add a test for default perf stat
 command
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
 kan.liang@linux.intel.com, ak@linux.intel.com,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Weilin Wang <weilin.wang@intel.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Yang Jihong <yangjihong@bytedance.com>, Ze Gao <zegao2021@gmail.com>,
 Sun Haiyong <sunhaiyong@loongson.cn>, Jing Zhang
 <renyu.zj@linux.alibaba.com>, Yicong Yang <yangyicong@hisilicon.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240828140736.156703-1-james.clark@linaro.org>
 <20240828140736.156703-8-james.clark@linaro.org>
 <ZtFnbq_158fxttmW@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZtFnbq_158fxttmW@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/08/2024 7:32 am, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Aug 28, 2024 at 03:07:21PM +0100, James Clark wrote:
>> Test that one cycles event is opened for each core PMU when "perf stat"
>> is run without arguments.
>>
>> The event line can either be output as "pmu/cycles/" or just "cycles" if
>> there is only one PMU. Include 2 spaces for padding in the one PMU case
>> to avoid matching when the word cycles is included in metric
>> descriptions.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/tests/shell/stat.sh | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
>> index 525d0c44fdc6..24ace1de71cc 100755
>> --- a/tools/perf/tests/shell/stat.sh
>> +++ b/tools/perf/tests/shell/stat.sh
>> @@ -148,6 +148,26 @@ test_cputype() {
>>     echo "cputype test [Success]"
>>   }
>>   
>> +test_hybrid() {
>> +  # Test the default stat command on hybrid devices opens one cycles event for
>> +  # each CPU type.
>> +  echo "hybrid test"
>> +
>> +  # Count the number of core PMUs
>> +  pmus=$(ls /sys/bus/event_source/devices/*/cpus 2>/dev/null | wc -l)
> 
> Is it working on non-hybrid systems?  I don't think they have cpus file
> in the core PMU.
> 
> Thanks,
> Namhyung
> 

Good point I only tested on Arm non-hybrid. I can change it to assume 1 
PMU for no cpus files?


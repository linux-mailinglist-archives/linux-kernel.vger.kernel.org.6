Return-Path: <linux-kernel+bounces-334072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D8297D24B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 183BFB22795
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D316F06D;
	Fri, 20 Sep 2024 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="THvxhL9e"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697835FDA7
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820060; cv=none; b=bTlnX8vaK2MeincDYLT1kCVjVXoS7zSurqmpGzMEsUJnerOdlUEe6FxdHXuJC/B9ucoNNc5aOj/9XqLgMNzBm4VXxaSO9T9A7W9IteOza08FGp/w9WE0gq8JiaSVzCbWOpDja8hGL++LfYlEGpfyJPj+XYRb09Bry0cNmiB+jo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820060; c=relaxed/simple;
	bh=+T/38q/733oY7lFYN7yq1mIg11UNkECAKyzikUM6u6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NecHxFE1jA/eYL+CkUQJ023Xa4levzDaYyGT60D6vioaG+DkheWG00mvlBlglGSUAa2H4vH0Ul2Y+H/G1Yx0/2ydKWzBRtRlDUG6B8Jp41ygVEvYzea+qC9MgLYEOZdOaNSPmK0Da3ljvImxyXIFVQE0s85YHcTwnM8wp1vBfq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=THvxhL9e; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374c962e5adso1018367f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 01:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726820057; x=1727424857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fbr7uHJxZBXpc9SxcUXYAD0M/z9tzCVql6NpOtOjSnM=;
        b=THvxhL9eokj5uqLlmhbM6Edlz7QMqRSHYPFw9KX/hYAtxbjfKmXM5A2jG9rflM/JC5
         hRc3Dbwp50WoY+YV1raaD3zjusFXwYDQYpVBPnvqPllOG3dwqUUTuoiTvpLaC+ua9B/X
         6N3xKAQzkGUApzfYwM6LYe5fDxtWkdw18OtrBt43SgNNCfqFcKsrPQ/7uNkEt6Rt5a2Q
         RswuhPsILocokn9Qi+bcJm2JVgF4ppkY4Vrq8OmQ5OEabi+rAW7MMgMExbLiv4TAYE7i
         v+KP5c6E/a4SL6QEjWQFzjm6AWpp9deNT527S2VdOjS0nxB8xZ1QHPsaTcl31C4jvnqQ
         LX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726820057; x=1727424857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbr7uHJxZBXpc9SxcUXYAD0M/z9tzCVql6NpOtOjSnM=;
        b=J/xgX3O+XGD9DItlN7pfm+Q52GjdBq/kjY2tKrqm5G/6nHoqC266E4MuXT4hOCrbc0
         HuBhyQdk0Nbnbq5egkpZXiebFVjoDmlAGEhZeBAsF0OicNw+Y+JTQqQU5vPmNTMkzV3K
         GtwxDzWqqlaGiFoAWQq05wCfrhJboTadO6SvOveFhkOp6/YDTZPQFMIvHTpP4GK3PlKT
         mgjb+5qCwQKeqWUMhbdAgIPdJZMmq2H8UxH8gMGMwO9yJFYkOOQ/RgGci6d/v9e2q1Xd
         JH73wXMb2SYKeO2zNIpBwkti88Mg5WA5G2CZGVP5/zJ8vzJaQtNGmZwaX73HmkqmHiSX
         8tzw==
X-Forwarded-Encrypted: i=1; AJvYcCURPH1dCRaWbM+aWA3dRpewSd2cwh34my5wAfp/sxpX+wLVrxdi+Rk0Q9mVwpC7EUZKnRec6Xm2FFmaBIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqo2RQcm3xsEUl4lAvr7istvqDAzaB8p/UI/0v5FpDY3xmigZ1
	l9ztP038GttZfPcc/AWbJAztZ0e+UzHNqigBnW4WROKR6DlET9xZDr1Qej8HZss=
X-Google-Smtp-Source: AGHT+IHEed/p2Pf28xJnO9owUMqlwyQa0QykvsOdE/oVxO5WRmGwqzHMPTalaq1XxY7tI00VZPekFg==
X-Received: by 2002:a5d:5b84:0:b0:374:b6e4:16a7 with SMTP id ffacd0b85a97d-3799a1d312dmr2836672f8f.8.1726820056626;
        Fri, 20 Sep 2024 01:14:16 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7af8905bsm15603035e9.11.2024.09.20.01.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 01:14:16 -0700 (PDT)
Message-ID: <ddc6c1d0-a88a-46d2-93d4-f9f10f6aa254@linaro.org>
Date: Fri, 20 Sep 2024 09:14:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] perf: cs-etm: Coresight decode and disassembly
 improvements
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Ben Gainey <ben.gainey@arm.com>, Ruidong Tian
 <tianruidong@linux.alibaba.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
 leo.yan@arm.com, scclevenger@os.amperecomputing.com
References: <20240916135743.1490403-1-james.clark@linaro.org>
 <24e24324-cb41-4ae7-9584-e97684b12585@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <24e24324-cb41-4ae7-9584-e97684b12585@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/09/2024 12:23 pm, Ganapatrao Kulkarni wrote:
> 
> Hi James,
> 
> On 16-09-2024 07:27 pm, James Clark wrote:
>> A set of changes that came out of the issues reported here [1].
>>
>>   * First 2 patches fix a decode bug in Perf and add support for new
>>     consistency checks in OpenCSD
>>   * The remaining ones make the disassembly script easier to test
>>     and use. This also involves adding a new Python binding to
>>     Perf to get a config value (perf_config_get())
>>
>> [1]: 
>> https://lore.kernel.org/linux-arm-kernel/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/
>>
> 
> Tried this series with below commands and issue is not seen as reported 
> in [1].
> 
> record:
> timeout 8s ./perf record -e cs_etm// -C 1 -o kcore --kcore dd 
> if=/dev/zero of=/dev/null
> 
> decode:
> ./perf script -i ./kcore -s scripts/python/arm-cs-trace-disasm.py -- -d 
> objdump -k kcore/kcore_dir/kcore
> 
> ./perf script -i ./kcore -s scripts/python/arm-cs-trace-disasm.py -F 
> cpu,event,ip,addr,sym -- -d objdump -k kcore/kcore_dir/kcore
> 
> Feel free to add for 1/7 and 2/7.
> Tested-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> 

Thanks for testing!


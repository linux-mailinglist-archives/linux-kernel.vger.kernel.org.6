Return-Path: <linux-kernel+bounces-331421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 278A697ACB3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A1F28206F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE417F477;
	Tue, 17 Sep 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktTTSwq/"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320084C66
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726560894; cv=none; b=nRseanPu6euJ78X7Hw42Wo+IlvdIQ0oqUFqaC8jif+Qlkf7Q7tfdsAwEbN3wfxtA51jWIhkHktt8ijqgNGGKNxiyJ6VeESDeqSVYGH3H78lr1Vl9968DN+JcA7XIjTg8H2o8Pn17bdf1uWq7YK0aImJdlJF6WD0Q6btfWWT5KD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726560894; c=relaxed/simple;
	bh=fuBX73Jn0IJmQMm2EvxwdHma5rP78BJNFL3nGkoIlPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEc86KUjRHmCi5Z24qr0S1EDjMUuI2pJBQ4ACjIW3jyftJSvfy3BvCcUQQsJkrQN0iUMj1SJL5fh4v8mRFLbw6E5Q/xp8roGzi4jNjl36bjEQrJvuOjQ0MUyVTUwK8ydDGZM80lw/qXvOvcqrokU2QqpYmNu8rwBvCg6zwAAIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ktTTSwq/; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75de9a503so56161281fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 01:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726560891; x=1727165691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=40MhPp2saeHTiRrc06dNphqLdj+mKjYaNVOr8gOga8U=;
        b=ktTTSwq/fmQFuBexJRrnvFsK8s9nuzk/ro2KR0ji8EP1Kd9yOOucHNcExc5g1FTD6m
         E6H82y6FVg3oUHTdYQtUMLb06ldDapXA3+nXahnv5WNOuvx4evB3qYEjDvGHuuL+IHIn
         VKd5VplhtXx9OF0V2XtNv9xq1gG5z9uIJ2/92MecckTHij815i62TM2s0pRsjP/Osa2/
         ++NCDefw7lctDL70NVmJzSBhocaPK/Rj9HLcPa0AqFpgWZstPmBWuFrugGf0B4NeMBHw
         x80EqIQNQJcm41lW5AZtqTRYqQAgRCHDlSEw29DLEibtRxBJ0BczXPtJJuOpJoqxmW7U
         hj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726560891; x=1727165691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40MhPp2saeHTiRrc06dNphqLdj+mKjYaNVOr8gOga8U=;
        b=BH5UcMbT2cPB9D+cb5Oj3XPF6A7QpwHlT9+ajOUeYrnhulvmMwC3p7x6Tb5V6Unfm3
         B8k+Y0hpw79OyWj7oy8fa8/OIraHQylwfxnkkyQYPIkB9LquVw0LvfQslBXOY3PlAYI2
         440/5VilMt4IthPaQyRq9+9JAI0VUXCn3FCFk7uAcSSHQz1vNbIGcqL/XrjRAwu/iIdp
         7rhkbk7hfr4kfvEuQG1wwLLs+aT7hTSWx+k9k6UlvPyD3VkqasTbdSvxTROXCONRnjgM
         idjtaMc0105Now0dIsVMTEyuUexo+iCgCzxu9IOaoRnVv3QkQVSO7jPljOURLlsqe0HF
         FZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjJL0KfH9rKJmwRqv58ADwxyeY03WCDFa1tiatInJncrpHOshWrabwZ0qb1mavq5HFqz4NM9JReX+0DqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmGsQ1RPitj4tYw8L84NcxhD/0T2N8Opm0/6fA/WHq8qJhYB9
	s1raeMkhdVAsMt7zMoYf7fJN+4f2dnJ+CUItyE7rbygkquJ9f6HV9rKLpIs4aGU=
X-Google-Smtp-Source: AGHT+IGhMCNStijW6BvOu47nwjvS+9s5k0vizVA+NhP22vD89NPpE8po+GWqjAVPIR6eOIhd42007g==
X-Received: by 2002:a2e:e0a:0:b0:2f7:5c58:cc7c with SMTP id 38308e7fff4ca-2f787f6a8f5mr74583591fa.44.1726560890867;
        Tue, 17 Sep 2024 01:14:50 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9aff579asm134462235e9.0.2024.09.17.01.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 01:14:50 -0700 (PDT)
Message-ID: <a6439ec3-27dd-4e1a-b4ee-b9d4650c98ca@linaro.org>
Date: Tue, 17 Sep 2024 09:15:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] perf: cs-etm: Coresight decode and disassembly
 improvements
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, gankulkarni@os.amperecomputing.com,
 coresight@lists.linaro.org, leo.yan@arm.com,
 scclevenger@os.amperecomputing.com, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
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
 linux-arm-kernel@lists.infradead.org
References: <20240912151143.1264483-1-james.clark@linaro.org>
 <ZuM_oMuODcF0WVza@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ZuM_oMuODcF0WVza@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/09/2024 20:23, Arnaldo Carvalho de Melo wrote:
> On Thu, Sep 12, 2024 at 04:11:31PM +0100, James Clark wrote:
>> A set of changes that came out of the issues reported here [1].
>>
>>   * First 2 patches fix a decode bug in Perf and add support for new
>>     consistency checks in OpenCSD
>>   * The remaining ones make the disassembly script easier to test
>>     and use. This also involves adding a new Python binding to
>>     Perf to get a config value (perf_config_get())
>>
>> [1]: https://lore.kernel.org/linux-arm-kernel/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/
> 
> Looks ok from a quick look, but I can't test it, so since there are
> reporters for problems that are being fixed, it would be great to have a
> Tested-by: from the reporters and probably from someone with access to
> the hardware where this can be tested.
> 
> - Arnaldo
>   

I pinged Ganapat, hopefully he has some time to test it. But we can wait 
a bit and maybe find someone else if not.


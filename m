Return-Path: <linux-kernel+bounces-326847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F5E976DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA06289360
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B93F1AD24B;
	Thu, 12 Sep 2024 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tU9D9vtM"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9401922D8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154523; cv=none; b=O4oS+wtq+ZH5um2Tnlmv9BdgNY2qumdgWWSuF1SnUw3z9/CUqXJVTfvKIZ41/G9xnGp04tL5CR4/W8AGd4Azpi3vc3eFnKfiwYyI0ldpU7majaUh4gwh1xJvPjRXSrPaTsx5PLktp9ws4z6uNpgDMEG7vqZ/IgjE+WSp1Ektum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154523; c=relaxed/simple;
	bh=iQ1oKsBPPe/zMQcslRbghBsY7GVvs4EzjaXss889pls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsTK1pc6dKD7iXHP3zmHZZtJQkpV9qiEC+RQBdmf4LkbFqlVmDuQKevPnxmWepNGScuJAqo+lD0BoVSsVbrOZxfHHRdrsi3ev1duXYTu4qXnYWFPqiKEM5NmkIoeJCfkwln835Q8+UNitd6bqhewilIULRekkOeDOLKLeIR/VHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tU9D9vtM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cc8782869so10347935e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726154521; x=1726759321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8yBlVHQt+vnOgxumPxuDbxHiUodHyZmJ8GTxwWDdfrY=;
        b=tU9D9vtMz60so4ZyI/ZA7FdLTLgAk0Rw0g76zZ7t/5cSwjXQHBcFpH8V1fYzjXznhd
         dp+TZsjS6TRXxtyA5vmkxF/HdHDUmsxtFQ0XeKDuf83qim2ZMJrJo1HpgzEUHoVUSa2u
         ygjw7T6JXlRFe/WvBZUmHu+iwvEa/ih6R2amQp6r0MX9aamEBHgxPOKNdnnk6KHqyLJc
         Gc9v/Vcmq0emsWzOCHlI9hyDcA/WBw2ROvVnKFJ0Bu9k43Kbrs6lj5N6ybjJo4015ZEH
         xpoJaN1s3JkDeGtGRcMU/PkIxHcjLH5JccW5u+f7DfiQQntUpALO1FzM7vUfS+31SPyp
         UsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726154521; x=1726759321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yBlVHQt+vnOgxumPxuDbxHiUodHyZmJ8GTxwWDdfrY=;
        b=MT42gyWxt1Ba+bLocP0Oc7e5FgVQu8zTobzV6eCMJuKcdHp3EEmVbbHjVzpuWOuqJn
         +R1RnjgNLF8BALrwiV1i3YBqxUCWDQrZYuuanVJclOnr0I66rB+Mrtn/FJ0xPHGOTyz1
         +Frl0BlMIUrEO1mRK9w8iHwJZ+kouwB2YX5quD4BM08Pz+wMTgfiLI/9yMk8OqveU0sK
         fchPqXji8RC7duF3WDAf3k44TA9NLvWzbOEd7U9NZnu4bgGYXEU0w/r08c1gUkdAtvud
         e3EbvvUDqN4F1sc4tAIcTjorIvlReEwTZPVQ+70sm8BCdz+pkP5vIDtJwPQHwsNfmEdY
         kHPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJMNQ34KpTJVABLDsE0Ix8N7r4x9mlmxqqgv7ABJuTYtQwyqutIFddQ4UxIhxfzPbQxFQ+NPP9VjgjD1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6PvmzXaumvR56RJqQmMdnxn5Qt4W5SEdTu4Bw5fL/KIVekJWO
	/TPHQmq5W8uVFmhG4HwaRqHXCuOFo4dqVIzUQc8dWSLYF5uEbuIwofb8mCxc4qM=
X-Google-Smtp-Source: AGHT+IHlcoT3TEFF8U77+rI/EDslAOsz4FVdUzOrLilBFniwMVVrKySqO4ID2KPEa+yO5Y3+4W6cLg==
X-Received: by 2002:a05:600c:1914:b0:42c:b95c:65ba with SMTP id 5b1f17b1804b1-42cdb511f40mr26605925e9.6.1726154520433;
        Thu, 12 Sep 2024 08:22:00 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956e8a98sm14701188f8f.117.2024.09.12.08.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 08:21:59 -0700 (PDT)
Message-ID: <c124ad7c-31be-42cb-9eeb-507d99a97891@linaro.org>
Date: Thu, 12 Sep 2024 16:22:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] perf cs-etm: Don't flush when packet_queue fills up
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
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
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, coresight@lists.linaro.org,
 scclevenger@os.amperecomputing.com
References: <20240905105043.160225-1-james.clark@linaro.org>
 <20240905105043.160225-2-james.clark@linaro.org>
 <5a0d9510-eccb-4074-964e-ae068b4ee31e@arm.com>
 <1e55f148-37d8-4fbe-b863-d604fdfaafaf@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <1e55f148-37d8-4fbe-b863-d604fdfaafaf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/09/2024 09:14, Leo Yan wrote:
> 
> 
> On 9/10/2024 9:28 PM, Leo Yan wrote:
>> On 9/5/2024 11:50 AM, James Clark wrote:
>>
>> [...]
>>
>>> cs_etm__flush(), like cs_etm__sample() is an operation that generates a
>>> sample and then swaps the current with the previous packet. Calling
>>> flush after processing the queues results in two swaps which corrupts
>>> the next sample. Therefore it wasn't appropriate to call flush here so
>>> remove it.
>>
>> In the cs_etm__sample(), if the period is not overflow, it is not necessarily
>> to generate instruction samples and copy back stack entries. This is why we
>> want to call cs_etm__flush() to make sure the last packet can be recorded
>> properly for instruction sample with back stacks.
>>
>> We also need to take account into the case for the end of the session - in
>> this case we need to generate samples for the last packet for complete info.
>>
>> I am wandering should we remove the cs_etm__packet_swap() from cs_etm__sample()?
> 
> Sorry for typo. I meant to remove the cs_etm__packet_swap() from cs_etm__flush().
> 
> Thanks,
> Leo

Turns out there was already cs_etm__end_block() for the end of the 
session, but it was only called for the timeless modes. I added it for 
timestamped mode too in V2.

I also kept the existing flush() function for discontinuities. I changed 
my mind that the differences to cs_etm__sample() weren't relevant.

So I think we still need to keep the swap in flush() because otherwise 
the next sample won't start from the right place.


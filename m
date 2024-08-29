Return-Path: <linux-kernel+bounces-306470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81147963F73
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3882B1F2586A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50D818C935;
	Thu, 29 Aug 2024 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nI/c18Gy"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D07215666A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922309; cv=none; b=jAZD/RBeJs5SRKlCU/seb4tDRRcK7p2YxTQgvuy/rMYN+53WXqoXM4Yoy25+RjnXiywaqHf7WrEjtl8MhZXGyjWKpcGadIKsn68QzAL0BTnP9s1w5P2GVsWq8NMkLDOZHyFXt6rBGslY1np7V9tk0FJGfw4apO2b5rFNj/gf1SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922309; c=relaxed/simple;
	bh=WrKSvZyIPmfneFkHI3Mw8tDPuIZ/e9Q2bKoaKXg6a0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9a5V1K0bWFVcubqsCqZajNy2fWih89ZgfWQV7tEWoti4t1EFQMvUwKAfUFh1ywgDBqsElpKa36KzGrC2cas9hq3IwqYbvjDtNrasUbE+NJKQz7+UZjamv5d6sUmGqmhY5cIv3kNuiejwl2CibHpy61xDk7LOWbu65Xwq7BsB/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nI/c18Gy; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bef295a2b4so738244a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724922306; x=1725527106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DuBxoWy157nnbS1/JjpE+7fauo1YwxW92soyQSN/iA=;
        b=nI/c18GyXEcbErm7RJE+DKjcwSWHW8sAX6bqaFdQYKOt+pmDKFv9TusHqy6/R/vJc9
         IyXAso1uz4t4gVnkLuALBdxesSSQYF/dfzu/pk2RnmlmL8HnQ/ala/gMqCIC5uhtsHuN
         brKT6/JNhbvw8FdXSR040h4x1LsiOAF4DWfv4IPPyxeZGbuUDCIN3tMsOBEgoeBreL+n
         VE7Qifwl0ESZuA6z5KgijagQ2SCaUoNtPdnr5RDjFiqHBM7cSzjrRyeB4EUTnlUxY6BO
         SznL8ibMKu80LyhgrJQNud1vP06gXfZPRFMz1vt9dNaOjX+Ssla1/CQt/FfUh9+ntWVA
         pfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724922306; x=1725527106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DuBxoWy157nnbS1/JjpE+7fauo1YwxW92soyQSN/iA=;
        b=h0+vQ2dlnlNGDeqjVxEEtDnSCwoCuxP0H8ka6ayzAX0+ioKTVYyJHIfzAfsXGtjcoz
         9RG7JApsIe8Y56zhZUCDmkoltMtZxpbddCR3lSKGV01Zs4ENTFCoJw227J/AnuOPdVv5
         EJEasNBMEN2Q6P6Ms4vsnxCG9gdn/og0sqboFpmlF7gtFCyQSjjpTL0peYTjukLmhoyA
         4q5keTs/eDoOpQy4TN3aKk/uCzMABGme6i8/hSvTsQwkpkkWrRWyvhV7IQ3Xo12Gd4Fw
         ScW5eG73p6NZA56XxXkYebUcMsN/r36tLl/AW8PkPsFffXoXKF6AgJp9HHEHspxfsZr1
         OXzw==
X-Forwarded-Encrypted: i=1; AJvYcCVyZn9PkRmKER570G5mxGWc2f+L9Ds6rwuRS6iKcorL9BwUfDC+kqG8vwwlnnP4uXOqouRPW10mAqZsn8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGMuJn5x0wFwh6A90QBLnqrVSgcKVJbRlPO2c1fpIsduy0mHEq
	S/Hjl0fGxH/NHMCEtkcfJvYpoAGMfoUGmggmGOpZgpkX6v1mz2/9xTv2F9t2QyA=
X-Google-Smtp-Source: AGHT+IEIc+7B3QpJ98XadgHQzotWLA5vnY006rf18T7jH2/xIboTRex996U2nAhHSlYtYvCuPHWpPA==
X-Received: by 2002:a05:6402:5253:b0:5be:fb2e:d334 with SMTP id 4fb4d7f45d1cf-5c2201acb4bmr1950484a12.12.1724922304743;
        Thu, 29 Aug 2024 02:05:04 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c731a7sm452885a12.26.2024.08.29.02.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 02:05:04 -0700 (PDT)
Message-ID: <7b96894c-f5df-473b-be50-ee118ce3cfaf@linaro.org>
Date: Thu, 29 Aug 2024 10:05:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/17] coresight: Use per-sink trace ID maps for Perf
 sessions
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: coresight@lists.linaro.org, gankulkarni@os.amperecomputing.com,
 mike.leach@linaro.org, leo.yan@linux.dev, anshuman.khandual@arm.com,
 James Clark <james.clark@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20240722101202.26915-1-james.clark@linaro.org>
 <ZqOwGWcYosGe9ru4@x1> <6476a228-847b-4804-9229-c11a881663c7@arm.com>
 <ZqOzio8Oco9ZFsDm@x1> <8068c8ff-a8ce-4bcd-bb19-2c25b45cf6f3@arm.com>
 <ZqO3gPcCCVh1r5WM@x1> <aab886f3-ebbf-4853-b26b-5cf70c801683@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aab886f3-ebbf-4853-b26b-5cf70c801683@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/08/2024 3:35 pm, Suzuki K Poulose wrote:
> Hi Arnaldo,
> 
> On 26/07/2024 15:49, Arnaldo Carvalho de Melo wrote:
>> On Fri, Jul 26, 2024 at 03:38:13PM +0100, Suzuki K Poulose wrote:
>>> On 26/07/2024 15:32, Arnaldo Carvalho de Melo wrote:
>>>> On Fri, Jul 26, 2024 at 03:26:04PM +0100, Suzuki K Poulose wrote:
>>>>> On 26/07/2024 15:18, Arnaldo Carvalho de Melo wrote:
>>>>>> On Mon, Jul 22, 2024 at 11:11:42AM +0100, James Clark wrote:
>>>>>>> This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
>>>>>>> as long as there are fewer than that many ETMs connected to each 
>>>>>>> sink.
>>>>>>
>>>>>> Hey, may I take the tools part, i.e. patches 0-7 and someone on 
>>>>>> the ARM
>>>>>> kernel team pick the driver bits?
>>
>>>>> I plan to pick the kernel driver bits for v6.12
>>
>>>> Perhaps it is better for me to wait for that?
>>
>>> Yes, please.
>>
>> Please let me know when you do so so that I can merge the tooling bits.
> 
> I have now merged the driver changes to coresight/next, they will be
> sent to Greg for v6.12. [0]
> 
> You may go ahead and merge the tool bits.
> 
> Thanks
> Suzuki
> 
> [0] 
> https://lkml.kernel.org/r/172433479466.350842.6920589600831615538.b4-ty@arm.com
> 
> 
>>
>> Thanks,
>>
>> - Arnaldo
> 

Hi Arnaldo,

I just checked and the tool patches still apply cleanly if you're able 
to take them.

Thanks
James


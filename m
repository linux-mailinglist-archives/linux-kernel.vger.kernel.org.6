Return-Path: <linux-kernel+bounces-569590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAECA6A514
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25C1189602A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026601E5B6A;
	Thu, 20 Mar 2025 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0ay9JnN"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800279C4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742470624; cv=none; b=Z84tkLJcIbK5iGhUsG/DPIK0FDGMCtgbNt1bjtKIGrvmXuLMgDQ/wBBLc34jUxH3QGIdaxBak53nFWpqJgeNApSrIfMWpsYu9ixwPRlAui9qe0arox1d+/u5wcbVG59PckUM6uDeD39ZGhAyBJaz4UbWdYpjOdcggydEhiYoVmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742470624; c=relaxed/simple;
	bh=1C7bpo2rWiO9yyTZV75L7Qmv/xob9QKLrD1DGIBJC/o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l1jzc2c1Zt1x19rtMAu0LybEu7VuCBb1wi/nODk0Ij5zwEgvcj/s/phfh5+dSF/kCZd7g4hUZcp0x7n1sECu/4rDhVKG+hyaWlT8c6FiwntBMkWVyEiRrKSbX4WLgPAuWGP92zg5DjnO5icrZKmOWLQoCdMlfsWlfFEV2/pFvmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f0ay9JnN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso6601995e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 04:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742470621; x=1743075421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mjlcvKGTiShc7ATMQRzCYdMBBkwojrXBnj0x7+vUXZY=;
        b=f0ay9JnNbhbdoynyNW0sCykyB9xB2NdKqvJxTe3lzNBRR8Dp0VnXuxf6fQ/mT4w3VC
         X8RlXxN9PByIXLP6X6xZFYEBWG3U5pDArTG4Uck67wNJarc2CGO2mP8951hIPmUMW0KG
         tLvzGTCFSbodOk3gTGKRLWfL7cOM1Iq1FlRV5PFS2eW3D8JVaMBzD0zvQWSGTV2+hx4W
         NS+pcVP3ZUmPP5SXdYa9+NpdE7GsvhJNnEXgstY11WUrCwIlGgU2x4jhiBXS8mgaYk7x
         BIWeU8SHQTCCKwtRu7fzothWEocveCa42nT9fdmc+uJ7RRtSZ3aWGXqNGGdGGW//m7TR
         jtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742470621; x=1743075421;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjlcvKGTiShc7ATMQRzCYdMBBkwojrXBnj0x7+vUXZY=;
        b=mbTSon+8aftn3SqhSyaz7XYsjbTLEDJwwdzciphCSyGHbMt+ERBOf1cMTvPNCd3H5S
         GRrYF33L6yHVTyc9ufKkGY8/Qt8aUZ/nyZJO51wKJImvcRCs3E2MaZ7rMyqfOev2hcC/
         j8F42yM+Vfc8vzdzitydN14UztOrQO7MoHFj6h2glh+vxMOWoMBYo+JzEWjPMPMJwem6
         3J9LzmcJUtL49FQ2aKsqX2Fg4y/yjHb43tpJVBJojftQv2eMrEk7wtHE9h635UFmI6So
         6UByuq+oUjkGXi1zgZWwrzVJaivNVUvOSFFxt7w+8HiK4jVtr8zl/tJ5byz4RkW8eZlU
         dxlg==
X-Forwarded-Encrypted: i=1; AJvYcCWtNqFowxSmgijuS4diaQNUdcn/nf0eJNSOpdirZkBPOI+iGpAmB8cFToOuvi2gPlZk5gG09VCnsnLFvJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQX8G4FjlUs4rcRCQTC1oLbF55WA6isilPzBmyLIFd49kpVOby
	4dmjbDjajyLf4mplPk9XNYrnhKrQTueLaWroVSh2QUViahXYjga/fzcONLVdzEI=
X-Gm-Gg: ASbGncvppiECd83H/AVC0XtmqnMOXH8TgCyXASsUj1u0YqWRxzRntTls6xj6v7v8KdT
	czqymK+WITyjQI065l2VEoLX2fwWdGeOSga0/rrXJQPecIxGruW7u8WInUWDKD1eYKPBvdJjOUt
	j+suSz3vYt4QXrcPXozS+gMbI/wCIk1lhAHKaAT99XmCUuOneXvFraAnnxCJYvzjbSvwc884Lar
	IRmCk8j8zGom5dro2ihk04ScS1kjMflJxHBA878tXQhaMXMKKOE3gTTTAdiYgqcXcRgL+saFi8l
	PvbJ8t+1v5Hsn0G0EnnvU1uvd5+iqGki1h/+A5lX5+N0Cqln2thkKw==
X-Google-Smtp-Source: AGHT+IEBnVrt5yF+/dpxCYgBqldTqyVcsJrb9G0+k1EV5oFyXfWLLDcJYgmLaYOt7HhudBU9kooqig==
X-Received: by 2002:a05:600c:1e07:b0:43c:fcb1:528a with SMTP id 5b1f17b1804b1-43d4950e6b4mr25679875e9.6.1742470620859;
        Thu, 20 Mar 2025 04:37:00 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4453227dsm47249775e9.40.2025.03.20.04.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 04:37:00 -0700 (PDT)
Message-ID: <4bd59d1f-bbb6-4712-a60f-b47e3ca6a8a9@linaro.org>
Date: Thu, 20 Mar 2025 11:36:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf build: Restore {0} initializer since GCC-15
From: James Clark <james.clark@linaro.org>
To: Leo Yan <leo.yan@arm.com>, Ian Rogers <irogers@google.com>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250319110454.3230687-1-leo.yan@arm.com>
 <16b146f7-7568-437d-8ee5-f26bfb0354bd@linaro.org>
Content-Language: en-US
In-Reply-To: <16b146f7-7568-437d-8ee5-f26bfb0354bd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/03/2025 11:19 am, James Clark wrote:
> 
> 
> On 19/03/2025 11:04 am, Leo Yan wrote:
>> GCC-15 release claims [1]:
>>
>>   {0} initializer in C or C++ for unions no longer guarantees clearing
>>   of the whole union (except for static storage duration initialization),
>>   it just initializes the first union member to zero. If initialization
>>   of the whole union including padding bits is desirable, use {} (valid
>>   in C23 or C++) or use -fzero-init-padding-bits=unions option to
>>   restore old GCC behavior.
>>
>> This new behaviour might cause stale and unexpected data we defined in
>> Perf.  Add the -fzero-init-padding-bits=unions option for entirely
>> zeroing union structures.
>>
> 
> Do we need this? I don't see any unions initialized in that way. In fact 
> there is only one struct initialized with {0}, the other handful are 
> char*s but I don't think either are affected.
> 
> Adding options that allow people to add more non standard code doesn't 
> feel very portable or in the spirit of doing it the right way. Maybe 
> there's an argument that it guards against future mistakes, but it's not 
> mentioned in the commit message.
> 


After reading in a bit more detail and seeing all the extra 
inconsistencies between compilers/versions/syntaxes etc I retract this 
and agree that -fzero-init-padding-bits=all would be harmless and only 
make things better.



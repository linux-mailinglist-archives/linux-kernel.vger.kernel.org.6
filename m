Return-Path: <linux-kernel+bounces-544293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51362A4DFD1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38623A919D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A941204C20;
	Tue,  4 Mar 2025 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zf8pxSNy"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADED0204C18
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096451; cv=none; b=a/MRIYPslwMKHcQ0/Tl4sgXNtcmgpp2ZMA1jieYV30oMZh6U1mqA49XgNiYzi/1ye6dkSUbMY+yEREO+sBtVyEJXVF/98+ShTzbCy8QFhibDDd0xQoqRRbGoKb3PiW5xhcWjMJQbiCDfWofWZYIRNHCjDuwANOlgvZjoe3MZFSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096451; c=relaxed/simple;
	bh=zeH16qUQgun19UqozJUeAy3+MM8xqv07ZUw+BZ2QSyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRKxr7TtvcnXJN64u068DLyg5O7YKIoKlFOhZqE9MQ4UzisvFWYnIITwK8nIXoT3V6WxKQ+7S22+R2j98NYgfEB8oU5mBwp2VNJPBCmQoJpj/okzTwqyGYEgwIcJP5iEQ6bD6WlNLJtfX7PyUqfxdmMvLkrACYQSubEvq2rt6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zf8pxSNy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so36757965e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741096448; x=1741701248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z6ET8MYxAHAqXMFH0yBJKC2mR8XDHbGjevdrSyQ6aJc=;
        b=Zf8pxSNyKmgxdsWSGw2kL0WPEz//1ylBUb3/h/yatywqUtoksWzTBLJpKvzHR7ojUC
         iIexVX2m8FuG5I8hLcRkD4kIOyvBB8s2kH2QhY9CBjza8t1v7EsT/Rn/hDSkGygzY9sB
         Im/YoFwsDNYGjJyLyWiqMmKfWXTWKqO8S4wA/2oLzMXbtGftEIGLN9uEoilv/kTol26d
         pVRmPt971bBwIJPu6UnKacUEYVVjhi0EzX7vEN6hfO3/q5DwUBpJlI1DW+MO5LgGDXJN
         JQ6ENdsWcLgn+XVy0Iycm8CLtZATZD9+cDTrGZkr4o7GTcO2CPm86OpTJo9+6QM9n+13
         aGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741096448; x=1741701248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6ET8MYxAHAqXMFH0yBJKC2mR8XDHbGjevdrSyQ6aJc=;
        b=Ei/tZCHSri1qy+BDAuUMab76iJqvWEzJTW6bUhB7esfCMcdm5kccHUVZCCXlCpQLwy
         mcRtADTHloIW+1SQFKMDmc8hxl3QgK58BK+MqprrASnTT+09ErHnb4D5hBK9HwUvefdO
         UYemN+4xk6uymNSgdDay5tyLj9gPdNqu0ZuqaTOcgbZ4k7UbjTXEwXY8ugPr1axvGqKu
         ir2IcSXUcrxrHXx01fQI2FRqJhMWeayW/cRDDxd9p26KsCYS5JEUDCO5cpbOnSzOSrAf
         l7eExDK+ojDw/C8zYSJ/fC9+zNXoZBiKWX51ftjcrS0Nn2lkNtg1hrDMET1aZtpQuo7n
         kY4A==
X-Forwarded-Encrypted: i=1; AJvYcCVSkqOoNWD3/IxoCzZ2UJESDQUG2vREzykwgWtnakqgp3m+YQrBXK2kcqUGMl6UxUIwNqIbzNmh9/+jpso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMm61T6LpZWcqwsw3kGrhAeNI8edD1wg/MSwKZM55uuPR5Jrre
	nXml3lFxptHmbNTXoGOigbUmZnsf68tHZXKtmASJrs+aHG/r7q+CHnMa86332WQ=
X-Gm-Gg: ASbGncsipA2bLxQEfwTT/ItNDKGqQ3xLTHy94SjxDIWhhBF3CG+nBMzCmjJxfjEAR+/
	4JwDbwYiGDSEHlU7RvYOQw+NbivwFYJT/CLbrZYafyziSq8MOYyP+5KAX+HvYt8gviX9PYjvdma
	W8eQpc0vILIa/vdLuHZhouesbwliEIm7e8mgML8pYeVDbhjoKGD8vEN4tBN+A0wW9cAYuIMVLkc
	kLW4TZxYErLpGhA3AaHp5q9iQCWhUVv1+n83ER1+Jz/c/uMbElPEw62YJnRFOSk7G1wPtWSe+98
	WbnqCtdgS0a74YXsL+ERFOsM09sP2TYWF+eUL8wIrn5hgdSn+9xNbq4=
X-Google-Smtp-Source: AGHT+IFHlRbmRv8rbhJ5XKKfhGPa/iDq0l5JnEEMy/k3BPLKE+6aVxU2AZ65AeORq+30N2372lL66Q==
X-Received: by 2002:a05:600c:4693:b0:439:88bb:d017 with SMTP id 5b1f17b1804b1-43ba66da7aamr137510265e9.6.1741096447926;
        Tue, 04 Mar 2025 05:54:07 -0800 (PST)
Received: from [192.168.1.247] ([209.198.129.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba58720esm231475695e9.40.2025.03.04.05.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 05:54:07 -0800 (PST)
Message-ID: <65268cde-cefc-4c29-9ffc-7d85492ab125@linaro.org>
Date: Tue, 4 Mar 2025 13:54:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] perf Documentation: Describe the PMU naming
 convention
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Robin.Murphy@arm.com
Cc: Robin Murphy <robin.murphy@arm.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Tuan Phan <tuanphan@os.amperecomputing.com>,
 Thomas Richter <tmricht@linux.ibm.com>,
 Bhaskara Budiredla <bbudiredla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Stephane Eranian <eranian@google.com>
References: <20240606044959.335715-1-irogers@google.com>
 <c7d6eedb-7c5e-4411-a83f-4328dc75ec46@linux.intel.com>
 <CAP-5=fXY2Ofr_GRc7Mq7BfoR+2150o8e1JeyGctcGPRG70DqPg@mail.gmail.com>
 <060b220d-f7d6-4594-9b2b-e878a2ba98c6@arm.com>
 <CAP-5=fU+pigNLi+cTFwEmyG5tO+JHTGDgWh1sYbCiX5TppdLnQ@mail.gmail.com>
 <CAP-5=fVBsCxHbqQkEbG2zzATDYfN8bP6mN9ixkae7o9eNB5w+Q@mail.gmail.com>
 <Z2XIitYfFaZJltul@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Z2XIitYfFaZJltul@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20/12/2024 7:42 pm, Arnaldo Carvalho de Melo wrote:
> On Fri, Dec 20, 2024 at 11:16:46AM -0800, Ian Rogers wrote:
>> On Wed, Oct 23, 2024 at 9:21 AM Ian Rogers <irogers@google.com> wrote:
>>>
>>> On Wed, Oct 23, 2024 at 2:34 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> On 2024-10-23 5:06 am, Ian Rogers wrote:
>>>>> On Thu, Jun 6, 2024 at 11:15 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2024-06-06 12:49 a.m., Ian Rogers wrote:
>>>>>>> It is an existing convention to use suffixes with PMU names. Try to
>>>>>>> capture that convention so that future PMU devices may adhere to it.
>>>>>>>
>>>>>>> The name of the file and date within the file try to follow existing
>>>>>>> conventions, particularly sysfs-bus-event_source-devices-events.
>>>>>>>
>>>>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>>>>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>>>>>>> ---
>>>>>>>    .../testing/sysfs-bus-event_source-devices    | 24 +++++++++++++++++++
>>>>>>>    1 file changed, 24 insertions(+)
>>>>>>>    create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices
>>>>>>>
>>>>>>
>>>>>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>>>>>
>>>>> Thanks for all the reviews. Could we land this?
>>>>
>>>> Hmm, it's not always going to be strictly true as written though - we
>>>> will also have cases where multiple PMU instances owned by the same
>>>> driver don't all support the same events/filters/etc., and/or are
>>>> entirely unrelated such that the same event encoding may mean completely
>>>> different things. I've just landed a driver where not only are the
>>>> instances going to be heterogeneous (since it's for arbitrary bits of
>>>> interconnect), but for hierarchy reasons the most logical place to put
>>>> the instance ID in the name wasn't even at the end :(
>>>
>>> Right, I was trying to capture what the tool is doing and trying to
>>> encompass the problems hex suffix create. Another example of that
>>> problem recently burning us is ARM's PMU naming of armv8_pmuv3_a53
>>> means the a53 looks like a hex suffix. When ARM release a model with a
>>> 3 digit number will the naming break? Wrt filters, I wonder if there
>>> should be testing, bugs, etc. The wildcard matching will likely do its
>>> thing and I think the failures should be predictable and descriptive,
>>> like an event used a format that a PMU doesn't support, but I'm not
>>> sure if we should do improvements in `perf list` where we try to
>>> deduplicate PMUs. Perhaps the deduplication should be smarter.
>>>
>>>
>>>> FWIW I think if we want to nail down a strict ABI, it would seem more
>>>> robust to have an explicit attribute to describe underlying PMU
>>>> properties like whether instances do represent identical "slices" or
>>>> not. The hex suffix thing is already proving how fragile names alone are
>>>> liable to be.
>>>
>>> Agreed. Does this mean we shouldn't land this? I worry that LKML is
>>> the home of bike shedding conversations and we're likely to bike shed
>>> trying to achieve 'perfect' while something 'good' would have value
>>> today.
>>
>> Ping.
> 
> Thanks, applied to perf-tools-next,
> 
> - Arnaldo
> 

Just commenting to tie this into some related ideas that I put in the 
cover letter here: 
https://lore.kernel.org/linux-perf-users/20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org/T/#m44b5da77819baa249d34bc5b2c7f10b65d3d7360



Return-Path: <linux-kernel+bounces-280734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017CC94CE43
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F28B216EE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B294190684;
	Fri,  9 Aug 2024 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BpcLS7eT"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFFFEADA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723198130; cv=none; b=SDx3i3uKukK/ODARZe7Wva5dJjzDu1sqdiMUsKHOhx6CtQhsrMYQlXXmRiqJVFj4V4JipbzErR2U0GlKDc0RIUhuwgbk6a1cV3qcukInyo9KUtoLqv4l/GWVMKqKS6hoOAqEv5QPlK7QKq82AKYFsnkxzEae3XD1VLyzCxEj4JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723198130; c=relaxed/simple;
	bh=TNdfiNtPGBKEiqqYaBmEQaV0ajmcYNCB+JkPSsA2Nzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=mlSMBp7cjslkQeHj33bPP7Iamhhjxm6CzsbWsc8uYhgMtzE/Iuf56VCYcaV00VSmPTdWZq9T+RHnUQyHO6NnHhLMOMxS8ukiaL7Z+GIX26IyBkUNPkOyjqviljD6bQD+6xSI8P6XPz5TDT8BSxsVDkdApXMevJsZskV1HZCW0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BpcLS7eT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3687ea0521cso1332395f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 03:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723198127; x=1723802927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xiNn5CbFV0NLfgU2Ui8emxAJOJLFsPl75IXpIHWwt1g=;
        b=BpcLS7eTi6xpOrBqdg1pnzYckG2ys4P3Me8MeC5GLelsWguYtKx32WbakDVzEyGho6
         X4owJFzLcQCN1fnurFQpM8nlMRzKm/zCw+ykwJoWfKKTW+dJ4kQov/1rXTgUZIccskQF
         inyJT/TqQJRYcnodizq74VIj+86GpyNQtSi25eaZ18r4zGwFtArGZWu9vDPmca8jeEQg
         Ydpj/9ezTVh8+Z1bK/2CWtG0coC16y96N/vt8laOKDsuUWawD6MW6HHz8o1V8AH05qC/
         ZCbIdzhyAyxcEezAhtriOS5FIjwa6YcD5bFcoNRmA5kLNs3+Bd50JkOJkbyG5/A4EVqa
         5/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723198127; x=1723802927;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xiNn5CbFV0NLfgU2Ui8emxAJOJLFsPl75IXpIHWwt1g=;
        b=eesOJRHuRIDgAq+/gpMAScEzASViuiKXB5a3t8PpdrSSDDwwF5Lb7Zef3LxOotYLcO
         QqFyALWLZubDdAm1A7Z/OLugkpHNl6W45GFDxXfU/7JKIOzHvIV6jUhFJ7vf40IeJ6tM
         7KLF3VBb3kJtyI10RPEmaU/no5+edMIYhKk1VwbH9dYy7l9O4605FNS2stOAI10iRscc
         eCvH4jdZMmfhf4dm9udIGHgNC0YJmoQEBh7YR0CMGeraUneHXllEDmPflkaJSN3xrGex
         e8abUs2Ho2plFJHF6BkmREpv07eN5W7y5WAtdiZmBGQkYwEtoqW3zj2XHoXyOKeju1Jt
         vhIw==
X-Forwarded-Encrypted: i=1; AJvYcCW5rn+RfViIQ/jkbCujD0GNgxH9soxiQaRgKxZGtQNFqib1iAzhSzxONs1+oSyWS4gKeLw8uCKXI7Wd9AwRtMKsjtcpoNfaR1pYMSa2
X-Gm-Message-State: AOJu0Yw4scUzEb8QxTGPSgX3SYvmH6Eh3mNHWD3T70b4GCHyKr1nfmJO
	vA24mNUuBmiP81cGa8dDaqOVlHUPbFeJCzkBxgZorU99XzLFWk8wJYos7LJQCbY49vtRHzqsjpq
	f
X-Google-Smtp-Source: AGHT+IEjxOMpJijyJPtqjvN2SnJkH31SRvQqSXCULSa1KYcfXyvol0WgIsf493nMf6mm5AMqBEpe4g==
X-Received: by 2002:a05:6000:b89:b0:368:3b5c:7a5d with SMTP id ffacd0b85a97d-36d5e1c7656mr1238878f8f.20.1723198127039;
        Fri, 09 Aug 2024 03:08:47 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290598d87asm121020005e9.21.2024.08.09.03.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 03:08:46 -0700 (PDT)
Message-ID: <8258c91a-ab6c-42f0-a77c-dea52201deec@linaro.org>
Date: Fri, 9 Aug 2024 11:08:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] perf auxtrace: Refactor
 auxtrace__evsel_is_auxtrace()
To: Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>
References: <20240806204130.720977-1-leo.yan@arm.com>
 <20240806204130.720977-4-leo.yan@arm.com>
 <1059261e-9d1c-472e-a211-f83c313eb5c2@intel.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Liang, Kan" <kan.liang@linux.intel.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <1059261e-9d1c-472e-a211-f83c313eb5c2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/08/2024 1:58 pm, Adrian Hunter wrote:
> On 6/08/24 23:41, Leo Yan wrote:
>> The auxtrace__evsel_is_auxtrace() function invokes the callback
>> .evsel_is_auxtrace() to check if an event is an AUX trace. In the
>> low-level code, every AUX trace module provides its callback to
>> compare the PMU type.
>>
>> This commit refactors auxtrace__evsel_is_auxtrace() by simply
>> calling evsel__is_aux_event() rather than using the callback function.
>> As a result, the callback .evsel_is_auxtrace() is no longer needed, so
>> the definition and implementations are removed.
> 
> evsel__is_aux_event() assumes it is on the target machine e.g.
> being called from perf record.  It indirectly reads from sysfs
> to find PMUs, which will not necessarily be the same a different
> machine.
> 
> For example, what happens if a perf data file from one arch is
> being processed on a machine from another arch.
> 

I think this does go a bit wrong. If I open an SPE file on x86 it finds 
the intel_pt PMU which both have the same type number. But because 
that's also an auxtrace one it appears to work.


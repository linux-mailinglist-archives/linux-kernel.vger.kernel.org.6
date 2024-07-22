Return-Path: <linux-kernel+bounces-259303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8232D9393BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0631F2212E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED7117084F;
	Mon, 22 Jul 2024 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HSTUdhrv"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA4770E6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673727; cv=none; b=pEAGI/xS07+J7uVeTN/1a2WBlJqOz/eOGRZwQvcoVTvMXja/wGCp/3kBsej/opSJj+tQUh3i+RtrfplHnHAJsYG9tHerYaO7OXFLtL8N8fRBtfEOXlId+fFlvBCE1CjVKLslsyL7TBqcZTY0TZYmei3yPboZ/slJzJEAGW2OPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673727; c=relaxed/simple;
	bh=0E1fNsDif3VQXgBcyMnbWqtdpW+WZ9QRELLlUphu3v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/gzP6vBh2evacKtnsX/KEkmuwGMEnvt4GFCiphSTMILls1Fhi+w4Bnp0QQWWQIQ4a4zYvHQjlnlePmU1sOslFCytR7mmorSlsC1c3TGohZemYZ+vh+rbPf62WulMRgd2iDWrA/Ht8wxgOv6kAeryrQTkWhdArEtHf+wR3lfGSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HSTUdhrv; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39633f58414so1823855ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721673724; x=1722278524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0fXwDk328PWlLbWRpQs1+cfkwX+2wF82ZM6SOq+7S10=;
        b=HSTUdhrvpvUIMO7Ob6rr4JCXcXbW7bw7zmgoLrNKrR+VIr8B4Vs9tAca0LACZ/uO6t
         9qwDuvQK/3sJ9aOWkQrdHejpAtrKhqKnAZmklmso7RXe+H0gyBtg5K4zWsNkVBNAn3aP
         C9om1LOgcVkqlAJpkA0DNv49LXN8anu4dIcHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721673724; x=1722278524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fXwDk328PWlLbWRpQs1+cfkwX+2wF82ZM6SOq+7S10=;
        b=P/TpY8ThdpNi3M0zxNn0EiefJ3IZQbQPhBFqPWdAUQu476zlQLeX5x4redDxkkVmVR
         rq2lUVzWnYANCqYJj66omQD17var8gYPW8XARuFyJa+3wVW9JXeXzGV6S10ziHhiwiGB
         LAenI26A/dDNyOxHxHnzqIYxov1ALBYQosKEG4N2dh0vDSU0j1qDLy6LLlZ9B0Nx7kcY
         tAKtj5yBlftub2yuZNsr71uU1WEzfm0zlG29bm/PRiEHucU3Zn5rrkqSBDi4YMRUPOQU
         s5UJ9kSZvmH2hmSoiw+y9rh2Jzzc9R7d8VdpsLEfnhBWwk4Nx0+2xxW9PPRv3WeXZqVl
         OKxw==
X-Forwarded-Encrypted: i=1; AJvYcCVDNJCVlNP74KrscDg4E/VTfLyDh0FiEUna4zyunFtdPDellcZKgS8tpKOc51/cb4kb4GQoFN0D9bJ49Z/GG7Zbvzw56bQywLBX4fjr
X-Gm-Message-State: AOJu0YxW6yaiEhMaHDUKoz1/aD5DsHr8SqMe1vcGC4ebUB90kAuewlZD
	JpmwjEGYx2/uRajaEdMu2K33vjglr6FKldIbQG5C3ou1lbO65XDGCgnjEZGAVtU=
X-Google-Smtp-Source: AGHT+IFY4lRe7g4vBeCyqyzghwmKnXlwRNyo4g8Qu9oGXhbrhUa7NUUCi5GcqzC+1V3HqAjYxSLXKw==
X-Received: by 2002:a05:6e02:1d8a:b0:38e:cdf9:8878 with SMTP id e9e14a558f8ab-398e7446c00mr39082535ab.5.1721673724442;
        Mon, 22 Jul 2024 11:42:04 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-397f5c2b5aasm26785885ab.38.2024.07.22.11.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 11:42:04 -0700 (PDT)
Message-ID: <6f599bfe-3d54-4972-aa06-c987c0bb65b0@linuxfoundation.org>
Date: Mon, 22 Jul 2024 12:42:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: ksft: Track skipped tests when finishing the
 test suite
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: gregkh@linuxfoundation.org, nfraprado@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240722154319.619944-1-laura.nao@collabora.com>
 <0fe1b57e-4557-4020-878a-7eec13a2fdb1@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <0fe1b57e-4557-4020-878a-7eec13a2fdb1@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/22/24 11:32, Shuah Khan wrote:
> On 7/22/24 09:43, Laura Nao wrote:
>> Consider skipped tests in addition to passed tests when evaluating the
>> overall result of the test suite in the finished() helper.
>>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>> ---
>>   tools/testing/selftests/kselftest/ksft.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/kselftest/ksft.py b/tools/testing/selftests/kselftest/ksft.py
>> index cd89fb2bc10e..bf215790a89d 100644
>> --- a/tools/testing/selftests/kselftest/ksft.py
>> +++ b/tools/testing/selftests/kselftest/ksft.py
>> @@ -70,7 +70,7 @@ def test_result(condition, description=""):
>>   def finished():
>> -    if ksft_cnt["pass"] == ksft_num_tests:
>> +    if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:
> 
> Please don't. Counting skips in pass or fail isn't accurate
> reporting. skips need to be reported as skips.
> 

More on this since I keep seeing patches like this one that
make the reporting confusing.

There is a reason why you don't want to mark a test passed
when there are several skips. Skips are an indication that
there are several tests and/or test cases that couldn't not
be run because of unmet dependencies. This condition needs
to be investigated to see if there are any config options
that could be enabled to get a better coverage.

Including skips to determine pass gives a false sense security
that all is well when it isn't

thanks,
-- Shuah



Return-Path: <linux-kernel+bounces-438630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D949EA3BB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C86282C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28AD1BC5C;
	Tue, 10 Dec 2024 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PgnA62os"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE01380
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733791419; cv=none; b=MDrdZfbp/TdPc3ifPRAwVuOW9Nf7Y/xqg3JgNtj6lQjd9A1SNnx84DOrP2EuWrEMRCQjVHcApMpLjGig/np3vKgfF8Mx6/5ULtmsHiyeApejGL3Pfa1GzbAslAOaPKoONiHYk3vDbOt5HEXF6DaTPMJnmflzNCW/OZALz5uH/uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733791419; c=relaxed/simple;
	bh=7s8cXBHP/4C+GO2k56/2eFfcYIYomUQvCh2uoFWNhto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iL254iX0DQcg6Ijjl7XmTOU2zCXVe9N69EvakUqRsZ164QT1GUJWJuSMsgdL08258zqEKmu1KbtUFGMBAvpTK4nl4GkjSWWpTLjmkLFiEP97mr4qbbJ5vFCxfsKsTZdIcwt4AqDnQJb6eweG1W6luLh7itsne/CNPY7bwYNW6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PgnA62os; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-843df3c4390so164573639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 16:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733791416; x=1734396216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uxQj4mFkPuCMF5g/bHPAP+ehf22UWQDWDQ3gf17TMVs=;
        b=PgnA62oso5qKw3Cryin9/fmfASCNwmh9+HvR8/5+uGLLkGhtmDBtP1PF235C3cJZH7
         8ZMhhd92uvfc0pBu+f236n0EWlm4Zaf9aNO0bHQvYHzpYrH9dCOcTpxQDT8N5Z2vs/H9
         CCvE8+k99zWJXBEMJkdwEBHZd/jeoCs+tEvk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733791416; x=1734396216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxQj4mFkPuCMF5g/bHPAP+ehf22UWQDWDQ3gf17TMVs=;
        b=At9GNun8dbFPECb8BEoLtBsAI2VQe7Q79+YvgWhUvSNRHFvc3/5eTMaNLye8bGAcJy
         tv89ZGqd4YNxnMiK1odugJGK1rhXg9dqEXAqXgZ8Eoc13pa0jxxxTqwKvrJaaaRrk1G4
         Oh/DwNnWvAAGbVCS0HfqAJas8GkwBWxzoCEJXI2RPIE/PAosSQYXlnEK4QEixYml2dhS
         Fj1FUtThjxA706ZH4xM6khcNlGpRR7d4qYSTrdxsabMfwLQjc0Bbo2WN4jcPUbkCk+Sp
         8F88cCok/5VGrVVtoNNEo5JFMnAcaiz1GbUK1CVUJ/SP3fJqd4KMMLRfU+Kr+CmiHRTH
         GJjQ==
X-Gm-Message-State: AOJu0YwDqa9rM/NHCQOvJAqEuquIFO9aMfT0vDFmX9agzbphRqKUQwtB
	r2trLP2oeEpA7PMVUjUn7PQba+9v1dD9cPro6OOzo+PK/1rNK8d5L+LgJRmnLA4=
X-Gm-Gg: ASbGncvjWq0LLCTi3Q9i4QdhrnaUIV0OZBwRCtYImP7X/45sV6J+DOj/R6lFapdoDSb
	q3h6da0CGjtmnPb4vZghdzKyzFRtsHfpq9E70m/zwveoUO7TdD5CRBwa/L8sxRCSIOU4/1fFIL0
	eoUJBvygwVaDhJjGKzRLJ/bupe5cmcJNtFbIqVSPe6rzegwjN+cZ1M5RHB98Q9xa5YxaQFN65mu
	3ALwSN+8sUte8q30zJETaIOkWcOumPzR0rHxV+8InT65I2/DwxnkUiQF0/YEpV4rg==
X-Google-Smtp-Source: AGHT+IEfT6QHF9o4tTU+ARq3U2kLw293RMSpojeZMjocSBS13RSPmW2lOyXE12NqKCYYgMLVBKBVng==
X-Received: by 2002:a05:6602:1482:b0:835:4931:b110 with SMTP id ca18e2360f4ac-844b51791a0mr375170339f.5.1733791415202;
        Mon, 09 Dec 2024 16:43:35 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84473a5b3b9sm291700439f.35.2024.12.09.16.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 16:43:34 -0800 (PST)
Message-ID: <e5b0996d-be80-47a9-af28-ee9776638ab7@linuxfoundation.org>
Date: Mon, 9 Dec 2024 17:43:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: fix TSC MHz calculation for Mperf monitor
To: He Rongguang <herongguang@linux.alibaba.com>, trenn@suse.com,
 shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com, wyes.karny@amd.com
Cc: linux-kernel@vger.kernel.org, shannon.zhao@linux.alibaba.com,
 linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <269b8bb2-85b5-4cc9-9354-a1270f2eed35@linux.alibaba.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <269b8bb2-85b5-4cc9-9354-a1270f2eed35@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/24 02:50, He Rongguang wrote:
> Commit 'cpupower: Make TSC read per CPU for Mperf monitor' (c2adb1877b7)
> changes TSC counter reads to per cpu, but left time diff global (from
> start of all cpus to end of all cpus), thus diff(time) is too large for
> a cpu's tsc counting, resulting in far less than acutal TSC_Mhz and thus
> `cpupower monitor` showing far less than actual cpu realtime frequency.
> 
> Fix this by making timediff also per cpu.
> 
> /proc/cpuinfo shows frequency:
> cat /proc/cpuinfo | egrep -e 'processor' -e 'MHz'
> ...
> processor : 171
> cpu MHz   : 4108.498
> ...
> 
> before fix (System 100% busy):
>      | Mperf              || Idle_Stats
>   CPU| C0   | Cx   | Freq  || POLL | C1   | C2
>   171|  0.77| 99.23|  2279||  0.00|  0.00|  0.00
> 
> after fix (System 100% busy):
>      | Mperf              || Idle_Stats
>   CPU| C0   | Cx   | Freq  || POLL | C1   | C2
>   171|  0.46| 99.54|  4095||  0.00|  0.00|  0.00
> 
> Fixes: c2adb1877b76f ("cpupower: Make TSC read per CPU for Mperf monitor")
> Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
> ---

This patch has several warnings and seems to corrupt. Can you
look into this and send v2?

scripts/checkpatch.pl will show you the problems.

thanks,
-- Shuah



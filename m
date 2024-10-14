Return-Path: <linux-kernel+bounces-363667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A81099C56C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422A51C2160D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116BC1A265D;
	Mon, 14 Oct 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDv8PVkn"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDDB16190B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897472; cv=none; b=tylxZnWUEWufZCjIYJ1WTyG7brj8UETajC9ZNeB4qrgoCkJXhiUBF7yjSJ2bU2YnREuDlOzAP8eiWRVEuQfG2xMCTskkmGRT9pPsyh7EBH+qGZG9mi1RX3oQDvr+E/yYn85nyelBB7GBDmSaHiVC7rkdOwG8a7eL2cNMX19dMMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897472; c=relaxed/simple;
	bh=De9fFe1s07CApLkIdJB6+zLnUZdDCLyrYscPzlA+yCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qe2Z8q+slmJm5XC4ymSEIrAyvGkMANMRQ8cqSoOOa6qSFJ7329ZVpMX0BRtJfFjlh4iMjHOuRNgBn9zL3HNSb9At0th9z+5vGLdsdE8gYw07qnlt3FbiJIrGZNJsujRJzp/wzU9SNd7e8Ag9xHHhga/reACW7vuuWdZx8FM5iXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iDv8PVkn; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d6756659eso921233f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728897469; x=1729502269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0EPH13A2Xjjojfy4tUVU8gXPPxXzoo4So4iK5SvPwko=;
        b=iDv8PVkn4sKcq5NvKcatjqrcqGd0ZO6AKFg4vYEakWPjtwh1gei9CGX8qb64qG/JHV
         yOcul78Hygi/8k/VVGfzZr3n7IQ2nt5gp1emmeOE2cZrCMzAQEPlAVq6lol0lbJNCZOg
         RWyhvWQTCmk42Y/DAEMa+4frTUo+Vf8yWcwb14wZFsny6CWYo5CCZqb8R1k+dxlxV31E
         VVgYWLSYET2x728agQws7/vkGpWgrqN6bJ/oWaY5SHTvwrp7etQsNO36OJGwSKojdtga
         hSAlFJfl4msm1GcWyUzMlN8w3vIyvwHDgZcVG8y0pF4pK1cc79pZE+JEUCIY2GaMTOl0
         xC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728897469; x=1729502269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0EPH13A2Xjjojfy4tUVU8gXPPxXzoo4So4iK5SvPwko=;
        b=UZOJV0wf1svdM8xB8DtQL9SelIx4yGvnsWmKLeUxWuaX6J00HK+DxjJ3o72/hH5nQa
         eIYWs3ENO2pIYlteCvaV2rTlka8JLGgoOEcERgYlSimZo5zWDE3Ak3Zxmr2J9LZHDSgB
         lMDYqeyW5tB4N9Bh5fvHEDXSq7TgtrnU59UrSQjMV0LtFm9s1VO3VUvdBx2rA9DtvJGJ
         Hp5lOHhos4wBjAwXpBQVywblm41dAxZVzz5fq5RtdD5agBnyBWKXMnmq6skBui19EgWp
         cYCH7fFsEleUP41YNTx8NrOlx0/TGCT2XW5cyp8l9iin70TqG41BB+xpBDcj87X+4CbM
         pIfw==
X-Forwarded-Encrypted: i=1; AJvYcCUvVWG5jnTJDZSCrkgpdaJ8ucjoJsNh8ATYewJQ/PKj8oJrtQStxtJKiDUU8sLJPJHa33gVH6hNV+Fz2To=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/SNQ0Y/ZhuGL/la2JIU9e7Xjw6k9zXuTwlUR4L4o/l+92pHM
	erDqC80hngVuIydd13kPc5qi5sLRBeWMvg12bpF+gNqcX8wHrQkD32qKdkdvRbk=
X-Google-Smtp-Source: AGHT+IE4kzG+KSag4TfyVTDMk6wc38ssMJ1GBxTqPVc4j+ZamIlnnj9r3s3bhZhzBCbu0+3LXwvRig==
X-Received: by 2002:a05:6000:1104:b0:37c:d1bc:2666 with SMTP id ffacd0b85a97d-37d5fe954e9mr4791980f8f.4.1728897468922;
        Mon, 14 Oct 2024 02:17:48 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6ebe2csm10831502f8f.65.2024.10.14.02.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 02:17:48 -0700 (PDT)
Message-ID: <2036d7c3-8d4f-415a-9530-0758d440523f@linaro.org>
Date: Mon, 14 Oct 2024 10:17:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1 perf-tools] perf trace: The return from 'write' isn't
 a pid
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Alan Maguire <alan.maguire@oracle.com>, Howard Chu <howardchu95@gmail.com>,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Zwl6q8PMuyBz1k9d@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Zwl6q8PMuyBz1k9d@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/2024 8:21 pm, Arnaldo Carvalho de Melo wrote:
> When adding a explicit beautifier for the 'write' syscall when the BPF
> based buffer collector was introduced there was a cut'n'paste error that
> carried the syscall_fmt->errpid setting from a nearby syscall (waitid)
> that returns a pid.
> 
> So the write return was being suppressed by the return pretty printer,
> remove that field, reverting it back to the default return handler, that
> prints positive numbers as-is and interpret negative values as errnos.
> 
> I actually introduced the problem while making Howard's original patch
> work just with the 'write' syscall, as we couldn't just look for any
> buffers, the ones that are filled in by the kernel couldn't use the same
> sys_enter BPF collector.
> 
> Fixes: b257fac12f38d7f5 ("perf trace: Pretty print buffer data")
> Reported-by: James Clark <james.clark@linaro.org>
> Link: https://lore.kernel.org/lkml/bcf50648-3c7e-4513-8717-0d14492c53b9@linaro.org
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Howard Chu <howardchu95@gmail.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>   tools/perf/builtin-trace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index f6e8475290739a10..d3f11b90d0255c7e 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1399,7 +1399,7 @@ static const struct syscall_fmt syscall_fmts[] = {
>   	  .arg = { [2] = { .scnprintf = SCA_WAITID_OPTIONS, /* options */ }, }, },
>   	{ .name	    = "waitid",	    .errpid = true,
>   	  .arg = { [3] = { .scnprintf = SCA_WAITID_OPTIONS, /* options */ }, }, },
> -	{ .name	    = "write",	    .errpid = true,
> +	{ .name	    = "write",
>   	  .arg = { [1] = { .scnprintf = SCA_BUF /* buf */, .from_user = true, }, }, },
>   };
>   

Fixes the return value:

   0.000 ( 0.010 ms): echo/100910 write(fd: 1, buf: , count: 6) 

                 = 6

I still see the missing address for buf, but I suppose that's a separate 
issue that's introduced in the same commit. Also whether the address was 
even useful I don't know.

Reviewed-by: James Clark <james.clark@linaro.org>



Return-Path: <linux-kernel+bounces-409186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1049C8878
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F261F24ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14671D9664;
	Thu, 14 Nov 2024 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ttkSUlFt"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA90D1F80D2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582574; cv=none; b=FuIa0TGc1QtpKMjL6eNgLE1p/C1H7eyeVZFVt0pTLsLsFoEPAeOAZ8OlhmT5IN1Fv6S0X8Zys11pFzScBoRqq8gl32tL7HJkaoUS88EWEoFrOYrqVYEm8+o9ienKhbAg/wM00Dyz24v7DNKW//OEuTpzArH6wmA+kEle/gx+4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582574; c=relaxed/simple;
	bh=tosTpACMBr90iqiDKF/YON69YfCEcBco4UivdlsdubU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fk620KiRBhG5S/olPGKn8B4KKeJLX+xc1h7zmObZFf2r+l0wVl6qX1bSkt9PCBbHoo2yUsQgqDnaWeb0JOQ4AIZIsmgOGW2ojH/zv2Ma27DVLkBsx+I7LMJQwBHHzfiaxfqj10+rz06rlbCJ+5SrCFyaBKGbStN0gF8cgbds41Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ttkSUlFt; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cf844d5a60so76371a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 03:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731582571; x=1732187371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4B/6kX8Dv1v0x61K7KnGVF200oD26dvfXr9yaw5UIdA=;
        b=ttkSUlFtI6IMMxHtMq/dbGF6NwPyQcgiu/xyNbf/d7lYYoKS+h9dbnjo8xjw9esYVp
         NxnDwGUxR+tJmWTSpqZcmeth900MjXpGob0zG5QB1QZhE2YE1pUb8Jkk8RT5lTpNZuCt
         VPYIGLazhPfVfJSxfQ5g+F1kKgcCd9ULX9xO4qCkVsFB1NKEqQqEW2DZf1WyVgoRLVwJ
         HPiYw6eDft8DxatA17WiwTG6np/HJVXKW2hRMH3Xubj917EXbhCAr7mmG5oJgp/E3qRU
         8HMKtTpQQIfL4enX9T/IfZAdMhEREktfnxHPG5OtEfQA9xon77FCvoHkC418JqOnSmML
         yHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582571; x=1732187371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4B/6kX8Dv1v0x61K7KnGVF200oD26dvfXr9yaw5UIdA=;
        b=OrKC+r72NC45nzIZyg+Vv+ia8VAEJlaS9852Hxg3Hv7qZrQ0a6spP55HBD/qUDA8G7
         cCITSGZ1Ot05f5/lAskDOwet0o7mgWKcfyJsnK8IRNI3qZ+4DrH0C1UrnvnhRoKyRIXc
         ncIESs6bhbTgyOkHhU7Gj5OueKzlrtoNratizZUag5k3Bw4gJw6m4QkEMDSPnK1K8qKc
         TQIR/MPudNFopqVSB6xLwz82y32LaMBgfTAarNmDsL7UPfJwkThQpESOFhYWKdGW9yJp
         QROGgntgV3/6U0bAN+G/xbX3mwN/AZSUszJ14KK5G0YiRR1fAhLIUD/5nNQr6QaiJty+
         0MiA==
X-Forwarded-Encrypted: i=1; AJvYcCXDoqN2HjXob0fbcTQ5E8fpPi+7Ec2A5VrhFqTfIlU9T9vJYLe7rpKPKzE0O/iEBbRYHr6W2/vlEnwVVRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeU9Rjs54NqXU81VWOLXvfEtd2LFw1jlz5bhhPncfZ0vHCszyD
	ZQhxJgcWFi9HJuiiu3Eo7RHL0xnL45QzXktV1YTYlzEjmGwbgCejkwrlTjD2soM=
X-Google-Smtp-Source: AGHT+IF2C+FExDVfDs7XP69Gi5qTPDO/xl7y4YZmBo3xSaFOop1jpkIHKM5PZ6uedcT0B056R4IB4g==
X-Received: by 2002:a05:6402:43cd:b0:5cf:a27:c87e with SMTP id 4fb4d7f45d1cf-5cf75512e6cmr2581823a12.10.1731582571024;
        Thu, 14 Nov 2024 03:09:31 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79c1de36sm458723a12.84.2024.11.14.03.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 03:09:30 -0800 (PST)
Message-ID: <b107d9a6-48b7-468d-b36e-da9c587b7953@linaro.org>
Date: Thu, 14 Nov 2024 11:09:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PING PATCH] perf/test: fix perf ftrace test on s390
To: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
 svens@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
 hca@linux.ibm.com
References: <20241114090149.1489811-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241114090149.1489811-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/11/2024 9:01 am, Thomas Richter wrote:
> On s390 the perf test case ftrace sometimes fails as follows:
> 
>    # ./perf test ftrace
>    79: perf ftrace tests    : FAILED!
>    #
> 
> The failure depends on the kernel .config file. Some configurarions
> always work fine, some do not.  The ftrace profile test mostly fails,
> because the ring buffer was not large enough, and some lines
> (especially the interesting ones with nanosleep in it) where dropped.
> 
> To achieve success for all our tested kernel configurations, enlarge
> the buffer to store the traces complete without wrapping.
> The default buffer size is too small  for all kernel configurations.
> Set the buffer size of /sys/kernel/tracing/buffer_size_kb to 16 MB
> 
> 
> Output after:
>    # ./perf test ftrace
>    79: perf ftrace tests     : Ok
>    #
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>   tools/perf/tests/shell/ftrace.sh | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/ftrace.sh b/tools/perf/tests/shell/ftrace.sh
> index a6ee740f0d7e..742d6b8f34d3 100755
> --- a/tools/perf/tests/shell/ftrace.sh
> +++ b/tools/perf/tests/shell/ftrace.sh
> @@ -80,10 +80,21 @@ test_ftrace_profile() {
>       echo "perf ftrace profile test  [Success]"
>   }
>   
> +if [ "$(uname -m)" = "s390x" ]
> +then
> +	ftrace_size=$(cat /sys/kernel/tracing/buffer_size_kb)
> +	echo 16384 > /sys/kernel/tracing/buffer_size_kb
> +fi
> +

It probably wouldn't be terrible to do this for all platforms to reduce 
fragmentation. It doesn't do any harm and it only added a few seconds to 
the test time even on a small Arm box, maybe it will prevent flakes 
everywhere else in the future. But I don't feel too strongly about this one.

>   test_ftrace_list
>   test_ftrace_trace
>   test_ftrace_latency
>   test_ftrace_profile
>   
> +if [ "$(uname -m)" = "s390x" ]
> +then
> +	echo $ftrace_size > /sys/kernel/tracing/buffer_size_kb
> +fi
> +

Restoring the value should be in cleanup() so it works on interrupt too.

With that:

Reviewed-by: James Clark <james.clark@linaro.org>

>   cleanup
>   exit 0



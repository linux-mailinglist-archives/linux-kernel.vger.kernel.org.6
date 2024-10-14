Return-Path: <linux-kernel+bounces-363535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326DB99C39E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EF7CB220F9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019F4154C0F;
	Mon, 14 Oct 2024 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYySi/Uu"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD78515278E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895268; cv=none; b=XsIAf6qxKkjVrJexinnh5g81M9FPfqsbE0fJIJ7a1M9nDOyd4cEzma7ixJYphYg0rWqrfGAn0Kaknejdl6Z3+FXZG0ohWHOVmbohk0u3PtfGtqYJ78LHCvPaz32Q4YwanFXPb5PJo8weGOeZM4wqrq4ovkQ4h1l4MjR0GL9LOvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895268; c=relaxed/simple;
	bh=xZ/0mFJsN0uX6bZq0vqYSXkP6POKdmnylv4KXdMluNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9hDdg1jhnbN3Z3ag6EJHh2NlZJSP+b65gxO2YX7sEIXdI6eUU/zX6v83C/1wJW85VmyI6bfDAVnm/LQwgjCkn9/l3IxoHE80K7RjYUAPdKR8SRJnwXxZkdU/AcZguCJclGCp+S0AVmKFAKorKKORaB0juu9/T8/1mpZU4X5agw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oYySi/Uu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431291b27f1so15231505e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728895265; x=1729500065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gSGOk1StsSVQ0B/tQclfKgAa1y1dk9HJjhymNlVhCA=;
        b=oYySi/UuhJSx2xp7BffKTmCaED3iTAHMMRCg1TirLBTBfmah7ukcHsQ9fEkuXd0wpa
         5cE9qKLCP9o252alj1keBofeR/37/otUWW5jFThcZKpb9/Qxth1RcyJiNlcAZhPbwyA2
         r7CK70dQhezqz6nmeyxM+RayfIDVZlZt2xrZodVXx2crP7PSZw5+cgAOf6yFlcC9AvW0
         /owyrkbDY3Yh4XyxrqUfEV/rBi3R8+5R6bi2px+/qIO61x97Akf/I4aQmG6L3PffRT9a
         J/4Zm+iBVk8hRPmWiSIKi/qMirtXkqjz5y9LYObtWNx2nEO2vcBajK2MU6fMWPePz6Qb
         LU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895265; x=1729500065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gSGOk1StsSVQ0B/tQclfKgAa1y1dk9HJjhymNlVhCA=;
        b=Gxu4nFDVBVtMxMBC0nGjr+udifcF1n48fwxcfSKpkyz4KFxCgI1b/vjsKv+rplxd7p
         r2NCPBXinaxqTS/9T9lGyddgA055nyhokdk5lce+jE2PYWOqRuWDqbB+oD4lHHIUZKH0
         u2casOHmeN6MHhez2aKAuYMUv7+kxmUz8O1sl/S/ktcgl1VuB1MwMoAmmCqXcQOlENwT
         nLuL+7QRMKPmccs3Bn6ozufuKNYmirIvsqhqGgzwtvypk5Owi7WQnd1kkdBBnda1A66k
         B6szqKun4mMVKPkHn2KyvCytu0+pJ3wqGO7LzpUOKVnXxpI0A1K6GT/6XCJDfvBH6iTy
         b5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVAzgK4Q9KeLaFYa8n9Eqz8aqsjecUWJGd/dLUYNPscI9KLwapqcmj96WCwYfoxTPSXZkCFMZQtBQcy/BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV7fiOb2wWbBz/lY9FLOVqw/8duWWurbk/JQv3/xj47x3ms1D+
	5fOSU2mJ5GzyIaaP6BNzTFtoPlsh4TD7WotEEoYSZBPIYoxF/bQ9psPQzSVMbgA=
X-Google-Smtp-Source: AGHT+IEveUAgZbDhy2DQdu0VRzyJ/Oh+ZamPGbCYi7D425oZff8DPXg7iNomCrsClFGNJU+6zT6AjA==
X-Received: by 2002:a05:600c:1d26:b0:42f:75cd:2566 with SMTP id 5b1f17b1804b1-4311deaea05mr83712215e9.2.1728895265251;
        Mon, 14 Oct 2024 01:41:05 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b444csm148010215e9.33.2024.10.14.01.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 01:41:04 -0700 (PDT)
Message-ID: <d4d5528a-2420-4f0b-a251-cc3db26345fc@linaro.org>
Date: Mon, 14 Oct 2024 09:41:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf test: Document the -w/--workload option
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20241011171449.1362979-1-acme@kernel.org>
 <20241011171449.1362979-4-acme@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241011171449.1362979-4-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/2024 6:14 pm, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Wasn't documented so far, mention that it is mostly used in the shell
> regression tests.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>   tools/perf/Documentation/perf-test.txt | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
> index 9acb8d1f658890e9..62ce705d365f0442 100644
> --- a/tools/perf/Documentation/perf-test.txt
> +++ b/tools/perf/Documentation/perf-test.txt
> @@ -48,3 +48,17 @@ OPTIONS
>   
>   --dso::
>   	Specify a DSO for the "Symbols" test.
> +
> +-w::
> +--workload=::
> +	Run a built-in workload, to list them use '-w --list', current ones include:

Should be --list-workloads now



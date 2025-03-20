Return-Path: <linux-kernel+bounces-569619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D243A6A55C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E449A17DE06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BC4221548;
	Thu, 20 Mar 2025 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJcXTcd5"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2C3221542
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471169; cv=none; b=N8KhBHM4/9HH83hqN8giCsKn2AAjj6BQvKOymnA7riB94JiSxUH/lELLdWD2QaE3XHJrqVuAFQv1DVOygPZQIFZSuk1PDa4RJaNd88WfRz07Ilpc+qlrg4FjZGhg94A/gq/Dp5UKXCseIGFPcIPDf5ypkIR3/UiAbH0Jh3Qz3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471169; c=relaxed/simple;
	bh=K3uUC4fl0Wd5qXU848rirln8bzCs66S0l5k9oxU/V9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=MjZyaMb1JT9vyiEjaCU84pV5+DYdyi09pSVM0vCfe63qugGUJKUT+wNyFjVzTW+Lb8h7RjXW63H0bxTu5LF7RPuzncH1SFWROy1xTuE5e/OLWmV9v04NHGkWCVxp4WExLI+rB2L6Q+ExqFNHPafVJwSauDoupjJooCy/hRxOGs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GJcXTcd5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3965c995151so346645f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 04:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742471165; x=1743075965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7W3HPSMP4f2CiNLUVG9hzYOpX9Z/+7n96rGcD94rGNM=;
        b=GJcXTcd5BPkvUUGYBjC3h288rLOv7u91I8sVXkQ25dlycTGtGvZSiH7IyNhCHwO2tb
         aNWolJXfaEkKE+7m3XMZoIuCrapwbqUMLLklBWD1Igy5E/yEaaIWNfHWSD3U++cyssZE
         0KJoBvC+ttSOREnatdnFLlb22GMnZ48Rzi46ipVZYsARDbAEPTvbp0cVbGa7SSP7Kz7o
         f2guzb0JfJn7ojKGOS5RnZarDPsuaL4EMpXOoJI+1CEZkJ/iFeo+8oCqry5aCZk/u+UJ
         sDdboddIVJ969haMmRCM8yA9nYZOAnL+k3u5i1BjubxkZHe06jqwEiLbWCPEkdq00vr8
         YnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742471165; x=1743075965;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7W3HPSMP4f2CiNLUVG9hzYOpX9Z/+7n96rGcD94rGNM=;
        b=e0BxYRgqqlS2m21RlQSZ8qJllF/6QFLHzE8QKvL2gusuck0DtD0VAaqBwPmQYmLrYN
         A2jAPdYPo+dfYRQfLpQTvHNz8gOftNNL80ehf5jUp7ai96iqciDDAOaQkGoMiuqAsL0u
         nLL7ZQl5waH2eSQqv8J93LQ8jvzq3QGkVAfHqJTGBJ1sc243U3YHfPM7f1+ZrRdg3iv9
         xBBhEIKTrY0Z8RtyYHiNl7RXJo25Z/cxb87ue5mDcCZSai84ybLYAmTXfi02eQUsWq0C
         AO8bo4hpdlD438jLdWiio5IPwZ3JN6M7CinNkl3JQJrhANM7SexchU2z0Iz11IoGMBzH
         l6ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWWSNLjycl4Gza7o9v7qWyZKhsmh294KhP8OzhnfxQWDyp7Bb4jUrCVjbEGqdXCFrKlwZIUN4pf+M2PA/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfX3Z7hQX33g1jtlNhG391XoepneZ+pJNSWHjzU6pjd00NRjLM
	pfIvYrSuhbzpXSmMYR+Jx9KJ5YjVZxFgRQXf7tA3O0aSolHNlQaNRfrn9yKbdlQ=
X-Gm-Gg: ASbGncvZZyv/cXd/ziIfArt6BvbGhv1gEQcvJGFylmXYdZy4Vouebv007da+3YqUiT0
	A5j2EFiPKE82AQnZS54iIZB/XKmIpkRUDv/BUk/tQezJXR3ghuFiytTkux1+loGEUOizgjpWyXl
	LnnmYkWrFt3TAmulLOUUqg6bTfBVnytYZoJvxb3w54tZZJzXvCsJcx1YikQaeDybs19oA6Qhi+4
	5G14QF9A2xaRe/K3WA3ZvJGxpGZ1u64YZHFA3BxGy1BGXKmpe6xZusp3V5V/GUN6q3+v87Aonh6
	p/212lGjGFjkyHGtH/n5x/1R20NmAXAYFxfQqwG+vZCcBNZjFuOZtQ==
X-Google-Smtp-Source: AGHT+IGcFNWraQoMB1oIelQ6Jpm900cEnPwSNonv9rK3S5bnytIvFEX4bYUOeHVyZIaHtwEF8g3fiQ==
X-Received: by 2002:a05:6000:1a87:b0:391:48d4:bd02 with SMTP id ffacd0b85a97d-399739d7c73mr5449932f8f.29.1742471165180;
        Thu, 20 Mar 2025 04:46:05 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8881213sm23046180f8f.42.2025.03.20.04.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 04:46:04 -0700 (PDT)
Message-ID: <06233fa3-0663-4861-8fd0-ca30806d38a3@linaro.org>
Date: Thu, 20 Mar 2025 11:46:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf build: Use -fzero-init-padding-bits=all
To: Leo Yan <leo.yan@arm.com>
References: <20250320105235.3498106-1-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250320105235.3498106-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/03/2025 10:52 am, Leo Yan wrote:
> GCC-15 release claims [1]:
> 
>   {0} initializer in C or C++ for unions no longer guarantees clearing
>   of the whole union (except for static storage duration initialization),
>   it just initializes the first union member to zero. If initialization
>   of the whole union including padding bits is desirable, use {} (valid
>   in C23 or C++) or use -fzero-init-padding-bits=unions option to
>   restore old GCC behavior.
> 
> This new behaviour might cause unexpected data when we define a union
> with using the '{ 0 }' initializer.  Currently, the perf tool has ruled
> out these cases with the sanitizer "-fsanitize=undefined".
> 
> But the sanitizer is not enabled by default, we need to manually enable
> it with EXTRA_CFLAGS='-fsanitize=undefined'.  This means developers
> might encounter issues caused by the initializer with new compilers.
> 
> Enable -fzero-init-padding-bits=all to zero padding bits in unions and
> structures that might otherwise be left uninitialized.
> 
> [1] https://gcc.gnu.org/gcc-15/changes.html
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> 
> Changes from v1:
> - Changed to use '-fzero-init-padding-bits=all' to replace
>    '-fzero-init-padding-bits=unions'. (Namhyung)
> - Updated commit log for a bit background info. (Ian)
> 
>   tools/perf/Makefile.config | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index a148ca9efca9..b4f6d656c729 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -323,6 +323,8 @@ FEATURE_CHECK_LDFLAGS-libaio = -lrt
>   FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
>   FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
>   
> +# Explicitly clear padding bits with the initializer '{ 0 }'
> +CORE_CFLAGS += $(call cc-option,-fzero-init-padding-bits=all)
>   CORE_CFLAGS += -fno-omit-frame-pointer
>   CORE_CFLAGS += -Wall
>   CORE_CFLAGS += -Wextra

I don't think this makes its way to libperf. I don't have a compiler 
that supports it, but "-std=gnu11" is in CORE_CFLAGS and that's not 
there on any libperf compile commands so I'm assuming CORE_CFLAGS is 
only local to Perf.



Return-Path: <linux-kernel+bounces-441114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 451459EC9CE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9EDA188922C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0A11EC4D1;
	Wed, 11 Dec 2024 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1Cojbxx"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1D21DFE26
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911086; cv=none; b=NXP4KZcOn1F9C5Y5pHFcN9bJ+x5N+Ld9zD6V6+2wVImNVlhu8I9OkZDU+ou6M7uaRTBjFOu65A2UKteFP3Kq+j7xKGIuZc1D3Sxjb7VhxYLDyCRACFjWkFWJQ8zU02IIyVPXyln4XP7LhSj0eK1ERurgwKWzolp33A6QNp925Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911086; c=relaxed/simple;
	bh=hb10IRqDEB3bAd6YS4FDT3teoGsks7yB4MJQiDSV2mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=SuxhuIP7hP+TVXc21LITu/SCIL8Cqnc5W5bNb4QIgJDoTCwpOfbyUHYRR6TzU9qRlpON6J0oTtYnuYyqXJqxJhSMe3GS7ZR7S2tGxT9i5Kypg6peD6fHGdy31H5nE6ElISsg8nSnB9bkT/BZxZvrV8n2qzVCiCmN2Ts5KOA2d0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l1Cojbxx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so65716445e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733911082; x=1734515882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tciY6+uBVxS9wS+R1/VFJQBrmgOsGnFvaLr4XYlcAbM=;
        b=l1CojbxxX8p1hseAOj2Yeqg1Ardqttds6KVeIVxiuHP4yBES2AclWfGgGV3cuO+3As
         RHFQxjZn3bIal8TyTEAYHlVf6o4p4P5JtWWK6XNVaAwbrRk0lFuv9UuA6/C/1yJfexyr
         qUeaN30++I0GE5tsTcw+fQg+FYqZlsRhp4QkRpZSWinFY67kxC/sDlnQUvsZW4VZrX63
         fhBytDLrTVWDcmFzObUW6D5SVLYlO7/hiqWWm/beyyC5SOgFAHR48v2g1V5ZlW3PztxX
         f+e7CtlupPQ/2YJnZmHig4eIHFWYqHSVHs3ZxGVbkxKyfKCF2QdkybBk1Cv+h9rQ77Qw
         odEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733911082; x=1734515882;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tciY6+uBVxS9wS+R1/VFJQBrmgOsGnFvaLr4XYlcAbM=;
        b=wV8CgA8CF4YfzsLTYERoKJ+mFzxxSFsTw6cPqPQwaeJKFdEojk6B8AmvcqelqjbuPu
         Kr+OlJniLaYMDkE/kUbJjuOga+Oy01EfdapDd0TSBqC541ft8uUSFQ9QD+lvOl4+TBT2
         9UZ/+eW+Uckxf4RfwwaFfdnmKCvbF+4cclCKtuiAXPLgSGTI5S6UBfpiZN2Y+bEtZgMu
         fpAOw/Hg2MhbIRwvHwm4nevUFr9+aYhw7S188HhUUgs4U1pDlLo+5/2U4XhyyPdtMTTi
         gCGsonvoow1WrQ25QLxdu1LK+yM3AiRzECymik5ST3G47QOldlf/U7Shed92p4jbT65a
         8NlA==
X-Forwarded-Encrypted: i=1; AJvYcCWblm055CSII1HBW3F7i5c68RqIKXTbfUKhGt/WChLdsc6/ALLPyNb3ejA/Rut2YHyW5U4qOgs0yBWU2h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsiIeVdM3wxcxKF8QRpmNtAUHW9wZt+J1CzioDZaQqjPwTX5MU
	kQR0T0Ve2uGKY0ju77yoMAQADPU3/y52y03bv9USKFDjYDGwk/wiIxBqaMKhh2E=
X-Gm-Gg: ASbGnctSWdNyOiyIfk56k/xh6MDSE8Jq+yiq8yOmporhz0kwgk5aB7bxyzkKZQ4bzJI
	n1UUat9g1auKfsJiUNjnnm1G5KCoVLpc9UAkD7Uk4uApbahmxYgEy/1D6sS894JNDPCLzsrHfBj
	g3a/xBhcrcEUJIBAedB9520DoXWXdcu7f/4xhpMPB6i9/nq6Y4lHmVPPjz6qkTELOKygwU3/AfX
	1LG3C46mIIYHnJ8E+v967fui9zhoMdvvi0auHesqIJfZ5P6NqZ8WHxFzp6VV6P0hQ==
X-Google-Smtp-Source: AGHT+IEqpF1I20Q/eEs3dVdKFEOXVx9vJrnzLjJoaCFt3LKT8qvifeskFJfoMTfYbt9FbaUwAwk2zQ==
X-Received: by 2002:a05:600c:4e47:b0:434:f5c0:3288 with SMTP id 5b1f17b1804b1-4361c43dc3dmr14271985e9.29.1733911081849;
        Wed, 11 Dec 2024 01:58:01 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f587sm911405f8f.11.2024.12.11.01.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 01:58:01 -0800 (PST)
Message-ID: <6f441be9-7731-45dd-a131-39cc2e34dc1a@linaro.org>
Date: Wed, 11 Dec 2024 09:58:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf inject: Fix use without initialization of local
 variables
To: Ian Rogers <irogers@google.com>
References: <20241211060831.806539-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241211060831.806539-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/2024 6:08 am, Ian Rogers wrote:
> Local variables were missing initialization and command line
> processing didn't provide default values.
> 
> Fixes: 64eed019f3fc ("perf inject: Lazy build-id mmap2 event insertion")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/builtin-inject.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index d6989195a061..11e49cafa3af 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2367,10 +2367,10 @@ int cmd_inject(int argc, const char **argv)
>   	};
>   	int ret;
>   	const char *known_build_ids = NULL;
> -	bool build_ids;
> -	bool build_id_all;
> -	bool mmap2_build_ids;
> -	bool mmap2_build_id_all;
> +	bool build_ids = false;
> +	bool build_id_all = false;
> +	bool mmap2_build_ids = false;
> +	bool mmap2_build_id_all = false;
>   
>   	struct option options[] = {
>   		OPT_BOOLEAN('b', "build-ids", &build_ids,

Reviewed-by: James Clark <james.clark@linaro.org>



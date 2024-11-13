Return-Path: <linux-kernel+bounces-407990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 728039C79C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74418B28578
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A0F158DC4;
	Wed, 13 Nov 2024 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLU0J3P7"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D94F171C9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514387; cv=none; b=Pu6LBRdEmDR9xEtFRSEyuopBFSlFLZT5HwEwTML4lYmiS4ZfVp+o91Wxn3fpmNwk1roQ2jALvJuPiukw3YRd2U/QY959hIoxAkJ3Eqfsugdh1cIp/5uOMawJhN9WigvFM6XJniM0/01i9/It9mrlx9TalgAr/vyeO328Cg8PH7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514387; c=relaxed/simple;
	bh=/70UgeSPQ4hOl+81apBVxeqoPl9OH4tSaQJnk7qPHtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQ25yq3WBZSDX6ao1T/hxzgzuEl+VujXRfyhWeM+QXHXtOBaaOYs1MSBe5ioywLARLuI8kzl99x7T7LnmKzdtb+Tg0TctnNRZ3Hf14iuN7ANk30nsT5vWFrw50dhcJsMfeLZOZGwBIqF9lL0oOqme8hOoMJXnOtGlyow3q/utNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jLU0J3P7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9ec86a67feso1235722566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731514384; x=1732119184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SPCRSYoPSHpwTYrkQfPBw1+Y7qPSaun9UleVAf6DtlE=;
        b=jLU0J3P7WEhai6a6IlExZ8K/QosOAtqVYJ5ft6XqIiq2e27BiqYA5P8RAUKoOtMch8
         fUp1Ch7NlbNPXI7NB1m3iy3tUPMhR64O+vcRWRz0lCnjdw92FDhRns6o7oecA79kv9KA
         7GrAf7EbwN5+rw7OE6AnJfhlqUqcAsT52sSkuGapdNxEjNYzo8z5/nNNyKh+mn82gTIw
         gEqLTHHdoR2+9AfGSo15UPnefoBt8TuZhjd3fF8cWQGo82g3qxj8cKni0AZe2fdcLrGj
         jVzgGrNYtM8wti4sF6u/1lhyX8YG0kibLTg28t9Hv4ivcK6KkGBC9kJWqdrZ3i+dnYeK
         HrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731514384; x=1732119184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPCRSYoPSHpwTYrkQfPBw1+Y7qPSaun9UleVAf6DtlE=;
        b=w2f6feYD2rWO/QgN7DXGWLqRV9BobG+tn3yXcE/d1+uGjPPT+xWXzMKgb2eJ7RwRym
         qeXqNHcYJTlVT/zk45P625ijy7kFh/0PgjHYZODY3So0Jk9mJ+5eTi7VrPjM4NHfZLLg
         juHP0iW6z5JhJQW1Cv2ULo3vAeswbs8x8/ACDWmrRjxiepp76nqO3JPGzVIs8nqBBJzF
         f1cAI2IlAvBPnRfaPy+gt0bBaVSsEJUE2CIOHcJKAA+trN5PSzirSEl7OFuAuYTycH9q
         /7D+TWINIiR+FTtMx2EB+3zf/pW5Xo8g3N+PsY7+URSDZgWTN18XEtkS9B59rkP9W6N+
         36vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSxPIQceBiXX+oojxf53UANyzj2rdyMACoO3XtX/h02S7wMADXABqEerLPjamIdOz/2O2q8odISblm0SE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9XSZ2m3DAE31t8rhDHDglTFseOUzTMNd+wCwG1MuRdGLOBP9/
	OlrU0tPrGmy6FRdNLN6peShphaealiRzQNCa0+VQ8FpuxRSSkJ3AhqNqWDOWzLU=
X-Google-Smtp-Source: AGHT+IFjZsCHovOOd6p/6Y6Rm1a3D613g06b2tt4FLhBkNEK/HNzyPsLILrVS2Y3DIliqWTK31ytdQ==
X-Received: by 2002:a17:907:a4b:b0:a99:fc3d:7c76 with SMTP id a640c23a62f3a-a9ef001915amr2144913766b.37.1731514383858;
        Wed, 13 Nov 2024 08:13:03 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2eb28sm877229166b.197.2024.11.13.08.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:13:03 -0800 (PST)
Message-ID: <c03b1604-cc41-4746-be3a-fc326152d556@linaro.org>
Date: Wed, 13 Nov 2024 16:13:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf/util: initialize is_test value in
 expr__ctx_new()
To: Levi Yun <yeoreum.yun@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 nd@arm.com, namhyung@kernel.org, mark.rutland@arm.com, irogers@google.com,
 james.clark2@arm.com
References: <20241108143424.819126-1-yeoreum.yun@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241108143424.819126-1-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/11/2024 2:34 pm, Levi Yun wrote:
> when expr_parse_ctx is allocated by expr_ctx_new(),
> expr_scanner_ctx->is_test isn't initialize, so it has garbage value.
> this can affects the result of expr__parse() return when it parses
> non-exist event literal according to garbage value.
> 
> use calloc instead of malloc in expr_ctx_new() to fix this.
> 
> Fixes: 3340a08354ac ("perf pmu-events: Fix testing with JEVENTS_ARCH=all")
> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> ---
>   tools/perf/util/expr.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 5e3732bc2fa5..bc119501f091 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -285,7 +285,7 @@ struct expr_parse_ctx *expr__ctx_new(void)
>   {
>   	struct expr_parse_ctx *ctx;
> 
> -	ctx = malloc(sizeof(struct expr_parse_ctx));
> +	ctx = calloc(1, sizeof(struct expr_parse_ctx));
>   	if (!ctx)
>   		return NULL;
> 
> @@ -294,9 +294,6 @@ struct expr_parse_ctx *expr__ctx_new(void)
>   		free(ctx);
>   		return NULL;
>   	}
> -	ctx->sctx.user_requested_cpu_list = NULL;
> -	ctx->sctx.runtime = 0;
> -	ctx->sctx.system_wide = false;
> 
>   	return ctx;
>   }
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 
> 

Reviewed-by: James Clark <james.clark@linaro.org>




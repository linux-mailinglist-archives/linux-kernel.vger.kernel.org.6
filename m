Return-Path: <linux-kernel+bounces-557506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AADE8A5DA19
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75930189DF6F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF7023C8D8;
	Wed, 12 Mar 2025 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qqns4Kwp"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DBF23A996
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773759; cv=none; b=A3k1V4FrwqNLGa9kjUnHbytFCO/5TNuFWhQpef+LU6OsYSIJktxOlBfT6BPzUpE4riFIeuiu2NrGXWBdAIOB+41JdMdg9fwijfFHfmVst8bs0BGPNmSM5SJqsMuf3g1xggIn1AEV3ynfB4nWJm6aAueEHl4CVaUPK1q+fW7z/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773759; c=relaxed/simple;
	bh=kjWvjaQQHnF7eoPYtX5uf54kvFANSjafAEnJ7s0W104=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJ7fQo69RE6z7wrlAwSfDf6Ye+5xOFXsc8gwVTSmaLRwKSOSz7ysz0DDx+SXTvOdk6bDAZMdoNlKPf/ejqGJx0RXguMejy/43DWf3PGSAwKEalEuveG8GUkq24P6uMz5C1TTVVt4ExNZo3szjCXYdhHaXxwNZ8nNVwNz2SD5I2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qqns4Kwp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-391211ea598so3557627f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741773756; x=1742378556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pUHKQpxTCLmGn74czB9zdVmL8GuztD+1m1BAWrqdpyw=;
        b=Qqns4Kwpx88PkRN131RElQbAYioRhFwayWd6xeAXl2oqzzLlpJngKu3hsPpo8viYbe
         NgZ0tgSgHkw9RyMXBfHxExqlWbUtWY+/kADiMxz7EOKc1SIvgA8bZFSvodLZp2nR4ccu
         pxxNXklFUkAAa/hGSH3qFFMq/bHTTtDx0kfbiZRteJfMjoJRZCb6WGO/w5OVj6CuBzLw
         mFD2Kj2bG+ktvBcj19DRkKwbO2XEAkaEt0V7E0aejaGkkgXTngRjppG6/8PIVwjCMtkn
         IwjC4pAZQyrQa2PTL9KWv93c7xCyPhKnXePObd5rPxbOem/FnvsG9s4d+1fMdOyoSkzi
         IQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741773756; x=1742378556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUHKQpxTCLmGn74czB9zdVmL8GuztD+1m1BAWrqdpyw=;
        b=LjxROpVjudl1XlMrUDPilZ1QRFZglLbf3C4fyaCw9++cDj53K9y/n3KfqQnC7+dyJb
         5Axd++zJ6j5rOeAdlflpDLTYlbl76dcPsoxmbKkcSANJRt8B/iucWdCBUbnnAD/DFVOj
         KFKrECOsHPPDBmxWl5UmN3lmrU/UK2jGo2h3jcgVjyWiI7TTzKrCuFxnlnps4NwDHkI6
         /5PnTrObIlSVz6Or9m9mbSh8GE7DTYpbfjwYbu2glGNvIZ2p3IOmf+zmbGwBkix/01BL
         Q6YiEWpSEqrDTrQbTFHyLeuaHWlgq5TKx021+HVw4J9kmgQIprF+sXl/VlWy+sAyq3I2
         Hb1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxrEHczVphcK2Meu1xeRyC7U9ayy3En64QJ8P7L0APOZ1wS4tUFooavlC5v/3Ut+tRdLFD33fpZzbUlo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJtEO4eiqxFhR5PAB/vqz1/wR0mgToY/SgppwuXVIPrhBaPQ4
	4QrTJGXojbye83xD3Pdi+MYYlOPIcosQs7oG4uq7XlpG8YWoxBhio5vck/KNBIQ=
X-Gm-Gg: ASbGnctG00FaSwfzz+FXWqaBJpC6WVtBtA37LU4viWr2yi0EMUl3iBNCdUg5OZEsJe9
	R4Z4shh/Y76ZyxFuuMA662OSrcYXiqlhDZhrkjQfUQGvYO0Lfb7ZSMG/TolPP0Y+BEvd740RRP8
	Kti5UKfYynSYMY+Vnbod1AKie/hdnrVLcJw0SG6bvKBJl9U2K08LhF85KW5D6uJgpwt0HShgrIC
	s+FUI1iPGoPKv+FRYxjt+NdVsy2tXDt8JIklFQbzAKFdxJs0LPrv4PZgztffGaMpr/hOskSea1y
	n6v9oDLWDc8QrnSOho5pu0dkwU1kC2Gl4WGptcvQP2NnNOr0BWbDrQ==
X-Google-Smtp-Source: AGHT+IHsfLVyBWcJIJmx03S34iaHHCTkfZVaBtu1xexwTvJTh2AWPtnReHSIE67a3DSyc4chYw5jdw==
X-Received: by 2002:a5d:5f8f:0:b0:391:2e0f:efec with SMTP id ffacd0b85a97d-39132d1faebmr14844096f8f.7.1741773755863;
        Wed, 12 Mar 2025 03:02:35 -0700 (PDT)
Received: from [192.168.1.247] ([209.198.129.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c015d2bsm20073216f8f.43.2025.03.12.03.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 03:02:35 -0700 (PDT)
Message-ID: <6b43a3e5-b76f-45fc-bb2a-6c47a0a7c511@linaro.org>
Date: Wed, 12 Mar 2025 10:02:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf script: Fix typo in branch event mask
To: Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Graham Woodward
 <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com
References: <20250312075636.429127-1-yujie.liu@intel.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250312075636.429127-1-yujie.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/03/2025 7:56 am, Yujie Liu wrote:
> BRACH -> BRANCH
> 
> Fixes: 88b1473135e4 ("perf script: Separate events from branch types")
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> ---
>   tools/perf/util/event.h                 | 2 +-
>   tools/perf/util/trace-event-scripting.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index c7f4b4b841ca..664bf39567ce 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -91,7 +91,7 @@ enum {
>   	PERF_IP_FLAG_VMENTRY		|\
>   	PERF_IP_FLAG_VMEXIT)
>   
> -#define PERF_IP_FLAG_BRACH_EVENT_MASK	\
> +#define PERF_IP_FLAG_BRANCH_EVENT_MASK	\
>   	(PERF_IP_FLAG_BRANCH_MISS |	\
>   	 PERF_IP_FLAG_NOT_TAKEN)
>   
> diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
> index 29cc467be14a..72abb28b7b5a 100644
> --- a/tools/perf/util/trace-event-scripting.c
> +++ b/tools/perf/util/trace-event-scripting.c
> @@ -347,7 +347,7 @@ static int sample_flags_to_name(u32 flags, char *str, size_t size)
>   
>   	flags &= ~(PERF_IP_FLAG_TRACE_BEGIN | PERF_IP_FLAG_TRACE_END);
>   
> -	types = flags & ~PERF_IP_FLAG_BRACH_EVENT_MASK;
> +	types = flags & ~PERF_IP_FLAG_BRANCH_EVENT_MASK;
>   	for (i = 0; sample_flags[i].name; i++) {
>   		if (sample_flags[i].flags != types)
>   			continue;
> @@ -359,7 +359,7 @@ static int sample_flags_to_name(u32 flags, char *str, size_t size)
>   		break;
>   	}
>   
> -	events = flags & PERF_IP_FLAG_BRACH_EVENT_MASK;
> +	events = flags & PERF_IP_FLAG_BRANCH_EVENT_MASK;
>   	for (i = 0; branch_events[i].name; i++) {
>   		if (!(branch_events[i].flags & events))
>   			continue;
> 
> base-commit: b10f74308e1305275e69ddde711ec817cc69e306

Reviewed-by: James Clark <james.clark@linaro.org>



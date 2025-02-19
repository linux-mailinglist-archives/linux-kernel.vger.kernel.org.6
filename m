Return-Path: <linux-kernel+bounces-522435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523A1A3CA5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313B616E086
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390C924E4B3;
	Wed, 19 Feb 2025 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DMzqsYWa"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53B324E4A1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998300; cv=none; b=MEQvELCHxnVzcsqz+9S8wxE5vbwmeX0fs7nJpWiiO0kieIITDKEZ+vwpYW/MC3DbjZc1Y7WuiFZDGALSO1kiI+yEk8QFZocCpZ6IyCXXpw+nA6tl8KtuO2J/GuE1rxMwClgoJFgzGAuY8xm+XMNxgLd4UITWEt7n1PEA622Ybm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998300; c=relaxed/simple;
	bh=+uHdTRHxNDfBVd3zhnH7kveAQzlfhzBsi9i6T6xdxJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+w2MgdFZzJIxg5ZqE7QUnfoV1UwVwjyaztlF4sFOcPaMS2Sh09UC+E4dX8l1nCRhIxqR0dGwTi1ud6dT0NZXszzveTYLEUsKGqkUWrxzBLWVgMu7N94S8aDj2JkRffEoamZpa/Hqx0hDbOsGE7qSOF/nk2191xxNRInd0pRt3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DMzqsYWa; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-855a8275758so6018239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739998297; x=1740603097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v2o5IeA7VDXTHKtaj62YbAWTuLHaB+wX30y2aehqoy0=;
        b=DMzqsYWavni4q+a4KghpQ6zyHCnbtkfKbUWJSrgCRoF9D9s4Rlzv2wUJryPbyeC88a
         Nt/klUmxYWh0DTIXu4+8/PpVeNUgJpfD5i8Vx/DsUPkAL4hSW4BI5J3TBSQaDfo33o+B
         qgbeWoP9gTiTEH5XkMPhsKKM5WxaiJxXRbc5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739998297; x=1740603097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2o5IeA7VDXTHKtaj62YbAWTuLHaB+wX30y2aehqoy0=;
        b=uXpDMI6jUzn0AihAIAXJAXXb14KGfEht4nbEEFoGvmgnzxohSLxQcxxR7yTXm89dDD
         yMnOAFyE7FtYqlHaYVH43fr5AlB7NasPTgErwK5iOn2E03zutlRBL9D4yVfvxGwzXID7
         6m5RiYWsH/UThnM7N8PUW2E8FSLzhxAYabPPTi94BTI23VIaxpKey3MPUWVZPVfLIDri
         8iMN0fTWLcXubHd/7XOQeCzcGDA6f896tg/sghIqpCDSbjwsA4OLFa2S31dCpBTtHDoP
         FNeRIT2dWy0yUkfoHXD8UJX/+sNUWnJPwIHR2/+PDk6AMeH3eNy+I9FPgPAl2L5R72gE
         NFvw==
X-Forwarded-Encrypted: i=1; AJvYcCWXD4MTEOPYY41GvNSEaal3kNi/xS2rwzo+IAMVPmAm9amcK96fybG7j6GLT800pDGdiws78bFljyNCJwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsAeKPllhGQKH/fa3/Iot+nzUBOHx4mXHwA66tAVae8TctO6jK
	T5mlJYLTlg9qBsKSxopn3QMSiWu+RRcXuymR2ucRdf7TYpC+mLjUqF1+nk4X5lI=
X-Gm-Gg: ASbGncs2/yqcq562HQ7IHOmp3bGWTq8T28nPq33QT/FKU7DpAabZC92GmURvFjazP1+
	feTIFqlFd0G4KiWZqFGDtQ/APvPjX6+S4HlIyfkwuonjU8rJNfsnQ3W3eKT9wgkm+9n5c+yVpUD
	6HB9N99ZxVSP47VnN8pFd8NKpFiazoGI4WuayTLNYanvsyDFC+AZJJZp3gNJ7uQEBnLfxuq+aW+
	HaQj0m3fTlN+lEu5jFSdy7Ur6SXJqhNLXxUi8QD/Ct29T95XMUU24JkGKNbelrQ9+SbgBdoz8h4
	sObvwT5rjq7iCm59soi11WVpaw==
X-Google-Smtp-Source: AGHT+IHMYP6GsM4Y2iBZ0krD9AR16rOibJ64C+QYYXdRt3JS3ZCwEwZHaU6pgXrYj2XeSJIsteCc0A==
X-Received: by 2002:a05:6602:2d86:b0:855:690e:ed8f with SMTP id ca18e2360f4ac-855b3a01ccemr621360839f.12.1739998296814;
        Wed, 19 Feb 2025 12:51:36 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8559c37b07fsm120999639f.0.2025.02.19.12.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 12:51:36 -0800 (PST)
Message-ID: <9f137f62-e182-4f00-97c1-5dca6e25b316@linuxfoundation.org>
Date: Wed, 19 Feb 2025 13:51:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: bench: Prevent NULL dereference on malloc
 failure
To: Zhongqiu Han <quic_zhonhan@quicinc.com>, trenn@suse.com,
 shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com, peng.fan@nxp.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250219122715.3892223-1-quic_zhonhan@quicinc.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250219122715.3892223-1-quic_zhonhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 05:27, Zhongqiu Han wrote:
> If malloc returns NULL due to low memory, 'config' pointer can be NULL.
> Add a check to prevent NULL dereference.
> 
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> ---
>   tools/power/cpupower/bench/parse.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
> index 080678d9d74e..bd67c758b33a 100644
> --- a/tools/power/cpupower/bench/parse.c
> +++ b/tools/power/cpupower/bench/parse.c
> @@ -121,6 +121,10 @@ FILE *prepare_output(const char *dirname)
>   struct config *prepare_default_config()
>   {
>   	struct config *config = malloc(sizeof(struct config));
> +	if (!config) {
> +		perror("malloc");
> +		return NULL;
> +	}
>   
>   	dprintf("loading defaults\n");
>   

Thanks. Applied for Linux 6.15-rc1 - will be included in pull request
to PM maintainer.

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah


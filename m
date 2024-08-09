Return-Path: <linux-kernel+bounces-280476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F80F94CB24
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2371C22D3F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62735172BD6;
	Fri,  9 Aug 2024 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOAEgNht"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4549F170A02
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188074; cv=none; b=EMvo+BhDzk5/3w2B3Wjn7NB/tvZ1PAv3ShOIEooJPRFGzZdLCRypI9lG723QZlAjtp7oHqNP8ktLdYq2qXUmorzlCLkXK0Dg58Y2cdzyXCErrFOUz9SqxY5UObj0nZ9kmLL8Ac/deFbpak9LTWq2Onx468Nh9OetUNh5R9B8PHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188074; c=relaxed/simple;
	bh=QxkBQzipU159PB2wyHzE5iFYHTjRi7kwQk+67LpGaiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVleDzOdzRUppwIqXVkjv0Cy78SjWOKZGh3uxZZfqXy+LaiPxTfJKMrntzqiUeZrMaKbqMT5/TJwJqRG1VX6qyl48B9OzP4wv7v41VJRv5oIvIflHli+UkxsPcQHugAvkPlELnuVAJZ4lQNaYXhxsHodEGBdgomPa7V3moHpJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gOAEgNht; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc56fd4de1so12082065ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 00:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723188072; x=1723792872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJ7sJqSF1TkQHDuuGssihp9fwsv9r97LCZqEA521fL0=;
        b=gOAEgNhtwTVxYsJFxY/7FDOdzam588mYqPSsCDUrEX4Y/Bp+G6FAgo7EilcuLasT6L
         HXm6R//DkU59CK2pFivyXtxUvBjeRbsoUoLitnGJdTIkW1aTNz133Nu/pEIYxSdoT4J0
         Ys1kheZZsQ7mrj89iYldu4qqMFkFKs2m4YLp7l4u1viHtyOinuhpE/ArMyY4lG8V8B2N
         NFRJFDhrlOTYm2Co5T1v/Hk4NLMRh4GYyOviwIWqiw/c4+c7FhQBv3eiXIB3SWZT9CPQ
         gPGNV+sf4xgF/fA/VuvUGrjkSiwTeOcscEgx9vozS8FnBvmh7Mw4HfDeQAwmX5aAhAoW
         xy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723188072; x=1723792872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ7sJqSF1TkQHDuuGssihp9fwsv9r97LCZqEA521fL0=;
        b=oNl0Vynr4E6SmnGJqdoLQdPTMWzU5Er+yaFL+mquvFerp9sg0SXZzlx9w88jSACr/6
         TPE5LCwoN8gwyvSxDSmEui2oUHGs7DA4ApTdV3T/urtlW/EFdsOevrNQ/DotJJ7cK/93
         Cn7J9zJ9xIQvbbNg5oz4EkS8et00p20oDcM1GL31bjjuBubcJATmRX8EJRzPPK4dkLi+
         OYaQr93G3pOzj09J/ArADgB4xLkctdADEwYbXFugFTVNMcgaoA/tkdX7YCOq4zOeo0Ne
         B2ziwCO/1zdUxm/aCh8b+F4QUBKlBbxUMKt+csNMtlnLE1NaVCX77xllYW+0REt86R8z
         ZXSg==
X-Forwarded-Encrypted: i=1; AJvYcCXTE/x0cgpd6AVlcLIdU2LE325GBIyRekTdV2kNaoIleJAooVHpdv1k9Wi/ifW1aXfvVgIsYwzoUtZA8mbDnd1rWEx1rfIYNbOTzEUq
X-Gm-Message-State: AOJu0YyzqbzLfm4HDmLvkp3NGB8vUMuTjedwV3oZfSa5TUhjvM/Ae5JF
	pgoGfQ5Rxe/zdB9TqfbmKfR71oGSkj7+0dObxiXYtNfTUhuG1v+rLwtRZhtLhPc=
X-Google-Smtp-Source: AGHT+IF1i8beM8uAfXZssupMAVGlCAp1gZOrRbekA77KTQLwPssMRWulWeZsjxYUnURP0YkIw6Sxaw==
X-Received: by 2002:a17:902:f68c:b0:1fb:9cbf:b4e3 with SMTP id d9443c01a7336-200ae5d85d1mr12384395ad.22.1723188072489;
        Fri, 09 Aug 2024 00:21:12 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59058d20sm136717635ad.175.2024.08.09.00.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 00:21:11 -0700 (PDT)
Date: Fri, 9 Aug 2024 12:51:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
	perry.yuan@amd.com, rafael@kernel.org, li.meng@amd.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] cpufreq/amd-pstate: Add the missing cpufreq_cpu_put()
Message-ID: <20240809072109.ygel62d4333shkrw@vireshk-i7>
References: <20240809060815.21518-1-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809060815.21518-1-Dhananjay.Ugwekar@amd.com>

On 09-08-24, 06:08, Dhananjay Ugwekar wrote:
> Fix the reference counting of cpufreq_policy object in amd_pstate_update()
> function by adding the missing cpufreq_cpu_put().
> 
> Fixes: e8f555daacd3 ("cpufreq/amd-pstate: fix setting policy current frequency value")
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 68c616b572f2..eff039ba49ee 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -554,12 +554,15 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>  	}
>  
>  	if (value == prev)
> -		return;
> +		goto cpufreq_policy_put;
>  
>  	WRITE_ONCE(cpudata->cppc_req_cached, value);
>  
>  	amd_pstate_update_perf(cpudata, min_perf, des_perf,
>  			       max_perf, fast_switch);
> +
> +cpufreq_policy_put:
> +	cpufreq_cpu_put(policy);
>  }
>  
>  static int amd_pstate_verify(struct cpufreq_policy_data *policy)

Applied. Thanks.

-- 
viresh


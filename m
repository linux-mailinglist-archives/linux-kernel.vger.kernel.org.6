Return-Path: <linux-kernel+bounces-570351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F6FA6AF35
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7984D1886605
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC644227586;
	Thu, 20 Mar 2025 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6OG7CWz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D261C68B6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502720; cv=none; b=OwWs364ToyWLXVXGS3U9zqpMvQn4UdRry/pH9vOK8EpW+O1/jCBqrIZZMi5E3xn/yfCzb5xZvepwsPqpmBAcDL6RKAz3jU9j6sTXxni9D3Cxt57pQQcodLBx2503jsXFm0/X6gywkFCa8QiCzAw1cvsAUyo1mb5wnYbmTybIDx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502720; c=relaxed/simple;
	bh=2tV+k+LBk+tVq13k3Y51obWTupsNyQ9CIrTpML8b0kc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W/uKtgNXwOiIYJPa5gMdN3vZcdRSPW0etbSvArMd9NRv02PD0iceivp6+MmO25UuEK/Ett8DqhJ47miuO1r9g9yD8DSTL7vUUmkDRlcCuafy6PeBQ18YWK+Gl82dzxfNJOqIHbxDimYo3Z1FFjd2/Te71FSgZGBLuvOnTIo6eqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6OG7CWz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742502717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cs78ufWo2bSJSKRY/bRQ3KlIEcRDlnNhDJQo1byueYo=;
	b=h6OG7CWzmJMv5zpcojsq3wu6dgFkD6xVOvvlfpD0DLVaXMRjL6SIkzsPW5PQvDTmw39iP2
	LVo3EY/UGQ44hdhtoDtF1nrAweqeBMHqiF3sZ4hm0h47nMTxkOXz9J6ilCqp5Wwkgq8L2Y
	9PgV4oRJL480wsGEBritVnF9iJfGELg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-XpdOLy-9O-uX-vq7OdmOXQ-1; Thu, 20 Mar 2025 16:31:55 -0400
X-MC-Unique: XpdOLy-9O-uX-vq7OdmOXQ-1
X-Mimecast-MFC-AGG-ID: XpdOLy-9O-uX-vq7OdmOXQ_1742502715
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-476b2179079so22665851cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742502715; x=1743107515;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs78ufWo2bSJSKRY/bRQ3KlIEcRDlnNhDJQo1byueYo=;
        b=b2t19P2w6JN43urC1FwuXm8pYx9dEAj0WNyynsPaPyVAEhg+iEGq86nlW9KDkHvCLE
         6bbAlpeYuM7qMOZ+AUJ0mJnPOaq17Fu+3deMsFA8zrHMFbCv4UM2LZDuboDPc356oEXD
         rhhCEPKSOFMrdOL9y92WhE/PKnSo3uXTNpbhHT8I4n7u8GIf9pMwO/1YOKVIk1nFSG5r
         TkNP0ol5ORe4l+X+Y0IzbOwresg2qFPnzrsVoCD5U4RoL76+xAQyn9HWUiDstrXN9F8y
         j1SifLsCy7pJz6ooQAxNphgwV+HQ3mxjTItmxdmVilP6YqcGl0++CDqGVNucBx6M+R+k
         qsbA==
X-Forwarded-Encrypted: i=1; AJvYcCVkhfEq/qy+sgjtt9EIAWgPoSx/49Vs3av9gWoOC1iDjCV16te9bNdrQ3q0BHIZjrwZIdPOG00+kelJalw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHxbwaK75tqdgDClmcoYXecSjNsXEhN73Uvy9jfKvb4n1IkzUG
	Ar0D16ae6qQznwoSAj4OwhdMT6dA+VxVUE+KYdp7nuP6j2RvCaSMhFfgsxbM4w66I0bn86jG1R0
	zT6LMcA6mlu8+zxOn0t5dGcMq7cby9dQB6qM18r4HU68h9Rvq662KgwVSgkZEQw==
X-Gm-Gg: ASbGnctPH/rhtS77Ox3aRTQUN7Gd2X9RtcduVzQrT3xgnElLj/gAVtKgZE0rkfiYXl4
	z/PgibpYS/dGLppLddGnHyDE1/8tSeifpE+v/tbgZQQezldY5k4c1BSckoGBMBLYwsiSpv1xIxn
	9iV7aEdI3XZwKuUaJisCsITgEWG20tcnpYLpobGl9/5rMZbsWhj1Tn8xFDHnB2w7Wb84fx6MHGJ
	tay7StuJHXl6SGM2o0ogJD5K3+9C+V5My/X5XmRKktMkLi9hwLftU1jjwo1C9BwXIDUuKPLXxwF
X-Received: by 2002:ac8:71ce:0:b0:477:1eec:e355 with SMTP id d75a77b69052e-4771eed082bmr2367161cf.3.1742502715247;
        Thu, 20 Mar 2025 13:31:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbgJAMPPYKZh9vIiVrvuQuTmRjSYeYhTU4Xkf9NWImKq7CokOQ3ONC+sh5/MiuNZxDyvWfIw==
X-Received: by 2002:ac8:71ce:0:b0:477:1eec:e355 with SMTP id d75a77b69052e-4771eed082bmr2366741cf.3.1742502714704;
        Thu, 20 Mar 2025 13:31:54 -0700 (PDT)
Received: from fionn ([76.69.33.37])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d51fec4sm2708811cf.52.2025.03.20.13.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 13:31:54 -0700 (PDT)
Date: Thu, 20 Mar 2025 16:31:42 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Luis Goncalves <lgoncalv@redhat.com>
Subject: Re: [PATCH 4/6] rtla: Always set all tracer options
In-Reply-To: <20250320092500.101385-5-tglozar@redhat.com>
Message-ID: <8e41f0ee-7534-eedb-0a67-184ac195baf4@redhat.com>
References: <20250320092500.101385-1-tglozar@redhat.com> <20250320092500.101385-5-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 20 Mar 2025, Tomas Glozar wrote:

> rtla currently only sets tracer options that are explicitly set by the
> user, with the exception of OSNOISE_WORKLOAD.
> 
> This leads to improper behavior in case rtla is run with those options
> not set to the default value. rtla does reset them to the original
> value upon exiting, but that does not protect it from starting with
> non-default values set either by an improperly exited rtla or by another
> user of the tracers.
> 
> For example, after running this command:
> 
> $ echo 1 > /sys/kernel/tracing/osnoise/stop_tracing_us
> 
> all runs of rtla will stop at the 1us threshold, even if not requested
> by the user:
> 
> $ rtla osnoise hist
> Index   CPU-000   CPU-001
> 1             8         5
> 2             5         9
> 3             1         2
> 4             6         1
> 5             2         1
> 6             0         1
> 8             1         1
> 12            0         1
> 14            1         0
> 15            1         0
> over:         0         0
> count:       25        21
> min:          1         1
> avg:       3.68      3.05
> max:         15        12
> rtla osnoise hit stop tracing
> 
> Fix the problem by setting the default value for all tracer options if
> the user has not provided their own value.
> 
> For most of the options, it's enough to just drop the if clause checking
> for the value being set. For cpus, "all" is used as the default value,
> and for osnoise default period and runtime, default values of
> the osnoise_data variable in trace_osnoise.c are used.
> 
> Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
> Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")
> Fixes: a828cd18bc4a ("rtla: Add timerlat tool and timelart top mode")
> Fixes: 1eeb6328e8b3 ("rtla/timerlat: Add timerlat hist mode")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise.c  | 56 ++++++++++++++---------------
>  tools/tracing/rtla/src/timerlat.c | 59 +++++++++++++++----------------
>  2 files changed, 56 insertions(+), 59 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
> index a71618d876e9..2dc3e4539e99 100644
> --- a/tools/tracing/rtla/src/osnoise.c
> +++ b/tools/tracing/rtla/src/osnoise.c
> @@ -17,6 +17,9 @@
>  
>  #include "osnoise.h"
>  
> +#define DEFAULT_SAMPLE_PERIOD	1000000			/* 1s */
> +#define DEFAULT_SAMPLE_RUNTIME	1000000			/* 1s */
> +
>  /*
>   * osnoise_get_cpus - return the original "osnoise/cpus" content
>   *
> @@ -1127,46 +1130,43 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
>  	if (!params->sleep_time)
>  		params->sleep_time = 1;
>  
> -	if (params->cpus) {
> -		retval = osnoise_set_cpus(tool->context, params->cpus);
> -		if (retval) {
> -			err_msg("Failed to apply CPUs config\n");
> -			goto out_err;
> -		}
> +	retval = osnoise_set_cpus(tool->context, params->cpus ? params->cpus : "all");
> +	if (retval) {
> +		err_msg("Failed to apply CPUs config\n");
> +		goto out_err;
>  	}
>  
>  	if (params->runtime || params->period) {
>  		retval = osnoise_set_runtime_period(tool->context,
>  						    params->runtime,
>  						    params->period);
> -		if (retval) {
> -			err_msg("Failed to set runtime and/or period\n");
> -			goto out_err;
> -		}
> +	} else {
> +		retval = osnoise_set_runtime_period(tool->context,
> +						    DEFAULT_SAMPLE_PERIOD,
> +						    DEFAULT_SAMPLE_RUNTIME);
>  	}
>  
> -	if (params->stop_us) {
> -		retval = osnoise_set_stop_us(tool->context, params->stop_us);
> -		if (retval) {
> -			err_msg("Failed to set stop us\n");
> -			goto out_err;
> -		}
> +	if (retval) {
> +		err_msg("Failed to set runtime and/or period\n");
> +		goto out_err;
>  	}
>  
> -	if (params->stop_total_us) {
> -		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
> -		if (retval) {
> -			err_msg("Failed to set stop total us\n");
> -			goto out_err;
> -		}
> +	retval = osnoise_set_stop_us(tool->context, params->stop_us);
> +	if (retval) {
> +		err_msg("Failed to set stop us\n");
> +		goto out_err;
>  	}
>  
> -	if (params->threshold) {
> -		retval = osnoise_set_tracing_thresh(tool->context, params->threshold);
> -		if (retval) {
> -			err_msg("Failed to set tracing_thresh\n");
> -			goto out_err;
> -		}
> +	retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
> +	if (retval) {
> +		err_msg("Failed to set stop total us\n");
> +		goto out_err;
> +	}
> +
> +	retval = osnoise_set_tracing_thresh(tool->context, params->threshold);
> +	if (retval) {
> +		err_msg("Failed to set tracing_thresh\n");
> +		goto out_err;
>  	}
>  
>  	if (params->hk_cpus) {
> diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
> index 448fb1f7d3a6..c29e2ba2d7d8 100644
> --- a/tools/tracing/rtla/src/timerlat.c
> +++ b/tools/tracing/rtla/src/timerlat.c
> @@ -16,6 +16,8 @@
>  
>  #include "timerlat.h"
>  
> +#define DEFAULT_TIMERLAT_PERIOD	1000			/* 1ms */
> +
>  /*
>   * timerlat_apply_config - apply common configs to the initialized tool
>   */
> @@ -27,49 +29,44 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
>  	if (!params->sleep_time)
>  		params->sleep_time = 1;
>  
> -	if (params->cpus) {
> -		retval = osnoise_set_cpus(tool->context, params->cpus);
> -		if (retval) {
> -			err_msg("Failed to apply CPUs config\n");
> -			goto out_err;
> -		}
> -	} else {
> +	retval = osnoise_set_cpus(tool->context, params->cpus ? params->cpus : "all");
> +	if (retval) {
> +		err_msg("Failed to apply CPUs config\n");
> +		goto out_err;
> +	}
> +
> +	if (!params->cpus) {
>  		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
>  			CPU_SET(i, &params->monitored_cpus);
>  	}
>  
> -	if (params->stop_us) {
> -		retval = osnoise_set_stop_us(tool->context, params->stop_us);
> -		if (retval) {
> -			err_msg("Failed to set stop us\n");
> -			goto out_err;
> -		}
> +	retval = osnoise_set_stop_us(tool->context, params->stop_us);
> +	if (retval) {
> +		err_msg("Failed to set stop us\n");
> +		goto out_err;
>  	}
>  
> -	if (params->stop_total_us) {
> -		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
> -		if (retval) {
> -			err_msg("Failed to set stop total us\n");
> -			goto out_err;
> -		}
> +	retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
> +	if (retval) {
> +		err_msg("Failed to set stop total us\n");
> +		goto out_err;
>  	}
>  
>  
> -	if (params->timerlat_period_us) {
> -		retval = osnoise_set_timerlat_period_us(tool->context, params->timerlat_period_us);
> -		if (retval) {
> -			err_msg("Failed to set timerlat period\n");
> -			goto out_err;
> -		}
> +	retval = osnoise_set_timerlat_period_us(tool->context,
> +						params->timerlat_period_us ?
> +						params->timerlat_period_us :
> +						DEFAULT_TIMERLAT_PERIOD);
> +	if (retval) {
> +		err_msg("Failed to set timerlat period\n");
> +		goto out_err;
>  	}
>  
>  
> -	if (params->print_stack) {
> -		retval = osnoise_set_print_stack(tool->context, params->print_stack);
> -		if (retval) {
> -			err_msg("Failed to set print stack\n");
> -			goto out_err;
> -		}
> +	retval = osnoise_set_print_stack(tool->context, params->print_stack);
> +	if (retval) {
> +		err_msg("Failed to set print stack\n");
> +		goto out_err;
>  	}
>  
>  	if (params->hk_cpus) {
> -- 
> 2.48.1
> 
> 
> 
Reviewed-by: John Kacur <jkacur@redhat.com>



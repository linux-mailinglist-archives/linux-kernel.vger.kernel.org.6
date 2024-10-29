Return-Path: <linux-kernel+bounces-386387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8E39B42C9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68247B21D65
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363E4200BB7;
	Tue, 29 Oct 2024 07:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CctmT9ox"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42102010F9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730185474; cv=none; b=ajGJ0Lwl204mW7//bG/SxeCMPieunkzC0+UAcv2qS3VV9WHyZJySN0+iHJvnGlDqLJBGoatVZ7u35WlMeLRPCl42J400DMoKSDKIitwuNCqGLdN0TqZbCotoxzrX7ZvHC/2oiV/wv1VFrnZOP6SUslI3HjAIYteevODExfGkcvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730185474; c=relaxed/simple;
	bh=vHsiJAHyiSg5n/Otn3IuIkTF5NDW0RqUReC8IUcUKLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeGDr1ki4VNKThlXvKrIy3Xl1LysoBuLu1l1aSvTplAI4qophSB0ARHYLXHUC6i5Hzl3HonrvFv7dW9gAlYVTs1+yAkapkKmWXoLMHUIOTU3y50PW05xkOP8qV36uJqDSlgJa1m5F2EodW9bDvWpnP2udBKiCy7hY/ji7F7Q+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CctmT9ox; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e91403950dso1101029a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 00:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730185472; x=1730790272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QfezvlEpUor+6kVtO8K9KtmutpWAUXlWNawX08ky9NY=;
        b=CctmT9ox2KNXSQy9sdrd7GOY4meqU3jDSvArdEkTMjwFkm9pCKcH/iGlBCOfHUWTs+
         m9u6APBOOWnZRz336QCuxv8Qk21uhKcETyyi3O+St4qcqkbg46wulT/t775i7UrM3gbe
         GWTnNCislhV37Yg6oHj+iCWrvzxXAOx3TCawe5zgXtMR3sg6QTaMMDjkRvUzDv/vn8Ap
         mCqOtlDnaxVhch5sH3dIAiOPsN5A2rz4ToNPhLXweXgqd81hmqXvxy/Gld2Ll24rgVXx
         HdnXqRPe/kuCm6+MNCHLoH5W/XuUGQo2NrOLGU5gjInXCof1XWJ1FmQ1cVIt1iAjcdXI
         4X8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730185472; x=1730790272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfezvlEpUor+6kVtO8K9KtmutpWAUXlWNawX08ky9NY=;
        b=eXzfKtQ8pl65xusQ/iH/sVPqyEc22wwepV17enXxG0HeZjMs+i3/PQ/7kEgH5rCHDe
         Ux7NKDsOv32wP5o9dXJTFjR/0dL0e2GC96HyijQiZUEoRtfIz5SvceSh8OTAdDkroutA
         RUoN139V1kb15nkzTba8AR8ud4Hvhdy1ACtOqZM/ZtUImt71VNbDu/x6WRw47gG/kGvT
         B9DtbvM0gG332+0y3a8y1Rav1k0thk8YSl0cuoJa0OqIds9s13CTt3DhR2dyvkXCAL9m
         aRIkKZO4AWdwNr5RVtscDskrAhTZDWkqm4bMCR3rP7ueRZqq6nTJj+ZGoRp4iB4L+3Cu
         DnwA==
X-Gm-Message-State: AOJu0YwWznksD5wbfHgTJuFijlP7lF9VMzeGKQAF5stRwTwBxeBvZ24n
	PbGt8zzJBQX6Y0iQv1NqaTw9oFIU8RUAFMQBJf+yoQaeTPYSIaxDo0yqbr9rbGk=
X-Google-Smtp-Source: AGHT+IEAtGrYcgaJcMZnxR7XFpG1XzMaaIW78Qyci9zH3p9A4VM2ySX803U/IA4Vmiqs9wsvnq89/w==
X-Received: by 2002:a17:90a:9a8c:b0:2c9:9658:d704 with SMTP id 98e67ed59e1d1-2e8f11dcf62mr10274984a91.40.1730185471912;
        Tue, 29 Oct 2024 00:04:31 -0700 (PDT)
Received: from localhost ([122.172.85.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48bb69sm10767253a91.1.2024.10.29.00.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 00:04:31 -0700 (PDT)
Date: Tue, 29 Oct 2024 12:34:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com
Subject: Re: [PATCH v7 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
Message-ID: <20241029070429.m7q5dkumitoyqxq2@vireshk-i7>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-2-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913132944.1880703-2-beata.michalska@arm.com>

Apologies for the delay from my side. September was mostly holidays
for me and then I was stuck with other stuff plus email backlog and
this series was always a painful point to return to :(

On 13-09-24, 14:29, Beata Michalska wrote:
> Currently the CPUFreq core exposes two sysfs attributes that can be used
> to query current frequency of a given CPU(s): namely cpuinfo_cur_freq
> and scaling_cur_freq. Both provide slightly different view on the
> subject and they do come with their own drawbacks.
> 
> cpuinfo_cur_freq provides higher precision though at a cost of being
> rather expensive. Moreover, the information retrieved via this attribute
> is somewhat short lived as frequency can change at any point of time
> making it difficult to reason from.
> 
> scaling_cur_freq, on the other hand, tends to be less accurate but then
> the actual level of precision (and source of information) varies between
> architectures making it a bit ambiguous.
> 
> The new attribute, cpuinfo_avg_freq, is intended to provide more stable,
> distinct interface, exposing an average frequency of a given CPU(s), as
> reported by the hardware, over a time frame spanning no more than a few
> milliseconds. As it requires appropriate hardware support, this
> interface is optional.

From what I recall, the plan is to:
- keep cpuinfo_cur_freq as it is, not expose for x86 and call ->get()
  for ARM.

- introduce cpuinfo_avg_freq() and make it return frequency from hw
  counters for both ARM and Intel and others who provide the API.

- update scaling_cur_freq() to only return the requested frequency or
  error in case of X86 and update documentation to reflect the same.
  Right now or after some time ? How much time ?

  Rafael ?

> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 04fc786dd2c0..3493e5a9500d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -752,6 +752,16 @@ __weak unsigned int arch_freq_get_on_cpu(int cpu)
>  	return 0;
>  }
>  
> +__weak int arch_freq_avg_get_on_cpu(int cpu)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline bool cpufreq_avg_freq_supported(struct cpufreq_policy *policy)
> +{
> +	return arch_freq_avg_get_on_cpu(policy->cpu) >= 0;
> +}

And why aren't we simply reusing arch_freq_get_on_cpu() here ?

-- 
viresh


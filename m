Return-Path: <linux-kernel+bounces-199064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AE88D8186
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1BC1C223B3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A8A8564D;
	Mon,  3 Jun 2024 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YYb3zl00"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1E38562C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717415297; cv=none; b=ii3fveev/kHZIZFXxY4B584K2pdIxpA8okO5WsQMszAVGTV5Yv7ggIUkaeh5ZST/6otf8BVC8YLgOKsFDIXnzGBkkZBx1x02MQuWwpgXeWwofcu00UsseBTpOawA33Vhap/cBj346POw5NIxGXyuQOYV1tejaue6OxEJPJZJipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717415297; c=relaxed/simple;
	bh=wR5A6hecpARoRRWZgd2NYKAO1k8JQZFj4SPbmOoOjAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/3RgCksDv49Q9DMNarCUk32R8BNsn6qghTKu/ZsLBY2oLFM8YefcHJxLv2X8yTfQ3T7TZW9xlginX8gBb8HzLIwZSsYYVMqpmmM9Rs6/sxUCJAAdkuO7UmWhwwWsHImEPuqjZTxLfhGnBhiQGFk1Hh7Iviv3nE1PphUh88Qm1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YYb3zl00; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f44b594deeso30849515ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 04:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717415295; x=1718020095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KUzNVhckUaLfnqSSoRN0c/kRmpAdIiK8FmQ6QGiwkFQ=;
        b=YYb3zl00qkJt7e0C0w4HfgSp8Z0vn0D4E+S0nSlRmfNNRDqFy0Yeu91S1j1UTKhIkM
         MXCd2BpE3htM7Z5HdpRCMdfTtTeu66Hic1mr5BwCbggZVGj/8Qzb4qtNKQJhrVZqHfpm
         Udr35Qq1Vuwmu/PCCWdx19ax+bKGE9ftyFeSf9/YAFi97sNKr8/sIlp4NwNFjC6O7e/m
         Gyh3SNZnMOsfccm6mQqyoibn9o3nHjlN7nW3EB0Ro8tiOFq+qIySPJGlgrFGyhd7y6qB
         RLe+HcElFWbPZDkgJpTI51eMhIdoacf6iUje/fQxd9DU2KgS0lohkmHmkkF+DtUHCI5H
         47Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717415295; x=1718020095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUzNVhckUaLfnqSSoRN0c/kRmpAdIiK8FmQ6QGiwkFQ=;
        b=bMZNolwz6FQ5CIz2/9VFUkSH6HTRqO2s0+gBkkOKfxqX59XSiMuCxpuuFKlD3je8j6
         uWsdnbDnZnWUa8/JROrms/xUdrukHL3wQR9wPepFxm/Tk8IMh2ZPYaNqO9fM+IORqmyn
         ekpov7MPP3otnFeOsm4jSzgPk6X0os9xan5W2xBkh/OWmgcaTafn0CfrwQCl1yV1puG+
         WcyGy3v4GP69ss6JVzCQQk+4EYIlcobgbbuowEBsn+4/byfSn0QUzkbSJvs0eWpmWO0v
         GwwYyidL2ELznt5YV15Adz2ho3L2ZQXMAQ1KGC8r6MKf3Yh8wMJsS1g/DkDV2sQjii8X
         Zh/A==
X-Gm-Message-State: AOJu0YyyRbYfRDsKoBq83E24IJoz4oaCpY2lQktcQHuEz8+cau8iXrw6
	dtdapWNmCveM6kxNgV4lyE+F3pRahZNMoHhFEzxwe3CRw/0mpMkjTIdTRqN06MZR/SRDCgjGnxM
	1
X-Google-Smtp-Source: AGHT+IFap6u0+MFzW2YY2ja6/0cIlNs1i1vSu0Ls8bPRsbMzAYM3cdtNrv8q//r7PbFzWcfbtOc6Zg==
X-Received: by 2002:a17:902:f683:b0:1f4:5477:4be6 with SMTP id d9443c01a7336-1f6370529damr87187545ad.41.1717415294647;
        Mon, 03 Jun 2024 04:48:14 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f681a8b8c1sm13070565ad.253.2024.06.03.04.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 04:48:13 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:18:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, len.brown@intel.com, ionela.voinescu@arm.com,
	vanshikonda@os.amperecomputing.com, sumitg@nvidia.com
Subject: Re: [PATCH 1/1] cpufreq: Rewire arch specific feedback for
 cpuinfo/scaling_cur_freq
Message-ID: <20240603114811.oio3uemniib5uaa2@vireshk-i7>
References: <20240603081331.3829278-1-beata.michalska@arm.com>
 <20240603081331.3829278-2-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603081331.3829278-2-beata.michalska@arm.com>

Hi Beata,

Thanks for taking this forward.

On 03-06-24, 09:13, Beata Michalska wrote:
> Some architectures provide a way to determine an average frequency over
> a certain period of time, based on available performance monitors (AMU on
> ARM or APERF/MPERf on x86). With those at hand, enroll arch_freq_get_on_cpu
> into cpuinfo_cur_freq policy sysfs attribute handler, which is expected to
> represent the current frequency of a given CPU,as obtained by the hardware.
> This is the type of feedback that counters do provide.

Please add blank line between paragraphs, it makes it easier to read
them.

> At the same time, keep the scaling_cur_freq attribute align with the docs
> and make it provide most recently requested frequency, still allowing to
> fallback to using arch_freq_get_on_cpu for cases when cpuinfo_cur_freq is
> not available.

Please split this patch into two parts, they are very distinct changes
and should be kept separate.

> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a45aac17c20f..3b0eabe4a983 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -758,7 +758,8 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
>  	ssize_t ret;
>  	unsigned int freq;
>  
> -	freq = arch_freq_get_on_cpu(policy->cpu);
> +	freq = !cpufreq_driver->get ? arch_freq_get_on_cpu(policy->cpu)
> +				    : 0;

This is getting trickier than I thought as I dived into more details
of all the changes to the file.

Rafael,

We probably need to decide on a policy for these two files, it is
getting a bit confusing.

cpuinfo_cur_freq:

The purpose of this file is abundantly clear. This returns the best
possible guess of the current hardware frequency. It should rely on
arch_freq_get_on_cpu() or ->get() to get the value.  Perhaps we can
make this available all the time, instead of conditionally on ->get()
callback (which isn't present for intel-pstate for example).

scaling_cur_freq:

This should better reflect the last requested frequency, but since a
significant time now it is trying to show what cpuinfo_cur_freq shows.

commit c034b02e213d ("cpufreq: expose scaling_cur_freq sysfs file for set_policy() drivers")
commit f8475cef9008 ("x86: use common aperfmperf_khz_on_cpu() to calculate KHz using APERF/MPERF")

What should we do ? I wonder if we will break some userspace tools
(which may have started relying on these changes).

>  	if (freq)
>  		ret = sprintf(buf, "%u\n", freq);
>  	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
> @@ -795,7 +796,10 @@ store_one(scaling_max_freq, max);
>  static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
>  					char *buf)
>  {
> -	unsigned int cur_freq = __cpufreq_get(policy);
> +	unsigned int cur_freq = arch_freq_get_on_cpu(policy->cpu);
> +
> +	if (!cur_freq)
> +		cur_freq = __cpufreq_get(policy);

This change is fine and can be merged earlier I guess.

>  	if (cur_freq)
>  		return sprintf(buf, "%u\n", cur_freq);

-- 
viresh


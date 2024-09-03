Return-Path: <linux-kernel+bounces-312575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06889969857
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F13EB219F9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BC11C769F;
	Tue,  3 Sep 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QzB2GG0g"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BC21C7669
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354590; cv=none; b=omBvy3LNOkFDukeGI/n0VH8hWraC6r7bBqxme1R78yYr1Z1lt4zfc3z3hvr7OjfkAJ53oCUlAKOQ/nLZ5u5BjACynTUpZ6WrYD5UikGB22Jr8V+0R4f75Xmsi7+rTPyP422Dc63bDYfAIlrF8Rvhz9bZ4JEeEVq+W1sl9bxhOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354590; c=relaxed/simple;
	bh=mhNCMdmXQx/9BVSzjWgtTpeJaKJ+WCbfwr+Rv9a8SRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyCwizw76PqGZYbnVp8aQZ01NXBJBGvV24k2bqnOEQO96JwA0hm8pVaTE03XUkDwz10a2EoKqzxK73hbXWYGtzBYv1SJrbwcAHsZepxrs2/iwOzQtjZztknCj9QRpt71DvRtIb38mdTGOZgkh6O4NRqoqpz7G3nuq6KMF/yFRr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QzB2GG0g; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7cd835872ceso3427381a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725354588; x=1725959388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsV4q8d8HmroiyzNZA3zkvPM2YEa9w2l7UOPrHHxXY0=;
        b=QzB2GG0g+Kk6F7PplBRpO3yZXgbuTNJRCUqhzD2LJBDJOP43iF/mk+IpY7trQ5NL4I
         c42fqJvIFzjnZL0fIGW3467kb0/bJL2Ftsc6XmF+AmAIyeeNzp64uzzRetEQQTQ0deZ3
         FPe8t+shdIpvcMT2UpciZgb8aYs8uWhstkwjDG8GIVT/2dBnH6NMj+2Umk8aL2xN9VYc
         P00M3alHiJCOMNe0hOL2rFY9WLvxE81thOz1IPFOIXV/213/PSep3Nmu5gjuAOvMAXSQ
         nsEMNhukZEX/0T+os0ee7/z9a7q2AiI1/2BHivc/HIBQEAyNltyOufoDa/WfQ9uuuvaF
         pbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725354588; x=1725959388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsV4q8d8HmroiyzNZA3zkvPM2YEa9w2l7UOPrHHxXY0=;
        b=urLq/h8+/AFx6UFm6kpG/AlNrst2ANpaR/eHdJQ9itBN4He/59UB0FN4dPdAA+3THK
         Da/zNOOBffBOBkHp7mvRXqLUFnfABceg5GhqhKw7Ho7dkThBWwOjW/3zZN0JUoXf8QH3
         X8gcOTaHS8ma/Edd+zEuA8JGwF7x5aMPMU+fPoje62RykUGwwk0LRgB8jYQuyAo8PLRx
         CQILimAix3x53LnlgidQ972ryfqdfJ5iNN1NhuQ8GcesoyIk1cqH8LqgEkrte4/yKt6e
         Rd7f2VZRkq0AYLKHpiIkEBWSUNq0zAPWEEDsX9k66roD9rw7ZjIhQS0wlpUbGhNWajEB
         JqjA==
X-Forwarded-Encrypted: i=1; AJvYcCUmIzYfAESMJXItk0oalyBhibV8Vo9dVfpu5UG/JBjoQZ/fDJgsx06ORrYXjyWDvGAjbQpLcI27XkRvlzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz47JrldQSou7MaAh9Di3qCpOxRDZsGrwcngiCJ+iFCA29vzxdO
	J+TXeZ8d3BfYhI5NB4PCAX+1QdHP5ZpSaZDU1JzaTMtDmwPoOYqR634YfTV34PV202wozupsHTc
	f
X-Google-Smtp-Source: AGHT+IGY28JAMIxy1PxU63Bxh8OG0t6izbnuuuNEdXt9/cEqJkJ1IBW0Kp2isWZ1Io52De4YznvI7Q==
X-Received: by 2002:a05:6300:41:b0:1cc:be05:ffe2 with SMTP id adf61e73a8af0-1ced0468f79mr8699300637.18.1725354588232;
        Tue, 03 Sep 2024 02:09:48 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2058456e121sm22602085ad.111.2024.09.03.02.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:09:47 -0700 (PDT)
Date: Tue, 3 Sep 2024 14:39:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vibhore Vardhan <vibhore@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH] cpufreq: ti-cpufreq: Use socinfo to get revision in AM62
 family
Message-ID: <20240903090945.rqqqrchwadustegn@vireshk-i7>
References: <20240902092135.2826470-1-d-gole@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902092135.2826470-1-d-gole@ti.com>

On 02-09-24, 14:51, Dhruva Gole wrote:
> In the AM62x, AM62Ax, and AM62Px devices, we already have the revision
> info within the k3-socinfo driver. Hence, re-use this information from
> there instead of re using the offset for 2 drivers trying to get the
> same information ie. revision.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> 
> Hi,
> This patch depends on [1] and if someone wants to test, can use my
> github branch [2]. I was able to test this on SK-AM625 [3].
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20240828131915.3198081-1-nm@ti.com/
> [2] https://github.com/DhruvaG2000/v-linux/tree/ti-cpufreq-revision-fix
> [3] https://gist.github.com/DhruvaG2000/d0c360b0bd7e43d0fd28cfe3eab941d2
> 
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Vibhore Vardhan <vibhore@ti.com>
> Cc: Bryan Brattlof <bb@ti.com>
> 
> ---
>  drivers/cpufreq/ti-cpufreq.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 804329e81eb8..ba621ce1cdda 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -16,6 +16,7 @@
>  #include <linux/pm_opp.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/sys_soc.h>
>  
>  #define REVISION_MASK				0xF
>  #define REVISION_SHIFT				28
> @@ -303,6 +304,13 @@ static struct ti_cpufreq_soc_data am3517_soc_data = {
>  	.quirks = TI_QUIRK_SYSCON_MAY_BE_MISSING,
>  };
>  
> +static const struct soc_device_attribute k3_cpufreq_soc[] = {
> +	{ .family = "AM62X", .revision = "SR1.0" },
> +	{ .family = "AM62AX", .revision = "SR1.0" },
> +	{ .family = "AM62PX", .revision = "SR1.0" },
> +	{ /* sentinel */ }
> +};
> +
>  static struct ti_cpufreq_soc_data am625_soc_data = {
>  	.efuse_xlate = am625_efuse_xlate,
>  	.efuse_offset = 0x0018,
> @@ -384,6 +392,16 @@ static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
>  	struct device *dev = opp_data->cpu_dev;
>  	u32 revision;
>  	int ret;
> +	if (soc_device_match(k3_cpufreq_soc)) {
> +		/*
> +		 * Since the SR is 1.0, hard code the revision_value as
> +		 * 0x1 here. This way we avoid re using the same register
> +		 * that is giving us required information inside socinfo
> +		 * anyway.
> +		 */
> +		*revision_value = 0x1;
> +		goto done;
> +	}
>  
>  	ret = regmap_read(opp_data->syscon, opp_data->soc_data->rev_offset,
>  			  &revision);
> @@ -406,6 +424,7 @@ static int ti_cpufreq_get_rev(struct ti_cpufreq_data *opp_data,
>  
>  	*revision_value = BIT((revision >> REVISION_SHIFT) & REVISION_MASK);
>  
> +done:
>  	return 0;
>  }

Applied. Thanks.

-- 
viresh


Return-Path: <linux-kernel+bounces-442631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C61519EDF9A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8CD28387E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 06:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9EE204C2C;
	Thu, 12 Dec 2024 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXFnks2q"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08701885B4
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986266; cv=none; b=fpwG9FPo8H2YYHmkDHVTapfL7wBgZWtcK3sLhX0DdgWjHBO9vyI3VIp1ODl+AhTr3LyR5gQ022LQpfvp5Ak56YYs8pEM9HfzLXqdv1K71dkSXZdNa1P32SubeipqX5MAU1lK/gtcpL3dXecKTfG7cYVk4yDWbpy+kmVfw2KH8pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986266; c=relaxed/simple;
	bh=J5qTMehS3VZ62nZjN03LGp8GqaYD+XZuK6SdZqnwox4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSjYCknQJOi+/wHunQMWdCB5TQQvviIdlqf7mrLMrh5z+RgywbieDCmlgDamabKIk1kKP53XA9iQEPZmyxg6Wl0GfCa5Hh7OaUxEKAoyU+gA5urc8NFQdgH+57rA8eeYhptCkjTdjQMQKg+IUBUIJ+qga2m+brAQAZF1qIIaCmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AXFnks2q; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-728ea1e0bdbso220348b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733986263; x=1734591063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AzE1O+wEcFJCWBuWQepSclrHJZ9pm/tyRfOt1u5cgLg=;
        b=AXFnks2qbV0MiA1bgTfCHENGufngpialPoAEaehB+J9DhSOEay/ENWfonPAaEAvk+Q
         VIhF/XgdWHCTr/WZlEdWzxDWKhFttJsL+GvOZKfrWPIJKbJMZSFqEi8hQv/Q0QM5cWgp
         l6UboFp5y7MddO6KU0x/pqrS3qQxpY7oehPbWTnmkCtvGacseg52O74GKjSnUXdfiSPs
         IwDDZl67d3j9U1/PXG+Yal7ZgN5tdfcv5ZOOOTNCVwnRsqlnaFZPeZoa//igP8MFRguF
         Hzr1zOsLycE43CquhBsGJkCcAB1Y4sZXXEtbHWL/17eFINWJe6U1+eMDLlFBw6M3g4f1
         G87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733986263; x=1734591063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzE1O+wEcFJCWBuWQepSclrHJZ9pm/tyRfOt1u5cgLg=;
        b=k4aH4rulDXLdoTilObjHQdJPkSTO7/J5c+Fx275xdJzTXqvODNeQKCpUfxLnm1dlIR
         SdMfYq6XAsQB5cGD8Xu19RU63XJ8vDmjsBkiu3dgZeOfZWTlCX+S1vs6p4Py2QUMm+PZ
         F9tdbMNu68kw/cmsJVF3iDzuxlVd4e4/FHbsQq6ufoiYWO5+cABwzCVwwS1w/7RcUWg/
         go9tehIwAdF2McWzFgd1dieycsmH61yNHoy+Jrh3wgl997uQYKeVY2F94yBoWc81JJ60
         ebEJpzVVEzup1DwVw21IFqwrXlU51nM1HnCJoZSO0pR8Vi+b524j4MCT/4BW8LClJJG3
         DN2w==
X-Gm-Message-State: AOJu0Yz/rj092M9Ng+H/HDr13h5gsz0Z/uFU8cJaGOzlyjMcpZRiUbZF
	PKrIpUAkQISvaUy4wTo4ZSl7W81wWBOjBequMh7eOTO2pqH/Eh+TKmGeJhdmROc=
X-Gm-Gg: ASbGncurkxsrLF3dkx3xP6ix5zwBnmsLU9MtN9KmM0pHfHmMVujS0EkbWzyPXDhpc+C
	e7isK2nXMp5tC1NgixfKUo1krXU7gGs+OrbKLMLoMMqaNRxngkLp4UoNPk7PR595qS5arP1gFzQ
	+2KqZv+oztXVVIjeeQ1CXPlZ+I1K0i3MRXTaI9z7fwxY5e+doh8Mfy5aVH5IAhNVzKnL4L0P/Iw
	3zDRCU2mk20hlD5PG3O8+X/6smvpZxYaA/cbRDT3ENFsZQR4QshsdQWubg=
X-Google-Smtp-Source: AGHT+IFE78oKDXfbnWAKipxIsGcsj9ziBXqvMJZisKuD8EuJoQLV1Ku/T9xLrtjkJtyJVpTFpdinxQ==
X-Received: by 2002:a05:6a00:9aa:b0:725:e325:ab3a with SMTP id d2e1a72fcca58-728faa1ce63mr3316269b3a.14.1733986263004;
        Wed, 11 Dec 2024 22:51:03 -0800 (PST)
Received: from localhost ([122.172.83.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e82197e4sm7131155b3a.72.2024.12.11.22.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 22:51:02 -0800 (PST)
Date: Thu, 12 Dec 2024 12:21:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
	sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
	rafael@kernel.org, sumitg@nvidia.com, yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com, lihuisong@huawei.com,
	zhanjie9@hisilicon.com, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Phil Auld <pauld@redhat.com>,
	x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
Message-ID: <20241212065100.sjb7lrlmksbm2hdk@vireshk-i7>
References: <20241206135600.4083965-1-beata.michalska@arm.com>
 <20241206135600.4083965-2-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206135600.4083965-2-beata.michalska@arm.com>

On 06-12-24, 13:55, Beata Michalska wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 04fc786dd2c0..70df2a24437b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -747,9 +747,14 @@ show_one(cpuinfo_transition_latency, cpuinfo.transition_latency);
>  show_one(scaling_min_freq, min);
>  show_one(scaling_max_freq, max);
>  
> -__weak unsigned int arch_freq_get_on_cpu(int cpu)
> +__weak int arch_freq_get_on_cpu(int cpu)
>  {
> -	return 0;
> +	return -EOPNOTSUPP;

I did suggest not doing this as it may not be acceptable.

https://lore.kernel.org/all/CAKohpokFUpQyHYO017kOn-Jbt0CFZ1GuxoG3N-fenWJ_poW=4Q@mail.gmail.com/

-- 
viresh


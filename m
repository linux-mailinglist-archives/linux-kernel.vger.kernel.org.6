Return-Path: <linux-kernel+bounces-416634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05E39D4810
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CF128249C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 07:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8A81C8FB7;
	Thu, 21 Nov 2024 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kn4ptSmZ"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FA11865EF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732173093; cv=none; b=WJKqJ31Kahno9VZq4hY6WOmdCxYP2ofpboisstG+PWCLmWP+rG4YuH9WHAxQNtDvsQPi7+KpCKf+i94nrxJzyRF9KpXHvKQtRs7d88jRgJqG4ZUxJRoPxpmnaCGyrMtjnZTNrn5/xbepCNsjqHCoSs5xmfOHhNUqIVQva4mfDwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732173093; c=relaxed/simple;
	bh=dR2xaYZLT8J72LgXJrYpTqW3JoYtXIm13DXRuOxZJb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkeoHHNvCnE5ZiLmgFw7YE3voejksEpmJrH9LCY+yE0TgWY4PXB5a8U3GTEeRLClAl7Qi3DTkwmBe5TM8+KbMvrNxRpemMYV49As1hJqIpQxhJwoDYecfEjuxfs26H9R0p3guUL6wQ0c09Sb3FCv+1O5Zwn5HWxLvd06VvCb+Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kn4ptSmZ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f8cc29aaf2so454321a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732173091; x=1732777891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lwndOPs6zZlfAWU75NptZcH8ZvVkNsjK1khYdtyhMYo=;
        b=kn4ptSmZzCPnbE851bx6eZxADkmjRZGCZ2x2f2ucSajOo/fOEeyDm1/J9jqWhOwrA9
         Iwdh0h7/OAYOOdZ8R0qANoMZ27mrF/OcjVYdKJDzPMplUULG6aYspAfy6bAheRwZx/KC
         hxwu5tccd4cFFM7Q4jorz+BKao40fnNcvXROoKeXhrDG9UtlkXzRxXeGIzoIZHAaeuRt
         3/nGgrmGNmDGCYXlGJW5o4uy2A7QiwTK1pzXTAtp+AJDzPImtUzZajfIUUD1F0/vBBUI
         Y0o/MuXsMXvFZrZQexPsPf88xomgJN30xDQX7F651BzBjo4XqIt056juogW704OW69T3
         v6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732173091; x=1732777891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwndOPs6zZlfAWU75NptZcH8ZvVkNsjK1khYdtyhMYo=;
        b=dJLlJDO3crbi+yNNLqR9UYbK+OZSBmstoAqIx/Gb4UThlz6ymoYpt8aGaepRypbrJZ
         RhBtHA5cchepp44Zp6BeBZMhipp5ARNPk5qrEfPHSeY3ZHeiBs6L5F6siOnrC1ipfPDY
         cOponIzQaauF0jIMDJMSI4rKh2EkyVF/aUv1T11O97ncTOWOfJ/kiB90rqCumXEiThxi
         Xtt0l+hfNyqyIo9ExsCqpF95yr0H4j0JEGlHSmwCsFOVAcqh7BJVj24Y9ba4WaGgNvR+
         +PJF3Utms6aAOkoBEuMEgysDaDEyghnqONO/6QUuIB9fWPz7qhbIb/ZZ4jgOlklaA3vB
         E9ew==
X-Gm-Message-State: AOJu0YyvfbBtQLxy2BqR6JqiMaU6JLEo2N653oDxHU3EDRqMjKw2vQ8g
	8Y8+Y7Kt3dIfWxWi0eFB+AbIFjvwcofb000vN8iMD/YeYYMH7PcpHUZ6IuTFUvA=
X-Gm-Gg: ASbGncsnfEp5hCKQmFk9T0Sl2b56Zd/OmqPvU6smxSOVbzQYzorUm4UuTQAySb9OIYn
	3rS6PXXtE1LeTuNgeAaiu/8z0AcXV+F3rDwhIb37G3qE5SFqbEPaDhN+LcI4wqg9x11tbTzFENe
	LsB2xsJ6HnKhoFhCaLHrQH0ieanW70DbbzuxTCX6NpKD5MSKdGbgIsAuTC8CCd6G5PDLrQOqnII
	o7a2CxKpstEpFDycolnyUHhQeWMO77k38jsiAsrWAPoTCpQwdUt
X-Google-Smtp-Source: AGHT+IG1cAE++g+6JuO24wxOlmcC0eBMb+agSIobo0ZkO7QH+WoKZoKf3psQEBrm9NMN1Vi72tfcKg==
X-Received: by 2002:a05:6a20:748d:b0:1d9:db4c:240e with SMTP id adf61e73a8af0-1ddb11d8450mr7427559637.45.1732173090552;
        Wed, 20 Nov 2024 23:11:30 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724beeb83easm2895696b3a.16.2024.11.20.23.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 23:11:30 -0800 (PST)
Date: Thu, 21 Nov 2024 12:41:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Javier Martinez Canillas <javierm@redhat.com>, robh@kernel.org,
	arnd@linaro.org
Cc: linux-kernel@vger.kernel.org, Radu Rendec <rrendec@redhat.com>,
	Zhipeng Wang <zhipeng.wang_1@nxp.com>,
	Maxime Ripard <mripard@kernel.org>, javier@dowhile0.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH] cpufreq: dt-platdev: Fix module autoloading
Message-ID: <20241121071127.y66uoamjmroukjck@vireshk-i7>
References: <20241119111918.1732531-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119111918.1732531-1-javierm@redhat.com>

+Rob/Arnd,

On 19-11-24, 12:18, Javier Martinez Canillas wrote:
> This driver can be built as a module since commit 3b062a086984 ("cpufreq:
> dt-platdev: Support building as module"), but unfortunately this caused
> a regression because the cputfreq-dt-platdev.ko module does not autoload.
> 
> Usually, this is solved by just using the MODULE_DEVICE_TABLE() macro to
> export all the device IDs as module aliases. But this driver is special
> due how matches with devices and decides what platform supports.
> 
> There are two of_device_id lists, an allow list that are for CPU devices
> that always match and a deny list that's for devices that must not match.
> 
> The driver registers a cpufreq-dt platform device for all the CPU device
> nodes that either are in the allow list or contain an operating-points-v2
> property and are not in the deny list.
> 
> For the former just add a MODULE_DEVICE_TABLE(), and for the latter add a
> module alias. That way the driver would always be autoloaded when needed.
> 
> Reported-by: Radu Rendec <rrendec@redhat.com>
> Fixes: 3b062a086984 ("cpufreq: dt-platdev: Support building as module")
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> Posting as an RFC because I don't have a platform that uses this driver
> but I'll let Radu test since he reported by issue.
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 2a3e8bd317c9..7ae7c897c249 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -97,6 +97,7 @@ static const struct of_device_id allowlist[] __initconst = {
>  
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, allowlist);

This is fine obviously.

>  /*
>   * Machines for which the cpufreq device is *not* created, mostly used for
> @@ -236,4 +237,16 @@ static int __init cpufreq_dt_platdev_init(void)
>  }
>  core_initcall(cpufreq_dt_platdev_init);
>  MODULE_DESCRIPTION("Generic DT based cpufreq platdev driver");
> +/*
> + * The module alias is needed because the driver automatically registers a
> + * platform device for any CPU device node that has an operating-points-v2
> + * property and is not in the block list.
> + *
> + * For this reason the MODULE_DEVICE_TABLE() macro can only export aliases
> + * of the devices in the allow list, which means that the driver will not
> + * autoload for devices whose cpufreq-dt will be registered automatically.
> + *
> + * Adding an "of:N*T*Coperating-points-v2" alias is a workaround for this.
> + */
> +MODULE_ALIAS("of:N*T*Coperating-points-v2");

How does this work? This will autoload the module for any platform with
"operating-points-v2" property in the DT ? The driver though works only if the
property is in the CPU node, while now we will try to load this driver even if a
non-CPU node has the property now.

I am not sure what's the best way forward to fix this.

Arnd, Rob, any inputs ?

>  MODULE_LICENSE("GPL");

-- 
viresh


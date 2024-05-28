Return-Path: <linux-kernel+bounces-191825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AA78D14B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1FE283E05
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065395339B;
	Tue, 28 May 2024 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwOB9zC+"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACBF1BDD3
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879192; cv=none; b=nhkRAmsVkWCewIHhPNfhsBeS56JETrJT8P1d91Iqy+nUnV9N5CkmbsZ7aCk//C4CQI1B2fyk1vGw/cOtH7UtBY36aGNczJJMlFHbEEvm+wzVlwm/LAQBkJCwRdIbui48lSA7vz1qrWZeJ0UqN6t2QAlbw5F4qjWcVdzp2tDyItk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879192; c=relaxed/simple;
	bh=MFhs9/4/KnYhU7bixwTj8g8sHF+zGloFZrbHBdROFkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XH7z3SRZBvUetT6+UoZx5WaFwzzFBmpziW5cDyugnmQpbJ7JXwJ2JfDIyMb4uC/2x7oOR0TaN59Wx3Rj1YeqAU/6G5NuPiwsi+nE9vjzrNE+5p40evobJNmCLj95O9dl9gjfNG/m1nNvNE/4Wd+QKzTvyJlIhKHJrVnLLy8vDno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gwOB9zC+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f8f30712d3so1937333b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716879190; x=1717483990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zlz29iodFOMw14RnZpFK2iit4WCC6vTwGm+tYGoGHKg=;
        b=gwOB9zC+VIQRIMdmzrbCsfQYxBmnPG7sW4VAMf9pdYKFfb7cuL+S6OdaSnNxuPkC16
         IoVGuyXESFMC5/OvO3q2ZwxCx58nMWwaLdfGuSYE4o5zIBabpXh+jFaMX3mGa38QQEAh
         m3Uhc3j3tYwHkmUcT4MIJlb6Q5U1cwdmxB7/TdhDcJSH9FgqpiY22dn41xq1cs/aW+fa
         kgE3VLJmjdX96Uy3P9ggzBKPErxIyvsswqzghxbSNPA9hIAJNP35AniiJWUptJ8vRjYF
         GA0hSQwaDCvVwoCP50hVGbHz/Ggw/LiwyCH6w5QEEP34neegwiPlJ6gKnWQTPG7Hj934
         DbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716879190; x=1717483990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlz29iodFOMw14RnZpFK2iit4WCC6vTwGm+tYGoGHKg=;
        b=EflgftD//2uO5aCDYeRopdcGHiY/1lJX4iLRSG6YJqEiHoOdClK45Uh5JnDhr65/on
         bPSZ/b678NQOqNFX0tkSVvIWulqMqzb+7T+LE8dRYMWP6KQgVmoj1SaTsI/wg2uew5Ot
         iTMtkkk5ES5XgYBkmsCChj8uZZOfxAWd6ukSiH0SJ6UFUUFO7p89FeNUO9xko5YEwlB3
         9hs+BhEJd+PdFP+9N0J2AbviqVwt6BXJJzzwsd0x7jiKCKx8DmP27NYFdiRXKoCcmXzV
         3p55DMB0pZpBzM6l5M9B/ETXqrnBgrpxvXj5Pyyez9cJewA2ze2vuwxy+VnbnAMNQ35s
         PIZg==
X-Forwarded-Encrypted: i=1; AJvYcCX+hizC1ZxYTfwZIBr6alTgTR9NhK4ihZOqdXNq9ZzNY13w1+cWeqwMIDjC7GDJA+YXEx2XonB8JptfLdfx57MFGgKrGyhpMbaq9BOY
X-Gm-Message-State: AOJu0YxRqimWgdRxRH1gRM+uDn6tRhR5yJTycJp88D36tsySBp73WsmI
	659v25SlVpl1SzEVWJkAgxTb5ts1cbU/+fVtB7KWqvbx2dWMGbbpDv4H3qBw3PA=
X-Google-Smtp-Source: AGHT+IEEdcuEvmK07i02IWiptZ0LaWC1/GpoVpyTFIkU2FpULvAsdQXvYWBWbq7M8iWbV7N5a7ZXrg==
X-Received: by 2002:a05:6a21:3398:b0:1af:a9ad:fbbe with SMTP id adf61e73a8af0-1b205cf89b4mr21796164637.27.1716879190257;
        Mon, 27 May 2024 23:53:10 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682271d78d7sm6977547a12.77.2024.05.27.23.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 23:53:09 -0700 (PDT)
Date: Tue, 28 May 2024 12:23:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cpufreq: longhaul: Fix kernel-doc param for
 longhaul_setstate
Message-ID: <20240528065307.2gdau7dnfvjzwj2s@vireshk-i7>
References: <20240524092037.71666-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524092037.71666-1-yang.lee@linux.alibaba.com>

On 24-05-24, 17:20, Yang Li wrote:
> The patch updates the function documentation comment for
> longhaul_setstate to adhere to the kernel-doc specification.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/cpufreq/longhaul.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> index 4c57c6725c13..bd6fe8638d39 100644
> --- a/drivers/cpufreq/longhaul.c
> +++ b/drivers/cpufreq/longhaul.c
> @@ -236,8 +236,9 @@ static void do_powersaver(int cx_address, unsigned int mults_index,
>  }
>  
>  /**
> - * longhaul_set_cpu_frequency()
> - * @mults_index : bitpattern of the new multiplier.
> + * longhaul_setstate()
> + * @policy: cpufreq_policy structure containing the current policy.
> + * @table_index: index of the frequency within the cpufreq_frequency_table.
>   *
>   * Sets a new clock ratio.
>   */

Applied. Thanks.

-- 
viresh


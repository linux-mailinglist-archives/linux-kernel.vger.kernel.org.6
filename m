Return-Path: <linux-kernel+bounces-358510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B58699803F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19D128289E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9BB1C5790;
	Thu, 10 Oct 2024 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FPnqr0Pk"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAC51C578C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548267; cv=none; b=gimeQLPh+E+RE/azZZFy9Ha47YWMY25XulfPuE6iNe2GwQ7RuexoFVmc9aS/5s9boMiUHBtX7DtgR9LXAU5w7FWgidZclp41dkGVQQoMNRKcUxefkXeEd3aTbu7zLzhLHD+eGIg9ACFaIBzRWsz/eJqYM41193XrvJn6cvRRUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548267; c=relaxed/simple;
	bh=2XZJGdP4uS7akmtYh6C3g577TJust8x6E0dYSh+nI6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2Fb1TQmubzRdyZUWQCSsCbnbAkAFbAOcqYXjIRqy2cAyb7ithk1anoghWFZx737wmmkW0pY6ecqFi7r4jcXJl5WvIc2usmuGCyYQnFqqtPPbujadRPS+AuhidVzS2cdaSBF6OabzWEt4M3iRaQY7xftV4fp2FjGHdZ7fYB4VVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FPnqr0Pk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so1200626a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728548264; x=1729153064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KfFjRIz1Yuvbl5Bt9vW8i6ZynIZV+mEcMmGM4N6/pLw=;
        b=FPnqr0PkzXAOlFqcDH6E8m9QV8jNh5F1irjou3QGfAsmZgG6R7SMz/nAbGi1pEEi0w
         i4IG33DAAAIu3nKFkqmoOlfUiUO6FkI81waCzgTb5qQQllHFU1kB4cemCx4RBqT+LpaT
         AEGIq493qOyn+VnnpbJOT+1BKvBrF+0Yow94THDxiT5gLpQQsAkzA0Tp0AibRVSlTzRh
         Ik2zZTUjkX11FdljKpR+wRB05mPeoPVqzprOIFGaMkK0vfU8fAjYIzjTwqLx/Jp9JyWf
         usePaXkhuvKEgC53JSyd9SJmg5fB2XIJ9wDMqGaCbW4QSI1KrXrCS45hYQIOju/fgPAd
         CX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728548264; x=1729153064;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfFjRIz1Yuvbl5Bt9vW8i6ZynIZV+mEcMmGM4N6/pLw=;
        b=tJq0kGghDnpyGCV2VABpsRjbj0iIVTaPKPL1UgElfuzl+5TbyNqo89NqOfRMKG1Vpq
         luPmtAsW1onS10Yx6c9K3EsoavYifX2MaTYtic92iyVaeqp1o5yAIqk0pEdI4hSP2y58
         8JxH4na83XyOxl/KYrAgwLEASs0awQfMS/uJtU/o0bUxTzWF5AgcUN+p2VqpkXsWf/20
         MoX8nUU+AqPLFylPlaDFVnOGgpy9f7SG4iTWmU6Taj9x8d4oTwO/GFQLx3e6iTdb+FFq
         k0KnCZGMDZWCGavfdv5Ih9tCREQPL+wl6qzM7Q8sH+za0Qfk4AaxQGgC8gWJbGFmpeZV
         RP9A==
X-Forwarded-Encrypted: i=1; AJvYcCVARRWcC9bVuNFNCp6fp4sjGVxEOBoLOubWWcHtyUVP41ywnmbl3d1MqvkgOz9X2vp7t7RzObhA4rJ7Usg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTnfutMKZV38uVjp+Bw4/JoEwydxJnKiLz8AiA1+xnOiY6Bac9
	9N2INfDUxjq+0X1IRiKlJEiaBgUSXtcwWE/Ode5SImfObhxc+Ci5V8HjARkQxBpCp0ZLCsnuuQ4
	=
X-Google-Smtp-Source: AGHT+IHprO0InyX/z4iovA+Lj3INMCpc+yLlH2kBdOBRCfmgQoAsPTgYOxOtRdSXf2H/ilh4hM8nqw==
X-Received: by 2002:a05:6402:1ecb:b0:5c8:78dd:8027 with SMTP id 4fb4d7f45d1cf-5c933554318mr2072193a12.12.1728548263527;
        Thu, 10 Oct 2024 01:17:43 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9370d2246sm444803a12.5.2024.10.10.01.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 01:17:43 -0700 (PDT)
Message-ID: <e6d4912a-d6d0-41f8-a3e6-fe3eec6c6807@suse.com>
Date: Thu, 10 Oct 2024 10:17:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xen: Remove dependency between pciback and privcmd
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20241010075848.1002891-1-Jiqian.Chen@amd.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <20241010075848.1002891-1-Jiqian.Chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.10.2024 09:58, Jiqian Chen wrote:
> --- a/drivers/xen/acpi.c
> +++ b/drivers/xen/acpi.c
> @@ -125,3 +125,20 @@ int xen_acpi_get_gsi_info(struct pci_dev *dev,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(xen_acpi_get_gsi_info);
> +
> +get_gsi_from_sbdf_t get_gsi_from_sbdf = NULL;
> +
> +void xen_acpi_register_get_gsi_func(get_gsi_from_sbdf_t func)
> +{
> +	get_gsi_from_sbdf = func;
> +}
> +EXPORT_SYMBOL_GPL(xen_acpi_register_get_gsi_func);
> +
> +int xen_acpi_get_gsi_from_sbdf(u32 sbdf)
> +{
> +	if (get_gsi_from_sbdf)
> +		return get_gsi_from_sbdf(sbdf);
> +
> +	return -EINVAL;

Perhaps better -EOPNOTSUPP?

> +}
> +EXPORT_SYMBOL_GPL(xen_acpi_get_gsi_from_sbdf);
> \ No newline at end of file

Can you please take care of this as well while touching the file? Or
maybe you are doing so, but the diff doesn't show it properly?

> @@ -484,6 +483,7 @@ static int pcistub_init_device(struct pcistub_device *psdev)
>  		if (err)
>  			goto config_release;
>  		psdev->gsi = gsi;
> +		xen_acpi_register_get_gsi_func(pcistub_get_gsi_from_sbdf);
>  	}
>  #endif

Why here rather than directly in xen_pcibk_init()? And why no change to
xen_pcibk_cleanup() to remove the hook again on unload? Which will then
raise the question of possible race conditions.

Jan


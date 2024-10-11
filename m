Return-Path: <linux-kernel+bounces-360777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B02C999F62
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310B91F2552C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721C120C483;
	Fri, 11 Oct 2024 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ar6nEd9/"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A5920C477
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636883; cv=none; b=nahXubT5M9AAnWpqRe3W6dYVJvhRdj8WbFdpmUQqfI9mo7V3Mieg/HKb/TqftxNfbuWSuBzdhLNrQ3Lz2VXS0VCcYtju6/u2TlV6nay37HFMRiO1/4CCmr9WGwp3Gb/0MsSEKTsuMOGcpMMDDiY1nIQkjfWVs6/qm4Ga6CvBKuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636883; c=relaxed/simple;
	bh=g2gyKFm+JFjIytCyQkJemxE0+ztNsha5Nk1ranxiJMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFpMXdZM4i0LNj6c6HclPFZLjLthHGuLgIFrB39DklYzLOklP6nUOFqw5sclf3EyJe/vobwAw/xt5mAPphet5FCcGq1UicoSCsdjA4+za86w2zuoI9iiiIEMF2JJWiLT5/864ZVtPfVgFpYizvDxkkiEu8WFRagQJCSxYaGsm0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ar6nEd9/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a991fedbd04so142503366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 01:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728636880; x=1729241680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EVqqV8bbP0vqZxsA2NHfVq60VXKBmC8xzX4oMOGwDjo=;
        b=ar6nEd9/M9DT8NFbBvvuQYiK0C+7/hR2sNu+pBZWvo5rQ4RjGrKxC4YgnAJ5YtMGMH
         RbFb3tlFamllOybUIFcfFM9lrabT1EPA+L00bsUBZnu4oesEeYbCNAUymvO3+XvZznL/
         P59Vgz11Uo7rImLFOsbPfKK5XsznHiV29jeL+tO7q+INYK7bFvQLyuC7DagtKDoK5pGJ
         ZhFpLGXSPj0Oj2CJH8omoUIHA2cdD0pkgqK7PYvAonQiOz1KLtjfffSA5tN3oZ9MMRfv
         pGwSBHNnD+oso+veltrI7nbk2Q0dBJ+4rIJ0uGHMrJaNv3UMhH87QMaNA6BdwqjNTk5/
         1u/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728636880; x=1729241680;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVqqV8bbP0vqZxsA2NHfVq60VXKBmC8xzX4oMOGwDjo=;
        b=YxYYB0ejANpEt21wj5fiCxgraQiej5XjYmnKfr7O6rYh/2v8e3cV0Snp2ApVIReI1/
         aUKxemttIrHk27+Pr2XUkh0MzK14ljt+CESbkygq894hJiBOoiU4jmFdeW2aQ7UAa05j
         OboYKT2vir8Rx7wBdUV5NS3zUyCJGyVZDcJIIv2t5o0zXFUJTYjRLKzAW561ylhaQ7VC
         RWjC6Y0c2TYu+rps+THryjBjY0jw2kzIdt377P3Pc8xOHIA45jUkT3YaSzY6rmpLN0v1
         5Myiu5mE8EiqWHhKfPjv/NEWZCo5g/syR5YtaDopxvRi1qwApWSnrG7h3DBV6da5GhA7
         GrTw==
X-Forwarded-Encrypted: i=1; AJvYcCVdlEOCvCtjbG2B3hhMqjkIwR4Bj04OwvP+T4wb5hghsnJH3coZGdh+ZJ/id2R4qCHtMIgnMHWeFUSd5ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfyXKsnbULAUXl/LyF9qO74UQ3fLDV37lupJIaJaIBUX6e+Tql
	CcwuiVcvXx7jkpbMmjtwnBLStydn9U5agczHf28wXrvjv0e80EaEUOnRqULvtFVkDX02xC7hhYc
	=
X-Google-Smtp-Source: AGHT+IFdCYEySFaAL2Q32bJrB2QP+f1I1PhmuHc4V7q3/BGmRtBabQTghb5XU7NgxOUjqBrA7M8lZg==
X-Received: by 2002:a05:6402:354f:b0:5c8:9f44:a0b2 with SMTP id 4fb4d7f45d1cf-5c948c8834dmr1938980a12.5.1728636880095;
        Fri, 11 Oct 2024 01:54:40 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937156781sm1712575a12.56.2024.10.11.01.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 01:54:39 -0700 (PDT)
Message-ID: <318bd8a4-a349-4e7b-8653-6995d5f9f125@suse.com>
Date: Fri, 11 Oct 2024 10:54:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] xen: Remove dependency between pciback and privcmd
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20241011034227.1278144-1-Jiqian.Chen@amd.com>
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
In-Reply-To: <20241011034227.1278144-1-Jiqian.Chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.10.2024 05:42, Jiqian Chen wrote:
> @@ -1757,11 +1756,19 @@ static int __init xen_pcibk_init(void)
>  		bus_register_notifier(&pci_bus_type, &pci_stub_nb);
>  #endif
>  
> +#ifdef CONFIG_XEN_ACPI
> +	xen_acpi_register_get_gsi_func(pcistub_get_gsi_from_sbdf);
> +#endif
> +
>  	return err;
>  }
>  
>  static void __exit xen_pcibk_cleanup(void)
>  {
> +#ifdef CONFIG_XEN_ACPI
> +	xen_acpi_register_get_gsi_func(NULL);
> +#endif

Just wondering - instead of these two #ifdef-s, ...

> --- a/include/xen/acpi.h
> +++ b/include/xen/acpi.h
> @@ -91,13 +91,9 @@ static inline int xen_acpi_get_gsi_info(struct pci_dev *dev,
>  }
>  #endif
>  
> -#ifdef CONFIG_XEN_PCI_STUB
> -int pcistub_get_gsi_from_sbdf(unsigned int sbdf);
> -#else
> -static inline int pcistub_get_gsi_from_sbdf(unsigned int sbdf)
> -{
> -	return -1;
> -}
> -#endif
> +typedef int (*get_gsi_from_sbdf_t)(u32 sbdf);
> +
> +void xen_acpi_register_get_gsi_func(get_gsi_from_sbdf_t func);
> +int xen_acpi_get_gsi_from_sbdf(u32 sbdf);

... wouldn't a static inline stub (for the !XEN_ACPI case) aid overall readability?

Jan


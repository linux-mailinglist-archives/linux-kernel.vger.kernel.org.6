Return-Path: <linux-kernel+bounces-293706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B527A958359
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747DD1F2569E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF7418C34F;
	Tue, 20 Aug 2024 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AT+Ey2qg"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3CD18E360
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147784; cv=none; b=sZ1vNoumJIpXvDyBDnTthrGk6YL6Birk+SUXOAm2H7fWqZd60Yei0sHP2OZh+BfqpwEJPun+HAEaYwbaQZ9kuYIKg9vHS+krB4WIo/UDoIVZR0C+Jv0krbkr32RofSCwe2aBLfaJEekXuqooDSXLrJQT7SUuSb+kUiT944tmRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147784; c=relaxed/simple;
	bh=AT2XFkT4wDbUyhV+U8SUKVJbCNxM8heu+SNR0vvuUKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/LHzWOQAR9JBHKU7fNFrY4pnt/UjBXQYufCNMGIhfzMRDe6i68fTM06A07r2WB3/dPFzN6IRu9ohJPSftxro1peB40s8SzfynJDp6ouh8pFi4AhgtHiYB7uDLYM8lYYexR3KIWDAD3yXtpJZAFLCJKUY8kNOmNDqTuPxx5u5J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AT+Ey2qg; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f01b8738dso4346804e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724147780; x=1724752580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O22wnNYOCBxaZUWUifSw34IZJjKrxoUhdzvzmYoIV68=;
        b=AT+Ey2qgRtb8xnbdAjLfwBz3INyvyo/YEpMJH3UbjmqgZZqU2xtAXODr0HbGRVUAgC
         DoHpc5/zTgIYUxdOC45g10HrbPbmKqRLfG8MCiJl9XZjDY/4i6Xcqp6F5gdAWotbwOyi
         v6QqLEO7HoUPx6nk08XSpqbAAiORzJuUXFlkD9aaKYLfW2QqzTSzX879gj/mktkw4aU1
         i9X3IZStjmany5ABdGxZ8tyAjUgzIO2fQUiFW4PK1aoH2sTR+fyWwO5uK2a6rnp3CPhM
         /1WERKwF9KEs0qfnMr4U4cDtFJqQ5lHgExiO+CXGzO1n/Zqm9b7M5S9EuF1z/mRWJV3/
         5Obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724147780; x=1724752580;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O22wnNYOCBxaZUWUifSw34IZJjKrxoUhdzvzmYoIV68=;
        b=JifOTA2gaCrcvVieirHiavL3v3oDTUjzIAUD9D0PxHybv8uuTh6LL2KG20sOSp838P
         14nOPRlhY5DGuCGReXOd2ZnWJHwDslA5aH/7tcEkYv+P3zV9ldxtlXbCI0cWFiIoX4MD
         Bz2Tjyig3mNvGbbNPnHj3kffnr30cbQEagsv6DKMg8xNt5obmHiGdQkjx1lPv0Ke6Brn
         hRMCr5g7dUgeHcLwHRliluNFWboo4I84sONBJM3m5CE0zvsdjbdjUL769iedDn14qINE
         hT1N/dkAPx9fO40vOGB9WwGSMawUbJNZdXJBHGFVCa8nhFsXkeyxiethtWj5Zo2fnChT
         zlmA==
X-Forwarded-Encrypted: i=1; AJvYcCXe9t7SNKDdYykJ3Jt4dF+KdCRnrnkPwhQPT82hC8CK+d37JAWTUcc8EczuOPJsexZ3peQ6UbZWRd3y7L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZPqmDkR0lerE+4blay9k6yMX8tFj3M2Xf8QTDXg3CmsDmJ6P
	JWgm8WpCw4kN10y9oByGtN+it6vwBM+A2G99PW1Sqzsn3LXLL34LrsxMkOFt/g==
X-Google-Smtp-Source: AGHT+IFrsPT4hsY3MVuzsaum359JeocN124iERr4tvRuSUdtykAH993mPaa7xKBT+WQaa6tnUfu4FA==
X-Received: by 2002:a05:6512:3085:b0:533:809:a970 with SMTP id 2adb3069b0e04-5331c6a20e1mr8788954e87.14.1724147779985;
        Tue, 20 Aug 2024 02:56:19 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c66e2sm739681766b.3.2024.08.20.02.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 02:56:19 -0700 (PDT)
Message-ID: <607602c3-5199-4326-8676-d28a8b42b4b5@suse.com>
Date: Tue, 20 Aug 2024 11:56:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] xen: allow mapping ACPI data using a different
 physical address
To: Juergen Gross <jgross@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-acpi@vger.kernel.org
References: <20240820082012.31316-1-jgross@suse.com>
 <20240820082012.31316-7-jgross@suse.com>
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
In-Reply-To: <20240820082012.31316-7-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.08.2024 10:20, Juergen Gross wrote:
> @@ -838,6 +839,31 @@ void __init xen_do_remap_nonram(void)
>  	pr_info("Remapped %u non-RAM page(s)\n", remapped);
>  }
>  
> +/*
> + * Xen variant of acpi_os_ioremap() taking potentially remapped non-RAM
> + * regions into acount.
> + * Any attempt to map an area crossing a remap boundary will produce a
> + * WARN() splat.
> + */
> +static void __iomem *xen_acpi_os_ioremap(acpi_physical_address phys,
> +					 acpi_size size)
> +{
> +	unsigned int i;
> +	struct nonram_remap *remap = xen_nonram_remap;

const (also in one of the functions in patch 5)?

> +	for (i = 0; i < nr_nonram_remap; i++) {
> +		if (phys + size > remap->maddr &&
> +		    phys < remap->maddr + remap->size) {
> +			WARN_ON(phys < remap->maddr ||
> +				phys + size > remap->maddr + remap->size);
> +			phys = remap->paddr + phys - remap->maddr;
> +			break;
> +		}
> +	}
> +
> +	return x86_acpi_os_ioremap(phys, size);
> +}

At least this, perhaps also what patch 5 adds, likely wants to be limited
to the XEN_DOM0 case? Or else I wonder whether ...

> @@ -850,6 +876,10 @@ void __init xen_add_remap_nonram(phys_addr_t maddr, phys_addr_t paddr,
>  		BUG();
>  	}
>  
> +	/* Switch to the Xen acpi_os_ioremap() variant. */
> +	if (nr_nonram_remap == 0)
> +		acpi_os_ioremap = xen_acpi_os_ioremap;

... this would actually build when XEN_DOM0=n.

I'm actually surprised there's no Dom0-only code section in this file,
where the new code could then simply be inserted.

Jan


Return-Path: <linux-kernel+bounces-535823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D696A477A8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C9516F2C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B237223705;
	Thu, 27 Feb 2025 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KKv+96nF"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DF522256C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644621; cv=none; b=MBYOYOj+Vpc6y4Ge3NkCwysYuPB46hlqSXDRdDN02hsh4MWSwOnVbVEg5fEuivySldX0imXTuZ92XHizAnpl5uJIKEGQsWwiSQPlDlld+YdALF0wPEdSRdAfSZXCDARX51eBwy1m1yTPKdrjitziCcieuvyJRt2N6B3XYVpelqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644621; c=relaxed/simple;
	bh=W9KN5pvX9x9UeQfxZLl+Kx7zYQ6RgmMlCXWT3/BihSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5kAS+CdlcaZwj+daWUMcHbp3f9OBJP8C5W9j1KwIxw9CNuzX+ksxcaV/ExPw/cyf36pYKSb/WLljMl3nA4ZR6wjIdJoVv1abFeuU2BT8URKeqdowxU1eFxGngTJngGnsDj7elxlbEOYn8m13HZW3VP+7ZnTRb0/+EqA6FbKYsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KKv+96nF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f24fc466aso357358f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740644617; x=1741249417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=etFPcrtk9Tgkn8uByeM46xjOYSvuZ71OIx9b3bGqazU=;
        b=KKv+96nF6KDkbykifiOb7UD324A7P/DSR8ZsNPZtXS/y40uf0B5CUaD197pm2gXSgf
         7IJSv/KFDsCvjyjSLlSw2zv43xO05YjUy+oF6HltCehdI1mhA7lLxSXCMQvvCtKlS0F1
         EhjaeDJ0Y+HazepRl4J9lxw5W9l4ctgedYyUt042OHEZ3kLPDGDmM/NTHZfXFc1ccY13
         S4LJlv0O+0It7ENrFP2r5Q07EdCpnqxLp3Vi4C38D0g6L0jJ17VMyw7/sGAnqmMnYHad
         r7M0SGyczi9T8zztVWHkKpJyMAWW9VZuUtEEKX/gm7lUTMjE99/yBZyP6pf/qP1Mamny
         hzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740644617; x=1741249417;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etFPcrtk9Tgkn8uByeM46xjOYSvuZ71OIx9b3bGqazU=;
        b=OHF0mPulrKHPRAZgxWGCCMSs5Woq/I+xVCyDr7hhqoBw1YW6scpGsSFnQN5sPcS8L1
         k+jG+9hxLI3U/YGLSSj6I7tvMWbeQVpV5ZDoG6LKyq0QK4oUemO/iYRmWms4w15t+6kM
         FAQpX6yrqsUDd5v3VK+HTbGhYMOppyPZauGeeDnjJ6RJQLRGxn3XLNo/DpFKfOJH6v3N
         tcyLQtxyLG3DgQXZAH/XvwyXrcCHT6VFBoV57AxeQPPuSwTo1Fet5ENwNpKmHHvSUpcV
         xVCNeM30CY0gbQ9f0EnjQk5IM6XpXcxN3BouU9fmVSHBiW2qFdbBFniFQaLC/ANPLCy8
         tEuw==
X-Forwarded-Encrypted: i=1; AJvYcCX+VBf49SiCIXWMcGMVBxxVZKBkY1d8VDe3nij27GEgxxjTQOOBvfBG6eWamMpymcqhEX/JqjOgb6K/EQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye/a2s892FvKVjogsPxz5beGYm6UkCOXitFdwu3RRnQ9vPwwyl
	efINHQtwpwBY1WM1eRYPWIGYp7TLGbVsoYoUV8lRkD3ZLtIyKwEVWcqtDvdkfQ==
X-Gm-Gg: ASbGncsYKsDZkOD3teh+FF03VT8cIk6Ldhfpsie4lJFIg8PITXiOtr7thArz1e0Jd32
	Sf2ZJNvVwOfSmesrNhtfU38B3SEBR4z9KAAzPRoneIsKyy87yLli5BmEj61Itkcyhrm8OjenPW2
	vq2yGnf4JEkZmcotRsWNyJyAlhth//yLUfJ87JPe9Hpp9E6zv7pHKLd7dTPvWsyOh12fSaDVBTO
	/1ickYTiwn2CsdtKqtqOEt7WwP6Skw9FlbykcdiwYOnZ5Sxt1aiIHlY3rZA1XbyjxvU5p2wb0rm
	APY0kREFnr46pSPH0gmInzR93XGCP7tZj8B9RYEHJ/AgrdTnk7MGzKssN/4OX4h/9JmbyDGToKL
	cV7c82QCa1E0=
X-Google-Smtp-Source: AGHT+IGNO4lSsKzWr9bxAoIjTpTJaMHd6X1/Kf+c9UJluJGrqU3WSg6vtNZXxKPF+NoQckaCet6dJA==
X-Received: by 2002:a5d:6c63:0:b0:38f:2a7f:b6cd with SMTP id ffacd0b85a97d-38f7079a134mr17580534f8f.20.1740644617014;
        Thu, 27 Feb 2025 00:23:37 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710f6sm48457185e9.29.2025.02.27.00.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 00:23:36 -0800 (PST)
Message-ID: <22a46f43-d60c-465d-9ae7-4d84ca9108d4@suse.com>
Date: Thu, 27 Feb 2025 09:23:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/pciback: Make missing GSI non-fatal
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: stable@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jiqian Chen <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20250226200134.29759-1-jason.andryuk@amd.com>
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
In-Reply-To: <20250226200134.29759-1-jason.andryuk@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.02.2025 21:01, Jason Andryuk wrote:
> A PCI may not have a legacy IRQ.  In that case, do not fail assigning

Nit: Missing "device".

> to the pciback stub.  Instead just skip xen_pvh_setup_gsi().
> 
> This will leave psdev->gsi == -1.  In that case, when reading the value
> via IOCTL_PRIVCMD_PCIDEV_GET_GSI, return -ENOENT.  Userspace can used

Nit: "use".

> this to distinquish from other errors.

Nit: "distinguish".

> --- a/drivers/xen/acpi.c
> +++ b/drivers/xen/acpi.c
> @@ -101,7 +101,7 @@ int xen_acpi_get_gsi_info(struct pci_dev *dev,
>  
>  	pin = dev->pin;
>  	if (!pin)
> -		return -EINVAL;
> +		return -ENOENT;
>  
>  	entry = acpi_pci_irq_lookup(dev, pin);
>  	if (entry) {

While I can understand this change, ...

> @@ -116,7 +116,7 @@ int xen_acpi_get_gsi_info(struct pci_dev *dev,
>  		gsi = -1;
>  
>  	if (gsi < 0)
> -		return -EINVAL;
> +		return -ENOENT;
>  
>  	*gsi_out = gsi;
>  	*trigger_out = trigger;

... I'd expect this needs to keep using an error code other than ENOENT.
Aiui this path means the device has a pin-based interrupt, just that it's
not configured correctly. In which case we'd better not allow the device
to be handed to a guest. Unless there's logic in place (somewhere) to
make sure it then would get to see a device without pin-based interrupt.

> --- a/drivers/xen/xen-pciback/pci_stub.c
> +++ b/drivers/xen/xen-pciback/pci_stub.c
> @@ -240,6 +240,9 @@ static int pcistub_get_gsi_from_sbdf(unsigned int sbdf)
>  	if (!psdev)
>  		return -ENODEV;
>  
> +	if (psdev->gsi == -1)
> +		return -ENOENT;

This may, aiui, mean either of the two situations above. They would then
need distinguishing, too, if user space is intended to derive decisions
from the error code it gets.

Jan


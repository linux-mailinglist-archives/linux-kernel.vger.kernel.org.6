Return-Path: <linux-kernel+bounces-360877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B94D99A0DE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7581C22E55
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E767B210C05;
	Fri, 11 Oct 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B/TpGZJq"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E470210C0B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641420; cv=none; b=rq8KumKI8Esg7udE4n6jvsgjT9Eb2y/pLMU8SWpgPyTFnKoLFHzrd9JveJfD7vBE1OyOYMMp10WlrCASaaJY2YygKhvdkFQX5rwDZr7dhjchmUNKDCMVmkDJ21SHXKDBFkW2e5ABR4LOHcQjnSw1savrgyD+RAGw/fQVCp7N18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641420; c=relaxed/simple;
	bh=evcUJmXkSdqJOI3Q5365Mwlj4STLnDJWQgP3ZaZcz2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LW9/zq0XkJUGvw5xZAm/YKzjxUh8Zx2KAc09E6/2Pomq5NoUXN+1OkWS9v65aTuErpnDuLq1+JAzv32N/3R412SrgY/CAJQlyjy0zgliZjeil12XSb5xamaNC+nxbmRCoAaXhfe16TjfPtwmsfx8WFF/0anDmOI6ygcje0Ob1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B/TpGZJq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99422c796eso306027466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728641415; x=1729246215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TOqv6ONAiRgTeJMOg0zqPfHha0JdgC7thaHCYs7T/n0=;
        b=B/TpGZJqd/6tRKnWFJ/e39Is+W0hamgaZaEUYYPP/Tc/S1m1k+fJr0Rb/Uxx2YRKjX
         Sz2Di5xJesVTBsjgtlFZkVDDbDkpJEGlJmNheXknWZ0A+g5S66itkJfhcbasaC5HkWZR
         odgPxqKRrDP0RLD2ue3S6uP47rD41xwZeTK6CJ5wQDNA1Ct2X2aT99pLEDUg3ma6GoKN
         N/vUHwqjAaijTXJam7Zdutj7msjUBsnORdqClKXdadIskWxscnHQnjybtvk2wjRdIW1t
         qkowwZD1Uvn+r5pgxlgsHIc9AjsjVFUeY8TepxKVufeY0lzxavDFyx6t+Qw6obw+INbd
         ALmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728641415; x=1729246215;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOqv6ONAiRgTeJMOg0zqPfHha0JdgC7thaHCYs7T/n0=;
        b=ubyZpqzw7b/dRJXxJlOMJeI4j9Wm0hnDnxNtSRw+6GBhYWRaBTNQoLDnD91vO0kq4Z
         RP6USipCAxX5OlthRg2Xd5HTiq10DTTLRHrElh5PW45DvUZJsXmWcAupTpFOfEZ02qXu
         EIKDBJ3pc1U0HIJ+TnJW0mCIipaNnk10NokoueB9GF/ebaIUs4VK0oP6R1mmYsg9JM7p
         VbOnoZ6o+auVSfsjLKgO7xwONcnDIoGao1DXeZGnDBd4mJar2fdeqveXGSIIvyOwf3np
         fYz56QEg/ERnsROkqIH6Z0JsLP8ro3D8B3vqNMjnsDW5QSeyY2G66DVrWKMvAGmv/T1o
         kIzw==
X-Forwarded-Encrypted: i=1; AJvYcCVVfsQdl14NuFb/PPNs74H4WeyNsIm61BsqigJbm5sfMzsRgun95n5gZYn9jYNnkADebc2vO8xb3LXHqv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPm0Zz6SdPWgesNxytVnI8LsAJ0YFoVVBTiwuHljFiR4g4IF8Y
	RRIGbIkxm12II0AiYp57DvdCtLXF7ODt6D6k14kU7YkGrCZ9LY1PGkCxcPMbVw==
X-Google-Smtp-Source: AGHT+IH19uuQmzJr7Iik9TogV5BfZ36plytAFrb9U72iDLIAaBX50KspcRF2pUYPw7flI4CWA6OqGw==
X-Received: by 2002:a17:907:7b87:b0:a99:4acc:3a0c with SMTP id a640c23a62f3a-a99b95ee687mr191264166b.53.1728641415476;
        Fri, 11 Oct 2024 03:10:15 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f291dsm193846466b.209.2024.10.11.03.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 03:10:15 -0700 (PDT)
Message-ID: <d67285fc-5106-429a-9dd1-747c435282f5@suse.com>
Date: Fri, 11 Oct 2024 12:10:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] xen: Remove dependency between pciback and privcmd
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <20241011034227.1278144-1-Jiqian.Chen@amd.com>
 <318bd8a4-a349-4e7b-8653-6995d5f9f125@suse.com>
 <BL1PR12MB5849EFA99B7F0C55D201738AE7792@BL1PR12MB5849.namprd12.prod.outlook.com>
 <BL1PR12MB584931B86739702086CDFF12E7792@BL1PR12MB5849.namprd12.prod.outlook.com>
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
In-Reply-To: <BL1PR12MB584931B86739702086CDFF12E7792@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.10.2024 11:33, Chen, Jiqian wrote:
> On 2024/10/11 17:20, Chen, Jiqian wrote:
>> On 2024/10/11 16:54, Jan Beulich wrote:
>>> On 11.10.2024 05:42, Jiqian Chen wrote:
>>>> @@ -1757,11 +1756,19 @@ static int __init xen_pcibk_init(void)
>>>>  		bus_register_notifier(&pci_bus_type, &pci_stub_nb);
>>>>  #endif
>>>>  
>>>> +#ifdef CONFIG_XEN_ACPI
>>>> +	xen_acpi_register_get_gsi_func(pcistub_get_gsi_from_sbdf);
>>>> +#endif
>>>> +
>>>>  	return err;
>>>>  }
>>>>  
>>>>  static void __exit xen_pcibk_cleanup(void)
>>>>  {
>>>> +#ifdef CONFIG_XEN_ACPI
>>>> +	xen_acpi_register_get_gsi_func(NULL);
>>>> +#endif
>>>
>>> Just wondering - instead of these two #ifdef-s, ...
>>>
>>>> --- a/include/xen/acpi.h
>>>> +++ b/include/xen/acpi.h
>>>> @@ -91,13 +91,9 @@ static inline int xen_acpi_get_gsi_info(struct pci_dev *dev,
>>>>  }
>>>>  #endif
>>>>  
>>>> -#ifdef CONFIG_XEN_PCI_STUB
>>>> -int pcistub_get_gsi_from_sbdf(unsigned int sbdf);
>>>> -#else
>>>> -static inline int pcistub_get_gsi_from_sbdf(unsigned int sbdf)
>>>> -{
>>>> -	return -1;
>>>> -}
>>>> -#endif
>>>> +typedef int (*get_gsi_from_sbdf_t)(u32 sbdf);
>>>> +
>>>> +void xen_acpi_register_get_gsi_func(get_gsi_from_sbdf_t func);
>>>> +int xen_acpi_get_gsi_from_sbdf(u32 sbdf);
>>>
>>> ... wouldn't a static inline stub (for the !XEN_ACPI case) aid overall readability?
>> I'm not sure if other files do this. But for me, it feels a little strange to use "#ifdef CONFIG_XEN_ACPI #else" in apci.h, like self-containment.
>> And "#include apci.h" in pic_stub.c is also wraped with CONFIG_XEN_ACPI.
> OK, I saw other files also do this.
> If you insist, I will make modifications in the next version.

Well, I'm not a maintainer of this code, so I can't very well insist.

Jan


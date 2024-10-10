Return-Path: <linux-kernel+bounces-358377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0370997E13
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1740D1F26D49
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 07:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EAF1A2540;
	Thu, 10 Oct 2024 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RXk2xC9u"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47299433C9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543719; cv=none; b=BGuDhJDsv2qEQGTKEKvDiN0teXPl395cDC10upc7yWPbYGf7Apiuf6jujgJ7eQblhJEFh1PLJ9ySS+O3ChjcwXvonwm6VyoDUxTbNb+vZpjAy8SW8W/tBLi+qRc94VTd7TQp1XfDN23OXxXkgno4sT5skyhOLtYl5nweRnIp3Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543719; c=relaxed/simple;
	bh=VpvFAPhJp/M1wupE23iYOYNMxGD6SmZw+rhsGW6fNg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZIsiWU8aNgf3LrzBOjjzQEdYD+4Dh/BW5bI4lHxsuFs4X2HI3Y/DwRHj+uV5//I8teRjhUZFP36OB1Y5v6XziQ7Fh58i/parcdkcZ92u2SDuSOzovjZaT4aRjp4pmv9EsWIOfzYfRc9SnLEoTiSQotPp498CqDDnlOTXUJFSfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RXk2xC9u; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c918c067a1so597227a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 00:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728543715; x=1729148515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sZt+XJYSdwYln561BuqB+yeUg38/33FYKTH8R/LAnPQ=;
        b=RXk2xC9uaceVVJkM/VHlSjnhL8nxrRhbW2CwR5ig+QVrRAisV/+MQ5GZBLTn8DsTnY
         cXFWMvfHvTsD8RbljWOhOqDTY4rUGmv28yIceqDRGFPNpRJtwH5D0E+rjNfQMoMfYTve
         abQDxEN5Rs+VLRuenuIloCXdsfzrr8qA4mICHmGJ1PzRTo7xeUx+PuHW6tkG5wUdDaWy
         qv9tBLFnOdXOZMQa+4KxQhoKKbznGRqC8S2zC+HlDp1wCXlUiYJeoZIx0bb2bVuTaOEo
         qI6Jf4vMm4PQOos4DCONLPrZCxA1jh/xN81/p482WHFvdMwhj2hGdgBnTHwgpMJnYqFt
         aWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728543715; x=1729148515;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZt+XJYSdwYln561BuqB+yeUg38/33FYKTH8R/LAnPQ=;
        b=c9vbfvlWpf7A5Cz9jsALzeu8RlpUDCaItu9vSc599Eg/R3o6UmVhaqVclug5ZBTwU1
         U1ayEmXozjEbZhIjmxGv6xQJDfu+QcNrs6P/WRQxp9cQZrCkdT6Q9nQWxHknd/wqG621
         V3cbreHL8gceXvX/1iCF5ZD49BBpNNFlMU+GrrjpaLWHFk4XbSxhk0wKrTBlr/7An1HU
         0fHZ9hbdIquZOsQbF0LXmX3ACyrRSnQJTOjuw/+/kO6MkUUoczFr8S4WlX8o7cm7XYq5
         BmJt85Wswi7HWjduEnM7+TmfdqwZKq8v6Q93VU4KDdvdDy3rNSAIURcjLHNCDjr4lv2y
         XCcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWmqOsNzCQ4V3qc7WEe7noIk9ACpMI7JQKHUBUjUWCPZXotFQNh28DLlzvHfWmXWVzHVWE+k3xnz3Wlc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynUKhDyDJv5PoHf2JOeyLZ2I1d37BnV60Gqx2RUHLoKo9GGTZu
	+/DmcI/guSU6gqROrFMXe3dyesYekgsKySDd7HqeqHbyY4oVE23KBStbs6VC7w==
X-Google-Smtp-Source: AGHT+IFaW38MP0jnIfnVt55M9aG5wz4Bk+QoZFc2vIZ6r2o4BcPZnjYn6x2Qoefq32VwnIcR6ZTwBA==
X-Received: by 2002:a17:907:60d6:b0:a99:4982:da46 with SMTP id a640c23a62f3a-a998d3299a8mr377605666b.63.1728543715487;
        Thu, 10 Oct 2024 00:01:55 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ec549csm44046766b.27.2024.10.10.00.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 00:01:55 -0700 (PDT)
Message-ID: <756dc3d5-48fd-429f-a5eb-6cb8e99dfe6f@suse.com>
Date: Thu, 10 Oct 2024 09:01:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen: Remove config dependency in XEN_PRIVCMD definition
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Cc: Jiqian Chen <Jiqian.Chen@amd.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Marek Marczykowski <marmarek@invisiblethingslab.com>
References: <20241009062014.407310-1-Jiqian.Chen@amd.com>
 <73174eb0-380d-4f95-a2c3-097b86fac8db@suse.com>
 <alpine.DEB.2.22.394.2410091539260.471028@ubuntu-linux-20-04-desktop>
 <8bfaa6cc-2cf1-48e4-828b-e4d356f0b3fc@suse.com>
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
In-Reply-To: <8bfaa6cc-2cf1-48e4-828b-e4d356f0b3fc@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10.10.2024 07:39, Jürgen Groß wrote:
> On 10.10.24 00:46, Stefano Stabellini wrote:
>> On Wed, 9 Oct 2024, Jan Beulich wrote:
>>> On 09.10.2024 08:20, Jiqian Chen wrote:
>>>> Commit 2fae6bb7be32 ("xen/privcmd: Add new syscall to get gsi from dev")
>>>> adds a weak reverse dependency to the config XEN_PRIVCMD definition, its
>>>> purpose is to pass the combination of compilation that CONFIG_XEN_PRIVCMD=y
>>>> and CONFIG_XEN_PCIDEV_BACKEND=m, because in that combination, xen-pciback
>>>> is compiled as a module but xen-privcmd is built-in, so xen-privcmd can't
>>>> find the implementation of pcistub_get_gsi_from_sbdf.
>>>>
>>>> But that dependency causes xen-privcmd can't be loaded on domU, because
>>>> dependent xen-pciback is always not be loaded successfully on domU.
>>>>
>>>> To solve above problem and cover original commit's requirement, just remove
>>>> that dependency, because the code "IS_REACHABLE(CONFIG_XEN_PCIDEV_BACKEND)"
>>>> of original commit is enough to meet the requirement.
>>>>
>>>> Fixes: 2fae6bb7be32 ("xen/privcmd: Add new syscall to get gsi from dev")
>>>> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
>>>
>>> This lacks a Reported-by:.
>>>
>>>> --- a/drivers/xen/Kconfig
>>>> +++ b/drivers/xen/Kconfig
>>>> @@ -261,7 +261,6 @@ config XEN_SCSI_BACKEND
>>>>   config XEN_PRIVCMD
>>>>   	tristate "Xen hypercall passthrough driver"
>>>>   	depends on XEN
>>>> -	imply XEN_PCIDEV_BACKEND
>>>>   	default m
>>>>   	help
>>>>   	  The hypercall passthrough driver allows privileged user programs to
>>>
>>> The report wasn't about a build problem, but a runtime one. Removing the
>>> dependency here doesn't change anything in the dependency of xen-privcmd
>>> on xen-pciback, as the use of pcistub_get_gsi_from_sbdf() continues to
>>> exist.
>>>
>>> Consider the case of XEN_PCIDEV_BACKEND=m and XEN_PRIVCMD=m, which
>>> I guess is what Marek is using in his config. Both drivers are available
>>> in such a configuration, yet loading of xen-privcmd then requires to
>>> load xen-pciback first. And that latter load attempt will fail in a DomU.
>>> The two drivers simply may not have any dependency in either direction.
>>
>> The idea is that there should be no hard dependency on
>> pcistub_get_gsi_from_sbdf(). If it is available, the service will be
>> used, otherwise an error will be reported.
>>
>> The problem is that IS_REACHABLE is a compile-time check. What we need
>> is a runtime check instead. Maybe symbol_get or try_module_get ?
> 
> This is a rather clumsy solution IMO.
> 
> I'm seeing the following solutions:
> 
> 1. Don't fail to to load the pciback driver in a DomU, but only disable
>     any functionality.
> 
> 2. Move the drivers/xen/xen-pciback/pci_stub.c functionality in a module
>     of its own, allowing the privcmd driver to be loaded without needing
>     the rest of pciback.
> 
> 3. Add a hook to e.g. drivers/xen/pci.c instead for calling of
>     pcistub_get_gsi_from_sbdf() directly. pciback could register the real
>     call address. If pciback isn't loaded, the hook can return an error.
>     This would remove the explicit dependency of privcmd on pciback.
> 
> I'd prefer the 3rd variant.

Same here - order of preference backwards in the set presented above.
In the meantime the original change may simply need reverting?

Jan


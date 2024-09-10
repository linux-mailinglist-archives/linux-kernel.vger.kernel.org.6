Return-Path: <linux-kernel+bounces-322708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B80A972C99
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3921C23E84
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1329188002;
	Tue, 10 Sep 2024 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D3Y/iVlY"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD45187876
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958489; cv=none; b=QSmw2qWkSexF51uLXWMWrRzFP5WztbaoTcdgbhzh0xhOd3dJke3+TNyBrD0yO7CbmH5Ab5anOqc5zslN0AYliOZ8xWHvEE54S/E8d4xHr/ZJ30OUjGXJKDO8SpWrSZnrhwuB6e0B7+4nNC5TZvfM5yfRZfDa4At85ch/YWUX51Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958489; c=relaxed/simple;
	bh=WE8oZgdTf32iDM2y3TggefeFmuWQ+lVtqFZodGc2K7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IAPR9hWfS/iObj/ND5I10NEzgs7saNh/7iaUO7d7+HvY7GFEZV0WC7n/aNNx+2Ku1pjAbAsFJR/DSJt8OzIMT+mDTwBFXyakrtD9X7PQjwTIEjvyRDMzyyiMhGrU1PFIl0RlKeOIM91GnBjIUfds0hcw8s8Xk1nNc8NmHecEhLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D3Y/iVlY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c3c30e663fso542023a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725958485; x=1726563285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jK4l7+/psZ/FR8kOwC806XIhHqjPYte0or/yFucIwHo=;
        b=D3Y/iVlYhU35ykaRCN+DQQUtbwWyOm29jm2Rj9KQ2EHXalpgIdTScVyjzLF30M1a7p
         oaXYqqWe23xyJsWjZYLwBBjLjeB4GviVsnZaZzxbGn4tDzq7laMC1YTnSc3QtSV8ccxX
         /5O7+DuPXoLQBHq3yydlHhw5TMNOgmYRuQXeHdWlbIMZ/KIY0ScZow02uJ7kpGKAT38d
         MPE/iXYIXhSI8D6EZQ/QES1ea2oVU5N3tpLKV4TGvNxK6E/C8vJdVfdqKS0YCiOExCc5
         cTzkQxShi6oKL8JBPa1VAwLKOZ83OeH92WPjSOW5wzdeMn8XosCeJl51vQ4asz/sLeRF
         Q3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725958485; x=1726563285;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK4l7+/psZ/FR8kOwC806XIhHqjPYte0or/yFucIwHo=;
        b=f4cOy8JBksV2IqaDYBY8nXFtU1eVWe7wtoGkdiu1r623s7NgVHxvA3kiSKxX4thn6V
         jU0YGPZhcDSTCel2R5cP+VxdFP1mDl0sZfAKjGEs+FjYRTeEy/e85P710Hp7q5PSaId8
         zV++AERtTHK34GzFF0Esm4k/xpn5wq/zLsrNdSy5MplmwBLaxt6vjOgnibOB9+RBTlDX
         iNHvUUS+/eAmMVigtmLtiUBK9pyL4mzMMUGaUdRqt7q/CmCFhCe9/Y7jpvkx7+rHkKbg
         7ySRQmkyGjADdPKBXQsBBdKumHWBSOcGdOeHEJ8sw0P5OySU71mFinUTVihJ1o/cR/CM
         PARw==
X-Forwarded-Encrypted: i=1; AJvYcCUi+PhyQkzLGeqMTJRtlCdYnyBf+vKx39PeBz8h7G8CaaUrVN1vRzzqdme89DNXuOOxri2tNEdtbWEYcB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzimh3/Hbvk5jGJj+qzFhQOOo8h5bPgi5n6/9CTzOJ4sUhi1oFV
	7+fcqzaqRshjcjcT9Ki4cv/TyhhXNCRc9u4Sfl3LpWESPkSzj9QjgKWne4dM6g==
X-Google-Smtp-Source: AGHT+IEEd+ihVCWZBnnt5aAc5uCsA+5tAGLGmtlMkZK7ODw9RHHnUeBRCZIoSldB213kcHZ0uZgnSw==
X-Received: by 2002:a17:906:c156:b0:a8d:555f:eeda with SMTP id a640c23a62f3a-a8ffaab0a09mr5496566b.8.1725958485323;
        Tue, 10 Sep 2024 01:54:45 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d657fesm453354166b.221.2024.09.10.01.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 01:54:45 -0700 (PDT)
Message-ID: <940fc273-4540-4177-9647-ddf37bd7b8af@suse.com>
Date: Tue, 10 Sep 2024 10:54:44 +0200
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
 <607602c3-5199-4326-8676-d28a8b42b4b5@suse.com>
 <b6bb45ab-23bb-458d-a8db-9619f594e8c7@suse.com>
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
In-Reply-To: <b6bb45ab-23bb-458d-a8db-9619f594e8c7@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.09.2024 10:15, Juergen Gross wrote:
> On 20.08.24 11:56, Jan Beulich wrote:
>> On 20.08.2024 10:20, Juergen Gross wrote:
>>> @@ -838,6 +839,31 @@ void __init xen_do_remap_nonram(void)
>>>   	pr_info("Remapped %u non-RAM page(s)\n", remapped);
>>>   }
>>>   
>>> +/*
>>> + * Xen variant of acpi_os_ioremap() taking potentially remapped non-RAM
>>> + * regions into acount.
>>> + * Any attempt to map an area crossing a remap boundary will produce a
>>> + * WARN() splat.
>>> + */
>>> +static void __iomem *xen_acpi_os_ioremap(acpi_physical_address phys,
>>> +					 acpi_size size)
>>> +{
>>> +	unsigned int i;
>>> +	struct nonram_remap *remap = xen_nonram_remap;
>>
>> const (also in one of the functions in patch 5)?
> 
> Yes.
> 
>>
>>> +	for (i = 0; i < nr_nonram_remap; i++) {
>>> +		if (phys + size > remap->maddr &&
>>> +		    phys < remap->maddr + remap->size) {
>>> +			WARN_ON(phys < remap->maddr ||
>>> +				phys + size > remap->maddr + remap->size);
>>> +			phys = remap->paddr + phys - remap->maddr;
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	return x86_acpi_os_ioremap(phys, size);
>>> +}
>>
>> At least this, perhaps also what patch 5 adds, likely wants to be limited
>> to the XEN_DOM0 case? Or else I wonder whether ...
>>
>>> @@ -850,6 +876,10 @@ void __init xen_add_remap_nonram(phys_addr_t maddr, phys_addr_t paddr,
>>>   		BUG();
>>>   	}
>>>   
>>> +	/* Switch to the Xen acpi_os_ioremap() variant. */
>>> +	if (nr_nonram_remap == 0)
>>> +		acpi_os_ioremap = xen_acpi_os_ioremap;
>>
>> ... this would actually build when XEN_DOM0=n.
>>
>> I'm actually surprised there's no Dom0-only code section in this file,
>> where the new code could then simply be inserted.
> 
> I'd rather make this conditional on CONFIG_ACPI.

Oh, sure.

> Depending on how Xen tools will handle a PV-domain with "e820_host=1" this
> code might be important for domUs, too.

Right, if that's a possibility for PV (I thought that was a HVM-only thing,
yet maybe it really is precisely the other way around), then yes, DomU-s
may too need to cope with unexpected overlaps.

Jan


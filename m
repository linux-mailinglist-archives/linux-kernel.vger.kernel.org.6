Return-Path: <linux-kernel+bounces-280668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B56494CD80
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E08D283859
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD403190692;
	Fri,  9 Aug 2024 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="di31CBAo"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA051917F2
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196715; cv=none; b=RE3Uen1i4b5Sa3wm31zmDqPdqzXaEKOMk/r5h5Xcy6ps+5j6oTMAVJkD3lpWrCpFiUDl2pr/XWW9dZWrpu4A6iF83lG9s2RxWkhZhO4qOpuqXS6yK5EomYoaKiYXR/+hMaROW6vXtgFJp+F2dORrzGNs7aMiubirWqc2tyE16Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196715; c=relaxed/simple;
	bh=EOaDU9ZrvO+zFZ0tRj0//IuDM0YhighaUzovEeTesJk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hQdJMdi+ncrrFp6UunvaJMcovFytLsb7uo3QGAPnBKfVTONzY/kl1m8a8C3Dk/jF6vYNzvMOWprjK4B6PmQ36oHLscCC3BjgkAeayYgEb/YoMrXwUBx/cqK9BuMhkhUKGJt2xAB3NPUsl3neXHflCMRNU3nKWweSyewtoko4baw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=di31CBAo; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a9e25008aso227680966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723196711; x=1723801511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bfXHI7YRjtVXLrVhuwcVI4WW/iq2ERr9gXv13LmzL3Q=;
        b=di31CBAoUgfIi2zCYxTYd9kFhetiMmGR02w7ABL4Z57hJwoyegRLttNzfvWuVfljPJ
         u5zPYumU4v+bztq4j16K1pWzASyAfR9ozaNsEJjwxY9bivYihFqJQdUrXOb+MzhUARkr
         LlOMgO6ttH9VKtR8YMrq/wksLiQbC29pWumrUJm3z5PbB1ET29Ih0Rq3pz5H3CXzDRUj
         TKlSyV9AcOV/7+xtttm/sHL0zADBrm9CnS3SMLLxkg2kTfO3hc5qMFvdBYzIysNcrEsd
         YqbiMbl0604CoSDhvQOZLMRGMQ4UlAIGXUQ8M0yM+ZJgvGS/nMCT+dwMN1EqC2346SK0
         LUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723196711; x=1723801511;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfXHI7YRjtVXLrVhuwcVI4WW/iq2ERr9gXv13LmzL3Q=;
        b=pX+Mi7N5DOs2xHhhmhVqfdZGjRI4QPqv1uV8ktUV6OgzKeBuXWSMniyvyCYXA+3myk
         hKRUtN91Cga895nEpqaVu0d2H5Ie4t8Qr+cNgXtjMw+9cy5A4n6WjaXIB1uiVqA1u3y1
         2kZj9Fgyjj8hcberOMxeGq9l0nUrOIuql2Y84tuNtVh0I+sLD3CQxzJVZdKHlFOluFeP
         xV6S5OiQ9Qagjpw/I6TlAZUVNmj0Ujd8dHzQScxns3B4Qpf1hnpziw0y3xzgBw1h0m2x
         j3vkYjnOJPwk+akzDILq7Klh1756SWcAl61kTqVydmMnciyAxjJ3vwacO/5x7K2qDxNZ
         WI6w==
X-Forwarded-Encrypted: i=1; AJvYcCVmZvP0Acb61CSOKnDQhE5MVKfmjlN5NXDOMTwOGAnQPDouSRhht1aMhumCGuva6Yw5c4AoW78FrcQ5gr54O2HsAHFS7DKCLfo3IZDo
X-Gm-Message-State: AOJu0Yw8mhk7fetV2jPqygouRgC725+RyU0RjCWB7BuyJeL7ddmRJGcV
	zDOujHJooS5gOe0kTbj9WVmphzeJ1KDqGLveJsOoIgWG10vi6VtGHeC4NsOXOWJEPYy0J8Snuww
	=
X-Google-Smtp-Source: AGHT+IHXEVmAihnXwyVjAcegGO2zuDmd5+TRNNiO5xOEembNdL9LIMP2KZqkz3FjqAEANanlRGVsqA==
X-Received: by 2002:a17:907:7ea1:b0:a7a:8cfb:6568 with SMTP id a640c23a62f3a-a80aa67340dmr72208466b.57.1723196710628;
        Fri, 09 Aug 2024 02:45:10 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0ca0bsm823132366b.74.2024.08.09.02.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 02:45:10 -0700 (PDT)
Message-ID: <64e0ac51-690d-4c44-85fb-6a0b8415fcb7@suse.com>
Date: Fri, 9 Aug 2024 11:45:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] xen: tolerate ACPI NVS memory overlapping with Xen
 allocated memory
From: Jan Beulich <jbeulich@suse.com>
To: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <20240807104110.18117-1-jgross@suse.com>
 <20240807104110.18117-6-jgross@suse.com>
 <90d67e10-6e35-487e-a9e7-611a0fa3b00b@suse.com>
Content-Language: en-US
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
In-Reply-To: <90d67e10-6e35-487e-a9e7-611a0fa3b00b@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.08.2024 14:05, Jan Beulich wrote:
> On 07.08.2024 12:41, Juergen Gross wrote:
>> In order to minimize required special handling for running as Xen PV
>> dom0, the memory layout is modified to match that of the host. This
>> requires to have only RAM at the locations where Xen allocated memory
>> is living. Unfortunately there seem to be some machines, where ACPI
>> NVS is located at 64 MB, resulting in a conflict with the loaded
>> kernel or the initial page tables built by Xen.
>>
>> As ACPI NVS needs to be accessed by the kernel only for saving and
>> restoring it across suspend operations, it can be relocated in the
>> dom0's memory map by swapping it with unused RAM (this is possible
>> via modification of the dom0 P2M map).
> 
> While the kernel may not (directly) need to access it for other purposes,
> what about AML accessing it? As you can't advertise the movement to ACPI,
> and as non-RAM mappings are carried out by drivers/acpi/osl.c:acpi_map()
> using acpi_os_ioremap(), phys-to-machine translations won't cover for
> that (unless I'm overlooking something, which unfortunately seems like I
> might be).

Thinking some more about this, the above may be pointing in the wrong
direction. If from acpi_os_ioremap() downwards no address translation
(PFN -> MFN) occurred, then what's coming from AML would still be
handled correctly as far as page table entries go. The problem then
might instead be that the mapping would appear to be covering RAM, not
the ACPI NVS region (and there may be checks for that).

Jan


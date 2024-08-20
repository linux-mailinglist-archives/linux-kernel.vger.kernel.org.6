Return-Path: <linux-kernel+bounces-293532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE5C9580FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12478286D58
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9173118A93E;
	Tue, 20 Aug 2024 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DPqW3Rg9"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAD418A930
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724142545; cv=none; b=BRvV6c6CNxzRItOV3x4zuCrozax0XQZbdS36nCBQxiB6ueUR/Gja0c6VxOCRGq4DpDQNY1rf3iv9TjiVTYAGk+Jof90NhY1XiBlX92heSUXvwXERNwvv8U69XzjMBgSh9UiVSq/w5iAfqQv40IebrEFU+bf+WoysUSQDZunTl/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724142545; c=relaxed/simple;
	bh=n8I3vFl1DJYwJdr3S9W/L7zYT0Jg/gdY+fx5Eyx6ZCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPhK6zm9mBHgVkOEpEg1zSCbqQQ4StJjZj/KmRstnpspH3JqJSmZF7GAEKPtfbxBxcLSURPhsdq+/qUvVbYaFniyCxP01Hex/XwhL3oMYxTHR9ShaPogvXqHtFOfkwdARk0J4tGsdiRjfuDBAo9vBgn0zOrruCYL7fmbXQ4muY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DPqW3Rg9; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bf009cf4c0so1843673a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724142542; x=1724747342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pWmTRf+lqqwdFlkN10eJYZT7w32zxJLaePIz0o/Lf70=;
        b=DPqW3Rg9yX6fsy4JZo0YkMAoCEX3OoasR9HfxkoOCSMSsnelGD19D3mUfa4b/tffmm
         NrqUcK/COD0fB3Bqgl+Ny3hpmSTH5abQe4UMgWRBka5vcfwCIPNoQDHsv9NNXRVKw7hE
         YMgf+yAppUAjI/VxIzQqhmu5Sxrg+qDPAqaOBfMs/W0WZvUfelW/UzQxNqYvliBl/e7t
         6AgmHf2FiqLTMsWx1MF01/doJltmuaSOp7O4CN0JZFvdaOm2rPmjzBeCcSSTFYT5/KtA
         EKNVsW9v7eItwLi6HpI/oAaTWX2p8ntrVLwMRwMcsQKciPLUhMFzc2GmZB25HyH7siwF
         ++vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724142542; x=1724747342;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWmTRf+lqqwdFlkN10eJYZT7w32zxJLaePIz0o/Lf70=;
        b=LIyGn77nJLJ7qHLmrUw5+CpEF4EzZNsSYA4lRJ2kQNYBjsazinKrYHICeZiiH7QNbC
         QkvPak8OZj7pHj3pjcAet//0cA0FW5zPtqwOTl4NOkSdHBWH+ftwlI/p+Dr8xw0DNU31
         8p+lH21EbGy+QCXsTrQzG/eV3EmuP59b+q4IFaGvHKtQwxj6lQaz9vuw8/O1kv6JjFWn
         aJNKjpuyXZJRo3fYKpJlREvO+14p17W0BAywWfp+0wo7D74gJh4MA5RxPRPVvW0XHEE/
         oFktI8Cl5dkuhtbNahoiaD4Wd+dhQg7PzRbBp+f0bvCmXWvKhTvWbpLPsKQPSt9a+5dT
         qY3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVi/htWpPiWKBSTrae/b5xU9oX77S6ivrN+hxjDkhgIbfeEcLlQOaswij2zMb/BEW/BFHiBLJuwRLkuwX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWDvm+ITnAzbieZtDPNrJQfllxYbiX4qhm0p/VB/DC1QN/y9SE
	dCG8m+hN+pJJbzgaDpktpTuR/j6NsGdrj50yB1fiykqeq4v22Ne5Hl6lWzKvsw==
X-Google-Smtp-Source: AGHT+IE6Q+yumPSaA4yB4wRaKEuNPBZP7rH5pqH/ZrgNa5ZaBHo+1ykUeQjOd02FSeuoP+so/JiYyg==
X-Received: by 2002:a17:907:3fa6:b0:a7a:ba59:3164 with SMTP id a640c23a62f3a-a8392a160d8mr944638266b.53.1724142542132;
        Tue, 20 Aug 2024 01:29:02 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6760sm728733766b.23.2024.08.20.01.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 01:29:01 -0700 (PDT)
Message-ID: <41837bb1-0251-4250-8f00-23d60cb1d664@suse.com>
Date: Tue, 20 Aug 2024 10:29:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] xen: use correct end address of kernel for
 conflict checking
To: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <20240820082012.31316-1-jgross@suse.com>
 <20240820082012.31316-2-jgross@suse.com>
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
In-Reply-To: <20240820082012.31316-2-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20.08.2024 10:20, Juergen Gross wrote:
> When running as a Xen PV dom0 the kernel is loaded by the hypervisor
> using a different memory map than that of the host. In order to
> minimize the required changes in the kernel, the kernel adapts its
> memory map to that of the host. In order to do that it is checking
> for conflicts of its load address with the host memory map.
> 
> Unfortunately the tested memory range does not include the .brk
> area, which might result in crashes or memory corruption when this
> area does conflict withe the memory map of the host.
> 
> Fix the test by using the _end label instead of __bss_stop.
> 
> Fixes: 808fdb71936c ("xen: check for kernel memory conflicting with memory layout")
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Tested-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>




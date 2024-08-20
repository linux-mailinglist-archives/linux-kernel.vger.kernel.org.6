Return-Path: <linux-kernel+bounces-293659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 771119582D8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287DF282FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AEB18CBED;
	Tue, 20 Aug 2024 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RrfGDBwr"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1F18C926
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146693; cv=none; b=Uu3OFoF1dAZadBQD5uA5iFk81H9wrj4MP/4VGxHb+g6UaSUzILzuvRLaYGARh2kSNpdxjArUDlsuUObbhwEHZnmUdm0N+qWicodN/3Z5fpOvOFrKfwhDDRD8lS3nqnMcovxHdX7TtNJflUSa6eMGFzUCTIfEdOeclGYtFGoDYac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146693; c=relaxed/simple;
	bh=g/KCHK6z1kDGNwkU52iHHTGSfZ3/8WOBnvtQmYa8z28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNRU689fLL5kriU1QeJrEGxT2w/+T3z86HtjaROJFZHgDfq+69/c3KiB6TMZC8T0KmIerZ05XZ4MyB68/oZ25boEcLGTiLK140sGjCQHbrQrHWuVy4v05Zwl92MXJsK4Fj3Vl2LH5fsDZFyE9QkK3HWpeaErplE5gKrMok5hfKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RrfGDBwr; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so907575266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724146690; x=1724751490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+NozY5ZdvAwIajBZmKZXdaHS6vOEqlk/A9b6+fwi6NE=;
        b=RrfGDBwr644GMKIhi54BFR446s+fGIZIcdxKMeL6IPtJMQDfbtMN0/sVHJYycI5TA0
         IQo2Ycpvj2+ceY9AOfg04UzQrpO7rPRhplEyIThC9wOTybxepGmNy4pTDHbzjDdPHOnn
         xCYGjbvO6rDBAqwanF5gGSOMXg1nU1p580pSif9GuB+haejlSaKT9+yVlrSEh5205lsx
         FQcMioAffbnhg0qpsEaydcKCk/53vw84AOF0fMOsZL3hRSTMCQrmjbPp4GsTJsS76KiG
         01SACiToNEXv2cEvZvUSWrA5xn1HijokTFI6eQ2UsuxeQAgpzCawsmY7+2ujnzn88pz8
         SGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146690; x=1724751490;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NozY5ZdvAwIajBZmKZXdaHS6vOEqlk/A9b6+fwi6NE=;
        b=QupQ+TFtJbA88SHloiFxU9KOjc1zUoFaJHmrqFOopsu4zUk6vvkSuOCQA2eG3Gw3Xb
         EoeVMmbxLM5lVox5EBEeqm8+8ppMUqivcQjWAf8zozJU8Mm10sYiQx+waLPYFIwKRcQ/
         nPz8ghYgNXM27h/8SGShwLJHlcrTU2oQ8BtQ+gqyZ4x2JrR13V1FSaqcO1E7rDlaa8Uv
         KoTQXfzM47B+TVCvFmLyu2CHMHFHFRW0fnkw7WjD0ht8gQGUE27s+E2tYuv7nIX97zeI
         AWefwa6sPoNmhBp3kxJ2xw14W2Y2N8L4jW55+tQryWBvinz/QE/XmZ5m0H+B+PIizBWJ
         qxwg==
X-Forwarded-Encrypted: i=1; AJvYcCWXl1BRriISddN+pXMXErEztYaSnSAzOIdpq0ZXJTTbs9PyhuaXhK2i0oTOe2xew3pe+RpEDU93SuJ02Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdUX04GVRDZjQCOMpq8VkuNROXKb2ZcgLH/iioZsejLjweJwyq
	yUTWMrR5oP2YJZNH6USevxOAM5HUmRPxU5xfLvVWkh6qAuEvoH57EOlsjFhMzA==
X-Google-Smtp-Source: AGHT+IEPBH5lFRLcB4lxBgQg9tNKFfBqKQQfsk6wOfQV5ywxbBkGJCylykN/aC4NPHooONPyfH3Fbg==
X-Received: by 2002:a17:907:2d07:b0:a7a:b26d:fb5 with SMTP id a640c23a62f3a-a8643f8115emr239072066b.19.1724146689632;
        Tue, 20 Aug 2024 02:38:09 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838d015asm738899266b.90.2024.08.20.02.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 02:38:09 -0700 (PDT)
Message-ID: <d32735a1-79a9-43c1-b4a6-15ddbc203646@suse.com>
Date: Tue, 20 Aug 2024 11:38:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] xen: add capability to remap non-RAM pages to
 different PFNs
To: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20240820082012.31316-1-jgross@suse.com>
 <20240820082012.31316-6-jgross@suse.com>
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
In-Reply-To: <20240820082012.31316-6-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.08.2024 10:20, Juergen Gross wrote:
> When running as a Xen PV dom0 it can happen that the kernel is being
> loaded to a guest physical address conflicting with the host memory
> map.
> 
> In order to be able to resolve this conflict, add the capability to
> remap non-RAM areas to different guest PFNs. A function to use this
> remapping information for other purposes than doing the remap will be
> added when needed.
> 
> As the number of conflicts should be rather low (currently only
> machines with max. 1 conflict are known), save the remap data in a
> small statically allocated array.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - split off from patch 5 of V1 of the series
> - moved to p2m.c
> ---
>  arch/x86/xen/p2m.c     | 65 ++++++++++++++++++++++++++++++++++++++++++
>  arch/x86/xen/xen-ops.h |  3 ++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
> index 7c735b730acd..bb55e0fe1a04 100644
> --- a/arch/x86/xen/p2m.c
> +++ b/arch/x86/xen/p2m.c
> @@ -80,6 +80,7 @@
>  #include <asm/xen/hypervisor.h>
>  #include <xen/balloon.h>
>  #include <xen/grant_table.h>
> +#include <xen/hvc-console.h>
>  
>  #include "xen-ops.h"
>  
> @@ -792,6 +793,70 @@ int clear_foreign_p2m_mapping(struct gnttab_unmap_grant_ref *unmap_ops,
>  	return ret;
>  }
>  
> +/* Remapped non-RAM areas */
> +#define NR_NONRAM_REMAP 4
> +static struct nonram_remap {
> +	phys_addr_t maddr;
> +	phys_addr_t paddr;
> +	unsigned long size;

size_t?

> +} xen_nonram_remap[NR_NONRAM_REMAP];
> +static unsigned int nr_nonram_remap;

Both __initdata? Or, considering patch 6, at least __ro_after_init?

> +/*
> + * Do the real remapping of non-RAM regions as specified in the
> + * xen_nonram_remap[] array.
> + * In case of an error just crash the system.
> + */
> +void __init xen_do_remap_nonram(void)
> +{
> +	unsigned int i;
> +	unsigned int remapped = 0;
> +	struct nonram_remap *remap = xen_nonram_remap;
> +	unsigned long pfn, mfn, len;
> +
> +	if (!nr_nonram_remap)
> +		return;
> +
> +	for (i = 0; i < nr_nonram_remap; i++) {
> +		pfn = PFN_DOWN(remap->paddr);
> +		mfn = PFN_DOWN(remap->maddr);
> +		for (len = 0; len < remap->size; len += PAGE_SIZE) {
> +			if (!set_phys_to_machine(pfn, mfn)) {
> +				pr_err("Failed to set p2m mapping for pfn=%ld mfn=%ld\n",

I'm not convinced that frame numbers logged in decimal are overly useful.

> +				       pfn, mfn);
> +				BUG();
> +			}
> +
> +			pfn++;
> +			mfn++;
> +			remapped++;
> +		}
> +
> +		remap++;
> +	}
> +
> +	pr_info("Remapped %u non-RAM page(s)\n", remapped);

This message may be useful in a log also when nothing was remapped - maybe
drop the initial if()?

> +}
> +
> +/*
> + * Add a new non-RAM remap entry.
> + * In case of no free entry found, just crash the system.
> + */
> +void __init xen_add_remap_nonram(phys_addr_t maddr, phys_addr_t paddr,
> +				 unsigned long size)
> +{
> +	if (nr_nonram_remap == NR_NONRAM_REMAP) {
> +		xen_raw_console_write("Number of required E820 entry remapping actions exceed maximum value\n");
> +		BUG();
> +	}
> +
> +	xen_nonram_remap[nr_nonram_remap].maddr = maddr;
> +	xen_nonram_remap[nr_nonram_remap].paddr = paddr;
> +	xen_nonram_remap[nr_nonram_remap].size = size;
> +
> +	nr_nonram_remap++;
> +}

You don't enforce any constraints on the addresses / size here. With
this the loop in xen_do_remap_nonram() may terminate too early if non-
page-aligned values were passed into here. Both addresses not having
the same offset-into-page may also end up anomalous. Might be worth
switching to frame numbers / number-of-pages for the tracking struct.

Jan


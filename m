Return-Path: <linux-kernel+bounces-323065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BE497372C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B7F1F2563B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC561E493;
	Tue, 10 Sep 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eGe8xZ7Z"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4714318F2D5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971196; cv=none; b=jlSl9uFwjbZggUwoy5pSkCdCIyVXEzG9YR5t6/cLuzz8ky356RUX3ZrrlzubuaLMuZTqu2xSRnD7s7NAgqnm8vNslKKY40lNLZ5n99d+7NkExJhklcALqqjuxvTWqnMqlyUUGHUBXp7XPrih29v0aKDt5zpvXJEBgIc2dHhmUTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971196; c=relaxed/simple;
	bh=8dqEdYc5Tcfu2v5aNtbPqZZLbqJG9gwASuPjGhRO1qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZlIodX99M1eZVJTi+IXpHjF1NsIpKOm0NfxJTeUlx9Yh6oKv2SvLXu5QByUd1/wESt38ZTT+NLudMQz9TkWI7jX+ZBCpWUybT0uD+jxNVHoodksNm5s6l9Gl5zRarONPF5qrosz8aZBDQSuTsY866lHCh6A0fUSVuq8PHSpUkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eGe8xZ7Z; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53653682246so848584e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725971192; x=1726575992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HLastlZm256bbCZQCjTY97zdqMvYpiAMsKAziBcVGN8=;
        b=eGe8xZ7ZfASjjkzJyf0eD9Mcv+Wy+IQFsy92rYsPDn07DClpxY10dzpr10xvkskkKQ
         q+sq8MIPOquUBfsgQLjGv7Uf0YVGE6hNfDmvRk1u8GiGSsrrCpH84FvVELfP8usphyzW
         lGlVVkWw4P6bL4VfQdiil+8vjfCnrfOVTOISxgSGKRmVPVgFC8JZn+LzsQvIRPF4KF1Q
         iLDIycC1TOIHxJVB4IgXi+Tt0ZozNj9ccJqzGaZ678gzLY1nF/jLrQz2mYD5pLKC2Wlx
         RJ1YTUulWtGJKc8HcNCDBzmRqL3D99SGvWdn57O9jUG194JDyQuP+oAaDJGQpjEldwqH
         D7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725971192; x=1726575992;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLastlZm256bbCZQCjTY97zdqMvYpiAMsKAziBcVGN8=;
        b=s/y8nPoppCKAsNpUgKb16k+wlO8S2cSgE7jUqnDNXhicm4szQvPZxOiBTJ+20BQhGZ
         lRZPNpeZdd9O+re9XYPzVBzNjReumjNDjnsvxzXuKQ2s4rS6AP4sAjmBSKBJpXQNj5ga
         sEe3dV3frykewFtOAzH1SyocPPOQtnbTpugrlR5oXyh1M02PqfOB44BSgoUbIlqbh+6y
         oxrIFwUwk7D6dzw7nauVS0LSPbSSIqLyV/7ku3IbuSQpcrwmfjXHX3lV6um23FazZX37
         biXaJBXD/ToCXD8uw/UnpnjcZRJlf75OfSXaHXMyo49QNLscT3Y9SQb3TVZjLW+klsd0
         7LYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBqef4HX23G81++KbeDksvDb8Taf/QA/tgONzvTFRUGlGs+k43klU8W3S81Nt2yjvuDAievGnUIQzsoJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWfjOeSD8Uxc09OUEllkNREbbaiVg9OobGElQeA5giun8Fr08
	8BY1fDL+G8oIonCkqN8xZ/FWrgB2DJEzwhlW6QzTNHIDDmjTMnIj12ImNQ0IBg==
X-Google-Smtp-Source: AGHT+IFhgTOQxyg9vMrWdF2h+zK+lg3d57CQp2VozcEuS2bWCk9BKBBNyPFX9q8dkzE1YxK8YIsyJg==
X-Received: by 2002:a05:6512:3502:b0:52c:df3d:4e9d with SMTP id 2adb3069b0e04-536587ef33bmr8995012e87.37.1725971192129;
        Tue, 10 Sep 2024 05:26:32 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd4693fsm4236803a12.37.2024.09.10.05.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 05:26:31 -0700 (PDT)
Message-ID: <0c4f3e87-b138-407b-a271-7f86fef255f6@suse.com>
Date: Tue, 10 Sep 2024 14:26:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] xen: add capability to remap non-RAM pages to
 different PFNs
To: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20240910103932.7634-1-jgross@suse.com>
 <20240910103932.7634-6-jgross@suse.com>
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
In-Reply-To: <20240910103932.7634-6-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.09.2024 12:39, Juergen Gross wrote:
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

Reviewed-by: Jan Beulich <jbeulich@suse.com>
with two cosmetic remarks:

> @@ -792,6 +793,70 @@ int clear_foreign_p2m_mapping(struct gnttab_unmap_grant_ref *unmap_ops,
>  	return ret;
>  }
>  
> +/* Remapped non-RAM areas */
> +#define NR_NONRAM_REMAP 4
> +static struct nonram_remap {
> +	phys_addr_t maddr;
> +	phys_addr_t paddr;
> +	size_t size;
> +} xen_nonram_remap[NR_NONRAM_REMAP] __ro_after_init;
> +static unsigned int nr_nonram_remap __ro_after_init;

I take it this is the canonical placement of section attributes in the
kernel? (In Xen I'd ask for the attributes to be moved ahead of the
identifiers being declared.)

> +/*
> + * Do the real remapping of non-RAM regions as specified in the
> + * xen_nonram_remap[] array.
> + * In case of an error just crash the system.
> + */
> +void __init xen_do_remap_nonram(void)
> +{
> +	unsigned int i;
> +	unsigned int remapped = 0;
> +	const struct nonram_remap *remap = xen_nonram_remap;
> +	unsigned long pfn, mfn, end_pfn;
> +
> +	for (i = 0; i < nr_nonram_remap; i++) {
> +		end_pfn = PFN_UP(remap->paddr + remap->size);
> +		pfn = PFN_DOWN(remap->paddr);
> +		mfn = PFN_DOWN(remap->maddr);
> +		while (pfn < end_pfn) {
> +			if (!set_phys_to_machine(pfn, mfn)) {
> +				pr_err("Failed to set p2m mapping for pfn=%lx mfn=%lx\n",
> +				       pfn, mfn);
> +				BUG();

Wouldn't panic() get you both in one operation? Or do you expect the call
trace / register state to be of immediate relevance for analysis?

Jan


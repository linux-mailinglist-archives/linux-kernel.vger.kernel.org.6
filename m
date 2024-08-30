Return-Path: <linux-kernel+bounces-308386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3F1965C46
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0811C234B6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAA216EB7E;
	Fri, 30 Aug 2024 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IwtTP+tE"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB92139597
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008721; cv=none; b=oXlB+DAEQ/V5TiwUuOrjV/bnhS1PArIa8f9IozkZ5ftogXTMN0FCvpKV1MYfcIWh8ewSma5mo989yiHy28CCmYPpsmrbFx2T7hG8fHM1Gfyol03DVKJGPg5okX1u3qran4nwRIhVU1QnvQ+gPJA16jhBy/i+gBm82dJTICs+WUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008721; c=relaxed/simple;
	bh=3Wbtju0u+4fqvsCsLz29fQKY/B3vmJFPmQsW6setUn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5GXglSrZ09EiccXi2JBhl2RmDJSB6EMLH18oK4xIkdtLYFzIbk2Q44Hi83NiOQzrCpyMpoX3J34u/YXoKECudGyKaBLUaqM2Z5W3tFfYDgX1fUTovunFyusV+b29uLH3D5LQXFqRYXx8wqGxoK2RvQaES9kVpdJmp9BydAJ5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IwtTP+tE; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bed83487aeso1414267a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725008718; x=1725613518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYYXpww9BLoecZi7S6vRbZ1I0Y637G0WqXbbhcM+O0w=;
        b=IwtTP+tEKrGFgYiyRaI58j+nDLoHcIOR4CaJv3sSpWzyCwx/BqE+YyDyQwIkwA2n+g
         g2twA025rINersDzMyYVYxvqFB+u+pLWuib8au3bnKAf1Y+B0dFJ/uYom6nEJWGnaHie
         yaHtslMZ1R4eMgmkBnooBOnFftwMMd2x5OZQqmLebqOgocFPWzN00teRKQps9KkN+QZ6
         ebJFtvVxT0sCTFU0k/Ki2LtZFkmHlBbTyIVp0Ce3xdrihqNAmSPcCXh04oI2phipTOP0
         fLu1hgAQ7riQ5uZE4q0dQf88+pCjIKJkjm4JvkbXrzDGkQkbcC1/dDE+fTl/Xdbo0LiL
         ynRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725008718; x=1725613518;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYYXpww9BLoecZi7S6vRbZ1I0Y637G0WqXbbhcM+O0w=;
        b=D2CTLhOQ4gCsAS623u67wjr/WPC+nBIoLrbc0KumTn0meMW8pr51qmQ+hoR8EE+qTI
         fWAXHQpTMIhVIkvM4c6XPMYTS/cGCBl01TbHwEg4Jga/Hp+E2zMTzSFFACXATrl0rBIh
         gsFpUWrHHWI937ZfAwRE2bxA79eGhhW03ggeO8dTFPeoxMi7ZxpYQi1aIj/KZSK6MKki
         gfVIoZU2B3Rfx7X2DI+Kr8sFtXrIFy/3euFojJBbnwZkIaTnMED9Tnw1Gx63OpZ+lfgy
         9JVtO2Xw+ODjPzM/l2foAbiK9ruHVCUlGTsG2S2+9xRseglQBWqRlw2oBMhj7uQrfego
         Z0jg==
X-Forwarded-Encrypted: i=1; AJvYcCU2ih/qqLFqjHzzWtv8+Is+sYFKdKDguk6jIEQjD7wYzfNmdLl0p5ZgG2pjkhpVEW4Ga7eBKqJkOOdsNGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6OlS7n8L1cz8dmQOorwD4eSnmTMlrwV5WKJ9yZ+S49zw9hW8
	VPoggA+NYM9yVIxiaFjJhCyDGC3XsFtKsJmbFuLfy1GmgOXjz8ebCEFc8a4sjrk=
X-Google-Smtp-Source: AGHT+IGHLyc8N9LthDSdx2jpVrMxlnFbSRiGIxGh86NyE2UgEnvDT6yn74MwZAnCKM4+HamW3JBgbA==
X-Received: by 2002:a17:907:6d28:b0:a86:a9a4:69fa with SMTP id a640c23a62f3a-a897fa72317mr476669266b.43.1725008716647;
        Fri, 30 Aug 2024 02:05:16 -0700 (PDT)
Received: from [10.20.4.146] (212-5-158-102.ip.btc-net.bg. [212.5.158.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feacbfsm190685966b.27.2024.08.30.02.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 02:05:16 -0700 (PDT)
Message-ID: <de4e1842-1ca2-44aa-b028-359008b591fd@suse.com>
Date: Fri, 30 Aug 2024 12:05:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] x86/virt/tdx: Prepare to support reading other
 global metadata fields
To: Kai Huang <kai.huang@intel.com>, dave.hansen@intel.com,
 kirill.shutemov@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
 peterz@infradead.org, mingo@redhat.com, hpa@zytor.com,
 dan.j.williams@intel.com, seanjc@google.com, pbonzini@redhat.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 rick.p.edgecombe@intel.com, isaku.yamahata@intel.com, chao.gao@intel.com,
 binbin.wu@linux.intel.com, adrian.hunter@intel.com
References: <cover.1724741926.git.kai.huang@intel.com>
 <0403cdb142b40b9838feeb222eb75a4831f6b46d.1724741926.git.kai.huang@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <0403cdb142b40b9838feeb222eb75a4831f6b46d.1724741926.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27.08.24 г. 10:14 ч., Kai Huang wrote:
> The TDX module provides a set of "global metadata fields".  They report
> things like TDX module version, supported features, and fields related
> to create/run TDX guests and so on.
> 
> For now the kernel only reads "TD Memory Region" (TDMR) related fields
> for module initialization.  There are both immediate needs to read more
> fields for module initialization and near-future needs for other kernel
> components like KVM to run TDX guests.
> will be organized in different structures depending on their meanings.
> 
> For now the kernel only reads TDMR related fields.  The TD_SYSINFO_MAP()
> macro hard-codes the 'struct tdx_sys_info_tdmr' instance name.  To make
> it work with different instances of different structures, extend it to
> take the structure instance name as an argument.
> 
> This also means the current code which uses TD_SYSINFO_MAP() must type
> 'struct tdx_sys_info_tdmr' instance name explicitly for each use.  To
> make the code easier to read, add a wrapper TD_SYSINFO_MAP_TDMR_INFO()
> which hides the instance name.
> 
> TDX also support 8/16/32/64 bits metadata field element sizes.  For now
> all TDMR related fields are 16-bit long thus the kernel only has one
> helper:
> 
>    static int read_sys_metadata_field16(u64 field_id, u16 *val) {}
> 
> Future changes will need to read more metadata fields with different
> element sizes.  To make the code short, extend the helper to take a
> 'void *' buffer and the buffer size so it can work with all element
> sizes.
> 
> Note in this way the helper loses the type safety and the build-time
> check inside the helper cannot work anymore because the compiler cannot
> determine the exact value of the buffer size.
> 
> To resolve those, add a wrapper of the helper which only works with
> u8/u16/u32/u64 directly and do build-time check, where the compiler
> can easily know both the element size (from field ID) and the buffer
> size(using sizeof()), before calling the helper.
> 
> An alternative option is to provide one helper for each element size:
> 
>    static int read_sys_metadata_field8(u64 field_id, u8 *val) {}
>    static int read_sys_metadata_field16(u64 field_id, u16 *val) {}
>    ...
> 
> But this will result in duplicated code given those helpers will look
> exactly the same except for the type of buffer pointer.  It's feasible
> to define a macro for the body of the helper and define one entry for
> each element size to reduce the code, but it is a little bit
> over-engineering.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---
> 
> v2 -> v3:
>   - Rename read_sys_metadata_field() to tdh_sys_rd() so the former can be
>     used as the high level wrapper.  Get rid of "stbuf_" prefix since
>     people don't like it.
>   
>   - Rewrite after removing 'struct field_mapping' and reimplementing
>     TD_SYSINFO_MAP().
>   
> ---
>   arch/x86/virt/vmx/tdx/tdx.c | 45 +++++++++++++++++++++----------------
>   arch/x86/virt/vmx/tdx/tdx.h |  3 ++-
>   2 files changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 7e75c1b10838..1cd9035c783f 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -250,7 +250,7 @@ static int build_tdx_memlist(struct list_head *tmb_list)
>   	return ret;
>   }
>   
> -static int read_sys_metadata_field(u64 field_id, u64 *data)
> +static int tdh_sys_rd(u64 field_id, u64 *data)
>   {
>   	struct tdx_module_args args = {};
>   	int ret;
> @@ -270,43 +270,50 @@ static int read_sys_metadata_field(u64 field_id, u64 *data)
>   	return 0;
>   }
>   
> -static int read_sys_metadata_field16(u64 field_id, u16 *val)
> +static int __read_sys_metadata_field(u64 field_id, void *val, int size)

The type of 'size' should be size_t.

>   {
>   	u64 tmp;
>   	int ret;
>   
> -	BUILD_BUG_ON(MD_FIELD_ID_ELE_SIZE_CODE(field_id) !=
> -			MD_FIELD_ID_ELE_SIZE_16BIT);
> -
> -	ret = read_sys_metadata_field(field_id, &tmp);
> +	ret = tdh_sys_rd(field_id, &tmp);
>   	if (ret)
>   		return ret;
>   
> -	*val = tmp;
> +	memcpy(val, &tmp, size);
>   
>   	return 0;
>   }
>   
> +/* Wrapper to read one global metadata to u8/u16/u32/u64 */
> +#define read_sys_metadata_field(_field_id, _val)					\
> +	({										\
> +		BUILD_BUG_ON(MD_FIELD_ELE_SIZE(_field_id) != sizeof(typeof(*(_val))));	\
> +		__read_sys_metadata_field(_field_id, _val, sizeof(typeof(*(_val))));	\
> +	})
> +
>   /*
> - * Assumes locally defined @ret and @sysinfo_tdmr to convey the error
> - * code and the 'struct tdx_sys_info_tdmr' instance to fill out.
> + * Read one global metadata field to a member of a structure instance,
> + * assuming locally defined @ret to convey the error code.
>    */
> -#define TD_SYSINFO_MAP(_field_id, _member)						\
> -	({										\
> -		if (!ret)								\
> -			ret = read_sys_metadata_field16(MD_FIELD_ID_##_field_id,	\
> -					&sysinfo_tdmr->_member);			\
> +#define TD_SYSINFO_MAP(_field_id, _stbuf, _member)				\
> +	({									\
> +		if (!ret)							\
> +			ret = read_sys_metadata_field(MD_FIELD_ID_##_field_id,	\
> +					&_stbuf->_member);			\
>   	})
>   
>   static int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
>   {
>   	int ret = 0;
>   
> -	TD_SYSINFO_MAP(MAX_TDMRS,	      max_tdmrs);
> -	TD_SYSINFO_MAP(MAX_RESERVED_PER_TDMR, max_reserved_per_tdmr);
> -	TD_SYSINFO_MAP(PAMT_4K_ENTRY_SIZE,    pamt_entry_size[TDX_PS_4K]);
> -	TD_SYSINFO_MAP(PAMT_2M_ENTRY_SIZE,    pamt_entry_size[TDX_PS_2M]);
> -	TD_SYSINFO_MAP(PAMT_1G_ENTRY_SIZE,    pamt_entry_size[TDX_PS_1G]);
> +#define TD_SYSINFO_MAP_TDMR_INFO(_field_id, _member)	\
> +	TD_SYSINFO_MAP(_field_id, sysinfo_tdmr, _member)

nit: I guess its a personal preference but honestly I think the amount 
of macro indirection (3 levels) here is crazy, despite each being rather 
simple. Just use TD_SYSINFO_MAP directly, saving the typing of 
"sysinfo_tdmr" doesn't seem like a big deal.

You can probably take it even a bit further and simply opencode 
read_sys_metadata_field macro inside TD_SYSINFO_MAP and be left with 
just it, no ? No other patch in this series uses read_sys_metadata_field 
stand alone, if anything factoring it out could be deferred until the 
first users gets introduced.

> +
> +	TD_SYSINFO_MAP_TDMR_INFO(MAX_TDMRS,	        max_tdmrs);
> +	TD_SYSINFO_MAP_TDMR_INFO(MAX_RESERVED_PER_TDMR, max_reserved_per_tdmr);
> +	TD_SYSINFO_MAP_TDMR_INFO(PAMT_4K_ENTRY_SIZE,    pamt_entry_size[TDX_PS_4K]);
> +	TD_SYSINFO_MAP_TDMR_INFO(PAMT_2M_ENTRY_SIZE,    pamt_entry_size[TDX_PS_2M]);
> +	TD_SYSINFO_MAP_TDMR_INFO(PAMT_1G_ENTRY_SIZE,    pamt_entry_size[TDX_PS_1G]);
>   
>   	return ret;
>   }
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index 148f9b4d1140..7458f6717873 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -53,7 +53,8 @@
>   #define MD_FIELD_ID_ELE_SIZE_CODE(_field_id)	\
>   		(((_field_id) & GENMASK_ULL(33, 32)) >> 32)
>   
> -#define MD_FIELD_ID_ELE_SIZE_16BIT	1
> +#define MD_FIELD_ELE_SIZE(_field_id)	\

That ELE seems a bit ambiguous, ELEM seems more natural and is in line 
with other macros in the kernel.

> +	(1 << MD_FIELD_ID_ELE_SIZE_CODE(_field_id))
>   
>   struct tdmr_reserved_area {
>   	u64 offset;


Return-Path: <linux-kernel+bounces-219159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 424CB90CAB1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5621F231C4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB3D15CD71;
	Tue, 18 Jun 2024 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JIbUsMz9"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B063E15CD66
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711142; cv=none; b=SX0wY9vu9Gj5BYEwafolJibTKgVFYTKKDK7KngcGD2r/UW7bfPFCYPtMP+2Tofnb4CWd5qwwyA7luhq0MGptq5+/kg3reWdFX1dzkuPU6XFrLuAStQAz1iSUvMhWgb7glaNh9/PYPK64byavcuRXOkMG6uAR0r7/ODufxxsK+lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711142; c=relaxed/simple;
	bh=tYe3DD1fCSMHGzPNpWN6MJvkH+q9PwDNhe1nQN+VMH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ua6AdldHYVMCbyfkCNn0QRk/RbDiXDPxVcAI2kFpuac65gNtWepe9oeX0V14LZ9rN43cqOyy747R0z2fXqy/GzrzDWdGX5fPdEcZv02nXQZqvNNI22K+OG4fyIy4AB8jv0duY4VvaVvpD8hPj6QCEflcAw6THATUp1g4VLxqQkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JIbUsMz9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3620ee2cdf7so357739f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718711139; x=1719315939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LYDxvLQlYGKG+H67tH5VGth33yFnD49SE9fJWyG5TWQ=;
        b=JIbUsMz9YKV810xZikRysFuWU6jHwx/dvWyjGfTvxkBY+FKRhJyf+U21qbWDxyNfbC
         a6Y99nL1BvwN1Rc36wX1JpUiNCP623SYJAc2pE5ACTt/jwgeI9gTHCLGKVLyTORFzeV5
         E08O7t4nYvSUMWH7P3dFt3Ktrw0acfORAQjn2FcEdSmuZE3NUMlrVM1q9qTg19mwRrBc
         hrku79oJMBYB1xBlpAKG+bKraZ4SvkGjeb9YpETgH3J5xOt0kcUpNmaz2njG0kDt6o9Q
         Q8ZQn57AycAwSkGj/Fo+vqw9ePrj/R5ZNzjSxxU1JT2bDplJT3y+12GehUagsXevnGFf
         eloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718711139; x=1719315939;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYDxvLQlYGKG+H67tH5VGth33yFnD49SE9fJWyG5TWQ=;
        b=Zgi+/+7SmEsqdSo4ZnixoYd9i15V1YJv8oxEoSHg5A3luXBOwEYnYD2KOphhPAyvXQ
         sk0KCxs+8aort3zzPzSbuoMzJwKG3ZPs+frPJqRxBApG0xQkZXYEzXjS4F4mqvVqxPQb
         Qgi+1q6wGjMvDuTaBRKFTJfrR92MUroeGdBIVCgVbos0lGH//Ahhcde+j5cuLhh/P3WR
         he2fWHfdvj1Y3mLMEg0HyA7oTQarO0MDnzQYIcCa3T7sawA6Injfve/GpBxmAKKX0I9L
         4hcoBlfe0KsFBCfbrlGpGHtIZ9KWO4VgZ+vsDzMP0+f3YPuNfVLxzzW8JdVpaJVh9Xn6
         3DWg==
X-Forwarded-Encrypted: i=1; AJvYcCVUp1RbgSnzFStOqm7N6udr3xX4NQcExuEZbrMjrkM24kDftMfxSkPXX8jHMzxgJGnY/CP/Qyw0ILYU2QrZ5mAxqP9GrXs5t9TDoqag
X-Gm-Message-State: AOJu0Yxi/r7KmuzJTFzZFWyderMzXkOvhDSSH9QvDiHJUlBigpeyjVYb
	sIjKkK+fvASzmCtozyvx7IM32LPRSDTbUkfDPJplJDpJ2BDWWgQAkA7CoASfV34=
X-Google-Smtp-Source: AGHT+IFWr8Mwu092i/2cJesdM+pm/8E0cF3K/P15rEkIwx6q7O0QTmYvoW47jTNzu5m4wm/boVs8WQ==
X-Received: by 2002:a5d:4e42:0:b0:35f:2c43:8861 with SMTP id ffacd0b85a97d-3607a78112bmr8449439f8f.66.1718711138987;
        Tue, 18 Jun 2024 04:45:38 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3609d95bc02sm2506195f8f.18.2024.06.18.04.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 04:45:38 -0700 (PDT)
Message-ID: <7a9eddb2-2ad1-4aab-8edb-548f05b524ec@suse.com>
Date: Tue, 18 Jun 2024 14:45:37 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] x86/virt/tdx: Abstract reading multiple global
 metadata fields as a helper
To: Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@intel.com, dan.j.williams@intel.com,
 kirill.shutemov@linux.intel.com, rick.p.edgecombe@intel.com,
 peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
 hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 isaku.yamahata@intel.com, binbin.wu@linux.intel.com
References: <cover.1718538552.git.kai.huang@intel.com>
 <dd4ab4f97fc12780e4052f7ece94ceadffafd24d.1718538552.git.kai.huang@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <dd4ab4f97fc12780e4052f7ece94ceadffafd24d.1718538552.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.06.24 г. 15:01 ч., Kai Huang wrote:
> For now the kernel only reads "TD Memory Region" (TDMR) related global
> metadata fields to a 'struct tdx_tdmr_sysinfo' for initializing the TDX
> module.  Future changes will need to read other metadata fields that
> don't make sense to populate to the "struct tdx_tdmr_sysinfo".
> 
> Now the code in get_tdx_tdmr_sysinfo() to read multiple global metadata
> fields is not bound to the 'struct tdx_tdmr_sysinfo', and can support
> reading all metadata element sizes.  Abstract this code as a helper for
> future use.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---
>   arch/x86/virt/vmx/tdx/tdx.c | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 4392e82a9bcb..c68fbaf4aa15 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -304,6 +304,21 @@ struct field_mapping {
>   	  .offset   = offsetof(_struct, _member),		\
>   	  .size	    = sizeof(typeof(((_struct *)0)->_member)) }
>   
> +static int stbuf_read_sysmd_multi(const struct field_mapping *fields,

Rename it to read_system_metadata_fields i.e just use the plural form of 
the single field function. Whatever you choose to rename the singular 
form, just make this function be the plural. But as a general remark - I 
don't see what value the "stbuf" prefix brings. 'sysmd' is also somewhat 
unintuitive. Any of 
read_metadata_fields/read_sys_metadata_fields/read_system_metadata_fields 
seem better.

> +				  int nr_fields, void *stbuf)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < nr_fields; i++) {
> +		ret = stbuf_read_sysmd_field(fields[i].field_id, stbuf,
> +				      fields[i].offset, fields[i].size);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   #define TD_SYSINFO_MAP_TDMR_INFO(_field_id, _member)	\
>   	TD_SYSINFO_MAP(_field_id, struct tdx_tdmr_sysinfo, _member)
>   

<snip>


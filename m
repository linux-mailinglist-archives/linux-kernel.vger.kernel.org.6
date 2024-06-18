Return-Path: <linux-kernel+bounces-219135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E6290CA44
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358D01F239AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB842139D1;
	Tue, 18 Jun 2024 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Isz7OeaE"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EA14D9E9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709787; cv=none; b=a3BQXhqxlFstkajXFf7548r3tqgpdHYl7Fl0WrCBP8jbXzA3jmejF3uYA4r6XnkFFosb49Hprnauzh00pGErOrUJjuE1H7kvnvtGCnQ8379VYtN2QBBT3M44d9gtVgRMJe7XlN01x0inIOcus2czoE5nfoYjEoLUwldYsG30WtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709787; c=relaxed/simple;
	bh=hBpWJYugKdNSKxyYJn3C5KoKYpJ9D3LPCkWwDgEO9/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmydgU1srmgR1h5fhx7oAwrEMt4Z0BaaPHW//Y0zrsqGbhm470An1Y7zSI4D6k/QdwRMd61m6ZMVAFKBTmIZURDLegnxOJEH5RQhkDT/VKvZ5PHpyX1EppPqWc91LYI+lgCjzTp7OHlTfI3un/QwAl6q4obKZ4PLvb1zH3c31uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Isz7OeaE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso55952835e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718709784; x=1719314584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+gOrsYfZ1800/8WN41PXukGPtARa5FK/2D6JnB2So4=;
        b=Isz7OeaEf8tNDtl474xxYZPziImk4+dHoAWNXDDRj1DLTgRNuZd/J/Q3CtxOWQ9T+k
         /CELC+0b8jl8E2eVj6eDw8K9WxMcnLg6fIp1zluGsrpSF51GEDnWeH5oRasU7qG2tPs+
         jSp81zPd1rrS8+EilTuctek0uLgCxHoDjXq9U7LUR89tK12E4j8pwXtkqwE2q5ibgIW+
         sTPLthQT6TWJuNhnDGwaGLWzy9etBPGKHpGfse8vzIhBRCX9sD4nDejW1KqjHDHv6cgq
         S3G/L790Nl5HUd9m22+BKTRNR4tLVbf44q609ZjmWVqOuK8Dk23V7nHfIJRGZyW8CN9o
         izHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718709784; x=1719314584;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+gOrsYfZ1800/8WN41PXukGPtARa5FK/2D6JnB2So4=;
        b=TJsMnA795ybOey2wsaIXRHZP1RGnwSzsQ4RPm5E9HVkhXzL25hbTkhv92CZs1cYqJ3
         MA86QPFy7IYNeRctjXQmD/2XaBE0HBHBjCKCxqT/mV00x9pgy6grI6j/RZ/we7rsD+w8
         PUdS81/04lMRhfkpHWDO3EfwzkWviK8LtE4vK6uJdqEaY2/KdhbBBhJYodfHJkBWkRly
         kGVVTiNoZDQOvozmeodEH+06yfpmmbXkB9wDE39vBfKD0ayQ2mTnianh73/JfegYTVv8
         zqpO1/dMY1wUvB7XNdFv2lqvxerG5vsIfF9byb6ZTSxjb+oUVUx8uKnDbiHXMbUUQ5MJ
         eQkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVivt6p6mHaXoJEhClrv9rrvtJCD0QZd6CQ+Dwpa6Qk9NOzcLb7jzzHlH4QdPrP/D+dQUHUnpP6UgDRdh5eyk7H6obhVpnlCkjDCxzQ
X-Gm-Message-State: AOJu0Yw4DQ+g4HQ4cYhn59zdGFaMvhpYvkj5nCe2TXoKgiGvaJdhlKia
	pO9kPInRbhauWRjSpB1mc03EPa6GL67WdLYK/1msG+JgKi44j/so/DpLAMp5hcQ=
X-Google-Smtp-Source: AGHT+IFbHBOxdj+EyogloHZITbETnHDbNwOzEMhz9fPXZyk1bg960ZHujEj16MMpnU24bHjMrWbEEA==
X-Received: by 2002:a05:600c:4f07:b0:421:7e19:5afa with SMTP id 5b1f17b1804b1-42304844b70mr125884405e9.30.1718709783622;
        Tue, 18 Jun 2024 04:23:03 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7579:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33bdasm188191855e9.8.2024.06.18.04.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 04:23:03 -0700 (PDT)
Message-ID: <6fd59803-252d-4126-91de-e65908fca602@suse.com>
Date: Tue, 18 Jun 2024 14:23:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] x86/virt/tdx: Unbind global metadata read with
 'struct tdx_tdmr_sysinfo'
To: Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@intel.com, dan.j.williams@intel.com,
 kirill.shutemov@linux.intel.com, rick.p.edgecombe@intel.com,
 peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
 hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 isaku.yamahata@intel.com, binbin.wu@linux.intel.com
References: <cover.1718538552.git.kai.huang@intel.com>
 <43c646d35088a0bada9fbbf8b731a7e4a44b22c0.1718538552.git.kai.huang@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <43c646d35088a0bada9fbbf8b731a7e4a44b22c0.1718538552.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.06.24 г. 15:01 ч., Kai Huang wrote:
> The TDX module provides a set of "global metadata fields".  They report
> things like TDX module version, supported features, and fields related
> to create/run TDX guests and so on.
> 
> For now the kernel only reads "TD Memory Region" (TDMR) related global
> metadata fields to a 'struct tdx_tdmr_sysinfo' for initializing the TDX
> module, and the metadata reading code can only work with that structure.
> 
> Future changes will need to read other metadata fields that don't make
> sense to populate to the "struct tdx_tdmr_sysinfo".  It's essential to
> provide a generic metadata read infrastructure which is not bound to any
> specific structure.
> 
> To start providing such infrastructure, unbind the metadata reading code
> with the 'struct tdx_tdmr_sysinfo'.
> 
> Note the kernel has a helper macro, TD_SYSINFO_MAP(), for marshaling the
> metadata into the 'struct tdx_tdmr_sysinfo', and currently the macro
> hardcodes the structure name.  As part of unbinding the metadata reading
> code with 'struct tdx_tdmr_sysinfo', it is extended to accept different
> structures.
> 
> Unfortunately, this will result in the usage of TD_SYSINFO_MAP() for
> populating 'struct tdx_tdmr_sysinfo' to be changed to use the structure
> name explicitly for each structure member and make the code longer.  Add
> a wrapper macro which hides the 'struct tdx_tdmr_sysinfo' internally to
> make the code shorter thus better readability.
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> ---
>   arch/x86/virt/vmx/tdx/tdx.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index fbde24ea3b3e..854312e97eff 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -272,9 +272,9 @@ static int read_sys_metadata_field(u64 field_id, u64 *data)
>   
>   static int read_sys_metadata_field16(u64 field_id,
>   				     int offset,
> -				     struct tdx_tdmr_sysinfo *ts)
> +				     void *stbuf)
>   {
> -	u16 *ts_member = ((void *)ts) + offset;
> +	u16 *st_member = stbuf + offset;

This st_* prefix is completely arbitrary, Just name it "member" since 
this function can be used for any arbitrary member.

>   	u64 tmp;
>   	int ret;
>   

<snip>


Return-Path: <linux-kernel+bounces-301353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486C595EF65
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03DE6286452
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EE713AD32;
	Mon, 26 Aug 2024 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PEZci8xq"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C414F9CF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724670274; cv=none; b=e2tzBXF1LegoBDEezLxnIMQXni3MJdb0xTOVu2JW+mPeAhh/krMOFL4/iHOTd2a2LktZidQ8GZKlDj5PFwaVb55BbXHg97u1tK5By1GSHtY0rveEM4cEStvoGjSquSR0DVsS6epNboRVR81bk2Q4fmQHkyxrhe6KV4MGjReoNY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724670274; c=relaxed/simple;
	bh=qQwuQmq19WaJY2TKw8051kfCZHiwoDZB2S9b1qWk7As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ba54jIwXGlnQeWYVbNy1Ua0oyJQKQVzbCv6ZDzJGou0YK0oOI5hqy+aXfne/304EB1RuyJgjIXxb7uMSbMChKPGwOQg2xcAuIwN99IeV4xjkfJReDn3bhHFWeFu/9blnDtMVA1fTH6+s85kUcngdWn2IlQRc78zCsFzyINWPULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PEZci8xq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428e1915e18so34418425e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724670270; x=1725275070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBUf5QDMv+hVbN1ugf3E0laVvepA0Eshqkxu4Gw5YM0=;
        b=PEZci8xqo5I2MLnHCPmjgoQIAAo3qGuGoGN3N+8QJxGVt5KQhFUERGpZd7sSkdJOce
         IgbO+wXFDuQ5K8aYl75pxWlgg6cnswOFQxrHihNG6xnDGn4pKptIlw6fOQRIOLP+qKEl
         RaJ6fDZK962SvEv+malbpsWZ5AeKY6Ln5I5Ax3Zs2PMLQmwK/u6p8D3cgtqavEC2ulFh
         wp+e/tjV3W16tqPBEn7zcxR42UMXoGLIjbSiFNcp4t/zA9EsfY/0sA3hxnS16fqim74k
         BB9Zv/ywO3mMLsy/Js+S/pnakbJ6MNwKHXji3NsOvfPGg/Xb4NWmverQ47lz/1OktIgG
         hLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724670270; x=1725275070;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBUf5QDMv+hVbN1ugf3E0laVvepA0Eshqkxu4Gw5YM0=;
        b=DH2M+cIBk530U5CzW6AOl/Af8bwcyC6A5uC0MMYIVvrdbe5BI74Oa6eAOS6+Ku1cIt
         L+dQL/NJKDbRC+zkwO0KUpSORYmsYDXZiQ9mkGtfX9PFq1G0a7vY/JtjpZzesnxQvN6o
         peesboKCyw1b+0ExaUPZiX+Z8kWTZ5Sp/nqm0wjH34YTHaOlnr00ix2rfjUsR+SgeGJV
         Tj1+4dUs2YRchDbjZbNc+/AqFOJFb4VTBrqwdMRxhEOUc3aiCIIcpIl88/eTYgNRSwip
         jg+w11mDl+SJbBKV9fIReWJYZa7oHrsyg2nPMOaGLnLrciolzNhppUkKSXZ+93Ck1e9K
         /WmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp39cgpLRyVDzIiq5u49ENHIPozxXhY4zhNOYMD/sCAvx6wdKNSYoxi2qAWEwirhFTVYYyllsK737j928=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4YmD6+Xc7bANP0QHVikZqlB3tN7yw8PsZNv0SHL6VvILJ5rCv
	SQtj3KviPtSnJEjcmLnV9+toJlRcU0KQyKw3YQxhXxkZdtJPFz5DfQeTiEx4htI=
X-Google-Smtp-Source: AGHT+IFjlwzJAG+UaujRUepSwwYiC2cK0519dJmLL8/0p57HqWVGq1Y2q3nJ4NjDjd7xcOtuwkQBYQ==
X-Received: by 2002:a05:600c:47d0:b0:42b:892d:54c0 with SMTP id 5b1f17b1804b1-42b892d54d7mr58161045e9.12.1724670270117;
        Mon, 26 Aug 2024 04:04:30 -0700 (PDT)
Received: from [10.20.4.146] ([212.39.89.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac935211csm134383535e9.47.2024.08.26.04.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 04:04:29 -0700 (PDT)
Message-ID: <b8ed694f-3ab1-453c-b14b-25113defbdb6@suse.com>
Date: Mon, 26 Aug 2024 14:04:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/25] KVM: TDX: Initialize KVM supported capabilities
 when module setup
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com,
 pbonzini@redhat.com, kvm@vger.kernel.org
Cc: kai.huang@intel.com, isaku.yamahata@gmail.com,
 tony.lindgren@linux.intel.com, xiaoyao.li@intel.com,
 linux-kernel@vger.kernel.org
References: <20240812224820.34826-1-rick.p.edgecombe@intel.com>
 <20240812224820.34826-11-rick.p.edgecombe@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240812224820.34826-11-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13.08.24 г. 1:48 ч., Rick Edgecombe wrote:
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> While TDX module reports a set of capabilities/features that it
> supports, what KVM currently supports might be a subset of them.
> E.g., DEBUG and PERFMON are supported by TDX module but currently not
> supported by KVM.
> 
> Introduce a new struct kvm_tdx_caps to store KVM's capabilities of TDX.
> supported_attrs and suppported_xfam are validated against fixed0/1
> values enumerated by TDX module. Configurable CPUID bits derive from TDX
> module plus applying KVM's capabilities (KVM_GET_SUPPORTED_CPUID),
> i.e., mask off the bits that are configurable in the view of TDX module
> but not supported by KVM yet.
> 
> KVM_TDX_CPUID_NO_SUBLEAF is the concept from TDX module, switch it to 0
> and use KVM_CPUID_FLAG_SIGNIFCANT_INDEX, which are the concept of KVM.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> uAPI breakout v1:
>   - Change setup_kvm_tdx_caps() to use the exported 'struct tdx_sysinfo'
>     pointer.
>   - Change how to copy 'kvm_tdx_cpuid_config' since 'struct tdx_sysinfo'
>     doesn't have 'kvm_tdx_cpuid_config'.
>   - Updates for uAPI changes
> ---

<snip>


> +
>   static int tdx_online_cpu(unsigned int cpu)
>   {
>   	unsigned long flags;
> @@ -217,11 +292,16 @@ static int __init __tdx_bringup(void)
>   		goto get_sysinfo_err;
>   	}
>   
> +	r = setup_kvm_tdx_caps();

nit: Since there are other similarly named functions that come later how 
about rename this to init_kvm_tdx_caps, so that it's clear that the 
functions that are executed ones are prefixed with "init_" and those 
that will be executed on every TDV boot up can be named prefixed with 
"setup_"


> +	if (r)
> +		goto get_sysinfo_err;
> +
>   	/*
>   	 * Leave hardware virtualization enabled after TDX is enabled
>   	 * successfully.  TDX CPU hotplug depends on this.
>   	 */
>   	return 0;
> +
>   get_sysinfo_err:
>   	__do_tdx_cleanup();
>   tdx_bringup_err:
> @@ -232,6 +312,7 @@ static int __init __tdx_bringup(void)
>   void tdx_cleanup(void)
>   {
>   	if (enable_tdx) {
> +		free_kvm_tdx_cap();
>   		__do_tdx_cleanup();
>   		kvm_disable_virtualization();
>   	}


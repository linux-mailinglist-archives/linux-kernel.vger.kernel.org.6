Return-Path: <linux-kernel+bounces-308775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5450E96619D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56001F282AB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0529199FC5;
	Fri, 30 Aug 2024 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NBM7DXFQ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3545E1D1312
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020842; cv=none; b=srfpYdReDt9YFMzA/ICV6DmuQaXKni/2HwFEDRia0dEj/NJMc4jKftpLo6rTWhoy1789pTiqj+74Yc29LBpq9iVQDY4Fo5TOIG4oNpcSmCG/0ynLfWrueOX/oTwdCMhJyuqVRN4ge7oQ1pl7BOM+8m+im3ynzDa1vK/0o6P6Brc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020842; c=relaxed/simple;
	bh=ur0JWyShQgoQopaWpJTcRJZt1xbVa2943ENTjGpAUA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uog47MzQNmtXWcSAoAoZC1OOG/sfQ3P0Lt3YN3foKUgma6mGBGH1mMpCAgjM5M0BR+pJuiJGb9XrAFq6pZAtPy4WIZ1ruI5UWbOtUm+NccP8ddK9e9liH8CTlIKbiS9K6zfjrwOrcn8FPCMgdwDLSUiAHnguJTYypwmgbuyM3uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NBM7DXFQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86acbaddb4so211712866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 05:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725020837; x=1725625637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NE74wxGwsCKlZLA7ems9OjPNaFhB2GRCRAeyjJDrX+w=;
        b=NBM7DXFQ7FAn9p5WN8EEnw05TWWPWz74cF0NOTkymuOV+t2oieDmEywtvnTBLtiAu/
         40YlrsBOv2qfBlljLBm5f1pRKt+TySpbYLzgjhyPEuXh2WG+o9qUwypnNkwXB8/RR5Us
         8YivUMUPHtZQbYdp8ACM7xaRx3R0eRSEI4c/7AMb0fE49F2EbBBB1nBGVKnGQKjPNGdk
         EG1ALELVj/GkQuS+lDHdP5iP+WxtKCjzpI1S4Hz4c+MQp6ZrEKwaoQWJRYtY3kGNqNgy
         bz1JEuA10uspqGVayQktX24jL0h0LS6JsBFznzE7esJ+CrJAvawdu5W3NqJ/u/lARi63
         mJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725020837; x=1725625637;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NE74wxGwsCKlZLA7ems9OjPNaFhB2GRCRAeyjJDrX+w=;
        b=faecQ4v8O6ivakSD4DzmBfOCtqupdawtK4mzq9AzocG0AG+bGRAhC3hmW6Wmy057uL
         mmeD1JZY1XN//h3w5owi1AqnWqWNdMKjSsa9gQ8HsYbnuV5vLnLwEZac9SYJ6rXlPZZf
         Yy/4D0VymuhyTdHANl1I0eCx9rzqyiZAJ4Uj0SpJTyph3HLOVH0jME0iob3FRTDVKTwD
         7+PJEY6de7tthu8siJb/mabaJS2o0EKFSUHN+iJa48lstQTOqoeso7Pz4/+/VTLrVjEw
         hq+zjP/vCLqOVTQTF6FYzCzkcktCuI4lhbp/bgJa7FChEJvRF1yY0Kpw48/1fXvqtGOF
         Djgg==
X-Forwarded-Encrypted: i=1; AJvYcCV5uiKQmYuQuDakMb0KmmY82gqGGG3Q4wnQQHDIJe9FcL1pAcpf4nuaLr82t2lnEslunVyMkdqtyfUZmLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh9Ze7ocT22xfNwzCsYsza+PWS1tHugAZ9huAETq/XqEd8YrPd
	GetS1ff4dJHLdlU7jNKrgztgqZqUy8M9nTR/vl0tqUAs4KoeyFLO3ULkpumjJso=
X-Google-Smtp-Source: AGHT+IFwGTUaqlFFzSyRSdCyCgSrH1k0+wuZKY9klMeJF2RQGjHYW71f2iHG128z/xGmHE0xY1TD2A==
X-Received: by 2002:a17:907:6d28:b0:a86:a9a4:69fa with SMTP id a640c23a62f3a-a897fa72317mr519196666b.43.1725020837027;
        Fri, 30 Aug 2024 05:27:17 -0700 (PDT)
Received: from [10.20.4.146] (212-5-158-102.ip.btc-net.bg. [212.5.158.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989035f02sm210237266b.89.2024.08.30.05.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 05:27:16 -0700 (PDT)
Message-ID: <02c06646-a8c9-45ae-9836-33f70aefccea@suse.com>
Date: Fri, 30 Aug 2024 15:27:12 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] x86/virt/tdx: Reduce TDMR's reserved areas by
 using CMRs to find memory holes
To: Kai Huang <kai.huang@intel.com>, dave.hansen@intel.com,
 kirill.shutemov@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
 peterz@infradead.org, mingo@redhat.com, hpa@zytor.com,
 dan.j.williams@intel.com, seanjc@google.com, pbonzini@redhat.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 rick.p.edgecombe@intel.com, isaku.yamahata@intel.com, chao.gao@intel.com,
 binbin.wu@linux.intel.com, adrian.hunter@intel.com
References: <cover.1724741926.git.kai.huang@intel.com>
 <9b55398a1537302fb7135330dba54e79bfabffb1.1724741926.git.kai.huang@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <9b55398a1537302fb7135330dba54e79bfabffb1.1724741926.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27.08.24 г. 10:14 ч., Kai Huang wrote:
<snip>

> [2] Convertible Memory Regions of the problematic platform:
> 
>    virt/tdx: CMR: [0x100000, 0x6f800000)
>    virt/tdx: CMR: [0x100000000, 0x107a000000)
>    virt/tdx: CMR: [0x1080000000, 0x207c000000)
>    virt/tdx: CMR: [0x2080000000, 0x307c000000)
>    virt/tdx: CMR: [0x3080000000, 0x407c000000)
> 
> Fixes: dde3b60d572c9 ("x86/virt/tdx: Designate reserved areas for all TDMRs")
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---

<snpi>

> ---
>   arch/x86/virt/vmx/tdx/tdx.c | 105 ++++++++++++++++++++++++++++++------
>   arch/x86/virt/vmx/tdx/tdx.h |  13 +++++
>   2 files changed, 102 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 0fb673dd43ed..fa335ab1ae92 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -331,6 +331,72 @@ static int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_version
>   	return ret;
>   }
>   
> +/* Update the @sysinfo_cmr->num_cmrs to trim tail empty CMRs */
> +static void trim_empty_tail_cmrs(struct tdx_sys_info_cmr *sysinfo_cmr)
> +{
> +	int i;
> +
> +	for (i = 0; i < sysinfo_cmr->num_cmrs; i++) {
> +		u64 cmr_base = sysinfo_cmr->cmr_base[i];
> +		u64 cmr_size = sysinfo_cmr->cmr_size[i];
> +
> +		if (!cmr_size) {
> +			WARN_ON_ONCE(cmr_base);
> +			break;
> +		}
> +
> +		/* TDX architecture: CMR must be 4KB aligned */
> +		WARN_ON_ONCE(!PAGE_ALIGNED(cmr_base) ||
> +				!PAGE_ALIGNED(cmr_size));
> +	}
> +
> +	sysinfo_cmr->num_cmrs = i;
> +}
> +
> +static int get_tdx_sys_info_cmr(struct tdx_sys_info_cmr *sysinfo_cmr)
> +{
> +	int i, ret = 0;
> +
> +#define TD_SYSINFO_MAP_CMR_INFO(_field_id, _member)	\
> +	TD_SYSINFO_MAP(_field_id, sysinfo_cmr, _member)
> +
> +	TD_SYSINFO_MAP_CMR_INFO(NUM_CMRS, num_cmrs);
> +
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < sysinfo_cmr->num_cmrs; i++) {
> +		TD_SYSINFO_MAP_CMR_INFO(CMR_BASE(i), cmr_base[i]);

Yeah, this is just golden, not only are you going through 3 levels of 
indirection to expand the TD_SYSINFO_MAP but you also top it with one 
final one MD_FIELD_ID_CMR_BASE(i). I'm fine with the CMR_BASE/SIZE 
macros, but the way you introduce 3 levels of macros just to avoid typing

TD_SYSINFO_MAP(foo, bar, zoo)

makes no sense.

<snip>


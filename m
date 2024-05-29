Return-Path: <linux-kernel+bounces-193978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58828D34DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C10528796B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A6A17B513;
	Wed, 29 May 2024 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eTwlKTnT"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B6817B404
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716979678; cv=none; b=Voc0Y1c5KmIfG/JUyRgE6//y858niNaMPS7W+A75eE9sE2N+k4R7g4AgUGpzrDXwQg1p54e1qAL5m6SHG64iiwzFFSB3vvMKH8H/rv3fayqqRPxmfUneQOFWhtWJ6NEUmm+4eDnTjAtqktcfqVVkGVarYDvA37M9WUlQfNqHkcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716979678; c=relaxed/simple;
	bh=biTHQy47V8Q8BKCW+K43IFMoQQNOJzPVouRP8f6euts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TP7LHj9UwEgGLsJxcYtJzJZ3lmasb86wILhSwpAfEmIj2Pt1aD8IXcvmLbwfSfkY0IoXW4F3QQAvFxAME2XdWJ3gXhP8BMS1+OtvNT4MuYLrBVjHl0gF4zoTxKjrAiS3o6JPbdRiW5DisAwWjHJhGGWPDSDq1azq7mpxVAg53e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eTwlKTnT; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ae38957e8so593381e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716979674; x=1717584474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwTOdZ/RFlQPDVFnmQ6lMLq54IcHFFkkOCYIgsO+Y4g=;
        b=eTwlKTnTia03KZBiVV2TXw2T+4hSXhZc69CR5G14gorixmsuZEiVdngfHDfLrj5usU
         jdEFeSgzn8UTGnSchaqSO8Uhvlk42h5YJgWbBpngh27kgUhBG1bh7OLrWw09ZyxjTJ94
         clDTKAxz4tZLEwvmnap+C+QZ2a6QqdgBo788KhkhReTkp3wRwqAOIuYWyMW4+dFPjhzx
         jFDAYJEOllu5LL88G4wy9Dd1sy62tZm38rqFFDTBy315Q8TL79F5vweMLd4RyYfdr4Vl
         3FgNvOQEqbTsPYcb111ehwKZGMfVXq+7+o7g261HvmpYj7dprjIw5RXmxOWySEQ7cxtE
         RqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716979674; x=1717584474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwTOdZ/RFlQPDVFnmQ6lMLq54IcHFFkkOCYIgsO+Y4g=;
        b=Xp+zN31YnhgwT0DCmU7/Zx7NOXnVHqCTIAD/ED/ASQLwpnd78xXDmYfmsn6I9DkSAh
         XmdqQJXW3hQ+t/uyX/GyTMtyOU9rb7kP9LqvqZpMxW+jrsW4dBY1ePksFxWDRZAIkHiP
         fNpAUbJndmex5r98vqWfgWoqBoD5esZBQH8FtP+baoZT8zcPTHfosS5EuCCSVCJ7g2/C
         YOLrlNUBP8VlZKr7SpPCNRV2VHXjmESCt5XmK7nyovD0aerVbxvZZ9AJQtrIxYepZAzz
         +qE0He97s12nlnYgQ2nu6EqAn75fMhKDd+y7B124YPrDRWlK8YOeCxu6sYapFsB3fcsC
         D4iA==
X-Forwarded-Encrypted: i=1; AJvYcCX7+q1KFNNDDK7YzgE4++39ypRbgNtofhLxQPzy9BhyswIdsZlxktIFxP7EfcgEkG8oVNUVjv3BfLc+lBkIhhZFBNsYqLT6MF7ORO4o
X-Gm-Message-State: AOJu0Yzc29IEhdfuKnZ4aYkWoCMqCtKZ/wrxOocb1l/3mQ1wvCi7rX5G
	A9NCHmKJ/A63HvyfJHjOh6IRqo/Al1fUNDPH0tpYlGjvzTiJetqb5xT44frNblY=
X-Google-Smtp-Source: AGHT+IEDNLfaKkjwilk2wM/7emdtUCiwRFG5fAyoCeXjb78CBxx0+9sY3lJLnzVD08O5h0N8LkpWdA==
X-Received: by 2002:a05:6512:4c4:b0:52a:fdcb:6652 with SMTP id 2adb3069b0e04-52afdcb66efmr721019e87.68.1716979673442;
        Wed, 29 May 2024 03:47:53 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:5de0:ca17:8dd8:7313:d6fd? ([2a10:bac0:b000:5de0:ca17:8dd8:7313:d6fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108970b4esm176411645e9.14.2024.05.29.03.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 03:47:53 -0700 (PDT)
Message-ID: <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
Date: Wed, 29 May 2024 13:47:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Baoquan He <bhe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.05.24 г. 12:55 ч., Kirill A. Shutemov wrote:
> From: Borislav Petkov <bp@alien8.de>
> 
> That identity_mapped() functions was loving that "1" label to the point
> of completely confusing its readers.
> 
> Use named labels in each place for clarity.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   arch/x86/kernel/relocate_kernel_64.S | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 56cab1bb25f5..085eef5c3904 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -148,9 +148,10 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>   	 */
>   	movl	$X86_CR4_PAE, %eax
>   	testq	$X86_CR4_LA57, %r13
> -	jz	1f
> +	jz	.Lno_la57
>   	orl	$X86_CR4_LA57, %eax
> -1:
> +.Lno_la57:
> +
>   	movq	%rax, %cr4
>   
>   	jmp 1f

That jmp 1f becomes redundant now as it simply jumps 1 line below.

> @@ -165,9 +166,9 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>   	 * used by kexec. Flush the caches before copying the kernel.
>   	 */
>   	testq	%r12, %r12
> -	jz 1f
> +	jz .Lsme_off
>   	wbinvd
> -1:
> +.Lsme_off:
>   
>   	movq	%rcx, %r11
>   	call	swap_pages
> @@ -187,7 +188,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>   	 */
>   
>   	testq	%r11, %r11
> -	jnz 1f
> +	jnz .Lrelocate
>   	xorl	%eax, %eax
>   	xorl	%ebx, %ebx
>   	xorl    %ecx, %ecx
> @@ -208,7 +209,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>   	ret
>   	int3
>   
> -1:
> +.Lrelocate:
>   	popq	%rdx
>   	leaq	PAGE_SIZE(%r10), %rsp
>   	ANNOTATE_RETPOLINE_SAFE


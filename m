Return-Path: <linux-kernel+bounces-449596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A329F5134
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FC0165841
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8031F75BE;
	Tue, 17 Dec 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuQhqn/M"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13BC1F6676
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453490; cv=none; b=L5kxBLGudig6eBdO5a8FCqhOmIM8ofQFE68Eh9oiQb8lVUI+PSUpkCnM7H+6oThO/7nhiEFB+fOd2FPg19Ev1PYYLz/Q8WLD69KiMDH+AFsRiLqAwAOwCaGeAqNmgk62Bbg+dwdl84/6OTYXXrEe/nryYk4CM8g2H2A8+DkbZUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453490; c=relaxed/simple;
	bh=ZfXv8cNLEnRBxg9wVVM5y+8TMf0SysnxIcST/G9iWRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xt9wPOTQVeMM/aVGrfJN33JqMgT1MyQBuzWrzBI+9Ag1a6ht90sa6rx2pNkONRazpM/nT/xwhCxEi72VztsLWo41oIQW+CKz2YfdQQ9P0NmaWWDxKJ7VyKIRBPmBcl7x1nZiZGQHGV/AweSFcKBTOB6Ye0VNl7RKKqLmozfg3J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuQhqn/M; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa696d3901bso1063080766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734453487; x=1735058287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iH70s4kN1OmYyU7l5ZxBv++8EBPGyuzfTKRoG/MitJE=;
        b=UuQhqn/MOBXxny5qbgX3UUQ875QZ0OrGRy1S6ufY0twzsToeYrQzk6o6Ii6iiZFdYx
         RXOKc1YMTjJuy8wAaVrEw1XG5Y0+qc+quGcciGT7nQcRBU8DdhW5D07Kg34ZBM8rXhm1
         L5Xf01IQUnfgpk9hqz/IIRFuGQ2NG4BqbHEVZHzDb0PcBEDwTIiPzcWpwYeCV0B5bTdi
         6mK/jKfhGIHdhWC3Wn367el2K24DCxRfTP5heu81xefOUFe/hKr7l11oZrlgriB/7a4I
         LcIL4vol3cn+ZoT86mb8zBafyeZeXm0lAsilUCE2P2+bvxKoyFisNVClh565HT5USINu
         3nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734453487; x=1735058287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iH70s4kN1OmYyU7l5ZxBv++8EBPGyuzfTKRoG/MitJE=;
        b=W/TZk6bUvxoCxce0fQyCyEjII+gZWHDKRA5DP5CZtNc0/Vtoi2klby9OxqjoNcqQt5
         arLR24n8Z2xn5rnrTglH/F3ZHmKWHRmsnA5JXO0uosd0NeYtstftDcysw1N1ON+8qImX
         fbicIFxN9o8fLA7YhU7PhKJsrJQUdItfxsgwZszG6hGeBgZ8uoIPZoXqvY+jtFyfaOyh
         CEgs/HFfcSjPe30ELGgIOklhCwzZrv7N2f9atlyvQalcbH9XMF9MraWBknp/ohpyDNLZ
         LHG4tuvA+mvQI+ocUdoHKn8Wom3Y45K8GfMZV8ftIgRPSOTxecG5LDCRE7MDiiJbmqJk
         GnPg==
X-Forwarded-Encrypted: i=1; AJvYcCVgmbEwXOj5aLV9siEA+eY6LD4jT86fe6kR0i9qKiSO1S1M0JM/uZnEk6LUV2nGuwMUG8M+Hnp4z/hVJco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhtHi3mV+jymjRM0A5pOLY6xyzqn5HMhuoi88II5/h+mZt+pFF
	hKDLAH9hHgp8jKI8AByYAi4CXPUlCH3lrOkDjSdVUo8s5xGfjMo+
X-Gm-Gg: ASbGncuVyvjajOC7UbDeGTW2sR401G5VW+iZwzzeOb5guYb7Sy94JbX+9QjVr0jW3qc
	R4zuujOpKD4sP6Cix30mTSMlTLiKYIDMe4nhL8CM+NfHaDJTAPaQNYsxAc+ioQRI3gGTYJhU+9f
	wkudE/2coDNV61tB4ybT7yum+2wO4xmRI8L93eQJiSUj1UoTNLWFZvLNWbmcBYwm6VTa+HCum2b
	tVKeURZbGM1LQ5D7h098A+fWQD7ai+eM3/yrIQrpF6bjGbFC9cn/rYHtQ==
X-Google-Smtp-Source: AGHT+IFdOTWlQ3XGT9Bbtyc5hUf6TLwfRJLJZcM8KJ/JAayRtZbKneHKECG4frLOlCSEzCF6vLj9aw==
X-Received: by 2002:a17:906:dc92:b0:aab:736c:558 with SMTP id a640c23a62f3a-aab77ebcacdmr2066488266b.55.1734453486800;
        Tue, 17 Dec 2024 08:38:06 -0800 (PST)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963595ffsm463142266b.94.2024.12.17.08.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 08:38:06 -0800 (PST)
Message-ID: <05bde41f-9f2a-18e9-05ef-c5b29a66caf8@gmail.com>
Date: Tue, 17 Dec 2024 17:38:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/9] x86/kexec: Ensure preserve_context flag is set on
 return to kernel
To: David Woodhouse <dwmw2@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Yuntao Wang <ytcoode@gmail.com>, David Kaplan <david.kaplan@amd.com>,
 Tao Liu <ltao@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>,
 Wei Yang <richard.weiyang@gmail.com>, Rong Xu <xur@google.com>,
 =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas.weissschuh@linutronix.de>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de, nathan@kernel.org
References: <20241216233704.3208607-1-dwmw2@infradead.org>
 <20241216233704.3208607-3-dwmw2@infradead.org>
Content-Language: en-US
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20241216233704.3208607-3-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17. 12. 24 00:24, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The swap_pages function will only actually *swap*, as its name implies,
> if the preserve_context flag in the %r11 register is non-zero. On the
> way back from a ::preserve_context kexec, ensure that the %r11 register
> is non-zero so that the pages get swapped back.
> 
> Fixes: 9e5683e2d0b5 ("x86/kexec: Only swap pages for ::preserve_context mode")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   arch/x86/kernel/relocate_kernel_64.S | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 9bd601dd8659..1a52e4339c1d 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -220,6 +220,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>   	movq	kexec_pa_table_page(%rip), %rax
>   	movq	%rax, %cr3
>   	lea	PAGE_SIZE(%r8), %rsp
> +	movq	$1, %r11	/* Ensure preserve_context flag is set */

You can save a byte here by using "movl $1, %r11d".

>   	call	swap_pages
>   	movq	kexec_va_control_page(%rip), %rax
>   	addq	$(virtual_mapped - relocate_kernel), %rax

Uros.


Return-Path: <linux-kernel+bounces-541206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 220B9A4B9F1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E991622DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6730E1F17EB;
	Mon,  3 Mar 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LY7nTfAJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275801F1508
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991931; cv=none; b=SHMmhV1lJzDXEltnlfZijRN7XTEARJpeU2bc58davYz2HYjFZRDm5UrHGylA2dGUJQyqPVXgE4QxryuN3Wl+ZlRxiyTQumpky1SxD2o1ua6iTIP8eHq/TO2t+XcTi/OW54GXg4urIbNIAdpPuSYhvLJWmWNw8tcbQ1diRAHJkCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991931; c=relaxed/simple;
	bh=ADaSFdz0OaQQDH4JkFJQ/We+kOUWVf10zyDiFzjjGag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3+44pHkDT8KJjdQrUFaMDNOJEei9bJT2xJSZVgmJoTfX5VD+9D0E2V3lAQ3G/fAHr5uUTH3uUgq3U0P5L6v7WdpDAH5bNB/F9UUG/6GEVHeATGQRXhhxZzzrmUd79FSWdHqB/FMA+2gnhNzynP6IOICCMdOiCB0Wh08NjUyIVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LY7nTfAJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740991929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AD0BhRUSKUKI9Ce/AzRts0lu/YIF74G3wU8/3/wY5qk=;
	b=LY7nTfAJdPKpywQsTebzvcp8vf5vGssVWnv36aKNmt0aqGokmee3aXcoW36McPZ2A1qKNV
	7n6P9k7Pt8VQqd3TOQkMVZPEPGoZ9/qPZ2WasPAvUR9JPqx/+64O8Ye+znlPaNJWA6Uibl
	RJ2Zz0Vf/+8b+SxFy18DB6AGonJb6ZA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-CJ4rv2EUMd64ITZbRNj-IA-1; Mon, 03 Mar 2025 03:52:06 -0500
X-MC-Unique: CJ4rv2EUMd64ITZbRNj-IA-1
X-Mimecast-MFC-AGG-ID: CJ4rv2EUMd64ITZbRNj-IA_1740991926
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390e27150dbso3880646f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991925; x=1741596725;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AD0BhRUSKUKI9Ce/AzRts0lu/YIF74G3wU8/3/wY5qk=;
        b=O94hDcUZ69wek9J2Lzv51qqRz4UUgC7zaMePZ3G4g08r+3gDkZdTlpV2lZqQZGVO/v
         VXCLvGoLvcT8S2eRnLHinUgAj6y7LWE7NO1wV9iKHrNntAaoWrHofKtRAFJrIJiz8v1B
         9y39zrlZaP2gsFAJ0rwsdO58BfZG9KQ/d/SMcBK6jd79Er2ivRbsYbg2c+qr8pTB8UfZ
         YsKLGcmB9ECZKlr3ScPAT9LyjGWJ+zaznCX8gCc+RERRS3pFYuIVUC47pXkzIRr7389C
         joJ2SLwobQsySDLGG7NXA51+AK/LbEnDL3ZdNr8p4i7PnmewoSEZshpyptpsWvsOKV1T
         s2Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVEV1ZivAW36Y7H2jRFIlWEfVO6JRaI4GU1jpec+kP6B88xsZEO5JEXDCHgbMJJnKBOc+vBUlkB1LLqGdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywIfcYMd25Xp0v1D+2uNnJNml+trByne4PcvM9I9Rs8p8ajV6e
	NZEStflaDhl7Iug3waP7lBD0s6vfwp6cYWJ/ME+O2jTZHe4av9qdcov1/gwcQa8MMTlG1idCgW8
	QsB+v14NQYlgizvvnd0QXosYxfW/qP3krNJ+O4vsqKfMHDcmXICTo6QM9CzOZnA==
X-Gm-Gg: ASbGnctBbIsfQrmUTrXv81GSMsMD3IIueRK/MBQIi73joIIBT2/oOLroKzR9wfKIAf3
	pj5S/POghL2SaijuNhTK3HUTEtXF8YsGc6qOxkYi8yMGVX1R6cF95exNciRm57jpLCL43S/mMsT
	RImt8YM4IdeZypmbeFuUEgbILGD9W1M1AYmH5yzk4Vv3VNpYx8oR+pbavPtI8nFsV6tneV9OuXz
	WHvifYqMsL7k+RNaLstR+Ay/9lQPh55y7eGLr6bTLW4bE6hHNeB3rO85uSajo2jIUY4bY0pGYfE
	JOdCorLEw9GrAEOUH2IAD0bhHWd+FuCchi94Cu6dNpjv6lw0K1AbxH8clyuHvJEYyAP+9p1Diak
	UlDsQUEJ/wVEMcugMsDXxfM+bveuGbPWE9VEHn/xFHOk=
X-Received: by 2002:a5d:6d89:0:b0:390:f88c:a689 with SMTP id ffacd0b85a97d-390f88cadabmr5755538f8f.47.1740991925672;
        Mon, 03 Mar 2025 00:52:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3sqppN55tl5C45qFk6psMYLYRvi/O7tktf2gORA/1QEyfox9eLasRdl1uBOhQIOjNr4hTpA==
X-Received: by 2002:a5d:6d89:0:b0:390:f88c:a689 with SMTP id ffacd0b85a97d-390f88cadabmr5755517f8f.47.1740991925267;
        Mon, 03 Mar 2025 00:52:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e13fsm13623429f8f.100.2025.03.03.00.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:52:04 -0800 (PST)
Message-ID: <0db13472-d056-4e41-a42c-f4ca60483176@redhat.com>
Date: Mon, 3 Mar 2025 09:52:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] sparc/mm: Avoid calling
 arch_enter/leave_lazy_mmu() in set_ptes
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20250302145555.3236789-1-ryan.roberts@arm.com>
 <20250302145555.3236789-4-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250302145555.3236789-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.03.25 15:55, Ryan Roberts wrote:
> With commit 1a10a44dfc1d ("sparc64: implement the new page table range
> API") set_ptes was added to the sparc architecture. The implementation
> included calling arch_enter/leave_lazy_mmu() calls.
> 
> The patch removes the usage of arch_enter/leave_lazy_mmu() since this
> implies nesting of lazy mmu regions which is not supported. Without this
> fix, lazy mmu mode is effectively disabled because we exit the mode
> after the first set_ptes:
> 
> remap_pte_range()
>    -> arch_enter_lazy_mmu()
>    -> set_ptes()
>        -> arch_enter_lazy_mmu()
>        -> arch_leave_lazy_mmu()
>    -> arch_leave_lazy_mmu()
> 
> Powerpc suffered the same problem and fixed it in a corresponding way
> with commit 47b8def9358c ("powerpc/mm: Avoid calling
> arch_enter/leave_lazy_mmu() in set_ptes").
> 
> Fixes: 1a10a44dfc1d ("sparc64: implement the new page table range API")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   arch/sparc/include/asm/pgtable_64.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 2b7f358762c1..dc28f2c4eee3 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -936,7 +936,6 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>   static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>   		pte_t *ptep, pte_t pte, unsigned int nr)
>   {
> -	arch_enter_lazy_mmu_mode();
>   	for (;;) {
>   		__set_pte_at(mm, addr, ptep, pte, 0);
>   		if (--nr == 0)
> @@ -945,7 +944,6 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>   		pte_val(pte) += PAGE_SIZE;
>   		addr += PAGE_SIZE;
>   	}
> -	arch_leave_lazy_mmu_mode();
>   }
>   #define set_ptes set_ptes
>   

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



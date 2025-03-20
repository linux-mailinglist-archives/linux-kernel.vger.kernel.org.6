Return-Path: <linux-kernel+bounces-570374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EECA6AF8A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AED169A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC31229B02;
	Thu, 20 Mar 2025 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jh1+sd/H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7881BD01D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742504597; cv=none; b=i3G3RpYhdmLobPFPSTRSTTLh/g1L1+mpGKuOyN3tk/X7vi0oic6m89FoJhvH43vHA8iDkosCBHPlF7vLNnSsnULUG6RKXdxZPLJSdsLXn7MzgWIa40K9MAcK/yMDkcJdq7qmYc6uSCI5D7jiylh+0SliE5Qdw7l/PqtWP3aqA2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742504597; c=relaxed/simple;
	bh=MRDYTMmZQWKKmt6ViRWOob79Ubt8oXe6qNpysUH/jHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABsxdcCVBOoewZo/CnC2X1LD4xFq68subKJMtwwox04/N32TpZsantzgzGkHZ6JXSPJTxx9ENQp2c6ewWM+9ht+AZ1vhgnxBIVL+FSSvCznHTHgFwfad3S4K1l41YTRfCmFQLS0LJMP9vZya6wzLfiuMsgqVU4n6ikrxWwFIuRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jh1+sd/H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742504593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9cWHc7K+Srf/xWlU/uXyGYlcpAE8jDtkMRoLJ801OI=;
	b=Jh1+sd/H+z94X0xORiH8qPiAvqqQyYuymvebSMpQs7j3wI1j8FGwzWaIdZDB2ITXWzVN0k
	LxLUoIA7+MoBEuAWvlVzj4JxlH3MEYRiXxYT9NpYCK6pV9MSqpNjznqSOj79zisLn1xT9s
	jjJJMjLeDPF3qa9k31KjQPm/0A3Fj/I=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-GQm37cvnMDSRxpCr_UKeuQ-1; Thu, 20 Mar 2025 17:03:11 -0400
X-MC-Unique: GQm37cvnMDSRxpCr_UKeuQ-1
X-Mimecast-MFC-AGG-ID: GQm37cvnMDSRxpCr_UKeuQ_1742504591
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d060cfe752so12656235ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742504590; x=1743109390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9cWHc7K+Srf/xWlU/uXyGYlcpAE8jDtkMRoLJ801OI=;
        b=nd8v5/OIt2NPIABGvSyAP7vRk+6aTbyt80MTWVCT07fjiW/ORwzrY8OEpIYbSV57Ah
         onA4wbMUG80BBvikGrCaDtCO8ZJDYm6JonS58zfzTXRJwXRAC65e8P2QiK86kc14gFNI
         fx/qMbakmaOdDwjj+CDBA2U8CMQ16a04M57Jh4BCPh6HXPod6ehwyvJm/MfG+DmpWn9z
         sfnPkmZ84yfaz07p7UJ3AYggE32lfn8L2/iUaUtko1Z3I57Mx1pYJJkrlXxGj0Ldykn9
         xCI5RntLfs1/qSZTth1GJiE/BGYfmHHytIU+quJP4TpYth8kuKVS8llTbYVwsA0a2rzK
         p5aA==
X-Forwarded-Encrypted: i=1; AJvYcCU+9FYGdgRfEDdTMPzyaRTvSG6krRm3873GtkvIJzYW2Zlu0NiPKGSpcSJZSX3MuwjXuLGyK+NMMZZp3ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLR4hh2cl4GQ9mTeMkbZU93uMMPp01y3m1hvICeQRXsPGDact
	oH+slHSugVbknQtdY5tna9g3cVh3Qe3Rb0PkskQruL5+3Q5VMw11UpGzifIjosZw1afxTD1pL+V
	YcDx1zRK06JcGF327PH1fgWuAA4le7PM+ufk1RsVlEwl84EL913eVWhKRP7i7OTV7nGYV1A==
X-Gm-Gg: ASbGncsNYOg35TBBJ3CX3d7XxGCdbIsUC5xFOU65+V5Sl1pgA3hCLAClpwElxCkRDTV
	4J3OCZZIzlzAGfcdfySiY0u3KOGKgWSzrxDKYpTIGOykK528bIi6eihVwmN+mzNNCvJelNjMhjI
	FyI82A9GgRGfQGFvZCMkdKSKtLsQjOTRlZu/lDyt7aqnZegUHPnnk+PpULsNpuE1iv++Qh1rVvm
	UdqtGo9E3U8gQc8r+7tPq6PL6N1FjBd2AYrkRVBUCMOSqnjw5vfTvqUosKyurMID8VEVxlEq96n
	/jqKKe7NZ+fxriHj
X-Received: by 2002:a05:6e02:3a0c:b0:3d4:6f37:372c with SMTP id e9e14a558f8ab-3d5960e2419mr11346075ab.7.1742504589883;
        Thu, 20 Mar 2025 14:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnzVigKPBA5Q69oU5Iypl8N02NSBBlztIoOjGF6V6vtIJyPBcKMGbE54MAjDKZEk1qejJTbQ==
X-Received: by 2002:a05:6e02:3a0c:b0:3d4:6f37:372c with SMTP id e9e14a558f8ab-3d5960e2419mr11345785ab.7.1742504589527;
        Thu, 20 Mar 2025 14:03:09 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdb3bcdsm104582173.3.2025.03.20.14.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 14:03:08 -0700 (PDT)
Message-ID: <73969634-a6f6-4dbb-bc30-801a5c4500cf@redhat.com>
Date: Thu, 20 Mar 2025 17:03:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/arm64: Drop dead code for pud special bit handling
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Keith Busch <kbusch@kernel.org>
References: <20250320183405.12659-1-peterx@redhat.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250320183405.12659-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Peter,

Thanks for the cc, as I have the original commit in a recent, proposed backport that now needs an edit...
or, since harmless, maybe this patch to additionally backport, once committed. :-)

On 3/20/25 2:34 PM, Peter Xu wrote:
> Keith Busch observed some incorrect macros defined in arm64 code [1].
> 
> It turns out the two lines should never be needed and won't be exposed to
> anyone, because aarch64 doesn't select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD,
> hence ARCH_SUPPORTS_PUD_PFNMAP is always N.  The only archs that support
> THP PUDs so far are x86 and powerpc.
> 
> Instead of fixing the lines (with no way to test it..), remove the two
> lines that are in reality dead code, to avoid confusing readers.
> 
> Fixes tag is attached to reflect where the wrong macros were introduced,
> but explicitly not copying stable, because there's no real issue to be
> fixed.  So it's only about removing the dead code so far.
> 
> [1] https://lore.kernel.org/all/Z9tDjOk-JdV_fCY4@kbusch-mbp.dhcp.thefacebook.com/#t
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Donald Dutile <ddutile@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Fixes: 3e509c9b03f9 ("mm/arm64: support large pfn mappings")
> Reported-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   arch/arm64/include/asm/pgtable.h | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 0b2a2ad1b9e8..15211f74b035 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -620,11 +620,6 @@ static inline pmd_t pmd_mkspecial(pmd_t pmd)
>   #define pud_pfn(pud)		((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
>   #define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
>   
> -#ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
> -#define pud_special(pte)	pte_special(pud_pte(pud))
> -#define pud_mkspecial(pte)	pte_pud(pte_mkspecial(pud_pte(pud)))
> -#endif
> -
>   #define pmd_pgprot pmd_pgprot
>   static inline pgprot_t pmd_pgprot(pmd_t pmd)
>   {

Reviewed-by: Donald Dutile <ddutile@redhat.com>



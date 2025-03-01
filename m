Return-Path: <linux-kernel+bounces-539731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A54BAA4A7E1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDE1189B7AA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AA4158535;
	Sat,  1 Mar 2025 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fM4PWUSn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F7022066
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795204; cv=none; b=EMZ/ikjDHoviio/tpbAcRLuYGoRYrkiz9f0iVVJn0+Wrr0tyFKZmTiRyYthscQHMrdnBcGV10IMs33CWsPx4G0qyyS99JoiOx3i+FJID6ae4seTs9NfdajezCw3yAQCPuZu6LRrMyPA00rlUizZm97GMpcH+Z1Lu7OYyNmMDoOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795204; c=relaxed/simple;
	bh=T3w0SzYjhvJxk6k4bPntpWstEuXmDTnYB++0GwpZuVY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=amH85FQf8AHIpRGXwP9rCdTm0iZvEITNiBmLGzfYJEIhc/lhyFcTQLmlmRH5Pxz+1H677ETDoO7yxDmLgswv6/2snZx1cETOGfixGDdRlp4T2N2OdSu1/1jw1DVhkmUbwB3bWrgZ6pXKbiBoeNFiK0xeDqOS/3pFacdvt7UJKvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fM4PWUSn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740795201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23HNObBRF7Awkr12Tspnod8eVeUfyWHo9QdOpe43DIM=;
	b=fM4PWUSnsPSlUZt0cAf5MUDV7OSVqhIADtcEg8MTUrUMNpx8x5g5PwNcLhsowSsx7ZvRSF
	kJSx5sz7vvFn8vjnskHJ1suvrKNiw76CYwVE/Ru+FX07/yrvdIfImXtyZBnN1Vu4vZrGCR
	04TRoQOjmrDv9HTMInp+UEOyvO90VmE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-S6xk2nuzMhiLSLcT9k1FuA-1; Fri, 28 Feb 2025 21:13:19 -0500
X-MC-Unique: S6xk2nuzMhiLSLcT9k1FuA-1
X-Mimecast-MFC-AGG-ID: S6xk2nuzMhiLSLcT9k1FuA_1740795199
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e66249f058so92183166d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740795199; x=1741399999;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23HNObBRF7Awkr12Tspnod8eVeUfyWHo9QdOpe43DIM=;
        b=MhZNBP7PK7sd8rSYuIQO3pCLMlKiPkWN8EPeIzsgKohUUH2QiIoLeiYXh6vFtbv0Sa
         /ZH98HMHMyRafRyXPmeELHM9VVCliiVrAQIqkrBZGgSDgwHx2llgNLTgV+DQptdSuMao
         URLJv2UGeCbGEeUlT1EB1MrwQeEm8Ggf2QOEeJvqafIgP+YsoZKVYrcEyQGdw4WLLQFk
         rhLi0Z9WW1pXrBv0fr8rwQqj592qmRmYIAMLy8pMl08PoR3Ggzi7evT/89h6cHnopDT1
         9EgsyvTm72duVpgaE4X/0qoMOIfmy9P6n0HP3/91Gyp+F4APd8fClWgQWDmOKoz0U6j+
         aTww==
X-Forwarded-Encrypted: i=1; AJvYcCUpJvgPrblbQFfy+DPIZdjAvnB9DrqyfcBQKbpBqTvdttVOqCTGd5zbRJ0bnO81UhHWcCJTMdWRJVmcrHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyFqvBl/E1zFv8ToUNl+fqOgGdLzecVMYrvYeRRNF60/GFjmTW
	9nfvs7rACDL8fhQMKphCWFtHaJpKd8r+gxLvzs+i1Ep90MF0w7CkkfXfmDKLUWup2aCdyfeW6O8
	ZWOADoc0hZ6gQZiCV9tHCg6+B8h9zMxW2Hcp3T35lCd/ABzhushJ0AIP0IiZN4Q==
X-Gm-Gg: ASbGncuI5fyBL2iEA6EoTB6GB+XNwlm61pozoAg1ZmuF82u6Nr7BfqumP8l3OrKDWsH
	SYVvcSiP/FG3vGjltCv8N2FNOItygUNv11dj5jM5EqciUhVbQ/JIy14QA928qWo1INUjzB8aXvT
	U7NxPsKaWbqAiPHgxP/W4R3N90HhVRCFtgU05WThUOWwBLQunXxh8vf7S0DG7wAaY7NT6o5juvM
	mwRke7aLGy2QM3p5YlkgFFjbnbALVQUCWVRNPp5iNSlptkzp4d3akpeRNa5JtqReOxcnkz2s8xi
	0tzWVu37lubEbuA=
X-Received: by 2002:ad4:5ec9:0:b0:6d4:c6d:17fe with SMTP id 6a1803df08f44-6e8a0d066f7mr100418726d6.25.1740795199459;
        Fri, 28 Feb 2025 18:13:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHby/pOI2/cjHxNFtoBza6WhUyo/Cy0uLxM68AvvFaPCh8WDcdpymODwF1urcBd/yOvWHIP9A==
X-Received: by 2002:ad4:5ec9:0:b0:6d4:c6d:17fe with SMTP id 6a1803df08f44-6e8a0d066f7mr100418576d6.25.1740795199220;
        Fri, 28 Feb 2025 18:13:19 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e89765347bsm28371566d6.37.2025.02.28.18.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 18:13:18 -0800 (PST)
Message-ID: <a8d8a373b41dbc72d007f60e83dcb7ee596a5ad5.camel@redhat.com>
Subject: Re: [RFC PATCH 10/13] KVM: nSVM: Flush the TLB if L1 changes L2's
 ASID
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Sean Christopherson
 <seanjc@google.com>,  Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 28 Feb 2025 21:13:18 -0500
In-Reply-To: <20250205182402.2147495-11-yosry.ahmed@linux.dev>
References: <20250205182402.2147495-1-yosry.ahmed@linux.dev>
	 <20250205182402.2147495-11-yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-02-05 at 18:23 +0000, Yosry Ahmed wrote:
> KVM tracks a single ASID for L2 guests. L1 could change the ASID it has
> assigned L2 due to switching to a different L2 guest or simply to avoid
> flushing L2's existing ASID. Flush L2's TLB when this happens to avoid
> reusing TLB entries from the old ASID (from L1's perspective).
> 
> Remove the comment in __nested_copy_vmcb_control_to_cache() about the
> cached ASID usage, as this changes makes it stale by adding another
> usage.
> 
> This is heavily inspired by nVMX's handling of last_vpid.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  arch/x86/kvm/svm/nested.c | 5 ++++-
>  arch/x86/kvm/svm/svm.h    | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index e2c59eb2907e8..12bb391884299 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -368,7 +368,6 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
>  	to->pause_filter_count  = from->pause_filter_count;
>  	to->pause_filter_thresh = from->pause_filter_thresh;
>  
> -	/* Copy asid here because nested_vmcb_check_controls will check it.  */
>  	to->asid           = from->asid;
>  	to->msrpm_base_pa &= ~0x0fffULL;
>  	to->iopm_base_pa  &= ~0x0fffULL;
> @@ -509,6 +508,10 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
>  		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
>  	}
>  
> +	if (svm->nested.ctl.asid != svm->nested.last_asid) {
> +		svm->nested.last_asid = svm->nested.ctl.asid;
> +		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
> +	}

>  	/*
>  	 * TODO: optimize unconditional TLB flush/MMU sync.  A partial list of
>  	 * things to fix before this can be conditional:
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 6a73d6ed1e428..f2352135b99d3 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -211,6 +211,8 @@ struct svm_nested_state {
>  	 * on its side.
>  	 */
>  	bool force_msr_bitmap_recalc;
> +
> +	u32 last_asid;
>  };
>  
>  struct vcpu_sev_es_state {


I can't be 100% sure but overall the patch looks correct to me.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



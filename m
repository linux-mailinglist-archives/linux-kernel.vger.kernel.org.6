Return-Path: <linux-kernel+bounces-539737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD88A4A7FD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895C9189D0B8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9F139AD6;
	Sat,  1 Mar 2025 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3m1gSYa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EF31B95B
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795720; cv=none; b=Rh877CRJiD92FLQD36lzogaas6HiD/nfeBa3MCcyMPUDuDLA8QTBc8PnePHgQJ4mil5NVH8ermrkq+3KBCLIzpdro9QFQaio+SxMzUWHGFOVPsADI33EeV2avwH6a1haGGjmRwKVdcNIUeEq19hKT8VyiV1FSFWEBh4mgBBit5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795720; c=relaxed/simple;
	bh=bDibNU9cIAoysHjLeD71zv5dAzOetWpaXTYTDB0yu6Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g//yr5gRYJEc5D/iLe+Mvqqm5AP+B/zWOJChuHaRN5VoPJ6MXzDlT5GVDrPfB2tmivua9KtpUmQvqSGgcjOL4t0GpkYEU9Te2KhzmS+c3LlcXnvRlZqhzXV+aMPT/m3WATSiwL0WuIT5G/Q/C9vbvUNfQ22bETq/7LMsa61afgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X3m1gSYa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740795718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXZzwbUKVjbHG2DfVdm6JTcxzSxRdgemZS7ziWqrxzA=;
	b=X3m1gSYagx9qhYKjisIeV1iCmKBOvTwFNCD2xI5iQ0PC4QkcSvBDSxenJPgu9/YRqy5VpP
	577632JPyc3atc4QNP3Wd2cSd4gJHBZsSYsd9P4s93OgSRivQs8Xc7qAtaTNJaCTyL3TcO
	bVDYIWQ2Gqomuf3ALZg53AUxPfNZpac=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-AWqHQPWHOCOaw-1RMkOdTw-1; Fri, 28 Feb 2025 21:21:56 -0500
X-MC-Unique: AWqHQPWHOCOaw-1RMkOdTw-1
X-Mimecast-MFC-AGG-ID: AWqHQPWHOCOaw-1RMkOdTw_1740795716
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0a46f1ec7so476468385a.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:21:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740795716; x=1741400516;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXZzwbUKVjbHG2DfVdm6JTcxzSxRdgemZS7ziWqrxzA=;
        b=I2Z7/oGCb/OC4icLPYTUJpMvF1iu9FfWOWHhHxp6Bfgb5YoyEaSOvgUsuSsilZPQNi
         OyZlxn9x/MBekOWGxXNuqrvKk1pn1nxo8YLh3iTZlhE+LHXoFv0HWcDREjccD4y9hC6g
         cJBnjmggqS7vOQSAxWFnj0twxZ8oh+U+EYHAxGRQ4rvswx0eBm1O7j/4Q6WhsG92ELzn
         9oL4ip+EsELpX0ZXQTS0gq1hNNd6R8ZuPFvAR8XlHg4Ty1zExIIK0QPC1f4eCTrKgtsl
         R5Nt/9szlnsYBQSDwrsKDpy/eAqXFoi4LBjro0W8vcN/2zJSfUhO+rwtWHVYALd/v33R
         QC0A==
X-Forwarded-Encrypted: i=1; AJvYcCUMpeJlKCyLcLedXnwkKSHZiVS2Icblcu2qB0QgQuH+5vmm0d9O3mxx1AoUEsG1wbJz3Iz74LeycbBv344=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFsFEowOGgCNZodWYRkrX4uG+GvW4vxNGJWMIG6LFX2hndevlc
	YdevSxhw1hVovB46aIAjK9/FeshBqTEXf0p2gSYPN2mJAgX57r36svRNllR4tOxc3sTdPQlLHXi
	9yqNKIYE45xhZRVccylBuEHa44MghMA3zIyohAiNKrALt8cuM38IfpSU7P8bPgA==
X-Gm-Gg: ASbGncuEBdkAdXaj1b10iIB9ZrzyB+SKMtgOOVslsTleJCRZ1OO9hXoMM6Nstt4GCov
	PNS9ET7lfomiol2fvH4WVNUUaZyasTluh5oWVMWkv0uaR3UC6LxhVesyQK21CH4Z7gS8Sm5wZ0P
	hFhBM033y01RS/TlMUCcCCOwdOsSGOzybNompKMVdtDjIE6yJIRz6YE7zCj8jxgb0MIHt0FjBYa
	Lu8x05X12wByX0iSrxQPeYQNscAFj2SYkxaicREhqNGP1zXxUjja4JuPgu3LF1UDEq/lX4bHZRC
	g8orHNYzTSs5rG0=
X-Received: by 2002:a05:620a:19a5:b0:7c0:a3bd:a780 with SMTP id af79cd13be357-7c39c6778e2mr1065106585a.54.1740795716030;
        Fri, 28 Feb 2025 18:21:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiVIxPbDW0c91j7RHZ7nyiiGATb61if+LbTMCmwDxjsFDBjOg8jBIWHtm8xjrLPxUNjm8vAQ==
X-Received: by 2002:a05:620a:19a5:b0:7c0:a3bd:a780 with SMTP id af79cd13be357-7c39c6778e2mr1065104985a.54.1740795715763;
        Fri, 28 Feb 2025 18:21:55 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976534c0sm28514006d6.40.2025.02.28.18.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 18:21:55 -0800 (PST)
Message-ID: <da0b13813b11e5b13f01dced9a629ac07fad27cd.camel@redhat.com>
Subject: Re: [RFC PATCH 13/13] KVM: nSVM: Stop bombing the TLB on nested
 transitions
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Sean Christopherson
 <seanjc@google.com>,  Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 28 Feb 2025 21:21:54 -0500
In-Reply-To: <20250205182402.2147495-14-yosry.ahmed@linux.dev>
References: <20250205182402.2147495-1-yosry.ahmed@linux.dev>
	 <20250205182402.2147495-14-yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-02-05 at 18:24 +0000, Yosry Ahmed wrote:
> Now that nested TLB flushes are properly tracked with a well-maintained
> separate ASID for L2 and proper handling of L1's TLB flush requests,
> drop the unconditional flushes and syncs on nested transitions.
> 
> On a Milan machine, an L1 and L2 guests were booted, both with a single
> vCPU, and pinned to a single physical CPU to maximize TLB collisions. In
> this setup, the cpuid_rate microbenchmark [1] showed the following
> changes with this patch:
> 
> +--------+--------+-------------------+----------------------+
> > L0     | L1     | cpuid_rate (base) | cpuid_rate (patched) |
> +========+========+===================+======================+
> > NPT    | NPT    | 256621            | 301113 (+17.3%)      |
> > NPT    | Shadow | 180017            | 203347 (+12.96%)     |
> > Shadow | Shadow | 177006            | 189150 (+6.86%)      |
> +--------+--------+-------------------+----------------------+
> 
> [1]https://lore.kernel.org/kvm/20231109180646.2963718-1-khorenko@virtuozzo.com/
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  arch/x86/kvm/svm/nested.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 8e40ff21f7353..45a187d4c23d1 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -512,9 +512,6 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
>  		svm->nested.last_asid = svm->nested.ctl.asid;
>  		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
>  	}
> -	/* TODO: optimize unconditional TLB flush/MMU sync */
> -	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
> -	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
>  }
>  
>  static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
> @@ -530,10 +527,6 @@ static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
>  	 */
>  	if (svm->nested.ctl.tlb_ctl == TLB_CONTROL_FLUSH_ALL_ASID)
>  		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
> -
> -	/* TODO: optimize unconditional TLB flush/MMU sync */
> -	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
> -	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
>  }
>  
>  /*


Assuming that all previous patches are correct this one should work as well.

However only a very heavy stress testing, including hyperv, windows guests
of various types, etc can give me confidence that there is no some ugly bug lurking
somewhere.

TLB management can be very tricky, so I can't be 100% sure that I haven't missed something.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



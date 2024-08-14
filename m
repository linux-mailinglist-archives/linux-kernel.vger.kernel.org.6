Return-Path: <linux-kernel+bounces-286906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD38495203C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C571C244A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351D61BA86A;
	Wed, 14 Aug 2024 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4hAidHw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AA1B8EB7
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653665; cv=none; b=umiS+rcHZTgnHMEol9Z1f1ZgZxQjyz2mj/ueZvXEH58d/7EjBpigbKS7moi91kGf53vshkQ8vk87WJzmxrVL73M2aA7CEJ4376XO2jTOj2JwESLKFAN2sTiTJlKqOGipb0yIzWumAM7Zy8Ym90Wi60+fZdnzBApHtpS3WDaDqsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653665; c=relaxed/simple;
	bh=7AB5XL5Leu1w77lulF3bSCcoPu0jslyenRtKKCGnLPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQDnS3stVwRDda7PA5iDOF89UhbCpbf/VENrJTAwSBasIWi+vWhGGzW0vbwund617+X8xHHMDoeha/AhSEVqn8gu3kZxQtkcMWVWc2NH3SLLc64WNxgF1yhhaYtvKuKhfADcJC5yTjolMfo/V5WK/zfjbDY1BM2X+JJJl6heGTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4hAidHw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723653661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6q4Gfk/lIOoinbvdgXo7rUdEdQMPSJAVb4LqB5Anl/M=;
	b=H4hAidHwnrzNzcOQl1KuGBDfH5ep2lJiB3ULnwhCLrQa3P7or9vEhsHBfWxxuYhHRKSWs5
	CDuR1SSjYJmYs7SS+DHsEedkKhT7jc/ZuQaBnwH424reBe7knVj1OATB81X8Y2ey5qHEi/
	IK58tUNXfbj74yBLzk7+Q6DGVv36SaM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-w7xebiPDNoWr1Aor9PY5VQ-1; Wed, 14 Aug 2024 12:40:59 -0400
X-MC-Unique: w7xebiPDNoWr1Aor9PY5VQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42820c29a76so53889585e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723653658; x=1724258458;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6q4Gfk/lIOoinbvdgXo7rUdEdQMPSJAVb4LqB5Anl/M=;
        b=NFARRC/8hvMUdb08fkUzygrhNLBWMp9CZHP5o+mP7qxCIfwBfByiU6pdQqOC3EUtw0
         xG990jzlbYDl8zeTWASdbd6muaB81jYkoydAESK5D9i3UFbToIcT2EFQCyd/xk2QiDEQ
         pqwcCk4UYD0amfBHu/RSDVhM9FJBNbAikMMGOMCyipy3U3HnAy8VwoxfGM46n4sooP05
         m1ZG5ab7zYSK27QlO6FKEXsns/ESno+a9jzYNvMDuN7IWfVBW+eZELUz5cxVa4dzC+Ba
         a3+rGegLz85h8sU9zHyJRYF0zYj9+SlREn0GpMOl4Ll8v2DCLmpT2nXF1oOeMeH034pC
         /jcA==
X-Forwarded-Encrypted: i=1; AJvYcCWZL7FdN/LEFfJthToZSYB4mtGCAVv2hcXXD9BrkfIF20CTz47KrCmyRS0M6v1OKHunEqLTuuOhIJ0T/XR2zDllmixxS9fp5TNhuBGT
X-Gm-Message-State: AOJu0Yzb3rPkBpxGweLYo35hRcU+tc7D40oCS4M5e1WEHW7/HMxqAhaA
	9QL8/uQs1NPUHrEXbqVS8X9YEFNJjLxJpFizeGL3myaGY9gGWrMhIGwOW32+jGyUXtVJcsWd/Wq
	ow3tvwGFfTlJuHhy8mai3NlSdcEb0xzPzUrH5SfdTJu7XHlCyZS5ay40KI/OXyTTj22DJqw==
X-Received: by 2002:a05:600c:4686:b0:428:e140:88c4 with SMTP id 5b1f17b1804b1-429dd26749dmr20611465e9.33.1723653657591;
        Wed, 14 Aug 2024 09:40:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnFK08Vl87WzQqs3F1Brre5kODaABIS4VX+/eU65GczibuUE4Dv7UmwPOShh4Rj083IwRo5w==
X-Received: by 2002:a05:600c:4686:b0:428:e140:88c4 with SMTP id 5b1f17b1804b1-429dd26749dmr20611285e9.33.1723653657032;
        Wed, 14 Aug 2024 09:40:57 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429ded19670sm25059625e9.9.2024.08.14.09.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 09:40:56 -0700 (PDT)
Message-ID: <96293a7d-0347-458e-9776-d11f55894d34@redhat.com>
Date: Wed, 14 Aug 2024 18:40:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/22] KVM: x86/mmu: Trigger unprotect logic only on
 write-protection page faults
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Ackerly Tng <ackerleytng@google.com>
References: <20240809190319.1710470-1-seanjc@google.com>
 <20240809190319.1710470-4-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240809190319.1710470-4-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 21:03, Sean Christopherson wrote:
> Trigger KVM's various "unprotect gfn" paths if and only if the page fault
> was a write to a write-protected gfn.  To do so, add a new page fault
> return code, RET_PF_WRITE_PROTECTED, to explicitly and precisely track
> such page faults.
> 
> If a page fault requires emulation for any MMIO (or any reason besides
> write-protection), trying to unprotect the gfn is pointless and risks
> putting the vCPU into an infinite loop.  E.g. KVM will put the vCPU into
> an infinite loop if the vCPU manages to trigger MMIO on a page table walk.
> 
> Fixes: 147277540bbc ("kvm: svm: Add support for additional SVM NPF error codes")
> Cc: stable@vger.kernel.org

Do we really want Cc: stable@ for all these patches?  Most of them are 
of the "if it hurts, don't do it" kind; as long as there are no infinite 
loops in a non-killable region, I prefer not to complicate our lives 
with cherry picks of unknown quality.

That said, this patch could be interesting for 6.11 because of the 
effect on prefaulting (see below).

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/mmu/mmu.c          | 78 +++++++++++++++++++--------------
>   arch/x86/kvm/mmu/mmu_internal.h |  3 ++
>   arch/x86/kvm/mmu/mmutrace.h     |  1 +
>   arch/x86/kvm/mmu/paging_tmpl.h  |  2 +-
>   arch/x86/kvm/mmu/tdp_mmu.c      |  6 +--
>   5 files changed, 53 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 901be9e420a4..e3aa04c498ea 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2914,10 +2914,8 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
>   		trace_kvm_mmu_set_spte(level, gfn, sptep);
>   	}
>   
> -	if (wrprot) {
> -		if (write_fault)
> -			ret = RET_PF_EMULATE;
> -	}
> +	if (wrprot && write_fault)
> +		ret = RET_PF_WRITE_PROTECTED;
>   
>   	if (flush)
>   		kvm_flush_remote_tlbs_gfn(vcpu->kvm, gfn, level);
> @@ -4549,7 +4547,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>   		return RET_PF_RETRY;
>   
>   	if (page_fault_handle_page_track(vcpu, fault))
> -		return RET_PF_EMULATE;
> +		return RET_PF_WRITE_PROTECTED;
>   
>   	r = fast_page_fault(vcpu, fault);
>   	if (r != RET_PF_INVALID)
> @@ -4642,7 +4640,7 @@ static int kvm_tdp_mmu_page_fault(struct kvm_vcpu *vcpu,
>   	int r;
>   
>   	if (page_fault_handle_page_track(vcpu, fault))
> -		return RET_PF_EMULATE;
> +		return RET_PF_WRITE_PROTECTED;
>   
>   	r = fast_page_fault(vcpu, fault);
>   	if (r != RET_PF_INVALID)
> @@ -4726,6 +4724,9 @@ static int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code,
>   	case RET_PF_EMULATE:
>   		return -ENOENT;
>   
> +	case RET_PF_WRITE_PROTECTED:
> +		return -EPERM;

Shouldn't this be a "return 0"?  Even if kvm_mmu_do_page_fault() cannot 
fully unprotect the page, it was nevertheless prefaulted as much as 
possible.

Paolo



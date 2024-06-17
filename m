Return-Path: <linux-kernel+bounces-217774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D17690B418
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0AA1F271B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6563B16A934;
	Mon, 17 Jun 2024 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcMi7WkM"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC82160883
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635788; cv=none; b=diwcARSnriuYTvPE1aZpqOSgx01mabDdqdR2ADBpLOBAeGy8IjrOl32NW29I7/LOgcozZhGf61UD8hbtzPdJyempK/kwBOsPuMxGMVOxZgedKkli5lLA6sj7kIsGfRHQiY1ftaz/1EsC5dLJkvoVQLSwHXQdLSy44P11CbEHnzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635788; c=relaxed/simple;
	bh=A1ObqteLnr4rsOexDfLBNOVS8Jb8YVaqD08pge4odro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ex9+Cs/V+D/JEPck7yYgCQ40vvcdNlX6RkHljGQ1Z3M6wDFXja4fKcHpgeEDxh7HW98ZlQgA7XOBTFzHdb1MwNjAaRHdpLi+Xe8zqQ8EbKS59/6eZlc3mAsSkA7/w7g5oU2ipMOLaQUmCbDFqjl+4Pm/eYtdFYL0P8DFaZhzxOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcMi7WkM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f6efc8759dso51095925ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718635786; x=1719240586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+xAYhKOZltGRZcPSGvAJLT2O5rAH3PpppLSl+wsonY=;
        b=fcMi7WkMW/D/hIkPPR4i2NwtRvuebY0NCCYiNCZUNQWLDv1PEp2Tes5QT0TndwcB5r
         rb3dSayd1M+7/mhpsb9dP9eAyGXlbJJEYTDwAupi4BAi5fBPKnwLpzxTXylZUo1vYrBy
         ukcYYmAv1WSiGsi6ipwmm+xgMdd3c+8EsIsRkjoizqWPVLT3LAotSWJmsmEtZCVZmVSY
         qumRgkY1tXllo4f0Fmp+JyYSE/fRTBF2ier+RYfQ2ZJrzRq6bSL+FXwN/mQYsjmue4QU
         aVKP1TFmkkmqkTX4Nq7ZM4bUIxAwdxx8RfhBmPkpWpa5PrN3f7lbRON/H258P+5NNbO6
         ikcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718635786; x=1719240586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+xAYhKOZltGRZcPSGvAJLT2O5rAH3PpppLSl+wsonY=;
        b=eRt1qW3vXHcdHMv2e/i2RQJcfeexxXKHHjeocxHCzF9NGa2d6XvSpMos6PfmLZvIz2
         iW6XSpvcI8SB4xynIHT/PSV/Rn+qdISZS5PkLx3yQs/OPSQaoaD3N7BSgcSIBCjkKb/0
         gV7uw669tMycrFB6gLN3ToLSw2CTITTW6XGgLKJx/hhbpWcDa8tbAny8TDqN46+yiOcR
         Mhf45ZYNoaO8Pa5x0HdJvjDYGSZpmEbij2cXeMysmcXhk/T8pb/ZerYok7ufbffjfIlF
         yVX9f0sXLdcrMH8nM6CUPkv5svXCtn59pi76ifjQddw+FB2V1Ak4+641zL2XvR3AsBpe
         gRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXetl6PrTIh10xvLrU1EEYY8wf8/fm1p2oAeiFa46uOAZL2kU4PGTrvnbZxZQIVB0j685Xf8UAqK+NOMWi5wzQPU8/dBJF1n2fqaDKS
X-Gm-Message-State: AOJu0YzwQi1YcywHgziAaJB9yLh3OdV1tEmSzcxtCPXqJSHAWyVdbOtu
	lhpE4jOdrGylB5nP85veq7qXJ4/Ukdn7534nuWNmKwgYAf8cWsC1cqmPV2yZ2D5HvcZNzMmTOmQ
	EPQ==
X-Google-Smtp-Source: AGHT+IEDL3RYLk4OeAsEDZAk7iTpL6KxgWNxcYgbSYbE6r72h4dXDgdaAGDiBFZLFIRvvkU38q9sG0Dlcoo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f98e:b0:1f3:2e40:579f with SMTP id
 d9443c01a7336-1f862a0d09bmr1636285ad.11.1718635786428; Mon, 17 Jun 2024
 07:49:46 -0700 (PDT)
Date: Mon, 17 Jun 2024 07:49:45 -0700
In-Reply-To: <20240615025930.1408266-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240615025930.1408266-1-maobibo@loongson.cn>
Message-ID: <ZnBNCYZHuflw83jq@google.com>
Subject: Re: [PATCH] LoongArch: KVM: Delay secondary mmu tlb flush before
 guest entry
From: Sean Christopherson <seanjc@google.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Jun 15, 2024, Bibo Mao wrote:
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
> index c87b6ea0ec47..98078e01dd55 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -30,6 +30,7 @@
>  #define KVM_PRIVATE_MEM_SLOTS		0
>  
>  #define KVM_HALT_POLL_NS_DEFAULT	500000
> +#define KVM_REQ_TLB_FLUSH_GPA		KVM_ARCH_REQ(0)
>  
>  #define KVM_GUESTDBG_SW_BP_MASK		\
>  	(KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP)
> @@ -190,6 +191,7 @@ struct kvm_vcpu_arch {
>  
>  	/* vcpu's vpid */
>  	u64 vpid;
> +	unsigned long flush_gpa;

Side topic, GPAs should really use "gpa_t" instead of "unsigned long", otherwise
32-bit kernels running on CPUs with 64-bit physical addresses will fail miserably
(which may or may not be a problem in practice for LoongArch).

> diff --git a/arch/loongarch/kvm/tlb.c b/arch/loongarch/kvm/tlb.c
> index 02535df6b51f..55f7f3621e38 100644
> --- a/arch/loongarch/kvm/tlb.c
> +++ b/arch/loongarch/kvm/tlb.c
> @@ -21,12 +21,9 @@ void kvm_flush_tlb_all(void)
>  	local_irq_restore(flags);
>  }
>  
> +/* Called with irq disabled */

Rather than add a comment, add:

	lockdep_assert_irqs_disabled()

in the function.

>  void kvm_flush_tlb_gpa(struct kvm_vcpu *vcpu, unsigned long gpa)
>  {
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
>  	gpa &= (PAGE_MASK << 1);
>  	invtlb(INVTLB_GID_ADDR, read_csr_gstat() & CSR_GSTAT_GID, gpa);
> -	local_irq_restore(flags);
>  }
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 9e8030d45129..ae9ae88c11db 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -51,6 +51,16 @@ static int kvm_check_requests(struct kvm_vcpu *vcpu)
>  	return RESUME_GUEST;
>  }
>  
> +/* Check pending request with irq disabled */

Same thing here.


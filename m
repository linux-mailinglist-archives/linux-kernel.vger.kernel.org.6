Return-Path: <linux-kernel+bounces-194714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F118D4086
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 23:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD916284496
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88321C9EC7;
	Wed, 29 May 2024 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLmehhzf"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51386181BA9
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717019490; cv=none; b=c8RzqNYRb1G2M9bekWAS13AbVaOoBudSnDhQ/lPP96GlTUPT3ihXYKxPp4gsXy+pPvz/9kPjroyKE9OkVynRddheCJfDT0XkYQz2UWWsCo+EkgymN9lBvizO82q+4R2XywkXHZ7ykEkxxr8brbLdMbSj8sO+uJUsCdJbHSOMT4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717019490; c=relaxed/simple;
	bh=lKMYQD65eNFrkDU5H9syEgOM26afIR7DCV4zcHP/8AQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nK6IL3dT/ypNSFmUGpg8jaifypkQVJeVc85hoAm4z25xcyo7MWD3iA7nTKrewXPse/HL5N5RU0AH+VkVPq3w4SGkbE0yrB9o0V0uZEWpra/W+wbT/bIrEAIvWefr3o2nNTPiyJKDBV6J1EikSt4EMTiGrr7ZKeN2oMJev/HytI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tLmehhzf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df771bdee6bso294907276.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717019486; x=1717624286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZEwQSuDxXsJBbCguZar5+VKzM/izfp4n/7bUq7QabM=;
        b=tLmehhzfnrlMGWqR2sFjYgibjU8taDCgc3add5HEghKH9yEtUxIXvVW7efzXyBmLmb
         Myq4BL9kQAiTMf/2zxgjC32aHAlasiqmHKTVp0Y/lCbeGRNiVlUXgfdQ8GZ3oStNTSBo
         bTxtnHQlJ7gccT9qDR5aHfopeKq12klGenQizobgOib2UgulyQiQKPhNaZAoBsYkh2sU
         5e9Yu3wfE7TZWEoNQY8f1cF8RP2BAT57NYV1CxBZhmJSJTcSnlEr7aK5HTyZ70AbdTx3
         a7rr+SQmodcBIb4j+iQvYxfXX0D9g3JTkBXN2gVZlROsNxxdteQTfRbbKtnA/lYQDxd/
         C/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717019486; x=1717624286;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZEwQSuDxXsJBbCguZar5+VKzM/izfp4n/7bUq7QabM=;
        b=nNs5Incvb4BbYpjsfWNltGpU1LZW4yr9nkaOA4DkZIKv8GA8oS+X5VAcQ9aB44bSB5
         YlBfY9Y7ebp4di+dUreMfkDqohiR04XPZHsDQUnHx+taIpWGQHYrOB1FCwlXi9gkqnDg
         DsTwN5b/vu6PIemzjqCc9RP5jcPpme6M7hN9BbgWa8rg5myA8EYsAPgufGyE7u/IIC8f
         VNsspfkQjgLlmPgqzSGIiZWBqzPGfn+Mn3kN1nSb0R4tnaTDiGrOi0tloM5pzxj3uoBK
         cA3ERwW0Q8PfHhqlTlDzPzbBLTRTRflCs46tI06cJrZ90eZumEFmpOEGDsQLPpVUK7H2
         I+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWDxciMbXcxRDOMHdiv1IFHn31pphAMupi0paQRLN/CoFgNl7br9fIuuz9WYPy/1BQOhRWnZsyS1jQ/uBWvZf32TirwL9thQ1n1Hei
X-Gm-Message-State: AOJu0Yw1yOc7EZKGDtTHtPmkp4bb7GzqpHbBCxUpEq6rajzrpFcN4JFZ
	jtn9xbV7Z7onSxqTEmSCEZtXufRKawxHK/cojY9PHqL98WJ0EPxrZzo6T+/JDcc0XBka24Sjku6
	ViQ==
X-Google-Smtp-Source: AGHT+IGqNZ2BbD8cAo2AnWXa3Pi0tfvxVmoPgtWnywK5+NXQgcmpZ6RBn86fT+8nIYtd+ZPLip7+OZUjHdQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:188e:b0:df7:8889:4795 with SMTP id
 3f1490d57ef6-dfa5a407dc6mr54800276.0.1717019486318; Wed, 29 May 2024 14:51:26
 -0700 (PDT)
Date: Wed, 29 May 2024 14:51:24 -0700
In-Reply-To: <20240529180510.2295118-4-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240529180510.2295118-1-jthoughton@google.com> <20240529180510.2295118-4-jthoughton@google.com>
Message-ID: <ZlejXCYIuJ7_DlwL@google.com>
Subject: Re: [PATCH v4 3/7] KVM: Add lockless memslot walk to KVM
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Ankit Agrawal <ankita@nvidia.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Raghavendra Rao Ananta <rananta@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, May 29, 2024, James Houghton wrote:
> @@ -686,10 +694,12 @@ static __always_inline int kvm_handle_hva_range(struct mmu_notifier *mn,
>  	return __kvm_handle_hva_range(kvm, &range).ret;
>  }
>  
> -static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn,
> -							 unsigned long start,
> -							 unsigned long end,
> -							 gfn_handler_t handler)
> +static __always_inline int kvm_handle_hva_range_no_flush(
> +		struct mmu_notifier *mn,
> +		unsigned long start,
> +		unsigned long end,
> +		gfn_handler_t handler,
> +		bool lockless)

Unnecessary and unwanted style change.

>  {
>  	struct kvm *kvm = mmu_notifier_to_kvm(mn);
>  	const struct kvm_mmu_notifier_range range = {
> @@ -699,6 +709,7 @@ static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn
>  		.on_lock	= (void *)kvm_null_fn,
>  		.flush_on_ret	= false,
>  		.may_block	= false,
> +		.lockless	= lockless,

Why add @lockess to kvm_handle_hva_range_no_flush()?  Both callers immediately
pass %false, and conceptually, locking is always optional for a "no flush" variant.

>  	};
>  
>  	return __kvm_handle_hva_range(kvm, &range).ret;
> @@ -889,7 +900,8 @@ static int kvm_mmu_notifier_clear_young(struct mmu_notifier *mn,
>  	 * cadence. If we find this inaccurate, we might come up with a
>  	 * more sophisticated heuristic later.
>  	 */
> -	return kvm_handle_hva_range_no_flush(mn, start, end, kvm_age_gfn);
> +	return kvm_handle_hva_range_no_flush(mn, start, end,
> +					     kvm_age_gfn, false);
>  }
>  
>  static int kvm_mmu_notifier_test_young(struct mmu_notifier *mn,
> @@ -899,7 +911,7 @@ static int kvm_mmu_notifier_test_young(struct mmu_notifier *mn,
>  	trace_kvm_test_age_hva(address);
>  
>  	return kvm_handle_hva_range_no_flush(mn, address, address + 1,
> -					     kvm_test_age_gfn);
> +					     kvm_test_age_gfn, false);
>  }
>  
>  static void kvm_mmu_notifier_release(struct mmu_notifier *mn,
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 


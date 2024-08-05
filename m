Return-Path: <linux-kernel+bounces-275486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C7E94865F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAAA1F23CC6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972CA16F84A;
	Mon,  5 Aug 2024 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJ69nggg"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8005314F9F1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722901988; cv=none; b=hJATYnl0evssLVtbQH9gYZHGUhW/R8PHfsqiAxd9Qeup3jcA1KDijGdYFY2WevHzdqKTrBY1piJkVDbOAQEVJKlzse23YlM2miUndsdHwKE4J9w0mQzt/gL4WL0D4bTLAf64RIgAM3DQgyF/pwJNcrB8TMY70rRhQXI8qK69PZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722901988; c=relaxed/simple;
	bh=XE64EO9QsKUjNS+RxiZtVEDU63XJXco52ktIOyCusQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=okwY8Eyy6SKdo/ugSrTC0ToSpaPY/zEdmt695uPZpho7xiDs/jg+qchjCIE4MOTp8cdOEVNeauTslhIN1H7yo37neoo2UfWoVuRGTVbaVOD1/+ouFpTA9lr91n9dFKkm1ZJkGIkLMLr7kfdXcmxKDwCzMEO5l1C9BhCk1RtZaEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJ69nggg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-666010fb35cso5219047b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 16:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722901986; x=1723506786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tNxfozveIy4KhK+t6BTSFuKqZ3CnwWBfLDeoqvVNkU=;
        b=pJ69ngggREAaIjL/T0BgH+kvr7l2vkZzXthW8dW73SUfJNWiQcVpFsdHdGiZVGL52w
         i5RNeLJcwpNL9GJeyxl094vXzSGFL4DM4F1Q5bUFv2eXSoTEWi/AfrtHWzUk0GQxYeJc
         LoaVhO/a6O/DEwbtV3RjjrFN9vcAE5VSBUtiVfsi9D3SVFxrXV7geqnZIJIaxP/gZNGE
         OeKRX94EoFqMyoWZb+PBIcMMuNVTtPzYRKrIjRDpIO1UUkSPJaJ9MsB/ZLXSZuN7ESCa
         4qcNrlUURKURzxl+/dWuuwkQ2h7I7+iVl8GtIj3OBnieVpUr5/Le/CV2j2/XN4pEWMal
         39dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722901986; x=1723506786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tNxfozveIy4KhK+t6BTSFuKqZ3CnwWBfLDeoqvVNkU=;
        b=NgRzRvvbWfLjk1DuEYYYFcZ7bwhd39EP3Hme7VZlEi8AM/9l8txyNdlt8P2eSzJS9S
         VAZbzqu7rz7bzk4fgSm0TOGbrZ0Cp8Kc1wD38gIBJ/da3vPVtU4X0YiNNnp33OKOfFkZ
         AhSH+0otz4Y4KS1QdVZxKV6WQw7WwBmzUnC/MrYtmSd8uUaAjokFMkRH8ICOXs6LcJ1Q
         bNUqi2Sf5JH2w6cfS4kl+R5DSIlSRCaEiLYnaVFnlbXagzL7nzev0C0YWPgI3BpxqbMy
         tYB2+p2tXArza8kfCn4PHM9IoiJEy+x0s6CyXFuHTLXzIrVDAKaE3ynIK+kzBKvaWrAV
         qKiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxEvt63eb2pGoOUst8orKracM6C87NjR+M13Hqkmb6WwORfIfGnqM+ZwIzApRiIYPp/BEBrUi+LM8D8pSWS8m5Qa4kKgIlxa3frG3G
X-Gm-Message-State: AOJu0Yx9TeoxpvI+JHqaEkGobOEojJSNsYTunH0ZgQjszPejg/ahECT2
	ZylsTE4D5gVZO5I/sOKDdoWoSaq+OsdEKEl3l+FsCC+nvHla0XUmQuz6HT1Rhad20afK7WHBT6v
	Ihw==
X-Google-Smtp-Source: AGHT+IHjgF0Ca8ethUSfrozdkFUFp0o0AUPtEhLPgrNZWa8lbUZ7qZQp3Z7lR+cNHb6EVM2g/AygpE/k1/Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:f16:b0:691:a38c:a61d with SMTP id
 00721157ae682-691a39bf26cmr3721507b3.3.1722901982364; Mon, 05 Aug 2024
 16:53:02 -0700 (PDT)
Date: Mon, 5 Aug 2024 16:53:01 -0700
In-Reply-To: <ZrFfvjy_-Tyx4xUV@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com> <20240726235234.228822-55-seanjc@google.com>
 <ZrFfgzRbiqT-Zi2O@linux.dev> <ZrFfvjy_-Tyx4xUV@linux.dev>
Message-ID: <ZrFl3faiGHQ5oLjf@google.com>
Subject: Re: [PATCH v12 54/84] KVM: arm64: Mark "struct page" pfns
 accessed/dirty before dropping mmu_lock
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 05, 2024, Oliver Upton wrote:
> > > ---
> > >  arch/arm64/kvm/mmu.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > > index 22ee37360c4e..ce13c3d884d5 100644
> > > --- a/arch/arm64/kvm/mmu.c
> > > +++ b/arch/arm64/kvm/mmu.c
> > > @@ -1685,15 +1685,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> > >  	}
> > >  
> > >  out_unlock:
> > > +	if (writable && !ret)
> > > +		kvm_set_pfn_dirty(pfn);
> > 
> > I'm guessing you meant kvm_release_pfn_dirty() here, because this leaks
> > a reference.

Doh, I did indeed.  Alternatively, this could be:

	if (writable && !ret)
		kvm_set_pfn_dirty(pfn);

	kvm_release_pfn_clean(pfn);

It won't matter in the end, because this just becomes:

	kvm_release_faultin_page(kvm, page, !!ret, writable);

So I guess the question is if you prefer to make the switch to an if-else in this
path, or more implicitly in the conversion to kvm_release_faultin_page().

I made the same goof for RISC-V, perhaps to prove that I too can copy+paste arm64's
MMU code ;-)


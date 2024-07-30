Return-Path: <linux-kernel+bounces-268303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DDC9422FA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999541F24886
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0281917D2;
	Tue, 30 Jul 2024 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFm794Cu"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B0818E051
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722378922; cv=none; b=TusfzM6Wjl5iMP3ACtnIlALmGstbxY+eh56J8q56tnln0mv5o7U2f8ISxnmHq53zIQZgEqPNkPA+vb1/ffxREDJd/XMh8QqtXnZQzfz3W0ihXsn4BArX/LxtLDxJ42ygIG6qJWcHqFREfVhpwElNjeyrv6VrTbqcBtZSnkfRxfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722378922; c=relaxed/simple;
	bh=YFDCChsqaB4UhHP0/2HzjxvaMXC55WBTMkh7IBQDDtE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hLnruuqXmgcT+lCthwUoJzN6RDzvDpBZwGDcRExiovUOWhNEEnsFppUNOy5wlPjKwvk1CJlh7z7bN+hfPss/NUhOEaNgfngfmaptaRsLcrKkPay1TdocOuWy/Umfwc7KLL0+NzgZwe8c8txAhd8RNooYtYzHRerflY2mGA7JXJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VFm794Cu; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70d188c9cabso4144934b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722378920; x=1722983720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eSOwPlC4K/K4c1NtKrHXJlP1TgjanOwgNCfxP6XzMYQ=;
        b=VFm794Cu4g1xmSVj5xxDIQ3U2TkQNpI93y1UzVMBC3NyvQsKPLGhWR09RVNvcrpKMI
         7SfUtm1/gqTJdPNvQdpFoP+kCkxKTgzwDl8unhOtxGXqfuahoOf0OYFETQfk1KGrOTqG
         cLRcUG3zkCf1rlPwowVhnQyGW5ht2n0SJrRjwBth6TnlTryrtiF4FCm+fGANTaEb5Heq
         MkwQ1oSW4ZQgmdML+HtzubjukNUDV0bWjVyL7fYwM9HQNmU7w9vdYTyUL6sZFNDErOyx
         fjKFurPNjJBPJCcVOLCIPMvVqZW6t+ylOnSPBHfe0qRhUU8lzY3iPYaJ8w3DxMes9Orl
         6zZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722378920; x=1722983720;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSOwPlC4K/K4c1NtKrHXJlP1TgjanOwgNCfxP6XzMYQ=;
        b=hI6plGd5xxDm9qkJPNyfR/dQxajesl/RecVz43MkNq5fu0ikQueYD84QLqtSgkrqda
         pWnI3Y37ub8KVFwh+1xipOAXQp6Hhg0xqSj1pyCg22CCp/m6zUcwqyyLHp2T/2X2VMTr
         W3KO9hIbuNR1S4QkJ7SaXgfyxyHX1M/ssarZBfkN4juM+1AbDmnc1uwb4AoD2RkBRELD
         e/qkFJuA9PlcOGbnSFBm5LgM2zzlchB1X0O3HprkBrJEyioemEzwhZtenXeCeNASet3U
         S1qQVTInlAwFlkO6jKD7E49NhqqRX/5WbaDvyYSni9xVEeVGfRDtOcQtKcSFkagvEg82
         Ke3w==
X-Forwarded-Encrypted: i=1; AJvYcCUw1yJ6osSviYOGQkIT0vx7WYaVjki2r6lImogv+JujyRkKmsmC0ArX5diniBCQBm5pd7azW4132+EY9nhKJfPO2M6xl+jH+sbacfMT
X-Gm-Message-State: AOJu0YyEqeC/JRU3rcqyXCRH480fVwYijRcfkEq7JHx2oqyyoxpfUJvG
	vOYEDE1hpdBFfwlzD3bX/AUSgCkkgRywi6YixbnviikVJORlGh3YKxko08vxTkVZasNxq27n+ZE
	WKg==
X-Google-Smtp-Source: AGHT+IFhvXMAoVFBOUzUOOlo2Rzlu+lOmmXT/AMKduASO9OrwvfaDw5U6qKsr5Vo6lwrA4+Cjt72+QiZt8Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:91c7:b0:710:4d08:e41f with SMTP id
 d2e1a72fcca58-7104d08e48amr716b3a.4.1722378920090; Tue, 30 Jul 2024 15:35:20
 -0700 (PDT)
Date: Tue, 30 Jul 2024 15:35:18 -0700
In-Reply-To: <419ea6ce-83ca-413e-936c-1935e2c51497@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726235234.228822-1-seanjc@google.com> <419ea6ce-83ca-413e-936c-1935e2c51497@redhat.com>
Message-ID: <ZqlqpjO0TiWnOEqx@google.com>
Subject: Re: [PATCH v12 00/84] KVM: Stop grabbing references to PFNMAP'd pages
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
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
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 30, 2024, Paolo Bonzini wrote:
> An interesting evolution of the API could be to pass a struct kvm_follow_pfn
> pointer to {,__}kvm_faultin_pfn() and __gfn_to_page() (the "constructors");
> and on the other side to kvm_release_faultin_page() and
> kvm_release_page_*().  The struct kvm_follow_pfn could be embedded in the
> (x86) kvm_page_fault and (generic) kvm_host_map structs.  But certainly not
> as part of this already huge work.

For kvm_faultin_pfn(), my hope/dream is to make kvm_page_fault a common struct,
with an arch member (a la kvm_vcpu), and get to something like:

  static int arch_page_fault_handler(...)
  {
	struct kvm_page_fault fault = {
		<const common stuff>,

		.arch.xxx = <arch stuff>,
	};

	<arch code>


	r = kvm_faultin_pfn();
	
	...
  }

In theory, that would allow moving the kvm->mmu_invalidate_seq handling, memslot
lookup, etc. into kvm_faultin_pfn(), or maybe another helper that is invoked to
setup the fault structure.  I.e. it would give us a way to drive convergence for
at least some of the fault handling logic, without having to tackle gory arch
details, at least not right away.


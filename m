Return-Path: <linux-kernel+bounces-210747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F3490483A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B551F23CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24FC4A1B;
	Wed, 12 Jun 2024 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pEjXY8GE"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30521FA1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718155130; cv=none; b=AlmJupten6E0tY+LueDygN7ExXKvp/a//aIaRgQGltumn409xNPkXFipYUkyIgpMfJxlL9LCkq15/d5UedpDWvuWgFMgRQWKzl7Ko4k0MeLQH7YvsAbcIt/h8+64IoWxO62DghdlvPyIiyW05/G1SIMzS3UGGsAyHYjDkywPsvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718155130; c=relaxed/simple;
	bh=NRQ5vxw0MkZ7yLnvDJPYGw9jB/h83t9zD3AKH0/y8IA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HGlxpZu1wyDWF+s9r6dljviYOp0E85+3O5HYQaMXZFRZdPAuqorO2KjkEYkiKOM3ONkAVcsCrUehIQ2KjWb2Y72s3rSm+sxC+bDc6v+wMfHeNENjeLRu65W+HuTueoV7cYG2t8hbRlFvrKV7gzsLXNQyomUSDOy32Rd9MEgwKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pEjXY8GE; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6e35e34f9b7so264250a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718155128; x=1718759928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gH/VrRThVAqNqdnAJ8qqfFFTLj74e8FaAJgriK6mdbo=;
        b=pEjXY8GEgFrzWkl7rtBJyniHlxYyMCahyYeu+gYkmCZJtQ/kw3QIwMy7zAC2V5/Rg0
         /7hgTzSJv9dWgreG+nbPJx7T2H9LI5eLwc8Fk8wg/+1Cq6zOUlzEzJ8AAnCNNQhQCySG
         OQPBKUDVm2yQqLeAPxQa9oM+UnmYuZfqE+IBsGLBcxmC3J6rPQj1jeVxzoJCl7c9yZWh
         yZUexog9dPhQndsTK6KpPQP3YWllg46NlThtb6MxcWjPwC2KLjfj8tkxOmRjYvsPoJdZ
         XRngwc8gCuiEIR5PyFo+w19DVFDTJ9f0wpT8Q7BZ91jASm+UHQNrGrD5CDjTp5t6wF1a
         ArdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718155128; x=1718759928;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gH/VrRThVAqNqdnAJ8qqfFFTLj74e8FaAJgriK6mdbo=;
        b=B0UnDP+5MEm7trZPltRKWE5imiqR9Sow3oKCsSLMYBObMcdZ/uhhI118j1OlzrsN1T
         oseCbZhYIkGLOfMU+DG6kp8Cwplf9DvEEYoTVTyQCoAwzEDci4ke0CUk/HTXCQ6TDN/q
         x06sxVczyVRnZhMAPCzF0nqL8cLyv83Wv2tHA2YftihhLWZ3eGYAwEzRK9e710PZlRRe
         u4uHgI4dand0xkz7sHy05YRPDaQXH/I6tHqELND5R3hhDpdMDZp05yboY5nLbZdrGm6P
         MVzIM4SVa0WngBLws+GWaBzWNm+/dVoD6t+EbkHLRXQorTYAUfn6tBaLZ9NMJV1SaTiu
         uedA==
X-Forwarded-Encrypted: i=1; AJvYcCURLLr47oknW+KSP3CSerRa59k013PoNmNzd1Nh2JeHcAqdlADnisGeH/Q6GfKu+J0loQ6/i5eEYryeNcF4RkGOLoTehJXZthy/kr99
X-Gm-Message-State: AOJu0Yxve6BscZipIUGYC6BSj8Vq2Uar7+YFtWcr+CQ+IrK4jg6YQCRl
	ERWBev8wHhwI3CS08USy3RwbhZ+n37H5iGx+rLGX5QnMXbDUMAAxhZf15T7E5AKzAbd6YsLDkZU
	YpA==
X-Google-Smtp-Source: AGHT+IFA7Nf2gM73IakGhMLgjpKn7tnJ0y7JJoAyUgWaeTxteQw7ecnDkGCPi06xyYh6rqY8tUOLbz5+Rl4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ce82:b0:1f7:516:4235 with SMTP id
 d9443c01a7336-1f83b1af087mr431195ad.6.1718155127840; Tue, 11 Jun 2024
 18:18:47 -0700 (PDT)
Date: Tue, 11 Jun 2024 18:18:27 -0700
In-Reply-To: <20240522014013.1672962-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522014013.1672962-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <171813751765.307375.7908491276602596005.b4-ty@google.com>
Subject: Re: [PATCH v2 0/6] KVM: Fold kvm_arch_sched_in() into kvm_arch_vcpu_load()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 21 May 2024 18:40:07 -0700, Sean Christopherson wrote:
> Drop kvm_arch_sched_in() and instead add and use kvm_vcpu.scheduled_out
> to communicate to kvm_arch_vcpu_load() that the vCPU is being scheduling
> back in.
> 
> While fiddling with an idea for optimizing state management on AMD CPUs,
> I wanted to skip re-saving certain host state when a vCPU is scheduled back
> in, as the state (theoretically) shouldn't change for the task while it's
> scheduled out.  Actually doing that was annoying and unnecessarily brittle
> due to having a separate API for the kvm_sched_in() case (the state save
> needed to be in kvm_arch_vcpu_load() for the common path).
> 
> [...]

Applied to kvm-x86 generic, thanks!

[1/6] KVM: Add a flag to track if a loaded vCPU is scheduled out
      https://github.com/kvm-x86/linux/commit/d1ae567fb8b5
[2/6] KVM: VMX: Move PLE grow/shrink helpers above vmx_vcpu_load()
      https://github.com/kvm-x86/linux/commit/5d9c07febb86
[3/6] KVM: x86: Fold kvm_arch_sched_in() into kvm_arch_vcpu_load()
      https://github.com/kvm-x86/linux/commit/8fbb696a8f53
[4/6] KVM: Delete the now unused kvm_arch_sched_in()
      https://github.com/kvm-x86/linux/commit/2a27c4314007
[5/6] KVM: x86: Unconditionally set l1tf_flush_l1d during vCPU load
      https://github.com/kvm-x86/linux/commit/ef2e18ef3750
[6/6] KVM: x86: Drop now-superflous setting of l1tf_flush_l1d in vcpu_run()
      https://github.com/kvm-x86/linux/commit/3dee3b187499

--
https://github.com/kvm-x86/linux/tree/next


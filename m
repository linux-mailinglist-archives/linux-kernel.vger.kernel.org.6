Return-Path: <linux-kernel+bounces-260419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8D693A8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE241F23590
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8274F1459EA;
	Tue, 23 Jul 2024 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LfX0m8xM"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDAE13DDDB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721769929; cv=none; b=QIntYn4ml8xOgjbap6m0fwg89W0+vy04nc6x0iPp+bJr9Ewui1Bd8FsEL98zPntwgPUhD3El8s8k9Mk3TDlas7KkoFvVTiAVOb49l4vD/vhc2v1xn9uyUPXeVYZtrVF5PyrRAhq1CBmNqiRY988X7ncyFqRzTHmg8+GCPFpAi0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721769929; c=relaxed/simple;
	bh=VRfWXStbqUNoMu/qD3trby7LOEO2dpGIApXJ5HarMVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cALr8G6IEbYWo82e91HuKvQtpTaFnE6ktW+tOEKJ1vAbAmet16EH+0h6oOP7dtU4p8t/rc3ozsp1h7EMS44x3EgzlSck6OQ7aEigU8WaeIqYw+D2TLMLqiq16GkOel5PaXa4AV7d1Yh5j+b2Ukx4DKA4SRvM2mza5hDWVO4GWGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LfX0m8xM; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-66498fd4f91so55456527b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721769927; x=1722374727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZJgCArp64eiMbqCXaN875D3c6qRuqIaB/kMh068BtM=;
        b=LfX0m8xMLkEj1yINcb5P1rwv6YW32GoBO5u4XzMGNA24Tg4JUg2b80LpS0J+fcooG1
         FWVzOXri+p6gWK1lrduigjqT+86GFi+1wtXOQgSiDsAtjQGya9KG4VevOoOB6LdMR2ve
         NNhwhb+a1y5vSvE59qmzTJUlDmqplZzRiu/YLx96afeu//m65GWvcghQNibm4kvfj133
         lUXI/zUYK3WsdwJhJrmF0ezaxGmKw5gXfcaU7XXYj1Xp32J5A4lcpssv//NdM5RogGOu
         54e7oaBOKAhjcwvvm7wJy4cc6zLC4sTyCRznYAihyW7x6gPNDQRxIEio4VOR1lFkVw8A
         noZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721769927; x=1722374727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZJgCArp64eiMbqCXaN875D3c6qRuqIaB/kMh068BtM=;
        b=dW/LfUY3wD34c9vJH1okkWk7IzCmG/wrpQgEjrmFffp1JjZ5RYUnT1HUdVrDKV8VuK
         fCNPjL1NqXr4e8OAsju032yPiyA417LilnxPAEnD9wZC3VqwY8bVxO4WLeYp5pFNKBDF
         18jyjGGof3/wS4PokQ7of5/ifB3ifdRlnV38/MgC4KjvWcpKF5D/qlratelyX56N+5OK
         jkqHcxfPvJGjkrP+xKzKuv1tkN0NUbKffY+OuVCorIZtu2+E3pf/P2zUsxv3TDaS81Mn
         rlD7lRn0CiJOxDThgkohJvXPEMFtkEnAU2qA2HLMItm6hU4B+LbUFKHvxgBnMsAx4mbd
         e2oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB6i87YDsXESdBvhGXQeBZyMaR+CnDA6zeTh8+bEIw+W88fhCmGpNjy0yNDU/kXprIdjZQW6IoIKEvBeMr5k/qwc9igcnXN8oaPCjy
X-Gm-Message-State: AOJu0YyGfkIH/aKBHaSgTQB/S5TDKHqU/DCVnO4V719GjAn+RL09GShT
	PofAgSKInU9uZhLdoOT/gAWMdWdZhXsFE4k8FU47Zs2cr4aEhg9sBTlpbGXPJCVNV8l3hjCQcFO
	EuXGnA1CnSSH4YxMuD5kH7kWxieYeHQL5sWGo
X-Google-Smtp-Source: AGHT+IGCV768j+YrEEm95b1T/ToEhs2+KD4YZsH39PZjohbKCe4xW674YxKBoDDwcCaLP5X/JLfj7nNNUwK9WrlPfmo=
X-Received: by 2002:a05:6902:274a:b0:e03:629f:5c41 with SMTP id
 3f1490d57ef6-e087b9e7ab9mr8610694276.55.1721769926984; Tue, 23 Jul 2024
 14:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com> <20231212204647.2170650-5-sagis@google.com>
 <5749ff16-ca81-440d-85f0-62a1c3a572d0@linux.intel.com>
In-Reply-To: <5749ff16-ca81-440d-85f0-62a1c3a572d0@linux.intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Tue, 23 Jul 2024 16:25:14 -0500
Message-ID: <CAAhR5DFtHDirPJy+ZWXGAALiRJiZD2NyW=bDTjyxoPLqkm9+Kg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 04/29] KVM: selftests: Refactor steps in vCPU
 descriptor table initialization
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Roger Wang <runanwang@google.com>, 
	Vipin Sharma <vipinsh@google.com>, jmattson@google.com, dmatlack@google.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 11:43=E2=80=AFPM Binbin Wu <binbin.wu@linux.intel.c=
om> wrote:
>
>
>
> On 12/13/2023 4:46 AM, Sagi Shahar wrote:
> > From: Ackerley Tng <ackerleytng@google.com>
> >
> > Split the vCPU descriptor table initialization process into a few
> > steps and expose them:
> >
> > + Setting up the IDT
> > + Syncing exception handlers into the guest
> >
> > In kvm_setup_idt(), we conditionally allocate guest memory for vm->idt
> > to avoid double allocation when kvm_setup_idt() is used after
> > vm_init_descriptor_tables().
> >
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Ryan Afranji <afranji@google.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >   .../selftests/kvm/include/x86_64/processor.h  |  2 ++
> >   .../selftests/kvm/lib/x86_64/processor.c      | 19 ++++++++++++++++--=
-
> >   2 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/t=
ools/testing/selftests/kvm/include/x86_64/processor.h
> > index 0b8855d68744..5c4e9a27d9e2 100644
> > --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> > +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> > @@ -1089,6 +1089,8 @@ struct idt_entry {
> >       uint32_t offset2; uint32_t reserved;
> >   };
> >
> > +void kvm_setup_idt(struct kvm_vm *vm, struct kvm_dtable *dt);
> > +void sync_exception_handlers_to_guest(struct kvm_vm *vm);
> >   void vm_init_descriptor_tables(struct kvm_vm *vm);
> >   void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu);
> >   void vm_install_exception_handler(struct kvm_vm *vm, int vector,
> > diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools=
/testing/selftests/kvm/lib/x86_64/processor.c
> > index b6b9438e0a33..566d82829da4 100644
> > --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> > @@ -1155,19 +1155,32 @@ void vm_init_descriptor_tables(struct kvm_vm *v=
m)
> >                       DEFAULT_CODE_SELECTOR);
> >   }
> >
> > +void kvm_setup_idt(struct kvm_vm *vm, struct kvm_dtable *dt)
> > +{
> > +     if (!vm->idt)
> > +             vm->idt =3D vm_vaddr_alloc_page(vm);
>
> IDT is allocated in DATA memslot in current code, but here, when using
> vm_vaddr_alloc_page(), it will be allocated in TEST_DATA memslot.
>
> Do we need to follow the current code to use
> __vm_vaddr_alloc_page(vm, MEM_REGION_DATA) instead?

This code is no longer needed after Sean's refactor in
"[PATCH 00/18] KVM: selftests: Clean up x86's DT initialization"
https://lore.kernel.org/lkml/20240314232637.2538648-1-seanjc@google.com/

>
> > +
> > +     dt->base =3D vm->idt;
> > +     dt->limit =3D NUM_INTERRUPTS * sizeof(struct idt_entry) - 1;
> > +}
> > +
> > +void sync_exception_handlers_to_guest(struct kvm_vm *vm)
> > +{
> > +     *(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)=
) =3D vm->handlers;
> > +}
> > +
> >   void vcpu_init_descriptor_tables(struct kvm_vcpu *vcpu)
> >   {
> >       struct kvm_vm *vm =3D vcpu->vm;
> >       struct kvm_sregs sregs;
> >
> >       vcpu_sregs_get(vcpu, &sregs);
> > -     sregs.idt.base =3D vm->idt;
> > -     sregs.idt.limit =3D NUM_INTERRUPTS * sizeof(struct idt_entry) - 1=
;
> > +     kvm_setup_idt(vcpu->vm, &sregs.idt);
> >       sregs.gdt.base =3D vm->gdt;
> >       sregs.gdt.limit =3D getpagesize() - 1;
> >       kvm_seg_set_kernel_data_64bit(NULL, DEFAULT_DATA_SELECTOR, &sregs=
.gs);
> >       vcpu_sregs_set(vcpu, &sregs);
> > -     *(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)=
) =3D vm->handlers;
> > +     sync_exception_handlers_to_guest(vm);
> >   }
> >
> >   void vm_install_exception_handler(struct kvm_vm *vm, int vector,
>


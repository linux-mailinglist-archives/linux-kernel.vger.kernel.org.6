Return-Path: <linux-kernel+bounces-268343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E40942368
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6AFB2314C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC711917E8;
	Tue, 30 Jul 2024 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fqryzt65"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCDF14A635
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722382272; cv=none; b=bjXmtpY+N00MWia1aIBtw1CHm6yT0maPczx40IwTb9lhZ+sg9o011/xE3OcPUf0Qlq/kONd6KM8grlAEjkD5Qp8heUXpX+hNjQH/m1/SxwCPp2lwQye8hTEyWHE8Nz9lUOA358Tri+JU2/Syh6m+OCAHR95niKxByIGKHg6JKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722382272; c=relaxed/simple;
	bh=QkGvdR+ItcZxMyQu3kSjm50qT6uU5ENMYoz0Fuoj754=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rVmDpiaTWldmP2KGg/g29ifoA5FtrXdr+WzUU4jhkWQhwep1LSaYV63l2lVBrVMuFepyX+Aeu91NVO4BM4DnqVP3estmKrqg21oKD01ghbrlE1BcUFRTTmlksRQ1m1KzNLOwrtcwv2LsgjPFaKKIr+TFOv5rjQmVhvNBHS7miF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fqryzt65; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66619cb2d3eso104683787b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722382270; x=1722987070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ay6wLs2JALdJRjG2Jl8mKWpqChoz9bwLuBE0bA+gW2Q=;
        b=Fqryzt65+I1Owmn+XIlFK3GxAmQ8tkwxb/2yA6w9iX3OuLgGY93CbiOsisLz7GvCLp
         qkJK48mcPb2Y4gb1PTXtEht1GJLP1FYEcx3NpeazxzXK5+JkCEUtXlap11mRCffgZr+I
         m1gQJxH37i1Lni2IeWqHjGBoEesRGQ1JKVaWRl0hRMAkA1Z55TxCKE4XXIWETfSb/4gG
         Y55WC6CP/oDrjKpka1MBbc1lRwNvU8OILU53rppcjLkMFjK+5qL1pQDzA1tx2Ht7BohF
         4n1wLJlT1yVKCkf0x0OL4JhWhxrm1xS6efm6fD2aNh7Il9DHoRSX0GIqtTuJlEAn8VGf
         Jh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722382270; x=1722987070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ay6wLs2JALdJRjG2Jl8mKWpqChoz9bwLuBE0bA+gW2Q=;
        b=JJz5r2m4L73WfM2h0s4C7x6QtGEm3dFzEeCLhbMo9MWH+2xL7XW7EPU+qBYxcdtzNU
         VZ6KD7jaV399YAw0yRKH44Nks0f4SiY/IE9AOJfKgHoqnKKDgqGWokgcc1vQcVvL+XYL
         i43cSlq3KJIIhEqeJ3YPP90DSJUB0C7miVDRWkP7db/bjLBVrszvmVwPnM+RDGubmWXS
         Ey8AM7LsyFNnw0Resv+EbTpmFm5JzMmVwBXQlhvmOmmDQ64m8zeNlnpDLh8LOFUW0jdn
         Mvmj6lkbFHKkaBaQk63X9iK4UOJg0SLlwG73fztt35r5g4Af4ArMMwHhvHz/TaAjIZ1p
         H6+A==
X-Forwarded-Encrypted: i=1; AJvYcCW+RcrOeD/Iz7zXHnLZFbPWk8lLZ32DLNutoHu9oCcGivTiNlKYtbMevc5KLluHQMd2VCc2jESMv2cmyes=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNh9C9Yw22qwZd6rrVa+k50AJtSoLD5qVbaxDf2f7oOVVSmIYf
	LvjNsk3gjdEqi2l+jeS4z+uyeHCsjFgihkrDsWFDq58CysNPeBZM/yUh7QOsOfphhSnOJC3S7Ur
	wJw==
X-Google-Smtp-Source: AGHT+IG2mF1GG8LrNAxvn4DKukVTRXcvlSZNShOVmgdijzgOOvZgMl6gWvwTJgbmd/3+mdcfqSeUDOejeB4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b04a:0:b0:62c:dce9:6238 with SMTP id
 00721157ae682-67a051ee096mr1032047b3.1.1722382270046; Tue, 30 Jul 2024
 16:31:10 -0700 (PDT)
Date: Tue, 30 Jul 2024 16:31:08 -0700
In-Reply-To: <ccd40ae1-14aa-454e-9620-b34154f03e53@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240730155646.1687-1-will@kernel.org> <ccd40ae1-14aa-454e-9620-b34154f03e53@rbox.co>
Message-ID: <Zql3vMnR86mMvX2w@google.com>
Subject: Re: [PATCH] KVM: Fix error path in kvm_vm_ioctl_create_vcpu() on
 xa_store() failure
From: Sean Christopherson <seanjc@google.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Will Deacon <will@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 30, 2024, Michal Luczaj wrote:
> On 7/30/24 17:56, Will Deacon wrote:
> > If the xa_store() fails in kvm_vm_ioctl_create_vcpu() then we shouldn't
> > drop the reference to the 'struct kvm' because the vCPU fd has been
> > installed and will take care of the refcounting.
> > 
> > This was found by inspection, but forcing the xa_store() to fail
> > confirms the problem:
> > 
> >  | Unable to handle kernel paging request at virtual address ffff800080ecd960
> >  | Call trace:
> >  |  _raw_spin_lock_irq+0x2c/0x70
> >  |  kvm_irqfd_release+0x24/0xa0
> >  |  kvm_vm_release+0x1c/0x38
> >  |  __fput+0x88/0x2ec
> >  |  ____fput+0x10/0x1c
> >  |  task_work_run+0xb0/0xd4
> >  |  do_exit+0x210/0x854
> >  |  do_group_exit+0x70/0x98
> >  |  get_signal+0x6b0/0x73c
> >  |  do_signal+0xa4/0x11e8
> >  |  do_notify_resume+0x60/0x12c
> >  |  el0_svc+0x64/0x68
> >  |  el0t_64_sync_handler+0x84/0xfc
> >  |  el0t_64_sync+0x190/0x194
> >  | Code: b9000909 d503201f 2a1f03e1 52800028 (88e17c08)
> > 
> > Add a new label to the error path so that we can branch directly to the
> > xa_release() if the xa_store() fails.
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Michal Luczaj <mhal@rbox.co>
> > Cc: Alexander Potapenko <glider@google.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  virt/kvm/kvm_main.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index d0788d0a72cc..b80dd8cead8c 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -4293,7 +4293,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
> >  
> >  	if (KVM_BUG_ON(xa_store(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, 0), kvm)) {
> >  		r = -EINVAL;
> > -		goto kvm_put_xa_release;
> > +		goto err_xa_release;
> >  	}
> >  
> >  	/*
> > @@ -4310,6 +4310,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
> >  
> >  kvm_put_xa_release:
> >  	kvm_put_kvm_no_destroy(kvm);
> > +err_xa_release:
> >  	xa_release(&kvm->vcpu_array, vcpu->vcpu_idx);
> >  unlock_vcpu_destroy:
> >  	mutex_unlock(&kvm->lock);
> 
> My bad for neglecting the "impossible" path. Thanks for the fix.
> 
> I wonder if it's complete. If we really want to consider the possibility of
> this xa_store() failing, then keeping vCPU fd installed and calling
> kmem_cache_free(kvm_vcpu_cache, vcpu) on the error path looks wrong.

Yeah, the vCPU is exposed to userspace, freeing its assets will just cause
different problems.  KVM_BUG_ON() will prevent _new_ vCPU ioctl() calls (and kick
running vCPUs out of the guest), but it doesn't interrupt other CPUs, e.g. if
userspace is being sneaking and has already invoked a vCPU ioctl(), KVM will hit
a use-after-free (several of them).

As Michal alluded to, it should be impossible for xa_store() to fail since KVM
pre-allocates/reserves memory.  Given that, deliberately leaking the vCPU seems
like the least awful "solution".


Return-Path: <linux-kernel+bounces-278621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE34D94B283
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26315B21F41
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CC61552ED;
	Wed,  7 Aug 2024 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1h9QXAV1"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3D14901B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067919; cv=none; b=ibVDIH6siW2NDDRwYB9RFoFtgpQ9JIblxWkUxq/fWvlUYLbY3xJUy7+kEcYiPVUDH3zVX1hxvk8JXjFmZvmN3kBNtZvS/smlLKSYSd/GkSbqVqDO2pnnYM6tsUX8RwbqUHzfnLTXH8BIvB3s0EwGqcjYS7TWFzVmoGDNCAwW044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067919; c=relaxed/simple;
	bh=c08WaZBC8OmswkebMYegQBqCu6JB2zC4KsS+DBX2LfE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EMQggiramdnS9ALxm6Ii22Rwo/bg6e/fJcwNFqVeGJdc9zRWP98MFrZgtmq/dJ4D5buiQRdj0tIiNe5N5KxGVe7WVR+0TBu5+FeVaJ/H6eaQE0kuHqTig4etycvT4NN2QZKhKQ28uaUekJC48c4Nul1jWDH5weOEYhHUrkj8uts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1h9QXAV1; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-778702b9f8fso155583a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723067917; x=1723672717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Geo7mE7Px+nMYERQfpI51YnWlkJ5yKR6d+PPNKtIfZQ=;
        b=1h9QXAV1Irw1QSzpeqV+TQWks+Rhmd9eCuMy5Gqs+dcyUZ4AdC4qiR5Tz/G+iriDCo
         0n5VMiVYP6DcuPSolS5eQwJwrCs6mrA6tgt3DnIYj8IcMqyYSiHhT2ceZ60LQ5seFCFJ
         0Qi3868ODZ8oR+IAFMeY1ACsgFydz0B5qXTLkCJZ5YLJzdsBkK8nTJ5kOmB9SeDgdTS7
         5MI06yNZ53EO/y8XzBIswEk70DiMw9bq+yovnVf2Ty+X2+C7XcSObZgL/WJ1uLC3LRp5
         aw3FgjMm3vE3V7pk6lgek+dfLStFHLnSkWxkifq7iOkCDWGncdBAmIcAvW4ngsSvgMFL
         qwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723067917; x=1723672717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Geo7mE7Px+nMYERQfpI51YnWlkJ5yKR6d+PPNKtIfZQ=;
        b=g+1a218OwcFuhoZhMHlncuk+AJiJqSAclKRRAg5TyFenQVNzbhMK+LeG27/yDJ6h45
         yc55JCrV5oMmq78gruzxCQgY+SmW9+w8j68QvskWlcEqwwcNdZk5fs+EdI4DDgdvtFU4
         Y59ULQxp1bEVFHm0xsyjpFyQrNbpPpfMVGkbkEv3DgFqMf4UzypIiv3cGicUkQUI2OOe
         L+AW7Omnx3Mk2B32NL8QeStOo6VeHxZo4xSuwQyXgopjh8V31K6uvhbPnjEMsp3qRlLi
         cFJenZxZV6JiC4RAAxa1/oLdyKmzYsY4wKBfWExE040c87bVglmjMxhRNNEU5uppe6mt
         XsXg==
X-Forwarded-Encrypted: i=1; AJvYcCU5aigREKcfZ/ZPDe8tlAUqbq9//dCvRGrh58NMU8M2gX2iSqfvt3K6lK95Z1KZpQ+U2Qhf3Vs6K+4L7pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQoUfEieAv2rDepDVY1I9Qfk9uVU+TvD9FTxbGp0wsFnDFzNcl
	cdjXuHcPOtpKE0amUK0CQoZyjBvqWdbua/1215r899HEyTszDUi+tu5rvWCyKu2XP+nGMFFG5dh
	4pw==
X-Google-Smtp-Source: AGHT+IGT4yfaQtCszwo3v/BQf+VsEDoi91mBnnPGweFALLFNPlxrCzIoFqDGdSNEdxfNC5erws8GJco3fog=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:935a:0:b0:702:4fb6:8724 with SMTP id
 41be03b00d2f7-7c11124f056mr7890a12.1.1723067917038; Wed, 07 Aug 2024 14:58:37
 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:58:35 -0700
In-Reply-To: <b0c3552b-1efd-4c48-8d86-91ee16e7222a@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240730155646.1687-1-will@kernel.org> <ccd40ae1-14aa-454e-9620-b34154f03e53@rbox.co>
 <Zql3vMnR86mMvX2w@google.com> <20240731133118.GA2946@willie-the-truck>
 <3e5f7422-43ce-44d4-bff7-cc02165f08c0@rbox.co> <Zqpj8M3xhPwSVYHY@google.com>
 <20240801124131.GA4730@willie-the-truck> <07987fc3-5c47-4e77-956c-dae4bdf4bc2b@rbox.co>
 <ZrFYsSPaDWUHOl0N@google.com> <b0c3552b-1efd-4c48-8d86-91ee16e7222a@rbox.co>
Message-ID: <ZrPuC59gatPJ4UzQ@google.com>
Subject: Re: [PATCH] KVM: Fix error path in kvm_vm_ioctl_create_vcpu() on
 xa_store() failure
From: Sean Christopherson <seanjc@google.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Will Deacon <will@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 06, 2024, Michal Luczaj wrote:
> On 8/6/24 00:56, Sean Christopherson wrote:
> > [...]
> > +	/*
> > +	 * xa_store() should never fail, see xa_reserve() above.  Leak the vCPU
> > +	 * if the impossible happens, as userspace already has access to the
> > +	 * vCPU, i.e. freeing the vCPU before userspace puts its file reference
> > +	 * would trigger a use-after-free.
> > +	 */
> >  	if (KVM_BUG_ON(xa_store(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, 0), kvm)) {
> > -		r = -EINVAL;
> > -		goto kvm_put_xa_release;
> > +		mutex_unlock(&vcpu->mutex);
> > +		return -EINVAL;
> >  	}
> >  
> >  	/*
> > @@ -4302,6 +4310,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
> >  	 */
> >  	smp_wmb();
> >  	atomic_inc(&kvm->online_vcpus);
> > +	mutex_unlock(&vcpu->mutex);
> >  
> >  	mutex_unlock(&kvm->lock);
> >  	kvm_arch_vcpu_postcreate(vcpu);
> > @@ -4309,6 +4318,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
> >  	return r;
> >  
> >  kvm_put_xa_release:
> > +	mutex_unlock(&vcpu->mutex);
> >  	kvm_put_kvm_no_destroy(kvm);
> >  	xa_release(&kvm->vcpu_array, vcpu->vcpu_idx);
> 
> Since we're handling the impossible, isn't the BUG_ON part missing
> mutex_unlock(&kvm->lock)?

Doh, yes.


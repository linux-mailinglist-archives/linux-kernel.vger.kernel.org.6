Return-Path: <linux-kernel+bounces-275440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5035A9485C2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83C71F245D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1415E16C680;
	Mon,  5 Aug 2024 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1Oh7drr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F8142E70
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722898944; cv=none; b=iGCPm1kdZNDQYeclfsljTgpm0RFK2Cmi/XBfbu94wknLDddinIIbgMDroWklMQaWeJIeghb0rRhhsyirAPvXBlvIqCQpiVXg1VvNFt4BuHfwv7lhNz4raz7TG5bXPUvG9ouVSrlcSUP9QDTXe9v6wT4FnZfi5Ap6/3alfbs8gmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722898944; c=relaxed/simple;
	bh=b/M23ple/0uWywkL6o3Uzu4J9Xa2wL24R0VMTNpFj8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/Ck06qfp5c8HWlxhb7goDMCeBEvoX6QLbgriL4xoZqjf+Jfe/XEs6PvxFsPtwi18vtA1LT646j27bYMuVYIWz7IJYBGffuYVwVD2Bef6sldJrweXHkY6CG9ORmVfRrfIA1p358oTf5TW3sOLHaK5Cj5PXJUyU3lXiq0qNWu9aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1Oh7drr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722898941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5GnfLWKG7h6fFrgWxAUA2aZXk1eJ4qRRj94U3Krgmk=;
	b=M1Oh7drryTzoud3V0w4Ysr0j6lqoOqT5rOFcX6x1kjlwnmIdgodigAlgqIV7pAeX0mPzy8
	CQZrc92mCl/mm5mcE59lykv9bimBNGvspAfH4nOqc9zMu6GZ31FxPkigO6yewic7qKKWFL
	XC5Mlr4Di2DD+rqaBKOFILoPRoe4/Y0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-OHCp21zMPvO9N1_lraJFVg-1; Mon, 05 Aug 2024 19:02:19 -0400
X-MC-Unique: OHCp21zMPvO9N1_lraJFVg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36863648335so5447449f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 16:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722898937; x=1723503737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5GnfLWKG7h6fFrgWxAUA2aZXk1eJ4qRRj94U3Krgmk=;
        b=vt2yX2nWNwucnT2685MwKS0y+Lee65g6ROqOo1r7WU8EO4MD6GYCRghPHwRdpxryuY
         XSIrm3RhuLpFQN3M0j5I1NL8bJc4w6361JgZVUSiOtI7c22VjcXomuoNDljLt2sjLoC7
         OqcfZ3UEURNS4leKWUh/uzFngKO4BZAZqfv0VnCIyQagBfcVtUSUZDrmgzZxelRZzHqU
         ifE7a7YU+crPVP1Kt4+CCIAZrDylSDeRoB2gfqN4G3o/uQ7hc6RAKppyWvhQyOIjEar1
         rzwApNFa18hlOp/5elii16uLlf6zkOUd9N0E0+zhhvu2O4H/K9ltPa/T0BCz5NGQhKsa
         fTIA==
X-Forwarded-Encrypted: i=1; AJvYcCWCLP3xLeEjio3fy0sFOkeK/f+gkudIHDi9DSqRZe6q/bwcLWWGgIwp+8LvOGFtXfpo86fObQejffWZO0L2mJlFNoIoakHoKqPl2fJs
X-Gm-Message-State: AOJu0YxuP8M87+AhwPVkk+s6F+T/iBSYCgQQXdNorQbNi3zsQxSvLmYq
	CdWP/eqPaB0Q0pcDs08yhNKmK8EVWTcMPFtSph9LUYBC3iQwefSvW55RuJP5/BJxrkw1trzB66W
	vMQfxAL81HiCK8aB+HLizhfk4Iu8ZorgvHL99iOZ5o/G5UXzdKmyfKlBu8kry0gfhWmtte5ODtm
	bfLOEXaccsdYV4oJRT8MXDykVD+6XqKH+HXRmA
X-Received: by 2002:a5d:6ac1:0:b0:368:3731:1614 with SMTP id ffacd0b85a97d-36bbc1011e9mr8248274f8f.32.1722898937575;
        Mon, 05 Aug 2024 16:02:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH74ylnE/BhxmQevxRtapsNk/fxZfcG0Ea7DzoV2Gxnnnr62q1iTr69ZKhDX/wyxBSmYl4hRaASNNxrbTylqBs=
X-Received: by 2002:a5d:6ac1:0:b0:368:3731:1614 with SMTP id
 ffacd0b85a97d-36bbc1011e9mr8248258f8f.32.1722898937120; Mon, 05 Aug 2024
 16:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730155646.1687-1-will@kernel.org> <ccd40ae1-14aa-454e-9620-b34154f03e53@rbox.co>
 <Zql3vMnR86mMvX2w@google.com> <20240731133118.GA2946@willie-the-truck>
 <3e5f7422-43ce-44d4-bff7-cc02165f08c0@rbox.co> <Zqpj8M3xhPwSVYHY@google.com>
 <20240801124131.GA4730@willie-the-truck> <07987fc3-5c47-4e77-956c-dae4bdf4bc2b@rbox.co>
 <ZrFYsSPaDWUHOl0N@google.com>
In-Reply-To: <ZrFYsSPaDWUHOl0N@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 6 Aug 2024 01:02:02 +0200
Message-ID: <CABgObfYK4Z6hpo5fh8U8QHtbx4-T32keSF+w=JXaYqsBmFfuMg@mail.gmail.com>
Subject: Re: [PATCH] KVM: Fix error path in kvm_vm_ioctl_create_vcpu() on
 xa_store() failure
To: Sean Christopherson <seanjc@google.com>
Cc: Michal Luczaj <mhal@rbox.co>, Will Deacon <will@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 12:56=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> +       if (unlikely(vcpu->vcpu_idx < atomic_read(&kvm->online_vcpus)))
> +               return -EINVAL;

+1 to having the test _somewhere_ for async ioctls, there's so much
that can go wrong if a vcpu is not reachable by for_each_vcpu.

>         /*
>          * Some architectures have vcpu ioctls that are asynchronous to v=
cpu
>          * execution; mutex_lock() would break them.
>
> The mutex approach, sans async ioctl support:

Async ioctls can be handled as you suggested above by checking
vcpu_idx against online_vcpus. This mutex approach also removes the
funky lock/unlock to inform lockdep, which is a nice plus.

Paolo

> ---
>  virt/kvm/kvm_main.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index d0788d0a72cc..0a9c390b18a3 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4269,12 +4269,6 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kv=
m, unsigned long id)
>
>         mutex_lock(&kvm->lock);
>
> -#ifdef CONFIG_LOCKDEP
> -       /* Ensure that lockdep knows vcpu->mutex is taken *inside* kvm->l=
ock */
> -       mutex_lock(&vcpu->mutex);
> -       mutex_unlock(&vcpu->mutex);
> -#endif
> -
>         if (kvm_get_vcpu_by_id(kvm, id)) {
>                 r =3D -EEXIST;
>                 goto unlock_vcpu_destroy;
> @@ -4285,15 +4279,29 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *k=
vm, unsigned long id)
>         if (r)
>                 goto unlock_vcpu_destroy;
>
> -       /* Now it's all set up, let userspace reach it */
> +       /*
> +        * Now it's all set up, let userspace reach it.  Grab the vCPU's =
mutex
> +        * so that userspace can't invoke vCPU ioctl()s until the vCPU is=
 fully
> +        * visibile (per online_vcpus), e.g. so that KVM doesn't get tric=
ked
> +        * into a NULL-pointer dereference because KVM thinks the _curren=
t_
> +        * vCPU doesn't exist.  As a bonus, taking vcpu->mutex ensures lo=
ckdep
> +        * knows it's taken *inside* kvm->lock.
> +        */
> +       mutex_lock(&vcpu->mutex);
>         kvm_get_kvm(kvm);
>         r =3D create_vcpu_fd(vcpu);
>         if (r < 0)
>                 goto kvm_put_xa_release;
>
> +       /*
> +        * xa_store() should never fail, see xa_reserve() above.  Leak th=
e vCPU
> +        * if the impossible happens, as userspace already has access to =
the
> +        * vCPU, i.e. freeing the vCPU before userspace puts its file ref=
erence
> +        * would trigger a use-after-free.
> +        */
>         if (KVM_BUG_ON(xa_store(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, 0=
), kvm)) {
> -               r =3D -EINVAL;
> -               goto kvm_put_xa_release;
> +               mutex_unlock(&vcpu->mutex);
> +               return -EINVAL;
>         }
>
>         /*
> @@ -4302,6 +4310,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm=
, unsigned long id)
>          */
>         smp_wmb();
>         atomic_inc(&kvm->online_vcpus);
> +       mutex_unlock(&vcpu->mutex);
>
>         mutex_unlock(&kvm->lock);
>         kvm_arch_vcpu_postcreate(vcpu);
> @@ -4309,6 +4318,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm=
, unsigned long id)
>         return r;
>
>  kvm_put_xa_release:
> +       mutex_unlock(&vcpu->mutex);
>         kvm_put_kvm_no_destroy(kvm);
>         xa_release(&kvm->vcpu_array, vcpu->vcpu_idx);
>  unlock_vcpu_destroy:
>
> base-commit: 332d2c1d713e232e163386c35a3ba0c1b90df83f
> --
>



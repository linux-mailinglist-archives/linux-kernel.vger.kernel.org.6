Return-Path: <linux-kernel+bounces-273080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFFF946460
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FAF1F21A30
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634E66A33F;
	Fri,  2 Aug 2024 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O0ddN3d7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B656F46B91
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630579; cv=none; b=HX/ydAaT0GypekRbEGMkzxsOs0wjINsmize9JSnSlY6npzqZU5ui/t1eZSDc+dxCEKCfTwn9Zelz0vtywf1DEZSnn131lvR0Xk0nlJLYTio9/+T3VMz5QXnkj/BhBX0HcWNjAjZ+U69mWpxa6W/Me8ElE10u7Rz4/U7axapzNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630579; c=relaxed/simple;
	bh=CMki9I2Y5hDPbvNKXl8/tTfJe8Wm9//Xu6+W9DDmr6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5PMZyOcdhqYiuhvj18jSvMeNM/eUFHl/lo9liUfgg73XV8zb5devQd3XhFAFeDrbzs6oirf/5i3wOPxYZHK3k4EJ30vD17DPXzBbgxUoUrDstdE0QVYGM6eODvywF13R//qHss7w2cR/T8OjdwXMUypyLxKkWctR2WHuPrwK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O0ddN3d7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efc82c872so14820e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722630576; x=1723235376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2uDO9ShPfNpZoAJ6K9acrrg1s8RVj7WAqg5LH0JB1k=;
        b=O0ddN3d7Bq2vTC+wpMCvnlPFrd+fqkb9tStXhjEpsGSV2e61EnXSW6SCWQ7ocFN3ui
         xQA1ZPCD90S6FilcaeRqIHyf7nXPF37VRantZtunX4FUSGBPSjdwiZdqulK7I5vQANiA
         gCcQ7eQNQmR8QB9ctIFszeQWGQDzWiXThOpNvUd+2RYX0VrpmwQRhtzxQB3/RsIPKzb+
         vyd5LqOG/te52XxpjsQWw8Z3MA9X9STVJ3O2SxDNKBB8maEAgd0W8/r2Yi8MlKHpkN6f
         nyiVyF7qVjBxGHA6WCQOK6x3rHrbXLfkZj0rG12OCVWJIvP8FxaVtVSurQUuXcKMjWup
         9wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722630576; x=1723235376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2uDO9ShPfNpZoAJ6K9acrrg1s8RVj7WAqg5LH0JB1k=;
        b=WAnm38Ld0v4b5w7gf8iEFUBqIoPOg4euq5PiwkSIOjgerxF8iC2LOjM3n3VT7PZwBS
         W6o8juvLVVh5gz4cJkWGuKxzpEd76LFICjNFUoQFzAbzK1hprhGARwf6Y9Wh/8jV/a3X
         3vqpSjXGhBZAdCbZgxorEYF1VKCmch1iEDsqHCG4TT/1JyhJHU+j8qNuV5baJQ1vsjr+
         91KIcVG0RpBkfgbnscuW6aWIJ5gP9kXqb9PeWGY/l6GwNFelQidN/xth2aLDKN4UaMpI
         gAV3iAOO5PUGX+riEIh4JBMNx0jMPgRCvvNy1k/LoKJppT8uEDOLHOFHIeEgU23drzmu
         DBJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQoodTEpg2U9qaNKt4p5vy77v9mS3itlUszeDfVU67T7czdTOUOEyFYIAVj9SwbhLnaLkfSs2HR+CCOVPJW2o4qUiT6aoeaiKY8SiV
X-Gm-Message-State: AOJu0YzTbpqld/M56jF6eyczVpqIOSB+mFXoe9fnQ0HhdzmKSRk+fS3C
	t+t+XEow0RYSXKDodAvBIcSrCk5/yp0MSZrJthfSfUQGeTzz+2wqNsPiS1iKKhoacvHyHahFcNo
	JqGrJdSWXn1Xt95dsmF5BmbZ6kS/XCVKWK2Pf
X-Google-Smtp-Source: AGHT+IFVMP6/AIADLfhzpRRtoWiEvCdz1UG4nR4KuW4rmv8Vt8+GJoT3o9txbVT3Dv1Y4rdQE3zf0+OrJwZBdgLqa1U=
X-Received: by 2002:a05:6512:3d0b:b0:52c:b243:cd02 with SMTP id
 2adb3069b0e04-530c46d7982mr6068e87.1.1722630575181; Fri, 02 Aug 2024 13:29:35
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802200136.329973-1-seanjc@google.com> <20240802200136.329973-3-seanjc@google.com>
In-Reply-To: <20240802200136.329973-3-seanjc@google.com>
From: Steve Rutherford <srutherford@google.com>
Date: Fri, 2 Aug 2024 13:28:56 -0700
Message-ID: <CABayD+dHLXwQK3YdwVi6raf+CF3XOaAiAG+tfDYPiZFzqeVXpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: Protect vCPU's "last run PID" with rwlock, not RCU
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 1:01=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> To avoid jitter on KVM_RUN due to synchronize_rcu(), use a rwlock instead
> of RCU to protect vcpu->pid, a.k.a. the pid of the task last used to a
> vCPU.  When userspace is doing M:N scheduling of tasks to vCPUs, e.g. to
> run SEV migration helper vCPUs during post-copy, the synchronize_rcu()
> needed to change the PID associated with the vCPU can stall for hundreds
> of milliseconds, which is problematic for latency sensitive post-copy
> operations.
>
> In the directed yield path, do not acquire the lock if it's contended,
> i.e. if the associated PID is changing, as that means the vCPU's task is
> already running.
>
> Reported-by: Steve Rutherford <srutherford@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |  2 +-
>  include/linux/kvm_host.h          |  3 ++-
>  virt/kvm/kvm_main.c               | 32 +++++++++++++++++--------------
>  3 files changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/k=
vm_host.h
> index a33f5996ca9f..7199cb014806 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -1115,7 +1115,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu=
,
>  void kvm_arm_halt_guest(struct kvm *kvm);
>  void kvm_arm_resume_guest(struct kvm *kvm);
>
> -#define vcpu_has_run_once(vcpu)        !!rcu_access_pointer((vcpu)->pid)
> +#define vcpu_has_run_once(vcpu)        (!!READ_ONCE((vcpu)->pid))
>
>  #ifndef __KVM_NVHE_HYPERVISOR__
>  #define kvm_call_hyp_nvhe(f, ...)                                       =
       \
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 689e8be873a7..d6f4e8b2b44c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -342,7 +342,8 @@ struct kvm_vcpu {
>  #ifndef __KVM_HAVE_ARCH_WQP
>         struct rcuwait wait;
>  #endif
> -       struct pid __rcu *pid;
> +       struct pid *pid;
> +       rwlock_t pid_lock;
>         int sigset_active;
>         sigset_t sigset;
>         unsigned int halt_poll_ns;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 91048a7ad3be..fabffd85fa34 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -486,6 +486,7 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, stru=
ct kvm *kvm, unsigned id)
>         vcpu->kvm =3D kvm;
>         vcpu->vcpu_id =3D id;
>         vcpu->pid =3D NULL;
> +       rwlock_init(&vcpu->pid_lock);
>  #ifndef __KVM_HAVE_ARCH_WQP
>         rcuwait_init(&vcpu->wait);
>  #endif
> @@ -513,7 +514,7 @@ static void kvm_vcpu_destroy(struct kvm_vcpu *vcpu)
>          * the vcpu->pid pointer, and at destruction time all file descri=
ptors
>          * are already gone.
>          */
> -       put_pid(rcu_dereference_protected(vcpu->pid, 1));
> +       put_pid(vcpu->pid);
>
>         free_page((unsigned long)vcpu->run);
>         kmem_cache_free(kvm_vcpu_cache, vcpu);
> @@ -3930,15 +3931,17 @@ EXPORT_SYMBOL_GPL(kvm_vcpu_kick);
>
>  int kvm_vcpu_yield_to(struct kvm_vcpu *target)
>  {
> -       struct pid *pid;
>         struct task_struct *task =3D NULL;
>         int ret;
>
> -       rcu_read_lock();
> -       pid =3D rcu_dereference(target->pid);
> -       if (pid)
> -               task =3D get_pid_task(pid, PIDTYPE_PID);
> -       rcu_read_unlock();
> +       if (!read_trylock(&target->pid_lock))
> +               return 0;
> +
> +       if (target->pid)
> +               task =3D get_pid_task(target->pid, PIDTYPE_PID);
> +
> +       read_unlock(&target->pid_lock);
> +
>         if (!task)
>                 return 0;
>         ret =3D yield_to(task, 1);
> @@ -4178,9 +4181,9 @@ static int vcpu_get_pid(void *data, u64 *val)
>  {
>         struct kvm_vcpu *vcpu =3D data;
>
> -       rcu_read_lock();
> -       *val =3D pid_nr(rcu_dereference(vcpu->pid));
> -       rcu_read_unlock();
> +       read_lock(&vcpu->pid_lock);
> +       *val =3D pid_nr(vcpu->pid);
> +       read_unlock(&vcpu->pid_lock);
>         return 0;
>  }
>
> @@ -4466,7 +4469,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
>                 r =3D -EINVAL;
>                 if (arg)
>                         goto out;
> -               oldpid =3D rcu_access_pointer(vcpu->pid);
> +               oldpid =3D vcpu->pid;

Overall this patch looks correct, but this spot took me a moment, and
I want to confirm. This skips the reader lock since writing only
happens just below, under the vcpu lock, and we've already taken that
lock?

>                 if (unlikely(oldpid !=3D task_pid(current))) {
>                         /* The thread running this VCPU changed. */
>                         struct pid *newpid;
> @@ -4476,9 +4479,10 @@ static long kvm_vcpu_ioctl(struct file *filp,
>                                 break;
>
>                         newpid =3D get_task_pid(current, PIDTYPE_PID);
> -                       rcu_assign_pointer(vcpu->pid, newpid);
> -                       if (oldpid)
> -                               synchronize_rcu();
> +                       write_lock(&vcpu->pid_lock);
> +                       vcpu->pid =3D newpid;
> +                       write_unlock(&vcpu->pid_lock);
> +
>                         put_pid(oldpid);
>                 }
>                 vcpu->wants_to_run =3D !READ_ONCE(vcpu->run->immediate_ex=
it__unsafe);
> --
> 2.46.0.rc2.264.g509ed76dc8-goog
>


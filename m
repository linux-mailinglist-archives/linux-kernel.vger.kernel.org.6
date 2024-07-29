Return-Path: <linux-kernel+bounces-265245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B9293EE61
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2462F1F217A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5461272A7;
	Mon, 29 Jul 2024 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GxAhRp9b"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8319E84A21
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722237989; cv=none; b=O66zwWEJaetz8Fx9it+BQUZK+Ito95gKGNz8O+TISvazHtBmEahfPAKiHAn3T2nxvt/rV9Do7Ia6k3JhCV8A/5S2prXZ8ZeuVlYKKdQxhiAcQioZCYRLykoB54QrlrfsKqzRH9RrSOl/JXJs7sBE919Ui8/aW37nIX0sLEGIWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722237989; c=relaxed/simple;
	bh=2hKEZgm5/EE5wIeD8w9GbGX7uU/DWHZu0LlH9PopXKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxvwwqMFoE7isOzZ5zzxhA1AMkb1du+657KviH+BXIkACndTY98qQ1I1o1aPSBfuYT1GgRlXOSLsyxXOkAUFHhf9pa19UOhibyN0x3efaK6RzhGqB3L3tBxNi3hAp9JsXh58g9u5CNv+CtzMrD8O0xP2AxKsVsxoIkyemAwJ0w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GxAhRp9b; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4f6bd3a7bbdso1475390e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 00:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722237986; x=1722842786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCebpCWNKlXe6DpILlIFO1QGAoyqFmV8Q7GN3Vo8R20=;
        b=GxAhRp9bf22jGr/2U51usbxgjWV9AxUudYitxPYcfh3u1gXkWjCysjXU+37zxkdfKA
         Wd8SWs/n7sYFTFR1gP6RjXi+MUwgXRHboMLFB24/Ezl9USIocG5Tj6Y1GJ7u+ba/imX8
         0RYKwPHg6XBAtbIXUqQlOAatWoXABFvBptS2O9ql8DKTpdwxFlHaONOqPEu08O+B0ML4
         e8HD+NLx7U1iYt0en3lY7MosuFznCtNThTHo5LcesSCSlDntderuTjrH+czEYjn0PY6w
         n1uunnt5DoiW5U1fC+LKLTN+rdUp4L2Yxy4gCK2eLDmSZLNwpsBppJZ00rl3u+dDI2yu
         80jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722237986; x=1722842786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCebpCWNKlXe6DpILlIFO1QGAoyqFmV8Q7GN3Vo8R20=;
        b=Ywdodvnogme1I1hTpmXm3DDZmIBfNv6tKPTchojTRhIPI/Iesmx1JFRFHCIAkhG6or
         pAvdlA4hrrDa1/jdqfx7e49Ihqicyz+6zMvaEzN1Sj03VOIGyubBVNz92ts9LYxx6ZRp
         IiVIkr9S+cH617kKaDpCIOBvVTTSJjYb1T/9I+U8JvWNdEA7juC2bKg+7hI3unNiV+Yl
         bziMJ+qLOGvL5x2ypQTJl+bHtXf7ima3piB071FlLcn7rs2k3lda/mGnszCpe7wTTBJ1
         MIRUpqqsV59LPev/S0/3Q2sdR8l/kZ+JoJ22OqWN8DbWdBiOPPBbISm/zm6XTzkklihE
         Oeyg==
X-Forwarded-Encrypted: i=1; AJvYcCV7OeOq4aFWspekHLiIX9EJjuQwyL03/5dVr0MsTU+Fr/L5nZTTgGYfdu6VBz8uldUhgQEKwyLv5iQ1SM2enzxHQrvXlM03xYl4t5Pz
X-Gm-Message-State: AOJu0YxDRvR2NVJyqZWhew6GsiDVIjkSJWwdejFwSBbNQjbd8JW10TQd
	ZOIgqAlvAew5ATn/lewdLJGx45ta/EnBnPr8JVirdQUj7VlPFerjvWC2mK4EciYUQfMuslpVH8Y
	cHUv7SEA8OezYjUBDwfFxNv13p6DYD1uRfPgY
X-Google-Smtp-Source: AGHT+IHSR0Z7VG3kt7Ncu0q2ap3y0qVXAQRK8G3Cyts4am3bFQAfPjRYFqYj85H9qo+HqKNpEzuIIA7fKt3FeMTJw8g=
X-Received: by 2002:a05:6122:1aca:b0:4f6:ae65:1e10 with SMTP id
 71dfb90a1353d-4f6e68d4398mr7427802e0c.4.1722237986227; Mon, 29 Jul 2024
 00:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710074410.770409-1-suleiman@google.com>
In-Reply-To: <20240710074410.770409-1-suleiman@google.com>
From: Suleiman Souhlal <suleiman@google.com>
Date: Mon, 29 Jul 2024 16:26:15 +0900
Message-ID: <CABCjUKAD=L0jcQcoj_5608EidAZDdRcPPHqZhvVXxHf5__FtiQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Include host suspended time in steal time.
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: ssouhlal@freebsd.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jul 10, 2024 at 4:44=E2=80=AFPM Suleiman Souhlal <suleiman@google.c=
om> wrote:
>
> When the host resumes from a suspend, the guest thinks any task
> that was running during the suspend ran for a long time, even though
> the effective run time was much shorter, which can end up having
> negative effects with scheduling. This can be particularly noticeable
> if the guest task was RT, as it can end up getting throttled for a
> long time.
>
> To mitigate this issue, we include the time that the host was
> suspended in steal time, which lets the guest can subtract the
> duration from the tasks' runtime.
>
> Signed-off-by: Suleiman Souhlal <suleiman@google.com>
> ---
>  arch/x86/kvm/x86.c       | 23 ++++++++++++++++++++++-
>  include/linux/kvm_host.h |  4 ++++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0763a0f72a067f..94bbdeef843863 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3669,7 +3669,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu=
)
>         struct kvm_steal_time __user *st;
>         struct kvm_memslots *slots;
>         gpa_t gpa =3D vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
> -       u64 steal;
> +       u64 steal, suspend_duration;
>         u32 version;
>
>         if (kvm_xen_msr_enabled(vcpu->kvm)) {
> @@ -3696,6 +3696,12 @@ static void record_steal_time(struct kvm_vcpu *vcp=
u)
>                         return;
>         }
>
> +       suspend_duration =3D 0;
> +       if (READ_ONCE(vcpu->suspended)) {
> +               suspend_duration =3D vcpu->kvm->last_suspend_duration;
> +               vcpu->suspended =3D 0;
> +       }
> +
>         st =3D (struct kvm_steal_time __user *)ghc->hva;
>         /*
>          * Doing a TLB flush here, on the guest's behalf, can avoid
> @@ -3749,6 +3755,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu=
)
>         unsafe_get_user(steal, &st->steal, out);
>         steal +=3D current->sched_info.run_delay -
>                 vcpu->arch.st.last_steal;
> +       steal +=3D suspend_duration;
>         vcpu->arch.st.last_steal =3D current->sched_info.run_delay;
>         unsafe_put_user(steal, &st->steal, out);
>
> @@ -6920,6 +6927,7 @@ static int kvm_arch_suspend_notifier(struct kvm *kv=
m)
>
>         mutex_lock(&kvm->lock);
>         kvm_for_each_vcpu(i, vcpu, kvm) {
> +               WRITE_ONCE(vcpu->suspended, 1);
>                 if (!vcpu->arch.pv_time.active)
>                         continue;
>
> @@ -6932,15 +6940,28 @@ static int kvm_arch_suspend_notifier(struct kvm *=
kvm)
>         }
>         mutex_unlock(&kvm->lock);
>
> +       kvm->suspended_time =3D ktime_get_boottime_ns();
> +
>         return ret ? NOTIFY_BAD : NOTIFY_DONE;
>  }
>
> +static int
> +kvm_arch_resume_notifier(struct kvm *kvm)
> +{
> +       kvm->last_suspend_duration =3D ktime_get_boottime_ns() -
> +           kvm->suspended_time;
> +       return NOTIFY_DONE;
> +}
> +
>  int kvm_arch_pm_notifier(struct kvm *kvm, unsigned long state)
>  {
>         switch (state) {
>         case PM_HIBERNATION_PREPARE:
>         case PM_SUSPEND_PREPARE:
>                 return kvm_arch_suspend_notifier(kvm);
> +       case PM_POST_HIBERNATION:
> +       case PM_POST_SUSPEND:
> +               return kvm_arch_resume_notifier(kvm);
>         }
>
>         return NOTIFY_DONE;
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 692c01e41a18ef..2d37af9a348648 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -366,6 +366,8 @@ struct kvm_vcpu {
>         } async_pf;
>  #endif
>
> +       bool suspended;
> +
>  #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
>         /*
>          * Cpu relax intercept or pause loop exit optimization
> @@ -840,6 +842,8 @@ struct kvm {
>         struct xarray mem_attr_array;
>  #endif
>         char stats_id[KVM_STATS_NAME_SIZE];
> +       u64 last_suspend_duration;
> +       u64 suspended_time;
>  };
>
>  #define kvm_err(fmt, ...) \
> --
> 2.45.2.993.g49e7a77208-goog
>

Gentle ping.

Thanks,
-- Suleiman


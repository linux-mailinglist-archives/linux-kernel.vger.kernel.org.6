Return-Path: <linux-kernel+bounces-544197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4D1A4DE95
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8285B1896A89
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555C51FF1DA;
	Tue,  4 Mar 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6t/bJdu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C54D944F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093215; cv=none; b=jn24Qve/3Bj6pC5fkErAPRnW+I38yjxEQBITMI6Z88XBHA0/JtUheRtR/y1VO0fbj4z2ueXmzrsktUHpOO0g9QVGi1NmpYA+xBkskf5xVrqvaBPRjLSMHtMw+aO14UiXv0I9rz0RP+f8Y5osh+4ghlgpdISTumYbjug4P8dAVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093215; c=relaxed/simple;
	bh=8n0b19N4k88oTV+0CWK8ErwPE6M+xXUkDhITJJVj73Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JfVrNd/pOIdij6tDzMXPrs6na++ARzxiOlpgz6mhVY+bsnSnKYtC7739r8Wo+aFXHRGTX1WmGb4687bzO+Sjzfj4cRyhjfIZdQaXXYm0eIf4CzHWi0hjrAoE/Wh+eZfbxuWiKWg0BAcC9Z8I9drdNRFT9yVcxcUaRmmeqaStlbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6t/bJdu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741093212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DHYNfO7wOdQLmm55pmQOPH3dGtE2gZNcuaLKTm02ejc=;
	b=i6t/bJdu8Q2t+SLkRUyb5Z4qmMgLpb/ZjbKqW2ABNJM5jv8euAunR2amf9X5wdVaOjc4m9
	FBHU4iKcVgWqfkOZHUhvmlr+NoP+ll0/cgxNHfGadvCAEbjSEklbnkMtONQ9ksCQBMFqDP
	FPDkuGMqB4mL2QX5EHMUGWmEx01cpB4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-my0CRGQtOLKvcjVHgEE1QQ-1; Tue, 04 Mar 2025 07:59:56 -0500
X-MC-Unique: my0CRGQtOLKvcjVHgEE1QQ-1
X-Mimecast-MFC-AGG-ID: my0CRGQtOLKvcjVHgEE1QQ_1741093195
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390f7db84faso2607997f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 04:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741093195; x=1741697995;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHYNfO7wOdQLmm55pmQOPH3dGtE2gZNcuaLKTm02ejc=;
        b=vb61eWhbpilm/lvCA7Fgq8/bFUvZGNo5q+zGZK5zMRU5C2ClbXi4Re1uhVnDL9dCel
         dJwscRENNCmLHNqNnwTXYrh5u67B8g9zK58kFSHvNnMiNaICZWGnX74vGIA+faysIulU
         L9jDrkJ5UwwO9RJDijfz1kJfLOg3yigr+ui3OQX7RLd5g2fA5TN2CKaMsGa1sFn0kFs8
         2O0rv5GFJVf3Ly1DjM5iVvVtKBwCVmVHkd9DHQ3CLU64ewMHia67brbINBNvTGyX84RX
         HBlD9HL9GGalquWqDbUqPC/zLf6Vi7GMmhLzVpr+rzHwVYD9D7aaK6JOXC2v2qeOYn8v
         efxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBnlQsjoRghXmC0B1JM0gI/iZLwT6dLaMCpjh3oW9tJANfVgCeeFbrKOGXxrWmDGubyemZ3XjOcfWfQV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8kQBzppiq2ETbtcjCeGZ2HFKtgiPIe2cRt/SaM0Lk+N+l/HdT
	psbcaqE7Qq9mRJHsXzFbHzygUClVq1H3BhwQ+slUTvBVGkuokIcld8E71Qx7U7tiItjvHDQc8aW
	jWbJG6LKiFSA9TFxicjRcERKQbjlv58u0nRw2mi0+hzEF0HixpWmspX6COZrTRw==
X-Gm-Gg: ASbGnctbYxEscjbqnPgCAZz/0xHqoJHkV2r8Z4/Lf1FDTuvehnnIgZUIzF2aUfKaECw
	l/bt/V1eKVDSVKPFCifi7uon9jD8okf+0aQMfAgiipoCPnKQyobtF5gmFH1R6L8ZbGa/JtgDuWu
	ytCHOQi4x3TPEVAaZShV/Et21fQGSA0J+Kq1w5r0vwUQOyDGWM/JvvLfGNDAFsUkf92v2p9KYfv
	rILskMivRgzsIYymbV9ms8f1OGkS78a7EmcvnXXfQ9KoSnOuq8UPrItrYZdprFlImw0jQQZcdsa
	z14JI4HeLhY=
X-Received: by 2002:a5d:64a1:0:b0:38d:dfb8:3679 with SMTP id ffacd0b85a97d-390ec7cdabemr14702336f8f.17.1741093195007;
        Tue, 04 Mar 2025 04:59:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTPRu7i/PFI1l57JUzpOpX55q4Iy6EySkNQ2cm/5kvYEuhBy0AgYK+O3UhK/RTW8R7BHllPg==
X-Received: by 2002:a5d:64a1:0:b0:38d:dfb8:3679 with SMTP id ffacd0b85a97d-390ec7cdabemr14702315f8f.17.1741093194666;
        Tue, 04 Mar 2025 04:59:54 -0800 (PST)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485db77sm17334901f8f.86.2025.03.04.04.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 04:59:54 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Maciej S. Szmigiero
 <maciej.szmigiero@oracle.com>
Subject: Re: QEMU's Hyper-V HV_X64_MSR_EOM is broken with split IRQCHIP
In-Reply-To: <Z8ZBzEJ7--VWKdWd@google.com>
References: <Z8ZBzEJ7--VWKdWd@google.com>
Date: Tue, 04 Mar 2025 13:59:53 +0100
Message-ID: <87ikoposs6.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> FYI, QEMU's Hyper-V emulation of HV_X64_MSR_EOM has been broken since QEMU commit
> c82d9d43ed ("KVM: Kick resamplefd for split kernel irqchip"), as nothing in KVM
> will forward the EOM notification to userspace.  I have no idea if anything in
> QEMU besides hyperv_testdev.c cares.

The only VMBus device in QEMU besides the testdev seems to be Hyper-V
ballooning driver, Cc: Maciej to check whether it's a real problem for
it or not.

>
> The bug is reproducible by running the hyperv_connections KVM-Unit-Test with a
> split IRQCHIP.

Thanks, I can reproduce the problem too.

>
> Hacking QEMU and KVM (see KVM commit 654f1f13ea56 ("kvm: Check irqchip mode before
> assign irqfd") as below gets the test to pass.  Assuming that's not a palatable
> solution, the other options I can think of would be for QEMU to intercept
> HV_X64_MSR_EOM when using a split IRQCHIP, or to modify KVM to do KVM_EXIT_HYPERV_SYNIC
> on writes to HV_X64_MSR_EOM with a split IRQCHIP.

AFAIR, Hyper-V message interface is a fairly generic communication
mechanism which in theory can be used without interrupts at all: the
corresponding SINT can be masked and the guest can be polling for
messages, proccessing them and then writing to HV_X64_MSR_EOM to trigger
delivery on the next queued message. To support this scenario on the
backend, we need to receive HV_X64_MSR_EOM writes regardless of whether
irqchip is split or not. (In theory, we can get away without this by
just checking if pending messages can be delivered upon each vCPU entry
but this can take an undefined amount of time in some scenarios so I
guess we're better off with notifications).

>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index c65b790433..820bc1692e 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2261,10 +2261,9 @@ static int kvm_irqchip_assign_irqfd(KVMState *s, EventNotifier *event,
>               * the INTx slow path).
>               */
>              kvm_resample_fd_insert(virq, resample);
> -        } else {
> -            irqfd.flags |= KVM_IRQFD_FLAG_RESAMPLE;
> -            irqfd.resamplefd = rfd;
>          }
> +        irqfd.flags |= KVM_IRQFD_FLAG_RESAMPLE;
> +        irqfd.resamplefd = rfd;
>      } else if (!assign) {
>          if (kvm_irqchip_is_split()) {
>              kvm_resample_fd_remove(virq);
>
>
> diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
> index 63f66c51975a..0bf85f89eb27 100644
> --- a/arch/x86/kvm/irq.c
> +++ b/arch/x86/kvm/irq.c
> @@ -166,9 +166,7 @@ void __kvm_migrate_timers(struct kvm_vcpu *vcpu)
>  
>  bool kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *args)
>  {
> -       bool resample = args->flags & KVM_IRQFD_FLAG_RESAMPLE;
> -
> -       return resample ? irqchip_kernel(kvm) : irqchip_in_kernel(kvm);
> +       return irqchip_in_kernel(kvm);
>  }
>  
>  bool kvm_arch_irqchip_in_kernel(struct kvm *kvm)
>
>

-- 
Vitaly



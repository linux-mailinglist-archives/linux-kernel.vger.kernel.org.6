Return-Path: <linux-kernel+bounces-308445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F43965D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF561C23ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275B6171E68;
	Fri, 30 Aug 2024 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOJKamn4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452EF165F05
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010540; cv=none; b=R5x9PqirtGrXFb36CwW3ggQ7i8+gn5BXHToGj/pKBkw2+QByyHTiAf9DVDyYUs8swjDBMdCqMSN7FRBaWXStuItKc7cqYwlwMpemagjVOYKJ/gFZEJ4MTbGl6x7lK1Qcf8xsFurFkw+J075z1FtNRNB333dF3xYOOXAIsxPUNZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010540; c=relaxed/simple;
	bh=/4AcU+5mrCpQ2UoZHnX2vYZ7xGUajTi/DEYXF9Kh1RQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gxs1XOYsCi8uAA46W/gzhbPS1SnlSIb0r2UdGWLhovkAabOC3N6G3LM7gClyoYiJhyH5eXFUpwpAx6Fv2Nu+fo5zyaoFyqcNeA/IJFkO0uDWk/ZVvuN4RqV87N+fPFQ8knal/UQlnDVWk8elaSJmL63PuSVsuoKBPi5QvgStT74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QOJKamn4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725010537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gOLHpXbrDu4AZVBfm8LLHD5ogMcE5R5Aph6RTHz3h88=;
	b=QOJKamn4ms5bGzAg7EO7hCGBUSkHtMuGt1j6gAxUDbz0SIxpuplPVAxvKBOz4kgiyekBDd
	ESUWDkPKDUFIJwKD4K4goaONjCfPJvOi46Mn1dX8Tes2leYt8QvSGmJhXVhtUk0FV5jbdL
	dXbTm7ICBtM541sikaGAaVqWBVeWo9M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-w4jmimoYP4Ka9POZ1o79Fw-1; Fri, 30 Aug 2024 05:35:35 -0400
X-MC-Unique: w4jmimoYP4Ka9POZ1o79Fw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428fc34f41bso15389795e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725010534; x=1725615334;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOLHpXbrDu4AZVBfm8LLHD5ogMcE5R5Aph6RTHz3h88=;
        b=RWF2iKEbQOQpYXUbfUbFcc0GBBBG0yvzs0feHSFGx2Kov/VfaJN8vMmUBOz27EVfgV
         g9F8ZepYAwTysUmX4Uh/3/MCsoyJ+umP7mGa4o7Ci0nq/o/fde9Eq2MajOvCpmm69T5L
         l1dmeJt+W4JekP55LV/UfVTxQxHHGWfnKdIGfc6WECDfrSA1hJ2I0kQv0furZswvzqWz
         mBWX1KvKCVC2o0blhXM+6kQwzqzRHzWDa9ly8V48BlEVB60ymU89EVYf3QDQotP8ilyI
         WHywbIU+sVQqBa7fY2tsi8YRPgMZdnKs0xiufvRKGQwrwz9xdaVPcSGBeFjHEMrtoaAh
         sBBg==
X-Forwarded-Encrypted: i=1; AJvYcCW3EoREvL5JOCjuIfU6e5R2FsXH2We6GcyT9aHN7+w1aTJQ0RV641z/U6BRc+WT38nD2jXE/rv3C+oMYeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vrgCT/JUXp1xlFSRFPXHbP1e3lfvXLB167I59EpPYlAFnTio
	Ws5jt2sVeKWpISzkZ99aTdSQmejnVOR1EuUXhrvOL4hav1atVtYRCv8nnOadgaIyLBQwYq2+zU4
	PzglhGN3cYtnLstLQKOcGUTRz2Tz8GkAnIDef/oxmONKLzS/pQD9cncM3PdETig==
X-Received: by 2002:a05:600c:4f42:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-42bb0137641mr48082465e9.0.1725010534371;
        Fri, 30 Aug 2024 02:35:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAXdxCbGrEOrDzUMeJDkQaCX59o438yNucxDqSfAGGWzdvpKi8o3/65PT380tdrco4sEffaA==
X-Received: by 2002:a05:600c:4f42:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-42bb0137641mr48082115e9.0.1725010533790;
        Fri, 30 Aug 2024 02:35:33 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0a0asm40473115e9.13.2024.08.30.02.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:35:33 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, Yiwei
 Zhang <zzyiwei@google.com>, Lai Jiangshan <jiangshanlai@gmail.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that
 support self-snoop
In-Reply-To: <20240309010929.1403984-6-seanjc@google.com>
References: <20240309010929.1403984-1-seanjc@google.com>
 <20240309010929.1403984-6-seanjc@google.com>
Date: Fri, 30 Aug 2024 11:35:32 +0200
Message-ID: <877cbyuzdn.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> Unconditionally honor guest PAT on CPUs that support self-snoop, as
> Intel has confirmed that CPUs that support self-snoop always snoop caches
> and store buffers.  I.e. CPUs with self-snoop maintain cache coherency
> even in the presence of aliased memtypes, thus there is no need to trust
> the guest behaves and only honor PAT as a last resort, as KVM does today.
>
> Honoring guest PAT is desirable for use cases where the guest has access
> to non-coherent DMA _without_ bouncing through VFIO, e.g. when a virtual
> (mediated, for all intents and purposes) GPU is exposed to the guest, along
> with buffers that are consumed directly by the physical GPU, i.e. which
> can't be proxied by the host to ensure writes from the guest are performed
> with the correct memory type for the GPU.
>
> Cc: Yiwei Zhang <zzyiwei@google.com>
> Suggested-by: Yan Zhao <yan.y.zhao@intel.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c |  8 +++++---
>  arch/x86/kvm/vmx/vmx.c | 10 ++++++----
>  2 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 403cd8f914cd..7fa514830628 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4622,14 +4622,16 @@ static int kvm_tdp_mmu_page_fault(struct kvm_vcpu *vcpu,
>  bool kvm_mmu_may_ignore_guest_pat(void)
>  {
>  	/*
> -	 * When EPT is enabled (shadow_memtype_mask is non-zero), and the VM
> +	 * When EPT is enabled (shadow_memtype_mask is non-zero), the CPU does
> +	 * not support self-snoop (or is affected by an erratum), and the VM
>  	 * has non-coherent DMA (DMA doesn't snoop CPU caches), KVM's ABI is to
>  	 * honor the memtype from the guest's PAT so that guest accesses to
>  	 * memory that is DMA'd aren't cached against the guest's wishes.  As a
>  	 * result, KVM _may_ ignore guest PAT, whereas without non-coherent DMA,
> -	 * KVM _always_ ignores guest PAT (when EPT is enabled).
> +	 * KVM _always_ ignores or honors guest PAT, i.e. doesn't toggle SPTE
> +	 * bits in response to non-coherent device (un)registration.
>  	 */
> -	return shadow_memtype_mask;
> +	return !static_cpu_has(X86_FEATURE_SELFSNOOP) && shadow_memtype_mask;
>  }
>  
>  int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 17a8e4fdf9c4..5dc4c24ae203 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7605,11 +7605,13 @@ static u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
>  
>  	/*
>  	 * Force WB and ignore guest PAT if the VM does NOT have a non-coherent
> -	 * device attached.  Letting the guest control memory types on Intel
> -	 * CPUs may result in unexpected behavior, and so KVM's ABI is to trust
> -	 * the guest to behave only as a last resort.
> +	 * device attached and the CPU doesn't support self-snoop.  Letting the
> +	 * guest control memory types on Intel CPUs without self-snoop may
> +	 * result in unexpected behavior, and so KVM's (historical) ABI is to
> +	 * trust the guest to behave only as a last resort.
>  	 */
> -	if (!kvm_arch_has_noncoherent_dma(vcpu->kvm))
> +	if (!static_cpu_has(X86_FEATURE_SELFSNOOP) &&
> +	    !kvm_arch_has_noncoherent_dma(vcpu->kvm))
>  		return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT) | VMX_EPT_IPAT_BIT;
>  
>  	return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT);

Necroposting!

Turns out that this change broke "bochs-display" driver in QEMU even
when the guest is modern (don't ask me 'who the hell uses bochs for
modern guests', it was basically a configuration error :-). E.g:

$ qemu-kvm -name c10s -nodefaults -smp 4 -machine
q35,smm=on,accel=kvm,kernel-irqchip=split -global
driver=cfi.pflash01,property=secure,value=on -cpu host -drive
id=drive_image2,if=none,snapshot=off,aio=threads,cache=none,format=qcow2,file=/var/lib/libvirt/images/c10s.qcow2
-device virtio-blk-pci,id=image2,drive=drive_image2,bootindex=3,bus=pcie.0,addr=0x8
-drive file=/usr/share/OVMF/OVMF_CODE.secboot.fd,if=pflash,format=raw,readonly=on,unit=0
-drive file=/tmp/OVMF_VARS.secboot.fd,if=pflash,format=raw,unit=1
-device ahci,id=ahci0 -vnc :0 -device bochs-display -m 8G -monitor stdio

The failure looks like Wayland starting and failing right away, this
repeats multiple times but after a number of restarts it may try to
pretend to work but then it crashes again. Things go back to normal when
the commit is reverted in the host kernel.

The CPU where this reproduces is fairly modern too (Intel(R) Xeon(R)
Silver 4410Y, Sapphire Rapids). I wish I could give additional details
to what exactly happens in the guest but I can't find anything useful in
the logs ("WARNING: Application 'org.gnome.Shell.desktop' killed by
signal 9") and I know too little (nothing?) about how modern Linux
graphics stack is organized :-( Cc: Gerd just in case.

-- 
Vitaly



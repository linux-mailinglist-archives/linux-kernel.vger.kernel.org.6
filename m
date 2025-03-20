Return-Path: <linux-kernel+bounces-570129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7B1A6AC9A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4EE18983BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79FA226CE5;
	Thu, 20 Mar 2025 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8J2fgUL"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43191DE3A8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493563; cv=none; b=kYx+B2PZYuiqagfc4TIoV/O7tecF1OY7UDjiC4XZ6FuZ+sLRfOL21CdmdDll5bAoiH26AnI4H1lE5oQw47b97lVOsP+Ck89gefwF8qKVOpDlVsFgd1F+fW81IO7ufj59ot5TgP7mjmFPkq5t+va5pMN8OiYz+uzMJeK5tWYM+kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493563; c=relaxed/simple;
	bh=Z7ZUdOd1Qu0akPYKGzYTaas6tJ63tvSTqgDH4om2eDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DowhLxnnQCSyyyUG+bZXvWgFDpsyw3wLKDN/XTqyuzBArD86u6jd6M3frvtphZW/9FSxqUWHjbhv9CBWv3zGKWAjDT1ooIZ2w3ZBvEMW26LSJmtYJfEYAFZyu82ryk/sqAlVTLfrZuZCdvdbiMd+OTUMudiy4iiM8/gE9sBja6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c8J2fgUL; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6aaa18e8so1597111a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742493561; x=1743098361; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtjBMjBZnb8gIPfwNEw+gjcHeYhjJgmG8Gm1x0OUREY=;
        b=c8J2fgUL0MNMVEFoqzAlBUkfUYeAesz0D7fCkmZWL0Kxxs86TSNizBDaSJRKKOT1bW
         Rny2AFvUzkVpAMtZigVcoMyXeSO+aVTWFEVXt+RNEBgQ1iKSnf/W9sBp3M+6i8EXlSGh
         SbOtaXSpXjcm9b6l9pvA19xGZayogrdJr0GKmPUy82Xqqv+PwBNFj7ExJ5xrj9cIJQWG
         sb+FI8iyizoNjT9y8J12k40DpvyjbHMAxb5X25ojHb8vn0CLr6P0iAceA8xM8mKzn++f
         Hwetxywy5DAmrtjJheOo6DEaR/CzqfqPPbzl34bEmf4WlMVRtQaPqqXHfm1VFg8srnn1
         5SDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493561; x=1743098361;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtjBMjBZnb8gIPfwNEw+gjcHeYhjJgmG8Gm1x0OUREY=;
        b=jM63nj7Tah95CSW14vAyF6JY+fXhOPPm3R2Nlt6/JcdEpKFLfo2y53nHDXwG6AlQAP
         HqRtXp8B7DJ7hC2bVWRAobUX1iVc7YaQJAbppOHjoAR4vKD4HNo3FjDkvL8Ea/vgH0da
         KZh4nlajRVcpgVmnoL4/vm8moWWe4NAEv2MfNgbeO0nIk9PMrQnNFGPiL2mXO7LoeSkx
         h5eij/4OYLTEd0/nsWC1W/3BIPNu+gsilQEWQeIVQEjVfb8DNiq1m35oB4pduwYWsd5Z
         wFm+sjzzO3ff7OLcEj8oCs5yGe4nE30T4JSLUWt7cauRXuuXkaiAFa6dNBFpdbPSnmHG
         bFLA==
X-Forwarded-Encrypted: i=1; AJvYcCVsrvStyjjATIfzkPkxsz+p6F6sKnedSs8FcEA5cWVqnov6SwquTIh/bD3PnKVy/euDy0aRdz68QhhBuGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK6ua020bJtVDb/nRN+gX9BJuCdunj6mrsSmIxEJMNzfBN8Fd2
	wRLn51kv/M4H06cwscnpHNpacaYTCDm5UrEVJxCfnr0Qm3bZPFex7Ad6d6kkim2x4MebMK287a6
	m4w==
X-Google-Smtp-Source: AGHT+IFFDux1CbiuMzkBtnyPZqPK4Cl0AlpMwyk2P7kdhcy6JyBURFc0XcLg0BWALe2g4ffe15lbm7EMEl4=
X-Received: from pjbqj7.prod.google.com ([2002:a17:90b:28c7:b0:301:1ea9:63b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ed0:b0:2fe:b470:dde4
 with SMTP id 98e67ed59e1d1-3030fe8bcb9mr311450a91.12.1742493561104; Thu, 20
 Mar 2025 10:59:21 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:59:19 -0700
In-Reply-To: <20250320142022.766201-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320142022.766201-1-seanjc@google.com> <20250320142022.766201-4-seanjc@google.com>
Message-ID: <Z9xXd5CoHh5Eo2TK@google.com>
Subject: Re: [PATCH v2 3/3] KVM: x86: Add a module param to control and
 enumerate device posted IRQs
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 20, 2025, Sean Christopherson wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index f76d655dc9a8..e7eb2198db26 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -227,6 +227,10 @@ EXPORT_SYMBOL_GPL(allow_smaller_maxphyaddr);
>  bool __read_mostly enable_apicv = true;
>  EXPORT_SYMBOL_GPL(enable_apicv);
>  
> +bool __read_mostly enable_device_posted_irqs = true;
> +module_param(enable_device_posted_irqs, bool, 0444);
> +EXPORT_SYMBOL_GPL(enable_device_posted_irqs);
> +
>  const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
>  	KVM_GENERIC_VM_STATS(),
>  	STATS_DESC_COUNTER(VM, mmu_shadow_zapped),
> @@ -9772,6 +9776,9 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
>  	if (r != 0)
>  		goto out_mmu_exit;
>  
> +	enable_device_posted_irqs &= enable_apicv &&
> +				     irq_remapping_cap(IRQ_POSTING_CAP);

Drat, this is flawed.  Putting the module param in kvm.ko means that loading
kvm.ko with enable_device_posted_irqs=true, but a vendor module with APICv/AVIC
disabled, leaves enable_device_posted_irqs disabled for the lifetime of kvm.ko.
I.e. reloading the vendor module with APICv/AVIC enabled can't enable device
posted IRQs.

Option #1 is to do what we do for enable_mmio_caching, and snapshot userspace's
desire.

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e7eb2198db26..c84ad9109108 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -228,6 +228,7 @@ bool __read_mostly enable_apicv = true;
 EXPORT_SYMBOL_GPL(enable_apicv);
 
 bool __read_mostly enable_device_posted_irqs = true;
+bool __ro_after_init allow_device_posted_irqs;
 module_param(enable_device_posted_irqs, bool, 0444);
 EXPORT_SYMBOL_GPL(enable_device_posted_irqs);
 
@@ -9776,8 +9777,8 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
        if (r != 0)
                goto out_mmu_exit;
 
-       enable_device_posted_irqs &= enable_apicv &&
-                                    irq_remapping_cap(IRQ_POSTING_CAP);
+       enable_device_posted_irqs = allow_device_posted_irqs && enable_apicv &&
+                                   irq_remapping_cap(IRQ_POSTING_CAP);
 
        kvm_ops_update(ops);
 
@@ -14033,6 +14034,8 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_rmp_fault);
 
 static int __init kvm_x86_init(void)
 {
+       allow_device_posted_irqs = enable_device_posted_irqs;
+
        kvm_init_xstate_sizes();
 
        kvm_mmu_x86_module_init();


Option #2 is to shove the module param into vendor code, but leave the variable
in kvm.ko, like we do for enable_apicv.

I'm leaning toward option #2, as it's more flexible, arguably more intuitive, and
doesn't prevent putting the logic in kvm_x86_vendor_init().


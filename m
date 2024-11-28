Return-Path: <linux-kernel+bounces-424070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890249DB055
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E30A7B22990
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F321BDCF;
	Thu, 28 Nov 2024 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7XxW7Eo"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F40EAD5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732754631; cv=none; b=aFXF4jVdxZXVJSoQZq3Sc63YKTyE5zR9ESTXLKcQB++sUHJQKhz/p+QUcEWo0q8/qjQKKb6Jpc4cBDQOWrX43Xej5Wpfm0PPQYuISWyHBUu98qNpTQRxDQHuqjwfqot2HeaM4geJZKaxJuH/NVb+byzQIOpBQYnk6mCWaG8eu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732754631; c=relaxed/simple;
	bh=EACB2yPyU5Yw8+WwKYitNwB9tkKiB/UcMdmwylhn5ac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=glqqbo59FRrZe0K7RPIjPwKPMZr33NEsKgsdxBB5dMwnHEhTSlKwbHRdZ1mtvB9r/4NVxxC/rOFARyW92jOImNrYkdtUE05cPUVCJoYB6CSunVm4hhtqtYXMC/BCeCp/OM5R3t+SVw7NaC4MuSKX5jBZjWfEM345n/0BvDh3s68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v7XxW7Eo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21147fea103so3437955ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732754629; x=1733359429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=H6v00VWPrFlV9G8PXjNGHz1lcbArd14LtnA+J13xoHI=;
        b=v7XxW7EoO+ncriNDu2gIHvbXy3S5xYONjO+Tf0yNsXsxEn8y6N3rh5wETBW6Tkebqa
         /RSErLXc8BX0QLx/r/i3LGRs4MJwvLuPUkvCxE8EQGrWfd2IM1FVHou0vWBKhB4qHfnR
         DC626wTtM/z4pDK4dzZeBj3uzSy3Mv7fOWtdC/65d9bGU9oseiO0LmGVrUQQwnSExSCZ
         SBpi/PSVK5jclZsl47hQHhddfM3q+PapNBtwbBWpJgqV4X+J7d+5jAYGYDr3OYfCJ+SV
         Hhe1gqn/npwqYlC37ShZibIpIqaM6lA8kjTUVNHXtr0M0gSeI98t6iGOy+81tlouIU9S
         Y9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732754629; x=1733359429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6v00VWPrFlV9G8PXjNGHz1lcbArd14LtnA+J13xoHI=;
        b=YXthap4BWmSbnbxauzyOJPmvX+UhKvnOeIq7sST+As7evW4elJaYeIqMLb/JOlFpBj
         V5LL5NPiex39sw5aEL5vG7ChCarjiDU3bA5XVj4LlqAh//Pq5AFY9caeSfBuMfnUD1ja
         R3OdgibRBcjA4M9LMETeBiqCXpvu4WvoQuZRlbCW0BCugyB9GdBpTLLAITdsU1toW8aV
         WcdJEHtVFlXVoGXtscCVlTqFwk5N9Zj6spHlSUa3zCPa4ad1RqBlPuus4hU2DjOzfek1
         HLtfR6nlhGGyPdqtxhUzqew8SYbuKXKFAxWcpYVfFfheh/U3i1UELTS+t6AZKNytbM4o
         zpmg==
X-Forwarded-Encrypted: i=1; AJvYcCVwlic9QMA26GuPqygiB6CjX2aaHcPhmPMmNB9Q9vu3+2nDoN+yiF6GQzxtNO/+KLaaosp13OPhuMBxRiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiUnooXaozHtGOpU95oxvzCVy039oTlGAWTQKh9zyiO5PECDMS
	VstFvzmUPPSPuXmZ/e995gEKaYG0Fs+KESkRLwHmegDIfJ9eBoZeJ1zN5YMQdfItO1CsEtd5PbB
	h3g==
X-Google-Smtp-Source: AGHT+IEK9pbCeaFZWXX0PLadQxkBbAx1o35IfYFdtf0yqxaDLee26TJikEv6kZT/3lUfdcYbGJKEkLcA4Vc=
X-Received: from pjbpd1.prod.google.com ([2002:a17:90b:1dc1:b0:2ea:448a:8cd1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d0d:b0:2ea:bf1c:1e3a
 with SMTP id 98e67ed59e1d1-2ee08eb2ae0mr7730683a91.12.1732754629027; Wed, 27
 Nov 2024 16:43:49 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 16:43:39 -0800
In-Reply-To: <20241128004344.4072099-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128004344.4072099-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128004344.4072099-2-seanjc@google.com>
Subject: [PATCH v4 1/6] KVM: x86: Play nice with protected guests in complete_hypercall_exit()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

Use is_64_bit_hypercall() instead of is_64_bit_mode() to detect a 64-bit
hypercall when completing said hypercall.  For guests with protected state,
e.g. SEV-ES and SEV-SNP, KVM must assume the hypercall was made in 64-bit
mode as the vCPU state needed to detect 64-bit mode is unavailable.

Hacking the sev_smoke_test selftest to generate a KVM_HC_MAP_GPA_RANGE
hypercall via VMGEXIT trips the WARN:

  ------------[ cut here ]------------
  WARNING: CPU: 273 PID: 326626 at arch/x86/kvm/x86.h:180 complete_hypercall_exit+0x44/0xe0 [kvm]
  Modules linked in: kvm_amd kvm ... [last unloaded: kvm]
  CPU: 273 UID: 0 PID: 326626 Comm: sev_smoke_test Not tainted 6.12.0-smp--392e932fa0f3-feat #470
  Hardware name: Google Astoria/astoria, BIOS 0.20240617.0-0 06/17/2024
  RIP: 0010:complete_hypercall_exit+0x44/0xe0 [kvm]
  Call Trace:
   <TASK>
   kvm_arch_vcpu_ioctl_run+0x2400/0x2720 [kvm]
   kvm_vcpu_ioctl+0x54f/0x630 [kvm]
   __se_sys_ioctl+0x6b/0xc0
   do_syscall_64+0x83/0x160
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   </TASK>
  ---[ end trace 0000000000000000 ]---

Fixes: b5aead0064f3 ("KVM: x86: Assume a 64-bit hypercall for guests with protected state")
Cc: stable@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2e713480933a..0b2fe4aa04a2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9976,7 +9976,7 @@ static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
 {
 	u64 ret = vcpu->run->hypercall.ret;
 
-	if (!is_64_bit_mode(vcpu))
+	if (!is_64_bit_hypercall(vcpu))
 		ret = (u32)ret;
 	kvm_rax_write(vcpu, ret);
 	++vcpu->stat.hypercalls;
-- 
2.47.0.338.g60cca15819-goog



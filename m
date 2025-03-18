Return-Path: <linux-kernel+bounces-566715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE37A67B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA891883F00
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5356214A98;
	Tue, 18 Mar 2025 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5eWFTnN"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0652144C0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321006; cv=none; b=LGbY2AjH77YNHnnz8jb969l13KFaXjKgPQbu0NsAQJ2i9MTlDRPReqkIMGS7V/ZVkF+f3TaEfg6WG0Q9wDf5gw8TRabCOWhQKgAtmpTFUiSeBK4ZjQaP8UPHQB070sz3k+cl5A8Djgj/lrJHOHrTBi+CxEKvs3YQm7WkTRATj9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321006; c=relaxed/simple;
	bh=TeLXYFvo5qSy4bl+vgw6Bf41OfZnXdJRvk2bbFernx8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uT7Zgu3khgWbJf2WdSE/0v6NkaIZQr8x8I1yJx1nH/Vm2TRaAjqudp7ctzAkJO2cSABiTQGmuuWXV0v8Wu/u56cJkwAFbn/27437joWBIOzqIZIg3B0253xmGNrgLAPMF5AjgRHEL5dMfSrT8X/klwzlwmZ0mN8n6xXpnVUiC3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5eWFTnN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff55176edcso5273640a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742321000; x=1742925800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bf+fu/7ON1B84p+IvqDQDkS4LKXFcc8bKyeZflk0FSo=;
        b=T5eWFTnNA8uRWjKRR9BJ3yhGhZUQ/x0wm554HfRccTGxbdISI6cD/B90dJ67hc+6Sr
         /y4zRFCGi4dPpdzxjrS1+kkCnhSF+maaFsVHRv6IdomV3wPq36Rt6QeFaiZC1mxcBAHU
         J5XPB8SD93lh5tk/zN8ip4UIqVoDvA7d4tTKgyS/5iZAct+BPKDaWNMzLhSeHs+vqZeZ
         THzCYC1Sf5vvZ3IGNS5D+Klu0FSCbul21rC41JfE/XrIUR/PQXC6P2cboY74h2gBSV73
         gU2ogpoNMMMthFI11muywN7NscMkbfZdMi8kbbZGbj8yUwYUSMgCF2d4DbsvU76SELk/
         bmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742321000; x=1742925800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bf+fu/7ON1B84p+IvqDQDkS4LKXFcc8bKyeZflk0FSo=;
        b=vW3Pjq/r9NgANdYvzsRuRq3nLKYXBX/7v/b4MIUgnx+gEe0plXBUCBZrw7Epk3a68c
         y2hb1GZICGuO9tbta+gtDaG02XRTE5MS5qeoqPdqSNtaYVTFyqANAPbjZv9xLxts0Nne
         BCnNIka1r12gErVwX/xNu/NuIz4k/IU0VdhfvzssWvEmivm6OwaSHR/yzi8zXOLY+TmQ
         J+7FPg3XygPj2i0VCc3HRot2/Avc2BQUMsWv82jNy9duNq0pgDOH0H3z9onx9UHOr2Zg
         z7MkhW5khSaxJmZDkc2yDNlOlZBc0TSBDJrKAI3Q64ksVrK/7knnL1EMKeAhNgo9YvPP
         74aw==
X-Forwarded-Encrypted: i=1; AJvYcCVf+UHR29CTULoSYkQ3vJNEjyDU8aRJ+s7frzhwLwB2nsmCCeHefA8PWRCQ3+ItC/ox8gd7Z3dU7nlHRAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKZm1Gtia3jQuR23E9diEn7ruSHYoUg+FcjPrWETlXIudLTMji
	b6flGcBX7iDau8vmjYPlqYxxOpVwVE4g+Ocdj+m+k6+QZcqCw46lMTOv7xoPfmNn92kUR+8MBZO
	5SQ==
X-Google-Smtp-Source: AGHT+IEyLGQ0lqlpljp92FTVfkcLktufylzUeatq4YgD7FVpBzaQch/i/1l3dzeMtZJD/Z3GGw77t0WB2hI=
X-Received: from pjj3.prod.google.com ([2002:a17:90b:5543:b0:2ea:5613:4d5d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55cc:b0:2fa:f8d:65de
 with SMTP id 98e67ed59e1d1-301a5b87b6amr3915192a91.22.1742320999879; Tue, 18
 Mar 2025 11:03:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 18 Mar 2025 11:03:02 -0700
In-Reply-To: <20250318180303.283401-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318180303.283401-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318180303.283401-8-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: VMX changes for 6.15
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Nothing major for VMX, mostly prep work for FRED virtualization.

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-vmx-6.15

for you to fetch changes up to 0c3566b63de860f6d42e3d9254890c00ac0970d7:

  KVM: VMX: Extract checks on entry/exit control pairs to a helper macro (2025-03-03 07:45:54 -0800)

----------------------------------------------------------------
KVM VMX changes for 6.15

 - Fix a bug where KVM unnecessarily reads XFD_ERR from hardware and thus
   modifies the vCPU's XFD_ERR on a #NM due to CR0.TS=1.

 - Pass XFD_ERR as a psueo-payload when injecting #NM as a preparatory step
   for upcoming FRED virtualization support.

 - Decouple the EPT entry RWX protection bit macros from the EPT Violation bits
   as a general cleanup, and in anticipation of adding support for emulating
   Mode-Based Execution (MBEC).

 - Reject KVM_RUN if userspace manages to gain control and stuff invalid guest
   state while KVM is in the middle of emulating nested VM-Enter.

 - Add a macro to handle KVM's sanity checks on entry/exit VMCS control pairs
   in anticipation of adding sanity checks for secondary exit controls (the
   primary field is out of bits).

----------------------------------------------------------------
Nikolay Borisov (1):
      KVM: VMX: Remove EPT_VIOLATIONS_ACC_*_BIT defines

Sean Christopherson (5):
      KVM: VMX: Don't modify guest XFD_ERR if CR0.TS=1
      KVM: VMX: Pass XFD_ERR as pseudo-payload when injecting #NM
      KVM: nVMX: Decouple EPT RWX bits from EPT Violation protection bits
      KVM: VMX: Reject KVM_RUN if userspace forces emulation during nested VM-Enter
      KVM: VMX: Extract checks on entry/exit control pairs to a helper macro

 arch/x86/include/asm/vmx.h     |  28 ++++++-----
 arch/x86/kvm/mmu/paging_tmpl.h |   3 +-
 arch/x86/kvm/vmx/vmx.c         | 106 +++++++++++++++++++++++++++++------------
 3 files changed, 92 insertions(+), 45 deletions(-)


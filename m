Return-Path: <linux-kernel+bounces-257737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9A4937E51
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 02:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C22AEB21253
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 00:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45143D266;
	Sat, 20 Jul 2024 00:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ejRIov5z"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854377F9
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 00:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433703; cv=none; b=eiMQHqVXqfOwUuWCwwvjLi40GRCpeF0Ilo/qYddjeXCBK8fKUjY12S7jr2fSMtgMIKL9MZ6vscDEDEyYsU3x1o5k5CHuxL4mjK3a4XIbidCS4GD5ZQ6sd2hW+8EkI5MV86ES0PiCZrBV1OCxn5p6puamIEE25rZ/OpFhXjxfOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433703; c=relaxed/simple;
	bh=zKOcZ/17Qu7v6XtfeopuihxsA/xqagkCC7r/VB/xMg8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G5cmsPMSPUhQ3SXlqqmb4u9u1zk0X1PLCSG77/bL2QDQWw9pf3dFhKmlqDQiVRaVXKDUEH8cgnf0XSb9iXsTMEohqL4o/KPqZmP3P5TK3XCvz5v7/6FeE8CsPVb4jE9AabAY8doIJwePwAw0h8r4izSUWVCUYSFPFMGNpxrVzo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ejRIov5z; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fc4b03fe76so19425595ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 17:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721433701; x=1722038501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwRE/lB6XnWzRpn4tZdnpiLwQkxee6V131gQ6RaCx10=;
        b=ejRIov5zk2wRNQIDwtwwJepCEI1NWNxorvJb5SKiGL7LoAgoN2xar41qtTpkKLMCe0
         iPQTiSxZg1xo32+QigB+mWiy37Z2y9WIsSMDkYcAjlcZ4UaZeruKA/Epusl0h/PUtMVu
         s0OzI67/mYje5OgdgGq+cMDfHiXkxQrTsP4LogLQBzgMbdSxcOQvMcxDca1bjWkMDuXr
         y6HSmVhR9p1DeCa5OjiN2zVzxFo4QPJglw+r1bc8zlaVQmC9kpZmVMXZ4GIj/cJQ6Bxp
         JiuzF7gQ9gHxLgK/fjJbDx3JUBGXH9Bew7KnkpjQtpLtLPihztmqjFuChCNCyro38AsF
         hEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433701; x=1722038501;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwRE/lB6XnWzRpn4tZdnpiLwQkxee6V131gQ6RaCx10=;
        b=LCm22MXnomScZTc/s1kOAEdEtXHC2YQnqZO9RHif+Gn81x09Wi4SGmrNMFah4PwbOq
         0QMrILKuNlOit4A7njqyB/4I1WDy3ZlsW9XqlAJcguAse8u3ngUQdosl/mZIM1PG7TUZ
         2KJyUuF87PIXMvr/vDKzuN+UOLzX5eg1NeGEm3HhhEkxWRH+igNBzRNxpQIeUggZaeye
         pj7Jbr8B0oD2kOOONmeLFTw4Imt+gWIO6TyTbD/1/aLteaqkJUm/v7sqRcP09VoGUc1w
         09rMaF86JoPC9owXVVK9hzieKRkwZCaAxyFuOglqcSEpp48AIIjbYREfFWmCBmSIurs3
         y34w==
X-Forwarded-Encrypted: i=1; AJvYcCVhR08+jKUEvV0Uio9a9ZvtMnylGtlFcLoILvvBxzFU1rFUf4MjWiaLueLHeI29Ryan4Z2geON+Sv/5XhPOabXgaP0r44BoNNwdW/CE
X-Gm-Message-State: AOJu0YzKXrIdNSS5EOgCnJg/RzLc/jpob3eoCcKxQT21Je85f0nRFCWd
	0Ix759z4xgGEowpxTk/EXMP89JEA4JH1fK8xzMEY/S240SzgwYb5qMYAzFjLxhxrIK2dOtvIgJe
	gAA==
X-Google-Smtp-Source: AGHT+IGJdd/lIh6kgApMAgbImNa+p0bD7o/hCkswy/T2NLWgYTvuwwbI+Fq9TlVBuF/yYHgNrZpAxtNcJTA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2341:b0:1fd:6ca4:f988 with SMTP id
 d9443c01a7336-1fd7462db45mr28085ad.11.1721433700595; Fri, 19 Jul 2024
 17:01:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 17:01:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240720000138.3027780-1-seanjc@google.com>
Subject: [PATCH 0/6] KVM: nVMX: Fix IPIv vs. nested posted interrupts
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="UTF-8"

Fix a bug where KVM injects L2's nested posted interrupt into L1 as a
nested VM-Exit instead of triggering PI processing.  The actual bug is
technically a generic nested posted interrupts problem, but due to the
way that KVM handles interrupt delivery, I'm 99.9% certain the issue is
limited to IPI virtualization being enabled.

Found by the nested posted interrupt KUT test on SPR.

If it weren't for an annoying TOCTOU bug waiting to happen, the fix would
be quite simple, e.g. it's really just:

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f7dde74ff565..b07805daedf5 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4288,6 +4288,15 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
                        return -EBUSY;
                if (!nested_exit_on_intr(vcpu))
                        goto no_vmexit;
+
+               if (nested_cpu_has_posted_intr(get_vmcs12(vcpu)) &&
+                   kvm_apic_has_interrupt(vcpu) == vmx->nested.posted_intr_nv) {
+                       vmx->nested.pi_pending = true;
+                       kvm_apic_clear_irr(vcpu, vmx->nested.posted_intr_nv);
+                       goto no_vmexit;
+               }
+
                nested_vmx_vmexit(vcpu, EXIT_REASON_EXTERNAL_INTERRUPT, 0, 0);
                return 0;
        }

Gory details in the last patch.

Sean Christopherson (6):
  KVM: nVMX: Get to-be-acknowledge IRQ for nested VM-Exit at injection
    site
  KVM: nVMX: Suppress external interrupt VM-Exit injection if there's no
    IRQ
  KVM: x86: Don't move VMX's nested PI notification vector from IRR to
    ISR
  KVM: nVMX: Track nested_vmx.posted_intr_nv as a signed int
  KVM: nVMX: Explicitly invalidate posted_intr_nv if PI is disabled at
    VM-Enter
  KVM: nVMX: Detect nested posted interrupt NV at nested VM-Exit
    injection

 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/irq.c              |  6 ++---
 arch/x86/kvm/lapic.c            | 12 +++++++--
 arch/x86/kvm/lapic.h            |  2 +-
 arch/x86/kvm/vmx/nested.c       | 43 ++++++++++++++++++++++++---------
 arch/x86/kvm/vmx/vmx.h          |  2 +-
 arch/x86/kvm/x86.c              |  2 +-
 7 files changed, 49 insertions(+), 20 deletions(-)


base-commit: 332d2c1d713e232e163386c35a3ba0c1b90df83f
-- 
2.45.2.1089.g2a221341d9-goog



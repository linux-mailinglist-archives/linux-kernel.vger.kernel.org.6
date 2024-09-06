Return-Path: <linux-kernel+bounces-318117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAB096E8A5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5463B20ECA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946B141760;
	Fri,  6 Sep 2024 04:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFwiOMd2"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CA283CDA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 04:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725597259; cv=none; b=dPH5h93Gb8yPfgW/7Q0sgV4qGkbx8Lea9YCeKZlgb9ZeV6ZTnXvrldNhEVhAmawBMd2kbP/FvItJbV/iFdrwSkNeJbSgOAvrw3rf/6M171xHx9bhwMlmkyR4bnAJzSEgBvA54c0NZ9hmE478TYRwbz6mAzrqUTerGYRa6winORM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725597259; c=relaxed/simple;
	bh=RT1aI6hMXnwPobjxMnyWJW+WtLEHVfvy+uS/LP8jAcU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sB7RbzymSaFXypCJisz1DclmPDCWUC9n2JBWKeAMlavVJwJAxDDaFvMcIogcK4GOFUBuo6cMdmRDaMG8aFqEoeGpuSYrbHajRUlpYPcb+i7+An/wgs4lY/+RjCLHBy7H620KZ4bwWw7eqHKQVvB/+cJEu3v1udZ3bARE1RDCRI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AFwiOMd2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2d8b3af9e61so2042356a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 21:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725597257; x=1726202057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6f4XFGl9ES5RFIpxWgOae+ryWTVpyIEIUyDw0NY4Vg=;
        b=AFwiOMd2mQ3+tCzVimogfIYIAqSGkYNOYeh2dmbGpKtNpQNKCN1oIEKCfC+lIkyxNk
         3AgIzr3vpd5We+Zi+Pi0GBuNbDFFiZIYxU9DLOISB9dJIkfFkBbPWwimIzbWXyTSpgh1
         UK3E684nu5LCzMi6TjtbK7Wq0MmNCZDoKLsXKB1qTkyJbS32/m+D/bXnHrljeCGxWksP
         sY8HNIuVAryTIQQ1qfKKpWRiHk4G2Js6ZYNhqqFW6F2kc9K4eMltIXPgbr19gIYhBXci
         nNISyckXiSF0z/C8GUtEPjcUfSUI/NANB4uBy4bdDJwg4pBoZpz2I7inY56YEM4MAC0m
         NWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725597257; x=1726202057;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6f4XFGl9ES5RFIpxWgOae+ryWTVpyIEIUyDw0NY4Vg=;
        b=Cf3aUdDkCsEaN4UmnXBo5ibD5XbyRmYnw3t7GRgHCX8VoIaqPWuGI3p45Do7NxFJVT
         IFxEVQXjBYqGoaoYRpNUaaPcXIPhOkw4bklIPc/1v8ES5sDg2+FzY+gSQyStV0QYJymY
         IhiC7WVZJQOtcKXvjybpGaWJqL/+DAVFChNEOcSf0OwPd2tzvFixYioL60W+Xj4JNoBa
         ufM8GJryO8spYdP8aS741NPbpFAsbp1TQ7SxZJk6zm+V18mx17He4dj+XmWgD1zv9nUQ
         182rgKXG858dRKVw5i98B8gP817qvfqQH/PBfnKOlfb+m3HZEa2C6PsjyH5YynT01vsm
         U+NA==
X-Forwarded-Encrypted: i=1; AJvYcCXaxb8mRIPIl7N7dMo45qxXLn/w8PgKVzVTjtZNdCGwrdnTuOhjIlcxBE1IQVE2Sm5cr7SjLBEEqv4P3GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfEOqmFII9Ad4nV84WJJ3S8qUfSNzDbxEcLnleDMvuC9To2/aH
	9vLMXa+FNopV787hzeJd6IDcsyJFiKDQXkU/bLcq27W+zTivvWxNQg0PuSaGr6POBCldk8iuawF
	INQ==
X-Google-Smtp-Source: AGHT+IGFOYWmrB5M6QLnKYNdASjWqveqc4FvIbep8yb+3D99F8n/A6lA+zOOTF0vtx08MfD8jk9Qimnri/Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:4c84:b0:2d8:b475:ec2b with SMTP id
 98e67ed59e1d1-2dad50ea941mr3373a91.5.1725597255343; Thu, 05 Sep 2024 21:34:15
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  5 Sep 2024 21:34:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906043413.1049633-1-seanjc@google.com>
Subject: [PATCH v2 0/7] KVM: nVMX: Fix IPIv vs. nested posted interrupts
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Chao Gao <chao.gao@intel.com>, 
	Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="UTF-8"

Fix a bug where KVM injects L2's nested posted interrupt into L1 as a
nested VM-Exit instead of triggering PI processing.  The actual bug is
technically a generic nested posted interrupts problem, but due to the
way that KVM handles interrupt delivery, the issue is mostly limited to
to IPI virtualization being enabled.

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

v2:
 - Split kvm_get_apic_interrupt() into has+ack to avoid marking the IRQ as
   in-service in vmcs02 instead of vmcs01. [Nathan]
 - Gather reviews, but only for the patches that didn't meaningful change (all
   two of them). [Chao]
 - Drop Cc: stable@ from all patches.  For real world hypervisors, this is
   unlikely to cause functional issues, only loss of IPI virtualization
   performance due to the unnecessary VM-Exit.  Whereas evidenced by my screwup
   in v1, this code is plenty subtle enough to introduce bugs.
 - Drop the patch to store nested.posted_intr_nv as an int, as there is no need
   to explicitly match -1 (as a signed int) in this approach.
 - Add a patch to assert vcpu->mutex is held when getting vmcs12, as I was
   "this" close to yanking out nested.posted_intr_nv, until I realized that
   accessing a different vCPU's vmcs12 in the IPI path is unsafe.

v1: https://lore.kernel.org/all/20240720000138.3027780-1-seanjc@google.com

Sean Christopherson (7):
  KVM: x86: Move "ack" phase of local APIC IRQ delivery to separate API
  KVM: nVMX: Get to-be-acknowledge IRQ for nested VM-Exit at injection
    site
  KVM: nVMX: Suppress external interrupt VM-Exit injection if there's no
    IRQ
  KVM: nVMX: Detect nested posted interrupt NV at nested VM-Exit
    injection
  KVM: x86: Fold kvm_get_apic_interrupt() into kvm_cpu_get_interrupt()
  KVM: nVMX: Explicitly invalidate posted_intr_nv if PI is disabled at
    VM-Enter
  KVM: nVMX: Assert that vcpu->mutex is held when accessing secondary
    VMCSes

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/irq.c              | 10 ++++--
 arch/x86/kvm/lapic.c            |  9 +++---
 arch/x86/kvm/lapic.h            |  2 +-
 arch/x86/kvm/vmx/nested.c       | 57 ++++++++++++++++++++++++++-------
 arch/x86/kvm/vmx/nested.h       |  6 ++++
 arch/x86/kvm/vmx/vmx.c          |  7 ++++
 7 files changed, 72 insertions(+), 20 deletions(-)


base-commit: 332d2c1d713e232e163386c35a3ba0c1b90df83f
-- 
2.46.0.469.g59c65b2a67-goog



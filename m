Return-Path: <linux-kernel+bounces-273015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8181946368
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49FF7B21F7A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FEB1547E6;
	Fri,  2 Aug 2024 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ukYeYtoA"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B671ABEC2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624918; cv=none; b=ez3gi3vVb5kk0qdZ6t772vTVNCaHyQh+bsywlVLAnZpq3B9YbLVm5YageTki4Oe8KMu7jDUmcJ9xGZ7WjbJP0Hw/KJvNYj1gDr02Hhm4+J4U9ZPHJbpceXOeElHS4rQf+QLzWVh1Ie1pKUxRXpCSvwHbvJjQ6o+ZS5KyqdVs63o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624918; c=relaxed/simple;
	bh=csDh3SLvIft85qMK7pks0DAvlEWyp4updhhuwAFMGEM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZPYihtg2yc8Mx8T0w4xB7S3nrwJCuSSrp3QkWnpEcOjIzoCwnl+F4jyWIsghHtR3m6w2AYjzYFes6Rfxkt7YZRAbZ0noBSLtO2Y6o4VmUnFJhTy85icj7eUYkGyQCnQxhbJkI3+0A3MBmjLikvuv61FFLI4sgyjdx+u9KifIMhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ukYeYtoA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-665a6dd38c8so168622577b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722624915; x=1723229715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOyRewHaLJeDoMAa2YF7gd0llk31ENfFaE/kDwJ04JM=;
        b=ukYeYtoA7TvKZhwCULcggTGqFM2um4xgcgPlNCVUx6zgkNtSyq+YsCj3YfAdE9gANF
         bJCMZJ+wtBnAkshuUitrY+PFvGb0+muWZcP4jZ4/R6DJkeTUttNN32JlDFzEeGdqGMmm
         /dy67+CZh+ACa7qtZgGWsoRzSh1sJwPl18tDZy/v0zFDVyQ94j3qlWmPjAXn1D/1DwCS
         lH+RhOP3RQwXSKQeRPLRxq+X+sRI1/2g/DDI8QqyYqNcAsByHfuswoui79Bv1iihUi7t
         EcOdcEpOLTCNNqjOkioTTrhMHKUpbfrhXG5f7yBAhVZj4DbgLYtigVZiOHAp6rxLn2+C
         dkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624915; x=1723229715;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOyRewHaLJeDoMAa2YF7gd0llk31ENfFaE/kDwJ04JM=;
        b=AQMoj8POlznLFaa5jbsVXzIenl0SZtAKA0AhpKUiJaAbYR5IOMzppKCqTYO2ncinHi
         Jz2HwoCCt5YQ6lfj8eyhgCxyr/IdR1CzqR45Ta0OXEP2fJZfmxS6TJiNSnj3wP3RwbhF
         XWueLhLvwuHrmAjkJBUHErIMFLxOeg6O9A2m8W1DchyOAzm7n5xWJwDiYlIi93ygdcLN
         0hJeltLUtmSA1B/MF49LQWHcHb8CvRwunyp5NGsb/SXilTXgHsUJK+IKOgfo+MuNUu5T
         LOfrepuKzToB6ntS54T70SPE8PQbeeBo/0KZXtjAa17Shsmi53Y4l3LhA5Li8Nfn77fz
         Nfng==
X-Forwarded-Encrypted: i=1; AJvYcCVg71jPXL2srKKqbIcfr3SRpO9EPtd2/gS+weNTtVCUXoqcmBAeEn7PKvpmgVzSlBCeEkbm3B2ueNqn9OoHfWuSuqIpX1toPPvBJKsX
X-Gm-Message-State: AOJu0YztO0+NUaBa4cKve2AkwGPf7ndEzOKgnW028/Aqw7qabE5xI3df
	yEdwUV0iJVvyEjgZYdJXyLAbSIhuIcVPhgnfR5E6HLXSvbH9ORv1RRQJoEoucldn76KMWSAWaZY
	Zpg==
X-Google-Smtp-Source: AGHT+IFx8/YCbU+oIuzkfZuhutT51QhJHSkGwIqvKExJaAJMbNbEMXpgqYu5whRNxmUqscWY+yxTgggMnJc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:c02:b0:e0b:d229:af01 with SMTP id
 3f1490d57ef6-e0bde2925d2mr7503276.6.1722624914717; Fri, 02 Aug 2024 11:55:14
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 11:55:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802185511.305849-1-seanjc@google.com>
Subject: [PATCH 0/9] KVM: x86: Add a quirk for feature MSR initialization
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The primary goal of this series to fix an issue where KVM's initialization
of feature MSRs during vCPU creation results in a failed save/restore of
PERF_CAPABILITIES.  If userspace configures the VM to _not_ have a PMU,
because KVM initializes the vCPU's PERF_CAPABILTIIES, trying to save/restore
the non-zero value will be rejected by the destination.

The secondary goal is to try and avoid such goofs in the future, by making
it explicitly clear that userspace owns the vCPU model.

To achieve both goals, quirk KVM's initialization of feature MSRs and give
userspace full control of feature MSRs, mostly.  I left VMX_CR{0,4}_FIXED1
as-is, partly because there was pushback on quirking those in the past[1],
partly because I (somewhat begrudgingly) actually think that it makes sense
for KVM to take control of the allowed-1 CR4 bits, as there is no known use
case for having the post-VMXON CR4 bits diverge from pre-VMXON (guest CPUID),
and trying to sort out what should happen if there was a divergence would be
a mess.

I did apply the quirk to VMX secondary execution controls, because unlike
the CR{0,4} bits, KVM doesn't take _full_ control, and more importantly, I
want to stem the bleeding and avoid KVM fiddling with more VMX MSRs, e.g.
tertiary controls.

Note, this applies on top of the MSR userspace access series [2], and the
tests will fail without those underlying changes.

[1] https://lore.kernel.org/all/20220607213604.3346000-13-seanjc@google.com
[2] https://lore.kernel.org/all/20240802181935.292540-1-seanjc@google.com

Sean Christopherson (9):
  KVM: x86: Co-locate initialization of feature MSRs in
    kvm_arch_vcpu_create()
  KVM: x86: Disallow changing MSR_PLATFORM_INFO after vCPU has run
  KVM: x86: Quirk initialization of feature MSRs to KVM's max
    configuration
  KVM: x86: Reject userspace attempts to access PERF_CAPABILITIES w/o
    PDCM
  KVM: VMX: Remove restriction that PMU version > 0 for
    PERF_CAPABILITIES
  KVM: x86: Reject userspace attempts to access ARCH_CAPABILITIES w/o
    support
  KVM: x86: Remove ordering check b/w MSR_PLATFORM_INFO and
    MISC_FEATURES_ENABLES
  KVM: selftests: Verify get/set PERF_CAPABILITIES w/o guest PDMC
    behavior
  KVM: selftests: Add a testcase for disabling feature MSRs init quirk

 Documentation/virt/kvm/api.rst                |  22 ++++
 arch/x86/include/asm/kvm_host.h               |   3 +-
 arch/x86/include/uapi/asm/kvm.h               |   1 +
 arch/x86/kvm/svm/svm.c                        |   4 +-
 arch/x86/kvm/vmx/vmx.c                        |  11 +-
 arch/x86/kvm/x86.c                            |  34 +++---
 tools/testing/selftests/kvm/Makefile          |   2 +-
 .../selftests/kvm/x86_64/feature_msrs_test.c  | 113 ++++++++++++++++++
 .../kvm/x86_64/get_msr_index_features.c       |  35 ------
 .../selftests/kvm/x86_64/platform_info_test.c |   2 -
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |  23 ++++
 11 files changed, 189 insertions(+), 61 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/feature_msrs_test.c
 delete mode 100644 tools/testing/selftests/kvm/x86_64/get_msr_index_features.c


base-commit: 540fa2dc3c53613817bd7b345e1466d4a6f0ab5d
-- 
2.46.0.rc2.264.g509ed76dc8-goog



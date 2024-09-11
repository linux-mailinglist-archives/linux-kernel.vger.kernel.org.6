Return-Path: <linux-kernel+bounces-325598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27086975BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFF9283E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C651514CC;
	Wed, 11 Sep 2024 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XYMuGdVT"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A9149C69
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087342; cv=none; b=JiSxPmPAml1UcTzFFicEnkc4y25SJgSstLfuZwDMB/9dmRTew3IEJGWU1q7W2JzwD33mjTezIjfOx9gLBpk7KSeNMhdqp5sG2qp043ti1W/i2CqeOT/BG61/NI8g8DJB0hnD90akEL1T/iJDm8uWK+A03KfVG9PjFrYBjNrfY1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087342; c=relaxed/simple;
	bh=i3WL/U3Ij/2riywM9Udf//RtaBTjCk16LTXvMwDfo9g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aAH82EOILOz3fsztx9JG7n8dDKHLAaHHKIy99RdKdCQA/DQiiB5VQ6C+1ZB7yhp288eKRHghqUC+W5kMsW2aYX8ubUcgLTPQmr4Npm2PKTOdstpE3Mxo80TauOt+lxJPQTXfbAHNcOFHf9z0hkwTEm4ygaHbN1JmGuCexReoBLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XYMuGdVT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7d1fe1dd173so369850a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726087340; x=1726692140; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orNyJOAcZD+rHQnmy1du5vjxEg5EiEek+mzQd7BXIvg=;
        b=XYMuGdVTyrti6o4MMvInGZ9YCSn/v8tfKx2rRyUkugkOxGnXyJcPPRbohGKfJRXOCg
         G5mydwKxEApE4XRWkj8l8aFo1scd0rLcnNWLjrMw70Dv5y0sIW7v48URrDOIZ4xFB27W
         W0OlH+nlCGyQldSet67qIO5fgSYGGhK/sODIKTggkz5LgnoxMxiPGUGRc2zHUoLKsvTd
         nKd+wRSi+Rxgcl30aMvtyziUCFDjaqj2GOt2Acle0hN9mTBlTcpphpLNUjop6SfWLpBW
         Ey7FxhcCcmuuiGw5izHexRhj0WGmvHK+0XYE885OzwnYiUZuqHSTzyW3YNiQsgbuuwi1
         omHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726087340; x=1726692140;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orNyJOAcZD+rHQnmy1du5vjxEg5EiEek+mzQd7BXIvg=;
        b=sP/kcNgRvuNZ8jR+Kj8iRMDShZtO6tqhmTe+1X2OGIo/Dnibv0oFsureKMoamjOAy3
         zrVpzmvv40TEauCXaKEyOZlrAmbiaphxL75gnrLdpSSXo5Vzb7v5jBeDVTg4D1x6Kkrd
         okUBYzYsI0ZJ7mUx0sgrP78lcccEYQIyCp/XTyYyVORSzBBBmwJJtxMysinQy7Cw4hSu
         bj1zinmFM8BEQa9iNKrgGP96b+xnAICGSoagG86pjIxwWeT04k5agn3vMjTXwhGwuBT/
         /MXy969q2aOkHgQJFzQ7OGJPGMHRQX86u/+KOKbCZPqgzz5Q6Fmhn+VCblcy0GnlwdKX
         u0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWo9ZX1J6NLUWG2YCR3eQ8WSeNDkDOOpy/wCtmQ/W0J9DgTozzt65sKXNrAc84AaQWACpArvnM4+7hKNms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPS8FbdhYQrKA8UskNRmBdVVyQDHdPoc4S5QEoW3tz2APTeC1J
	EF6/+2Hm0yZg1QW3xCs76o6G/oyAkKIGsKVLr9czlshLGBdsHTWg/A7xjTOK9VbOr+elcfqxfNW
	GVA==
X-Google-Smtp-Source: AGHT+IFaujE7hEx/7weEqZv4CBEUENGoY66e8hJCtiz3GOrHctREiAah0BDLkxA9YXouCGo9V+1XVtyv7hY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:dac9:b0:1fd:60c4:6930 with SMTP id
 d9443c01a7336-2076e44762amr350555ad.10.1726087340433; Wed, 11 Sep 2024
 13:42:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Sep 2024 13:41:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911204158.2034295-1-seanjc@google.com>
Subject: [PATCH v2 00/13] KVM: selftests: Morph max_guest_mem to mmu_stress
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Marc/Oliver,

I would love a sanity check on patches 2 and 3 before I file a bug against
gcc.  The code is pretty darn simple, so I don't think I've misdiagnosed the
problem, but I've also been second guessing myself _because_ it's so simple;
it seems super unlikely that no one else would have run into this before.

On to the patches...

The main purpose of this series is to convert the max_guest_memory_test into
a more generic mmu_stress_test.  The patches were originally posted as part
a KVM x86/mmu series to test the x86/mmu changes, hence the v2.

The basic gist of the "conversion" is to have the test do mprotect() on
guest memory while vCPUs are accessing said memory, e.g. to verify KVM and
mmu_notifiers are working as intended.

Patches 1-4 are a somewhat unexpected side quest that I can (arguably should)
post separately if that would make things easier.  The original plan was that
patch 2 would be a single patch, but things snowballed.

Patch 2 reworks vcpu_get_reg() to return a value instead of using an
out-param.  This is the entire motivation for including these patches;
having to define a variable just to bump the program counter on arm64
annoyed me.

Patch 4 adds hardening to vcpu_{g,s}et_reg() to detect potential truncation,
as KVM's uAPI allows for registers greater than the 64 bits the are supported
in the "outer" selftests APIs ((vcpu_set_reg() takes a u64, vcpu_get_reg()
now returns a u64).

Patch 1 is a change to KVM's uAPI headers to move the KVM_REG_SIZE
definition to common code so that the selftests side of things doesn't
need #ifdefs to implement the hardening in patch 4.

Patch 3 is the truly unexpected part.  With the vcpu_get_reg() rework,
arm64's vpmu_counter_test fails when compiled with gcc-13, and on gcc-11
with an added "noinline".  AFAICT, the failure doesn't actually have
anything to with vcpu_get_reg(); I suspect the largely unrelated change
just happened to run afoul of a latent gcc bug.

Pending a sanity check, I will file a gcc bug.  In the meantime, I am
hoping to fudge around the issue in KVM selftests so that the vcpu_get_reg()
cleanup isn't blocked, and because the hack-a-fix is arguably a cleanup
on its own.

v2:
 - Rebase onto kvm/next.
 - Add the aforementioned vcpu_get_reg() changes/disaster.
 - Actually add arm64 support for the fancy mprotect() testcase (I did this
   before v1, but managed to forget to include the changes when posting).
 - Emit "mov %rax, (%rax)" on x86. [James]
 - Add a comment to explain the fancy mprotect() vs. vCPUs logic.
 - Drop the KVM x86 patches (applied and/or will be handled separately).

v1: https://lore.kernel.org/all/20240809194335.1726916-1-seanjc@google.com

Sean Christopherson (13):
  KVM: Move KVM_REG_SIZE() definition to common uAPI header
  KVM: selftests: Return a value from vcpu_get_reg() instead of using an
    out-param
  KVM: selftests: Fudge around an apparent gcc bug in arm64's PMU test
  KVM: selftests: Assert that vcpu_{g,s}et_reg() won't truncate
  KVM: selftests: Check for a potential unhandled exception iff KVM_RUN
    succeeded
  KVM: selftests: Rename max_guest_memory_test to mmu_stress_test
  KVM: selftests: Only muck with SREGS on x86 in mmu_stress_test
  KVM: selftests: Compute number of extra pages needed in
    mmu_stress_test
  KVM: selftests: Enable mmu_stress_test on arm64
  KVM: selftests: Use vcpu_arch_put_guest() in mmu_stress_test
  KVM: selftests: Precisely limit the number of guest loops in
    mmu_stress_test
  KVM: selftests: Add a read-only mprotect() phase to mmu_stress_test
  KVM: selftests: Verify KVM correctly handles mprotect(PROT_READ)

 arch/arm64/include/uapi/asm/kvm.h             |   3 -
 arch/riscv/include/uapi/asm/kvm.h             |   3 -
 include/uapi/linux/kvm.h                      |   4 +
 tools/testing/selftests/kvm/Makefile          |   3 +-
 .../selftests/kvm/aarch64/aarch32_id_regs.c   |  10 +-
 .../selftests/kvm/aarch64/debug-exceptions.c  |   4 +-
 .../selftests/kvm/aarch64/hypercalls.c        |   6 +-
 .../testing/selftests/kvm/aarch64/psci_test.c |   6 +-
 .../selftests/kvm/aarch64/set_id_regs.c       |  18 +-
 .../kvm/aarch64/vpmu_counter_access.c         |  27 ++-
 .../testing/selftests/kvm/include/kvm_util.h  |  10 +-
 .../selftests/kvm/lib/aarch64/processor.c     |   8 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |   3 +-
 .../selftests/kvm/lib/riscv/processor.c       |  66 +++----
 ..._guest_memory_test.c => mmu_stress_test.c} | 161 ++++++++++++++++--
 .../testing/selftests/kvm/riscv/arch_timer.c  |   2 +-
 .../testing/selftests/kvm/riscv/ebreak_test.c |   2 +-
 .../selftests/kvm/riscv/sbi_pmu_test.c        |   2 +-
 tools/testing/selftests/kvm/s390x/resets.c    |   2 +-
 tools/testing/selftests/kvm/steal_time.c      |   3 +-
 20 files changed, 236 insertions(+), 107 deletions(-)
 rename tools/testing/selftests/kvm/{max_guest_memory_test.c => mmu_stress_test.c} (60%)


base-commit: 15e1c3d65975524c5c792fcd59f7d89f00402261
-- 
2.46.0.598.g6f2099f65c-goog



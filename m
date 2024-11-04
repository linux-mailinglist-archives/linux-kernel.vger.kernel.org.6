Return-Path: <linux-kernel+bounces-394924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4AA9BB62D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B8E1F23117
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B30428E37;
	Mon,  4 Nov 2024 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="caCkjVYV"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1218BEE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727130; cv=none; b=I8WPgrecOcRD0vgoPKMmgaFHp62+/3neqrp38gWfiqKBOGnAXGDwrd3feYB8WYB2XSU8ph+E5DSeb3XbHDoTzjoItEN6b6MAH9Ia2HCrdzUF5ga04MzZyl1nsaQVGK23Vx+WIJM0UDXnGofLBnIUvAeR6CSHHWfjsvki7ERuVXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727130; c=relaxed/simple;
	bh=IGlHn80NNycrJBp1h8iQimbPVq54EMSfdblL7J6SlZE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MQka7kJvSd0wVIS1Fb2cUe9CGcsr9pq6vVi+pbPgVDPwsfmWyGfaSKU+xJNFFmxdJhYYKsUxxaLY5wBAIJkx7KBC2M88KG+QwZT/vTwfYUByGB9U+fp6vqOUeIhygDus/4UnQaI9YTshBvL+Oxh1plXlsAhtA3/rE4FdQlLHKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=caCkjVYV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea7cfb6e0fso41583447b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730727128; x=1731331928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HxxA8qOKzLiUY9hT0OrM+BS/2F7uNJDid+1gg9MXvMQ=;
        b=caCkjVYVQ0+JtPUuA3uj1lHA5552ZrHf2lrc4/1ivBZb0ISEP2bj/NkOEDKrkrLTiC
         f1wd15bIPZddUtOGKDTR7E+Jd3csJ76r4iWhwOXUKFgKTsfW89xHg1klyXrxODBmfnjL
         JEvSRZUv7LdB93xZFZ0Sar76gw40qyHH41bSsfrmGl3nQ0PLFlgPPL9llbeI2D5gu178
         wjnfealzez6xNoukzDfzaH8CQz6bk9Sowq0bwFYXrkppZzvz5hMEDmtLClGKDn2HQSzx
         T7OXyUhNHEKG1zlD4kcqfgjJ6S3/oIHeIgSRLL/xHgHqU9im9Ul0yWXSdFRmCDEFZxjr
         F1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727128; x=1731331928;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HxxA8qOKzLiUY9hT0OrM+BS/2F7uNJDid+1gg9MXvMQ=;
        b=kX5YB8wE6SHfV1Rf5gVgm6UoROVFfhk2n57YSwIkq9tsxqTF63QS725b9VVmNQF4dq
         eYoKefiuao6ymVym5IUew5oUdaFjm4oNUJjWWem5iqr5YR5DcVEvrWrp6dXD01l8Dg+c
         uGhQKmE4WYudXkhJXkYBpYzvsUlcIz1131Fj5xMvif7ujf3pOwd0CXW3BzBOfoYwVDhG
         jh+BflLmfr7+wHEpGCJIyCJPa9n4M9iewNpF35UAIixQ31TYf761+aKS5pVkLFb+cF/o
         cyy+canCwm/qEprpKmMWhWsCuzy3xMUNOzVZdgA53IlXrO3zQTv4594DriwGdQBXxJes
         q5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiS6Q/FMgaFtKr7QQO+E6QBD782k63vqR5flEpq2ryCHUf1EzD8Vx79yEx/Z8HckmxRk9D35EgAji9/4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFq/sGkzlTACR+eKw7XuteVqV8RSX/AtgczDkYpQIpgnw7rnrZ
	XOU76V91MVUJ7hYvtWIDdfOPWtx1MdRQBgk7FdKlWJy2PAs6upcyN8lO83NX7zpjyqyCH7PzbM1
	lGBBxpQ==
X-Google-Smtp-Source: AGHT+IEVbGHAWJltvuCaJ/azx5l/1Epto/a62kcYMbtely3oTwYCl8xO82ZRv+bF0K6w89ccEMj5+aQu0mFT
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a81:a8c3:0:b0:6e3:d670:f603 with SMTP id
 00721157ae682-6e9d8aada53mr4236877b3.3.1730727127723; Mon, 04 Nov 2024
 05:32:07 -0800 (PST)
Date: Mon,  4 Nov 2024 13:31:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104133204.85208-1-qperret@google.com>
Subject: [PATCH 00/18] KVM: arm64: Non-protected guest stage-2 support for pKVM
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

This series moves the stage-2 page-table management of non-protected
guests to EL2 when pKVM is enabled. This is only intended as an
incremental step towards a 'feature-complete' pKVM, there is however a
lot more that needs to come on top.

With that series applied, pKVM provides near-parity with standard KVM
from a functional perspective all while Linux no longer touches the
stage-2 page-tables itself at EL1. The majority of mm-related KVM
features work out of the box, including MMU notifiers, dirty logging,
RO memslots and things of that nature. There are however two gotchas:

 - We don't support mapping devices into guests: this requires
   additional hypervisor support for tracking the 'state' of devices,
   which will come in a later series. No device assignment until then.

 - Stage-2 mappings are forced to page-granularity even when backed by a
   huge page for the sake of simplicity of this series. I'm only aiming
   at functional parity-ish (from userspace's PoV) for now, support for
   HP can be added on top later as a perf improvement.

Please note that the approach taken in this series is a departure from
the existing out-of-tree implementation in Android which relies on
long-term GUP pinning even for non-protected guests which I felt was a
non-starter for upstream. Android will obviously migrate to the
upstream implementation when that lands.

The last two patches are likely to be the most 'controversial' ones as
they do the integration into KVM (please see the notes in the commit
messages), but obviously feedback is more than welcome throughout. The
overall idea is to use the KVM/arm pgtable API as the 'contract' between
the standard KVM and pKVM backend implementations. With pKVM we use
wrappers at EL1 with the exact same prototype as the kvm_pgtable_stage2_*()
functions that end up simply doing hypercalls as that allows easy-ish
plumbing in kvm/mmu.c. The pKVM EL1 helpers use a simple RB-tree to
maintain the GFN->PFN mappings as we need to be able to walk those from
EL1. For the record, I have tried a few other data-structures. A maple
tree doesn't lend itself very well to the use-case as we need to
pre-allocate the node from outside the mmu_lock critical section. I also
considered using a 'dummy' s2 page-table at EL1 purely for tracking
purposes, and hook deep into pgtable.c to issue hypercalls to notify
pKVM directly from there. That has very nice properties, but gets
horrible as we try to elide the TLB invalidation / CMOs logic from the
dummy page-table.

The series is organized as follows:

 - Patches 01 to 04 move the host ownership state tracking from the
   host's stage-2 page-table to the hypervisor's vmemmap. This avoids
   fragmenting the host stage-2 for shared pages, which is only needed
   to store an annotation in the SW bits of the corresponding PTE. All
   pages mapped into non-protected guests are shared from pKVM's PoV,
   so the cost of stage-2 fragmentation will increase massively as we
   start tracking that at EL2. Note that these patches also help with
   the existing sharing for e.g. FF-A, so they could possibly be merged
   separately from the rest of the series.

 - Patches 05 to 07 implement a minor refactoring of the pgtable code to
   ease the integration of the pKVM MMU later on.

 - Patches 08 to 16 introduce all the infrastructure needed on the pKVM
   side for handling guest stage-2 page-tables at EL2.

 - Patches 17 and 18 plumb the newly introduced pKVM support into
   KVM/arm64.

Patches based on 6.12-rc5, tested on Pixel 6 and Qemu.

Thanks!
Quentin

Marc Zyngier (1):
  KVM: arm64: Introduce pkvm_vcpu_{load,put}()

Quentin Perret (17):
  KVM: arm64: Change the layout of enum pkvm_page_state
  KVM: arm64: Move enum pkvm_page_state to memory.h
  KVM: arm64: Make hyp_page::order a u8
  KVM: arm64: Move host page ownership tracking to the hyp vmemmap
  KVM: arm64: Pass walk flags to kvm_pgtable_stage2_mkyoung
  KVM: arm64: Pass walk flags to kvm_pgtable_stage2_relax_perms
  KVM: arm64: Make kvm_pgtable_stage2_init() a static inline function
  KVM: arm64: Introduce {get,put}_pkvm_hyp_vm() helpers
  KVM: arm64: Introduce __pkvm_host_share_guest()
  KVM: arm64: Introduce __pkvm_host_unshare_guest()
  KVM: arm64: Introduce __pkvm_host_relax_guest_perms()
  KVM: arm64: Introduce __pkvm_host_wrprotect_guest()
  KVM: arm64: Introduce __pkvm_host_test_clear_young_guest()
  KVM: arm64: Introduce __pkvm_host_mkyoung_guest()
  KVM: arm64: Introduce __pkvm_tlb_flush_vmid()
  KVM: arm64: Introduce the EL1 pKVM MMU
  KVM: arm64: Plumb the pKVM MMU in KVM

 arch/arm64/include/asm/kvm_asm.h              |   9 +
 arch/arm64/include/asm/kvm_host.h             |   4 +
 arch/arm64/include/asm/kvm_pgtable.h          |  42 ++-
 arch/arm64/include/asm/kvm_pkvm.h             |  28 ++
 arch/arm64/kvm/arm.c                          |  23 +-
 arch/arm64/kvm/hyp/include/nvhe/gfp.h         |   6 +-
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  38 +-
 arch/arm64/kvm/hyp/include/nvhe/memory.h      |  43 ++-
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h        |  15 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 210 ++++++++++-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 333 ++++++++++++++++--
 arch/arm64/kvm/hyp/nvhe/page_alloc.c          |  14 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                |  55 +++
 arch/arm64/kvm/hyp/nvhe/setup.c               |   7 +-
 arch/arm64/kvm/hyp/pgtable.c                  |  13 +-
 arch/arm64/kvm/mmu.c                          | 110 ++++--
 arch/arm64/kvm/pkvm.c                         | 194 ++++++++++
 arch/arm64/kvm/vgic/vgic-v3.c                 |   6 +-
 18 files changed, 1007 insertions(+), 143 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog



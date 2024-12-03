Return-Path: <linux-kernel+bounces-429244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EEB9E197A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF1B161AE4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA64A1E1C05;
	Tue,  3 Dec 2024 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGDLFwzj"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A541E25F0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222262; cv=none; b=WuuQwQZxexzYvPRl4bgdDYeoaqAUN36Vx0uqP1eAI4sNpv+1V1c/DMoMt4lKJmxLYwalKDYPlMojeCpsQBBloLwS7Ya4ScqGXvnCU+CLyaSpn+HUxopaTOKK6grbCWI1MT4f1EnXMK0LcT0xsI/bYVuooZQOm5QGZGkVSoeAZPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222262; c=relaxed/simple;
	bh=q3+FxbCcBkiskXSn831XHlgU64Eqo1nUx21JojjeJx4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mi/KrMm/ZGFc/oCzjFu4HWAOVLyvxXFtJvVFXZMHam+PIOo5Wy3/RKfB9OVDPv+3uktc4h1psMTFObQmXahfgD6GAT3Q5I7y1TIB+OAn/DwUACo8I7og52NAsitSYbpMeA2wlGMsq9DLKe55/5Rv9hFK/6x0z5gunNBLbQT/orw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGDLFwzj; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d0b5036394so2854878a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733222257; x=1733827057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bhVcEYzfRw8eAXsIDOKtTfeOpA28Wa0JxjqlOgFYMJ0=;
        b=jGDLFwzjX0Kdua4EheEbK7ToyVEoXKCLwkNYNXUojA+VzO3dokFOVevperfzjvuj05
         WkWuojN68hISg+LuNwJMUWEM0mN7XGcdtLj+IlB2rTBWGsTDi5ZvLNgk6r3p/YTKsusG
         GvbxiJlB6s2iOo9U4yPRjGMHbfvIxJrL5T8kWX55zV6uJh+WB7njWBCYgnzuuVUrI7Lm
         rceheWCWVUl7YSzm1HnPdaUtOxcH0/8aqaMUteLtbrDUT4i1DEA5AUJImlc/XyV5DaMA
         DXzdYL1hAfV7A0yPi/1dR4KTembK4117B+Klx0l9FsfR+bjkstSQWbcNZV6s2JKd4+NZ
         Pb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222257; x=1733827057;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bhVcEYzfRw8eAXsIDOKtTfeOpA28Wa0JxjqlOgFYMJ0=;
        b=aa8BGfsk4VBSxH46qpgxxl0ImxQOf10Z9W2G8CBPGYXwK+cbNSYa74Ngfjl6jXTTt9
         OVlqCSwe0qDmau863A7N+Dr/pYsX1mid4iLbY3s7cBPwn4BL+XO+/xqSJvpn1GaBmGOk
         VMINB6B9i3nI9hNr4bMOjqkPclem3jVK/wXFDuRyJBXdYChUo12h9MO71suDsJch6RmK
         BlFsUDgxQOlwQoR0Ftlsll/Hy6WKwabQElTUtxQvRsUdrribJ/IagmEhiJEVCAETSxhE
         wPhGXQCZz596o39rlHFBONSSvc740Dnh3k+jHmKCWrSBR9dLh7HNkkP6sPyvgXJFYgEG
         UFjg==
X-Forwarded-Encrypted: i=1; AJvYcCVC4YhiojxegZhdg5BZgzWt5yUUdOwHz9Jwwl1Oazk1RYiRpVAJ6HtAM2j1YbCuP2j5jXrUSIGNPp/46qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyR+6lArXRfmIQE6ASF0fwUgrHc5mLNyQoIc5o1P3KB30jtmSR
	BlZVPcXInNKiK0k7cy6Zd6wgDXaJrmlEpK0Bb8NP2O8NDPZHyKwu29viztFaYlEbIsaZ/BeHJcW
	vn9n5ug==
X-Google-Smtp-Source: AGHT+IHYV6enzbdprLHZMQD92QaUuZlgGwTGzCSSf0HmxvgO/jp3WQcTuWxTF7EcB+yhrb6mkrn1yXRToanq
X-Received: from edvi16.prod.google.com ([2002:aa7:dd10:0:b0:5d0:27b6:2cde])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:510e:b0:5d0:8606:9ba1
 with SMTP id 4fb4d7f45d1cf-5d10cb82718mr1488954a12.24.1733222257469; Tue, 03
 Dec 2024 02:37:37 -0800 (PST)
Date: Tue,  3 Dec 2024 10:37:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203103735.2267589-1-qperret@google.com>
Subject: [PATCH v2 00/18] KVM: arm64: Non-protected guest stage-2 support for pKVM
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

This is the v2 of the series adding support for non-protected guests to
pKVM. Please refer to v1 for all the context:

  https://lore.kernel.org/kvmarm/20241104133204.85208-1-qperret@google.com/

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

Patches based on 6.13-rc1, tested on Pixel 6 and Qemu.

Changes in v2:
 - Rebased on 6.13-rc1 (small conflicts with 2362506f7cff ("KVM: arm64:
   Don't mark "struct page" accessed when making SPTE young") in
   particular)
 - Fixed kerneldoc breakage for __unmap_stage2_range()
 - Fixed pkvm_pgtable_test_clear_young() to use correct HVC
 - Folded guest_get_valid_pte() into __check_host_unshare_guest() for
   clarity

Thanks,
Quentin

Marc Zyngier (1):
  KVM: arm64: Introduce __pkvm_vcpu_{load,put}()

Quentin Perret (17):
  KVM: arm64: Change the layout of enum pkvm_page_state
  KVM: arm64: Move enum pkvm_page_state to memory.h
  KVM: arm64: Make hyp_page::order a u8
  KVM: arm64: Move host page ownership tracking to the hyp vmemmap
  KVM: arm64: Pass walk flags to kvm_pgtable_stage2_mkyoung
  KVM: arm64: Pass walk flags to kvm_pgtable_stage2_relax_perms
  KVM: arm64: Make kvm_pgtable_stage2_init() a static inline function
  KVM: arm64: Add {get,put}_pkvm_hyp_vm() helpers
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
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  38 +--
 arch/arm64/kvm/hyp/include/nvhe/memory.h      |  43 ++-
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h        |  15 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            | 210 +++++++++++-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 312 ++++++++++++++++--
 arch/arm64/kvm/hyp/nvhe/page_alloc.c          |  14 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                |  56 ++++
 arch/arm64/kvm/hyp/nvhe/setup.c               |   7 +-
 arch/arm64/kvm/hyp/pgtable.c                  |  13 +-
 arch/arm64/kvm/mmu.c                          | 109 ++++--
 arch/arm64/kvm/pkvm.c                         | 195 +++++++++++
 arch/arm64/kvm/vgic/vgic-v3.c                 |   6 +-
 18 files changed, 987 insertions(+), 143 deletions(-)

-- 
2.47.0.338.g60cca15819-goog



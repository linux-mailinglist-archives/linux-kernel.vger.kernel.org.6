Return-Path: <linux-kernel+bounces-405651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD229C54D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C88E284C69
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72152259E1;
	Tue, 12 Nov 2024 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="slQA91hl"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632CF2245E0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407851; cv=none; b=KieCCIZt+giSb/U7nb2cZYDyJcfrU8L5Foc8uO8wB8vqdq7xLfWd/ZaiRtmUXYEsvDUhmnZfx0p7cwK8M54K1CsNlROvIjyJdq7gAL8+VJ4zrenvrTvqpa2eSwDm/9nKrfFqzPAve3fhrBPISjkt5XbnTTbBgQ4pUtSnHodxrrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407851; c=relaxed/simple;
	bh=hgZL6oZxZJ/upPoc4TH+wtYRMYKp5HdcedWyuqvmCBs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I6jX5GDaUluJ1L1PhqfMMKaliJXDKZw91+MEhOg09m+IeqdKk79w4PnGaaT11vxe/o1PIWIvKhZhZqBsFdPAfl4Ga3WliVQuhFTIedojToa0VvG037VGOEyZP73DC424aoHlqy4T2wzJbJe8NutSSIDTp1ISGyI5GVTlQfmfAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=slQA91hl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso43242365e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731407847; x=1732012647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DTmm4txF/WGuXlLhJZrujPK9yr3N/UoD68EIAXZP55k=;
        b=slQA91hlRRv7m5WSbunQx68kxz+zxQm/IzdtCxVhrSspNZttPudMiT9HCJ1WYf0Jxh
         Ck8nqQ1kjkO100Oqg4VOqYk69NPxyV3gGJMpmenm4HRd3uEvtVLBrhNhemcgzZZdn6z5
         JfxI2OGus2RX7SZE6vKar4ORkzXYFacRIaDXT8fPFqPYzC5Yeb0vvcgGBeS2u6tBlo4R
         OcplHchdIqoNK2/wIqfZDpnyT/U8l/tDV5En5V41VsfKuT0CnLoyxssFGLvHAD39+JgP
         aW2vR5Zj5ypEQHrpmq2wc+F2VA6qCff4je5/baLDIF80mt3rremyG7DoN9p0eoruZHig
         lcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731407847; x=1732012647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTmm4txF/WGuXlLhJZrujPK9yr3N/UoD68EIAXZP55k=;
        b=s8TduRl1PJ2gRNi7o/lQR8+8m/Rdw/saQ8+Vsh9pXjrzMmtNo/3O83yOFNjS2/hVZi
         rdpxWG3FwgKDKs6driXDfg4RfO3Zv+nMK1h+k6YHH7Z5f65VvFvi/5WL922RFlJonhXn
         ic7+mhcZplGgHRkno/EB+s5/ex1oDqrIRGs7DRVzUUrQYD2cbqwYtTSIuyQ2ALlri9JD
         OnETAd1V4/Dwn46YUrKHxCl8i9nv0BtuUy0AN3MJGC4d3puiF0qm4uMvYhlFyA03zdBN
         IJdGJplH92bE8A7nRa2KcXP0dD/PAnbPn6i3k5/nlJdeqpnC58BFsLluSiyCrby2So/A
         zxTw==
X-Forwarded-Encrypted: i=1; AJvYcCUG13lCNUjyamgHr/5RgDXnN7iPFxrdw2A+0OLjy7cN4GylwCr/kMxko0wOPE5rBONxBFr68z52ZAm38Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeyBun7hm58yD7xT7LiWgxPaLuSUnpQiFRFqelZMySvRg3l5sf
	ibGs0cSb5GhVw96dUYjxQaKWYA72oR5a5zqXu/LdWqJeOouKv61A1WTh9u3Fsl4=
X-Google-Smtp-Source: AGHT+IHSSYdGHvj45CoxKZcPcWbqJL7VVuLCtim37dYRMvlOQFBAgm551VkAfgqBy0dlaMf5QQCexA==
X-Received: by 2002:a05:600c:3c8f:b0:431:4e25:fe42 with SMTP id 5b1f17b1804b1-432b751e28fmr123431995e9.32.1731407846604;
        Tue, 12 Nov 2024 02:37:26 -0800 (PST)
Received: from pop-os.. ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432bbf436ffsm142270955e9.44.2024.11.12.02.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:37:26 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: suzuki.poulose@arm.com,
	oliver.upton@linux.dev,
	coresight@lists.linaro.org,
	kvmarm@lists.linux.dev
Cc: James Clark <james.clark@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Morse <james.morse@arm.com>,
	Shiqi Liu <shiqiliu@hust.edu.cn>,
	Fuad Tabba <tabba@google.com>,
	Mark Brown <broonie@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/12] kvm/coresight: Support exclude guest and exclude host
Date: Tue, 12 Nov 2024 10:36:59 +0000
Message-Id: <20241112103717.589952-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FEAT_TRF is a Coresight feature that allows trace capture to be
completely filtered at different exception levels, unlike the existing
TRCVICTLR controls which may still emit target addresses of branches,
even if the following trace is filtered.

Without FEAT_TRF, it was possible to start a trace session on a host and
also collect trace from the guest as TRCVICTLR was never programmed to
exclude guests (and it could still emit target addresses even if it
was).

With FEAT_TRF, the current behavior of trace in guests exists depends on
whether nVHE or VHE are being used. Both of the examples below are from
the host's point of view, as Coresight isn't accessible from guests.
This patchset is only relevant to when FEAT_TRF exists, otherwise there
is no change.

Current behavior:

  nVHE/pKVM:

  Because the host and the guest are both using TRFCR_EL1, trace will be
  generated in guests depending on the same filter rules the host is
  using. For example if the host is tracing userspace only, then guest
  userspace trace will also be collected.

  (This is further limited by whether TRBE is used because an issue
  with TRBE means that it's completely disabled in nVHE guests, but it's
  possible to have other tracing components.)

  VHE:

  With VHE, the host filters will be in TRFCR_EL2, but the filters in
  TRFCR_EL1 will be active when the guest is running. Because we don't
  write to TRFCR_EL1, guest trace will be completely disabled.

New behavior:

The guest filtering rules from the Perf session are now honored for both
nVHE and VHE modes. This is done by either writing to TRFCR_EL12 at the
start of the Perf session and doing nothing else further, or caching the
guest value and writing it at guest switch for nVHE. In pKVM, trace is
now be disabled for both protected and unprotected guests.

There is also an optimization where the SPE and Coresight drivers pass
their enabled state to KVM. This means in the common case KVM doesn't
have to touch any sysregs when the feature isn't in use.

Applies to kvmarm/next (25a8556b54007)

---

Changes since V6 [5]:
  * Implement a better "do nothing" case where both the SPE and Coresight
    drivers give the enabled state to KVM, allowing some register
    reads to be dropped.
  * Move the state and feature flags out of the vCPU into the per-CPU
    host_debug_state.
  * Simplify the switch logic by adding a new flag HOST_STATE_SWAP_TRFCR
    and only storing a single TRFCR value.
  * Rename vcpu flag macros to a more generic kvm_flag...

Changes since V5 [4]:
  * Sort new sysreg entries by encoding
  * Add a comment about sorting arch/arm64/tools/sysreg
  * Warn on preemptible() before calling smp_processor_id()
  * Pickup tags
  * Change TRFCR_EL2 from SysregFields to Sysreg because it was only
    used once

Changes since V4 [3]:
  * Remove all V3 changes that made it work in pKVM and just disable
    trace there instead
  * Restore PMU host/hyp state sharing back to how it was
    (kvm_pmu_update_vcpu_events())
  * Simplify some of the duplication in the comments and function docs
  * Add a WARN_ON_ONCE() if kvm_etm_set_guest_trfcr() is called when
    the trace filtering feature doesn't exist.
  * Split sysreg change into a tools update followed by the new register
    addition

Changes since V3:
  * Create a new shared area to store the host state instead of copying
    it before each VCPU run
  * Drop commit that moved SPE and trace registers from host_debug_state
    into the kvm sysregs array because the guest values were never used
  * Document kvm_etm_set_guest_trfcr()
  * Guard kvm_etm_set_guest_trfcr() with a feature check
  * Drop Mark B and Suzuki's review tags on the sysreg patch because it
    turned out that broke the Perf build and needed some unconventional
    changes to fix it (as in: to update the tools copy of the headers in
    the same commit as the kernel changes)

Changes since V2:

  * Add a new iflag to signify presence of FEAT_TRF and keep the
    existing TRBE iflag. This fixes the issue where TRBLIMITR_EL1 was
    being accessed even if TRBE didn't exist
  * Reword a commit message

Changes since V1:

  * Squashed all the arm64/tools/sysreg changes into the first commit
  * Add a new commit to move SPE and TRBE regs into the kvm sysreg array
  * Add a comment above the TRFCR global that it's per host CPU rather
    than vcpu

Changes since nVHE RFC [1]:

 * Re-write just in terms of the register value to be written for the
   host and the guest. This removes some logic from the hyp code and
   a value of kvm_vcpu_arch:trfcr_el1 = 0 no longer means "don't
   restore".
 * Remove all the conditional compilation and new files.
 * Change the kvm_etm_update_vcpu_events macro to a function.
 * Re-use DEBUG_STATE_SAVE_TRFCR so iflags don't need to be expanded
   anymore.
 * Expand the cover letter.

Changes since VHE v3 [2]:

 * Use the same interface as nVHE mode so TRFCR_EL12 is now written by
   kvm.

[1]: https://lore.kernel.org/kvmarm/20230804101317.460697-1-james.clark@arm.com/
[2]: https://lore.kernel.org/kvmarm/20230905102117.2011094-1-james.clark@arm.com/
[3]: https://lore.kernel.org/linux-arm-kernel/20240104162714.1062610-1-james.clark@arm.com/
[4]: https://lore.kernel.org/all/20240220100924.2761706-1-james.clark@arm.com/
[5]: https://lore.kernel.org/linux-arm-kernel/20240226113044.228403-1-james.clark@arm.com/

James Clark (12):
  arm64/sysreg: Add a comment that the sysreg file should be sorted
  tools: arm64: Update sysreg.h header files
  arm64/sysreg/tools: Move TRFCR definitions to sysreg
  KVM: arm64: Make vcpu flag macros more generic
  KVM: arm64: Move SPE and TRBE flags to host data
  KVM: arm64: Add flag for FEAT_TRF
  KVM: arm64: arm_spe: Give SPE enabled state to KVM
  KVM: arm64: Don't hit sysregs to see if SPE is enabled or not
  KVM: arm64: coresight: Give TRBE enabled state to KVM
  KVM: arm64: Don't hit sysregs to see if TRBE is enabled or not
  KVM: arm64: Swap TRFCR on guest switch
  coresight: Pass guest TRFCR value to KVM

 arch/arm64/include/asm/kvm_host.h             | 123 +++---
 arch/arm64/include/asm/kvm_hyp.h              |   2 +-
 arch/arm64/include/asm/sysreg.h               |  12 -
 arch/arm64/kvm/arm.c                          |   3 -
 arch/arm64/kvm/debug.c                        |  97 ++++-
 arch/arm64/kvm/hyp/exception.c                |  12 +-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c            | 118 +++--
 arch/arm64/kvm/hyp/nvhe/switch.c              |   2 +-
 arch/arm64/kvm/inject_fault.c                 |   4 +-
 arch/arm64/kvm/mmio.c                         |  10 +-
 arch/arm64/tools/sysreg                       |  38 ++
 .../coresight/coresight-etm4x-core.c          |  43 +-
 drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   3 +
 drivers/hwtracing/coresight/coresight-trbe.c  |  15 +-
 drivers/perf/arm_spe_pmu.c                    |  13 +-
 tools/arch/arm64/include/asm/sysreg.h         | 410 +++++++++++++++++-
 tools/include/linux/kasan-tags.h              |  15 +
 18 files changed, 755 insertions(+), 167 deletions(-)
 create mode 100644 tools/include/linux/kasan-tags.h

-- 
2.34.1



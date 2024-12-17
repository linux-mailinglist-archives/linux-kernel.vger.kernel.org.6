Return-Path: <linux-kernel+bounces-449955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A33A79F58A9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E2416CA38
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E291FA149;
	Tue, 17 Dec 2024 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DwHjNqs9"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5A01F8F10
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470467; cv=none; b=Tq2kkALykhjSWTjasd4zbV5e6GJlcxABdtnil8VDTZgGP04F69eYulNTv5oLD88+zBo+eglV8EdAW8LgNwx1oeqreUeal4Zq0liGk5N9h8fI5VhR7xGKtuozE+kJDg5szp4dBjm1ZICXWbn3oZWPag+9dmy9EWsb56WCXH1mQvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470467; c=relaxed/simple;
	bh=W1ISGVP55xvU3h/rGaNOncCwYMUGsTzFuu20h9s82a0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sLz/zlVkChqK//l0ootokHzs7R+3adcLe8rgBI/CxKfOohCb/Wdd3lF/HY/aDWu4SuJGjMcv5ESOkz0zpT7TxwG/55XyZ7hj50j9t5qyAPdD/vdoANBhRjFfAQwBimpVTkfO83kyN5gB7mDnFuTgNWfuZA1WOzHBzCrUUguSQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DwHjNqs9; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734470459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V7VePf0YbJoItYMxVl7REHFnpHp2lyNorsluFMzYnjk=;
	b=DwHjNqs9ZJEVa2BRt7tkMQTKkExlrU1VLlZ3bEESNQVRPZAB0l2+tlmIaui/FGWl1yIleC
	pqvYKBTuMkWQWjEiZmlaMKAPd3lexI7Igp7lmOorTb7zvD7BKQQQt2bCMUnqHT+jbIkino
	gNU9YOi2BbTJIqqlGbNPXBDWUibgE60=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mingwei Zhang <mizhang@google.com>,
	Colton Lewis <coltonlewis@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 00/18] KVM: arm64: Support FEAT_PMUv3 on Apple hardware
Date: Tue, 17 Dec 2024 13:20:30 -0800
Message-Id: <20241217212048.3709204-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

One of the interesting features of some Apple M* parts is an IMPDEF trap
that routes EL1/EL0 accesses of the PMUv3 registers to EL2. This allows
a hypervisor to emulate an architectural PMUv3 on top of the IMPDEF PMU
hardware present in the CPU.

And if you squint, this _might_ look like a CPU erratum :-)

This series takes advantage of these IMPDEF traps to provide PMUv3 to
KVM guests. As a starting point, only expose the fixed CPU cycle counter
and no event counters. Conveniently, this is enough to get Windows
running as a KVM guest on Apple hardware.

I've tried to keep the deviation to a minimum by refactoring some of the
flows used for PMUv3, e.g. computing PMCEID from the arm_pmu bitmap
instead of reading hardware directly.

RFC -> v1:
 - Rebase to 6.13-rc3
 - Add support for 1 event counter in addition to CPU cycle counter
 - Don't sneak past the PMU event filter (Marc)
 - Have the PMU driver provide a PMUv3 -> HW event ID mapping (Marc)

Tested on my M2 with Linux and Windows guests. If possible, I'd
appreciate someone testing on an M1 as I haven't added those MIDRs to
the erratum yet.

Oliver Upton (18):
  drivers/perf: apple_m1: Refactor event select/filter configuration
  drivers/perf: apple_m1: Support host/guest event filtering
  drivers/perf: apple_m1: Map generic branch events
  drivers/perf: apple_m1: Provide helper for mapping PMUv3 events
  KVM: arm64: Compute PMCEID from arm_pmu's event bitmaps
  KVM: arm64: Always support SW_INCR PMU event
  KVM: arm64: Remap PMUv3 events onto hardware
  KVM: arm64: Use a cpucap to determine if system supports FEAT_PMUv3
  KVM: arm64: Drop kvm_arm_pmu_available static key
  KVM: arm64: Use guard() to cleanup usage of arm_pmus_lock
  KVM: arm64: Move PMUVer filtering into KVM code
  KVM: arm64: Compute synthetic sysreg ESR for Apple PMUv3 traps
  KVM: arm64: Advertise PMUv3 if IMPDEF traps are present
  KVM: arm64: Advertise 0 event counters for IMPDEF PMU
  arm64: Enable IMP DEF PMUv3 traps on Apple M2
  drivers/perf: apple_m1: Map a few more PMUv3 events
  KVM: arm64: Provide 1 event counter on IMPDEF hardware
  KVM: arm64: selftests: Add test for probing PMUv3 sysregs

 arch/arm64/include/asm/apple_m1_pmu.h         |   1 +
 arch/arm64/include/asm/cpufeature.h           |  28 +---
 arch/arm64/kernel/cpu_errata.c                |  38 +++++
 arch/arm64/kernel/cpufeature.c                |  19 +++
 arch/arm64/kernel/image-vars.h                |   5 -
 arch/arm64/kvm/arm.c                          |   4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h       |   4 +-
 arch/arm64/kvm/hyp/vhe/switch.c               |  22 +++
 arch/arm64/kvm/pmu-emul.c                     | 127 +++++++++++-----
 arch/arm64/kvm/pmu.c                          |  10 +-
 arch/arm64/tools/cpucaps                      |   2 +
 drivers/perf/apple_m1_cpu_pmu.c               | 103 ++++++++++---
 include/kvm/arm_pmu.h                         |  15 +-
 include/linux/perf/arm_pmu.h                  |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/aarch64/pmuv3_register_probe.c        | 135 ++++++++++++++++++
 16 files changed, 407 insertions(+), 108 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/aarch64/pmuv3_register_probe.c


base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
-- 
2.39.5



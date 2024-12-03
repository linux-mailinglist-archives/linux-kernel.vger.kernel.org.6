Return-Path: <linux-kernel+bounces-430051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1F99E2C12
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B153428432C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11399205E23;
	Tue,  3 Dec 2024 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AcS7Ml/0"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8202204081
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733254386; cv=none; b=c+GD3sWcoY2imT7vyYEF8ZEreFtqk25ckgPO6mwQdNV7xCHv4rzWi2ypV9ZZwNk6itLc1b3jboqD0TsEY8fdx8sCfr6aadrijAUnzDCcZmicQHi1kPn7Yn9ejT/YUcRggs2bpvVIDawy8USSssduYDbTEWohSqyRauitUUgNrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733254386; c=relaxed/simple;
	bh=m4lSy8mwo0EnZPuTDpnErzmcMOYW0h2b7+1b2aIV7aU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IUGHWcZOnBntJR/MGf6pyVghYoYh00lgIUIm+jZWDTVVUBzIWczD2I2dcMOAg8AS7KSi160NRX/p/mYvbpZw4xG6+joPGhQQDOZbuMAgTtJ0s2nVYgaADKjeJzZSQQMNDinEVvXMnWpMR7w8OMHAHBIkD2Oj7SB7HADspbasqj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AcS7Ml/0; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733254372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4K5gdULoo9ry6Ok1UhZcZTA9mvSZ4BXZX/0KfA5QqAQ=;
	b=AcS7Ml/0RnE/6drySXVVeVl277qknOcX0PZK/xrulnb7s18H8ZNMSBuAEeZWNAcTacrxR+
	k6ixLhmZTWKZVXpS4yq4ykIJ+0whhMeOyTQpc/oDIHCMdNF9kqlPTtY8RhzEeEfeG820w+
	nhtl28wt7FVUS7NcXR3h1uUz3JO+/c4=
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
Subject: [RFC PATCH 00/14] KVM: arm64: Support FEAT_PMUv3 on Apple hardware
Date: Tue,  3 Dec 2024 11:32:06 -0800
Message-Id: <20241203193220.1070811-1-oliver.upton@linux.dev>
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

Sending this as an RFC as there are some obvious open Qs:

 - Does enabling PMUv3 meet the bar for allowing IMPDEF crap to slide
   into KVM?

   I certainly think the answer is 'yes', especially considering this
   enables Windows guests.

 - Do we want to support programmable event counters?

   I'm sitting on some extra patches to do this, which maps a few
   architectural event IDs into the PERF_TYPE_HARDWARE space, allowing
   the perf driver to select the right hardware event ID.

   Deciding on a sensible number of counters in this case is a bit of a
   mess, as the M* PMCs aren't entirely fungible (some events only work
   on specific counters).

Applies to 6.13-rc1. I've only enabled this for M2 as it is the hardware
I have, but it is extremely likely this feature works on other M* parts.

It is also very possible I've broken something for true PMUv3 hardware,
as I've only tested on the M2.

Oliver Upton (14):
  drivers/perf: apple_m1: Refactor event select/filter configuration
  drivers/perf: apple_m1: Support host/guest event filtering
  drivers/perf: apple_m1: Map generic branch events
  KVM: arm64: Compute PMCEID from arm_pmu's event bitmaps
  KVM: arm64: Always allow fixed cycle counter
  KVM: arm64: Use PERF_COUNT_HW_CPU_CYCLES for fixed cycle counter
  KVM: arm64: Use a cpucap to determine if system supports FEAT_PMUv3
  KVM: arm64: Drop kvm_arm_pmu_available static key
  KVM: arm64: Use guard() to cleanup usage of arm_pmus_lock
  KVM: arm64: Move PMUVer filtering into KVM code
  KVM: arm64: Compute synthetic sysreg ESR for Apple PMUv3 traps
  KVM: arm64: Advertise PMUv3 if IMPDEF traps are present
  KVM: arm64: Advertise 0 event counters for IMPDEF PMU
  arm64: Enable IMP DEF PMUv3 traps on Apple M2

 arch/arm64/include/asm/apple_m1_pmu.h   |   1 +
 arch/arm64/include/asm/cpufeature.h     |  28 +----
 arch/arm64/kernel/cpu_errata.c          |  38 ++++++
 arch/arm64/kernel/cpufeature.c          |  19 +++
 arch/arm64/kernel/image-vars.h          |   5 -
 arch/arm64/kvm/arm.c                    |   4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h |   4 +-
 arch/arm64/kvm/hyp/vhe/switch.c         |  22 ++++
 arch/arm64/kvm/pmu-emul.c               | 159 +++++++++++++++---------
 arch/arm64/kvm/pmu.c                    |  10 +-
 arch/arm64/tools/cpucaps                |   2 +
 drivers/perf/apple_m1_cpu_pmu.c         |  68 ++++++----
 include/kvm/arm_pmu.h                   |  15 +--
 13 files changed, 248 insertions(+), 127 deletions(-)


base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.39.5


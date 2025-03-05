Return-Path: <linux-kernel+bounces-547699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC245A50C7B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10904171C48
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750882561C4;
	Wed,  5 Mar 2025 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PbKbEfsq"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9B417B50B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741206416; cv=none; b=s4vBUmjrtqVE0IzWOBR6sikrhqKPaqElxjQFslaWyNl7arKhUJzuDr63d/COVWIbTxOYdiHj4BF0FBpME8KqZ9DyHEk0eMVtV2FVnmYGtas+D+pAe3+f7l3GWhKdM2iFHGjwcSrDRK7FoGXF34D46zYO7NFGsrCrCMibP7EoOa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741206416; c=relaxed/simple;
	bh=d6Rr6XQlxAVZ+mE6RfpK/xi1nsseOYVsqwUcmX//sH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OKO2QUMDiB34ghoPZKfa3xHH/Sjg89KGgh7yl7lxtNo7tGRGF/3F5a+3RCTKY+akXFkIWJn1FCHBwtu1ZP9p96wOH9L7nT4DH/o1iXbjP5XbhfvvwtRHuDTYfkmB4DyA5C55Av9Lvm5nKNZbgEj0vrmGxMnZjpU06ho/Hp+UM+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PbKbEfsq; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741206413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/RePMasBxWLOq6wL+myI83nPFWKCp36b5QRiMaqR5Jo=;
	b=PbKbEfsqG25jqb/39HbNK2rqZCcaXv8jbOTnrWTOo7yyt1Mew0xNFcRBUL/jiv2vgRu2EP
	ftTcCC0Sscpq52P3sOzgSOnnkwA875AAedBcNW2U9yzSWikcmV7ZMUJEi7xkZ7MC9uOZ9x
	BNNvhiCV1CmzyuhluPPJ1c80CbIZKf8=
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
	Janne Grunau <j@jannau.net>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH v3 00/14] KVM: arm64: FEAT_PMUv3 on Apple hardware
Date: Wed,  5 Mar 2025 12:26:27 -0800
Message-Id: <20250305202641.428114-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hopefully close to the last spin, this time addressing Marc's comments
on v2.

Full details found in the v1 cover letter.

v1: https://lore.kernel.org/kvmarm/20241217212048.3709204-1-oliver.upton@linux.dev/
v2: https://lore.kernel.org/kvmarm/20250203183111.191519-1-oliver.upton@linux.dev/

v2 -> v3:
 - Reorder and restructure patches to include map_pmuv3_event()
   definition w/ KVM usage.
 - Disallow events that lack a valid PMUv3 -> HW mapping
 - Various minor fixes/typos

Oliver Upton (14):
  drivers/perf: apple_m1: Refactor event select/filter configuration
  drivers/perf: apple_m1: Support host/guest event filtering
  KVM: arm64: Compute PMCEID from arm_pmu's event bitmaps
  KVM: arm64: Always support SW_INCR PMU event
  KVM: arm64: Use a cpucap to determine if system supports FEAT_PMUv3
  KVM: arm64: Drop kvm_arm_pmu_available static key
  KVM: arm64: Use guard() to cleanup usage of arm_pmus_lock
  KVM: arm64: Move PMUVer filtering into KVM code
  KVM: arm64: Compute synthetic sysreg ESR for Apple PMUv3 traps
  KVM: arm64: Advertise PMUv3 if IMPDEF traps are present
  KVM: arm64: Remap PMUv3 events onto hardware
  drivers/perf: apple_m1: Provide helper for mapping PMUv3 events
  KVM: arm64: Provide 1 event counter on IMPDEF hardware
  arm64: Enable IMP DEF PMUv3 traps on Apple M*

 arch/arm64/include/asm/apple_m1_pmu.h   |   1 +
 arch/arm64/include/asm/cpucaps.h        |   2 +
 arch/arm64/include/asm/cpufeature.h     |  28 +----
 arch/arm64/kernel/cpu_errata.c          |  44 ++++++++
 arch/arm64/kernel/cpufeature.c          |  28 +++++
 arch/arm64/kernel/image-vars.h          |   5 -
 arch/arm64/kvm/arm.c                    |   4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h |   4 +-
 arch/arm64/kvm/hyp/vhe/switch.c         |  22 ++++
 arch/arm64/kvm/pmu-emul.c               | 138 +++++++++++++++++-------
 arch/arm64/kvm/pmu.c                    |  10 +-
 arch/arm64/tools/cpucaps                |   2 +
 drivers/perf/apple_m1_cpu_pmu.c         | 101 +++++++++++++----
 include/kvm/arm_pmu.h                   |  12 +--
 include/linux/perf/arm_pmu.h            |   4 +
 15 files changed, 301 insertions(+), 104 deletions(-)


base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
-- 
2.39.5



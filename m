Return-Path: <linux-kernel+bounces-382391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BBF9B0D20
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860001F25664
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E53C18C90E;
	Fri, 25 Oct 2024 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fJ6IvbC0"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE318F2F6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880651; cv=none; b=NnfDmmB8v+fN8hm0U2QpRFYXTj2VGP1mogvl4tEj0ePO44HTcCY+2A3lXjopfaoVXS/rub39nY4mept7JgBmB2dbKI+xYxAmfZhbeySh4KM+0xRJLPtmdvrE6jvjgXF8AikbTnFJWtVJq4Sc1E3HnmHxvHFgWdeiv3Fbg/Dzys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880651; c=relaxed/simple;
	bh=OHA5C8GaWmORzTeuKwznR+3k85lIX9wJcOBbPTIId0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5XMj1EJKFcjxIbYk417w3eou1H70xoVsA6gUr+zy+Ius8WJnHd5DnNAreNnb/iubLKgQta2rSmbzvvI4M59Jap5NSAk0QKTG665c20VAtPSoXgK1GsYJUAaqnSk+3oU7G+rfIcsNLF5k9tkb3oGLTRoWiL6OvIsnT6ZWWP6rjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fJ6IvbC0; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729880646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pqtm4O409KQs+qC4qHIqpJ6fPA7Q/9J5YGrNZs6ZYaM=;
	b=fJ6IvbC0WxjXQzJ+inEGwLweQ63h8mR57RCeZehUSbTWuHuZIv6YbrO7r5pnt003YZdFuh
	3ycg0wI8sZFg6qmD2W3SEI6M+8Vq1NmJ89A6c44Ssk9ajH6ooZ6X7twqbNoZGvUV3RWt6I
	hI5U3Tyg6SgvnQYDjM3HQAlFMx+CGAk=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH v4 00/18] KVM: arm64: nv: Support for EL2 PMU controls
Date: Fri, 25 Oct 2024 18:23:35 +0000
Message-ID: <20241025182354.3364124-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

v3 -> v4:
 - Align sysreg definitions with DDI0601 2024-09
 - Fix 'accessible' counter mask construction
 - Fix MDCR_EL2.MTPME RES0 logic

v3: https://lore.kernel.org/kvmarm/20241007174559.1830205-1-oliver.upton@linux.dev/

Marc Zyngier (1):
  KVM: arm64: Extend masking facility to arbitrary registers

Oliver Upton (17):
  arm64: sysreg: Describe ID_AA64DFR2_EL1 fields
  arm64: sysreg: Migrate MDCR_EL2 definition to table
  arm64: sysreg: Add new definitions for ID_AA64DFR0_EL1
  KVM: arm64: Describe RES0/RES1 bits of MDCR_EL2
  KVM: arm64: nv: Allow coarse-grained trap combos to use complex traps
  KVM: arm64: nv: Rename BEHAVE_FORWARD_ANY
  KVM: arm64: nv: Reinject traps that take effect in Host EL0
  KVM: arm64: nv: Honor MDCR_EL2.{TPM, TPMCR} in Host EL0
  KVM: arm64: nv: Describe trap behaviour of MDCR_EL2.HPMN
  KVM: arm64: nv: Advertise support for FEAT_HPMN0
  KVM: arm64: Rename kvm_pmu_valid_counter_mask()
  KVM: arm64: nv: Adjust range of accessible PMCs according to HPMN
  KVM: arm64: Add helpers to determine if PMC counts at a given EL
  KVM: arm64: nv: Honor MDCR_EL2.HPME
  KVM: arm64: nv: Honor MDCR_EL2.HLP
  KVM: arm64: nv: Apply EL2 event filtering when in hyp context
  KVM: arm64: nv: Reprogram PMU events affected by nested transition

 arch/arm64/include/asm/kvm_arm.h     |  29 ---
 arch/arm64/include/asm/kvm_emulate.h |   5 +
 arch/arm64/include/asm/kvm_host.h    |  21 +-
 arch/arm64/kvm/emulate-nested.c      | 291 ++++++++++++++++-----------
 arch/arm64/kvm/nested.c              |  54 ++++-
 arch/arm64/kvm/pmu-emul.c            | 143 +++++++++++--
 arch/arm64/kvm/sys_regs.c            |  15 +-
 arch/arm64/tools/sysreg              |  76 ++++++-
 include/kvm/arm_pmu.h                |  18 +-
 9 files changed, 465 insertions(+), 187 deletions(-)


base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
-- 
2.47.0.163.g1226f6d8fa-goog



Return-Path: <linux-kernel+bounces-222355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0AE910044
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A971C217ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC351A00C2;
	Thu, 20 Jun 2024 09:26:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FDB4AEE9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875585; cv=none; b=ddaFMJFbQQ1cGKlUpXse0+dJ/jcri2ACGpIYsNr5Fa0987vStGtii1UoEhiT1/NdgpS9iLupkq/vRHXi/2vMrhaa0hEreLsbEJWPoizF8mJyBiV6nfGTQa9pzDYrFtCqrsLe3HCMNFfdxWEMH8+CNmykKkT4XwzpPUrpeYFcdMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875585; c=relaxed/simple;
	bh=48SVrCSUrZdq+6+Y/Csf0a6W2s3XYlZRFFSqMJ52VNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L93ucW3ihcaV4XCAmgDNNBljysRzt8Xz2XPkhyna1WtCOMfKG14aq1+ZndPd2ehkVTt2rqz5U+v60b7QYq7PmD9TCyg56OrwPqkGn8BPkyatFoMm9sbsfFq2Q0hQV05PSudk77mItAxgz7plpzklaXtw+D7sXWSsfACv0nJ/Fi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C01DDA7;
	Thu, 20 Jun 2024 02:26:41 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.46.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 389883F6A8;
	Thu, 20 Jun 2024 02:26:11 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC V2 0/3] arm64/hw_breakpoint: Enable FEAT_Debugv8p9
Date: Thu, 20 Jun 2024 14:56:04 +0530
Message-Id: <20240620092607.267132-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables FEAT_Debugv8p9 thus extending breakpoint and watchpoint
support upto 64. This has been lightly tested and still work is in progress
but would like to get some early feedback on the approach.

Possible impact of context switches while tracing kernel addresses needs to
be evaluated regarding MDSELR_EL1 access. This series is based on v6.10-rc4
after applying the MDSELR_EL1 KVM series.

https://lore.kernel.org/all/20240620065807.151540-1-anshuman.khandual@arm.com/

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org

Changes in RFC V2:

- This series has been split from RFC V1 dealing only with arm64 breakpoints
- Restored back DBG_MDSCR_MASK definition (unrelated change)
- Added preempt_disable()/enable() blocks between selecting banks and registers

Changes in RFC:

https://lore.kernel.org/all/20240405080008.1225223-1-anshuman.khandual@arm.com/

Anshuman Khandual (3):
  arm64/cpufeature: Add field details for ID_AA64DFR1_EL1 register
  arm64/boot: Enable EL2 requirements for FEAT_Debugv8p9
  arm64/hw_breakpoint: Enable FEAT_Debugv8p9

 Documentation/arch/arm64/booting.rst    | 19 ++++++++++
 arch/arm64/include/asm/debug-monitors.h |  1 +
 arch/arm64/include/asm/el2_setup.h      | 27 +++++++++++++
 arch/arm64/include/asm/hw_breakpoint.h  | 50 ++++++++++++++++++++-----
 arch/arm64/include/asm/kvm_arm.h        |  1 +
 arch/arm64/kernel/cpufeature.c          | 21 ++++++++---
 arch/arm64/kernel/debug-monitors.c      | 16 ++++++--
 arch/arm64/kernel/hw_breakpoint.c       | 33 ++++++++++++++++
 8 files changed, 149 insertions(+), 19 deletions(-)

-- 
2.25.1



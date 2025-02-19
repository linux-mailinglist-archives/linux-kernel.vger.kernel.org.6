Return-Path: <linux-kernel+bounces-522054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A850A3C55D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38969189C40C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268AB1FF5EC;
	Wed, 19 Feb 2025 16:41:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6381FF1AD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983278; cv=none; b=OY/0nDXBSpi88nXQX86gapqI3p6nEfLSf4HXbO9f9Ckn03GZ35ht3HAn+7sX6Wn20mI1aLbyCRYBOKS+pE51YVfjfr/eWUri2XN/hgrda3pYxUtzEv49NZHA2u9ERdWYxfRR9OfSWnT3REX1U8R8tRmSxvlUefFpKHCXvkJDOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983278; c=relaxed/simple;
	bh=CwQG1Jbxk1c3jJy3EsVxnsgNloqEd90OJ6mwhvpsug8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNBvc2KoxJj1grocBySDHrIIR10ZgsDcOHbWieM5VOCiaURcznL0x8sXK8/GyWI76PDElT4f7JmUTstMLBtAhXZrCQlP4U93Na5Ri5MeAqId1yq1IJuxTN19jJ0R1E+RDi2oX64EnTH3B/ldimCKWEbkHNukBRIN9I0kEbmjvC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E83E1682;
	Wed, 19 Feb 2025 08:41:34 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 792C83F6A8;
	Wed, 19 Feb 2025 08:41:14 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 0/3] Minor improvements for PIE/POE helpers
Date: Wed, 19 Feb 2025 16:40:26 +0000
Message-ID: <20250219164029.2309119-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a collection of minor cleanups and improvements for the PIE/POE
macros in asm/sysreg.h and asm/por.h. Besides the readability
improvement, it will also come in handy for the kpkeys series [1] that
performs more calculations on POR_EL1.

- Kevin

[1] https://lore.kernel.org/linux-hardening/20250203101839.1223008-1-kevin.brodsky@arm.com/

---
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Will Deacon <will@kernel.org>
---
Kevin Brodsky (3):
  arm64/sysreg: Improve PIR/POR helpers
  arm64/sysreg: Rename POE_RXW to POE_RWX
  arm64/sysreg: Move POR_EL0_INIT to asm/por.h

 arch/arm64/include/asm/pgtable-prot.h | 36 +++++++++++++--------------
 arch/arm64/include/asm/por.h          | 11 ++++----
 arch/arm64/include/asm/sysreg.h       | 15 +++++++----
 arch/arm64/kernel/signal.c            |  2 +-
 arch/arm64/kvm/at.c                   |  8 +++---
 arch/arm64/mm/mmu.c                   | 10 +++-----
 6 files changed, 43 insertions(+), 39 deletions(-)


base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
-- 
2.47.0



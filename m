Return-Path: <linux-kernel+bounces-170645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 971F38BDA23
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4814B282A87
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A8D4F5EC;
	Tue,  7 May 2024 04:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QiMrqx7p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBBC4A12
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 04:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715055867; cv=none; b=Iatg0BEqTFgEA+O6PE9jUm5nPfSfQcg0Gyo+S9+OzUIDy+L6G5SK7+e5HWHUR66EoYM3ZEEU/LbGdEOk9xJ3LKWZbcCP8I1W8glvNOYNpb9KnXbnlKzpKsEMScYQ7MIGJYekc64lusJ7kbEbHEezsT2IeNxd+HerAuKA2vVvNy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715055867; c=relaxed/simple;
	bh=Osnwlt73s2bBh2Vn+sRNlDF+9e+02nXzC/g27ZohqLk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=krXAxjHJMUHT/sUPYK4tBggXVe/2cwhTU3rOr0SmxM38baHakEqNkU8tgDxojWFIl3oL8w6caJqexMm/lASOyfh3SeMNN5Acw7j9Z4Yi75JyyOpfwM7zBOz8cjulvoXzqS36fZyK/QuoV7v/m+NEKz6vxr1DpbILA9m0YKHxd5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QiMrqx7p; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715055865; x=1746591865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Osnwlt73s2bBh2Vn+sRNlDF+9e+02nXzC/g27ZohqLk=;
  b=QiMrqx7pbjVbf6ujL1+WY4fA+Syu27nKD+mMmDqiEVPudrSqdtOfYzw5
   KTZPIxgs8HF6UJhDA4iogtCK2+nKDIQoTsosoLzN3GY6VS82TgeNRd/FQ
   OBcbeKOJpnHa3vm6xjEteJ/0ERIuw/X5b8qyMgeIO1WbCgv1B/sGBmNfn
   U1TRllM+/BA+PDRqhUQbvbDgmAOP1eujr+ZLU54bZffCYgd4c5LmqQ6/k
   n8M7Fkl/7VtCZtEypLSlW6dUfT6Th7qZV7KKqh5alqME9aQUJfyDdmWxu
   vJDPQfboes1XnabKXO2dH2/UkHnn/dhTpsDAntEDEKvxjvJw8PUpu0QZl
   Q==;
X-CSE-ConnectionGUID: MIvDX2DgSA+CZ5LrK3QqfA==
X-CSE-MsgGUID: r82q6Kd+RXarK5UGixuFAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22230747"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="22230747"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 21:24:25 -0700
X-CSE-ConnectionGUID: Xqj0oIQ/RGiSvVL8nNnZMw==
X-CSE-MsgGUID: p0P9FwWTQACXs1QSyWokug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="33047152"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.193.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 21:24:24 -0700
From: alison.schofield@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Remove unneeded MKTME detection
Date: Mon,  6 May 2024 21:24:20 -0700
Message-Id: <cover.1715054189.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Changes in v2:
- Print the phys_addr bits reduction when BIOS enables MKTME (Kai)
- Remove init of keyid_bits (Kirill)
- Pick up Acked-by tags (Kirill, Kai)
- Update Patch 1 commit message phys addr bits note
- Rebase to latest tiptree
- Add note in this cover letter saying patches are independent

Link to v1: 
https://lore.kernel.org/all/cover.1713929290.git.alison.schofield@intel.com/


Begin original cover letter:
 
MKTME detection was added in anticipation of full kernel support
that never followed. Aside from just good housekeeping, this
cleanup is inspired by users who are confused by the TME/MKTME
messaging during boot.

The first patch cleans up the TME & MKTME detection code and the
second patch removes the unused pconfig code. There are no
dependencies between the 2 patches. The code that Patch 2 removes
is not used anywhere, not even pre-Patch 1.

Testing was done on a platform supporting MKTME using the BIOS
option to enable/disable MKTME prior to boot.

Alison Schofield (2):
  x86/cpu: Remove useless work in detect_tme_early()
  x86/pconfig: Remove unused MKTME pconfig code

 arch/x86/include/asm/intel_pconfig.h | 65 ---------------------
 arch/x86/kernel/cpu/Makefile         |  2 +-
 arch/x86/kernel/cpu/intel.c          | 72 ++++--------------------
 arch/x86/kernel/cpu/intel_pconfig.c  | 84 ----------------------------
 4 files changed, 13 insertions(+), 210 deletions(-)
 delete mode 100644 arch/x86/include/asm/intel_pconfig.h
 delete mode 100644 arch/x86/kernel/cpu/intel_pconfig.c


base-commit: 89948cc11a08639df9f004e866e51f9be887de88
-- 
2.37.3



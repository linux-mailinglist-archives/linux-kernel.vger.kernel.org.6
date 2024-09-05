Return-Path: <linux-kernel+bounces-317488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B2696DF08
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977361C247EF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E0A19F408;
	Thu,  5 Sep 2024 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a24uEWQQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859BA3C099
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552045; cv=none; b=aFr+mzwxTEzxWDy4NLp8yUBOiwykuGlsQHSF0mH28PQ7lgXGjqnQhjhbdYmYTQPTZ034dpa96JVSyNT0d+Ae7E86YL7KjLTnzFOqQchK6wOhSOBzWJfOHdVwmPuU1O/Kh4kQpmK5N/XYJQBxUWYKrusH+is42NSQLfXK4PsTVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552045; c=relaxed/simple;
	bh=QZk+x8qsMs6z8dNqyLtKXBt9OVzTRfsxtcayWspNCfE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kUd0hAbR8Vk7O/kOb92J/xdKGiHJPOcQAl9Qkhl3CXpKFVLbI2SwBZqH1i1oJR7aUTqFjQTfo0f/U7g4sRvEp/oGvj56wfvOh2wp10zVM+NuhHzao8EccdfB79YcPZmv3nM3ZUJApmNzDJwt01kIUIwWqg8xOh2mYHv/n0tGrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a24uEWQQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725552044; x=1757088044;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QZk+x8qsMs6z8dNqyLtKXBt9OVzTRfsxtcayWspNCfE=;
  b=a24uEWQQHEh7zadPNrBLSHUPpg+1PCM7cVEIJaJ9xPwtSbhKNTL3Rg+M
   wPIPiaTg6IX5YLod1lHrtWz6/+2qsMhmWY5EJnJwxtAucUkfWOguM/xV5
   CJ0x4bmGSB6MGLFqyUlsT0iErGinip8ADOnOsK8g7hoFF4KzaF7qsH3bq
   OOzCP6P4RkMQRSzx4eOty8m4edsUAfIHQOZIq4LO6rDH2F8NptW/BruWD
   eATlYNpyuP5FUnThy6U/5wIhQaLby16dtE6fGeCjkhLmws2IKf1CcpXVH
   xuAO0JiuH9n4QzeXHFr5B76+J1caR2MQs26zf1qE7Pw0pSVCnhcarM4Dn
   Q==;
X-CSE-ConnectionGUID: BL7MDiKyQH64Y2onRYNH/g==
X-CSE-MsgGUID: x1DIePObTgKoSQY+aJA79g==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="24395702"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="24395702"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 09:00:42 -0700
X-CSE-ConnectionGUID: JoLgS47jSLyk664heqqBqg==
X-CSE-MsgGUID: +APUSDLOQyucuhDlOdGJ0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="65701393"
Received: from bllerma-mobl2.amr.corp.intel.com (HELO desk) ([10.125.147.102])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 09:00:41 -0700
Date: Thu, 5 Sep 2024 09:00:39 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com
Subject: [PATCH v6 0/3] Fix dosemu vm86() fault
Message-ID: <20240905-fix-dosemu-vm86-v6-0-7aff8e53cbbf@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIACjS2WYC/3XOz27CMAwG8FdBOS+ozh873WnvMe2QJe6IRFvUQ
 MSE+u4LXEBqdvws++fvJjIvibN4393EwiXlNE814NtOhIOfflimWLNQnTKdUSiHdJVxzjxeZBk
 dyhgBwHdAmljUq9PCdeUhfn7VfEj5PC+/jwcF7tP/rQISpHPBKfR60OQ+jmm6XPdpOvNxH+ZR3
 MWingoq2iqqKtFa6gfsHRO1Ff1UqIOtoqvyDT32VqtA1rcV86JAt1VMVbxHg4YhMg5txb4qjS6
 2KuwohkganW90Wdf1D5oXCXfMAQAA
X-Mailer: b4 0.14.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v6:
- Use %ss in 64-bit mode as well for all VERW calls. This avoids any having
  a separate macro for 32-bit (Dave).
- Split 32-bit mode fixes into separate patches.

v5: https://lore.kernel.org/r/20240711-fix-dosemu-vm86-v5-1-e87dcd7368aa@linux.intel.com
- Simplify the use of ALTERNATIVE construct (Uros/Jiri/Peter).

v4: https://lore.kernel.org/r/20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com
- Further simplify the patch by using %ss for all VERW calls in 32-bit mode (Brian).
- In NMI exit path move VERW after RESTORE_ALL_NMI that touches GPRs (Dave).

v3: https://lore.kernel.org/r/20240701-fix-dosemu-vm86-v3-1-b1969532c75a@linux.intel.com
- Simplify CLEAR_CPU_BUFFERS_SAFE by using %ss instead of %ds (Brian).
- Do verw before popf in SYSEXIT path (Jari).

v2: https://lore.kernel.org/r/20240627-fix-dosemu-vm86-v2-1-d5579f698e77@linux.intel.com
- Safe guard against any other system calls like vm86() that might change %ds (Dave).

v1: https://lore.kernel.org/r/20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com

Hi,

This series fixes a #GP in 32-bit kernels when executing vm86() system call
in dosemu software. In 32-bit mode, their are cases when user can set an
arbitrary %ds that can cause a #GP when executing VERW instruction. The
fix is to use %ss for referencing the VERW operand.

Patch 1-2: Fixes the VERW callsites in 32-bit entry path.
Patch   3: Uses %ss for VERW in 32-bit and 64-bit mode.

The fix is tested with below kselftest on 32-bit kernel:

	./tools/testing/selftests/x86/entry_from_vm86.c

64-bit kernel was boot tested. On a Rocket Lake, measuring the CPU cycles
for VERW with and without the %ss shows no significant difference. This
indicates that the scrubbing behavior of VERW is intact.

Thanks,
Pawan

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
Pawan Gupta (3):
      x86/entry_32: Do not clobber user EFLAGS.ZF
      x86/entry_32: Clear CPU buffers after register restore in NMI return
      x86/bugs: Use stack segment selector for VERW operand

 arch/x86/entry/entry_32.S            | 6 ++++--
 arch/x86/include/asm/nospec-branch.h | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)
---
base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
change-id: 20240426-fix-dosemu-vm86-dd111a01737e



Return-Path: <linux-kernel+bounces-304804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4370E962528
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12F01F23C00
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AD116C869;
	Wed, 28 Aug 2024 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGj9TDDU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E2216C857;
	Wed, 28 Aug 2024 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841904; cv=none; b=rOwILnRQCU/nrHFzyHLdhh5HT645K31tslVMMbioP5aFsBmyqvbGmr/R0/MP6HVzgv17QLYLndTn/Y8C4Z5sigWJ62BWNMYAJC1w7YNmlNCxG8BRFvJNxnuVbCbWdFpPE+BUdm7TqsiNfZ3VsmumO/O9mSFpFa0MDO4/WBRz5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841904; c=relaxed/simple;
	bh=RJ1IaqCvApyfSsH4KWoeYq/fuMQ6WydSqOcFuoqX4tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKPw7BOjSF375jKiNJgUF6MKK9UwvbIbsWJIcNeXxtOpY2yNWR8wjrgUVlGz8uCwQ1hp/8eqD/CXw2FAgJiTfhdGSqmzHAypk15J1ZcmylviH17qd6Ijyyy4uvSEzypVBIXNi3cp5aant1iyOTC9bn9OAoNFLEaiJ9myoQ6Atw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGj9TDDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E11C98EC0;
	Wed, 28 Aug 2024 10:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724841903;
	bh=RJ1IaqCvApyfSsH4KWoeYq/fuMQ6WydSqOcFuoqX4tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGj9TDDUTNbCLOxcabGJmSzllDBJrozhBRQ1w5AWt1FiASevc+ObKsfsxxMAp7+Ey
	 YXoj1tgJVSJ0xaEOxU3Yv83cHMP+vzZbjkhiIQ/Z9M69gfUabLb2VN/n03xqE1Umbl
	 6y49OPOmRZwGIunmupCzFkBB/sdCQUpyWe0P2ufvxZSdZ/8O0Z8cObK1sTszfLHpPk
	 njbmCwXXTUPfDXpCEXcFZb39V8WCg1ZOnoFuioUeS7x1EQMXM5aiY3kUdsGnjcy8nT
	 bNWKq9BoXDvP7YGlFDKXt4XZsBIC0iKVp+pUSkYnYt+aAbpOgUpcnaMERzYeq/qpwx
	 fEHs0xheQ99ig==
From: Alexey Gladkov <legion@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: "Alexey Gladkov (Intel)" <legion@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>,
	cho@microsoft.com,
	decui@microsoft.com,
	John.Starks@microsoft.com
Subject: [PATCH v5 0/6] x86/tdx: Allow MMIO instructions from userspace
Date: Wed, 28 Aug 2024 12:44:30 +0200
Message-ID: <cover.1724837158.git.legion@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724248680.git.legion@kernel.org>
References: <cover.1724248680.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alexey Gladkov (Intel)" <legion@kernel.org>

Currently, MMIO inside the TDX guest is allowed from kernel space and access
from userspace is denied. This becomes a problem when working with virtual
devices in userspace.

In TDX guest MMIO instructions are emulated in #VE. The kernel code uses special
helpers to access MMIO memory to limit the number of instructions which are
used.

This patchset makes MMIO accessible from userspace. To do this additional checks
were added to ensure that the emulated instruction will not be compromised.


v5:
- Improve commit messages and comments in commits as suggested by Kirill A. Shutemov.
- To emulate MOVS, instead of storing the entire address, started using a flag.

v4:
- Move patches to avoid crossing the page boundary to separate patchset. They
  address separate issue.
- Check the address only in user context and in case of nested exceptions.
- Fix the check that the address does not point to private memory.

v3:
- Add patches to avoid crossing the page boundary when the instruction is read
  and decoded in the TDX, SEV, UMIP.
- Forbid accessing userspace addresses from kernel space. The exception to this
  is when emulating MOVS instructions.
- Fix address validation during MOVS emulation.

v2:
- Split into separate patches AMD helpers extraction and MOVS implementation
  code for intel as suggested by Thomas Gleixner.
- Fix coding style issues.


Alexey Gladkov (Intel) (6):
  x86/tdx: Split MMIO read and write operations
  x86/tdx: Add validation of userspace MMIO instructions
  x86/tdx: Allow MMIO from userspace
  x86/tdx: Add a restriction on access to MMIO address
  x86/tdx: Move MMIO helpers to common library
  x86/tdx: Implement MOVS for MMIO

 arch/x86/coco/sev/core.c         | 139 ++-----------
 arch/x86/coco/tdx/tdx.c          | 338 ++++++++++++++++++++++++++-----
 arch/x86/include/asm/io.h        |   3 +
 arch/x86/include/asm/processor.h |   3 +
 arch/x86/lib/iomem.c             | 115 +++++++++++
 5 files changed, 429 insertions(+), 169 deletions(-)

-- 
2.46.0



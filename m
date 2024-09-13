Return-Path: <linux-kernel+bounces-328603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FA0978661
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD381C2250C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941A34F20E;
	Fri, 13 Sep 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJWi83pn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F079E7DA95;
	Fri, 13 Sep 2024 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247170; cv=none; b=W1tKI4pCRfY/dNXh9e4VepFOkHGsOZy7vyTNbqi4XjSdqHHwgl1jTtEtoNEpXX21hvr12eZAos0Phq/0Ei9FSx+QKXwpbNWvnivZApRyioSK4lGV4DWhpeXATWfWXFWYDKbijnAo/M1K+ap4wj1vJXQGcgBrDSLh+tG/YtpKJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247170; c=relaxed/simple;
	bh=V0FUE55moSUh/RiO6vVkhRqYzDmAkN+3dar5NwizwaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRNnZyTc+uZ5UNgF9OdH+e+czZ+TAyKg38eQyWubKWdX+IGzmx8KoCIeanJG6BIykm5V2eKcClkDKn8d8uL5hIoNsVAR8KRi8CvkvJNonx7FzGu2/GLCWoKJJoVg7cxbbC9gvNjDjhKH9UIy7DWYSQjppAby1NqfYtoHUaGPNlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJWi83pn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6166C4CEC7;
	Fri, 13 Sep 2024 17:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726247169;
	bh=V0FUE55moSUh/RiO6vVkhRqYzDmAkN+3dar5NwizwaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HJWi83pnWhkbqHjEYPZLYoeTLvRz5FQJkF7M/3SDaOQhUVVv4vtWuP6MJwOPM637D
	 4re3H9T1f+4Aye4QAQhKvTmYqEOg6COKEXlJETNDtvPhLpOh00SGtQvAyBlm6mXjC8
	 i5t+wen83dJw3bOzMKDGo24sX1OT09SpLOcP4V1Fno9vbNg197hC8xxKllDp4IQT6A
	 0sBNjWH75F4waJhn7JSNlNvk8NAvkWwPMvISVs4BHiNXiS2ATVGRhaYvaBp5uikKXF
	 qnVTWZBetkx9b0Vx8fecIENx57E33hiYgZPfgYjYw6oH1XBgDZxesc3gO6ih/x/Jah
	 rz9DQDFG3k7qQ==
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
Subject: [PATCH v7 0/6] x86/tdx: Allow MMIO instructions from userspace
Date: Fri, 13 Sep 2024 19:05:55 +0200
Message-ID: <cover.1726237595.git.legion@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725622408.git.legion@kernel.org>
References: <cover.1725622408.git.legion@kernel.org>
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


v7:
- Use fault_in_kernel_space() instead of using your own function as
  suggested by Dave Hansen.
- Drop the unnecessary ifdef CONFIG_INTEL_TDX_GUEST from thread_struct.

v6:
- Reorder patches and change commit messages.

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
  x86/tdx: Fix "in-kernel MMIO" check
  x86/tdx: Split MMIO read and write operations
  x86/tdx: Add validation of userspace MMIO instructions
  x86/tdx: Allow MMIO from userspace
  x86/tdx: Move MMIO helpers to common library
  x86/tdx: Implement MOVS for MMIO

 arch/x86/coco/sev/core.c         | 139 ++-----------
 arch/x86/coco/tdx/tdx.c          | 334 ++++++++++++++++++++++++++-----
 arch/x86/include/asm/io.h        |   3 +
 arch/x86/include/asm/processor.h |   1 +
 arch/x86/lib/iomem.c             | 115 +++++++++++
 5 files changed, 423 insertions(+), 169 deletions(-)

-- 
2.46.0



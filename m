Return-Path: <linux-kernel+bounces-289749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42293954B50
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5194B23C53
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8249E1BD00D;
	Fri, 16 Aug 2024 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JecTPO7Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066F1BCA11;
	Fri, 16 Aug 2024 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815891; cv=none; b=D/+36P922oUMIxsCH9qTmAYJB1+M4Ol/kL4YEb5m+ROJhK41ZJghGloCnNYyiNXVVurROtMdKtuHi3uzxRSTz4I/SfExgFbmfjAnkrWxz+Wty6aU6sYbePNFLloNGasmC4QNZ7oRMqbTB7Dfh5aqM5Rc5hO8ZRYu6oWDsXWz+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815891; c=relaxed/simple;
	bh=bzBL+UiL+ypbHY7tqFz7QhD68vzt6nmzae2jSSkqhcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhX2mjcU3A6sH8tpKR5aAoHFwQNrspK2b5A68p0t2SfVUXYTtsgt9SbDFwmaPlvX7U4alxgCNJl74AiDC6104x44WL8EGz6SavzK0rKkc7lXvRVAW1uN92DKKq+BJnOOxva93y+rvj7vIAe+1wn2wpvwaesT2U5bAWGTnUHQ/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JecTPO7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6611EC32782;
	Fri, 16 Aug 2024 13:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723815891;
	bh=bzBL+UiL+ypbHY7tqFz7QhD68vzt6nmzae2jSSkqhcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JecTPO7YZwBOcfgsobL5EKN+jLh+j/mDHg+xlaj+RduO/91HJ1MgDYCs7+eA0r+6Q
	 UZR5XuxwiB+YZDtiO8fhAfz6b/bzaHQwni2SMRWCAIxY4nYUNrh6rrLmcZz0pGpiM7
	 AOmXdcJMTXEAfBbevEsdCgHoFCUBziEKo4qHxJgWlO3qi8rr3WefO7K8cUNNscl2W4
	 2YKrYFDs6gnup9fVU9qRFzNkSdPxjdb4/VhlqaXIjvnbZlXMt9at3oVvU7srSZXt/s
	 LxWTKGGatsZMliuDuno++Z+0QL9lBtTrDHd7R7jmEqvo4L3vTkUzrBwaRrCWxNEs6h
	 LRHKwrDDrmEng==
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
Subject: [PATCH v3 00/10] x86/tdx: Allow MMIO instructions from userspace
Date: Fri, 16 Aug 2024 15:43:50 +0200
Message-ID: <cover.1723807851.git.legion@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722862355.git.legion@kernel.org>
References: <cover.1722862355.git.legion@kernel.org>
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


v3:
- Added patches to avoid crossing the page boundary when the instruction is read
  and decoded in the TDX, SEV, UMIP.
- Forbid accessing userspace addresses from kernel space. The exception to this
  is when emulating MOVS instructions.
- Fix address validation during MOVS emulation.

v2:
- Split into separate patches AMD helpers extraction and MOVS implementation
  code for intel as suggested by Thomas Gleixner.
- Fix coding style issues.


Alexey Gladkov (Intel) (10):
  x86/tdx: Split MMIO read and write operations
  x86/tdx: Add validation of userspace MMIO instructions
  x86/tdx: Allow MMIO from userspace
  x86/insn: Read and decode insn without crossing the page boundary
  x86/tdx: Avoid crossing the page boundary
  x86/sev: Avoid crossing the page boundary
  x86/umip: Avoid crossing the page boundary
  x86/tdx: Add a restriction on access to MMIO address
  x86/tdx: Move MMIO helpers to common library
  x86/tdx: Implement movs for MMIO

 arch/x86/coco/sev/core.c         | 147 ++------------
 arch/x86/coco/tdx/tdx.c          | 329 ++++++++++++++++++++++++++-----
 arch/x86/include/asm/insn-eval.h |  15 ++
 arch/x86/include/asm/io.h        |   3 +
 arch/x86/include/asm/processor.h |   4 +
 arch/x86/kernel/umip.c           |   7 +-
 arch/x86/lib/insn-eval.c         |  55 ++++++
 arch/x86/lib/iomem.c             | 125 ++++++++++++
 8 files changed, 498 insertions(+), 187 deletions(-)

-- 
2.45.2



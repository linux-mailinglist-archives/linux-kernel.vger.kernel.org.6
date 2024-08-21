Return-Path: <linux-kernel+bounces-295659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 570B5959FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1000B1F24297
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A391B1D56;
	Wed, 21 Aug 2024 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXIfygwz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87271662F8;
	Wed, 21 Aug 2024 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250346; cv=none; b=BlhmZpkuf6BW3k7WqgH53e3Gd/pU462TpP5lW836zyC7Pp4nXCPlqDOP4zcnKyRGXkPtpTdBpaZNLlB34jGLSGQHJHl52Cnj/cSb+GpQDgIS9HI0xEScTcuyt5g21J0qMxBKXYcha8JtnX4bVb+gAvVfbBkA/+Ld1EdzwLnkhzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250346; c=relaxed/simple;
	bh=/Nf4+vctsy/ht87DiifW7sx7UMggl35ymMZyQ+iaSkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kq+jr0YATtl2YQutAjTHwWWpJY6gbU0UFPhzKGOYqvWscRc0gWor8KmaizXtXQ2oNVCQYzB7OOLZjn7p4L4/XPbLhCHTA1j0X13OuwKj3AVx3bRVOUQwrRzC/IkL++D1fm4Du8qD+DtFLkXdRhqJIavo98aLbzpfeZVnIK6MI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXIfygwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4993EC32781;
	Wed, 21 Aug 2024 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724250346;
	bh=/Nf4+vctsy/ht87DiifW7sx7UMggl35ymMZyQ+iaSkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AXIfygwzZE5q2xNw8ff9AKHpjsc7XHCPPT2A71GJ8qkWcXtHi0vVnO8YXW2DJdr/g
	 YgM87mretS12Zd1WslcPqQWbAw6igra3PGZ+8Hv/h3ErgJ9rWZWccrTBjqnKGAx0hJ
	 HDwR34KTt4oqrYpGtYGYm+3XzPPEWfAVhwU7hIykshbX9f6JwQZl+DL9mEtp1rqsQ+
	 7agilcfuGfjsPO4yK0stGMPrUI2PNjVVzdjAqedyUYY2H0JIX8JIpQEqE7eGMb+EjR
	 p9Yzxc35WzntmA9MoN+ZKWPyLKcFz8sV4TE+cRleWy8G5W86c/6QCfdgAi4VOocfXL
	 kMCl5dzkeDPZQ==
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
Subject: [PATCH v4 0/6] x86/tdx: Allow MMIO instructions from userspace
Date: Wed, 21 Aug 2024 16:24:32 +0200
Message-ID: <cover.1724248680.git.legion@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723807851.git.legion@kernel.org>
References: <cover.1723807851.git.legion@kernel.org>
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
  x86/tdx: Implement movs for MMIO

 arch/x86/coco/sev/core.c         | 135 ++----------
 arch/x86/coco/tdx/tdx.c          | 340 ++++++++++++++++++++++++++-----
 arch/x86/include/asm/io.h        |   3 +
 arch/x86/include/asm/processor.h |   4 +
 arch/x86/lib/iomem.c             | 125 ++++++++++++
 5 files changed, 434 insertions(+), 173 deletions(-)

-- 
2.45.2



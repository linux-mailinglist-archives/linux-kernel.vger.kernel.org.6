Return-Path: <linux-kernel+bounces-318806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5E296F393
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC921B24DDD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509C01CE705;
	Fri,  6 Sep 2024 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjqiBh0M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30EA1CBEA7;
	Fri,  6 Sep 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623422; cv=none; b=RBlSpa0s0+uc9uzmdslGXswubw2K622cNvNxs+5iwG3OTe9cfwXihkVRyaIrUjSvTcLq3FLq8TegBDxB6kagELrGpf6mrwB/80av+mtI/Iammrg9CvQ7qoZHlDP373/Hlrle/MH6rqRtcvK+XvB+g5pGbcCsOJSHRjhPocHFS+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623422; c=relaxed/simple;
	bh=xm9VDnJKdn0IefnBGBgUT0ddedKscu/4d0gC4dsHY5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yw22LE+69wIfL8a5hhdAci3RosU3C4FMQg+4Rm3HmmC3r26zdtuKuviER8uuX7wptGIdVK0Y2/ie3rKGA93D0qCvpCSrepmHlUVdED3HA3fviegpA4aBEOZ/2uKy2PF4x+OghzaHOYfPDcD+lsKMWfY6lYHtsv93MNl7rPaykAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjqiBh0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E9AC4CEC4;
	Fri,  6 Sep 2024 11:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725623422;
	bh=xm9VDnJKdn0IefnBGBgUT0ddedKscu/4d0gC4dsHY5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HjqiBh0MfU3RTTyntoxdEyk8M94i7yxjiV7BBt55SI886k0SDy9xeUma1K4e5XzQU
	 wWZV9BWx9YhDR6Ey6wD8PLY6dwzVJLFzBYon5zuO0oJ3bH6ZJZtZbkLAVM265JvFdp
	 o1STmAvKaOyu+hxRV2Cr0EyuGGe73ykDMpArNSdjDyXTkEZB4KAnSm37vlauJZiCmJ
	 /UPRna7jM2UhZrjq3v6gpx3rHyynDgE5yCMu/v/usnh7i8slkd8uq4iOI1QUfeb8YF
	 4Y2PFFhEKoqrAYxIZmO7bwBHqofV0Hc9xxqSL/bC3OOJ9S4FNBk+Mehpoi7QsqbkPX
	 Dh4fD4Hvp/SFQ==
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
Subject: [PATCH v6 0/6] x86/tdx: Allow MMIO instructions from userspace
Date: Fri,  6 Sep 2024 13:49:58 +0200
Message-ID: <cover.1725622408.git.legion@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724837158.git.legion@kernel.org>
References: <cover.1724837158.git.legion@kernel.org>
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
 arch/x86/coco/tdx/tdx.c          | 338 ++++++++++++++++++++++++++-----
 arch/x86/include/asm/io.h        |   3 +
 arch/x86/include/asm/processor.h |   3 +
 arch/x86/lib/iomem.c             | 115 +++++++++++
 5 files changed, 429 insertions(+), 169 deletions(-)

-- 
2.46.0



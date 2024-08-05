Return-Path: <linux-kernel+bounces-274718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEA2947BD7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF65B2813AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C27E2D030;
	Mon,  5 Aug 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZ04miN1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3DF36D;
	Mon,  5 Aug 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722864612; cv=none; b=a/j9WHsFSnJhDm9U9ySAOplAKb/iX4PUJBbclMzYZVbOjMn1gjXXA+PNrEjL+nGnEyGk18m9EaVrNlbDYIKYPdMvEbY7mJ3W2lXUkHvOXJo1JkNaEr5IATouCkJP6iqVbAg9M/WTsKHSyijdR/VKZ2Xz6OYCQ1omqJD0we1d0Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722864612; c=relaxed/simple;
	bh=imRC0CMmPqs/fzBlIFTjW+gL2qURUgVxVhF4BXlMk2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZoMOxINvFSVJIlw/OXabU9+iY1hepYKxocu+jYTNB/k21fTKNOxtOP/X7Tp8CI++vp9JVLt1GCZhGujAgye2Bm7N0GME2IdVjV9iFEHOyswzItDOh+dEZWhY9lYFpabteRPXJoeK6XmKTR91KymqZoTgnNKTtHvoWh79YeuPNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZ04miN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBBEC32782;
	Mon,  5 Aug 2024 13:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722864612;
	bh=imRC0CMmPqs/fzBlIFTjW+gL2qURUgVxVhF4BXlMk2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZ04miN1xGVMIUrTYHUrYeoIwdLP+g2a3KrvBxKmVkJumWoL9YcCJ3R4kkRxN/EHM
	 Th1Dl3w0WJDJkiKNa8zorUCSKEzWGvzjnkyxtAoc1SoAKsD+886yigJmOvLaQ+Vudt
	 9wLJ5UEUMVBmB6Bqey+a7CEZ+3PoxeIbdx5zNGcabiBzIQKY+yLlohqsSsdCiVkAvx
	 JFwaC0zXXgbSfI+1s3b7svQVZJ41cdf2sOMwDtm0IHV981OxExbmgBBVyIcsbsPuh1
	 5LrFHiJ+AkoaUVp+f0obqPISEfDmBC8oI8GXqx+ZejjHBnEh/tSDLIl13OmQn0O6lw
	 ldRe4XGrrB/FQ==
From: "Alexey Gladkov (Intel)" <legion@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
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
Subject: [PATCH v2 0/5] x86/tdx: Allow MMIO instructions from userspace
Date: Mon,  5 Aug 2024 15:29:41 +0200
Message-ID: <cover.1722862355.git.legion@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722356794.git.legion@kernel.org>
References: <cover.1722356794.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, MMIO inside the TDX guest is allowed from kernel space and access
from userspace is denied. This becomes a problem when working with virtual
devices in userspace.

In TDX guest MMIO instructions are emulated in #VE. The kernel code uses special
helpers to access MMIO memory to limit the number of instructions which are
used.

This patchset makes MMIO accessible from userspace. To do this additional checks
were added to ensure that the emulated instruction will not be compromised.


v2:
- Split into separate patches AMD helpers extraction and MOVS implementation
  code for intel as suggested by Thomas Gleixner.
- Fix coding style issues.


Alexey Gladkov (Intel) (5):
  x86/tdx: Split MMIO read and write operations
  x86/tdx: Add validation of userspace MMIO instructions
  x86/tdx: Allow MMIO from userspace
  x86/tdx: Move MMIO helpers to common library
  x86/tdx: Implement movs for MMIO

 arch/x86/coco/sev/core.c  | 135 ++---------------
 arch/x86/coco/tdx/tdx.c   | 309 +++++++++++++++++++++++++++++++-------
 arch/x86/include/asm/io.h |   3 +
 arch/x86/lib/iomem.c      | 125 +++++++++++++++
 4 files changed, 398 insertions(+), 174 deletions(-)

-- 
2.45.2



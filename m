Return-Path: <linux-kernel+bounces-267968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D1941EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81E63B21D77
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C22189918;
	Tue, 30 Jul 2024 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taHSqJyB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4581A76C6;
	Tue, 30 Jul 2024 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360976; cv=none; b=bZP+cpjp7/lDNQRkbgDHc3H0cgQKrLqomdbKqSSl6jHEeHjsSGJl8onUV8DXpBg/B2SGZJlGRRE5QbcO21/PVZIkUd7eNYF+hwgys3i60kc8JgT/VaD05GGLejZM6wLWFWoUt7K7PISbUv6QdQc5wzykAkAlHKG3DQlzWdN2w1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360976; c=relaxed/simple;
	bh=/xh6+8dPDxdWZz1b4Nfnen6mAu7ZStbzuwIyjB9nTXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NW4CUeQGQMC8NNH6tFXizOEAX/EW+mFR5QOcxG0+mkSGk7rMI7NQtToGYs+kD4+aqVG49uIZOeQGGycgeRv3a09f5tJZHujqxP+OVYksx+YF4KhwwcYyl3rLj5/jvePGNkgeb8cqUv5JtaT+UfYM6tpkTTClaU+BIuhRSGgl0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taHSqJyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CA4C32782;
	Tue, 30 Jul 2024 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722360976;
	bh=/xh6+8dPDxdWZz1b4Nfnen6mAu7ZStbzuwIyjB9nTXE=;
	h=From:To:Cc:Subject:Date:From;
	b=taHSqJyB/oKGkVx0IZ4cpwZuy+CORyQDfJKaB5/8CGyi0agtzN41xgYdBC2yYQG8a
	 KlupZJbmgl8AX54Xeux+Dw31Qmczdi5yduYa1mQvzP3Qaq5pCvHE4RTql+Ib4d6Xre
	 O1q8q5B0HOruPVXbaE3mEEzLpPk33rHoPYGvM/cerCkSPL27EWee4Rt/AHqI6Bfsvr
	 4GOqJyUVpEwjaR1UoTZSrRHZkyUk3w061CdTLxOktZQXoyy6TJgQ7aHmnLM7CtwaR7
	 hkj4ctXD06IG4yUZdGXO3I8T7+/Z87COMmsvZHQdgKgFeHhXzozCXx0+wWjik9ogFS
	 SKhxWxSN+tphQ==
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
Subject: [PATCH v1 0/4] x86/tdx: Allow MMIO instructions from userspace
Date: Tue, 30 Jul 2024 19:35:55 +0200
Message-ID: <cover.1722356794.git.legion@kernel.org>
X-Mailer: git-send-email 2.45.2
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


Alexey Gladkov (Intel) (4):
  x86/tdx: Split MMIO read and write operations
  x86/tdx: Add validation of userspace MMIO instructions
  x86/tdx: Allow MMIO from userspace
  x86/tdx: Implement movs for MMIO

 arch/x86/coco/sev/core.c  | 133 ++---------------
 arch/x86/coco/tdx/tdx.c   | 295 +++++++++++++++++++++++++++++++-------
 arch/x86/include/asm/io.h |   3 +
 arch/x86/lib/iomem.c      | 132 +++++++++++++++++
 4 files changed, 390 insertions(+), 173 deletions(-)

-- 
2.45.2



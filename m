Return-Path: <linux-kernel+bounces-374151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F6D9A65B1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB4CFB227F2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD42E1E7C17;
	Mon, 21 Oct 2024 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHpTSTQU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908771E7C0E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508257; cv=none; b=BDab+hmfy3Gk25Qybw5DuKQs4zcwj9HEVg2VGK4E4aemRKZGfzU9SfL8VkISpeSwvN2EnLjF5Aj+FLFUs8KdnNzfzPy+UtSiae0zpH7Qc0WjXZeLI+J11F+w+XANh1o4UfCRLSm+6viPJw+M4jv+sQaYYuF1tQCSU2u+HTJRpLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508257; c=relaxed/simple;
	bh=dPe6fM9W+U9OtJwRziwQoeiqJdRRsK5PWFzfMj7SUzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/68QdZnHPPKjN5cP7urllDq1lAYZJVxypoLkWm+4RR85Z7pa94+2l8/matPP4ODB+12gJAui0OPcZe/C1L9iOBPxDa9lz6f7nLCy4crKidh6gvmEOynscGv4Kd6ypo3WCMrV42k9SIzpmBlWGogdJcv8w/x75vrnzMRpVzf8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHpTSTQU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729508255; x=1761044255;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dPe6fM9W+U9OtJwRziwQoeiqJdRRsK5PWFzfMj7SUzQ=;
  b=oHpTSTQUytynrUIfKAhOrO8ADfdZWn5vSDSTx4zsyVthizTwA+p5BGPF
   bYTRJYRO1nKdAplyYCgNuECdXUp+hoF1uNBCU5e5lOnykya+aAMT7kHzn
   mbDCkkpLScLq95hx+iz4G5xyXh3VUcT/yxGoGxAOltV66uLIxnAPWgxsF
   JxpdVipD0svyprArb83hlYoAvpjqJj7I8Ft+kUD6Z+KxTCYSfWUm/ommn
   0HUAIyGkk/yaZBkc3Hc0/rwNm7mlCSZYDX+/xVj0ObfvuW2JXR8OUqFHd
   bA9UeKoFv87Zl395spt9fO7OegRWxseISJum0f831Hgh1jNL6Myu43Ejd
   A==;
X-CSE-ConnectionGUID: 1hRhAmylQ8uOABTaT0F1pw==
X-CSE-MsgGUID: 35rlNU+MRuWMr/rv2zhovg==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="28440669"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="28440669"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:57:35 -0700
X-CSE-ConnectionGUID: wV11nsFeSoi7zuNM+Hz8rg==
X-CSE-MsgGUID: IcxcZgNCTuWd8uYGU4iPrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84313352"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 21 Oct 2024 03:57:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id AD1521E0; Mon, 21 Oct 2024 13:57:27 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Chan <ericchancf@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kai Huang <kai.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Russell King <linux@armlinux.org.uk>,
	Samuel Holland <samuel.holland@sifive.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 0/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by default
Date: Mon, 21 Oct 2024 13:57:21 +0300
Message-ID: <20241021105723.2707507-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make memremap(MEMREMAP_WB) produce encrypted/private mapping by default
unless MEMREMAP_DEC is specified.

It fixes crash on kexec in TDX guests if CONFIG_EISA is enabled.

v2:
 - Fix sparse warning;

Kirill A. Shutemov (2):
  memremap: Pass down MEMREMAP_* flags to arch_memremap_wb()
  x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by default

 arch/arm/include/asm/io.h   | 2 +-
 arch/arm/mm/ioremap.c       | 2 +-
 arch/arm/mm/nommu.c         | 2 +-
 arch/riscv/include/asm/io.h | 2 +-
 arch/x86/include/asm/io.h   | 3 +++
 arch/x86/mm/ioremap.c       | 8 ++++++++
 kernel/iomem.c              | 5 +++--
 7 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.45.2

Kirill A. Shutemov (2):
  memremap: Pass down MEMREMAP_* flags to arch_memremap_wb()
  x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by default

 arch/arm/include/asm/io.h   | 2 +-
 arch/arm/mm/ioremap.c       | 2 +-
 arch/arm/mm/nommu.c         | 2 +-
 arch/riscv/include/asm/io.h | 2 +-
 arch/x86/include/asm/io.h   | 3 +++
 arch/x86/mm/ioremap.c       | 8 ++++++++
 kernel/iomem.c              | 5 +++--
 7 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.45.2



Return-Path: <linux-kernel+bounces-370113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26519A27BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FE41C26E09
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049FA1E0DD1;
	Thu, 17 Oct 2024 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuoQ7d05"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49D1E0B80
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180629; cv=none; b=g/oQL1ozMZ3kyBgAzJrMzjKc4g0pe9bpFZeEeG4DzLaNKERoBGUFVQeJcplB3n8UNpuFYuYiJTSccy/zbSrYW2Ruu8NIR9OEGDbcrJtLHJdM4NG+3qDglntUqx+ywkqQeHdw2xRjPaComFxTYAxxQrI9f+Lwuq1BieMDcXvboGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180629; c=relaxed/simple;
	bh=cFzzvpiMkjAjvhangRLjMs/3T+cI3jEZdRM4LzxxOx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tpEA8O9jyAgTYv9EPR/HiqbkNT5yme3ZkC3oS05/8zG1eMA3UScG7H/oMwhyL7Iz6h6i36YrCulfyvuYJVNkjmQ8aYTZyaMlhNPBc54hnIbzTAyIzU0fLOI74ciAxbr6poJBhIU9Fj8jagMzXSPt2Zz4t6KS1yzEeQLkZTT25h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuoQ7d05; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729180628; x=1760716628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cFzzvpiMkjAjvhangRLjMs/3T+cI3jEZdRM4LzxxOx4=;
  b=WuoQ7d05jVQskJ3uoP7Chc6p2fm2zTfEoG6qE8tWeed/U1xvmh0YNtAJ
   kl3UJJiacmYl8hkMzgtjLr//ywuFL4HVtz0HaC0sodZGAoNHn+O2HhB+a
   qCM6HSfLo/3Dexc0lhToAOiMjuq4EPpLip/ci0vM4qcLqFJbYTiZbEeW1
   R1X4pFxO/B4HPwvQeSFqzPudyzlexevf8VlpcVQS6SPhwiI3XKfrs/BdN
   T2xD0KHdB/THFvEHFWVDfnRxZzrUQEWThEFZhlk2jxHPLGakSVwPCfF6p
   QBlWoRlvE2a8sQqwGdxo+xMZCAR3PyPKy996PQy48gEp13D3cl5VejPa7
   A==;
X-CSE-ConnectionGUID: 2CvGjnGwTbWeSOTkfLdJHg==
X-CSE-MsgGUID: z/O1kftyQbuLXa8jdz8Qrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28637669"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28637669"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 08:57:02 -0700
X-CSE-ConnectionGUID: kKBWm2aUQNCGXNUrvtwMwQ==
X-CSE-MsgGUID: 6JQLpE9nSl2Esp5RUP38DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="78254725"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 17 Oct 2024 08:56:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id BBF36256; Thu, 17 Oct 2024 18:56:54 +0300 (EEST)
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
Subject: [PATCH 0/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by default
Date: Thu, 17 Oct 2024 18:56:40 +0300
Message-ID: <20241017155642.1942514-1-kirill.shutemov@linux.intel.com>
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



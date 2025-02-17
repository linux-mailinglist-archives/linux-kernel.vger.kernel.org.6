Return-Path: <linux-kernel+bounces-518098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128D3A389FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1C3170035
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214CA226172;
	Mon, 17 Feb 2025 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xl6zXgrN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128B422541A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810559; cv=none; b=DTLooX4QL7Aq8ifrOFGXYseomUT5i3O34L/p14G8ylgnIRbNNiViQpe+6Hexu1gi8AwgeBYF2PyoS/Imh0KtQXHMD+bgsUb//uzDTIMXrS+netAwWnNBSsSRaKXIpyJ4NVxsOPCYjOOVm3VqIojLO7ftmwywc5ITqJJxHU11kSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810559; c=relaxed/simple;
	bh=tyrZi4t3b2IXxjYSUmajtM2LB3gk2W9CEP0El9BjLIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gymhla1gjcvt6I8CtCQQoF4HL4mvj5VhIwqF8XJyD8n8RymgUqN0bxJHyags7VcABc+M4XbUyi7TB/TxtMABexNeJR0mSHtNWOMCOiNnpLzfMGOuBkK4/3ppjEaIEznkCcnaPFpfCO0flUCI1DSt2TRVA7CYlvcOcjjTboMREMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xl6zXgrN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739810558; x=1771346558;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tyrZi4t3b2IXxjYSUmajtM2LB3gk2W9CEP0El9BjLIQ=;
  b=Xl6zXgrNu4/WjsNMITjR5Liiico0H9PgcxZjDYEMqZQoV9dEtKON7BnX
   uJQM4ntFEnYA9y8U5Xn1on1owFSzoe5aoz89AKNSM+M/Ql5ymkmEEMGxn
   sgpUmbPivGC11aIecI4cx6qrhbOKzdirOj1xlrb1lT6xEllcb+LaB9Jx7
   d1NktFO08nFLOrcpGBgWs6pyl+0xv9pzZHogdK8HzL7TA9clWLcqg5B9k
   +20ueWWuUCE3KussEiOOO1pC9TXT9oWitBsQundQCTh3gtbSwCXhZXUTU
   xtWz0iu1D2/uP++Fl0bsEOVoTumFLdXtesTa7eDJWcRrqxzdogG0GYhY0
   g==;
X-CSE-ConnectionGUID: GK8hJfQLS0KRD2xBgNGpEA==
X-CSE-MsgGUID: vnr/ZAN1S4y2HaZgWlCL0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44426567"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="44426567"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 08:42:37 -0800
X-CSE-ConnectionGUID: /AahWOaxRZmGux3Yy1B1rA==
X-CSE-MsgGUID: IuYgUEE1RESuzp/t6DB12w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="119092109"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 17 Feb 2025 08:42:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 70355111; Mon, 17 Feb 2025 18:42:29 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>
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
Subject: [PATCHv4 0/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by default
Date: Mon, 17 Feb 2025 18:38:19 +0200
Message-ID: <20250217163822.343400-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
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

v4:
 - Keep default-decrypted for SME machines;
v3:
 - Update commit message;
 - Add Cc: stable;
v2:
 - Fix sparse warning;

Kirill A. Shutemov (2):
  memremap: Pass down MEMREMAP_* flags to arch_memremap_wb()
  x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by t 

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
2.47.2



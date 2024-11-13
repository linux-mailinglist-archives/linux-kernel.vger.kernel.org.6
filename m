Return-Path: <linux-kernel+bounces-407349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E1C9C6C4A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AD60B2C4B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8615F1F892C;
	Wed, 13 Nov 2024 09:59:42 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09101F80A6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491982; cv=none; b=u3LD84Oy+M+wwwl75y2wA8YRA4fOrrmCULgpDMBfTQ4O8GZDQaN8MlUuLg0P8Qlv6docZzrwNycQTRwXNAf40VltsTqRXtbm5oePWEv8BGsM8H98nLLROq6SFUYdUPwn1E3MCrhFnH+wNepisimRC9IyZ/+6rJoki0toTn/j5Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491982; c=relaxed/simple;
	bh=Dbca+qTtnE/QA1lb4gzic01lV4bRBZrUctAfrdeLSyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pUMmO4OVzWIHOqIt/VWcZPwK/tUlo1kQMNu6kOrwyOkQRvayYJrrXgllEN7g4RFvwT84Pa9VjJav5/2gAqQ4OxNYDYdlAhaP/ZZkcSkji1m2C22IPI6RG2JcnhPurjMHEE6n7Pu3bp30MPN/LzThG+0szFXXi1eHDVtD+w6RJP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.53.31])
	by APP-05 (Coremail) with SMTP id zQCowADHr7p4eDRnlmI4Ag--.57753S2;
	Wed, 13 Nov 2024 17:59:20 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V5 0/3] riscv: mm: Add soft-dirty and uffd-wp support
Date: Wed, 13 Nov 2024 17:58:30 +0800
Message-Id: <20241113095833.1805746-1-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHr7p4eDRnlmI4Ag--.57753S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw17trWrtr4xKryUZF4UXFb_yoW8Aw4xpa
	93Kwn8trW5Ar1xtrs3CrnF9r15W3Z3J3s8GrWft34ktws8JF4jvr9YkF1fJry8X3WY9r90
	9F45Cry5u3yvyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l
	c2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
	xUyZmRDUUUU
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiDAYAB2c0cpIT4wAAsO

This patchset adds soft dirty and userfaultfd write protect tracking 
support for RISC-V.

As described in the patches, we are trying to utilize only one free PTE
bit(9) to support three kernel features (devmap, soft-dirty, uffd-wp).
Users cannot have them supported at the same time (have to select
one when building the kernel).

This patchset has been tested with:
1) The kselftest mm suite in which soft-dirty, madv_populate,
test_unmerge_uffd_wp, and uffd-unit-tests run and pass, and no regressions
are observed in any of the other tests.

2) CRIU:
- 'criu check --feature mem_dirty_track' returns supported;
- incremental_dumps[1] and simple_loop [2] dump and restores work fine;
- zdtm test suite can run under host mode.

This patchset applies on top of v6.12-rc7.

V5:
- Fixed typos and corrected some words in Kconfig and commit message;
- Removed pte_wrprotect() from pte_swp_mkuffd_wp(), this is a copy-paste error;
- Added Alex's Reviewed-by tag in patch 2.

V4:
- Added bit(4) descriptions into "Format of swap PTE".

V3:
- Fixed the issue reported by kernel test irobot <lkp@intel.com>.

V1 -> V2:
- Add uffd-wp supported;
- Make soft-dirty uffd-wp and devmap mutually exclusive which all use the same PTE bit;
- Add test results of CRIU in the cover-letter.

[1] https://www.criu.org/Incremental_dumps
[2] https://asciinema.org/a/232445

Chunyan Zhang (3):
  riscv: mm: Prepare for reusing PTE RSW bit(9)
  riscv: mm: Add soft-dirty page tracking support
  riscv: mm: Add uffd write-protect support

 arch/riscv/Kconfig                    |  34 ++++++-
 arch/riscv/include/asm/pgtable-64.h   |   2 +-
 arch/riscv/include/asm/pgtable-bits.h |  31 ++++++
 arch/riscv/include/asm/pgtable.h      | 133 +++++++++++++++++++++++++-
 4 files changed, 197 insertions(+), 3 deletions(-)

-- 
2.34.1



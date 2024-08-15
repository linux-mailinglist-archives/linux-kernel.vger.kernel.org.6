Return-Path: <linux-kernel+bounces-287469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA795281C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DCF1C21AB5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E4828DC1;
	Thu, 15 Aug 2024 03:04:35 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00118EEC0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723691074; cv=none; b=lKKOmpM1tCWLDculOoU+FALgHm6d6W/Gt1SUX+4sX4gBbj4GKYfmWw/YhMdBqj0O+a4gjPvtDhbqd+zo1nPnZ1NrFhr8Ge7ah/yukLWgMz5fQakGKIolhz5RCAV8xLtpnpQvBCh+heh7qUXLIxjf7dKQ4aQHoFejM1XRfsf+zJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723691074; c=relaxed/simple;
	bh=zjHXZeclUyHs5I1gFUtGfdJ/z/j4HBGZ6PWvTxXh0yw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HCxJJOw3y3RkLH01l0fJmjzPe2BSH0lxqZxuqm6Euw/ZwL83COTVrb67H7Jxnh3YCI8EeGNgENEC8AhprKxz0GxWt2FaSYnlkdYCuCCX+1UaWCmqc4xdKrfP2Y1e3XPKYZLhVBOvFVIyKQVEb+TvAbSss6DCud5ySWhwcdOUw5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.53.31])
	by APP-01 (Coremail) with SMTP id qwCowADn7EgucL1mTZWnBg--.51305S2;
	Thu, 15 Aug 2024 11:04:15 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V4 0/3] riscv: mm: Add soft-dirty and uffd-wp support
Date: Thu, 15 Aug 2024 11:04:00 +0800
Message-Id: <20240815030403.832489-1-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADn7EgucL1mTZWnBg--.51305S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw17trWrtr4xKryUZF4UXFb_yoW8Xw4rpa
	9Ykwn8try5Cr1xtrs3Cr1DKr15W3Wft345Cryft34vyw45JF4jvrnYkF1fJw18X3W29r90
	kF15CrW3u3ykZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWU
	twCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
	9x07jreOJUUUUU=
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiCQ4AB2awi9k5hwACs4

This patchset adds soft dirty and userfaultfd write protect tracking support
for RISC-V.

As described in the patches, we are trying to utilize only one free PTE
bit(9) to support three kernel features (devmap, soft-dirty, uffd-wp).
Users cannot have them supported at the same time (have to select
one when building the kernel).

This patchset has been tested with:
1) The kselftest mm suite in which soft-dirty, madv_populate, test_unmerge_uffd_wp,
and uffd-unit-tests run and pass, and no regressions are observed in any of the
other tests.

2) CRIU:
- 'criu check --feature mem_dirty_track' returns supported;
- incremental_dumps[1] and simple_loop [2] dump and restores work fine;
- zdtm test suite can run under host mode.

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



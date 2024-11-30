Return-Path: <linux-kernel+bounces-426432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3329DF2EA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 21:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583E5162E8D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 20:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20891AA7BA;
	Sat, 30 Nov 2024 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="F+g7vJsx"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872391AA1E9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732997512; cv=none; b=LiEM5zSS9tmx+5OR+HTqYNVA8EGguJW6E7pbRdtx6sLbPaN65K8+G9pPVRuQ8CzvMxMgpxUa/9+/U4b+6IZ97LB8Pe2/wgb687ywaC9zElfXD6crMeFJwy/7PSqnzecDgue/CFu8uQJUXx2mHyIMhj39pwjAp6fM0pJ3IXETk1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732997512; c=relaxed/simple;
	bh=cW+dUlLlFpxV5oUgruOAkD0+QB2/8JSw3qmEcguBNt4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rBieBQbBN4lORVJZBCgRafzRonQWlWrw4q/EzxAn1Cd30T6PLWtcU7eI3hVCCW/hayuI7mQLVx4KXnLghv2Kigm+8oIhffQsuwFZxmo7T95y34plgVRVUeA0Q6EW/pfuKREfKGpt6Iky9jK+a8PoCOoxv7wfrrrIeVYJJQuoGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=F+g7vJsx; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732997510; x=1764533510;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t+WQb6BJgufEUtZmDEGv1ME0aTsf7gIJocZMkFV+cR4=;
  b=F+g7vJsxdPDeLfsF4exux1xneGXkSZ50jtUJ4k0BvNtcEFYKVi4Yiam7
   LJxCmYIMvCFGviMJgHzu7dijcit5GSWWyCj7OKrJWcDmHNf3Zk/ednNK9
   Dqalzz+YYprgZffkZfW0mVhas/WSlwqJe2+ff0AJ/Ym2PfU0+lzTjSdVk
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,199,1728950400"; 
   d="scan'208";a="452383875"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 20:11:46 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:11108]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.190:2525] with esmtp (Farcaster)
 id 49529e1b-bc79-4e0e-b4f2-a5e69d56acc6; Sat, 30 Nov 2024 20:11:45 +0000 (UTC)
X-Farcaster-Flow-ID: 49529e1b-bc79-4e0e-b4f2-a5e69d56acc6
Received: from EX19D013UWB001.ant.amazon.com (10.13.138.52) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 30 Nov 2024 20:11:44 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D013UWB001.ant.amazon.com (10.13.138.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 30 Nov 2024 20:11:44 +0000
Received: from email-imr-corp-prod-pdx-all-2b-22fa938e.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Sat, 30 Nov 2024 20:11:44 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com [172.19.116.181])
	by email-imr-corp-prod-pdx-all-2b-22fa938e.us-west-2.amazon.com (Postfix) with ESMTP id 0512FC05E4;
	Sat, 30 Nov 2024 20:11:44 +0000 (UTC)
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
	id 8F5347001; Sat, 30 Nov 2024 20:11:43 +0000 (UTC)
From: Eliav Farber <farbere@amazon.com>
To: <linux@armlinux.org.uk>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<naveen@kernel.org>, <maddy@linux.ibm.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <tglx@linutronix.de>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <farbere@amazon.com>,
	<hbathini@linux.ibm.com>, <sourabhjain@linux.ibm.com>,
	<adityag@linux.ibm.com>, <songshuaishuai@tinylab.org>,
	<takakura@valinux.co.jp>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>
CC: <jonnyc@amazon.com>
Subject: [PATCH v5 0/2] Improve interrupt handling during machine kexec
Date: Sat, 30 Nov 2024 20:11:41 +0000
Message-ID: <20241130201143.48808-1-farbere@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series focuses on improving the machine_kexec_mask_interrupts()
function by consolidating its implementation and optimizing its behavior to
avoid redundant interrupt masking.

Patch Summary:
[PATCH v5 1/2] Move machine_kexec_mask_interrupts() to kernel/irq/kexec.c,
               removing duplicate architecture-specific implementations.
[PATCH v5 2/2] Refine machine_kexec_mask_interrupts() to avoid re-masking
               already-masked interrupts, resolving specific warnings
               triggered in GPIO IRQ flows.

Changes between v4 and v5:
 - The function machine_kexec_mask_interrupts() has been moved
   from kernel/kexec_core.c to a new file kernel/irq/kexec.c.
 - A new configuration option, GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD, has been
   added.
 - The parameters for the machine_kexec_mask_interrupts() function have
   been defined in reverse Christmas Tree style.
 - The comment explaining the call to irq_set_irqchip_state() has been
   improved for clarity.
 - The phrase 'This patch' has been removed from the commit message.
 
Changes between v3 and v4:
 - Add missing <linux/irqdesc.h> and <linux/irq.h> includes.

Eliav Farber (2):
  kexec: Consolidate machine_kexec_mask_interrupts() implementation
  kexec: Prevent redundant IRQ masking by checking state before shutdown

 arch/arm/kernel/machine_kexec.c   | 23 --------------------
 arch/arm64/Kconfig                |  1 +
 arch/arm64/kernel/machine_kexec.c | 31 --------------------------
 arch/powerpc/include/asm/kexec.h  |  1 -
 arch/powerpc/kexec/core.c         | 22 -------------------
 arch/powerpc/kexec/core_32.c      |  1 +
 arch/riscv/kernel/machine_kexec.c | 23 --------------------
 include/linux/irq.h               |  3 +++
 kernel/irq/Kconfig                |  9 ++++++++
 kernel/irq/Makefile               |  2 +-
 kernel/irq/kexec.c                | 36 +++++++++++++++++++++++++++++++
 11 files changed, 51 insertions(+), 101 deletions(-)
 create mode 100644 kernel/irq/kexec.c

-- 
2.40.1



Return-Path: <linux-kernel+bounces-431379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347BC9E3C93
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED71E2802A1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE97208966;
	Wed,  4 Dec 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Wpon7Txw"
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1481F7589
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322014; cv=none; b=ulXhi/jaoxFG4pgAkKMAbqx+FW9MseB94Mq0MSd9QwOU23noQVc5L0JvBEmEBL6+fmPjB6BOBlPg5sxLYAr2eYBk8m0BEdYTAOJZKdW1DJwcTdMhTpU3/aU4pcUJpT+o8bN+rZr3YPRqSm26jwkiAe3qsR19Eg0ctdpmNd9eQc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322014; c=relaxed/simple;
	bh=yJ6g2kJpoMpt1kocOWNeppeInu257oApJ+ELYCwb2UI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jl0pT+sBEhz8NzbN4VK4IiJ4FXUY2Jb3lTviSUQ4WZrIsBYmNTbljKpp6OihSb8k9LUmR9rlWy0V72Yjy+4SGK6Epl1CqCuGGLQQ19wKU5dqmHcjoogNlEgSDCir1Vk/EaAp4xUxR0gdJp6WG2rAH8N8PEQFZ4ZyaufUVKCe3V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Wpon7Txw; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733322012; x=1764858012;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zswYcgJLwrXZ5Noz0/+vVn+a499HuoexmUzvToEzvkM=;
  b=Wpon7Txwe68uQqSKcBiVrxh1/TzzuXhoWaI81fZSqLutw7XpHJgGhGoZ
   fUzWdoddorfCoz+aISYLJDWj39B6NtGw0YO99mGfBOEREY1+z8/TiVZ/K
   QHb6Eofcuqq7i3qFmkONGqOAbWIe9+ChQzrbgrdzfWO2aRimId8GKV9Kk
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,207,1728950400"; 
   d="scan'208";a="46564984"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 14:20:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:50901]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.190:2525] with esmtp (Farcaster)
 id 609709e8-0189-4b6b-b1ef-da475ec79ee4; Wed, 4 Dec 2024 14:20:05 +0000 (UTC)
X-Farcaster-Flow-ID: 609709e8-0189-4b6b-b1ef-da475ec79ee4
Received: from EX19D013UWB003.ant.amazon.com (10.13.138.111) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 4 Dec 2024 14:20:04 +0000
Received: from EX19MTAUEC002.ant.amazon.com (10.252.135.146) by
 EX19D013UWB003.ant.amazon.com (10.13.138.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 4 Dec 2024 14:20:04 +0000
Received: from email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com
 (10.124.125.6) by mail-relay.amazon.com (10.252.135.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Wed, 4 Dec 2024 14:20:04 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com [172.19.116.181])
	by email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com (Postfix) with ESMTP id DBF344066C;
	Wed,  4 Dec 2024 14:20:03 +0000 (UTC)
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
	id 98F487591; Wed,  4 Dec 2024 14:20:03 +0000 (UTC)
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
Subject: [PATCH v6 0/2] Improve interrupt handling during machine kexec
Date: Wed, 4 Dec 2024 14:20:01 +0000
Message-ID: <20241204142003.32859-1-farbere@amazon.com>
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
[PATCH v6 1/2] Move machine_kexec_mask_interrupts() to kernel/irq/kexec.c,
               removing duplicate architecture-specific implementations.
[PATCH v6 2/2] Refine machine_kexec_mask_interrupts() to avoid re-masking
               already-masked interrupts, resolving specific warnings
               triggered in GPIO IRQ flows.

Changes between v5 and v6:
 - Change GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD to not be user selectable.

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
 kernel/irq/Kconfig                |  6 ++++++
 kernel/irq/Makefile               |  2 +-
 kernel/irq/kexec.c                | 36 +++++++++++++++++++++++++++++++
 11 files changed, 48 insertions(+), 101 deletions(-)
 create mode 100644 kernel/irq/kexec.c

-- 
2.40.1



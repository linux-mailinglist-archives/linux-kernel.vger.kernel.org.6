Return-Path: <linux-kernel+bounces-425497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B489DC2E1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A60FB223DF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D28C1991B4;
	Fri, 29 Nov 2024 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="d2Cinozf"
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19417132C38
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879890; cv=none; b=A5Dw6DFCoYitZ9yqsJ6Of2uE/rGRd+Nk4XuBe6rwuOp1JzsNwGSejLaRP0b7XDwZedPBIClh6jhFqwCksnid5lcmUbBSIQ8CPerRlNxuvKzZgBEBli41Nu4mTgbMIqXpe3y1Sr/6loZtKjSk+a9ElCzXD+ZewSe9pKkHcdcswzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879890; c=relaxed/simple;
	bh=ZWn3pm4B8j0PcUtitrerOaTGjembwXsiYYQm4nq3M0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rAuJz62EBZAuWsHeesenTdd8xzLefzy8e80NypOv3eMJayygyFJCpP6/pFFDN638iUVflZpjHYPSFzc9duJ2dPElwOtzNidVjWnr3H0ADzt1D4BdRiPbu7+uXu5SJXnzj9A6t49kPO22iW/peZCiz546HdkscUfvZEQnx2G+ceU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=d2Cinozf; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732879889; x=1764415889;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XxQ3De7RUhc+RdOPHYM+OjqpU7dn3KwiW10hYXSFbC8=;
  b=d2CinozfClfHBqd2s7CWi459JJwZY+1mK8oRW5Ojb8MBB+BCYbOBvcNG
   yUVC5dSCBvafXcOIu6G3dWBy8DqCDWpUXaOeEdaNp/+aiEidVBAwMszw0
   zVIowH4220ssQXuA4SdrdIPDFZl99zz+SwMqjl5PFj2cSfvI7Vg3LrY2t
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,195,1728950400"; 
   d="scan'208";a="441793923"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 11:31:25 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:47324]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.2:2525] with esmtp (Farcaster)
 id ecdc713d-df63-4dcd-9dd4-55bcc88c3341; Fri, 29 Nov 2024 11:31:24 +0000 (UTC)
X-Farcaster-Flow-ID: ecdc713d-df63-4dcd-9dd4-55bcc88c3341
Received: from EX19D013UWB002.ant.amazon.com (10.13.138.21) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 29 Nov 2024 11:31:20 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19D013UWB002.ant.amazon.com (10.13.138.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 29 Nov 2024 11:31:19 +0000
Received: from email-imr-corp-prod-iad-all-1a-8c151b82.us-east-1.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 29 Nov 2024 11:31:19 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com [172.19.116.181])
	by email-imr-corp-prod-iad-all-1a-8c151b82.us-east-1.amazon.com (Postfix) with ESMTP id 78A5940640;
	Fri, 29 Nov 2024 11:31:19 +0000 (UTC)
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
	id 355A79E9A; Fri, 29 Nov 2024 11:31:19 +0000 (UTC)
From: Eliav Farber <farbere@amazon.com>
To: <linux@armlinux.org.uk>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<naveen@kernel.org>, <maddy@linux.ibm.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <tglx@linutronix.de>,
	<ebiederm@xmission.com>, <akpm@linux-foundation.org>, <bhe@redhat.com>,
	<farbere@amazon.com>, <hbathini@linux.ibm.com>, <sourabhjain@linux.ibm.com>,
	<adityag@linux.ibm.com>, <songshuaishuai@tinylab.org>,
	<takakura@valinux.co.jp>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <kexec@lists.infradead.org>
CC: <jonnyc@amazon.com>
Subject: [PATCH v4 0/2] Improve interrupt handling during machine kexec
Date: Fri, 29 Nov 2024 11:31:17 +0000
Message-ID: <20241129113119.26669-1-farbere@amazon.com>
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
[PATCH v4 1/2] Move machine_kexec_mask_interrupts() to kexec_core.c,
               removing duplicate architecture-specific implementations.
[PATCH v4 2/2] Refine machine_kexec_mask_interrupts() to avoid re-masking
               already-masked interrupts, resolving specific warnings
               triggered in GPIO IRQ flows.

Changes between v3 and v4:
 - Add missing <linux/irqdesc.h> and <linux/irq.h> includes.

Eliav Farber (2):
  kexec: Consolidate machine_kexec_mask_interrupts() implementation
  kexec: Prevent redundant IRQ masking by checking state before shutdown

 arch/arm/kernel/machine_kexec.c   | 23 -----------------------
 arch/arm64/kernel/machine_kexec.c | 31 -------------------------------
 arch/powerpc/include/asm/kexec.h  |  1 -
 arch/powerpc/kexec/core.c         | 22 ----------------------
 arch/riscv/kernel/machine_kexec.c | 23 -----------------------
 include/linux/irq.h               |  3 +++
 include/linux/kexec.h             |  2 ++
 kernel/irq/internals.h            |  1 -
 kernel/kexec_core.c               | 30 ++++++++++++++++++++++++++++++
 9 files changed, 35 insertions(+), 101 deletions(-)

-- 
2.40.1



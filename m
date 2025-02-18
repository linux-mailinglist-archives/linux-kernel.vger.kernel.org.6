Return-Path: <linux-kernel+bounces-519591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044FDA39E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC00188D77A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C656726A0A7;
	Tue, 18 Feb 2025 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="tzk3AXnE"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA0F236A61
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887864; cv=none; b=HW9NB90GLD0I6nXKa3glb7fqUXR9qZcE8fsvSPL28u1m0oXzMZtdSggLn1i5i08/OQRba+EFB9i2UTpmlt9MUFAmzD40xKsikA4QbXzdPzFSfB96mDD84riAS4SoBT9IKFwUJQ6sax6CcmFIV/6BI+eNhIPIte1Dh2EARGKRYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887864; c=relaxed/simple;
	bh=yw5Mlo1NDA2JUqGk0E175mUAGVEem3ZLo8eW/gexkO8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YP4g7Af9ziVYO3iVNnHF/U7b6uNplAbud6CMOSSNEBZHTGedAB6mpwfNdO8lTjaDATq/ijVk7jtBWUzvx6D5HTv67onXMzyen8MLdJC8GvJfGdzkDBjrVyNClzIrQErlI4HH3SEp0YKkfI39YL/ScgSeaQT6VyVTem/ELNHxt3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=tzk3AXnE; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1739887860; x=1771423860;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UbGAlNFeDSOd0mKhsoLIp39iu1+dh2tNlSoCV8HdgVw=;
  b=tzk3AXnErWmYkBLiV8NrNKQlWPjJSkRzaqic0moSY+yg77tpnLusiU5v
   jCMioTec/BA91O8ZvdvaCr4A+K8tnM6PftvznFVcqmC9nJjjWLJkJNEPo
   qnBE7a5siXjsCV0kkxzz9XH9DaCKEB4b0Zs/za2/J1HHQ28Y6BFgixqvn
   I=;
X-IronPort-AV: E=Sophos;i="6.13,296,1732579200"; 
   d="scan'208";a="378382642"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 14:10:58 +0000
Received: from EX19MTAUEC001.ant.amazon.com [10.0.29.78:9210]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.85.113:2525] with esmtp (Farcaster)
 id a5ce179b-5db0-4fdd-b466-595760027a8f; Tue, 18 Feb 2025 14:10:56 +0000 (UTC)
X-Farcaster-Flow-ID: a5ce179b-5db0-4fdd-b466-595760027a8f
Received: from EX19D008UEA001.ant.amazon.com (10.252.134.62) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 18 Feb 2025 14:10:55 +0000
Received: from EX19MTAUEC002.ant.amazon.com (10.252.135.146) by
 EX19D008UEA001.ant.amazon.com (10.252.134.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Feb 2025 14:10:55 +0000
Received: from email-imr-corp-prod-pdx-all-2b-dbd438cc.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Tue, 18 Feb 2025 14:10:55 +0000
Received: from dev-dsk-stanspas-1a-2337b95e.eu-west-1.amazon.com (dev-dsk-stanspas-1a-2337b95e.eu-west-1.amazon.com [172.19.107.251])
	by email-imr-corp-prod-pdx-all-2b-dbd438cc.us-west-2.amazon.com (Postfix) with ESMTPS id C4267A6913;
	Tue, 18 Feb 2025 14:10:53 +0000 (UTC)
From: Stanislav Spassov <stanspas@amazon.de>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>, James Gowans
	<jgowans@amazon.com>, Stanislav Spassov <stanspas@amazon.de>
Subject: [PATCH v1] x86/fpu: Fix guest FPU state buffer allocation size
Date: Tue, 18 Feb 2025 14:10:45 +0000
Message-ID: <20250218141045.85201-1-stanspas@amazon.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Ongoing work on an optimization to batch-preallocate vCPU state buffers
for KVM revealed a mismatch between the allocation sizes used in
fpu_alloc_guest_fpstate() and fpstate_realloc(). While the former
allocates a buffer sized to fit the default set of XSAVE features
in UABI form (as per fpu_user_cfg), the latter uses its ksize argument
derived (for the requested set of features) in the same way as the sizes
found in fpu_kernel_cfg, i.e. using the compacted in-kernel
representation.

The correct size to use for guest FPU state should indeed be the
kernel one as seen in fpstate_realloc(). The original issue likely
went unnoticed through a combination of UABI size typically being
larger than or equal to kernel size, and/or both amounting to the
same number of allocated 4K pages.

Fixes: 69f6ed1d14c6 ("x86/fpu: Provide infrastructure for KVM FPU cleanup")
Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
---
 arch/x86/kernel/fpu/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1209c7aebb21..36df548acc40 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -220,7 +220,7 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
 	struct fpstate *fpstate;
 	unsigned int size;
 
-	size = fpu_user_cfg.default_size + ALIGN(offsetof(struct fpstate, regs), 64);
+	size = fpu_kernel_cfg.default_size + ALIGN(offsetof(struct fpstate, regs), 64);
 	fpstate = vzalloc(size);
 	if (!fpstate)
 		return false;
-- 
2.47.1



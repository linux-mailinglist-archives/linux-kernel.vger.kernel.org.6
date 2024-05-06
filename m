Return-Path: <linux-kernel+bounces-170253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CB38BD424
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8F41F243C5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17414158204;
	Mon,  6 May 2024 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUOXwF6e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D45157499
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017891; cv=none; b=VXR552FAFwT2ZkNaP57Yp5quhIy0oQZYgvTEGCAUobd66AK1MZ7grcMxPA3qb4c8GtLfCh7pRTOiH93do+21F/eksFHr3RQDn3kRLuCcD4+D9z63AvmBQr/RrBEL5UsxDBgDGGI9I7OsxxsBDEYhORLYls7Vp8HqkF+X4b/h81w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017891; c=relaxed/simple;
	bh=UQFmeKn/bzeED5j5KLeTWIeVfsxa8Flk85fxjIC/duc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AkQXz1ty+HQr6isWQdhN6SFNRpnj0/t7IVmCj1VREvufotsC4J6CH2AOaWvQGttlx2f40yl5KNrlXeOWOxP75k6dpYYfAS2vT9GG75SbJKMat6k3ZJ1/XDU6IqQesSAJXCCMcZguhUHvCRJhqko2f0+ZYhdCunQeiGxazF750zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUOXwF6e; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715017890; x=1746553890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UQFmeKn/bzeED5j5KLeTWIeVfsxa8Flk85fxjIC/duc=;
  b=nUOXwF6eRZ+rApS64yK1hie45D7d/F6AJvMrmB9lhusm9BP8l3suzYw9
   63V7i2rH499KPRHztpJuDB2zAV01/WS1G1qwM0UUfVlgVZDJNutE9a5bG
   EWYbu6AKRYsBi1zm0nvjKJkdHxiQsO3dwU9DluPcTdjJa602wVg2LYKRV
   wjvjjj9JOMA8GdGKI+wmVxRvf1r59mZSKX1aw7OsyAP/Q+LSgOvqeEEnB
   e59aKvteZOp76EMOo3pJdRp7rcc6I3RBbdyAsITzo4GQTU4bMUgUhUZxT
   M2/+uAuw+g9ua97LeNN0LYkC0WZKoRexPwncJyiJFIfbyZFiTComxmL8V
   g==;
X-CSE-ConnectionGUID: 8q7UKbCBQLG/tgM9LbeceA==
X-CSE-MsgGUID: CZCVxhDnSciC9BNyrdAyug==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10626474"
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="10626474"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 10:51:29 -0700
X-CSE-ConnectionGUID: wo5tugwnTaSgA6Qva7Ivtw==
X-CSE-MsgGUID: FRbDgwEBRAazpww68Jnw5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,259,1708416000"; 
   d="scan'208";a="59414995"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa001.fm.intel.com with ESMTP; 06 May 2024 10:51:28 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: X86 Kernel <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Imran Khan <imran.f.khan@oracle.com>
Subject: [PATCH] x86/irq: Use existing helper for pending vector check
Date: Mon,  6 May 2024 10:56:12 -0700
Message-Id: <20240506175612.1141095-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lapic_vector_set_in_irr() is already available, use it for checking
pending vectors at the local APIC. No functional change.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Imran Khan <imran.f.khan@oracle.com>
---
 arch/x86/include/asm/apic.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9122e93b89ea..d7a8ac961af8 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -505,13 +505,7 @@ static inline bool lapic_vector_set_in_irr(unsigned int vector)
 
 static inline bool is_vector_pending(unsigned int vector)
 {
-	unsigned int irr;
-
-	irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
-	if (irr  & (1 << (vector % 32)))
-		return true;
-
-	return pi_pending_this_cpu(vector);
+	return lapic_vector_set_in_irr(vector) || pi_pending_this_cpu(vector);
 }
 
 /*
-- 
2.25.1



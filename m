Return-Path: <linux-kernel+bounces-570529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D909A6B1BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4564A073D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACC322D4C5;
	Thu, 20 Mar 2025 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnYBxdAu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BAD22CBE3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514198; cv=none; b=SELgtHsv9+IZ3Liaj0YdwbsLKmqm7rMmhimZrMDHpILHbyHHzrn+HbOXpLTaYY0T4RRKBIzQNtjHeH7UagDJ6xaJVHL5unb7N4hGYsNjSNRwTC8gP+uaNwnhrKE/te6M+esp2ud9B+fQprejcag7lViNcV5yAxGQzdF1G7Xs4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514198; c=relaxed/simple;
	bh=RNLRsZq30foUqdf9pTnNJcZQdOrD5Yha7VHSwhaeXc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uhr6vy4QTMJkZjpnFPa9Y3DbfHiPLYUfrcVMGceuWyCkOT4UTDJtSfSFW7ztrPIvv650EEYhVLo2/1xEt5j8+1W5P7mNOVSLVcSru9nStOUARO8UFAspJxvsRp9vHIi5ukiVqbyPzSgyrxg289bfJraCNw8bj+LbSqj0zf5GVBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnYBxdAu; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514195; x=1774050195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RNLRsZq30foUqdf9pTnNJcZQdOrD5Yha7VHSwhaeXc0=;
  b=WnYBxdAuW++QO8gjk767/8lq8rrFBmGugwHByWI2NgGSunpmHGALDqdo
   W7YOAnSSxZfNBn0ArB827wG264pFDHg+tR3HiJWLfLLC8sJ74N8cUtICp
   uKJEWrKX0wwjbhBse1Jj9Q4N3Fvx46W66IMvman0STffKp43DHH29HjLy
   bWyPRsjdlwQqrFQMVHZa0OIN2TrB+Ix3h3gMRHNXcVI6a0j0j2pVYRQi2
   4ODXBEQgO9AYJ9YzPqbHI1bwiB+ccafHfDC/jI39+Y12c0DK/wJZJ+lca
   eu2Gs6JiFASac75LLWqQKdTYFMP9ZIEWCzyXnnoJCbspn1el6MecyMLBx
   g==;
X-CSE-ConnectionGUID: LxhBr/M/QCuQQtOsJR2uJw==
X-CSE-MsgGUID: wwvzCw0QTGycwsI+N4zYxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43502593"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43502593"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:43:15 -0700
X-CSE-ConnectionGUID: gMya7LexS4eGmNY6RNvFww==
X-CSE-MsgGUID: f5/jU1VNQeq5oJ08ibnqqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="122962968"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by orviesa009.jf.intel.com with ESMTP; 20 Mar 2025 16:43:15 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v2 4/9] x86/fpu/xstate: Adjust xstate copying logic for user ABI
Date: Thu, 20 Mar 2025 16:42:55 -0700
Message-ID: <20250320234301.8342-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250320234301.8342-1-chang.seok.bae@intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250320234301.8342-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

== Background ==

As feature positions in the userspace XSAVE buffer do not always align
with their feature numbers, the XSAVE format conversion needs to be
reconsidered to align with the revised xstate size calculation logic.

* For signal handling, XSAVE and XRSTOR are used directly to save and
  restore extended registers.

* For ptrace, KVM, and signal returns (for 32-bit frame), the kernel
  copies data between its internal buffer and the userspace XSAVE buffer.
  If memcpy() were used for these cases, existing offset helpers — such
  as __raw_xsave_addr() or xstate_offsets[] — would be sufficient to
  handle the format conversion.

== Problem ==

When copying data from the compacted in-kernel buffer to the
non-compacted userspace buffer, the function follows the
user_regset_get2_fn() prototype. This means it utilizes struct membuf
helpers for the destination buffer. As defined in regset.h, these helpers
update the memory pointer during the copy process, enforcing sequential
writes within the loop.

Since xstate components are processed sequentially, any component whose
buffer position does not align with its feature number has an issue.

== Solution ==

Replace for_each_extended_xfeature() with the newly introduced
for_each_extended_xfeature_in_order(). This macro ensures xstate
components are handled in the correct order based on their actual
positions in the destination buffer, rather than their feature numbers.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 93f94013b094..46c45e2f2a5a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1107,10 +1107,9 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 	const unsigned int off_mxcsr = offsetof(struct fxregs_state, mxcsr);
 	struct xregs_state *xinit = &init_fpstate.regs.xsave;
 	struct xregs_state *xsave = &fpstate->regs.xsave;
+	unsigned int zerofrom, i, xfeature;
 	struct xstate_header header;
-	unsigned int zerofrom;
 	u64 mask;
-	int i;
 
 	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
@@ -1179,15 +1178,16 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 	 */
 	mask = header.xfeatures;
 
-	for_each_extended_xfeature(i, mask) {
+	for_each_extended_xfeature_in_order(i, mask) {
+		xfeature = xfeature_uncompact_order[i];
 		/*
 		 * If there was a feature or alignment gap, zero the space
 		 * in the destination buffer.
 		 */
-		if (zerofrom < xstate_offsets[i])
-			membuf_zero(&to, xstate_offsets[i] - zerofrom);
+		if (zerofrom < xstate_offsets[xfeature])
+			membuf_zero(&to, xstate_offsets[xfeature] - zerofrom);
 
-		if (i == XFEATURE_PKRU) {
+		if (xfeature == XFEATURE_PKRU) {
 			struct pkru_state pkru = {0};
 			/*
 			 * PKRU is not necessarily up to date in the
@@ -1197,14 +1197,14 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 			membuf_write(&to, &pkru, sizeof(pkru));
 		} else {
 			membuf_write(&to,
-				     __raw_xsave_addr(xsave, i),
-				     xstate_sizes[i]);
+				     __raw_xsave_addr(xsave, xfeature),
+				     xstate_sizes[xfeature]);
 		}
 		/*
 		 * Keep track of the last copied state in the non-compacted
 		 * target buffer for gap zeroing.
 		 */
-		zerofrom = xstate_offsets[i] + xstate_sizes[i];
+		zerofrom = xstate_offsets[xfeature] + xstate_sizes[xfeature];
 	}
 
 out:
-- 
2.45.2



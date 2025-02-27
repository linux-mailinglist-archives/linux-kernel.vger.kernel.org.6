Return-Path: <linux-kernel+bounces-537102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3021AA48814
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A044B169C96
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DA81D935C;
	Thu, 27 Feb 2025 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKqclqxO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FF126D5B7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681911; cv=none; b=XESErk64ak9nQiKMA7dFkB3+MGLz5A9wVD2UhA8lkRmCzJ+j5qouMvUcaHk4md76iWGIjw/dVHWrsSh62HmeKOEg1YMvOrN17H5hwivTYvDQcUZ7d0hiS1TijgkBuDuNjeaSMlMLrCT+irFImvBCm75aGmHHoekp/aJ+KgrZhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681911; c=relaxed/simple;
	bh=v3kIX0ZxQDiQq9ytxtP1qxcASSi89ty5zyeqjVl/ciA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwm2IEaQWMsxAJruLTyaOvRjRh37sRL2UQ6qrn4pxmSujD94aILa+0QEssFmSGp12rotz29/RZOrEPb2aHOG3uqDe3TdA9o/ka89FGciyzc5I8L6fxVO+eagueorMgJj8AyU5RWR+v13aZtHQqXX/vt7DCZ7mR127sKAVIiFATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKqclqxO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740681910; x=1772217910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v3kIX0ZxQDiQq9ytxtP1qxcASSi89ty5zyeqjVl/ciA=;
  b=VKqclqxO07gbpZ1Q001VsqnSvaPRMAx+2xhGD4AqV6mdFD7BVRgebrNC
   GEMqgnAygRd3OKEuAwJoXofCNW+7lJWON6GfnHKyMpK6SAdHXncdg336o
   p3Nf/HbNm1jtV24z1NYh8twAKTp6lc+4tdnIyT2yHCuJLq5IQROebufG+
   76/aTixDQqc5klFZTmQPhR/g/irf9WucK53S85FrZNKQMR+YVqVFqRJ21
   N3PVdn3YpZZ9InAmCYR9qnu1O6QCeovWdvJjlC80pBiLBrrY69jX4VNtc
   ls/xVPhkedpNHRrdMsUY2q1gs0JVvsHEYNBPUIQ+D6RnHJPvleISGxhAl
   w==;
X-CSE-ConnectionGUID: yTqy82NASwSEKrPvz/w7jw==
X-CSE-MsgGUID: a8ogsUqiQ+iGQ6F7IshxWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41720884"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41720884"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 10:45:09 -0800
X-CSE-ConnectionGUID: WBVJT+7vRMKCuQvDS28alw==
X-CSE-MsgGUID: 7+yFHzS/RDuvfapBDp6ajw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117767403"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.154.132])
  by fmviesa009.fm.intel.com with ESMTP; 27 Feb 2025 10:45:08 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v1 05/11] x86/fpu/xstate: Adjust xstate copying logic for user ABI
Date: Thu, 27 Feb 2025 10:44:50 -0800
Message-ID: <20250227184502.10288-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250227184502.10288-1-chang.seok.bae@intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
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
index 06d2be602ea9..d04221d0fa0a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1102,10 +1102,9 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
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
@@ -1174,15 +1173,16 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 	 */
 	mask = header.xfeatures;
 
-	for_each_extended_xfeature(i, mask) {
+	for_each_extended_xfeature_in_order(i, mask) {
+		xfeature = xfeature_noncompact_order[i];
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
@@ -1192,14 +1192,14 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
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



Return-Path: <linux-kernel+bounces-514166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 587A1A35379
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C947A1BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 01:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47E37160;
	Fri, 14 Feb 2025 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Stm3WmDg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45B22338
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495171; cv=none; b=MNP8nHIxCISz8Us4XbKizgKT+tfZM8J9loibB25XZZDMoqj4ngzdQlr1L/5UjBw9Zey36/CxOU3UNIM1hH/Y1Viscy/ih5EDkaZS7niJ7Sf5LO1nFizMY5HjA7jh8QYvyEfHz79YTZhdAGt7PN49qGQSNhFHcOM/1/OrBjQgqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495171; c=relaxed/simple;
	bh=3yogtkjeT8EwtXj/Us/3p/Xx6ZRkKcobH+D1mhxZ+1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITNSoTXiqCA1kdyMMHx77HQFPlgBa60KKpmu4M6TINJ61+EBMw9v+2r42LY0sg7FUKuNblYUAgT1hTGWOeieD8VGEGimmBneHiJhvbYGzyk0R1F/iOYggpzpSBPfv539g33sN1iymycYNV/5I5hcEIeNrMYdaA3q0MVO6TYx1yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Stm3WmDg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739495171; x=1771031171;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3yogtkjeT8EwtXj/Us/3p/Xx6ZRkKcobH+D1mhxZ+1o=;
  b=Stm3WmDgUcwksks5D71rfCk2BTpOHQkPeUkTKKgSyLgiC7VZFxJ2Q4ZO
   55LiqxxDlSUrA6Y11InKiSuOhqV9t+FzfDOuHMd0jR8BYEofCr0Li2xq8
   bXhsE2iI/00yGb9pOziAoo6Dsl4nJsf8mq+gUHnVt4cgR1ANk8vPWfyCh
   LHaxrl6jpMHGCeJlxN3EE7OxuQ6wvo05JyGB5eESoq7B7BGkv6xpLUvV/
   UnHQA7PBc3LaZv8l8iBEYQPpkQWz7IuFqHRRh39bYhmHqDYZyW2+ngNg6
   cYO6ghabNQA92wffdS+Q3Z5BIgNAOsTxRvcgA2lbTZ1WjXB3GTW8MjG2Q
   g==;
X-CSE-ConnectionGUID: sr4AjhIPTmqxpnhSIKEBXQ==
X-CSE-MsgGUID: dhVdbahYTcya/GgM5fDNTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="50442868"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="50442868"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 17:06:10 -0800
X-CSE-ConnectionGUID: DeOkYzj3RQq0swQ+x0fUzg==
X-CSE-MsgGUID: DZlVDi4iRXeiAd7jiLcrdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="118402581"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.154.132])
  by fmviesa004.fm.intel.com with ESMTP; 13 Feb 2025 17:06:08 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	aruna.ramakrishna@oracle.com,
	TonyWWang-oc@zhaoxin.com,
	chang.seok.bae@intel.com
Subject: [PATCH 0/2] x86/pkeys: Remove unnecessary XGETBV1 dependency in signal frame exposition
Date: Thu, 13 Feb 2025 17:06:05 -0800
Message-ID: <20250214010607.7067-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series removes an unnecessary dependency on XGETBV1 which was
brought by commit

    ae6012d72fa6 ("x86/pkeys: Ensure updated PKRU value is XRSTOR'd").

Currently, the PKRU exposure logic overwrites xregs_state->header
->xfeatures in the signal frame, seemingly to emulate XSAVE behavior:
combining the requested feature bitmap with a processor-tracked status
bitmap derived from XGETBV(1).

A previous posting [1] attempted to handle the case where XGETBV(1) is
disabled or unexposed. However, that approach assumed this dependency was
necessary and further modified the logic to skip PKRU writes in such
cases, which appears problematic.

Instead, the XSAVE-written value can be read directly from userspace
memory, as is already done for legacy states [2]. Thus, tying PKRU
exposure in the ABI to XGETBV1 is excessive. This series refactors
reusable code into a helper and applies it to PKRU handling, fully
eliminating the XGETBV1 dependency.

Thanks,
Chang

[1]: https://lore.kernel.org/lkml/20250102075419.2559-1-TonyWWang-oc@zhaoxin.com/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/signal.c#n139

Chang S. Bae (2):
  x86/fpu: Refactor xfeature bitmask update code for sigframe XSAVE
  x86/pkeys: Simplify PKRU update in signal frame

 arch/x86/kernel/fpu/signal.c | 11 +----------
 arch/x86/kernel/fpu/xstate.h | 21 +++++++++++++++------
 2 files changed, 16 insertions(+), 16 deletions(-)


base-commit: b36de8b904b8ff2095ece7af6b3cfff8c73c2fb1
-- 
2.45.2



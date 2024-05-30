Return-Path: <linux-kernel+bounces-195834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F8A8D527B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C711C23DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D26158A00;
	Thu, 30 May 2024 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4ZrBZSt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4312F12E6D;
	Thu, 30 May 2024 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717098247; cv=none; b=CXCk9/+hfYk9kVxfhzMEgOOurxsGENEgMMxFldysilXI6RqCL87Ha5UGROrs6s8Y4igKsR1/EM6ThJ1qGs9U0lu0juhgVm2opwl+PWxSnG3pbv0JP9ypv4iHQGwvKmWWjibwnY2bKP6u5RK+9uVd75+sWaNfEzUGf/BFaAjxHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717098247; c=relaxed/simple;
	bh=Jmwxt8bWquRc2Bo8nA6dbosFgYTM5uelPHKc3KAchq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XH4w2FCBZO/rbVS8+Un+L7PYLsPynHSPtxhtIUNPILW0FrMLx20Fo6/0RWRuWCHxJJIFo/ZBCGh0qZfB5Tt6uR9khZXUW/0oRDvQxNthyZY4Dj6oJMXxjAtw1PfLw7CWIqK4QFsMYICRZsiwqpvLlNvE7lcXps8APENdw35iQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4ZrBZSt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717098246; x=1748634246;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jmwxt8bWquRc2Bo8nA6dbosFgYTM5uelPHKc3KAchq0=;
  b=F4ZrBZStxB6pRcxfkqMoVKCdf/EwVIWEbGcuWllBX05fl7xizh5Hl9a6
   WFDjXHKFTCTacm+qFJvw/G/ZC/4E1KLzNpMtiZ+HJJ4f1kof9eJYVsVr4
   Mvc7eV/32AtAUCudt3hQ3auG7pNCy5NJ5l49BEjhuxIwgVrtu5mzby8EX
   VMTvddpKNV1diM7B6b90dcSwEzoRVhEQSxKenISSzywwVPGonT5HTjzyk
   unTNGfi6ry/7NdphxBMjCnHIyKbaQMu4giSB2pUpTJfzckrhmHIqs5dAP
   x3wbWfDjN95QlQSlRFqBGu7xPzoveJglWzwmKYBJpN716EkadnC4TgwqX
   g==;
X-CSE-ConnectionGUID: F10TKrOHSbicWOallAGjDQ==
X-CSE-MsgGUID: wj6iL/PRSRKqssLKXJq4ww==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31143988"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="31143988"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 12:44:05 -0700
X-CSE-ConnectionGUID: 1/AsBVNGRi6pdfTq65GHFQ==
X-CSE-MsgGUID: Z7wdXs2VRU2fjDeKfAmLVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="36027619"
Received: from chang-linux-3.sc.intel.com ([172.25.66.177])
  by orviesa009.jf.intel.com with ESMTP; 30 May 2024 12:44:06 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	platform-driver-x86@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com,
	ashok.raj@intel.com,
	jithu.joseph@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 0/3] x86/fpu: Allow the In-Field Scan driver to initialize FPU state
Date: Thu, 30 May 2024 12:27:36 -0700
Message-Id: <20240530192739.172566-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This revision switches to a new approach by providing a helper to
initialize user FPU states for the driver, which is considerably simpler.
This approach could serve as an example for addressing similar situations
from a non-critical path.

I thought fpu_reset_fpregs() as the helper name. There is already one
with this name. Then, I realized the existing one is a bit misaligned, so
renamed it first here.

Thanks to Dave for the reviews and the suggestion.

Thanks,
Chang

The previous postings:
V2: https://lore.kernel.org/all/20240507235344.249103-1-chang.seok.bae@intel.com
V1: https://lore.kernel.org/all/20240430212508.105117-1-chang.seok.bae@intel.com

Chang S. Bae (3):
  x86/fpu: Rename fpu_reset_fpregs() to fpu_reset_fpstate_regs()
  x86/fpu: Allow FPU users to initialize FPU state
  platform/x86/intel/ifs: Initialize FPU states for the scan test

 arch/x86/include/asm/fpu/api.h           |  2 ++
 arch/x86/kernel/fpu/core.c               | 17 ++++++++++++++---
 drivers/platform/x86/intel/ifs/ifs.h     |  1 +
 drivers/platform/x86/intel/ifs/runtest.c |  7 +++++++
 4 files changed, 24 insertions(+), 3 deletions(-)


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.34.1



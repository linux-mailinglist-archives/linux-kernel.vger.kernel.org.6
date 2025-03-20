Return-Path: <linux-kernel+bounces-570517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BE6A6B1B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13282188BAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B655121D3DD;
	Thu, 20 Mar 2025 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8iSdQK2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179EF215770
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514074; cv=none; b=rL4aanq43hVEOP0NqT0nc79ypy5jpw2F68IuQ2wTfuK+3i8Nk5pNQsrFioAlLDStt8o+EWUoybRAYY8eSEXFKxz7wIEBeP2/fY5fBa4Gp8XzagpeFAe1nDRTt7BN36spm/BdSTHtECD6G1/hvhERJP6jv21JiUexmlGub03tcHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514074; c=relaxed/simple;
	bh=WT6Dt8NzbDjMwPOQ+0uBv5tX6x5jEDfLCYjbb4O9HKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TP6au8P9Y4YsmevXTUnmjrgoW/R7HYOpQ4ygzbfiuxopfWOQC47tsJyC1eol3Wmrw3ymf27PqWuTWgu0ody79xRPpxNMaAycMfnRrUPEtqp0J8RAsfkIZKrTipIYDiUfTyPvT/KzcgsQGUw059KjlwiCsigJlfaREKHtVT61NcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8iSdQK2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514071; x=1774050071;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WT6Dt8NzbDjMwPOQ+0uBv5tX6x5jEDfLCYjbb4O9HKo=;
  b=E8iSdQK253ToWvpErC6b9a5CHO79uQSsC4SZMa0vvcfY1pLTT8G9axez
   ISnVVfwaEg47EZak0aW/k+73Dr6XEAZo4myHv+zN1NQHl8vg4lZ+/JSmS
   7aq+4LDeoMc5ycL5R+FSw+8QlONB8nr3H0J92yRQhZuFAjmuA1rCYA4Gu
   LHgOuFI2clWvSUaNp8fN5AeEkfuy1bMLzZT2g8etHMhygJ9VCaWVU2QRT
   JxDUVbwLBUNEbedJBRuwuwnQIoqL+AEBDq7tK6dXE1Ardkp/ungkx9OI2
   45g1C5LONWZTnb7yIKXiIT6K4a6o4BrWhhfmMIKyvdPe2V58j13wQG5hx
   A==;
X-CSE-ConnectionGUID: yYR4430mT4yVqpx4JIEHXw==
X-CSE-MsgGUID: z5/wcdDNS2K8k+9GkB2I7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="54439121"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="54439121"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:41:10 -0700
X-CSE-ConnectionGUID: 1NPY9ezlQU67RaASDCWQrA==
X-CSE-MsgGUID: rvReTJVFSXOFFFFyk+bi/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123417974"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by fmviesa008.fm.intel.com with ESMTP; 20 Mar 2025 16:41:10 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	colinmitchell@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH v2 0/6] x86: Support for Intel Microcode Staging Feature
Date: Thu, 20 Mar 2025 16:40:52 -0700
Message-ID: <20250320234104.8288-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Here is a revision following up feedbacks from this posting [1]:

  *  Instead of embedding staging logic directly into load_late_locked(),
     it was suggested [3] to place it within load_late_stop_cpus(). This
     change ensures that staging is treated as a preparatory step
     before CPUs are stopped.

  *  Rather than introducing a separate .c file only for staging, the
     recommendation was to consolidate all staging-related code within
     intel.c [4].

  *  The previous implementation lacks clarity in explaining key aspects
     of the mailbox and staging handler. Improving documentation and
     readability in these areas was suggested as a necessary refinement
     [5,6], as I understood.

  *  It was also requested to fold MSR definitions into their usage
     patches [7].

In addition to addressing these points, I’ve considered a unified staging
state struct (patch 2), primarily to simplify the staging handler loop
while also improving overall code organization.

This series is based on the tip/master branch. You can also find it from
this repo:
    git://github.com/intel-staging/microcode.git staging_v2

I suspect the maintainers could afford another look at least after the
upcoming merge window. In the meantime, I would appreciate any additional
feedback from those interested in this feature.

The original cover letter, which provides some background on this feature
enabling and its initial integration considerations, can be found in the
previous postings [1,2]. The relevant specification has also been posted
[8].

Thanks,
Chang

[1] Last posting: https://lore.kernel.org/lkml/20241211014213.3671-1-chang.seok.bae@intel.com/
[2] RFC: https://lore.kernel.org/lkml/20241001161042.465584-1-chang.seok.bae@intel.com/
[3] https://lore.kernel.org/lkml/20250218113634.GGZ7RwwkrrXADX0eRo@fat_crate.local/
[4] https://lore.kernel.org/lkml/20250226175642.GOZ79V2jWQTH5rbuXo@fat_crate.local/
[5] https://lore.kernel.org/lkml/fac46937-e0a5-42c1-96ee-65fec4e17551@intel.com/
[6] https://lore.kernel.org/lkml/1aee0888-b87b-443c-84fa-3bc000cbebcf@intel.com/
[7] https://lore.kernel.org/lkml/20250226171923.GMZ79NG_8wDtZ8vyWH@fat_crate.local/
[8] Staging Spec: https://cdrdv2.intel.com/v1/dl/getContent/782715

Chang S. Bae (6):
  x86/microcode: Introduce staging step to reduce late-loading time
  x86/microcode/intel: Define staging state struct
  x86/microcode/intel: Establish staging control logic
  x86/microcode/intel: Implement staging handler
  x86/microcode/intel: Support mailbox transfer
  x86/microcode/intel: Enable staging when available

 arch/x86/include/asm/msr-index.h         |   9 +
 arch/x86/kernel/cpu/microcode/core.c     |  11 +
 arch/x86/kernel/cpu/microcode/intel.c    | 341 +++++++++++++++++++++++
 arch/x86/kernel/cpu/microcode/internal.h |   4 +-
 4 files changed, 364 insertions(+), 1 deletion(-)


base-commit: 758ea9705c51865858c612f591c6e6950dcafccf
-- 
2.45.2



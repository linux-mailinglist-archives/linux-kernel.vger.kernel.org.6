Return-Path: <linux-kernel+bounces-512194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD276A33576
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95631662A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9A214A60F;
	Thu, 13 Feb 2025 02:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPh//vIJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46357433AD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739413401; cv=none; b=C2q8XTBEK4zhgWXE8s90matKijt7NYY8bEsapLARB8DNTfWVIk+h3pjADeUDTpYHRYRsS8ekLSkdDCwsqs5Gz0Rgufs33XKlzcJ25N7D5lN3SCz3Xc/zqxpxLQ4PjuUh1DijgGRrvAIL7IgvVDMHyGLCUixzI0om82hUdSZi0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739413401; c=relaxed/simple;
	bh=o1jcl5KI/y1cuttFf66JMvaljCmtyP77ZEjjtgROw0Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Cj7B1sw+TqjK7dULdY99Va9jHdkXEcSGMIpjJHZU5VMqghobQ0Kz1HtIvrX9nC0cDLitRJ8K3WnrkdjnSURqq9AUkHRgRZDcI9GNoBf4wyHw8UCbYG6CJWgP4KhBUOTXmX0XoewArjWOTQcEj3H/7CYZxFWm36JQPHpWvDT/ZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iPh//vIJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739413401; x=1770949401;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=o1jcl5KI/y1cuttFf66JMvaljCmtyP77ZEjjtgROw0Q=;
  b=iPh//vIJ3mDcHjocSecFDKxN/9fe+CpEqfrUOTsKGanQUZEmU3GtOf7u
   n0xka/1mJkhJXQTf2IpZ7KL2mWaDseV0QUtp1mo3T0DSDnkATBNninjsi
   XgtGZonvzt9asmVvzcYKqJobdXyJunvEsjGnAlxStRZCOfGYYhHydTiC9
   EVLoKhfGij+v0tjftqZ7597RxMSl2ipm64/+HdPSnJxUu7kaBhVYeOHLd
   hp68vc6wiHETVe/2ysnCoI+kpxPtc5iEpnnGINfmePHXlz+3g3PefAV4q
   wtICMYbOgTUZmxZ6xQOr6kMsOTgGRiovtBwsDIgNUAZ58QhpRQayukiTh
   Q==;
X-CSE-ConnectionGUID: CC6yvoQHTlO4p2LPZ9qPkA==
X-CSE-MsgGUID: Bp9hfIiKR4Oddu8QlrVCgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="62566614"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="62566614"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 18:23:20 -0800
X-CSE-ConnectionGUID: bmEXs7aiRjC6g2NNS+17sg==
X-CSE-MsgGUID: 3KThC2W1R3ard7Y7XK53LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113905824"
Received: from rtice-desk1.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.246.116.160])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 18:23:19 -0800
From: Cedric Xing <cedric.xing@intel.com>
Subject: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
Date: Wed, 12 Feb 2025 20:23:03 -0600
Message-Id: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIdXrWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwNL3ZKUCt2iktwiXSNTUxNzSzMzc0MTMyWg8oKi1LTMCrBR0bG1tQA
 oZnqVWgAAAA==
To: Dan Williams <dan.j.williams@intel.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 Cedric Xing <cedric.xing@intel.com>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: b4 0.13.0

NOTE: This patch series introduces the Measurement Register (MR) ABI, and
is a continuation of the RFC series on the same topic [1].

This patch series adds a unified interface to TSM core for confidential
computing (CC) guest drivers to provide access to measurement registers
(MRs), which are essential for relying parties (RPs) to verify the
integrity of the computing environment. The interface is structured around
`struct tsm_measurement`, which holds an array of `struct
tsm_measurement_register` and includes operations for reading and updating
MRs.

Each `struct tsm_measurement_register` features a `mr_flags` member that
indicates the MR's properties, such as *Readable* (`TSM_MR_F_R`),
*Extensible* (`TSM_MR_F_X`), etc. Please refer to Patch 1 in this series
for more details. Patch 2 adds a sample module to demonstrate how to define
and implement MRs in a CC guest driver. The last patches add TDX MR support
to the TDX Guest driver.

MRs are made accessible to applications through a directory tree (rooted at
`/sys/kernel/tsm`). An MR could be presented as either a file containing
its value, or a directory containing the file `digest` under a subdirectory
of the same name as the hash algorithm. By default, an MR will be presented
as a directory unless `TSM_MR_F_F` is set in `mr_flags`.

[1]: https://lore.kernel.org/linux-coco/20241210-tsm-rtmr-v3-0-5997d4dbda73@intel.com/

Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
Cedric Xing (3):
      tsm: Add TVM Measurement Register support
      tsm: Add TSM measurement sample code
      x86/tdx: Expose TDX MRs through TSM sysfs interface

Kuppuswamy Sathyanarayanan (1):
      x86/tdx: Add tdx_mcall_rtmr_extend() interface

 Documentation/ABI/testing/sysfs-kernel-tsm |  20 ++
 MAINTAINERS                                |   3 +-
 arch/x86/coco/tdx/tdx.c                    |  36 +++
 arch/x86/include/asm/shared/tdx.h          |   1 +
 arch/x86/include/asm/tdx.h                 |   2 +
 drivers/virt/coco/Kconfig                  |   3 +-
 drivers/virt/coco/Makefile                 |   2 +
 drivers/virt/coco/tdx-guest/Kconfig        |  15 ++
 drivers/virt/coco/tdx-guest/tdx-guest.c    | 119 +++++++++
 drivers/virt/coco/{tsm.c => tsm-core.c}    |   6 +-
 drivers/virt/coco/tsm-mr.c                 | 375 +++++++++++++++++++++++++++++
 include/linux/tsm.h                        |  64 +++++
 samples/Kconfig                            |  10 +
 samples/Makefile                           |   1 +
 samples/tsm/Makefile                       |   2 +
 samples/tsm/tsm_mr_sample.c                | 107 ++++++++
 16 files changed, 763 insertions(+), 3 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250209-tdx-rtmr-255479667146

Best regards,
-- 
Cedric Xing <cedric.xing@intel.com>



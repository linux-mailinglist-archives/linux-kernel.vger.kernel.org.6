Return-Path: <linux-kernel+bounces-320016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507AE970518
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 06:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023C5282CE2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 04:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508014964E;
	Sun,  8 Sep 2024 04:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHasQbiy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769722AE94
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725771472; cv=none; b=g6rN4gRAMFZVQKMpGRddCKgxuz2SVZa6YqKC/nlryM9XEYYGdxuN18ICNM00Lp5iVtA43W0WA/TkLgFN+CPZRiHeRlhF5Eu9vdI8HkHsnWKmT4UP9y0Ubd85/93R6r1OyMG8IX/iNsf2DBx7Ij66nVmp/4oBb9AdT6EZaF25Tu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725771472; c=relaxed/simple;
	bh=qA5OYxRBHwI1X3vC8+wmcOP3BNpbMzeA9QExhdShNH4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LSl+9kD3U9dDJFL2jtxr/f8ht0YzipUPEfsq3v6t9ukk93eiA+q9ApUPJSFTRrrw59pePMzuYoTLGecGcNCdVatShLIboB1UP8An8KYpZ1knWIpy5+2m8acmtTQjxOslzwNNed6EBdQjCsZW9EmwHxJQRIL3Prx8j7zaDWaEdt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHasQbiy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725771469; x=1757307469;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=qA5OYxRBHwI1X3vC8+wmcOP3BNpbMzeA9QExhdShNH4=;
  b=MHasQbiykJyPBT8GikqrwkRW8dgDK/67MHrayZO3rTtrwBD+AHm9YvbM
   KdN8XUHZGSu9WYLFWtwSfKs+eeCWVLKWMVIkucyT2CL9Fl90V75pvrskG
   8+ZojsPc6d6O4PIkIlNt0VUrS+wHjbL1m+bu6JBky4vLYD6pA1LfJTExu
   iTYhn0TaYqTgDzt4EbFhEmxy4Y7M2GGUDlwGakRWrYk5ZuGRX7ZInSzY+
   bJ6msstPk0ccHcLLe2iBE+S/Y0i6Os2w+YHUw4VrwOCO4npfIJk5jdQNm
   y0G3y+iuZP/JUYvxjA5xCjzSWLZYYxrXO0JeksgqKTaP5YPQg+DRShEO6
   A==;
X-CSE-ConnectionGUID: flkJHo8KQgGFiadGnzqijg==
X-CSE-MsgGUID: SHnpwpMmTRujaXjtzqqgRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="35152164"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="35152164"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 21:57:48 -0700
X-CSE-ConnectionGUID: 6fI/PuQxQCya+BeBQdy3Ig==
X-CSE-MsgGUID: rq/YmnuhQteFcIFmXDuKxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="70924654"
Received: from ibarbour-mobl.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.246.116.49])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 21:57:47 -0700
From: Cedric Xing <cedric.xing@intel.com>
Subject: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
Date: Sat, 07 Sep 2024 23:56:18 -0500
Message-Id: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHIu3WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwMT3ZLiXN2iktwiXfNEE1MLU8sUo0RLMyWg8oKi1LTMCrBR0UpBbs5
 KsbW1AHOhWzBfAAAA
To: Dan Williams <dan.j.williams@intel.com>, 
 Samuel Ortiz <sameo@rivosinc.com>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Lukas Wunner <lukas@wunner.de>, 
 Dionna Amalie Glaze <dionnaglaze@google.com>, 
 Qinkun Bao <qinkun@google.com>, Mikko Ylinen <mikko.ylinen@linux.intel.com>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
X-Mailer: b4 0.13.0

NOTE: This patch series introduces the Measurement Register (MR) ABI, and is
largely a continuation of Samuel Ortiz’s previous work on the RTMR ABI [1].

This patch series adds a unified interface to TSM core for confidential
computing (CC) guest drivers to provide access to measurement registers (MRs),
which are essential for relying parties (RPs) to verify the integrity of the
computing environment. The interface is structured around
`struct tsm_measurement_provider`, which holds an array of
`struct tsm_measurement_register` and includes operations for reading and
updating MRs.

The MRs come in two varieties: static and runtime. Static MRs are determined at
the TEE VM (TVM) build time and capture the initial memory image or the
configuration/policy specified by the TVM's owner. In contrast, Runtime MRs
(RTMRs) start with known values, such as all zeros, at TVM build time and are
extended with measurements of loaded code, data, configuration, or executed
actions by the TVM guest during runtime.

Each `struct tsm_measurement_register` features a `mr_flags` member that
indicates the MR's properties. Static MRs are typically marked as read-only
with only the `TSM_MR_F_R` flag set, while RTMRs are marked as extensible with
the `TSM_MR_F_X` flag. For examples of defining and implementing MRs, refer to
Patch 3.

MRs are made accessible to applications through a directory tree, where static
MRs are represented as files and RTMRs as directories containing elements like
`digest` and `hash_algo`. Although the current root of this directory tree is
`/sys/kernel/tsm/`, other potential locations include configfs
(`/sys/kernel/config/tsm/`) and securityfs (`/sys/kernel/security/tsm/`). This
RFC (Request for Comments) series seeks feedback on the interfaces, with the
directory tree's location being a secondary concern. Further details can be
found in Patch 1.

Patch 2 introduces event log support for RTMRs, addressing the fact that the
standalone values of RTMRs, which represent the cumulative digests of
sequential events, are not fully informative on their own.

[1]: https://patchwork.kernel.org/project/linux-integrity/cover/20240128212532.2754325-1-sameo@rivosinc.com/

Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
Cedric Xing (3):
      tsm: Add TVM Measurement Register Support
      tsm: Add RTMR event logging
      tsm: Add TVM Measurement Sample Code

 drivers/virt/coco/Kconfig         |   4 +-
 drivers/virt/coco/tsm.c           | 598 +++++++++++++++++++++++++++++++++++++-
 include/linux/tsm.h               |  62 ++++
 samples/Kconfig                   |   4 +
 samples/Makefile                  |   1 +
 samples/tsm/Makefile              |   2 +
 samples/tsm/measurement-example.c | 116 ++++++++
 7 files changed, 777 insertions(+), 10 deletions(-)
---
base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
change-id: 20240904-tsm-rtmr-7a45859d2a96

Best regards,
-- 
Cedric Xing <cedric.xing@intel.com>



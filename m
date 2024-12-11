Return-Path: <linux-kernel+bounces-440705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBC59EC31D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3E51887C15
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6967120D510;
	Wed, 11 Dec 2024 03:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuhS7tV7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555820C000
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733887345; cv=none; b=Z62xGIPzYTykwhHPSpQFSRVIAncwMdfObupNLT2mD9JnSWPVIKhOgQ8qE8J7frHTWPqsbykHxfCOmJJKN6Otg0WfoUaUsEW3esJhVJsCEu2vdQukUX8PxeKGzPTqplDr44tR6ytGI0gWBJs3LJFV5wSnyXNsBkNHBFEVXrCwE20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733887345; c=relaxed/simple;
	bh=BblMdTek2Wml/bpRKRdA97BWh+x4IqXf48Y3nuDdim8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bemIqe8MEXPG0Za75XhRVZl0qBtBVnD5IvjlBVX2p/8ZgdO9XsffNqIAi1gMh1RVKvwQyCz22WFQ8TxR7ocA+Sgqz/TFSii4/bdivpdavd6yWEbHO+Uqgm/n9vZt6tCwM1+LgaQ3fn5F4aZIFEF5tjRCfhbl7RztQu9Gt4LZZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuhS7tV7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733887344; x=1765423344;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=BblMdTek2Wml/bpRKRdA97BWh+x4IqXf48Y3nuDdim8=;
  b=PuhS7tV76rXwRcBjlUAXx3wSdXLMPqNOn4woLcP31zvSPP4mYm2QfyMO
   Ncp8HZU6LYjE6FFGRX60XtzVma2zzy3GmJ3ly8G4VYSzwShsEA4LjTKs/
   IZxZD1p176q+i2wMKyPAV0yatLlBUjVyjcAk/hr1IVkHTOGEQLyNHkluL
   eBZiKu+g64QpMweVlqeS4Tn/3/D+dbcZoohniEy36h0bvm3KXvwsCMa8x
   WZcbitee6S549khzUB+YKdxaazrfru5cEOUv1pnBEbv2NrSLX3lavhlAi
   JrLgjs6OW7MFjorConKgQWmHwy2yNdXn4HUyQlCSwUWa5Iz/GikzkNTRC
   Q==;
X-CSE-ConnectionGUID: 7hzljZr9R1OlHeNP0xgHZQ==
X-CSE-MsgGUID: c0P6/j3SRaS8uFlA+cejzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="51785404"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="51785404"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 19:22:23 -0800
X-CSE-ConnectionGUID: OgbC4eu8Ra6sTjNC5mfRRg==
X-CSE-MsgGUID: n3SRmM6NT3GHy1KrfqDiKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118878394"
Received: from ibarbour-mobl.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.246.116.49])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 19:22:22 -0800
From: Cedric Xing <cedric.xing@intel.com>
Subject: [PATCH RFC v3 0/2] tsm: Unified Measurement Register ABI for TVMs
Date: Tue, 10 Dec 2024 21:22:14 -0600
Message-Id: <20241210-tsm-rtmr-v3-0-5997d4dbda73@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGYFWWcC/02M3QrCIBiGb2V8xxl+zs3sKAi6gE6jA5muCbmFi
 hRj955J1A7fn+eZIRhvTYB9NYM3yQY7jTnUmwq6QY03Q6zOGRhlnErKSQyO+Og8EYo3u0ZqpmQ
 L+f7wprfPorrA+XSEay4HG+LkX0WfsExfk/ibEhJKkPUd17zW3IiDHaO5b7vJFUliPxBpjSuQf
 UDVipYJ2UjENbgsyxsGauHO3gAAAA==
To: Dan Williams <dan.j.williams@intel.com>, 
 Samuel Ortiz <sameo@rivosinc.com>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Lukas Wunner <lukas@wunner.de>, 
 Dionna Amalie Glaze <dionnaglaze@google.com>, 
 Qinkun Bao <qinkun@google.com>, Mikko Ylinen <mikko.ylinen@linux.intel.com>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
X-Mailer: b4 0.13.0

NOTE: This patch series introduces the Measurement Register (MR) ABI, and
is largely a continuation of Samuel Ortiz’s previous work on the RTMR ABI
[1].

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
and implement MRs in a CC guest driver.

MRs are made accessible to applications through a directory tree (rooted at
`/sys/kernel/tsm`). An MR could be presented as either a file containing
its value, or a directory containing the file `digest` under a subdirectory
of the same name as the hash algorithm. By default, an MR will be presented
as a directory unless `TSM_MR_F_F` is set in `mr_flags`.

[1]: https://patchwork.kernel.org/project/linux-integrity/cover/20240128212532.2754325-1-sameo@rivosinc.com/

Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
Changes in v3:
- Added *Crypto Agility* support, see patch 1
- Fixed style issues in both commit messages and code
- Fixed incorrect assignment of files to commits
- Link to v2: https://lore.kernel.org/r/20241031-tsm-rtmr-v2-0-1a6762795911@intel.com

Changes in v2:
- Separated TSM MR code in a new file: `tsm-mr.c`.
- Removed RTMR event logging due to the lack of agreement on the log
  format.
- Default presentation of each MR as a directory, with the option to
  request an
  MR as a file using `TSM_MR_F_F`.
- Reduced verbosity: Renamed `struct tsm_measurement_provider` to `struct
  tsm_measurement`, and `tsm_(un)register_measurement_provider` to
  `tsm_(un)register_measurement`.
- Added `MODULE_DESCRIPTION` for measurement-sample.
- Fixed several compiler warnings on 32-bit builds.
- Link to v1: https://lore.kernel.org/r/20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com

---
Cedric Xing (2):
      tsm: Add TVM Measurement Register Support
      tsm: Add TVM Measurement Sample Code

 MAINTAINERS                             |   3 +-
 drivers/virt/coco/Kconfig               |   3 +-
 drivers/virt/coco/Makefile              |   2 +
 drivers/virt/coco/{tsm.c => tsm-core.c} |   6 +-
 drivers/virt/coco/tsm-mr.c              | 376 ++++++++++++++++++++++++++++++++
 include/linux/tsm.h                     |  64 ++++++
 samples/Kconfig                         |   4 +
 samples/Makefile                        |   1 +
 samples/tsm/Makefile                    |   2 +
 samples/tsm/measurement-example.c       | 113 ++++++++++
 10 files changed, 571 insertions(+), 3 deletions(-)
---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20240904-tsm-rtmr-7a45859d2a96

Best regards,
-- 
Cedric Xing <cedric.xing@intel.com>



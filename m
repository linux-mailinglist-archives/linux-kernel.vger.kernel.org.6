Return-Path: <linux-kernel+bounces-390962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B9A9B8095
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39ACA288DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577A61BD027;
	Thu, 31 Oct 2024 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSwPhuJU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421361A0B00
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393449; cv=none; b=jKEQczEi9weo3xmTyZ9k3aNs/Lj9LR9QI1KPBvaA2fHP+SAhtJ86quEsVSZH/DMPnTvWvlWjl2ErBqpHnq0y93HIrNk11O1llXso9DSVhabg9UMvpQ5F9P/M0aJxpDXj8QF2ifcdSXV06tRIqQLn6hRmvgRDvK+1XO60eAQdvLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393449; c=relaxed/simple;
	bh=GxiDslMxoB/b2hPqLO2xw8vPNP+oWQiDoxhqEkug5tA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K+lcVQ0Q7QbX9NQ6nWnHQFF4Ac+XsyRU65o+R5sZ0HD1wcUEhQDX1NYYCU+8OVmSDGHKv6c5wyWkCb+vvMSnZ2GIUMOp+6uN+XGTmUjy+K6J09SusVWzgBSR1gOM2PYgCUnBBl/CCO6l8c45zolWE1au+bZnx6/mI4+pdMzWA7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSwPhuJU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730393448; x=1761929448;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=GxiDslMxoB/b2hPqLO2xw8vPNP+oWQiDoxhqEkug5tA=;
  b=SSwPhuJUkdINDhEC3oA+kRiRKGDy2jJyyV2ILqUrU22d5Bvg2edevoLb
   CpAbrE8i5XGXWkd6nwHaktHHW4JwGzOw2ibiOE1AI16LOx+UI7MIqw4AQ
   Tf3PHqITkNeHBFVSVBJEkXwY0m38y7HF8EZ/38pGBfqmELryYlBX6jG0O
   h1S9rm49EbSW8BIueuMrMjxz1wZ2nrnQ3nYyebJN2jPVm0elYx9g80wPA
   GJ8IowD0r60pGu8QARH4x92QkuJvnNt2yuQ6H9r/kTIxLak1WIvMrc+w2
   YA3hZrJgUFgrgolGKN/jjt2QMhHuXb6puFK/yS7t+Ork3ZlTnQMbIyTJJ
   A==;
X-CSE-ConnectionGUID: IPgctozeR3eKnibPOLUtcw==
X-CSE-MsgGUID: qlAQ2otQTu2QmEI719dO7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30312362"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30312362"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:50:47 -0700
X-CSE-ConnectionGUID: VVnQKS/OTEiNIDek8OIKdA==
X-CSE-MsgGUID: qf2fUg6fR1ydFlpyKzcrSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82217184"
Received: from eschuber-mobl.amr.corp.intel.com (HELO bxing-mobl1.clients.intel.com) ([10.125.64.58])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:50:45 -0700
From: Cedric Xing <cedric.xing@intel.com>
Subject: [PATCH RFC v2 0/2] tsm: Unified Measurement Register ABI for TVMs
Date: Thu, 31 Oct 2024 11:50:39 -0500
Message-Id: <20241031-tsm-rtmr-v2-0-1a6762795911@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF+1I2cC/0XM3QrCIBQH8FcZ5zrDmcu2qyDoAbqNXYx51g6kh
 ooUw3dPJOjy/8Fvg4CeMMDQbOAxUSBnSxC7BuZ1sg9kpEsGwYXkPZcsBsN8NJ6pSXanrtdi6o9
 Q7i+PC70rdYfb9QJjKVcK0flP5VNbp5+k/lJqGWetWGap5UFLVGeyEZ/72RkYc85fHUEqR6UAA
 AA=
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
`struct tsm_measurement`, which holds an array of
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
the `TSM_MR_F_X` flag. Patch 2 adds a sample module to demonstrate how to
define and implement MRs.

MRs are made accessible to applications through a directory tree (rooted at
/sys/kernel/tsm). An MR could be presented as either a file containing its
value, or a directory containing elements like `digest` and `hash_algo`. By
default, an MR will be presented as a directory unless `TSM_MR_F_F` is set in
`mr_flags`.

[1]: https://patchwork.kernel.org/project/linux-integrity/cover/20240128212532.2754325-1-sameo@rivosinc.com/

Signed-off-by: Cedric Xing <cedric.xing@intel.com>
---
Changes in v2:
- Separated TSM MR code in a new file: `tsm-mr.c`.
- Removed RTMR event logging due to the lack of agreement on the log format.
- Default presentation of each MR as a directory, with the option to request an
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

 drivers/virt/coco/Kconfig               |   3 +-
 drivers/virt/coco/Makefile              |   2 +
 drivers/virt/coco/{tsm.c => tsm-core.c} |  26 ++-
 drivers/virt/coco/tsm-mr.c              | 374 ++++++++++++++++++++++++++++++++
 include/linux/tsm.h                     |  63 ++++++
 samples/Kconfig                         |   4 +
 samples/Makefile                        |   1 +
 samples/tsm/Makefile                    |   2 +
 samples/tsm/measurement-example.c       | 117 ++++++++++
 9 files changed, 581 insertions(+), 11 deletions(-)
---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20240904-tsm-rtmr-7a45859d2a96

Best regards,
-- 
Cedric Xing <cedric.xing@intel.com>



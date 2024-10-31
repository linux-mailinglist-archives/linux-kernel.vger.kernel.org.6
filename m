Return-Path: <linux-kernel+bounces-389894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1599B729B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F53B237B2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFFE13698B;
	Thu, 31 Oct 2024 02:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XApF2sli"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A4012C465
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342669; cv=none; b=r3KBpN1DH6DSQjry5XVI9hAEyVWga2qIhtHgLvVKfJoWdnCCjObQK2+XIkHhKfRH7RGqh/vJEoKnmqsNEGZs6pCTRGF6wU+PDBqQ4zsVs+EogkgVhUtCYDLFSeXa0SkeozYfPVxynsFSW37N4YjbGBYvv3iQBoZkdwv/iFY/mhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342669; c=relaxed/simple;
	bh=8AtT8YEFyRyHbeCzOHAzfEyWKhHdPX8SGO4p9v6hc5w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kso7cipGyVSe+ZyUb7G+OUZeZxGa8iqovBQIhL9d3TxqlzrFKL+NldohnKJ9Kky68H54EpgAii6Yl1Ud4xs6DqrbjLAS95/NbXxfvckeg2Ka7eI+Nmcq1Go5MflIiOvLbpGGf6lieRlTb2CsHx/iSy7D7FAVpBsAlfxbuoywwB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XApF2sli; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730342662;
	bh=8AtT8YEFyRyHbeCzOHAzfEyWKhHdPX8SGO4p9v6hc5w=;
	h=From:Subject:Date:To:Cc:From;
	b=XApF2sli1RJhht12/2Cov6k96jP7OjyvBdg/8Cyd9yU+uvuAlJC11CB6r5aCg8pte
	 mTceOzyRdvxvxm7PHNRfbkPM3zjuaLWC4QUruaP8pqpQUHlLYA1NckdBngJLMRXHFu
	 kBWDvlsLh/bsVTa4zMZGHR/OTu0lmx+mFffoAlfQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH RFC 00/10] sysfs: constify struct bin_attribute (Part 1)
Date: Thu, 31 Oct 2024 02:43:49 +0000
Message-Id: <20241031-sysfs-const-bin_attr-v1-0-2281afa7f055@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOXuImcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAyML3eLK4rRi3eT8vOIS3aTMvPjEkpIi3UQDAwtLMxMLwxSDJCWg1oK
 i1LTMCrCx0UpBbs5KsRDBotTCUqAVJRCZ2NpaAMyfSdWAAAAA
X-Change-ID: 20241028-sysfs-const-bin_attr-a00896481d0b
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730342657; l=3307;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8AtT8YEFyRyHbeCzOHAzfEyWKhHdPX8SGO4p9v6hc5w=;
 b=+0orQpJ2VcD7pMRj9s5+VuhwlBoS1z1cM/RJ76YDJIrc95VkSwKwHUDdslBwqTO6Vy1fsBWoG
 WX0RwBXi9NoDCA7+zz1MQt91jDdOPksn6rYtNdEjxJS2GjKDMlViKtc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

struct bin_attribute contains a bunch of pointer members, which when
overwritten by accident or malice can lead to system instability and
security problems.
Moving the definitions of struct bin_attribute to read-only memory
makes these modifications impossible.
The same change has been performed for many other structures in the
past. (struct class, struct ctl_table...)

For the structure definitions throughout the core to be moved to
read-only memory the following steps are necessary.

1) Change all callbacks invoked from the sysfs core to only pass const
   pointers
2) Adapt the sysfs core to only work in terms of const pointers
3) Adapt the sysfs core APIs to allow const pointers
4) Change all structure definitions through the core to const

This series provides the foundation for step 1) above.
It converts some callbacks in a single step to const and provides a
foundation for those callbacks where a single step is not possible.

This series is marked as RFC and only sent to the sysfs maintainers to
get some feedback on the general aproach.
The same techniques employed by this series can later be reused for the
same change for 'struct attribute'.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (10):
      sysfs: explicitly pass size to sysfs_add_bin_file_mode_ns()
      sysfs: introduce callback attribute_group::bin_size
      PCI/sysfs: Calculate bin_attribute size through bin_size()
      nvmem: core: calculate bin_attribute size through bin_size()
      sysfs: treewide: constify attribute callback of bin_is_visible()
      sysfs: treewide: constify attribute callback of bin_attribute::mmap()
      sysfs: drop callback bin_attribute::llseek
      sysfs: implement all BIN_ATTR_* macros in terms of __BIN_ATTR()
      sysfs: bin_attribute: add const read/write callback variants
      driver core: Constify attribute arguments of binary attributes

 drivers/base/node.c                     |   4 +-
 drivers/base/topology.c                 |   4 +-
 drivers/cxl/port.c                      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |   2 +-
 drivers/infiniband/hw/qib/qib_sysfs.c   |   2 +-
 drivers/misc/ocxl/sysfs.c               |   2 +-
 drivers/mtd/spi-nor/sysfs.c             |   2 +-
 drivers/nvmem/core.c                    |  16 ++++-
 drivers/pci/p2pdma.c                    |   2 +-
 drivers/pci/pci-sysfs.c                 |  36 +++++++-----
 drivers/pci/vpd.c                       |   2 +-
 drivers/platform/x86/amd/hsmp.c         |   2 +-
 drivers/platform/x86/intel/pmt/class.c  |   2 +-
 drivers/platform/x86/intel/sdsi.c       |   2 +-
 drivers/scsi/scsi_sysfs.c               |   2 +-
 drivers/uio/uio_hv_generic.c            |   2 +-
 drivers/usb/core/sysfs.c                |   2 +-
 fs/sysfs/file.c                         |  32 +++++-----
 fs/sysfs/group.c                        |   5 +-
 fs/sysfs/sysfs.h                        |   2 +-
 include/linux/sysfs.h                   | 100 +++++++++++++++++++-------------
 21 files changed, 132 insertions(+), 93 deletions(-)
---
base-commit: e42b1a9a2557aa94fee47f078633677198386a52
change-id: 20241028-sysfs-const-bin_attr-a00896481d0b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>



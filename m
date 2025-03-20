Return-Path: <linux-kernel+bounces-569418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2187EA6A2B0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765EE189AF18
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ED6222574;
	Thu, 20 Mar 2025 09:31:42 +0000 (UTC)
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986262222CD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463102; cv=none; b=bgnmXLMiAkDOTpVBwZ6rvKDVVGs1hCmcOUZUYNaS72a5Ztkj7Gu39Gurgouq5NAEEzLhd3rsxyOjPNI7Q3H+PTKlpUPxnTy8LQySJ+cHIveYRxEVFZvIT5ErMZ0FRqorsHb4Ku+JaaPrvMFIKBpEvP4FNEouXn7ILbPSj3kx24c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463102; c=relaxed/simple;
	bh=10Xzpfxhb3jedp2+7OzV3d9Sa+CRTIgs+auGCBtAp3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eevxk73Nh5Qf2FM747Xr/D87Q4Q4aeVCU4DTbaHYqlPisypR1Mmuqr+tAkca/n7t7ikEBKQei0nXVxKCCaz5ys2l16MuiHDly8FGcQcaKUWllWr+it20yXXOHQL0s99VNmDwppR8wVUF+2/KCEKQ+zrbapcB2Vqo04kULt77pY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 8B3A25FC89;
	Thu, 20 Mar 2025 10:31:11 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jerry Snitselaar <jsnitsel@redhat.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 3/6] iommu: make inclusion of amd directory conditional
Date: Thu, 20 Mar 2025 10:14:45 +0100
Message-ID: <5895641.DvuYhMxLoT@devpool47.emlix.com>
Organization: emlix GmbH
In-Reply-To: <12652899.O9o76ZdvQC@devpool47.emlix.com>
References: <12652899.O9o76ZdvQC@devpool47.emlix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Nothing in there is active if CONFIG_AMD_IOMMU is not enabled, so the whole
directory can depend on that switch as well.

=46ixes: cbe94c6e1a7d ("iommu/amd: Move Kconfig and Makefile bits down into=
 amd directory")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
=2D--
 drivers/iommu/Makefile     | 3 ++-
 drivers/iommu/amd/Makefile | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index ed673c8fd056..41b00cdc8621 100644
=2D-- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
=2Dobj-y +=3D amd/ arm/ iommufd/ riscv/
+obj-y +=3D arm/ iommufd/ riscv/
+obj-$(CONFIG_AMD_IOMMU) +=3D amd/
 obj-$(CONFIG_INTEL_IOMMU) +=3D intel/
 obj-$(CONFIG_IOMMU_API) +=3D iommu.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-traces.o
diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 9de33b2d42f5..59c04a67f398 100644
=2D-- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
=2Dobj-$(CONFIG_AMD_IOMMU) +=3D iommu.o init.o quirks.o io_pgtable.o io_pgt=
able_v2.o ppr.o pasid.o
+obj-y +=3D iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasi=
d.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) +=3D debugfs.o
=2D-=20
2.49.0


=2D-=20
Rolf Eike Beer

emlix GmbH
Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of G=C3=B6ttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
http://www.emlix.com

emlix - your embedded Linux partner





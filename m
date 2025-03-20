Return-Path: <linux-kernel+bounces-569414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAF8A6A2A7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBB2D7A454F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FB6221DA0;
	Thu, 20 Mar 2025 09:31:17 +0000 (UTC)
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A951CDFCE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463076; cv=none; b=TE7hN/AWbKsUr60pewMHjs6tNkKnlNknZ+iBDuSP38OTkwdBII5n+yxfJb4bsedxHqYB5WoAbBYrUQSUCWIA/N/LTPFDP8fvFDz9dAm7R2xYhpxlIa/CjXQVm0VXnJzVX6drbCLvCofHfqRHOhm+cVECEL/1HhZKoHBVrsGUCYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463076; c=relaxed/simple;
	bh=Y66KsA3GQgAvbU1qFYkPKPeelZgF94pVlJgOrb4lujQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N596j1emJWxVInDM390oN+HGpif+KhS4i0DR/g/Sui8SdP1P7owTwdNTX8nwZgegp8A2/TPfXvbAk1IaLyoovCsoYkP8n+zcTISkIm6BceUutIDESUy6LowfUuYZnKNTJlmJWogSs0gFWYtUfUU0UXq9tljZ3FxCp7ywQqN63SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 6DCF05F8E7;
	Thu, 20 Mar 2025 10:31:10 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH 6/6] iommu: make inclusion of iommufd directory conditional
Date: Thu, 20 Mar 2025 10:22:37 +0100
Message-ID: <2243601.irdbgypaU6@devpool47.emlix.com>
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

Nothing in there is active if CONFIG_IOMMUFD is not enabled, so the whole
directory can depend on that switch as well.

=46ixes: 2ff4bed7fee7 ("iommufd: File descriptor, context, kconfig and make=
files")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
=2D--
 drivers/iommu/Makefile         | 3 ++-
 drivers/iommu/iommufd/Makefile | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 17133876f777..38ee96607acf 100644
=2D-- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
=2Dobj-y +=3D arm/ iommufd/
+obj-y +=3D arm/
 obj-$(CONFIG_AMD_IOMMU) +=3D amd/
 obj-$(CONFIG_INTEL_IOMMU) +=3D intel/
 obj-$(CONFIG_RISCV_IOMMU) +=3D riscv/
+obj-$(CONFIG_IOMMUFD) +=3D iommufd/
 obj-$(CONFIG_IOMMU_API) +=3D iommu.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-traces.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-sysfs.o
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index cb784da6cddc..071f2a504167 100644
=2D-- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -12,7 +12,7 @@ iommufd-y :=3D \
=20
 iommufd-$(CONFIG_IOMMUFD_TEST) +=3D selftest.o
=20
=2Dobj-$(CONFIG_IOMMUFD) +=3D iommufd.o
+obj-y +=3D iommufd.o
 obj-$(CONFIG_IOMMUFD_DRIVER) +=3D iova_bitmap.o
=20
 iommufd_driver-y :=3D driver.o
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




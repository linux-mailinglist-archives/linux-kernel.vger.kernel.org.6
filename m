Return-Path: <linux-kernel+bounces-569419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 113D3A6A2B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B784D1887592
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1FF222596;
	Thu, 20 Mar 2025 09:31:50 +0000 (UTC)
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E321638D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463110; cv=none; b=jyLJLrznZ548iw3m1d2rc6u/UGp5P+0bH0JxEA0p6kHcA6CO9+3BtkjWETgAsi3CdeeT7yUQ+ZY+XnXuA9PhQOd8b3ugffwGzcw20JdTixAf0iyYv7IqKypgcekUXjl4WBW0Mgly6gIl3xjIdx866jYL2kp/u33RACKG6E+2u1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463110; c=relaxed/simple;
	bh=d9OiXxFIdwYuFKxylfqHhftafUoXpw+nM0NbjZ9d0ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sydBC2JX7x/DfY7L/nBhYzhA/r7HTVLqMPdXQhgNsgxQc4zRQpjJjg46WLaBma/1STG/91mOww+IB6UV/vZwtyE54PJKWC/sLRy3hR+1ax6KEW8UQRFT4NsT6fd0Yyn7A7Pb0XxdeB3oyg1KTJp9FbbOGZ+weI7f5OXkPexfI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id D8AEC5FCE8;
	Thu, 20 Mar 2025 10:31:11 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH 2/6] iommu: make inclusion of intel directory conditional
Date: Thu, 20 Mar 2025 10:07:58 +0100
Message-ID: <12654723.O9o76ZdvQC@devpool47.emlix.com>
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

Nothing in there is active if CONFIG_INTEL_IOMMU is not enabled, so the who=
le
directory can depend on that switch as well.

=46ixes: ab65ba57e3ac ("iommu/vt-d: Move Kconfig and Makefile bits down int=
o intel directory")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
=2D--
 drivers/iommu/Makefile       | 3 ++-
 drivers/iommu/intel/Makefile | 7 ++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 5e5a83c6c2aa..ed673c8fd056 100644
=2D-- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
=2Dobj-y +=3D amd/ intel/ arm/ iommufd/ riscv/
+obj-y +=3D amd/ arm/ iommufd/ riscv/
+obj-$(CONFIG_INTEL_IOMMU) +=3D intel/
 obj-$(CONFIG_IOMMU_API) +=3D iommu.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-traces.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-sysfs.o
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index 6c7528130cf9..ada651c4a01b 100644
=2D-- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -1,11 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
=2Dobj-$(CONFIG_DMAR_TABLE) +=3D dmar.o
=2Dobj-$(CONFIG_INTEL_IOMMU) +=3D iommu.o pasid.o nested.o cache.o prq.o
=2Dobj-$(CONFIG_DMAR_TABLE) +=3D trace.o
+obj-y +=3D iommu.o pasid.o nested.o cache.o prq.o
+obj-$(CONFIG_DMAR_TABLE) +=3D dmar.o trace.o
 obj-$(CONFIG_DMAR_PERF) +=3D perf.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) +=3D debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) +=3D svm.o
=2Difdef CONFIG_INTEL_IOMMU
 obj-$(CONFIG_IRQ_REMAP) +=3D irq_remapping.o
=2Dendif
 obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) +=3D perfmon.o
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





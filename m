Return-Path: <linux-kernel+bounces-569415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5EEA6A2A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A851460494
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F60821A45D;
	Thu, 20 Mar 2025 09:31:25 +0000 (UTC)
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE07C1A5BBA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463085; cv=none; b=FmXkO13ZJtSkrUbYFwajPDbcw5B0IytOKb0TiOdYQiRMi/In0GrLLIMiwgp8XRWdG0QdhnRtfRHnX3HXqrfeHiEvf21seedH5fsMrXJ52nvulmdnJ8vI2hDtTMBwQkDrogwEylsVsjQ6Ap6hx2XuRvSKsFn53GLL82QHFW/4r7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463085; c=relaxed/simple;
	bh=Fq7N5XhzkBZZ2U7tumyB/nILV22NxS/iDWf9NYICOTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNDjTjdrodeUrnYhHrlUoAQkLmKfxK7vKKMYdZKqplXCKFTXnIFeN2ikaMQzxQxwCpUzxEocDMHgMu4zfl1NmqeBrM0rp2jax2kjjXMcdN4O/1v5Og5fv5mP1KJJ/U83xdAO+jHP8eh057GWXlP7Ma0TUJmNCA4/nTlBciEcSdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id BC3445F9AD;
	Thu, 20 Mar 2025 10:31:10 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Subject:
 [PATCH 5/6] iommu: make inclusion of arm/arm-smmu-v3 directory conditional
Date: Thu, 20 Mar 2025 10:19:12 +0100
Message-ID: <6164975.lOV4Wx5bFT@devpool47.emlix.com>
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

Nothing in there is active if CONFIG_ARM_SMMU_V3 is not enabled, so the who=
le
directory can depend on that switch as well.

=46ixes: e86d1aa8b60f ("iommu/arm-smmu: Move Arm SMMU drivers into their ow=
n subdirectory")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
=2D--
 drivers/iommu/arm/Makefile             | 3 ++-
 drivers/iommu/arm/arm-smmu-v3/Makefile | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/Makefile b/drivers/iommu/arm/Makefile
index 0f9efeab709f..35a7e13eef34 100644
=2D-- a/drivers/iommu/arm/Makefile
+++ b/drivers/iommu/arm/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
=2Dobj-y +=3D arm-smmu/ arm-smmu-v3/
+obj-y +=3D arm-smmu/
+obj-$(CONFIG_ARM_SMMU_V3) +=3D arm-smmu-v3/
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm=
=2Dsmmu-v3/Makefile
index 493a659cc66b..6cc7c8557b9e 100644
=2D-- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
=2Dobj-$(CONFIG_ARM_SMMU_V3) +=3D arm_smmu_v3.o
+obj-y +=3D arm_smmu_v3.o
 arm_smmu_v3-y :=3D arm-smmu-v3.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_IOMMUFD) +=3D arm-smmu-v3-iommufd.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) +=3D arm-smmu-v3-sva.o
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




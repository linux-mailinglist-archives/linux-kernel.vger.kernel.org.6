Return-Path: <linux-kernel+bounces-555876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E32A5BDB8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C713A039B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D7023535D;
	Tue, 11 Mar 2025 10:22:01 +0000 (UTC)
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1889D233737
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.209.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688520; cv=none; b=QkDl29x/GBnJ/y12llGtR7QpHIPaLmDah31oPiV+u25YQ+qxmIdqbJSeRw+fBD7Ih0w38upkaCpGgyrRJsjqo3RbAXep4TmRB0PX2E0w/nOsN3v5AdAuNwwZ1IcI+l/EJUENfdOW2a1WvX2q5CKF0sLxsbAWVDqR8IRIgbku4qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688520; c=relaxed/simple;
	bh=ZSbAFnMZ0+Ui2fIy0XEgIhYav8KJwGrdYWtBLNCLH98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jt7hImCn6cj1H68GrqcXs2e9Xc67REBES4vP4dcN8mYAHj7W4s8n8yE5MEC1RQHGosSzq0SZxoeAZqJMZxpeIl+MpGH31Za5ms+1RhBwzJTZWRh/GyM0+XDjx93XOMJU3B+A8f7QeRknr4+Sk5GAy7TXWfChVuBsGgFwujWdu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com; spf=pass smtp.mailfrom=emlix.com; arc=none smtp.client-ip=178.63.209.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emlix.com
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 6DD395F909;
	Tue, 11 Mar 2025 11:15:25 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Tomasz Jeznach <tjeznach@rivosinc.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Sebastien Boeuf <seb@rivosinc.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 4/4] iommu: make inclusion of riscv directory conditional
Date: Tue, 11 Mar 2025 11:15:12 +0100
Message-ID: <3536592.QJadu78ljV@devpool47.emlix.com>
Organization: emlix GmbH
In-Reply-To: <2301497.iZASKD2KPV@devpool47.emlix.com>
References: <2301497.iZASKD2KPV@devpool47.emlix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Nothing in there is active if CONFIG_RISCV_IOMMU is not enabled, so the who=
le
directory can depend on that switch as well.

=46ixes: 5c0ebbd3c6c6 ("iommu/riscv: Add RISC-V IOMMU platform device drive=
r")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
=2D--
 drivers/iommu/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 41b00cdc8621..17133876f777 100644
=2D-- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
=2Dobj-y +=3D arm/ iommufd/ riscv/
+obj-y +=3D arm/ iommufd/
 obj-$(CONFIG_AMD_IOMMU) +=3D amd/
 obj-$(CONFIG_INTEL_IOMMU) +=3D intel/
+obj-$(CONFIG_RISCV_IOMMU) +=3D riscv/
 obj-$(CONFIG_IOMMU_API) +=3D iommu.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-traces.o
 obj-$(CONFIG_IOMMU_API) +=3D iommu-sysfs.o
=2D-=20
2.48.1


=2D-=20
Rolf Eike Beer

We are nominated for the embedded award Visit us at the embedded=20
world 2025 March 11th to 13th, 2025 | Nuremberg Find us in hall 4 at=20
booth 336

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




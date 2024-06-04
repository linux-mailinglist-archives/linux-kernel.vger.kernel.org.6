Return-Path: <linux-kernel+bounces-200533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0E48FB15C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AA8282CD8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE180145A11;
	Tue,  4 Jun 2024 11:46:10 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 3D88C145350;
	Tue,  4 Jun 2024 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501570; cv=none; b=V+EZGDqDmr6yNtJsBUkSe9RwMdlZUcKRVHzFzEi8iET2bpqe4C1cz1n+75XUsVT6+qNRmk08AY43x/m4vh0GqzX84OTDO/rHrNaT7DmWBhjaQjNg72nRj0F/qzwOSYtijxYj8O3+ezh/gD9ZRItYKYLIIKPKLfWahiJQqQkoOYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501570; c=relaxed/simple;
	bh=p6de8ISvGtQYeLkdgHcT+UhUuBgzjaRIyC6F/0qCGvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LYZ5C8UTpTSUYd6pUiewcSEjfK9Ud3RkcQKWDX4+73P9G47RxuW2qSye1cjZHz9Q3x7+xa2YKI0MdYe7vYDBmLoA1cUeRyiZl+kTAolJuDSMlHtNn+JU76KIhCJ6ySNIh1YhCHK3+dlrf6QDZ6ayHJssW2vntIAewakKfU2FpF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id A0ABB606E3AC4;
	Tue,  4 Jun 2024 19:45:54 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: Su Hui <suhui@nfschina.com>,
	tglx@linutronix.de,
	jiang.liu@linux.intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] iommu/amd: avoid possible wrong value of 'hwirq' in irq_remapping_alloc()
Date: Tue,  4 Jun 2024 19:45:23 +0800
Message-Id: <20240604114522.2630682-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'devid' is type of int, but 'irq_data->hwirq' is unsigned long.
When 'devid' >= 0xf000, hwirq will have a error value in 64 bit machine.
For example:
(unsigned long)((int)0xf000 << 16) = 0xfffffffff0000000
(unsigned long)((unsigned int)0xf000 << 16) = 0xf0000000

Add a cast to fix this problem.

Fixes: 7c71d306c97b ("irq_remapping/amd: Enhance AMD IR driver to support hierarchical irqdomains")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 52d83730a22a..934738dfc8ea 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3506,7 +3506,7 @@ static int irq_remapping_alloc(struct irq_domain *domain, unsigned int virq,
 		}
 
 		data->iommu = iommu;
-		irq_data->hwirq = (devid << 16) + i;
+		irq_data->hwirq = ((irq_hw_number_t)devid << 16) + i;
 		irq_data->chip_data = data;
 		irq_data->chip = &amd_ir_chip;
 		irq_remapping_prepare_irte(data, cfg, info, devid, index, i);
-- 
2.30.2



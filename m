Return-Path: <linux-kernel+bounces-313160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091FF96A124
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C64F1C24070
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC000154BE9;
	Tue,  3 Sep 2024 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YGMFrdY2"
Received: from m15.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7FB6F30D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375055; cv=none; b=J7HniJ9Uxfr6RklQZMNRw4urdDdQBibfy9Dw7rFSDaWdj3KzbI6+XYfNicXsFSw49t4ZhvKZ9Et7zDrebsjgk4c5z73tkKjH/3O7MWhvRjGHQD2Qr2Tydjwzga8xcDUKyBuBJbK/YQj5wlehaBv3NHH7lBzMUsgl8XwhKa/LsTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375055; c=relaxed/simple;
	bh=k5utM3wgHf32qhGpen5q4SK8rJu+bGuDYsx7xhGgVa0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nckptkWkNynTvx/cSRuPNz4fiegmarknmdETYL5IeMITN0QM6p9VbfGoSE3iOlqqvYHzCittncKSFEbzPZ/OGxnkBbDH7B4Pt7KX6hL8f7GJk4fz4rUhTAt4Zi0xldjy2LsSZM43ZWRakqeKrORIcSur9uEebVFZ93D2IKvwRpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YGMFrdY2; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PgJJ8
	SX8BUGlB9T2TFFYMz+dTL9blm1JY4VAnKEEgSk=; b=YGMFrdY2hD/RwPtYoX1sb
	CiJ85ureLALodvKkINXul3lnJIO5FT+wJEWZsGijMP8pbRk/v8hbIkb4laQ7Ptdl
	2ZL6E3tw/6arTnorTJfhRvR64YDa7RaV61Z7WTW4hqfku2IdgtIRG6dfpVBfwSZQ
	IENmUnrj1i1OrZc63OqEzM=
Received: from localhost.localdomain (unknown [36.33.36.240])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDX_18bItdm5cJoFQ--.14451S2;
	Tue, 03 Sep 2024 22:50:04 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH] iommu/vt-d: Fix 'Null pointer dereferences' issue
Date: Tue,  3 Sep 2024 22:46:01 +0800
Message-Id: <20240903144601.8149-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_18bItdm5cJoFQ--.14451S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1kGF17Gryruw45CFWrAFb_yoWfWrXEkr
	y8ZFs7ury5Zr48Z3WayFnruryqqw12vFZ3Z3y0grySqFn8Zrn5Cana9FWfJr45G3yUJFya
	yF4UWF4fuFyxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU2Nt5UUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYBZPamV4I-QKmQABsL

Passing null pointer "pdev" to "pci_enable_pasid", which dereferences it.
Check the "pdev" is null or not before passing to "pci_enable_pasid".

Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9f6b0780f2ef..a1e54f334330 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3935,7 +3935,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	 * So always enable PASID support on devices which have it, even if
 	 * we can't yet know if we're ever going to use it.
 	 */
-	if (info->pasid_supported &&
+	if (info->pasid_supported && pdev &&
 	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
-- 
2.39.2



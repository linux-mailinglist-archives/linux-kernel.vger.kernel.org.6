Return-Path: <linux-kernel+bounces-309663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B429966EF3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 04:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5121F284D95
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C5439FF2;
	Sat, 31 Aug 2024 02:37:25 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D10281E
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 02:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725071845; cv=none; b=trD+n+iMunOg/uooTiP8HQ1g9l8G8VY+Q+oOPgOJcSWjfa0fLzDs2dK12Gj9AeKVouuR7gWQ/VXsb2aDRMI16SkS8qKCOnpQq4//fAKeBad1YbQJ5yYuN9dgsrOUlytXSZ2reiv65e973GcMGiKH5kdU1D0XwbFv31OVQJX+GP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725071845; c=relaxed/simple;
	bh=w7yZtEgUtu3y7fY2Cs/pvsQ+8znMn15LBvLBQTzb24s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UJCNmnr5jX1PoBVEQ5XtT2OGfxL4bIoMSUAIROL5RoW7D7fvTtPrej2izJzregGW4nBWD0UWIwqHZxRHbGWTQfSCTnmQzOSkfu4/qFvktIvGK8UPyJuEz4G0yNNBRq55QIstj8pcswzaWvJUnZkeizXFJtG8PCceYVHA5Yowqw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WwfJ24Q3DzgYbS;
	Sat, 31 Aug 2024 10:35:14 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id C117E1400CF;
	Sat, 31 Aug 2024 10:37:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 31 Aug
 2024 10:37:19 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <boris.brezillon@collabora.com>, <steven.price@arm.com>,
	<liviu.dudau@arm.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] drm/panthor: Use the BITS_PER_LONG macro
Date: Sat, 31 Aug 2024 10:45:31 +0800
Message-ID: <20240831024532.455361-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

sizeof(unsigned long) * 8 is the number of bits in an unsigned long
variable, replace it with BITS_PER_LONG macro to make them simpler.

And fix the warning:
	WARNING: Comparisons should place the constant on the right side of the test
	#23: FILE: drivers/gpu/drm/panthor/panthor_mmu.c:2696:
	+       if (BITS_PER_LONG < va_bits) {

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index d47972806d50..2a0c46391374 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2693,7 +2693,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	 * which passes iova as an unsigned long. Patch the mmu_features to reflect this
 	 * limitation.
 	 */
-	if (sizeof(unsigned long) * 8 < va_bits) {
+	if (va_bits > BITS_PER_LONG) {
 		ptdev->gpu_info.mmu_features &= ~GENMASK(7, 0);
 		ptdev->gpu_info.mmu_features |= sizeof(unsigned long) * 8;
 	}
-- 
2.34.1



Return-Path: <linux-kernel+bounces-224310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217D191208C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4496F1C20BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CDA16EBE4;
	Fri, 21 Jun 2024 09:28:30 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1CC16EB51
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962109; cv=none; b=cqTG9JXlQf6Yk2cNNSjI5RJiUp3RA6A2RONpE+iMB/Us1l8kiSRo+aXsL7mUYJ6Aja2iKC/xF1Zsqgj5ci4TiBALe75PT3dan4mDTCFgB6N1uhKkapJnCzFmKQ5KRvYZfsA3kjM8HE1XI4tHLbD9/jXPL8N7V5ZlHnaieCWADPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962109; c=relaxed/simple;
	bh=6Jn1cQgmYX3CLOw8EBxpLFWxnjXVAJbMI/3ZjSWUlhI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LOook5d2pXGIzN/jQu1CBn4ft2AzYOtpQY+QI5Nh8ZMPgw3kFnnyIa/NPnT6nN9YSdSNTV7oJitpTaFYGSx+f+88EhRoBYlXLo5vNG5q+9NoeAsn+LKL4JSFWoBaASwmP2EvgwvfTOmWlOenHHynXlD0W5Q/fn6r2AiwOqTjYj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W5BkZ3gw4zZcHP;
	Fri, 21 Jun 2024 17:24:06 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 213E114037B;
	Fri, 21 Jun 2024 17:28:24 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 17:28:23 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
	<wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] arm64: Clear the initial ID map correctly before remapping
Date: Fri, 21 Jun 2024 17:28:09 +0800
Message-ID: <20240621092809.162-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)

In the attempt to clear and recreate the initial ID map for LPA2, we
wrongly use 'start - end' as the map size and make the memset() almost a
nop.

Fix it by passing the correct map size.

Fixes: 9684ec186f8f ("arm64: Enable LPA2 at boot if supported by the system")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---

Found by code inspection (don't have the appropriate HW to test it).

 arch/arm64/kernel/pi/map_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
index 5fa08e13e17e..f374a3e5a5fe 100644
--- a/arch/arm64/kernel/pi/map_kernel.c
+++ b/arch/arm64/kernel/pi/map_kernel.c
@@ -173,7 +173,7 @@ static void __init remap_idmap_for_lpa2(void)
 	 * Don't bother with the FDT, we no longer need it after this.
 	 */
 	memset(init_idmap_pg_dir, 0,
-	       (u64)init_idmap_pg_dir - (u64)init_idmap_pg_end);
+	       (u64)init_idmap_pg_end - (u64)init_idmap_pg_dir);
 
 	create_init_idmap(init_idmap_pg_dir, mask);
 	dsb(ishst);
-- 
2.33.0



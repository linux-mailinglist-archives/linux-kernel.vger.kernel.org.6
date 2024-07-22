Return-Path: <linux-kernel+bounces-258441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C46D9387E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582872810F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347DD18037;
	Mon, 22 Jul 2024 04:05:57 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24788171CD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721621156; cv=none; b=NBlDZY7PPhmsb6qZD1Q+yx4CD0ufJ/Aogy8SYprXWzfQqTXyf7UFcUyCXMO+xNE6qZHPI+MtKd03kLKQVXKikUj0ljclG418owePPuXWzOc7vmiPR/upZWtw3QLWwKE7od5rYna5m3hC20+Ql6X0l75MgIiJ/jbUPNJdkVn/KWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721621156; c=relaxed/simple;
	bh=c2a+MUNNmJv4IziUEEbzft8eTTiPu1rIEDhOjFqvxsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEOJnbLaS8WvvvjKZQYiyk1D5aYpHqL/hkUhWu92/h3k7cdWo5rKdEYKAbOmBNGqhBgQGpXabNVbg5rM03m3D7fkIebRD+Np5KCWQIhpLrmSAglAyyiPMHAy/iixfYhStiIMAMb/ciH5IDit8yxbj4sf1U0WJnHuW9NQn/PzloE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WS65K4skWzxThf;
	Mon, 22 Jul 2024 12:00:53 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id 23FF2180064;
	Mon, 22 Jul 2024 12:05:49 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Jul
 2024 12:05:48 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>, <rohit.mathew@arm.com>, <amitsinght@marvell.com>,
	<sdonthineni@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<zengheng4@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH mpam/v6.10-rc1 RFC 2/4] arm_mpam: Fix the range calculation of the implemented bits
Date: Mon, 22 Jul 2024 12:01:38 +0800
Message-ID: <20240722040140.515173-3-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240722040140.515173-1-zengheng4@huawei.com>
References: <20240722040140.515173-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100008.china.huawei.com (7.202.181.222)

The implemented bits of the MAX field in the MPAMCFG_{MBW_MAX, CMAX}
register are always to the left of the field, so the validated range
should be like [15, 15 - width + 1].

Fixes: 867471fefd5c ("SPLIT untested: arm_mpam: resctrl: Add support for MB resource")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/platform/arm64/mpam/mpam_resctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/arm64/mpam/mpam_resctrl.c b/drivers/platform/arm64/mpam/mpam_resctrl.c
index a217f2e1f350..e87fca6fc5fd 100644
--- a/drivers/platform/arm64/mpam/mpam_resctrl.c
+++ b/drivers/platform/arm64/mpam/mpam_resctrl.c
@@ -585,7 +585,7 @@ static u16 percent_to_mbw_max(u8 pc, struct mpam_props *cprops)
 			break;
 	}
 
-	value &= GENMASK(15, 15 - cprops->bwa_wd);
+	value &= GENMASK(15, 15 - cprops->bwa_wd + 1);
 
 	return value;
 }
-- 
2.25.1



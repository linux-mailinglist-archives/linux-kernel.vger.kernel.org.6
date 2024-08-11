Return-Path: <linux-kernel+bounces-282104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF3694DFB1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9E5283CF7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4766E5ED;
	Sun, 11 Aug 2024 02:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ZOPH050d"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735351A29A
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343178; cv=none; b=tyWk4tvmrGG6InAuSaDzUX/nceGQ4KPfGqe12qNxW1mPcy4w2mD6okJiW/2OC/6ckEuZpg666uhlfpJicvCe4USWxesPNjLBErnHCWhTEHZpcfHgr837aVwafPu+cVjOzygrlgfcnJhx7pqZFGp1PPceOwwchUHWUfowMaXQ2g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343178; c=relaxed/simple;
	bh=Zzcfp7M1d4fkhNfbb/N4LEuloezsuVI/b5t7LxBG3Z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cIDNkhwXDmarNgSw+B6W1AINeazDI7fLdRkDabOtQwY6ttsjDNLpLSqk0cVDYQmeIXe0vKOh2Jsu+gOo6bL5vKmWvsEk4KWArznj0RyrMebLPsKH4PYC9n1AS3hksLmUOV1kWY/jvgD2PIj+f4UGNcOmgshmGVOqSJSmcyRBkLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ZOPH050d; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343176;
	bh=qoGuIrTl5HYwoi/MjxccvnuOhmX+vv/gXgACeHCFixM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=ZOPH050dJE5hOg00HmhREm9Qcys7nADtG1Xm9iFMUbCUuJKZD9ZtPlTl7X53kEZ79
	 eF8EuDQAWqe2SW1J58YE/BvAqiN4mOMEufuNVDiysORrrLvGig5e4Vjm+4boGXG4YC
	 PvSOXb+Zf6Lglj0CBb/3GwOQhbi1QxnmGT27/JP8gByTV80CPr1tuv3zZCkAdXsfcS
	 MPP3M9cnk2+QdJbeYbfpKunh6aJORSbNCvoH17ccy9bTBKGmQjMjD9VkgNOCZ3Kii/
	 +teYj3/m7cJHUfj9L4k8Q8F2NFfsQmVI1FIOykmhTz3n3chNFke5d+28+HiGRqEwj2
	 I30VwcoAYGwmQ==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 8B7891349B39;
	Sun, 11 Aug 2024 02:26:13 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:07 +0800
Subject: [PATCH 16/27] sparc: vio: Make device_find_child()'s match
 function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-16-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: 8TjWQC9CCJAKAVO7aWuAAOLCLeCVVGjl
X-Proofpoint-ORIG-GUID: 8TjWQC9CCJAKAVO7aWuAAOLCLeCVVGjl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=857
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make
vio_md_node_match() as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 arch/sparc/kernel/vio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 07933d75ac81..1a1a9d6b8f2e 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -419,13 +419,13 @@ struct vio_remove_node_data {
 	u64 node;
 };
 
-static int vio_md_node_match(struct device *dev, void *arg)
+static int vio_md_node_match(struct device *dev, const void *arg)
 {
 	struct vio_dev *vdev = to_vio_dev(dev);
-	struct vio_remove_node_data *node_data;
+	const struct vio_remove_node_data *node_data;
 	u64 node;
 
-	node_data = (struct vio_remove_node_data *)arg;
+	node_data = (const struct vio_remove_node_data *)arg;
 
 	node = vio_vdev_node(node_data->hp, vdev);
 

-- 
2.34.1



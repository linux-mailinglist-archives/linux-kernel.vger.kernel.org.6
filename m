Return-Path: <linux-kernel+bounces-298572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C18D95C8F9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAD02837ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B126153BF8;
	Fri, 23 Aug 2024 09:13:25 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C133D14A088
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404404; cv=none; b=SJOBID0PIzuOK2caKGJ1TErcoudM8x32t1Ev6+0VSuCon5TN1jLYbTol0qu1RJu2lYqd95+/+tuGS97x6Uy6cgLe4SsMR106jYBHUBBznEhTWZmjGyrjQo4Y3Modv/NlOCO7x9H8OthqnbQBrr4HX20Pid50/RemPOfP1MIJtG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404404; c=relaxed/simple;
	bh=eiK6Y6DuuI6OV6AlErhWPjgXZQLljRJUceQPp5OCVjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ut9nbCicM1Et3kfCw1tnP51B6EAzrYd43PjLducovP/XN69LTY20PztTYD8Q3+lw2ABDbnjSHXXAwavnUyXrQFNkWDXSq6QsQIQPXg34WKEiFUWkc2bjBTE4hzEpozx6jvQgVYVtqt1h3UplhYdlzbCEkelZkzqRev67Fh5sTpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WqvSr5x12z1xvwT;
	Fri, 23 Aug 2024 17:11:24 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 36B161A016C;
	Fri, 23 Aug 2024 17:13:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 17:13:19 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <hjc@rock-chips.com>, <heiko@sntech.de>, <andy.yan@rock-chips.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 3/5] drm: of: Use for_each_child_of_node_scoped()
Date: Fri, 23 Aug 2024 17:20:51 +0800
Message-ID: <20240823092053.3170445-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823092053.3170445-1-ruanjinjie@huawei.com>
References: <20240823092053.3170445-1-ruanjinjie@huawei.com>
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

Avoids the need for manual cleanup of_node_put() in early exits
from the loop.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/drm_of.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 177b600895d3..41d9288c97a7 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -304,10 +304,9 @@ static int drm_of_lvds_get_port_pixels_type(struct device_node *port_node)
 static int drm_of_lvds_get_remote_pixels_type(
 			const struct device_node *port_node)
 {
-	struct device_node *endpoint = NULL;
 	int pixels_type = -EPIPE;
 
-	for_each_child_of_node(port_node, endpoint) {
+	for_each_child_of_node_scoped(port_node, endpoint) {
 		struct device_node *remote_port;
 		int current_pt;
 
@@ -315,10 +314,8 @@ static int drm_of_lvds_get_remote_pixels_type(
 			continue;
 
 		remote_port = of_graph_get_remote_port(endpoint);
-		if (!remote_port) {
-			of_node_put(endpoint);
+		if (!remote_port)
 			return -EPIPE;
-		}
 
 		current_pt = drm_of_lvds_get_port_pixels_type(remote_port);
 		of_node_put(remote_port);
@@ -332,10 +329,8 @@ static int drm_of_lvds_get_remote_pixels_type(
 		 * configurations by passing the endpoints explicitly to
 		 * drm_of_lvds_get_dual_link_pixel_order().
 		 */
-		if (!current_pt || pixels_type != current_pt) {
-			of_node_put(endpoint);
+		if (!current_pt || pixels_type != current_pt)
 			return -EINVAL;
-		}
 	}
 
 	return pixels_type;
-- 
2.34.1



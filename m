Return-Path: <linux-kernel+bounces-434181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 996C69E62A3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EED1627C7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1482E13D297;
	Fri,  6 Dec 2024 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="AC8Exnno"
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D147F53
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446454; cv=none; b=Ds88OT1qKVzfvlv54a9UplrRRRk0tpEKborySgM9UsTls025ntq9LjMH4UavGSwKbR+quMB+0w3iihqeNb1assdPuiOklqUxxfwkZcrN5n9AAHXHKv5qyV7RVgsv6XIoPCpSAGAE5UgDZgruAWAv3183JcJYyUWcLv9Ny2MposE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446454; c=relaxed/simple;
	bh=4gGpUxc+ueLe/9s3H5w03yxhgZr4jHYyf/gMsxtAANU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XfIwxUbbheqhlR7oO45PGLwL5Atf70Z+7hDZufXYcSOjtDfZp8Kj1gqrstuvlpVIVRC/c2XpGm627lr3XSmgRd1UopF/xNWIRoF3WQZCEvgALDZoJVLKP9KyP1lYXzFRClmONbFnNN6WEuOobeUE8eYzc0UCG+zdqs0SQV9+beI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=AC8Exnno; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733446452;
	bh=GcCykD0GR82c2pG2Xkejm3Z3BIkCqKMX+zNiZjv69I0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=AC8Exnnoz0LrM2fmLtefB52Ri8YOch6woOLhBi9pH8zAgZx9OTBiNPPVz7vS6fIaP
	 +yc9rr3bXLdI8yxrmhaXRU2ZUcRF7csGrc3O61Y+Ncd8bOQZVY2Bn9PgmzmuTW2avf
	 N4Twwi3WqzqxESz5ZIL5ahagWYNCQfCwK+9jhkgPwq2ro0TZenLqt8Q/MMn2TINbYf
	 PJDcdseLyL7Gw7JwVChUarLa/AzmiQOCxPm++laJk9RUws6nw/in2IPFBKL9Z5acxN
	 bhs95pjPbbLvfLJr2/KcqqEZIegDPSBnqYIei8t2mXYRGz9jKuIuBTvBTqqOjD7+dq
	 LxkPMou//d5ew==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 0E386A01E8;
	Fri,  6 Dec 2024 00:54:06 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 06 Dec 2024 08:52:36 +0800
Subject: [PATCH 10/10] of: Simplify API of_find_node_with_property()
 implementation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-of_core_fix-v1-10-dc28ed56bec3@quicinc.com>
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
In-Reply-To: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Leif Lindholm <leif.lindholm@linaro.org>, 
 Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: -03kjP29dKbBOXPMmppkSPOOwTG3W9wv
X-Proofpoint-ORIG-GUID: -03kjP29dKbBOXPMmppkSPOOwTG3W9wv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_16,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=965
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412060006
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify of_find_node_with_property() implementation
by __of_find_property().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/base.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 33abb6227468c03fd191201aa2bbe05a41fdd9f4..5fc061b66116d106c398f04a1d9d235f09741de7 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1026,19 +1026,15 @@ struct device_node *of_find_node_with_property(struct device_node *from,
 	const char *prop_name)
 {
 	struct device_node *np;
-	const struct property *pp;
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&devtree_lock, flags);
 	for_each_of_allnodes_from(from, np) {
-		for (pp = np->properties; pp; pp = pp->next) {
-			if (of_prop_cmp(pp->name, prop_name) == 0) {
-				of_node_get(np);
-				goto out;
-			}
+		if (__of_find_property(np, prop_name, NULL)) {
+			of_node_get(np);
+			break;
 		}
 	}
-out:
 	of_node_put(from);
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 	return np;

-- 
2.34.1



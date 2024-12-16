Return-Path: <linux-kernel+bounces-446650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B509F2790
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B44161FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A14BA49;
	Mon, 16 Dec 2024 00:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="wjnrfhS3"
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBD81DDEA
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734309677; cv=none; b=SpG0azHj2LZQfgB9FpmfcMDGLy3Cqs8LbGW++9DKl2Otm61xOCIHACREZkpcZo+NEhG/zFdlWSHG6LfWy4tyZlne6Xum9wMpGwWkVNpwVq5C3JteG5+2yE0HvQS/1YuXXYGGh/6tI509NfUtAp25Iucywp8uSuxClANdg/9j770=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734309677; c=relaxed/simple;
	bh=KMO14dnE9tRhaAGc5YxLFebssXtmFMt2M5jkVn0AjI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gzwak+C02kKCF4JH911Ecz6NfQAiOYRkJ/Yz/IG4w7vZwaQyBY7FthvpXw4JW82mkFNLvTWsGuIUH4H3tqRd8zcpbaA9ToG5qWGlo7SB8Fgl9NaK/2OBT1Xn2DsytkQMvg1++RLjxlfCImEBhQp8+5aWpv8YNQxMYotLipW3XRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=wjnrfhS3; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734309676;
	bh=Fj6BdgBM2U8SqvVK8X/8qKlugmpUIDlPqiwGDV3HR8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=wjnrfhS3Off0m322naodLBWNWpYBcMOYPCa3+HnTlB4LNtTgGJQN0AcJ2bKEgbfFW
	 wIQdyzi12s2Kv68CIiObIDu0sa7N+reF3XKTTz0koJuMGmL1wlGfezUcLwaTItatk5
	 09jCi/lQzGjAjsIK0K4BpsNCD0co0t/oYXGZHsK1Qh2aZWOAOWSamZhF/NSwEDLgAP
	 reKUp9h9Be8eo4aRHLmpXvAPcHFFYgZ8kxsSqVSxVC4jYHXtqMd9n1DL6x5P/IlwaW
	 N592aA8/Qb7WXpZPxer1p9EOB+TrLYAS6O4keaT9k9yobeyB7J/C4uWLTLXmBp7zDl
	 AhBvKtrYfOV2g==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id 42EFBD00211;
	Mon, 16 Dec 2024 00:41:11 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 16 Dec 2024 08:40:41 +0800
Subject: [PATCH v2 2/7] of: unittest: Add a test case for API
 of_find_node_opts_by_path()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-of_core_fix-v2-2-e69b8f60da63@quicinc.com>
References: <20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com>
In-Reply-To: <20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: dv7li9viv4lCM-e_YTdRfq5DVT4lJJKF
X-Proofpoint-ORIG-GUID: dv7li9viv4lCM-e_YTdRfq5DVT4lJJKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-15_10,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=992 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412160002
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

To test of_find_node_opts_by_path() take @path argument with pattern:

"alias-name/node-name-1/.../node-name-N:options", for example:
"testcase-alias/phandle-tests/consumer-a:testaliasoption"

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/unittest.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index daf9a2dddd7e0dbc680f708496b6dce6d23999cf..ed343509505f536436f8457bd200ccc323acffdf 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -161,6 +161,15 @@ static void __init of_unittest_find_node_by_name(void)
 		 "option alias path test, subcase #1 failed\n");
 	of_node_put(np);
 
+	np = of_find_node_opts_by_path("testcase-alias/phandle-tests/consumer-a:testaliasoption",
+				       &options);
+	name = kasprintf(GFP_KERNEL, "%pOF", np);
+	unittest(np && name && !strcmp("/testcase-data/phandle-tests/consumer-a", name) &&
+		 !strcmp("testaliasoption", options),
+		 "option alias path test, subcase #2 failed\n");
+	of_node_put(np);
+	kfree(name);
+
 	np = of_find_node_opts_by_path("testcase-alias:testaliasoption", NULL);
 	unittest(np, "NULL option alias path test failed\n");
 	of_node_put(np);

-- 
2.34.1



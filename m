Return-Path: <linux-kernel+bounces-282150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6F594E029
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 07:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3001C20C43
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 05:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD931AAC4;
	Sun, 11 Aug 2024 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gqhsbGNV"
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445218E20
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 05:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723355419; cv=none; b=IK4FJuRptI3ET/Yh83ChGTnRdgNDmaD8V90FcPv5QGnwaetDw7yIaKiQZ6mmOhp7BKig1RVCN0ruohZcLAdjeQst0XoZPH3lOfVn6VdbJCTVwOvfX0hvUr9dVPVhqs1nvfCE7+2MlkQTRAYXlY4DaieARuxvjfIKvThdvXN3bHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723355419; c=relaxed/simple;
	bh=JUdU1dWgthWDsq2QHolSqmavGLFL1A2hr16y1bey3N0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SQfoyGtG6GXI9WqCOx2ZVabZVZUs8IrxdUAKOVDnU78UOad4s/NnMY4gNpoLpaNTgA/dWuvuv7B+BnQb7H6z43YFjDxy6K/Ue2QldV5mUp6fS2MnZCmqJSI3Qd1eXalbmHN+GYOsgUtjcPl6L+xw2P36LDahoCZCFeB+3xNGsBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=gqhsbGNV; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723355417;
	bh=trhfvyCKHQsYq7q0rV0HsHqp8bgmMHJ5P/2VHtxj/rI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=gqhsbGNVfIqsQIA2expU2Xvta7GAp/+0rp8ZYoOxjiiSREazjgoGSzR2Edm82jX38
	 7Cxy8VzOJlxeCJsnfCjXp4hNniIcQrjw+QPTIZPYjn9mYjWxaN72ikArEpOL468nMP
	 T2iW9CX07rcrm2iDmulQeFMdO5d4aCJIJvJkEbTDL3yMQlbOqIKHmvKb909QH7G511
	 slvMUYvFnksg4dg2BoQuc3Sdqx7LL4ppauJgVhrvZnN17GnXNzPo+YdcgXTQDd56wC
	 YsOLOHMGCOFsgmhMgtMyg5FrBOuo5xnV+qbINkxXfBjNGoVQNh4K47llKmza716ktS
	 42ABNopxsinFw==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id D936B6800BD;
	Sun, 11 Aug 2024 05:50:13 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 13:49:58 +0800
Subject: [PATCH v2] driver core: Simplify driver API
 device_find_child_by_name() implementation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-simply_api_dfcbn-v2-1-d0398acdc366@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAVRuGYC/03P0WrDIBTG8VcJXs+hJmqaq73HKEGPx/XAoqlmY
 aX03WfXje3yU84P/ldWsRBWNnVXVnCnSjm1oZ46BieX3pBTaJspoQYxSskrLev7ZXYrzSGCTxz
 Ro5e69wiWtbO1YKTPb/L12HYseeHbqaD7g6wSD4jiZQ5lv3N8l1xyYUGjUCMAxJfzBwEleIa8/
 MgF21ul7cEz7yry9rvQNnU+Oj04e+i9sxajORirtTcm9g4GDEKADVINI/vf1lJ/yyCnut2j5pB
 TYzUoYZoBxk+7ZMfb7QteRhitLgEAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: oKX8w8KDfQipbixOzxlAB2oXUEQPlS81
X-Proofpoint-ORIG-GUID: oKX8w8KDfQipbixOzxlAB2oXUEQPlS81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_04,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110044
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify device_find_child_by_name() implementation by using existing
driver APIs device_find_child() and device_match_name().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Changes in v2:
- Correct commit message and remove all unnecessary comments and codes
- Link to v1: https://lore.kernel.org/lkml/20240720-simplify_drv_api-v1-1-07c5e028cccf@quicinc.com
---
 drivers/base/core.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f152e0f8fb03..8ed593d7e0be 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4093,18 +4093,7 @@ EXPORT_SYMBOL_GPL(device_find_child);
 struct device *device_find_child_by_name(struct device *parent,
 					 const char *name)
 {
-	struct klist_iter i;
-	struct device *child;
-
-	if (!parent)
-		return NULL;
-
-	klist_iter_init(&parent->p->klist_children, &i);
-	while ((child = next_device(&i)))
-		if (sysfs_streq(dev_name(child), name) && get_device(child))
-			break;
-	klist_iter_exit(&i);
-	return child;
+	return device_find_child(parent, name, device_match_name);
 }
 EXPORT_SYMBOL_GPL(device_find_child_by_name);
 

---
base-commit: bfa54a793ba77ef696755b66f3ac4ed00c7d1248
change-id: 20240811-simply_api_dfcbn-eebeb153bec7
prerequisite-change-id: 20240811-const_dfc_done-c5c206675c6b:v1
prerequisite-patch-id: 475b810c1ccacab955c654c223d5214f70c4f6c8
prerequisite-patch-id: 81a5ccaa144a7732cae29fc5ea1a13426becee5b
prerequisite-patch-id: 9b77254186b7366809f949f5643f9437fa2528a0
prerequisite-patch-id: 95308bb3eedcf8c4a5e30aa3071116148495329e
prerequisite-patch-id: ee643a52674e2aead02f7be3d011d88507970436
prerequisite-patch-id: 0625de1f03ef4350b1828f0faff7a9d9bdebae94
prerequisite-patch-id: 6e671f2891f6ed906a35e0a90b5d8cd71c382b9c
prerequisite-patch-id: 8859b6fa330c363ef37567fc0a5421c0b9ecd8dc
prerequisite-patch-id: fe9aa57807bbb8b98dba32abd614d8f2e27565cd
prerequisite-patch-id: d03febd9c0afd5d21a2f664d748da7d7811a8e84
prerequisite-patch-id: c7425de06cf7032d54ff72f610d7632941be976e
prerequisite-patch-id: 54c942a1a492ba04480337f99dc901a8d4def782
prerequisite-patch-id: 7e8f4a3e378d5329b886a9a3719add3cbb10e3e3
prerequisite-patch-id: 34ff831994ac7bc265f567bacefff8ae687ccd40
prerequisite-patch-id: 66d46c755c25065e9d440a4137e1e8ccc245e0be
prerequisite-patch-id: 15bc81129ee07324b5a8faa39a5e6aea59952573
prerequisite-patch-id: fe9ca6ae244761b48469f375fe1fc8c9c7b24204
prerequisite-patch-id: a6fd24b37269a06a91fd926fa5111a19cdec7551
prerequisite-patch-id: 2f584b03145bc7d01e3ea632c6abb89d3b543d93
prerequisite-patch-id: 10e0d06e0340ce5028cd109fffa7f0720c70d242
prerequisite-patch-id: 0f9ea4a7c63d15c5c1324c5666901f0704c129ca
prerequisite-patch-id: 4f56ebd28ae00a50130f58409d934ca79ccec6a9
prerequisite-patch-id: 70e7432951b43a67204bb7eb6c437ba135def0f1
prerequisite-patch-id: 1718891e69e1d2031336b4a6e7f251c50619f336
prerequisite-patch-id: 5f838fb00256dbadfd36735ef3a1b1e43ec20549
prerequisite-patch-id: f4b36e4136d462c8ba9f94f777a6fa1a054b8809
prerequisite-patch-id: 56c12ce5dc6bfb090fa7801fa3f31c4e52b50775
prerequisite-patch-id: 2b23c8c2ae90030a59d267297b478584447b78ac
prerequisite-patch-id: 294c325d517e318063c61af218607d9721f1cc5f
prerequisite-patch-id: 38fb282ac119a88af58a88b38c9cdc74372df404
prerequisite-patch-id: d3ab2693194b77403d6ce20edf25ee3896d0260b
prerequisite-patch-id: 19b69184800129923777ee2acd2629565c69291b
prerequisite-patch-id: f58374cebf0ada070fc0825736424dd177e49676

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>



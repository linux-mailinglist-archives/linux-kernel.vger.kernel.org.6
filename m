Return-Path: <linux-kernel+bounces-531358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1D1A43F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148071880541
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0D12686BB;
	Tue, 25 Feb 2025 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ai82X+4d"
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0497267F58
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486802; cv=none; b=j2ekkUBJD32DQ8OWnCoFKqlPiZCdgTiGGoE3h+Pl2Yuhx3cefwS8hCkCdFwRp1g0BqTNG8nIwMWZNWZYvcxda3apmIiX2F+KnD3XsKZTO93ceaKYsS/M528SpwczsJTqSUipKmmR8Mf8mnXvC2t2jBU/oV6q84qFKZSxwnO0f7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486802; c=relaxed/simple;
	bh=e5ri7o/pKQgLDKlyQicTt3kAVTALbarSe2xQ/ZK/7MY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p1ltto55tnK8VfjYj6CsqvQQKklP/JALuMgsGAtBOzpK4W7Wj3wyacwkYOdnC4ksngzMd/ofei/5SFD3GlN4+cE0wRviHeIPT6gTle4RQcqG16H5ibEmKL0us1paShdOfR/lXN+wTgKzBorhMcUBFaduynqpYny/96a9rxSW+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ai82X+4d; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=BdtS65RHiFl1WFTCHO1gU6ssbrkbzjGtY4ydMrp5+Lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=ai82X+4d1AJ2ZgIr0rehiaxriw2YduGrnSxnJGLJxFOtPC65AT3/t/fQTT3moGZuu
	 u02wdu9sbKRlRJiqtcSUnqmUFSMIau8wtalTrPiFtIrLENcYgl7I9iiDxmVtKF9R39
	 nYW68ggjlNOoSU9YHqI8EmIGJMFopNURXlDKKEk5y59v20q8vcdz+R1PrAnHRpsVaf
	 2FIo+zs5tTdSOULdZGOMrPwM26kRpiW8uxBUGsKfZvabyCkqkXgB8mKPF0q63xSM+s
	 7W041G4b+83eWbCkRS/30BwnPvQYPd/OdQz22/rVW9PG/6IgVTYjU69zkep64yuxIn
	 gTTrZD6NNKhzg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id 4DB316802E4;
	Tue, 25 Feb 2025 12:33:12 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 25 Feb 2025 20:32:38 +0800
Subject: [PATCH RESEND 1/2] phy: core: Remove API
 devm_of_phy_provider_unregister()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-remove-apis-v1-1-e49b4a1941fd@quicinc.com>
References: <20250225-remove-apis-v1-0-e49b4a1941fd@quicinc.com>
In-Reply-To: <20250225-remove-apis-v1-0-e49b4a1941fd@quicinc.com>
To: Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: SIn9GGzSmUJc6gvg7CAUl2XGTMZUmYhs
X-Proofpoint-GUID: SIn9GGzSmUJc6gvg7CAUl2XGTMZUmYhs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=765 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502250088
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

API devm_of_phy_provider_unregister() has not had callers
since 2013-09-27 when it was introduced.

Remove the API.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 Documentation/driver-api/phy/phy.rst                  |  5 +----
 .../translations/zh_CN/driver-api/phy/phy.rst         |  5 +----
 drivers/phy/phy-core.c                                | 19 -------------------
 include/linux/phy/phy.h                               |  6 ------
 4 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/Documentation/driver-api/phy/phy.rst b/Documentation/driver-api/phy/phy.rst
index 81785c084f3ec2dd02af2131fbc8632cb5b33b0b..be3687a2a11bbf84e6e5561b11931ea6db984434 100644
--- a/Documentation/driver-api/phy/phy.rst
+++ b/Documentation/driver-api/phy/phy.rst
@@ -64,12 +64,9 @@ macros can be used to override the node containing the children.
 		__devm_of_phy_provider_register_full(dev, children,
 						     THIS_MODULE, xlate)
 
-	void devm_of_phy_provider_unregister(struct device *dev,
-		struct phy_provider *phy_provider);
 	void of_phy_provider_unregister(struct phy_provider *phy_provider);
 
-devm_of_phy_provider_unregister and of_phy_provider_unregister can be used to
-unregister the PHY.
+of_phy_provider_unregister can be used to unregister the PHY.
 
 Creating the PHY
 ================
diff --git a/Documentation/translations/zh_CN/driver-api/phy/phy.rst b/Documentation/translations/zh_CN/driver-api/phy/phy.rst
index 0d7489081b904d6fc5aa21824c969e325e801297..2d3f98deb92035c44fcb1ff0e3dc8543053140f6 100644
--- a/Documentation/translations/zh_CN/driver-api/phy/phy.rst
+++ b/Documentation/translations/zh_CN/driver-api/phy/phy.rst
@@ -63,12 +63,9 @@ devm_of_phy_provider_register_full() 宏来覆盖包含子节点的节点。
 		__devm_of_phy_provider_register_full(dev, children,
 						     THIS_MODULE, xlate)
 
-	void devm_of_phy_provider_unregister(struct device *dev,
-		struct phy_provider *phy_provider);
 	void of_phy_provider_unregister(struct phy_provider *phy_provider);
 
-devm_of_phy_provider_unregister 和 of_phy_provider_unregister
-可以被用来注销PHY.
+of_phy_provider_unregister() 可以被用来注销PHY.
 
 创建PHY
 =======
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 8dfdce605a905d7f38205727151258af41f807a9..dd6302dfd14d2ec060857fc019268096c33e37a2 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -1248,25 +1248,6 @@ void of_phy_provider_unregister(struct phy_provider *phy_provider)
 }
 EXPORT_SYMBOL_GPL(of_phy_provider_unregister);
 
-/**
- * devm_of_phy_provider_unregister() - remove phy provider from the framework
- * @dev: struct device of the phy provider
- * @phy_provider: phy provider returned by of_phy_provider_register()
- *
- * destroys the devres associated with this phy provider and invokes
- * of_phy_provider_unregister to unregister the phy provider.
- */
-void devm_of_phy_provider_unregister(struct device *dev,
-				     struct phy_provider *phy_provider)
-{
-	int r;
-
-	r = devres_release(dev, devm_phy_provider_release, devm_phy_match,
-			   phy_provider);
-	dev_WARN_ONCE(dev, r, "couldn't find PHY provider device resource\n");
-}
-EXPORT_SYMBOL_GPL(devm_of_phy_provider_unregister);
-
 /**
  * phy_release() - release the phy
  * @dev: the dev member within phy
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 03cd5bae92d3f189d739c453fe4c160dd2a5063e..06037a7eefc4b0319008065d142c9f1caba2c74d 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -288,8 +288,6 @@ struct phy_provider *__devm_of_phy_provider_register(struct device *dev,
 	struct phy * (*of_xlate)(struct device *dev,
 				 const struct of_phandle_args *args));
 void of_phy_provider_unregister(struct phy_provider *phy_provider);
-void devm_of_phy_provider_unregister(struct device *dev,
-	struct phy_provider *phy_provider);
 int phy_create_lookup(struct phy *phy, const char *con_id, const char *dev_id);
 void phy_remove_lookup(struct phy *phy, const char *con_id, const char *dev_id);
 #else
@@ -547,10 +545,6 @@ static inline void of_phy_provider_unregister(struct phy_provider *phy_provider)
 {
 }
 
-static inline void devm_of_phy_provider_unregister(struct device *dev,
-	struct phy_provider *phy_provider)
-{
-}
 static inline int
 phy_create_lookup(struct phy *phy, const char *con_id, const char *dev_id)
 {

-- 
2.34.1



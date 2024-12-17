Return-Path: <linux-kernel+bounces-449232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A659D9F4C05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9355B165276
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0181F76B1;
	Tue, 17 Dec 2024 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Z1LtAnKN"
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803581F76B2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440894; cv=none; b=LfoesPxjVtWI5seOAA0vZet0lvcX2pRkcsMzrRpT3SbYBXocWXQnLeJDAtWriX6LQX+GOHxjhZyg9kGf0XNAitoeoKKUIkjoyFOuvu4vh18yJxXb0U2Sg1Om6hEnPxdXkStP9ymLmk//Adx0KJANW9OMLJVDBThpT2MgrdbtxTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440894; c=relaxed/simple;
	bh=4/H70e0punnJ+RTZIpTcPhQowk99820k7GsZQcgr2+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VgfrR5aVIjtgHxfT9q8u8ToozeM8owNJKDwL3OHo6sOqB1PicYF4pX0k4GWLC4YzgQrqxwzxsf4tl2El2EiQzA+jpMLkPvYn6O12ikEMYXoqzz4ZpsYBPGJxRaxHA9G+RT1ZW5bCr6wDjLT71J/3s2Gix2wZVovLn3Wm5Rb34NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Z1LtAnKN; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734440893;
	bh=n/2ECFFvsy3oX54LANvs+QW1uDJIfzCg4fhckcEOoYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=Z1LtAnKNwOC+QV0YGMlZBb04806CMisrTeKAyrcfTXei+5ba4InX6JY0dMcqHX7pC
	 4c+ifodEy52ro11bEqH3ywp/drFfcmxLTzUu7F43otS+7Ryzt4ndqyGaKNtuEYc94Y
	 RDmHn7aoYqQkjE2zxLBj4H1ZkyvD2DbDocZCbYaRUy4IZQQnbpZjWjr7vgnHxgVJxm
	 GzUpIzwQxJ5Vm06Cs9dRWRrJjHezowjXwMqjZS/oWhFeVlUgRdVfUUVawc0YWdt4R5
	 vN3mmOus58vX9eg1C1shPZTirr+anFAOzl/Pn8JBNSSzCsSqKLcRtwwXe/8/dCVy8g
	 9+15DBLa7b0Ng==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id 28BE09602BA;
	Tue, 17 Dec 2024 13:08:09 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 17 Dec 2024 21:07:31 +0800
Subject: [PATCH v3 7/7] of: Do not expose of_modalias()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-of_core_fix-v3-7-3bc49a2e8bda@quicinc.com>
References: <20241217-of_core_fix-v3-0-3bc49a2e8bda@quicinc.com>
In-Reply-To: <20241217-of_core_fix-v3-0-3bc49a2e8bda@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 9vUZ2aJGuQLZzk4fqjghWZ0W9NDnSOfF
X-Proofpoint-ORIG-GUID: 9vUZ2aJGuQLZzk4fqjghWZ0W9NDnSOfF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_07,2024-12-17_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 mlxlogscore=664 phishscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170105
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Do not expose of_modalias() since it has no external callers.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/module.c     | 2 ++
 drivers/of/of_private.h | 2 ++
 include/linux/of.h      | 6 ------
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/of/module.c b/drivers/of/module.c
index 03a2b1b381e5b353b6699dac183c03186afb0486..6dd670f7e4fe68b6a8f4b30a81064a1b8e4a0644 100644
--- a/drivers/of/module.c
+++ b/drivers/of/module.c
@@ -8,6 +8,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
+#include "of_private.h"
+
 /*
  * of_modalias - get MODALIAS string value for a OF device node
  * @np: the OF device node
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 3433ccd330e84fd3a4b54638e0e922069757c8f0..5facb6ff63cce46205fbe3969ae2e9f7858ac9bd 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -150,6 +150,8 @@ extern void __of_detach_node(struct device_node *np);
 extern void __of_sysfs_remove_bin_file(struct device_node *np,
 				       const struct property *prop);
 
+char *of_modalias(const struct device_node *np, ssize_t *lenp);
+
 /* illegal phandle value (set when unresolved) */
 #define OF_PHANDLE_ILLEGAL	0xdeadbeef
 
diff --git a/include/linux/of.h b/include/linux/of.h
index f36bab2caa8ccffbd43593d8b6720946e19503e0..d9062d4fbd143d42b6b217942aced66fa34f1c80 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -382,7 +382,6 @@ extern int of_count_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name);
 
 /* module functions */
-char *of_modalias(const struct device_node *np, ssize_t *lenp);
 extern int of_request_module(const struct device_node *np);
 
 /* phandle iterator functions */
@@ -761,11 +760,6 @@ static inline int of_count_phandle_with_args(const struct device_node *np,
 	return -ENOSYS;
 }
 
-static inline char *of_modalias(const struct device_node *np, ssize_t *lenp)
-{
-	return ERR_PTR(-ENODEV);
-}
-
 static inline int of_request_module(const struct device_node *np)
 {
 	return -ENODEV;

-- 
2.34.1



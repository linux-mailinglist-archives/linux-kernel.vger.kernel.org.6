Return-Path: <linux-kernel+bounces-282094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4CD94DFA7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8981C20D86
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1609E208A9;
	Sun, 11 Aug 2024 02:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="F7G3o9N0"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A0F22EE4
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343138; cv=none; b=cMu7nvdMBu8TojTcMWYO4oe9lVKj3pSlWVdTwt7zNkkw2zhUnlHoeA5MVzONaT/RJdADIgcIYEjsJ8AvJz8rBmDdQ9x3zPhuIthWn8Fiy0ZGUyufXOQb4SrU/OwkBAlX4dQmrpCmfJosfoFK6v2IWL40KYm4y9unnD6fhF+sERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343138; c=relaxed/simple;
	bh=w7PAioQTScijhALSXWwSjrKfi4vkXl6vrrv54trLHoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tFg7ADbbQaRersBGKS00blG81QRrvn4sLjsRG+Rlq/BzZ1O5LvkELUIUUOdXTLWC/OJTgGUHJKI0Aaww+Y8DyGoUoEq4HqLZRoIHu52M6Ujd1ndL5ALpAr/u6bNL9mMXV9fGFi1OwPt6BiShH4ylGO38sR3TJhUUemnzoSsDB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=F7G3o9N0; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343136;
	bh=JKG1Kj8NdCqB0zViXrPq/bCmTEbJnL43t1wVEufEbto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=F7G3o9N0sW0Fk21wtyWrhNb6Wck4qYgyc4RrYgzvgv0r5xBo6T5YVvlZhGQVtJKF2
	 PLZZhwcLqJpAXQHTI5e7tgqLiUaWB/PLEkM3jNdH5rlAdQXG3tyGOQ6Vyl6xjFqCAL
	 WiT8rcgKU5xNmoZoK35EE2I12O8Nnwnh9ennqU5DHLvWKhwpZ+OA8xHT9B+YIIcKRs
	 wAar41YlxF9Nk5rCetDzoCnd3UeVb00nSshaxZiG7awJrW86E+qdsAHbYtAPaBjPH3
	 knWVy47Lnni2Heu1saeeNOZn8cUrUNFRmDCRL1xgXW9up4uD2Ah+taZpwct4b/vsMg
	 niSZJln0fKsOw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 3EAEE1349B99;
	Sun, 11 Aug 2024 02:25:32 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:24:57 +0800
Subject: [PATCH 06/27] slimbus: core: Make device_find_child()'s match
 function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-6-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: 36_BxiVoOYVrnxt3vvzU7Ulqq2jS62OH
X-Proofpoint-ORIG-GUID: 36_BxiVoOYVrnxt3vvzU7Ulqq2jS62OH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make its match
functions take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/slimbus/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 65e5515f7555..ab927fd077cb 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -328,7 +328,8 @@ void slim_report_absent(struct slim_device *sbdev)
 }
 EXPORT_SYMBOL_GPL(slim_report_absent);
 
-static bool slim_eaddr_equal(struct slim_eaddr *a, struct slim_eaddr *b)
+static bool slim_eaddr_equal(const struct slim_eaddr *a,
+			     const struct slim_eaddr *b)
 {
 	return (a->manf_id == b->manf_id &&
 		a->prod_code == b->prod_code &&
@@ -336,9 +337,9 @@ static bool slim_eaddr_equal(struct slim_eaddr *a, struct slim_eaddr *b)
 		a->instance == b->instance);
 }
 
-static int slim_match_dev(struct device *dev, void *data)
+static int slim_match_dev(struct device *dev, const void *data)
 {
-	struct slim_eaddr *e_addr = data;
+	const struct slim_eaddr *e_addr = data;
 	struct slim_device *sbdev = to_slim_device(dev);
 
 	return slim_eaddr_equal(&sbdev->e_addr, e_addr);
@@ -384,9 +385,9 @@ struct slim_device *slim_get_device(struct slim_controller *ctrl,
 }
 EXPORT_SYMBOL_GPL(slim_get_device);
 
-static int of_slim_match_dev(struct device *dev, void *data)
+static int of_slim_match_dev(struct device *dev, const void *data)
 {
-	struct device_node *np = data;
+	const struct device_node *np = data;
 	struct slim_device *sbdev = to_slim_device(dev);
 
 	return (sbdev->dev.of_node == np);

-- 
2.34.1



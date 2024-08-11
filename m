Return-Path: <linux-kernel+bounces-282112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B91494DFB9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1FAB1F2172C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5429424;
	Sun, 11 Aug 2024 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="w41NJ5se"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A6613BC3E
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343210; cv=none; b=d25n2NjvdZrkl6S1VW1icFvA+0d3oiHHUYn9/WpjTIBVZDNeHmNTEUD6cJo5jvQ3S8d6ek87uIBBzIpYNMEFbvlq27iyjoZHCI7STA7x5aLKysjzoHn6N66sSHnOwBBW2NX4RvJey/7jTiNzHj1NrcTg7IOKPbT1Xa2GIxl+VcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343210; c=relaxed/simple;
	bh=e+JkQ7K5hS3PEdxTk/EG+5K7UTlEQoN/w50ihBQgE60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d9lLvNlQl4Hrb2TLbpPrm+QjtEiC023AreLrIeouogePwgl9Lt0Pzea2j9rpPYC7EtcXIhAxcoCaD3rLOSmJ1dCrsHEP6GarGFhxrlAqzBEBU04WKiuc8mihsc0C0vcw0obv3gpe6PlYY2HJIKztX6t/iPYUk0cEaKP7Ht+ZbzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=w41NJ5se; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343209;
	bh=cBAK8Kuf4xT7vUB6fda4oECSPrBvDw73H8oUmB7ElMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=w41NJ5seF3maluEnDlHz08AuA1Sp9Q2r2TG/oXXetWCN/YG00nMs7TrP6D+N3FBAd
	 qJ74g7K/Wy1yk0FWukv7D/ZlLvTeOq1BNeRM5rWGR/fqWi6uXfJ8ruNMS7irRvQ1RI
	 Cun2VXDWyhgwizVsfx6mepVihXY6JJwqJJzV2AVsuUd7OlX2urHR1dfG9puYcWFY+B
	 HMvh4R2cVd48iCVnhxoTxr6ARFzsmOngq3mSkhseqztdfOO4vgmcqyg6WdMRKuI+Ok
	 Br17Ngjg440WpPI119NYKl4EMJR+xqjOoQgFrvH0RjAGg0CDp2B+NUY5U9jeu/CXWI
	 bpyYSeyXE5QTw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id B28BF1349C58;
	Sun, 11 Aug 2024 02:26:45 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:15 +0800
Subject: [PATCH 24/27] rpmsg: core: Make device_find_child()'s match
 function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-24-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: 9IlFGcd7PyIJbT6C_NlMnaWPFSKdR9qq
X-Proofpoint-ORIG-GUID: 9IlFGcd7PyIJbT6C_NlMnaWPFSKdR9qq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make
rpmsg_device_match() as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/rpmsg/rpmsg_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 712c06c02696..207b64c0a2fe 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -377,9 +377,9 @@ EXPORT_SYMBOL(rpmsg_get_mtu);
  * this is used to make sure we're not creating rpmsg devices for channels
  * that already exist.
  */
-static int rpmsg_device_match(struct device *dev, void *data)
+static int rpmsg_device_match(struct device *dev, const void *data)
 {
-	struct rpmsg_channel_info *chinfo = data;
+	const struct rpmsg_channel_info *chinfo = data;
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 
 	if (chinfo->src != RPMSG_ADDR_ANY && chinfo->src != rpdev->src)

-- 
2.34.1



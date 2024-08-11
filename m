Return-Path: <linux-kernel+bounces-282105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD8594DFB2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DF0FB20F07
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443F61A29A;
	Sun, 11 Aug 2024 02:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="MH8XpVHI"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3652B770EB
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343182; cv=none; b=G4yu8LjIt2zdXf7MuZvvIHdMxZqinh7vKBDv2bYr7TdUsbOr+5wIgVawjWqMTEPPKjqyrVz8ChtPuBvzTVMt9YCsnLwOULPbgqROWs81sYC5bZhw6cBJ1NEhxDguK5IQjs1FmTkF59FUNfeSSIda88FZkl5BEvQ4rejlh5xRfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343182; c=relaxed/simple;
	bh=2tEwom4I8U4vt3CSoONqNCWvVKCknTHp+d++FJEpNrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HgAgjZlPTaXxNPBdOb+vw1h/6MyBFNJqgE/7FcEhdzV13kf8PH9LyfitRSoHrDGOy1qo1Ki4GnSKMYnlxJJP18Li623L0fiD8w2wZzIdeh4SvyPTDkzxPpdKn4+29G8k79DYTnL8vrsgX4atZpJELDFeG7r/WmO9AuoIMX+TI98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=MH8XpVHI; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343180;
	bh=c8Qs+v0QSAyErw7zOYBOkTqXb/w1uPouJIA/o+PSZE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=MH8XpVHIXttsbtrSsB2Ca3zy6zaaO3te0Ad+QAdTSqEr3/ACJDseibXyiBis7biPI
	 wwfgKkcCNdz+7o82f9xOP37g8PLuxbMG15HmJ6jOZo+SxbX4f2grbiEVGUikiDbJDu
	 bn1AxwtaouIErWnykgUgRLz9Qu9tDLbaJ1/rzcLvz7rqpCarkpXlyeWOhalhjJeutP
	 lrOU7i3sEOYq4+hI+1IThfBgp4UIMIx8sok18N4zYSaeaP+GHA7Ryqg2YPlp88ZVIR
	 rUhEEGiaWYSlX+rvGArjF9sarpvD/ZQc1PEZAhXPur4eKI7SVsYwg7honpS6gNkEZy
	 Fctt8OfDbQqpg==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 92F7E1349C2D;
	Sun, 11 Aug 2024 02:26:17 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:08 +0800
Subject: [PATCH 17/27] bus: fsl-mc: Make device_find_child()'s match
 function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-17-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: 8kEwm5m71wG4cUPs9nujgU_ivGUmT0dz
X-Proofpoint-ORIG-GUID: 8kEwm5m71wG4cUPs9nujgU_ivGUmT0dz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=965
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make
__fsl_mc_device_match() as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 4b68c84ef485..a3dfaa508724 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -23,10 +23,10 @@ struct fsl_mc_child_objs {
 };
 
 static bool fsl_mc_device_match(struct fsl_mc_device *mc_dev,
-				struct fsl_mc_obj_desc *obj_desc)
+				const struct fsl_mc_obj_desc *obj_desc)
 {
 	return mc_dev->obj_desc.id == obj_desc->id &&
-	       strcmp(mc_dev->obj_desc.type, obj_desc->type) == 0;
+		strcmp(mc_dev->obj_desc.type, obj_desc->type) == 0;
 }
 
 static bool fsl_mc_obj_desc_is_allocatable(struct fsl_mc_obj_desc *obj)
@@ -112,9 +112,9 @@ void dprc_remove_devices(struct fsl_mc_device *mc_bus_dev,
 }
 EXPORT_SYMBOL_GPL(dprc_remove_devices);
 
-static int __fsl_mc_device_match(struct device *dev, void *data)
+static int __fsl_mc_device_match(struct device *dev, const void *data)
 {
-	struct fsl_mc_obj_desc *obj_desc = data;
+	const struct fsl_mc_obj_desc *obj_desc = data;
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
 	return fsl_mc_device_match(mc_dev, obj_desc);

-- 
2.34.1



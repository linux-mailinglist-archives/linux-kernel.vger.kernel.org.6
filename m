Return-Path: <linux-kernel+bounces-264010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E199193DDD7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 10:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164581C21287
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 08:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5D739FE5;
	Sat, 27 Jul 2024 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="xK763BF+"
Received: from mr85p00im-ztdg06021701.me.com (mr85p00im-ztdg06021701.me.com [17.58.23.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5092570
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722069264; cv=none; b=Od0qyT78PEFeoRP+Lx2aK+M63S7xiRK4oZZkLgWyB+ieCZuB3x1YXJbS+Dldx13WetFxio0QbM+TrGwyinCosijji5mUU1wLEyRm/psTxO1CdPupt/+6184V54SOlV7hjEwFcAFNU/JEIeUIY5Xh1r/UbOM5VNIwi8l+OouQhFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722069264; c=relaxed/simple;
	bh=bGkivs/jYI7//1S41rjSPg6Zf30D00sjQ6Ibe9SbJSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LNi2mrsfVE0QrvaufkOR7tAbpBOZjeC+tNtNI8GAniA/AQ0qT8aCKQLXzVedL6WrdBqmhIwGd/LReDT5MPlCG9MLq1f0g2f5JNUjX+QzBiZG7TLXTCGaN4hL34Bb6C8xsQO3kyb4ktHxmOJTcQ49GqJwHCJU+6PI6Hpn8nWwHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=xK763BF+; arc=none smtp.client-ip=17.58.23.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1722069262;
	bh=vpzvlHTUX+FHKuRxdNgrBIa8MECN/tebROqRQxFYSlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=xK763BF+Vz2fFG7ux/8WZKKt079LtXQ3dBdX9R0fMsOuCcmZDwlmhWE2cyEedacTA
	 jXyWeuIF/NaIDHopgNdE0r4/OQAwDTCuF6A+n77IFe/A7HJD//uYlAgvy6h5pq0+SH
	 FSPYiV35Hi9OyrGhgPfLDz2Sy75LR67Le61p105LwHlDV3knI6/WdSi+wiN2P3/uqO
	 W81pzSKeeS+/DuBrhcM15Xc+rsBC5h9vXHdoGM98EBDi4Q6j7QXZHqZgqW3gBPYpeO
	 UqR9ugbKiN1ISXUHXCelojRKf8DbPEJc9TTksQL3k+8RnBx+zvt4wRzyfIEEDZ3SRK
	 Heve97tALfWHQ==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021701.me.com (Postfix) with ESMTPSA id 644902633357;
	Sat, 27 Jul 2024 08:34:18 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sat, 27 Jul 2024 16:34:01 +0800
Subject: [PATCH] driver core: bus: Fix double free in driver API
 bus_register()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-bus_register_fix-v1-1-fed8dd0dba7a@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPiwpGYC/x2MQQqAMAzAviI9O9jGZOBXRIbOqr1MaVUE8e8Wj
 wkkDwgyoUBbPcB4kdBWFFxdQV6HsqChSRm89cFGH814SmJcSA7kNNNtQmhczrN10UbQbGdU/S+
 7/n0/8CMOtmIAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: TDXSc6dwp1M4QLsAgct-rq7AeS1skhf3
X-Proofpoint-ORIG-GUID: TDXSc6dwp1M4QLsAgct-rq7AeS1skhf3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_06,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2407270053
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For bus_register(), any error which happens after kset_register() will
cause that @priv are freed twice, fixed by setting @priv with NULL after
the first free.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index ffea0728b8b2..08362ecec0ec 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -920,6 +920,8 @@ int bus_register(const struct bus_type *bus)
 	bus_remove_file(bus, &bus_attr_uevent);
 bus_uevent_fail:
 	kset_unregister(&priv->subsys);
+	/* Above kset_unregister() will kfree @priv */
+	priv = NULL;
 out:
 	kfree(priv);
 	return retval;

---
base-commit: 1722389b0d863056d78287a120a1d6cadb8d4f7b
change-id: 20240727-bus_register_fix-4451ccf01707

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>



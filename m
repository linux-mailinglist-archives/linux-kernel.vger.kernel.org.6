Return-Path: <linux-kernel+bounces-282113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2FA94DFBA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D46C286A66
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE93134B1;
	Sun, 11 Aug 2024 02:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="PBcX/QR5"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D72713D892
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343214; cv=none; b=eF6+r0oMs2pNBMFXlJ5PhWyACHzeyJ+f3ID8meJY680THnX08KQv4EBD4pzG6+vIHhaTO5/n7HJ5u+D/G9DiUD46VLUkpQhs2bS2hJ7vveL6TJRGcl+bsNbIeFQ6zbH7hUukk4VSwmENxZCfnetK7kPV2LeZSVHLSJHfFjwQOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343214; c=relaxed/simple;
	bh=R7SG95+y0eCnKZRHhsw9diFEI6Al6ea4aLoO6XHSQAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G+udMOXJnZzrWxRUJ66CbD0MAz54SJusviWOckUJwgcqLFzWib3OoMvI/O5Jcr0Ufrx8QyyK41ZgrO9rsguY6kSAcVx1qkAUBK6nG4o80r3OdzY9v5H6nSEZZcOoTDRqPq+bKpyXBCDfx0UqWrgQWClOsVzCVs1q82OdqVPVXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=PBcX/QR5; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343213;
	bh=AALvdOVnufe86KWt7uABgH1oMyvZANCpsbPWo5ZHAOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=PBcX/QR5D8ZQD3w0BN61rOZDEVA0CDi4/JW+GPWZfomvf2p0cSlXBM9c/yk8hKNyE
	 gLdunmeEVAOcOOizfL7fLLDSYltlVdRdyMuDYm3Rh7PEVZ5IdXR5eZT75T8JvAErka
	 bVods6dSEq+kBMLN527k5AmklrnEBg0cfQXedAHefnuQY8UP2MEhl/bspIPEdXySnJ
	 dB2W9OXcTycoInxaKameEwLjDrRYTsuriF8Wns3iY0J8RjFwn0cvegUiRQfe51XK99
	 TC8V+ae15eyAB8D1pSnI7VQABs57PIAGCcmg4gSHQ6SoMNR4P5nMx46CF7UA86z8GN
	 L9U/5NDgMG0CQ==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id B44761349C17;
	Sun, 11 Aug 2024 02:26:49 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:16 +0800
Subject: [PATCH 25/27] thunderbolt: Make device_find_child()'s match
 function take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-25-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: seMkKfPW7NZkFQ_rHN5UtsB0clXcNFyl
X-Proofpoint-ORIG-GUID: seMkKfPW7NZkFQ_rHN5UtsB0clXcNFyl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=521
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make its match
functions take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/thunderbolt/retimer.c | 2 +-
 drivers/thunderbolt/xdomain.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 721319329afa..ebda5f996f19 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -461,7 +461,7 @@ struct tb_retimer_lookup {
 	u8 index;
 };
 
-static int retimer_match(struct device *dev, void *data)
+static int retimer_match(struct device *dev, const void *data)
 {
 	const struct tb_retimer_lookup *lookup = data;
 	struct tb_retimer *rt = tb_to_retimer(dev);
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 11a50c86a1e4..b0630e6d9472 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1026,7 +1026,7 @@ static int remove_missing_service(struct device *dev, void *data)
 	return 0;
 }
 
-static int find_service(struct device *dev, void *data)
+static int find_service(struct device *dev, const void *data)
 {
 	const struct tb_property *p = data;
 	struct tb_service *svc;

-- 
2.34.1



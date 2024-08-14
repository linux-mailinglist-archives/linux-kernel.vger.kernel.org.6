Return-Path: <linux-kernel+bounces-286113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C6B9516A7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76FC28328D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C2813DDC3;
	Wed, 14 Aug 2024 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="rYivM9Zh"
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com [67.231.149.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8AB156CE;
	Wed, 14 Aug 2024 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723624493; cv=none; b=E5B07ZFPxurf09YzhxaGocXprMug9HII365QeeenL/Xjfecw59QxbMDr4HfSfqlvQrlT/axGs8FZtI8ayyGzWraJanQbCfo4oDtzN/FmD+QB82dfY39gyzrJxuxhAK8k+kzrWm02ObVh9eLtpe5OnR/QnTjbRaLS59kpqEv8vlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723624493; c=relaxed/simple;
	bh=7QDLntWldbnSeuBAZcY/ZzFo2vh83BEtMVio1Wckw38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qvpC2E8/8mh1XjigzSyC5NzkRFW5nk9fkYlnhV/3OtEgsYmeS9CXTm/+nrQ6BhoH0iUln60D0ICVI0APwKnyvxWLvBUXnpjSwq4Zs6yoYvLQNKruRtPC0FHryeS3nSaXzt1jbYkZzNO2vkYj4/9fTPwtjeCy8rVQ2EaCagbCt9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=rYivM9Zh; arc=none smtp.client-ip=67.231.149.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Received: from pps.filterd (m0047963.ppops.net [127.0.0.1])
	by m0047963.ppops.net-00176a03. (8.18.1.2/8.18.1.2) with ESMTP id 47E79cEf048829;
	Wed, 14 Aug 2024 03:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	gehealthcare.com; h=cc:content-transfer-encoding:date:from
	:message-id:mime-version:subject:to; s=outbound; bh=yYXBYwKvovwf
	RYTq1dF6PXijGWFPPekmKyVhJGzLDtg=; b=rYivM9ZhXaFIYZCOzsh1wsi5H78x
	IJUzdsCphQJmjmT93Q//Om8o6elHnbjR0ez8z4ACpsVK2o6diE47dc/COTy5E9z7
	192r5ILsY51ABFuJfR5RvyZ1L4bY/znS+qR6N4D4evDkHN/zFHf+lNtEmLm6cxwr
	zwwMwspo5tQRVA2ivMhElYgFEIfuMVH6Vk1QmvLTYOgLzIxckTGXNHz0wC2+hHKD
	4j0lonbRmxGzKEUcaJOBfiEnKkBPyBDFREaYE1pL+d9K6w4IJzQGUib9cTzHN7P4
	2ikkhpVYc+YPSeOe7u7OL0YjcBBGoulbHJopp2U6leLPdMnfq9fLdsLoSQ==
From: Ian Ray <ian.ray@gehealthcare.com>
To: Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ian Ray <ian.ray@gehealthcare.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cdc-acm: Add DISABLE_ECHO quirk for GE HealthCare UI Controller
Date: Wed, 14 Aug 2024 10:29:05 +0300
Message-Id: <20240814072905.2501-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Idp6fefdzsS78CHuuaq_A42ttE8PszEg
X-Proofpoint-GUID: Idp6fefdzsS78CHuuaq_A42ttE8PszEg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_04,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 suspectscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408140051

USB_DEVICE(0x1901, 0x0006) may send data before cdc_acm is ready, which
may be misinterpreted in the default N_TTY line discipline.

Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 drivers/usb/class/cdc-acm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 0e7439dba8fe..0c1b69d944ca 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1761,6 +1761,9 @@ static const struct usb_device_id acm_ids[] = {
 	{ USB_DEVICE(0x11ca, 0x0201), /* VeriFone Mx870 Gadget Serial */
 	.driver_info = SINGLE_RX_URB,
 	},
+	{ USB_DEVICE(0x1901, 0x0006), /* GE Healthcare Patient Monitor UI Controller */
+	.driver_info = DISABLE_ECHO, /* DISABLE ECHO in termios flag */
+	},
 	{ USB_DEVICE(0x1965, 0x0018), /* Uniden UBC125XLT */
 	.driver_info = NO_UNION_NORMAL, /* has no union descriptor */
 	},
-- 
2.39.2



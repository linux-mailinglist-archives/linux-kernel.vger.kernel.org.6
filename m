Return-Path: <linux-kernel+bounces-184509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB4D8CA7B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 07:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 159C4B22859
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB64A43AC3;
	Tue, 21 May 2024 05:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="esLKZywy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE22B47A73;
	Tue, 21 May 2024 05:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716270206; cv=none; b=nAdCWY5rXgJEsz054tayPPh6Y0ZRPsp2mQWvTVX0SljcTKTZSbdfTdddKZsAwNf/8LmwdJQIfZjS9LwjU4PGGaSAMvvo7HjcZaiC3fVZFo+MGIsC/wQsrXwKegRsus2JZrmX1qvQwskTCTkACQRnvMODp1I6JyVjXfeM8jG9gcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716270206; c=relaxed/simple;
	bh=mRXYAVcS0INx8PQTnBxXRFR4ONvAUOefmV5ZCkLu97E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qUAeq66a3oPnxIni18hwspDdLS6htJn2dHsO21P4fW+SwUxMW5iBR8ZsDriU4Ksl1dj6IPRO54TmiIxqLRYQWy3SJ2Y9MeBf4WghguJXXBA7V1/OJfYzY+WUxAb3brotBL2vk9b+8e77lt6MRGUz5dh7MBE0oPB87FudWjglUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=esLKZywy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44L3VaQX015369;
	Tue, 21 May 2024 05:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=9qRAYpc3G8G7AVcjNmq22okmtZTeP5x2a/qxqH9FWng=; b=es
	LKZywykqGfVf9oZkmh4NPTs+HipYLY8BcHEpHZTZGGiqAH9g1tAEtTFbqUqXOPfD
	Mm42+TNqRsWyepKxNHXuhC9D0Qbg3T4iJPekwMkoZt+I1C1Z4g3OHw/JVBslcF51
	MNHL1R4zweBuHieS0aYMdt5MGrMGeOSRL6Kjc5WYj87hAezyCRlnU13aIvwx8fAm
	YWg5M8pZqhEmmm2ZBMti/te9nm9uSDV5bc8hVnpmcV2QgH8ZgxGUfBYkIcKPkL/5
	t2YuJh09gQNbD8Jx/NhR/mFO8hXRZ+mu9nXYAWcDUtCLKPBIoI5kXjQgV5Qcuvmt
	1QphxounOfSHVWVn7pKg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4p5gu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 05:43:18 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44L5hFWd012496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 May 2024 05:43:15 GMT
Received: from hu-akakum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 20 May 2024 22:43:08 -0700
From: Akash Kumar <quic_akakum@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jing Leng
	<jleng@ambarella.com>, Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Pratham=20Pratap=C2=A0?= <quic_ppratap@quicinc.com>,
        Jack Pham
	<quic_jackp@quicinc.com>, <kernel@quicinc.com>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Vijayavardhan Vennapusa
	<quic_vvreddy@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Akash Kumar
	<quic_akakum@quicinc.com>
Subject: [PATCH v2] usb: gadget: Increase max configuration interface to 32
Date: Tue, 21 May 2024 11:12:57 +0530
Message-ID: <20240521054257.32689-1-quic_akakum@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vFoDhf4FlW9cgR_m7-l629bUtglIyTdM
X-Proofpoint-GUID: vFoDhf4FlW9cgR_m7-l629bUtglIyTdM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_03,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0
 impostorscore=0 clxscore=1011 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=776 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405210042

Currently, max configuration interfaces are limited to 16, which fails
for compositions containing 10 UVC configurations with interrupt ep
disabled along with other configurations , and we see bind failures
while allocating interface ID in uvc bind.

Increase max configuration interface to 32 to support any large
compositions, limited to the same size as USB device endpoints, as
interfaces cannot be more than endpoints.

Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
---
 include/linux/usb/composite.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 2040696d75b6..d6d4fbfb6d0e 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -255,7 +255,7 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g, struct usb_function *f,
 int config_ep_by_speed(struct usb_gadget *g, struct usb_function *f,
 			struct usb_ep *_ep);
 
-#define	MAX_CONFIG_INTERFACES		16	/* arbitrary; max 255 */
+#define	MAX_CONFIG_INTERFACES		32
 
 /**
  * struct usb_configuration - represents one gadget configuration
-- 
2.17.1



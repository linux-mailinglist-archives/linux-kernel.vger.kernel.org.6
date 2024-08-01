Return-Path: <linux-kernel+bounces-270643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C6A9442B9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E4B1C20DD5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C6B13DBA4;
	Thu,  1 Aug 2024 05:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BanuGsq1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBEC2744E;
	Thu,  1 Aug 2024 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722490281; cv=none; b=Y28VSAC5BIEU4LqRKVqqo9anfwKRvSwVsuP9cYI1e0oPtWROcFU+e9BKRBsggiNPTGpVkpGb6QN/d9X0Y5tjiPS6xZ6v2Ef7+lb+3XEn0LXVBYY/argfCAnfsZ1Fu040/QZmd2cWJusF/HvzcLfTHoRG7aT1YQXAarmq3LGXwgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722490281; c=relaxed/simple;
	bh=r+dH3tnTDJQpi8X8pE4bNLRxm4x9qSvqVTXiJGce7jU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YPizy0CPiwK66NS/urLEVeGhvrLmmM4Y54a357kDx0oiqIk0M8x1HebnazzfH4axnQ//8YgxDonMaMijhuigM6BYpqsGh4khOK/lAqPBRyhBtYxYN6wuz8zwsvVWcdnFOgwQkPC8yYWTaMlOaCY7TT1KAxxhK1iDs6V5LMGyYxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BanuGsq1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VMRpRY020552;
	Thu, 1 Aug 2024 05:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=QFEJaSAxgxgPNWxAYtoc8e8qb12Q/0iYNTyO3gpgrDs=; b=Ba
	nuGsq1gNJQgCmUqk+mbPY8Gu6TPR7ncEPjQZ7zY3IrHd8GV+Ym/DTrVhUPXGItvC
	O1HC49ADQZGIxDAlRr/rhA8LRLgDznzY/mKAD4525LYOYu+OwquWkIRM7MHLES1O
	ybqS/5IsVfyUo2t4nHlr1tZ7AKAQTYH9qIljPzMMCTTuipgdVHvwDXU1PE5ikXtg
	HemGPeiWMRNSgZ5vdn2Dri+YsQ/9kruxRha1wa+c668C+6+V9xsk/PjWDHNmMjdO
	fBSGJaZoJX9N+v2OVpWpu2DKJW+xk7ix/AtF/pqQyj7N045apKf82m/9UUFWk8bb
	3yTZ7EEWK1X6oeKEf+hQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40qkv0tq4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 05:31:11 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4715VBA7023300
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 05:31:11 GMT
Received: from hu-akakum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 31 Jul 2024 22:31:03 -0700
From: Akash Kumar <quic_akakum@quicinc.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jing Leng <jleng@ambarella.com>, Felipe Balbi
	<balbi@kernel.org>,
        Jack Pham <quic_jackp@quicinc.com>, <kernel@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>,
        Daniel Scally
	<dan.scally@ideasonboard.com>
CC: Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Akash Kumar <quic_akakum@quicinc.com>
Subject: [PATCH v2] usb: gadget: Increase max configuration interface to 32
Date: Thu, 1 Aug 2024 11:00:03 +0530
Message-ID: <20240801053003.15153-1-quic_akakum@quicinc.com>
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
X-Proofpoint-ORIG-GUID: pRNg6HCfHJJSe3ysMV00W7nkeL1p9JS1
X-Proofpoint-GUID: pRNg6HCfHJJSe3ysMV00W7nkeL1p9JS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_02,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=799 clxscore=1011
 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010030

Currently, max configuration interfaces are limited to 16, which fails
for compositions containing 10 UVC configurations with interrupt ep
disabled along with other configurations , and we see bind failures
while allocating interface ID in uvc bind.

Increase max configuration interface to 32 to support any large
compositions limited to same size as usb device endpoints as
interfaces cannot be more than endpoints.

Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
---
 include/linux/usb/composite.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes for v2:
Removed comment '/* arbitrary; max 255 */' as per review as it was
confusing as MAX_CONFIG_INTERFACES cannot go beyond 32 due to usb
ep limitation.

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



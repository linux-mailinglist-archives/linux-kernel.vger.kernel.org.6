Return-Path: <linux-kernel+bounces-198562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD718D7A55
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FA31C20EBA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B621EAC2;
	Mon,  3 Jun 2024 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qn2D9rP3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E616CD271;
	Mon,  3 Jun 2024 03:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717383737; cv=none; b=WkjibA+2yK+R6lS5kJRaiWE8orsvcXJPgZUgVKw3fFuQyC/qaYGeu8rJPTwT7kRYgzAduyQn+pAaWBR7aWpVgLSs73lKBlsGKuWosqL7BaNdkrTTaqcI5Va02VhPWBGDm6eOj1PcRjqML6t9iiaL1BqeYMTC5DUN6wkPWr5uLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717383737; c=relaxed/simple;
	bh=mgYVA1yYxqNDMNqXiSBXnZpivAnSTkybZ199W4G6En4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=OJ5NZmBRLO0VR/3IsN78jU7ZWRKinEutoe8fSnITfN9HtGq9KiiM9E+WYAJjyFuNMtP+DjPFUf6uWDZJd48lnF64CunAdzf8uvy0Q/dN56LnilZDvRJEQpZKZn9IurSa4YrYC9UazV6BuiaN0u/pIgkpM63kAEkiMxxC51IHaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qn2D9rP3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4530Us2m002321;
	Mon, 3 Jun 2024 03:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Nfn7cy7Yl7LvnB0d4MsQaO
	TxTwOLpTzlu2/F6mHlSfE=; b=Qn2D9rP3TKPnAdKU3N6AYRDUQ+HBeweglcNZzP
	kQ2ayQYqAujQYFHLj3dLKC25Cx/9YUXP/GnoO+ECVYEJSGDwPSUEYBs3C+HTYD67
	he/4hepfV319fIJP3jUXTXowif7CgLBB2JT+UpxSweex+rm0I/qV6kRjtnD4BDGy
	6/oZjnTrCSu1LNnQhPTwyEajMXSA1Mq5lP+noyOjiap837zbsW/SDcUwIIDR1Dri
	K/q7XlnghUUtfFt7rijazC8ZoL5oYxM97pHYuyogzEbjj8oh1E7zVbfOhYzTH0Yd
	Ey7a41/ziWsILV0Xo9oV+vwlm9TQ4me57MDZBkwupql29xeQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw3r30ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 03:02:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453322Y2000607
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 03:02:02 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Jun 2024
 20:02:02 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 2 Jun 2024 20:02:01 -0700
Subject: [PATCH] auxdisplay: linedisp: add missing MODULE_DESCRIPTION()
 macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240602-md-drivers-auxdisplay-linedisp-v1-1-9895acebf916@quicinc.com>
X-B4-Tracking: v=1; b=H4sIACkyXWYC/x2NQQqDQAxFryJZNzCGIrVXKV1EJ60BnUpSZUS8e
 8fu/lv893ZwMRWHe7WDyaqun1SgvlTQD5zeghoLAwW6hiYQThGj6SrmyEuO6vPIG46a5NxIXFP
 bBK5vLUGRzCYvzf/A41m4YxfsjFM/nNryWzJO7F8xOI4fE8UEBY8AAAA=
To: Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven
	<geert@linux-m68k.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GaBEuEdD1Hiwk5pJZs7i1szjA3ezSziL
X-Proofpoint-GUID: GaBEuEdD1Hiwk5pJZs7i1szjA3ezSziL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030025

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/line-display.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/auxdisplay/line-display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index e2b546210f8d..83c94e6c4df9 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -388,4 +388,5 @@ void linedisp_unregister(struct linedisp *linedisp)
 }
 EXPORT_SYMBOL_NS_GPL(linedisp_unregister, LINEDISP);
 
+MODULE_DESCRIPTION("Character line display core support");
 MODULE_LICENSE("GPL");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240602-md-drivers-auxdisplay-linedisp-2a12960a1892



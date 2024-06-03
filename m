Return-Path: <linux-kernel+bounces-199692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5768B8D8AEE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105B2286003
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCE513B595;
	Mon,  3 Jun 2024 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RSBFcwka"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226D820ED;
	Mon,  3 Jun 2024 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717446758; cv=none; b=T+ld35P4/ezaLW6rmDSmQ/+/8vnDcXHpfvshZEFBzodN7WhCWZmXmzeJ3z12lxRVL2nWVageNYsBQhI37maIJx3WYU/JPfybzkPhH3g4/tTlh/ntnxGxWSeRmAV0fWJxgeTshxe9Okrhh8y+Gs0/wbqnm9rfOt4gp2r8Ka4KZgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717446758; c=relaxed/simple;
	bh=X75hm9ltweyMS1cu8LE6Cgq3Dy7pnfg504SHwIh2upg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Qq+Xo/7F/E7rxGKotXs567MZiClGu57PqWNNJGl1tKSEAA0vcBOV5bD+n2KH09RmYjmfhROFEoj9WGhY3A3etoqHbHsFxd405wqov01N7uZgxQqBfWnF+QMTweZgkihMgXxfjczf1tBZreby/1RafOj27TochE4UmGOIH+1pP4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RSBFcwka; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453DBsJC018795;
	Mon, 3 Jun 2024 20:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EiLf2hzPOMAHdd39fwXdAK
	2FGVAhEnRWE/CwpvTSL0o=; b=RSBFcwkahyJjuQp6WEJSLJxIoWQHMMP5uzDU5j
	gvfTuFVtt7pVOWOR6oHnGIcg8P2hmBBLzSrY0KyWc6/HXJjVnVvBYI5qXLI9JmsV
	8sFLRBfOUB9wLL8u1L/FhaLZxTf9JeriVSvjAl8xFdAwOB5dZ3eZRPoKkicfqQuc
	PlNQ+yPL5eKbyp0IuQWIU+gonP52CIrL8ioE/zYzP/kuZdjsbeeIRlEYlcPNGsSd
	BkeQjaiSyY24smn4zmPfIaYldOrRyYCF32T4aPAzo8qL+/rdzg7lznG1lihWzWS0
	nE8JvrJD/32Eu/kVpVehCHWCYVzkPq3jZ/f2+P0G4N63jbgg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw4bcwvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 20:32:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453KWWYw028388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 20:32:32 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 13:32:32 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 3 Jun 2024 13:32:29 -0700
Subject: [PATCH] misc: open-dice: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240603-md-misc-open-dice-v1-1-ee7972ae0d39@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAFwoXmYC/x3MwQ6CMAyA4VchPdtkIC7DVzEeylaliStkRUNCe
 Henx+/w/zsYF2GDa7ND4Y+YzFrRnhqIE+mTUVI1dK7rnXdnzAmzWMR5YcUkkXEYiEPoL8G3Hmq
 3FH7I9n/e7tUjGeNYSOP0O71E3xtmspULHMcXic+Bz4IAAAA=
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 482A_X3BFHTar2O1gIJxworbLK__aXu2
X-Proofpoint-GUID: 482A_X3BFHTar2O1gIJxworbLK__aXu2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_16,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406030166

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/misc/open-dice.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/misc/open-dice.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
index 1e3eb2aa44d9..e6a61e6d9427 100644
--- a/drivers/misc/open-dice.c
+++ b/drivers/misc/open-dice.c
@@ -201,5 +201,6 @@ static void __exit open_dice_exit(void)
 module_init(open_dice_init);
 module_exit(open_dice_exit);
 
+MODULE_DESCRIPTION("Driver for Open Profile for DICE.");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("David Brazdil <dbrazdil@google.com>");

---
base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
change-id: 20240603-md-misc-open-dice-99ae88458616



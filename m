Return-Path: <linux-kernel+bounces-196221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04388D58FC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 05:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805FB1F253CF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEED10A16;
	Fri, 31 May 2024 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BQ6nBjLv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E1B38DEC;
	Fri, 31 May 2024 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717125844; cv=none; b=jIEIk3wtysuBuAmXcL+oagcvrH/f1mYNaPPcQecbDkGeGI/Gh1iiJs5uDLQyT/ZkNmlWbvIjNfht8Vjevs8AGtUWUEki/yMqdAtIs1LQ4aKst4oZihfXRXn7orb0+7UOvY9Y9GeFNtjRUS31u19avd7Xdk317jmMtWCTZEcjLuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717125844; c=relaxed/simple;
	bh=UhIrDzGXxaH/4eLKhF+wSTfeSDPdvRTxVsZ2+c6Oy+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Ubalu6KXD1ZyHNxlmPvbLApa7HMxHVz+9SRxSAL/PoYdlX6Y2fYiNqJbD6n1sy+RmGQpUAgHNSV/OIihFByfJTgJf2S00t7VNvQbWIz5yN93rGylQYVOUcZHdLdjDVbf4KK4E9fwxZH2lm+Mxn4+/NmXwo7g8dPxt5jTmOnwtWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BQ6nBjLv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UGdlpN004947;
	Fri, 31 May 2024 03:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QZtDSP74aeLFitfPMT6+TP
	Pem9ghJVk6TDToxbNY/do=; b=BQ6nBjLv53QSRZfGQRd+FEDNriqL+DD6n2WQB2
	uo9x4fV3TdF/IOToFYUX1sQMlTmzm3Mk/bAqG2Mn1NN8dbc2laOsVh+o4aieydkX
	rAHjf2JpXPv+XZ2szpak3y3x/Vnf3WWrHCIjXnCwwcmffcavUcjyErq+zPd5Y6Ie
	oioqFMfrLjnJ0DAwDHUqgOEuSbcb1SzQNoXMj/1Zg+/6DFNKB/hL3pqbGGbZ3vGN
	6j6nD6++Vyl0C+CAqIma4niu4nn0cWmsk1+II6B1M8bKOvjyiz3yWIYzqKE1j1Dd
	C1yL5608TMRjz+0I2NYHHblV8Zyo8FMJNm1UuXQ3aTV25X9g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2pwtr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 03:23:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44V3Nxw8006634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 03:23:59 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 20:23:58 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 30 May 2024 20:23:34 -0700
Subject: [PATCH] cdrom: Add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240530-cdrom-v1-1-51579c5c240a@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALVCWWYC/x3MQQqDQAyF4atI1g2M47jxKqWLmIk1oGNJWhHEu
 3fa5Qf/eye4mIrD0JxgsqvrViraWwM8U3kKaq6GGGIKfReQs20r9qnjzFNsMyWo7ctk0uP/c39
 Uj+SCo1Hh+bdetHwOXMnfYnBdX8Yc25R2AAAA
To: Phillip Potter <phil@philpotter.co.uk>, Jens Axboe <axboe@kernel.dk>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jNWqRU5lj_obl9MbM_Lo2Srzlzs7C1jX
X-Proofpoint-ORIG-GUID: jNWqRU5lj_obl9MbM_Lo2Srzlzs7C1jX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1011 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 mlxlogscore=927
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310024

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cdrom/cdrom.o

Add the missing MODULE_DESCRIPTION() macro invocation.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/cdrom/cdrom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 20c90ebb3a3f..b6ee9ae36653 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3708,4 +3708,5 @@ static void __exit cdrom_exit(void)
 
 module_init(cdrom_init);
 module_exit(cdrom_exit);
+MODULE_DESCRIPTION("Uniform CD-ROM driver for Linux");
 MODULE_LICENSE("GPL");

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240530-cdrom-543cdcf21da4



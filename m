Return-Path: <linux-kernel+bounces-197647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A45F8D6D7A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 04:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7BB1C2182F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD50A94C;
	Sat,  1 Jun 2024 02:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R37VePvj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A119D28EF;
	Sat,  1 Jun 2024 02:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717208356; cv=none; b=AcyeMDn7K1k516ZVBuvnVmQsHLfMSQFweAoqoq6HDP1PeNC/hpncAwCLcaHyFj8faptyABBqHhD3JyXLLF+wMsueyRsDPxq/kTxCVFAMW1nJARVSFYN4W0WGScdM5RjVVgovlAXYszgDUzNlozic47+Xd0n6kdGYw0W0XRhertE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717208356; c=relaxed/simple;
	bh=8ur2zc+OEDENtUKwIHOFRIlJwWguR4YulroiHs38vts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=TKoUvyAnHeHx5K5jb2arJ8d6K1TISekQiYe3xxsUoS/ZOdriO0FImGjrc59mTQrc7fqlvli6Gi29XZhkOWeNyJo50E80FXe/tjXfCz1wL9ERY2ikWI0IwtAgjhGsxAaM/NjXVzUs+LNTwaKYRp0LZ8x//HBWFouu/s+slvYP6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R37VePvj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4510u8sZ015221;
	Sat, 1 Jun 2024 02:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lY9enypKCpnkmM70ZqEsHq
	AwUZafgNa5e1kgI9Ke9Uk=; b=R37VePvjDdgmKlX7PV9+bz/gIGIMIs7TOnYJIs
	S5s+bKWARE5Ykm9iGL+iU9HO4DPXRzRhGZW9pcD9j0Jtr2odsclEnGI0Wo9B41OY
	bp+ux4/0YnL9p887vkoq1pMXuHbYLYk/mTZag9C3jG95Lx9yNQ4b6RR21/x4LOyR
	BDCMnCYiUj9TwxvKoKeWNgJiAhBRlginO3VJ7kD673sHockh55G5fXBt2v+ak90x
	iryohGdzxmHd3NSONWP9PHmNPPlLSN4LdRQzwkhTd538+CVLGc1HN29wGREMke/p
	sJGzc4SyP8sleOhL7U71aPcPwk6iDTIQ9Xns53juwZQSYkAA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfa9bjknb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jun 2024 02:19:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4512JA9m003709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jun 2024 02:19:10 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 19:19:10 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 31 May 2024 19:19:09 -0700
Subject: [PATCH] uuid: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240531-md-lib-test_uuid-v1-1-67fa498104c0@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAByFWmYC/x3M0QrCMAxA0V8ZeTawRivir4iMdI0usFVpWhmM/
 bvVx/Nw7wYmWcXg2m2Q5aOmr9TgDh2ME6enoMZmoJ5OvT86XCLOGrCIlaFWjXgmupD37CIxtOy
 d5aHrf3m7Nwc2wZA5jdNvNGuqKy5sRTLs+xcrOXXpgQAAAA==
To: Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kw6emUY5m1sr0mCbzkZb8ZCEcrqngINK
X-Proofpoint-GUID: kw6emUY5m1sr0mCbzkZb8ZCEcrqngINK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_01,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406010015

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_uuid.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 lib/test_uuid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_uuid.c b/lib/test_uuid.c
index cd819c397dc7..0124fad5d72c 100644
--- a/lib/test_uuid.c
+++ b/lib/test_uuid.c
@@ -130,4 +130,5 @@ static void __exit test_uuid_exit(void)
 module_exit(test_uuid_exit);
 
 MODULE_AUTHOR("Andy Shevchenko <andriy.shevchenko@linux.intel.com>");
+MODULE_DESCRIPTION("Test cases for lib/uuid.c module");
 MODULE_LICENSE("Dual BSD/GPL");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240531-md-lib-test_uuid-6228255a1d2a



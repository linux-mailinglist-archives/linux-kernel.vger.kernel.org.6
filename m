Return-Path: <linux-kernel+bounces-175896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528878C26BF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0773A1F210F8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8D2170844;
	Fri, 10 May 2024 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NMxYQ0mO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5221212D1EB;
	Fri, 10 May 2024 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351048; cv=none; b=D8N56fSR6L5Fe42WobuSvcRbJacmw7b1m76XGWYxdJegAeZvwGRR+TOwKS8SyRtzHYE4jwt3jHHsKz4S4uQvNurNYLK2gn6mv1Egjl+TYAPSce/4K+1jqHBH1Apwx4OWiOfdH8hcLXm2X1pIV0RrLge3PLnivmjhqTSX6lTQY2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351048; c=relaxed/simple;
	bh=c/JCSSt35mbjMJ//E+sxG04fSIhKxLeG+9OlxBi7444=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=AAIdKXOmaG9EZnNOwC6J535UBSPRXhfpfB5L73z0HgJi0Wbb2OmAfPpFUQ1ofaeI5bgrgGuz44YXmZmP4NqhW4g1Z63fMPV0DhSVtsICz+qvX9FzWk7iEduD+dAZVkIUxVP9kQFFdN9x6Vjkcr29jTG8lXdK/LDllyTnxDSUA0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NMxYQ0mO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A2tjZE009522;
	Fri, 10 May 2024 14:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=aBt
	pUrTb6nW56PWpG40EJQXJ+qbrHBCgV+FF0VYkQsI=; b=NMxYQ0mOHv2/HdRRijd
	/8XbIbkAgPv8FKIPUgSjLNFWRf4fhAzTxyX7eG1GBTde820Db9+epZZwPO7HhO6L
	e/kQTI2rI1YazoZxKOFSh+O1p9v0h8SScZRfUSWUr8OUw5MVSJ6dV1xm8A0p4tmD
	eao8PBMOuTePgVTURz3UZYorO6VL9vdtxAdjDmQVo4Vj2nz20B+ijLCGZSuGpV9y
	b2tSPc7Ju1HDrids1QIFyy7Z7Pp3yPgGc9CL0YjdSMyIiEwTXc3yrny4FoBXnIY5
	STcrk69RGB/tidHDJhAJ4IJ96Z9U30oCmgCpn21i3MGnmsBIAyHmsCwMiWS3podK
	hkg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w29qfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 14:24:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44AEO48v013886
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 14:24:05 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 07:24:04 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 10 May 2024 07:24:03 -0700
Subject: [PATCH] dca: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240510-dca-md-v1-1-d532a0757090@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAIuPmYC/x3M0QrCMAyF4VcZuTbQ1SrVV5FdZG22BVyVZJPB2
 LtbvfzgP2cHYxU2uDc7KH/E5FUq2lMDaaIyMkquBu98cJfWYU6Ec8ZzDNHH6y2FHKDGb+VBtv/
 Ro6vuyRh7pZKm3/wpZd1wJltY4Ti+aefQ5ncAAAA=
To: <kernel-janitors@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: a9HDPPXYZwzHC0YNudcJtLaADvbNs81x
X-Proofpoint-ORIG-GUID: a9HDPPXYZwzHC0YNudcJtLaADvbNs81x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_10,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=864
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100102

Fix the make W=1 warning:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dca/dca.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/dca/dca-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dca/dca-core.c b/drivers/dca/dca-core.c
index ed3dac546dd6..f5cedf816be1 100644
--- a/drivers/dca/dca-core.c
+++ b/drivers/dca/dca-core.c
@@ -17,6 +17,7 @@
 #define DCA_VERSION "1.12.1"
 
 MODULE_VERSION(DCA_VERSION);
+MODULE_DESCRIPTION("Intel Direct Cache Access (DCA) service module");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Intel Corporation");
 

---
base-commit: dd5a440a31fae6e459c0d6271dddd62825505361
change-id: 20240510-dca-md-38482869c4d4



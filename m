Return-Path: <linux-kernel+bounces-216024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81079909A09
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 23:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A6FC2838FE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 21:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0B461FFB;
	Sat, 15 Jun 2024 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WrgK9Fck"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230D01849;
	Sat, 15 Jun 2024 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718487856; cv=none; b=f7117nOfUOQ5DEsHQzuc8g0mmTefHy2i8DX9//9wuSGuaTryOp3EHYbN0px7j8HTftRQnHHRsgYGjZPzfu4DNZdwjOR8WftcwJv6MTy2SosTZwyMtfWLpk68WOP6ZjMVs2OoUxPSBka5PCcxmsSVhsfsZIQ+wT17oLAuEUrIRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718487856; c=relaxed/simple;
	bh=u0DMDt+qSvdt9AbW6+WiVBNtZDTS5qiFqJKVLkrzav0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=eF9+oSp4wCavXNYNdB0TjPknIC9v7bo3V5qeAD1GD3Z9+KV1fkY+tjrgMGleZvsRq6LBqyl842YhqqB4G8/jAUinbm3XNfZSduQPsDMk+A06u9FKJIXRG5QuHfGiaNwwXUU3pKN6yVxCGtpP4+qJ+k/mUmn1wA4PoMMZboniiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WrgK9Fck; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45FKg5U9022360;
	Sat, 15 Jun 2024 21:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=smP/z+dSjtIA182ewbRcBP
	3e4jmTbezHzi/Qy/YIa5Y=; b=WrgK9FcknuTWMZdn2/U4q5e10n+ZUZMCmv5Daw
	QsaPFtOSaB4CM33F/1L5DQ3QMBx0b8Pqg9bTEf2Gio3SS8S2dj34doGhRmtSrNHu
	fLsrMP7axGpMYRVX93kxFn7bNZDl/HMpjJs7AFbFF2q7eWFxpaH5Pfsd4Y79kNgo
	+fbLD9HKf4GKrZi5wY3FlESDX2NL1h6cpStIInGPyN1eOE//4Jxi+QX9hqM+vYzb
	bnxVdn49Q+9gZo1qXRdpTIble8EC5zja75siPGo1cglnHFAxM5K0ApVpJQe7sp9p
	TuZTc6IKxEweoSwjJUBvOtfd6wQYjRHnAECLgtJGxqkV9m4w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys36393a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 21:44:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45FLiBbI014858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2024 21:44:11 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 15 Jun
 2024 14:44:11 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 15 Jun 2024 14:44:08 -0700
Subject: [PATCH v2] dca: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240615-dca-md-v2-1-c4062275a3f1@quicinc.com>
X-B4-Tracking: v=1; b=H4sIACcLbmYC/2WNQQ6CMBBFr0Jm7Zi2FAFX3sOwKO0ok0jRFgiGc
 HcLW5cvef+/FSIFpgjXbIVAM0cefAJ1ysB2xj8J2SUGJZQWhRTorMHeYV7pSlWX2mqnIcnvQA9
 ejqN7k7g1kbANxttun7/YTwv2Jo4Udr3jOA7he2RnuY/+CrNEia7IlRFlUYpa3D4TW/b2bIcem
 m3bfscFSKm9AAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton
	<akpm@linux-foundation.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ic_4yd3_kK9301itXE9t8dU5tEPkScU6
X-Proofpoint-ORIG-GUID: Ic_4yd3_kK9301itXE9t8dU5tEPkScU6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-15_15,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406150165

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dca/dca.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Rebased to v6.10-rc3
- Updated commit text to use a more recent boilerplate
- Since there are no matching entries in MAINTAINERS, added Andrew & Greg
  to see if this can go through one of their misc trees
- Link to v1: https://lore.kernel.org/r/20240510-dca-md-v1-1-d532a0757090@quicinc.com
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
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240510-dca-md-38482869c4d4



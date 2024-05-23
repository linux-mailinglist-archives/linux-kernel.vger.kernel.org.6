Return-Path: <linux-kernel+bounces-188116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 174048CDDAF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 01:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D781F2275D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23830129E92;
	Thu, 23 May 2024 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kjOtTJJE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B42129E78;
	Thu, 23 May 2024 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716506572; cv=none; b=jyFNKUWbnblQRd3x53NnUXHKBs8bIYcumnwHcDYVnqse0mLfZI5EgryoBvbvSI3PHmAxyTZiN8gOd36LoWWQ9PsD61GL7ACp/LidsXvP/EzsclI7nD/m065QehZm8EsE575JITD5M4WWn6pgzf5q0Fe5/mcLtxxT0m+ugEFGnqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716506572; c=relaxed/simple;
	bh=OLXX2LxJlZ5Ny/3fQeOWJvdMWznXzudiOcGh4kVBmRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Dy40IFCCS3J1Aonbo5v0cM/uOs8UB8CbJMPOTZyhfDvxoL4zcRqCEq0aFZwELzGtmUbAheTtO9kv5uZsxPy5bNY5T/EHWZO6Ee1fk2Q2z6j98RW72upoqecc0YSkf/pvwUm1lFbr95ciNdw/yjvJEiq5w0p+8rxDGPXZT3NXJ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kjOtTJJE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NNJbuO029560;
	Thu, 23 May 2024 23:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EOM4CsCYqg5acNEKpbY5mZ
	cQ8K+iIvTv5UvVK50XzZw=; b=kjOtTJJEfej48fGOFdbmFZGUqL1df4xiz5gZtS
	v/NMJwoONC6A/PGTB1rTXfk8a55hEeGPuZNKNF/xvXHyQV1pGJM529SPtFxATPMJ
	832qK02v89+bhkDMm9M1+F7nFNUCEcJORP0prlSJwSug1E/ebnNTY185SIQB9v4o
	4LG+RMH+Cc5qNgTG1X3hrlBTyljV1bvxRsHdQHf8zyZcVRyNCFi2A/HH/CHgvccP
	y0sFhBBjDtFFUcNJIKkEAKzVdocfyC5G7wwloMiGJoF0Ss8aY6tfrwVVLdRdQ5Nx
	yJ2BwK8NOBfH5QYZ9kmoYZVkQHkLqgLEqWiSfGfhsksmNhow==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa8k0n3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 23:22:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44NNMZqP014960
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 23:22:35 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 May
 2024 16:22:35 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 23 May 2024 16:22:34 -0700
Subject: [PATCH] firewire: add missing MODULE_DESCRIPTION() to test modules
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240523-md-firewire-uapi-test-v1-1-6be5adcc3aed@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALnPT2YC/x2MQQrCMBBFr1Jm7UBaFapXEReTZmIHbAyZtFZK7
 +7o4i8e/Pc2UC7CCtdmg8KLqLySQXtoYBgpPRglGEPnupM7d0ecAkYp/LbhTFmwslZ0ffSOLtz
 2gcHcXDjK+u/e7saelNEXSsP4qz0lzStOpJUL5o9dYd+/ZxLfzowAAAA=
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
CC: <linux1394-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TJV6-wRw29BO6wRTBrWepdbvrxpI07hU
X-Proofpoint-GUID: TJV6-wRw29BO6wRTBrWepdbvrxpI07hU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_13,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=981 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405230161

Fix the 'make W=1' warnings:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firewire/uapi-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firewire/packet-serdes-test.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/firewire/packet-serdes-test.c | 1 +
 drivers/firewire/uapi-test.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/firewire/packet-serdes-test.c b/drivers/firewire/packet-serdes-test.c
index f93c966e794d..e83b1fece780 100644
--- a/drivers/firewire/packet-serdes-test.c
+++ b/drivers/firewire/packet-serdes-test.c
@@ -579,4 +579,5 @@ static struct kunit_suite packet_serdes_test_suite = {
 };
 kunit_test_suite(packet_serdes_test_suite);
 
+MODULE_DESCRIPTION("FireWire packet serialization/deserialization unit test suite");
 MODULE_LICENSE("GPL");
diff --git a/drivers/firewire/uapi-test.c b/drivers/firewire/uapi-test.c
index 2fcbede4fab1..bc3f10a2e516 100644
--- a/drivers/firewire/uapi-test.c
+++ b/drivers/firewire/uapi-test.c
@@ -86,4 +86,5 @@ static struct kunit_suite structure_layout_test_suite = {
 };
 kunit_test_suite(structure_layout_test_suite);
 
+MODULE_DESCRIPTION("FireWire UAPI unit test suite");
 MODULE_LICENSE("GPL");

---
base-commit: 5c4069234f68372e80e4edfcce260e81fd9da007
change-id: 20240523-md-firewire-uapi-test-08fb0a9e18de



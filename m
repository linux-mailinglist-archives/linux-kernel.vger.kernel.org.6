Return-Path: <linux-kernel+bounces-210782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19927904898
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C201E1F23BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556D1D29B;
	Wed, 12 Jun 2024 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IaV9SEyl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1913E4696;
	Wed, 12 Jun 2024 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718157259; cv=none; b=SWTmTGdVVi9zdpoKybQ4tkWFpyo5DvkTv6S+qM/6PVHEh++r4pjrhb4/aLZUr13+Ml027PsNVRFOVcviJZnk3uwi3qthPR0RxZ7iPXK6AZL7jFn4LQvqrb1ddId1nroA/dPJjmhgqtLvsFxl4AAShnxLCi5o+v9WS0GkpRuUOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718157259; c=relaxed/simple;
	bh=qEP1jfUnLDqKY+Tbv7jWMRIeP29xqp5aif0Wikh853o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=VciAf8PgYMRg6AvktxQhdQD14BtHjUb7v/LDPTLphp/h5aI31aTaK1GgnZpINKo5BkcyYe4AdbEcjElhNymiOaku903t+QOsaNE1HkykreoLq12PvBYj892Ivbr0E0FCYNSiaLekWmu0bgOdWE4P539luVqE3f0SOHfxhrdVkz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IaV9SEyl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFD0TR031044;
	Wed, 12 Jun 2024 01:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dEliYOecfFwvzvpruyOir3
	lcTsdZk5RA15G2wEuI1WA=; b=IaV9SEylu7NSFXZfhs2n4RO2fkhanhD6kofAJS
	L4umGZBIrLvYNKxlr/XLfKNXifOPSEkBihNiFLA5eYxZSpg3wSDdBAvKoY2Wjpjs
	Z88/lrpPu3N32r0dOfu5dWABaOQvt2Q18AuNIV4X2kqpsEFoJhtUL387IkNMheFR
	nupel6Yg7nZ5Tv/p4VjhmDnrhKFSVKw17pg3rPks7Gb5R+UgU7H743LMSfDM/4Lf
	JRFF8oB3DeNvFPqm1d/tSs0ZyPt4Ssn0fqn1Ndiw10CJOLFa+lWDqU0fHIov0FPh
	GHy71gpsg2P9P6Tx9e0FwSr7frKz8Gzx81efVgPZPrbSJ6vw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymcnmytwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 01:54:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45C1sCPI026977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 01:54:12 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 18:54:12 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 11 Jun 2024 18:54:11 -0700
Subject: [PATCH] usb: common: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240611-md-drivers-usb-common-v1-1-f81555b0bd0d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAML/aGYC/x3MwQrCMAyA4VcZORtoi1P0VcRD2kYXsK0kbgzG3
 t3q8Tv8/wbGKmxwHTZQXsSk1Q5/GCBNVJ+MkrshuHB0J++xZMwqC6vhbBFTK6VVHMMYHF/OkVy
 E3r6VH7L+v7d7dyRjjEo1Tb/bS+q8YiH7sMK+fwHJzxW9hgAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen
	<peter.chen@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sX6MLW-0Ze7QD44XD6xCn93IH3hZr5T7
X-Proofpoint-ORIG-GUID: sX6MLW-0Ze7QD44XD6xCn93IH3hZr5T7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_13,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1011 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=797 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120010

With ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/common/usb-common.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/common/usb-otg-fsm.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/usb/common/common.c      | 1 +
 drivers/usb/common/usb-otg-fsm.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index b84efae26e15..59b55d6cf490 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -433,4 +433,5 @@ static void __exit usb_common_exit(void)
 subsys_initcall(usb_common_init);
 module_exit(usb_common_exit);
 
+MODULE_DESCRIPTION("Common code for host and device side USB");
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
index 0697fde51d00..e11803225775 100644
--- a/drivers/usb/common/usb-otg-fsm.c
+++ b/drivers/usb/common/usb-otg-fsm.c
@@ -449,4 +449,5 @@ int otg_statemachine(struct otg_fsm *fsm)
 	return fsm->state_changed;
 }
 EXPORT_SYMBOL_GPL(otg_statemachine);
+MODULE_DESCRIPTION("OTG Finite State Machine");
 MODULE_LICENSE("GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240611-md-drivers-usb-common-52520e97ba0b



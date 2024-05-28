Return-Path: <linux-kernel+bounces-193015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09D98D259B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF891C21FB1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD5713541F;
	Tue, 28 May 2024 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dloYGoFa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1D2FB2;
	Tue, 28 May 2024 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716927399; cv=none; b=k0jgnLxOVdtoJ2qnpsXdL4IkQngZkaTFRDhnhQ/gsoyNwZ6cYdy+vbK4wzm7bE95kA69Du/CXd8ybki3WG2re9zZPoBXsVaPA9nsX4Gb56HerGGU3qwVTabeTllrGgH1aNt1EWsRINNruu2VlVSIo/rF3mm2hj5g5z/DewD07Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716927399; c=relaxed/simple;
	bh=GcNMq6yrtNxIflFHLG4vacUarHXbKyb30L56JVugDhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=rpxekymyyq8Bp7cR1pGFrUAOQQ8XhnBbANneU7iHgDIcAcr4cqnJGpaK6FaICmnRq6PXZtH3UBp1jeyLX11ZEXF8GzR7Wp44FJQQadXMSsMvI0dtPaLV439FPyO3E001oINEHalu0NxjeKOriUSINB12H0fEKRo3zkHso74gPTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dloYGoFa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SAudx8005296;
	Tue, 28 May 2024 20:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gWfH+6JxRoULJbUSX497F6
	vfBHDLo8b/NgwKTjgWHfE=; b=dloYGoFa5Flr8gxMC5qHNf7UtM9iEGS0ebCiPg
	GvVegMPQ2pVO3PO7km5xTeesDO2mK8Ngawm6h5UqNmW+66Na59w85fooj79kBQf9
	6Ki7JJF78+DgRK6WxLcE2IS2IQmhOLwtRhlxaLHAHeR4OCuE3IVVjIC9jSQdW3Uc
	y9zKVNoaJjWWap0ZKwrUPEL669K9HpVxf2SwU+kHZRd6/8xpeDYtQFWuAbAU2SIZ
	SEKaCFQGflx1AvQrNVb0JEWbgDHQmh4wuaZkHqvnzwuPvROGKp6H7mfqcHiJTncE
	1WuvTI4t7hom6RADPMf64p0LR90+tEbe5M7wc5Biyk++k54w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2h788r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 20:16:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44SKGP4U002387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 20:16:25 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 May
 2024 13:16:25 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 28 May 2024 13:16:24 -0700
Subject: [PATCH v2] locking/ww_mutex/test: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240528-md-test-ww_mutex-v2-1-a2a19e920b12@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJc7VmYC/32OXQqDMBCEryJ57hYTU5E+9R5Fiq5rXWiiTeIf4
 t0bPUAfP5hvZjbhyTF5cU824Whiz72NoC6JwK6ybwJuIguVKp3elAbTQCAfYJ5fZgy0AMoCVZ7
 VqItMRG1w1PJyVj7LyHXlCWpXWeyOog/bcQFT+UAOhjVGD6ljH3q3njcmeah/FicJEnRbFyjTv
 CUlH9+RkS1esTei3Pf9B/4WshTXAAAA
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
        Boqun Feng
	<boqun.feng@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -xH1rxlkXjq_d06AAfqCKvVrxVVM9xSl
X-Proofpoint-ORIG-GUID: -xH1rxlkXjq_d06AAfqCKvVrxVVM9xSl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=803 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280151

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Moved the MODULE_DESCRIPTION() after MODULE_AUTHOR()
- Link to v1: https://lore.kernel.org/r/20240524-md-test-ww_mutex-v1-1-4fb8c106fe21@quicinc.com
---
 kernel/locking/test-ww_mutex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 78719e1ef1b1..10a5736a21c2 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -697,3 +697,4 @@ module_exit(test_ww_mutex_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("API test facility for ww_mutexes");

---
base-commit: 07506d1011521a4a0deec1c69721c7405c40049b
change-id: 20240524-md-test-ww_mutex-c18c263bc483



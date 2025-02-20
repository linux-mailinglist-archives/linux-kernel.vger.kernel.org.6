Return-Path: <linux-kernel+bounces-523316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB39A3D501
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84E257A5654
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F7E1F03D9;
	Thu, 20 Feb 2025 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZWgqL5yH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC21E9B36
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044533; cv=none; b=TExOBMAc+PkKY0sxfswEAhI33xaYcscbJLEDllHgHJqG8iS2gLtRiel7y+uR1KKdRccUy74xRx1yH/JC7PlD8p7X9BzyN2rXHH1dnWmW15vaVv05ZgpPKj9tk61VLUEsA/RkzV2pNO6fwRhUia+/QaxWnb1gEuwSl/6ZtgVroig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044533; c=relaxed/simple;
	bh=rChncOtg0mnw9AqVWObnAr5EAgepiFacUpox0dBd+Fs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ABfASpGCHjcvQp+jj83pEOJwDE3JKgSfYA1le/HGlFCxlh2Ns11vSDot6wpvdvjj8fkGfe6aGZLOTF0z5J2c9OsbparsOeirrzR+0olq14xeRuujw6VzsVCuXJHo4FDDc2ILDVvE3muOfrugFtCepsBVTiu8TAF2hZkV2Q/+FRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZWgqL5yH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6ewSt014973;
	Thu, 20 Feb 2025 09:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VfpJvRD9QaopNkfQklaUs3
	pO73GIB0PfsxYTdpdK/Mc=; b=ZWgqL5yHLn0fz+gK7P4sak8i5q6X57FyEq7wD8
	bLDqaj7/SVvqOZXh5ewRHUTvcuYUW/P7yvs/j9tkMfWIXdEKQw51Q6j9SZPUEmXv
	KWLSnoeu3HsbLMUUZsqvZ5CV920Wz6zh6l1GXdttyiDhhcqaMp1fbsiwc0aXCzYL
	kqHklkhHEYSLuv3cPT39VjKuVWDFkU/BPNealtUEjJudn1r9+yUe2u3sEhPqZI3E
	FS0NNyN0mzZozfaKu9ussw04pghdJUNDmWUlElyXetGuXFm2+eW9tKQAacvHcX8l
	csEq79vAcFcBPpzSdw/tZ5CGFYzNxVSmhV375z9MOd6FiXtw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy15kt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:42:00 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K9fxRK014047
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:41:59 GMT
Received: from yuanfang4-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Feb 2025 01:41:54 -0800
From: Yuanfang Zhang <quic_yuanfang@quicinc.com>
Subject: [PATCH 0/5] coresight: Add Coresight Trace NOC driver
Date: Thu, 20 Feb 2025 17:41:20 +0800
Message-ID: <20250220-trace-noc-driver-v1-0-15d78bd48e12@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMH4tmcC/x3MTQqAIBBA4avIrBtISfq5SrQQHWs2FmNIEN49a
 fkt3nshkzBlWNQLQoUzn6lBdwr84dJOyKEZTG9sb7TBW5wnTKfHIFxIcKbRhnHSeogOWnYJRX7
 +5brV+gEAUMmZYgAAAA==
X-Change-ID: 20250212-trace-noc-driver-9e75d78114fa
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>
CC: <kernel@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740044513; l=3442;
 i=quic_yuanfang@quicinc.com; s=20241209; h=from:subject:message-id;
 bh=rChncOtg0mnw9AqVWObnAr5EAgepiFacUpox0dBd+Fs=;
 b=fwJHywpBov/tTCZnx/SMPba0s3hUQU5hbdWZ5i7ciTSJSEI4KqjfVQJkHMNb73HNUJYi4bLd9
 Sxm6CcV9DaXCygbcMLKAQTV7Zh9c6fHQmUpQND6oJo2jiPtFPVOXs0T
X-Developer-Key: i=quic_yuanfang@quicinc.com; a=ed25519;
 pk=ZrIjRVq9LN8/zCQGbDEwrZK/sfnVjwQ2elyEZAOaV1Q=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1NST2Js7Ik9nZIuKBQ2XdtCNEriUiruF
X-Proofpoint-ORIG-GUID: 1NST2Js7Ik9nZIuKBQ2XdtCNEriUiruF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502200070

The Trace NoC is an integration hierarchy which is a replacement of
Dragonlink configuration. It brings together debug component like TPDA,
funnel and interconnect Trace Noc which collects trace from subsystems
and transfers to QDSS sink.

Compared to DL, it has the following advantages:
1. Reduce wires between subsystems.
2. Continue cleaning the infrastructure.
3. Reduce Data overhead by transporting raw data from source to target.

    +--------------+                                         +-------------+     
    | SDCC5 TPDM   |                                         |  SDCC5 TPDM |     
    +--------------+                                         +-------------+     
           |                                                        |            
           |                                                        |            
+----------|-------------------+                                    |            
|          v                   |                                    |            
|  +----v----+     Dragon Link |                                    v            
|  |DLNT TPDA|     North       |                         +----------------------+
|  +---------+                 |                         |    TRACE NOC AG      |
|       |                      |                         |                      |
|       v-------------+        |                         +----------------------+
|                     |        |                                   |             
|              +------v-----+  |                                   |             
|              | DLNT Funnel|  |                                   |             
|              +------------+  |                                   |             
|                   |          |                                   |             
+-------------------|----------+                                   |             
              <-----+                                              |             
             |                                                     |             
             |                                                     |             
             v                                                     v             
    +----------------+                                      +---------------+    
    |     QDSS       |                                      |    QDSS       |    
    +----------------+                                      +---------------+
    

Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
---
Yuanfang Zhang (5):
      dt-bindings: arm: Add Coresight device Trace NOC definition
      coresight: add coresight Trace NOC driver
      coresight-tnoc: add nodes to configure flush
      coresight-tnoc: add node to configure flag type
      coresight-tnoc: add nodes to configure freq packet

 .../bindings/arm/qcom,coresight-tnoc.yaml          | 107 ++++++
 drivers/hwtracing/coresight/Kconfig                |  10 +
 drivers/hwtracing/coresight/Makefile               |   1 +
 drivers/hwtracing/coresight/coresight-tnoc.c       | 401 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tnoc.h       |  57 +++
 5 files changed, 576 insertions(+)
---
base-commit: 92514ef226f511f2ca1fb1b8752966097518edc0
change-id: 20250212-trace-noc-driver-9e75d78114fa

Best regards,
-- 
Yuanfang Zhang <quic_yuanfang@quicinc.com>



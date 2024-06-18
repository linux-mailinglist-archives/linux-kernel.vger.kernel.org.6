Return-Path: <linux-kernel+bounces-218643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCAA90C305
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA22284E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1A41C286;
	Tue, 18 Jun 2024 05:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JRUv03Of"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3D617C8;
	Tue, 18 Jun 2024 05:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718687768; cv=none; b=B/qlfr7xuJ2pX0jdqiCe0U8lebRYWeNfewFOFWMf65EkOnsdblMgE4t+3pOzxix7+IxS7wzwYL9JKXotHF+gZwJVe1idpHUODPRaP8NC7aGHrGBrK1HYo3NF08JL10Xe9TkLR0Bj5v4Hxgq+pKKDajCYWaiC9UzqWuQ4uXjlZys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718687768; c=relaxed/simple;
	bh=JFuaEL0i5O+a1x7snaYcxyqNALKR5Ngkjb5nlZpxD0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=lXEzfYsRzRkFAqxFfG636Gh1TZag0zcJ6VWhkFwp16Oj0Lgk1A2u9JJ5O+SDWMGtI0HmaiTOB2MtokS4LqNMNRGC4TKPYgmpGvJsrKUUQT5O/8yN7T1v+evEHru5M/1MiqVOAtDdcBe3fumG9nkFHa3yU57JWutmlE7PzojPqeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JRUv03Of; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I38H20019454;
	Tue, 18 Jun 2024 05:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TNTw+Ygvej0cWOhb6Ygm6e
	kDY8ur0ZnUwnkQN2wPkyI=; b=JRUv03OfooJ9bbLHgUbOlE2sJ8pAijXdDllpt2
	FIBp2+TukyUTD31rLp2yxuPY/WL+1HO/fY2zAgQZzQ9OnIioqusvDbeKYCXZN33K
	ELHOUFuTF3td/pknOLN3K0mfIhXZxKBtG4nFtq7QifvwXcnjkM/1wpaAgrNGxMkK
	52IWOD3zqtLTgANaHTn83LlAygn/+J8M+iNw7LA8x3To9os2BLhnaZ5VcwxOBIrX
	VbOG2x2+CBpqhIZZq0HeV/hvbbD+TtJ/u3xdmy77bM+pQpuyp9SZMOfMIPyAyNeH
	cKmtaAKbU0gDOQxDpD6EAvqTyLAezkNN5qS1d0dreaC0QGyQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yu22gr761-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 05:16:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45I5FxSk016528
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 05:15:59 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 22:15:59 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 17 Jun 2024 22:15:56 -0700
Subject: [PATCH] dtlk: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-md-m68k-drivers-char-dtlk-v1-1-a53a237f1f06@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAsYcWYC/x3Myw6CMBCF4Vchs3YSWg1WX8Ww6GWQCbSaGSQkh
 He3uvySc/4dlIRJ4d7sILSy8qtUmFMDcfTlScipGmxrL21nrpgT5s5NmIRXEsW6EkzLPOGtOw/
 WRUMuBaj/t9DA27/96KuDV8IgvsTxV5y5fDbMXhcSOI4vCjxJV4oAAAA=
To: "James R. Van Zandt" <jrv@vanzandt.mv.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <blinux-list@redhat.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: h0JKSCpyjTmy0Mj6txXhvZoAGjVHT_nM
X-Proofpoint-GUID: h0JKSCpyjTmy0Mj6txXhvZoAGjVHT_nM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 mlxlogscore=874 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180037

With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/dtlk.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/char/dtlk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/dtlk.c b/drivers/char/dtlk.c
index 6946c1cad9f6..5a1a73310e97 100644
--- a/drivers/char/dtlk.c
+++ b/drivers/char/dtlk.c
@@ -660,4 +660,5 @@ static char dtlk_write_tts(char ch)
 	return 0;
 }
 
+MODULE_DESCRIPTION("RC Systems DoubleTalk PC speech card driver");
 MODULE_LICENSE("GPL");

---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240617-md-m68k-drivers-char-dtlk-963f28c1e8db



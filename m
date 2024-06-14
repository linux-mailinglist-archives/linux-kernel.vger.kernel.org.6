Return-Path: <linux-kernel+bounces-214340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A50908300
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77F71F23681
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB06D146D73;
	Fri, 14 Jun 2024 04:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kgG2qMSw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B432D145323;
	Fri, 14 Jun 2024 04:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718340001; cv=none; b=ToPYpsu9rB/RXGaYVEoTqlaYQb7BqwwM8SBPD2QC3rJcRyAGRRmCSr47rOrqhEfT5GjQ94KwrHF1T/YwEfNY/DPaEApc/QbReuoSyqobyKEt3SewA7Dtz5q1uPcbibJlzGNIkOatly7yPjavYLW/sXTY8X4LswZctwZnbZ2pUg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718340001; c=relaxed/simple;
	bh=yN1wVzgzD893y5hYpLKsGUjCi2JdRc+fHzFDmufqcVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=TQ60KeMrrRX2wkewZZvjEgM/6v9URe64AtDNl3c5XsixSjsvN+Y5JnpFkwTjTWzHR/NORInGAjkPLfdpSGhr46G1+e1vojfDSy1nalG+XLLM4xZTZdUmpvyPkyyI4uJoKXUfpjuEwqDcidYRr31YqoyovyK+wRjr2IIGvim+sPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kgG2qMSw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DJGKjg009889;
	Fri, 14 Jun 2024 04:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cg7s+ByQqdkCmelxlg057w
	Dqd+vhqXOWX+YIk1o2HL0=; b=kgG2qMSw30iAPOMXhxX8wH1NP/07oYzvK9LymO
	9SRkXYn8wIRggRoG8bke0Pb/qgvi9uy0IUPNV4XvVZko6oQ07NezUueUz3NKjjeG
	bh66XiqDhqIrV5pyQn/yD8JK/kcs0A97TiA0+wOzeZ36rybDLHJP5wEyaR8yD6XS
	ghVZ9ztRyciur5+S50UjqYReLQcsNfy51oHB8yrNqF5OrNhSEgiLH2PDNe0faQHT
	QzSKk81iL9isGxxq1jW+pRom1QTUszz4EnVO1NFixDptGyoDBTc76kC0Yf5zgJD0
	RmAEYIC/VnGdn32SDMYJgCAnjsldhU5YceB+XYyVmoPcS8Fw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yr6q3h0uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 04:39:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45E4di2t024751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 04:39:44 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 21:39:44 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 13 Jun 2024 21:39:42 -0700
Subject: [PATCH] pstore: platform: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240613-md-csky-fs-pstore-v1-1-c525f636b1cb@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAI3Ja2YC/x3MTQ6CQAxA4auQrm3Cz4DRqxgWnZkijTKQFg2Gc
 HdHl9/ivR2MVdjgWuyg/BaTOWVUpwLCSOnOKDEb6rJ2ZVc1OEUM9vjgYLjYOitj46l1Lp679kK
 Qu0V5kO3/vPXZnozRK6Uw/k5PSa8NJ7KVFY7jCzZUgBqCAAAA
To: Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme
 G. Piccoli" <gpiccoli@igalia.com>,
        Guo Ren <guoren@kernel.org>
CC: <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-csky@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qz1_T-hhdMaEkqwrI4fgb-H7IIpw3y-U
X-Proofpoint-ORIG-GUID: qz1_T-hhdMaEkqwrI4fgb-H7IIpw3y-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=871 mlxscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140028

With ARCH=csky, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/pstore/pstore.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/pstore/platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 03425928d2fb..3497ede88aa0 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -761,4 +761,5 @@ static void __exit pstore_exit(void)
 module_exit(pstore_exit)
 
 MODULE_AUTHOR("Tony Luck <tony.luck@intel.com>");
+MODULE_DESCRIPTION("Persistent Storage - platform driver interface");
 MODULE_LICENSE("GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240613-md-csky-fs-pstore-3ba544d7659a



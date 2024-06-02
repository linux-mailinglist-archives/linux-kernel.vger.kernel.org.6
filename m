Return-Path: <linux-kernel+bounces-198066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FBC8D72FE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 03:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074A5282275
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 01:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F9C1C06;
	Sun,  2 Jun 2024 01:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ho9jf8dL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16816A2A;
	Sun,  2 Jun 2024 01:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717291134; cv=none; b=MHBytFG1YYNNlOZPSDxxIIIzYmphMNJjXCEOPqrkBcAxvttRSIAy2HqNNtPEhDeU4YjlV/XEwUrQ3+vkHIS2Ns9E9q5fmC6fgh1QDuImANjJs1Q8DPmaVYB21QxgRJo0VuAV9oP15jx+Y/mUe7N8NGE3CuYTiOUCqY7BGDml3hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717291134; c=relaxed/simple;
	bh=fgFiLu96gnsQ1GdNNI//RSvLw4YAL+I7vjfDnsxuBe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=uXtMvyQeiz3qRfpFD8ePjngJsaZC55u4m08ZAwl9uoTJRVcDOulK1HoZ25QExFiDEYdHOrQ1NKmj7VdDqCe2vl1g0tZKBnBuKgCLTCsefwI8tldLzjKq957B7GlHTeQ8u1QxO+qfWZyZBz+s62oGGy/vQObJ1l0wqdvnNf75P/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ho9jf8dL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4521GFdq008863;
	Sun, 2 Jun 2024 01:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mZQnqzFmPO+evl/r7+YzH4
	7sdMKbhGojVd3Jgj4gso4=; b=Ho9jf8dLnoh7ZWlVgZhra9wLR9D26XxHfqv68C
	8uXEPZR3+Vu+kI9tQjUhy1c7Oent3JY+9knSidh964GLsOFC8mgsGWXELzO1JQQU
	BheyyMBi8LK8dyLkF/H8eFngqV7lXxD8zwkneSy3HwCmlHPBfv4rxhSxqOHKSQ5y
	E+ZZtWNpEBUQYPrxtBbe3u+jpukS9goL8gIUJdXugZF8iYnulM6c8ZStye+PRZEy
	RujwHALY5JvZ/kPtgVpd6trOwuOr/7N0L3bLShjIv2fMcR/43+Qs2Am1rgX73mtZ
	sfJ5aEF0gFWTG9Gsaqq4aahkUHq6YaX9nwXnzROpXPd78E8w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw7dhh5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 01:18:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4521IonY016032
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 01:18:50 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 1 Jun 2024
 18:18:49 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 1 Jun 2024 18:18:48 -0700
Subject: [PATCH] samples/kobject: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240601-md-samples-kobject-v1-1-f63b215d50cb@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHfIW2YC/x3MwQ6CMAyA4VchPdtkECTiqxgP3ValygZpwZAQ3
 t3p8Tv8/w7GKmxwrXZQ/ojJlAvqUwVhoPxklFgMjWta17kaU0SjNI9s+J78i8OC59jFC7vWU99
 DCWflh2z/6e1e7MkYvVIOw281Sl43TGQLKxzHF1F3p4KDAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lCIMmFUjH_rri49rM14E3WT43APJBQtT
X-Proofpoint-GUID: lCIMmFUjH_rri49rM14E3WT43APJBQtT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_19,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=919 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406020009

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kobject/kobject-example.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kobject/kset-example.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 samples/kobject/kobject-example.c | 1 +
 samples/kobject/kset-example.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/samples/kobject/kobject-example.c b/samples/kobject/kobject-example.c
index 96678ed73216..c9c3db19799a 100644
--- a/samples/kobject/kobject-example.c
+++ b/samples/kobject/kobject-example.c
@@ -140,5 +140,6 @@ static void __exit example_exit(void)
 
 module_init(example_init);
 module_exit(example_exit);
+MODULE_DESCRIPTION("Sample kobject implementation");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Greg Kroah-Hartman <greg@kroah.com>");
diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
index 342452282719..552d7e363539 100644
--- a/samples/kobject/kset-example.c
+++ b/samples/kobject/kset-example.c
@@ -284,5 +284,6 @@ static void __exit example_exit(void)
 
 module_init(example_init);
 module_exit(example_exit);
+MODULE_DESCRIPTION("Sample kset and ktype implementation");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Greg Kroah-Hartman <greg@kroah.com>");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240601-md-samples-kobject-5d6d8e04ba99



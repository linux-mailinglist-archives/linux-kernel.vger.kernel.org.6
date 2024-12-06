Return-Path: <linux-kernel+bounces-435031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CF29E6E9B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D68A281F92
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEA4201019;
	Fri,  6 Dec 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="maq16Z+z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CA45464A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489627; cv=none; b=Q10QVoBupH9XMTArW2g8ltXZbRgLP32eIBIqJu3xq5aTJNFad2J/Wp/6KL1EXyThDY67c7LI2axzqBRtkAZdehu1+s+lD4/sbE2MEcED0D+BineJqU/uzyXG39O2/Al6c0FhB8x4oin426X6+zsto8Y5iOfVT3Q4gDMwuntWxFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489627; c=relaxed/simple;
	bh=ywmW2KOAhh9b/GxPM4oy/ormt7yVohGPrAZcFiKsWtw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UwIFAZa48JrI+wCVuyWKydrvVJLaPcL6At6NdpMV9LQoadAwTXEJv6Jb1Z1AHXG79vVYdNyKTD92HaQLrcvwXZHwdF9RWzRnuCtsx0wXX4YpwF4p02PnCYXsEbJA8f6BHf8+oG1QDu5fdyPXtnaTjt2+udnOjp1HRU0AORp21h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=maq16Z+z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6BmwJV003138;
	Fri, 6 Dec 2024 12:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=Q3gonYDhgHp8TDmpOVMp4K2m+cXMh6AwNwWl360M3ug=; b=ma
	q16Z+zKt9XVniozz7pF6q4GQZk9RZFt9mPMe5qTKBw5PQn+YX1FaoeboUmsWn6cu
	c07fEbIrA9N96MI9p0eaOT9k3emFMxEXlw600Xs1omhNmUYmrWqp1BgENc8RnDHm
	zbl5nOyRPU9OkblMlRaWK5DQNSuK00NH2MgGhDJmm7cGT/Xd4+Q5tKHuzh5eM+d9
	8NhjuIh2sk3HYBPOkmtq2qJyivWiUYMRTBn+udlKvQUBToZFSi1Y3VRBZf5ehL6i
	pQANq2ekGG1/RBQYe+WltRYcDS8iSYLfY1OCSlX1+p+kfkiUnr7mmuxgg5E4CRbp
	nodOhbkAi9gpjADjjGUg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43brgp1jq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 12:53:32 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B6CrWu1029763
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 12:53:32 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 6 Dec 2024 04:53:29 -0800
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <richard@nod.at>, <chengzhihao1@huawei.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>,
        Pintu Kumar
	<quic_pintu@quicinc.com>
Subject: [PATCH] ubifs/debug: remove return from end of void function
Date: Fri, 6 Dec 2024 18:22:58 +0530
Message-ID: <20241206125258.9212-1-quic_pintu@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QkxsqqPNAy4p3SUB3d43iKi6JwT1nT4d
X-Proofpoint-ORIG-GUID: QkxsqqPNAy4p3SUB3d43iKi6JwT1nT4d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxlogscore=843
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060097

Noticed that there is a useless return statement at the end of void
function ubifs_dump_leb().
Just removed it.

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
---
 fs/ubifs/debug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 5cc69beaa62e..987eb5b6782a 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -863,7 +863,6 @@ void ubifs_dump_leb(const struct ubifs_info *c, int lnum)
 
 out:
 	vfree(buf);
-	return;
 }
 
 void ubifs_dump_znode(const struct ubifs_info *c,
-- 
2.17.1



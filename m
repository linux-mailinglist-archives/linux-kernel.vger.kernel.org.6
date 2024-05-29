Return-Path: <linux-kernel+bounces-194782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFE38D41F9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB976285F85
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 23:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CCC1CB330;
	Wed, 29 May 2024 23:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k//smB2i"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EE26AB8;
	Wed, 29 May 2024 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717025525; cv=none; b=ct/eCGhM6l9BEZ2oHeaIY9tWJa8rT4eidk02xhD1rWwbLvfEUWyvwqhMUiJCXKMwfFjnhDACmz5f4724/wFZqvmuWm5n+gSKpyWU4caJev0SLtrP9Iv/VXVHYu4918PifOKzLBvNE8uw/K9erraphFSzG1M9hTdRMsbVfXck0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717025525; c=relaxed/simple;
	bh=4mKxqehj52IvxkEGVqhXNt6WptidXy0S3B7dAFZnIZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Ijm3miXJF47uAV01T9vPOWRyOkuf55nUom0RC+Zf59aEb4Qo6RfNj6EzSoeTpRM/0l+/yY687o6s8eleptyrtjzKHq0JxSzi3s1zKLfZ7QWs/kFxDtddCmwO1qLRgLAllSXih3znw3TfZBgyD65tAOVD2z/tM7jKxX+OccpHWtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k//smB2i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TJne5M000498;
	Wed, 29 May 2024 23:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=aocjmcSyEYUc6gNKmBCW7k
	6+aHjWPJTQ7E+fx5JOMfU=; b=k//smB2irEnyq1uh/Vh2dSBzHQf6XsrQlsj+s/
	IdWAVdb3lTecyIabZEw0DKLEhpv0kav3+UBopSa5OnjPL+EsSLgJNV6PRX8HME/t
	srePae8xDlkVMfYIjzTxp6gPuabcLr7i1VaZs63K6WLzmxBbmOPhNPY/Iz9y7rup
	QPoSWyfyDk3DMFHF+CoCcDfKuzLBG4tchFL0NIyftRruU6KS8nXA8wgKteXZLGOb
	OY/llB1F4jn0yrcz8Ez5M57miSU31LRkLhcViVLyYRHdXdegjnxrVPUja/xyH6gh
	Sqgkii2qN4wcAZ5ClRqocGZdv638gA7gYJXdnL4k3iTmoTSA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2ptmtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 23:32:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TNVx3u015767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 23:31:59 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 16:31:59 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 29 May 2024 16:31:58 -0700
Subject: [PATCH] resource: Add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240529-md-kernel-resource_kunit-v1-1-bb719784b714@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAO26V2YC/x3M0QqDMAxA0V+RPC8QiyLbr4wxapvNoNaRWBHEf
 1+3x/Nw7wHGKmxwqw5Q3sRkSQX1pYIw+PRmlFgMjlxDrbviHHFkTTyhsi1ZAz/HnGRFatouEtX
 UdwQl/yi/ZP+v74/i3htjrz6F4TecJOUdZ28rK5znF7Kwn2uJAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dU00OP-p4wFyV_IWma38yQB1RHgS-fCk
X-Proofpoint-ORIG-GUID: dU00OP-p4wFyV_IWma38yQB1RHgS-fCk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_16,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1011 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 mlxlogscore=904
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290169

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/resource_kunit.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 kernel/resource_kunit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/resource_kunit.c b/kernel/resource_kunit.c
index 58ab9f914602..0e509985a44a 100644
--- a/kernel/resource_kunit.c
+++ b/kernel/resource_kunit.c
@@ -149,4 +149,5 @@ static struct kunit_suite resource_test_suite = {
 };
 kunit_test_suite(resource_test_suite);
 
+MODULE_DESCRIPTION("I/O Port & Memory Resource manager unit tests");
 MODULE_LICENSE("GPL");

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240529-md-kernel-resource_kunit-0457d0010b70



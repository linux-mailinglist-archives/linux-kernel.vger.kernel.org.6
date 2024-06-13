Return-Path: <linux-kernel+bounces-214041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45247907E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDAE11F23245
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A26414B06A;
	Thu, 13 Jun 2024 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WuUGQ1px"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DC15A4FD;
	Thu, 13 Jun 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718315741; cv=none; b=icgQl+6fR1YOMpBHxjKxUK0ZQVxcR1EZop/y8nEm/fLIWE+IZLBVXe1igv4YBZCgb5qR40y76uUA6qDSUFPT/dgMTrVEuzK2mrptqkoaGmfCbUqyteLkhpSC8+Me5Z+JpolFgnBQAeTc1Bk/nZ7sujtkaCe9zPjLMkYPo6MLhSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718315741; c=relaxed/simple;
	bh=dsOdR70lZRFyArvzgl/75h8G2gwthKt8M1Exy+eRc7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Z0BrI1O3qo1YAWPiw6cz/RQTOt3eXKWbZLVOJR3TX+ZrrkFnGRnQO3DOEt/R/fxlKZKGL0/zwtF7SUbdKG3lkLUCz2mrHc4Z9RScOUZAIqHEGdFxHn7tQI7qcd8ZFLOZa6EGCYx3RnTLzG1MqveQ5qggP4B+Qfe9H1U8d6x9kNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WuUGQ1px; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DJGIDQ032680;
	Thu, 13 Jun 2024 21:55:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=w8iVtX2uGyYjJntoEL2QQf
	DpVm30iw125rO/76T8PAI=; b=WuUGQ1pxK8Yk/qCMcDycOW9/xD8uAWARvofYEs
	t4CvK8/9Jj06UWmUVdVa6nkC8awGwiiJKrsdJbhnAWOe7zMK48gccWnr2BudWg2Y
	WUHvPn0dN/RfMBj0QyXnnRc78Ls2IpB3YOH5JV/wudZ7+q4UQc6K7afkBMkb2dZi
	J9kwFoagCnhxSLj3HsvR8PNKf1AvrWvzjsD5hQHUcSKrw1/+EHg65qBm/b6lLnVW
	paPKzudbnmUquroVMlU8pCwldZ7u+b0JW2HGLqG+GbsJ/BxXiy1zskz2EGjFMsPa
	Pw59ReWPSNBhH/4ZTLT2cYYYWGkKE1EHVVQnsdZcvkL9kj/w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yr6q2rcat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 21:55:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DLtJFY028812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 21:55:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 14:55:18 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 13 Jun 2024 14:55:17 -0700
Subject: [PATCH] clk: vexpress-osc: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240613-md-arm64-drivers-clk-versatile-v1-1-6b8a5e5e00ef@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAMRqa2YC/x3NSw7CMAxF0a1UHmOpPwXEVhADJ3WpRRKQ3VaVq
 u6dlNk7k/t2MFZhg3u1g/IqJp9c0FwqCBPlF6MMxdDWbV+7psM0IGlyPQ4qK6thiG88B80SGan
 2jrquvY79DUrkqzzK9j94PIs9GaNXymE6s1HysmEim1nhOH5iK8+ijwAAAA==
To: Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Liviu Dudau
	<liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IABhzWWIfaWeGOsC5HBWz9Ewu9RaSAsQ
X-Proofpoint-ORIG-GUID: IABhzWWIfaWeGOsC5HBWz9Ewu9RaSAsQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_13,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=907
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130158

With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/versatile/clk-vexpress-osc.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/clk/versatile/clk-vexpress-osc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
index b2b32fa2d7c3..c385ca2f4a74 100644
--- a/drivers/clk/versatile/clk-vexpress-osc.c
+++ b/drivers/clk/versatile/clk-vexpress-osc.c
@@ -119,4 +119,5 @@ static struct platform_driver vexpress_osc_driver = {
 	.probe = vexpress_osc_probe,
 };
 module_platform_driver(vexpress_osc_driver);
+MODULE_DESCRIPTION("Clock driver for Versatile Express OSC clock generators");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240613-md-arm64-drivers-clk-versatile-a0b6a3327f48



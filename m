Return-Path: <linux-kernel+bounces-178034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5577E8C47AB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D771C22F28
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B447E58E;
	Mon, 13 May 2024 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eCS4H08Y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BB5770F5
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629106; cv=none; b=evzcSAVa/jJ7hlpdrtzwl8FOKl8C4jPv+noWtHFEA4g9rb65zQ1lP0zgE5m5Ev77seIKiygPt/GDxc8oy3He955ESWvv9Q60ATqghLcoeEMUmBYdClzhaAkepL63aCNp2arQustWk1m3lOmQ8bgiCnFaibDKydUc5q/Syw3rpcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629106; c=relaxed/simple;
	bh=A4KT+okBpV6zwlGJ/mZ486pqW+XQVmh2RvbmvqYAWuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NdikgaY6yU/tRZbZlgwQ6+gGNgmXq+i/ycW4Zle2ic4SImqRtRGw8CmhRpdsT/6zqEGAy4rlWf04E6fY0MIG4Q+7YSxsi943hESHYUUBw2ASrEMMobYjLqyuNrO9y54i1KkqTd4qpC82erVgK+FSijMJTIp0p/Ea2eFOokskPW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eCS4H08Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8Xqc024006;
	Mon, 13 May 2024 19:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=utludO3sqtwnj1dM01Y5bTnUD7G81v38tyL2hzxTiJ8
	=; b=eCS4H08YGYuH7XVGYOrb68IpfuJ2mNbWFyv0DEkGhj5juK5GCQu100wX10v
	Eww7RqQzqMra0Vntts92jI5wNewsAWefBVRlO4sadRXMt2RzeR2Kuy2pqJTNp03k
	38CrDIchfdTnb2ChcYU8tnyG/Ej7Z27FhvnUX7I8TYgm2eKjAsg8VnzPnzATEWtA
	2RPZjZwOk+/vyRrmWNYcBo2EDaDJuthI6PeWiRGPrpwJqDqGIUhS0jdSp/jpPc4y
	EvsY0Gm70l6LfRPvJR5ZuxbR0HKou5WtMZD2P9hzVrK5Uy31GSjrojYN4K23nHbV
	wJAOVPXSPG8tEpGlp8sDKRsJpIA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y2125cdm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 19:38:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DJc3NL004093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 19:38:06 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 12:38:03 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 13 May 2024 12:37:40 -0700
Subject: [PATCH 3/4] mm/kfence: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240513-mm-md-v1-3-8c20e7d26842@quicinc.com>
References: <20240513-mm-md-v1-0-8c20e7d26842@quicinc.com>
In-Reply-To: <20240513-mm-md-v1-0-8c20e7d26842@quicinc.com>
To: Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi
	<nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Sergey
 Senozhatsky" <senozhatsky@chromium.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kasan-dev@googlegroups.com>, Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eQDbYw0N_xlwn63HOf1HuOWH_llEaQYu
X-Proofpoint-ORIG-GUID: eQDbYw0N_xlwn63HOf1HuOWH_llEaQYu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=877 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130131

Fix the 'make W=1' warning:

WARNING: modpost: missing MODULE_DESCRIPTION() in mm/kfence/kfence_test.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 mm/kfence/kfence_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 95b2b84c296d..00fd17285285 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -852,3 +852,4 @@ kunit_test_suites(&kfence_test_suite);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>");
+MODULE_DESCRIPTION("kfence unit test suite");

-- 
2.42.0



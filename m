Return-Path: <linux-kernel+bounces-178032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A418C47A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6591F2471B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2057E0FB;
	Mon, 13 May 2024 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tn2WlWNg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2268E76C61
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629106; cv=none; b=BHpTEcB8seiqVROEHMOR3lerLs/2zjl1gyBQZ4im2ibNxZMM0Re6wgLivFHGf/k9JsjJb3lLTrcBOtW6cOUh6mRLLbSN/PELngGPUHAv7U7iktomJRPRrdgsf+aK9Lz4ggGNtdomyBy0vM+8l3GY9IrxjObcCEDXMcaJv0NOnj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629106; c=relaxed/simple;
	bh=gxrgJhnBtkRkwlaZbS3TjpFcjoOpXmoV+nKl6IT0Wg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Vv02g9rJy4G9E9tD9nyb6m9WSLOp/ZUyJK1bZ7O0patGuhYEsoh352MiCy29JRL2FtdJGziEoKmbgZkvjdCRq9BLOEyPmz3TEoZol59w/+iI8mhMszrYEi7+UUWglkqORZix1Lokwl8beA79csizwnbitWPfbIO9KnVKYHAJMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tn2WlWNg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8Zw0027313;
	Mon, 13 May 2024 19:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=M5On8UDNIfPjL9B9SOl2Byx+r6yib+177PbilkE9xME
	=; b=Tn2WlWNgfWB0fuKCMGXazjcSABxNtehnHlGdZcEB49SYD097PK7e2DTciBV
	iSTA1VoOlfXBIJdE6H+aWlpsUel/302CLjkQnXMNc7irQjzVi0wySMqMURjfV3/x
	rMo8QckX9Z81Bk7ahRkkPKn8xtFjXrIoxFaJcIAOzYB20wgQhKFcwQ2HNMioUb5N
	/24i+7s8cKsrfaHg+VR+VbGGUzk7bG2TiLFK7jsm58dhzCD8rVll9gL2uVtdTcmy
	f17pxaTOIp8xIsjlzAyuccVtN70GEZfumWaWco+FWcAnD2GVxuKewR39psQT2MZ7
	JuTwNJsLoP/MIl0qe22lijeov6w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y1y9mchuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 19:38:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DJc3NJ004093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 19:38:03 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 12:38:02 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 13 May 2024 12:37:38 -0700
Subject: [PATCH 1/4] mm/hwpoison: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240513-mm-md-v1-1-8c20e7d26842@quicinc.com>
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
X-Proofpoint-GUID: nG7lJYwglfeYIktc6RVkONFDtBx6Ma9g
X-Proofpoint-ORIG-GUID: nG7lJYwglfeYIktc6RVkONFDtBx6Ma9g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=912 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130132

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in mm/hwpoison-inject.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 mm/hwpoison-inject.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index d0548e382b6b..7e45440aa19c 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -109,4 +109,5 @@ static int __init pfn_inject_init(void)
 
 module_init(pfn_inject_init);
 module_exit(pfn_inject_exit);
+MODULE_DESCRIPTION("HWPoison pages injector");
 MODULE_LICENSE("GPL");

-- 
2.42.0



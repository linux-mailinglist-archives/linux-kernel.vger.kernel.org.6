Return-Path: <linux-kernel+bounces-342042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474339889FC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB5F8B20CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB0C1C1ABD;
	Fri, 27 Sep 2024 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N0CaCZ87"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C315A853
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727461081; cv=none; b=aYPhpL5r7ZlvqYJkb5S6MEyWwKziAsMQR0BymUWrh7mJWl7MP3sGEzPwJ+bH0pwn3CHKwn23pIGKcHklv4yJPxAkISzFqrKwjHJ51noKtv8+/O/b08rRlGe/Nai4paCHD+ibWbaOA3tewzqcJzN828m5/pJBP4xwG4PUdJKh+vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727461081; c=relaxed/simple;
	bh=EbyxXEWXkH+63CnoZYq8n89k7C3F71t3l3YpirYGbIM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sVmoTDQMcTVfi9aquNr6hdI8eemYCSFlaNXTH4swDwHlcvPtzQ8nT+iV0hA9ScSpGv59fXeDkspTO41j8CQLbsFByTULRt/JvrUW1qopGC1phJVrigL30JG8lVONxKmI6nWmKA3olJFxUAD5I4hg8ZOR/wyIjqHvjRcVnif9L0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N0CaCZ87; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RGU744000903;
	Fri, 27 Sep 2024 18:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=aDfvZgQEJuxrkulYeZkIpVjsIBwvH4nh23ruW1qhnVY=; b=N0
	CaCZ87xF/B5odmOIitr5liFUz7DrF0pf8uqnEbNdqUHw7rcov0tFSyAhiKKsNO+/
	hg3Jmwwlj2piXXbUXc8TWrv7kJPxgKwVLbTLbHfdg5HCR84JQ15D0dEjlpito6FB
	coKb3YDZtOslQ5lnPi9x+CYoewfFWNVBfZG/AL+bTaugXbH71vi/jPGF2ql6ZU1j
	jPZVij99F7Xxy2SkG5lKVHgWo+jO5NCswp1o8HJ3IZrMtUy7D40r0RP9m7ljfgZu
	TDCxiKqJ0xHBPGmhJmPufCwF2WXgeU2Rb8ubNzmj93MpqyjflfgqNWHI0eRPAY0B
	E1AEAFZCWI03E/ZvVAWg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sn3skp08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 18:17:38 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48RIHSPs013445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 18:17:28 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 27 Sep 2024 11:17:24 -0700
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC: <shuah@kernel.org>, <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>
Subject: [PATCH] mm/cma: fix useless return in void function
Date: Fri, 27 Sep 2024 23:46:37 +0530
Message-ID: <20240927181637.19941-1-quic_pintu@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NbH8Pt8JkqFhxt4Y0pln47e5hUZ9nuW7
X-Proofpoint-ORIG-GUID: NbH8Pt8JkqFhxt4Y0pln47e5hUZ9nuW7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270133

There is a unnecessary return statement at the end of
void function cma_activate_area.
This can be dropped.

While at it, also fix another warning related to unsigned.
These are reported by checkpatch as well.

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+unsigned cma_area_count;

WARNING: void function return statements are not generally useful
+       return;
+}

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
---
 mm/cma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 2d9fae939283..c5869d0001ad 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -32,7 +32,7 @@
 #include "cma.h"
 
 struct cma cma_areas[MAX_CMA_AREAS];
-unsigned cma_area_count;
+unsigned int cma_area_count;
 static DEFINE_MUTEX(cma_mutex);
 
 phys_addr_t cma_get_base(const struct cma *cma)
@@ -135,7 +135,6 @@ static void __init cma_activate_area(struct cma *cma)
 	totalcma_pages -= cma->count;
 	cma->count = 0;
 	pr_err("CMA area %s could not be activated\n", cma->name);
-	return;
 }
 
 static int __init cma_init_reserved_areas(void)
-- 
2.17.1



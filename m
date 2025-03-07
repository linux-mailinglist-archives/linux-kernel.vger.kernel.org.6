Return-Path: <linux-kernel+bounces-550328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D127A55DFD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB0D1895389
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40121624F7;
	Fri,  7 Mar 2025 03:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PCxkC9Dl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE31F94C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 03:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741316660; cv=none; b=VpmEYDrkwqOLLvtWUUXQa8aLs6xchPQne9WoNuW/qtH32zYosxLpAxpQl9ikzA6HWaLsHN4Cxkxhwsgrdkeck7pW1Lg0CfQjcvvSeED6QHG7yFQD1m5iFk93HmbY3kAzRMbzAv9tpsu5dg9QJJc8QAQVoAuJsDZYA3qYyq4fYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741316660; c=relaxed/simple;
	bh=XCP9kwKztjB5aMRSK3OlQNdJX12K71O8wDs8oAclikE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BWITi0mLfOgsbn/YuAFcdy/ZJtOCnuv6Hu1t2Vayb/USiuHUpiAoDdPESI9wlsGFUDRcQWZYz55jrQz645E97suU++fobS/GyCiupHYJ3a2tmyeu10hqndHhdCEhcnfO4RohylI6YDWIjPJp4DlZbwoB5PBOFak7BAxsslYUbvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PCxkC9Dl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526FYWPh017935;
	Fri, 7 Mar 2025 03:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IEawcTkCI3WN0tBwh7VLst
	cfdDPbM0A0inPDwTtdLlo=; b=PCxkC9Dl73FlMap8NTr17C4MOwX8bvU2wk+ESb
	oDFQbnCddwvn/W5ChLbZIUgCxUwo/wKl3UJMxUMv+VHtVx+utt5Zhvte5uYHw3m/
	ReGUQ25ElHiTu14zANCqEVYu58UhX+ZXlFxsvNPkz+jMku+caRD0ZaPVxzCkFhSZ
	xjHzYmJ7y9qjyLbcxLhLUMfmLCiZY6nbavMFKc83+jTNcC+6RRz88FpUXkNwJzX7
	deJqYTQj1XJZN+FvmLrlbNvbHWNHShZCr8YV4y+UPpPNdeARMUPCqH/4Yc/x6goe
	/sP3/bq9itBVWHwBKaj1m8KcP9iwg+Nn1D56J1zXKHZxs4tA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45778tb0x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 03:04:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 527342ks011599
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Mar 2025 03:04:02 GMT
Received: from Z2G9.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Mar 2025
 19:04:00 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <m.szyprowski@samsung.com>, <robin.murphy@arm.com>, <justin.he@arm.com>,
        <hch@lst.de>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <quic_bqiang@quicinc.com>
Subject: [PATCH] dma-mapping: fix missing clear bdr in check_ram_in_range_map()
Date: Fri, 7 Mar 2025 11:03:50 +0800
Message-ID: <20250307030350.69144-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IA4xNB-LbgoUeq15A9bmdWCUt3KXcaLk
X-Authority-Analysis: v=2.4 cv=U5poDfru c=1 sm=1 tr=0 ts=67ca6223 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=6YtNXFjIWaMwA3fUu04A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: IA4xNB-LbgoUeq15A9bmdWCUt3KXcaLk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_01,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503070018

As discussed in [1], if 'bdr' is set once, it would never get
cleared, hence 0 is always returned.

Refactor the range check hunk into a new helper dma_find_range(),
which allows 'bdr' to be cleared in each iteration.

Link: https://lore.kernel.org/all/64931fac-085b-4ff3-9314-84bac2fa9bdb@quicinc.com/ # [1]
Fixes: a409d9600959 ("dma-mapping: fix dma_addressing_limited() if dma_range_map can't cover all system RAM")
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 kernel/dma/direct.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 5b4e6d3bf7bc..b8fe0b3d0ffb 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -584,6 +584,22 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	return mask >= phys_to_dma_unencrypted(dev, min_mask);
 }
 
+static const struct bus_dma_region *dma_find_range(struct device *dev,
+						   unsigned long start_pfn)
+{
+	const struct bus_dma_region *m;
+
+	for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
+		unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
+
+		if (start_pfn >= cpu_start_pfn &&
+		    start_pfn - cpu_start_pfn < PFN_DOWN(m->size))
+			return m;
+	}
+
+	return NULL;
+}
+
 /*
  * To check whether all ram resource ranges are covered by dma range map
  * Returns 0 when further check is needed
@@ -593,20 +609,12 @@ static int check_ram_in_range_map(unsigned long start_pfn,
 				  unsigned long nr_pages, void *data)
 {
 	unsigned long end_pfn = start_pfn + nr_pages;
-	const struct bus_dma_region *bdr = NULL;
-	const struct bus_dma_region *m;
 	struct device *dev = data;
 
 	while (start_pfn < end_pfn) {
-		for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
-			unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
+		const struct bus_dma_region *bdr;
 
-			if (start_pfn >= cpu_start_pfn &&
-			    start_pfn - cpu_start_pfn < PFN_DOWN(m->size)) {
-				bdr = m;
-				break;
-			}
-		}
+		bdr = dma_find_range(dev, start_pfn);
 		if (!bdr)
 			return 1;
 

base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
-- 
2.34.1



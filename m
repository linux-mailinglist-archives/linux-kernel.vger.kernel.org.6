Return-Path: <linux-kernel+bounces-364592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299899D69D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B2728439E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915831C8787;
	Mon, 14 Oct 2024 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cUNVdFZb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A0231C95
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930884; cv=none; b=WUiUrHui8LuNdgqx6v/+QOI5EnIIPmI+WwSqWF0SZ0PK2bZDiLJed1LcJ4f+Ahc5qGtfjsuMs+m2wot2sWu2VdZHqcoZz1nRHWyYoCJhRz4yTK8Dg2KJoGN80gYEdzANT82wHsV19/T9ZX6NMziZy7ouRdTebXVq9H67alk9fvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930884; c=relaxed/simple;
	bh=DcpF6yulUm95WMJOeU92hu5tF5L+SdRZIVjzksq8shA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pO56MoEi/9WqFu2jraTjRyT8d0/H+oD0hYYv0Vx80PcW0XLITSpvcTas1HSZV6wtvnGFmwa8vF328xchw/ujuBms7vCqFHO31L5szddxrIYcd8x7Kr4Y1c7g0T/d0sr8Rgpx095gUkcK3ClKUdIQOLnW8Kn3jUaV8mK3RmQzmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cUNVdFZb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EFrD5L019841;
	Mon, 14 Oct 2024 18:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=ZtMZ9rpeS1pqw3+AB3ebNz1vWNw34/B8sPO+EDEkMYE=; b=cU
	NVdFZb5dGGoSA/v01torSxdOcqzkpBSm5VnBy480ikipRlMNFwptCm6+n0G3BPxg
	kc+UIXIK23SW0qe85W/H0acif1ru8IumeRknctzN8UqoTecLEf+alrHUrs9eNa9D
	dUu9Xb2C9sh4hviqKsQnlhJ/MR63S24TtDMYZ9WkvG+O/ML2Hrks9ixZf7PDhn0+
	KGhTYHMZYmSgrOg9OkKT+2wAZia7VmIqqHrzvPRgzT/tMzldf/SwLibHrpg8PKFv
	Xoj8ocQpxwXrEHJqLDbW8gn6nTGfENFK+hf9qAsYmZ/pW2C7K5Bjts12863+rPeI
	VFQU6cBXZgctIE2OHQIw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4296b7rc9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 18:34:36 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49EIYZFX012598
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 18:34:35 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Oct 2024 11:34:33 -0700
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC: <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>,
        Pintu Kumar
	<quic_pintu@quicinc.com>
Subject: [PATCH] mm/dmapool: use unsigned int instead of unsigned
Date: Tue, 15 Oct 2024 00:03:49 +0530
Message-ID: <20241014183349.21763-1-quic_pintu@quicinc.com>
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
X-Proofpoint-GUID: W69QJEk-dfTBGiBJLW5SswZMPcJaTny_
X-Proofpoint-ORIG-GUID: W69QJEk-dfTBGiBJLW5SswZMPcJaTny_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 mlxlogscore=990 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140133

This warning is reported by checkpatch.
Fix by simply replacing it with unsigned int.
This make the style clean.

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+       unsigned size;

total: 0 errors, 1 warnings, 524 lines checked

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
---
 mm/dmapool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index f0bfc6c490f4..9d81d7b3cb05 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -72,7 +72,7 @@ static DEFINE_MUTEX(pools_reg_lock);
 static ssize_t pools_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dma_pool *pool;
-	unsigned size;
+	unsigned int size;
 
 	size = sysfs_emit(buf, "poolinfo - 0.1\n");
 
-- 
2.17.1



Return-Path: <linux-kernel+bounces-438001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1669E9B77
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800A91657BF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70642142E6F;
	Mon,  9 Dec 2024 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i46ik0RD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E1035954
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761309; cv=none; b=Etbzy/10f+J6OR5dJ5osKiWPsqJjo0+aCAAT2nlon7bitqOb1ZFobc3zI31qKONxpfZ6EY9Ti+eniuHQNZfCqbJMP4Rj3y2gPbrEdYnpw5Rj61Wlcll4tgXa0kvp8RrgD87itzVE9p2RRBa70HKdXLPOd/XMOvQbqHZVSnW4JJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761309; c=relaxed/simple;
	bh=lODOasS0YTQSUAkCE8s6lBplaA+bsV0vRzmMpYHCVlw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=upfQZOuQ3tW0580cLAepT7HVVIs0nXpAsixDTX4bhOVexqMJY9EwsP2IVMea2TuH2uu6lrI+g8AlHIHkb0778zXaDntw1Ndx13p7D5I/osCICSe73p8f1KoqkFbnBFzd2+fVS7aJuD0AnSzJZ780pZXzj4920oQ2+FX0nWBCKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i46ik0RD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FaNQl014046;
	Mon, 9 Dec 2024 16:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=jeX8jBQrA4Y/1/e2bofe8t72kt/HJ+dQVyIr2KvR5Tg=; b=i4
	6ik0RDPtgMRze8JDiu4HPhCdlKGqpr9rw9qquxNU/V75xR+Kuehp0vW1WwlHeJ6O
	kAIiA/nQF0xg9+vqdm62Iu5h9onNXgNBzj2EJ8bKJG5qSfw5zRHzO/yOggtH5XGA
	XXiizC7ivsMc9wtXGznfBbUHlqyvWEYA5XqwK/flzFXtfwGkTnD3HLn6p0eUFRjx
	3cU1lYiAIMIVqIdWGYJDRMaax7jcUop0U5huO2WDXIMtRY1Xf8hsPjZ2CR2bW3xe
	INinuMKeQftePE5/NAZRs6aSHMhkhCZF9v/SZMP8sNWI3E+mNByi782/8WlF1Uxb
	6LqVKg8Y/5bLH2u1L+5A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dvyahmrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 16:21:30 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B9GLTjd015708
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 16:21:29 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 08:21:26 -0800
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <richard@nod.at>, <chengzhihao1@huawei.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>,
        Pintu Kumar
	<quic_pintu@quicinc.com>
Subject: [PATCH v2] ubifs: ubifs_dump_leb: remove return from end of void function
Date: Mon, 9 Dec 2024 21:51:04 +0530
Message-ID: <20241209162104.15331-1-quic_pintu@quicinc.com>
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
X-Proofpoint-GUID: rRIns4iJhf67h--F4ZCl6Xyt5b0A4NzM
X-Proofpoint-ORIG-GUID: rRIns4iJhf67h--F4ZCl6Xyt5b0A4NzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxlogscore=821 mlxscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412090127

Noticed that there is a useless return statement at the end of void
function ubifs_dump_leb().
Just removed it.

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>

---
Changes in V2:
Change commit title as suggested by Zhihao Cheng.
V1: https://lore.kernel.org/all/e43da923-0184-d41e-a273-a02848f3b671@huawei.com/
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



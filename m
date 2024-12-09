Return-Path: <linux-kernel+bounces-437752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD79E980A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AD1283A45
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8551B0416;
	Mon,  9 Dec 2024 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nht7vGxn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425E51B040C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752821; cv=none; b=PZS4z4ZmeCKK6elEmX+IdxerVEkcEr7dy9vra9k47Rrq1af74vTwoGnSBkU+pW2jAQzxwMg+lWor2XwtyaTy5zwsgvxYajtuCOGDFzRjfjJnoGmx/HLWcVwiIVCYeD/ubW1ba1201PXC4blXP/augMdW4eEy14VRpKuSU2/NHD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752821; c=relaxed/simple;
	bh=4UvV1I6/VfgF588LR+Fqbeb87PSKgHmaAImazAAxcHI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ErBh1WUHs44U0r2M6rcYAN7OzHSBHVOqL7YOyuhqoCwxSj08FFHStI3hORCdUnucBiqAREXHon+e47Fo/3PZDqK3WR66vW0pxz9+cphcATuA5U7UgmRwi1qpGK7y7tO73oKEQdWgSaZWeFOa7uXVgB0NdNni/Yl6dFQ1aUdXvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nht7vGxn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9ADA9V010451;
	Mon, 9 Dec 2024 14:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=LYCDrDXJxDehK72J9pt8JiBZkQmznl2IFYQgM47YD8o=; b=nh
	t7vGxnxAZJz1y016lvsxyrpyVLR4IlkPFDx0apH6wxTzAs0mbexrhxFEUlpiLtIl
	gXSp0EchGRWEm5TTkuKbNgVr674L2yooXv+DAnoUBJJJYJsRme30GTN8WS6CWZBa
	6VqzaR/1j6OttxdmmPDKj3dZKcdrsk/lpMShuXf2kFLb8NbB1DqqkBvn/nYo9naM
	2cCGd3vQhvDEVhE29xKMDstje5XXJksaiFQXauRj59ODtU3KsxlXTTeXsEM8vSTg
	xTX211O7MIckOp9r81SP+SVpN+HqwCwYUWcaKW7dKGggHm8q72TVU+fhjggxJf+u
	vf+oGmTekXosCa3XBVsQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdc6d3hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 14:00:02 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B9E01Mb029634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 14:00:01 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 05:59:58 -0800
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <richard@nod.at>, <chengzhihao1@huawei.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>,
        Pintu Kumar
	<quic_pintu@quicinc.com>
Subject: [PATCH v2] ubifs: dump_lpt_leb: remove return at end of void function
Date: Mon, 9 Dec 2024 19:29:36 +0530
Message-ID: <20241209135936.13229-1-quic_pintu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: d6FWbJHLxOwzIU91aR03njawlQ2EB_bS
X-Proofpoint-GUID: d6FWbJHLxOwzIU91aR03njawlQ2EB_bS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=926 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090109

Noticed that there is a useless return statement at the end of void
function dump_lpt_leb().
Just removing it.

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>

---
Changes in V2:
Change commit title as suggested by Zhihao Cheng.
V1: https://lore.kernel.org/all/abe79e0a-a35f-0b53-bbec-7d642f592fae@huawei.com/
---
 fs/ubifs/lpt_commit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ubifs/lpt_commit.c b/fs/ubifs/lpt_commit.c
index aa8837e6247c..f2cb214581fd 100644
--- a/fs/ubifs/lpt_commit.c
+++ b/fs/ubifs/lpt_commit.c
@@ -1932,7 +1932,6 @@ static void dump_lpt_leb(const struct ubifs_info *c, int lnum)
 	pr_err("(pid %d) finish dumping LEB %d\n", current->pid, lnum);
 out:
 	vfree(buf);
-	return;
 }
 
 /**
-- 
2.17.1



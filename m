Return-Path: <linux-kernel+bounces-435059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 713719E6EF3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C132D168B10
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A9E1EE02E;
	Fri,  6 Dec 2024 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SCUgMWio"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB3C1F9AB5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490361; cv=none; b=JUoxaDMFpjF1fOl6dMtjfH6D+1HTbh8LnUO4McgGqY2mZzqkn9cas6gH5v9TPAS7Hqef2vaNVMEeAo+YE8Jm5vQ3wZ/WGcAKudjMsmwmA1XzRpNo0TyXvCranZrehGZ21NsYBy7nchRQ4tE5z4+HPck9Vn7xRbH8yT1FEnCA85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490361; c=relaxed/simple;
	bh=PUhIlS3MF5XoirB1kPtnLOxu2fHb++fD8uO/bIFaPkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tu8ctU3fBot4LRjredWIVL/BlaktCXxzugBHMrlTDwvX+NpPKYRoQS9SqCQDo6SSARQdl5QSWksfrALviBIRALDqi9Ll3nfr1ud0vfYocAb+pDii3IoTJQKrshcj9V+EyO/7hvjcABXeEi76D7USAhuniewasf7UrDwQCmSmkkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SCUgMWio; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6775Jn031009;
	Fri, 6 Dec 2024 13:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=+THftZcvlIieAl5jw5OcObXVsaJk7nXwFhsvTAjoNxY=; b=SC
	UgMWionfKk6rY9XQH6kCLURggq78dunhiL9Ix6qb15F1XGTksSQYiZau8aKNdbYD
	CtoWHP4kgN+0rjH0TTxyINAAdeqv5xYS2wol/VUMsbhunaDWetBGXsj2HV+03Qmq
	jp331i57V+kwQKiXncFxXogJBgGG5cPdfE7+f8f6cbQ0BDsUCtH/RQL6gz0B6QTx
	okyTdUOKCchcz+Fm9Poi7BWMQEP6ssSNfwWqSh1Jk5BeUAzLFmEtqCghInatKXQ2
	WpweqNADH/NejFATuWtHJnDBpEcuATbXf/rKkJdtd9beDDD7krR3FXD8kOMlTD8W
	dkT/zkI/Hs9kW6o3mpkA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43be17380g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 13:05:40 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B6D5dfj020365
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 13:05:39 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 6 Dec 2024 05:05:36 -0800
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <richard@nod.at>, <chengzhihao1@huawei.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>,
        Pintu Kumar
	<quic_pintu@quicinc.com>
Subject: [PATCH] ubifs/lpt_commit: remove return at end of void function
Date: Fri, 6 Dec 2024 18:35:11 +0530
Message-ID: <20241206130511.32592-1-quic_pintu@quicinc.com>
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
X-Proofpoint-GUID: PSheeY--Q8p1hdWVRx6BhI7ezy8wuMcB
X-Proofpoint-ORIG-GUID: PSheeY--Q8p1hdWVRx6BhI7ezy8wuMcB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060098

Noticed that there is a useless return statement at the end of void
function dump_lpt_leb().
Just removing it.

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
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



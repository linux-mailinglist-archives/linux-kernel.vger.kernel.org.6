Return-Path: <linux-kernel+bounces-418585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9D49D633D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71944282E10
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F035814C588;
	Fri, 22 Nov 2024 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ixiod5uu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126A622339
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297014; cv=none; b=bAQKy2wehBomPCSvlD+om44Y8SI1LciWaPWmPbGn/QUH9IJpvUtm9nRYJ+FObzx0Sqw05J51eMXMNcO36vw5REZHOZA+19jo1KspSLlL6N+sMnBQpgpzr+HMV3oSqDxp0lWEW2O7XHyNyVdgLAb2QmGFfBtKLSlMDmDiAgFJ1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297014; c=relaxed/simple;
	bh=5uRxN43Ee+yFDSOtXHASrm9+yQc/Ef64I596NH3KsOM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NL9lrxRZA2jQdQspKp6NfyEQ/vxNoAApRvfvUI1vuJj0z+091ZJSvn8YYjjs3ms4pLWSq0AdioiPMRNa49VeELj9CQbzQRUai7AmuDizzKIIkNLw7jPkQfhxFUlRIEfsIpFfUMmlO2hGYW8AFov4TGU5h3hjZY7k2X8AN35KiIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ixiod5uu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMCeoj6025117;
	Fri, 22 Nov 2024 17:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=JvumQIHSZnVbuJEZ6nC12MuJtRABvCq5Eytz4+N4o9M=; b=Ix
	iod5uuXvUEJL/cu1EyRGoUCOwUwnAG3hoabVGuS8Huh8Vt8Z1z3LCEkTDCoL22Yj
	/RqNS5n8QnxbjmqX17Lz0Trb8ym9eFDik76e4lpao1cvfq40vFdqyyA2rwDJeIV7
	D/0vuJy5L+imCNG2HtY27hoq+GXxY13bJUZ7bCL91BGIBMSxTA2AsnN3gcGmOIVN
	imG+nuzCBtKNaf6PhlcCnWmzcsmMyLWu6fji4xTYnDOIB/QStNT+9l/ZXTOY3Hgq
	PUd/yWkFokXhs+Nc94yD1RSnkoYOjMHTglcUtrYa8DaB3KuBfq/Hz7fFcJNwPRyX
	+30hFFKGQb+/6x2jWYDQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43251nm3ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 17:36:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AMHakV2003510
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 17:36:46 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 22 Nov 2024 09:36:44 -0800
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <akpm@linux-foundation.org>, <quic_pintu@quicinc.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>
Subject: [PATCH] mm/hugetlb_cgroup: avoid useless return in void function
Date: Fri, 22 Nov 2024 23:05:58 +0530
Message-ID: <20241122173558.20670-1-quic_pintu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: z3oV6t_BWKdOITMz1NrgrXXMKxU-HZyL
X-Proofpoint-GUID: z3oV6t_BWKdOITMz1NrgrXXMKxU-HZyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=564 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411220148

The return statement at the end of void function is unnecessary.
Just remove it as part of cleanup.

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
---
 mm/hugetlb_cgroup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index d8d0e665caed..8abe7151df21 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -936,7 +936,6 @@ void hugetlb_cgroup_migrate(struct folio *old_folio, struct folio *new_folio)
 	set_hugetlb_cgroup_rsvd(new_folio, h_cg_rsvd);
 	list_move(&new_folio->lru, &h->hugepage_activelist);
 	spin_unlock_irq(&hugetlb_lock);
-	return;
 }
 
 static struct cftype hugetlb_files[] = {
-- 
2.17.1



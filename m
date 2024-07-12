Return-Path: <linux-kernel+bounces-250688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B992FB2B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05AEEB230AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBF817108E;
	Fri, 12 Jul 2024 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QPybPh3x"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC8216FF28
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790351; cv=none; b=BnZ5BE2tPjEtHgStVXTr9IR25a7HtjY/WJX6iJJu19XeFM2mNWE2ulYJrXcT2vHfRi684tYeFUODkT17j3MizlvuI5PzEs2o9oBpOwqe/93oTUAI7D5sW3rZXe+NpuReYO7p6BOERz+5SqmcwqL5OtLJ8fNqnvhq00cvFfW6Klg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790351; c=relaxed/simple;
	bh=SifNTPkrOyt1o72VGP+1ZHcebiT2mNEzcaMyfAUlc4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ki1mMPtIdJJP0bRhf5Sz6/X3hPIAk8XE23UfJzLDjEdRZlzeTrDrh+BZxKc8JzeEIIHPClhFYj2atqSVTWZNKMWtQa6cBQTo4UWaW9PUVxoG899Huy6zUDQR6NTUqtcOhkEw/ejheVheR47sUaNyhz+VrwI+awtJWngzRI+sU+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QPybPh3x; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIL4V006325;
	Fri, 12 Jul 2024 13:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=GbTtDJldqRAxtpXcP6RAUB5I1SetiV86HUhK1VvYzyg=; b=
	QPybPh3x9OrLBEipWifKbVVm1KbZIdj20eMYA71mvvSH7zULgcqHCX1JwaUL5mwz
	jl1BmF9CsYviqZq6OLC646qwZxwcS7nCtIvrKiqzH820jDXv/5IjY1dD+1fFBOpr
	CxTsIyOHR3e4/UXJZ3s1pccsp5sDQHgyctHyTAwn7ieKFEcPsevYrArX+Hdl/RBB
	D13ZnTeixfAljQl36qYMq089OAiH+MMAzsG7sg0qkPelJIuYu8pBjqknSX28T5PW
	z/Ml5Cs3saiQQHt8LT/bGrumx6itcc9CHXPtPYnbf/Uw9wDCfq3e6vgPDUCf1O/n
	oYBbrxM76OR3DgE9e7EDmA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcks2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CD61QH022053;
	Fri, 12 Jul 2024 13:18:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv3snq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:55 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CDIsDB029886;
	Fri, 12 Jul 2024 13:18:55 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 409vv3snp2-3;
	Fri, 12 Jul 2024 13:18:55 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 2/7] vhost-vdpa: pass mm to bind
Date: Fri, 12 Jul 2024 06:18:48 -0700
Message-Id: <1720790333-456232-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
References: <1720790333-456232-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120089
X-Proofpoint-ORIG-GUID: 9K6Lu_tlx0jqHi6mCbXlUPlqqKvHkhrB
X-Proofpoint-GUID: 9K6Lu_tlx0jqHi6mCbXlUPlqqKvHkhrB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Pass the target mm to vhost_vdpa_bind_mm.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vhost/vdpa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 963f3704bc39..b49e5831b3f0 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -251,7 +251,7 @@ static int vhost_vdpa_reset(struct vhost_vdpa *v)
 	return _compat_vdpa_reset(v);
 }
 
-static long vhost_vdpa_bind_mm(struct vhost_vdpa *v)
+static long vhost_vdpa_bind_mm(struct vhost_vdpa *v, struct mm_struct *mm)
 {
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
@@ -259,7 +259,7 @@ static long vhost_vdpa_bind_mm(struct vhost_vdpa *v)
 	if (!vdpa->use_va || !ops->bind_mm)
 		return 0;
 
-	return ops->bind_mm(vdpa, v->vdev.mm);
+	return ops->bind_mm(vdpa, mm);
 }
 
 static void vhost_vdpa_unbind_mm(struct vhost_vdpa *v)
@@ -888,7 +888,7 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 
 	switch (cmd) {
 	case VHOST_SET_OWNER:
-		r = vhost_vdpa_bind_mm(v);
+		r = vhost_vdpa_bind_mm(v, v->vdev.mm);
 		if (r)
 			vhost_dev_reset_owner(d, NULL);
 		break;
-- 
2.39.3



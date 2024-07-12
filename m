Return-Path: <linux-kernel+bounces-250689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B49A92FB2A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06828281628
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C09171090;
	Fri, 12 Jul 2024 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QzsYmGqN"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE716F91D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790351; cv=none; b=iZvWWbbbmgBlC/qWd47lyoBg+F2CJDTzvw6t8xJkCSFn5tl5IrtbxEHdCrWl52iCe1wbu88NNFjy43R/ctkzgIvt8tVesZdhi/H0djZPF+wFTNNnixoX8j7LUqMytf5iG7JXCVz0BrDIp/Guokn4DNZQmkV/p4KG7O00ooXB1uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790351; c=relaxed/simple;
	bh=hlBTCWc/+N1wCk/wXZAgKGiPA/PMmWCVwg+g7qOTjBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JMfBp4evJzBYVWr9FhRPfXiVmu4WziFcEK1/XaiThxuktFUWLPXV8n7LBAIwdgqdYDZZYxFJxg9HVwz+DeVbSPO9yS6Y9mRuyH8UelLa9eG6JtJup7wh4Q4dnEHuyiaQrTKn8HgiViZu3LrVgDPn0HjJ+PzoenlGqteUNihGhk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QzsYmGqN; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIL99006342;
	Fri, 12 Jul 2024 13:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=1Rs0R5MKc/0Zr7T6CVE7wYEZGdaXmFH0mlVQdxtpyTU=; b=
	QzsYmGqNemciHyLWVRxSdNuoVkZR7kewd6CKw8lkrns7ts0ZKFBsf1eNxvzXTvYX
	7idphuzJM3rK1CABIZKX35nIv84uHRrHpYG954qDij04biyhzcm8ketegq+r3iBR
	5j0Ue5EZO6tyYaUl6epXxylKBcNT9VB5Zeum+Qob6MB0LyybotYb5kzdwJm+nbYB
	mLARP85UcVUPeP1gkf5jNPlO14rTUzm12Zz5fTdg8bzTnr/KPoxvVL/NSEAu1LQ3
	M9nt6V2PDDXYPkAv6rQHIuIYAshubauwwtfn5VXXL+L0ZlwlCP795EXkiJPIJ6X6
	xUBLyfsRg2/4/H0gYYow6g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcks2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CBneZm022757;
	Fri, 12 Jul 2024 13:18:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv3snqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:57 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CDIsDF029886;
	Fri, 12 Jul 2024 13:18:56 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 409vv3snp2-5;
	Fri, 12 Jul 2024 13:18:56 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 4/7] vhost-vdpa: VHOST_BACKEND_F_NEW_OWNER
Date: Fri, 12 Jul 2024 06:18:50 -0700
Message-Id: <1720790333-456232-5-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: chDgWWEaTXrQPr8cdirWfMwHY5c3WKC4
X-Proofpoint-GUID: chDgWWEaTXrQPr8cdirWfMwHY5c3WKC4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add the VHOST_BACKEND_F_NEW_OWNER backend capability, which indicates that
VHOST_NEW_OWNER is supported.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vhost/vdpa.c             | 7 ++++++-
 include/uapi/linux/vhost_types.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 5cf55ca4ec02..4396fe1a90c4 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -640,6 +640,10 @@ static long vhost_vdpa_new_owner(struct vhost_vdpa *v)
 	struct mm_struct *mm_new = current->mm;
 	long pinned_vm = v->pinned_vm;
 	unsigned long lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
+	u64 features = vhost_vdpa_get_backend_features(v);
+
+	if (!(features & BIT_ULL(VHOST_BACKEND_F_NEW_OWNER)))
+		return -EOPNOTSUPP;
 
 	if (!mm_old)
 		return -EINVAL;
@@ -821,7 +825,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 				 BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST) |
 				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
 				 BIT_ULL(VHOST_BACKEND_F_RESUME) |
-				 BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK)))
+				 BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
+				 BIT_ULL(VHOST_BACKEND_F_NEW_OWNER)))
 			return -EOPNOTSUPP;
 		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
 		     !vhost_vdpa_can_suspend(v))
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index d7656908f730..9177843951e9 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -192,5 +192,7 @@ struct vhost_vdpa_iova_range {
 #define VHOST_BACKEND_F_DESC_ASID    0x7
 /* IOTLB don't flush memory mapping across device reset */
 #define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
+/* Supports VHOST_NEW_OWNER */
+#define VHOST_BACKEND_F_NEW_OWNER  0x9
 
 #endif
-- 
2.39.3



Return-Path: <linux-kernel+bounces-250690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CB592FB2C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 563BAB22802
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A357172BC2;
	Fri, 12 Jul 2024 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EZ4yXVxc"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC3016FF26
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790352; cv=none; b=N22mfwP0VYgU4dhpzSf4IDcpF2lubHlsnKasJpCkPi0ia39OLzbdF29jNzpB33Xm+uc2IqIH3/0GbpcYfqwkWetaSiuI/rT65Xdfk3rN/dBcKDvydciXVmfr+nshpQgGz+Xbz7AK4J50nSB/0S3PkVmGAwoWkDyC7VFDL9A9uFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790352; c=relaxed/simple;
	bh=wCvW00aBdlJDx2fw9Sb9Aw6FcCB2yoyvOxsFnqJNtbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FVyTo6v4MlemiRoCeb+vKrElTcxw/95QbGVgsvsRnvVIYcZFsPYnR7y/VNDgovNGmy7lSnVlfMwHCAB6rXV9De9dpEpSQdCj8EbXzFn9ewphcn1oSimsFtvfOJQRnnIlJb1J+3g/+JrRp3/H9zYs88btQL5ZIFAFQmEnWLj2GZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EZ4yXVxc; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIK6e014260;
	Fri, 12 Jul 2024 13:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=kt586yo3yoOuzwKRIaw5fOFI+WJWJXsv6eQwBzv0uqo=; b=
	EZ4yXVxcbAlG+oOYkDzPlMfdFpEeXNcPvLXIkClf7Xjfj11Q1myltu6jjjTQH2zI
	fkLKmdteAu91vEzj4nTlA8igh7qc/qrJAQ3+of14iJzufjys61eYu45yL3uXt7j/
	VytOuciNTKweLW0TOa+xlzf0rCc0Eoo6pFENl2tu96CoIVquXmT6yJ4jc8o8tJZ6
	b80reSBjdBqcy71UYPI3pBXeB0jBEJhKzwp5V68ue6L2XhLbTpxokwDRTkX4hcE6
	CLqQ1jusGTXn2E0ZrrbuPxZdJBJ0pzV7c6hrGc4Urf2a29fiyTG88/77QxunF5Mv
	5/dnsK9VgcLvbFpxhr4/aw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybuyg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CCPDTo022608;
	Fri, 12 Jul 2024 13:18:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv3sns3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:58 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CDIsDJ029886;
	Fri, 12 Jul 2024 13:18:57 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 409vv3snp2-7;
	Fri, 12 Jul 2024 13:18:57 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 6/7] vhost-vdpa: VHOST_BACKEND_F_IOTLB_REMAP
Date: Fri, 12 Jul 2024 06:18:52 -0700
Message-Id: <1720790333-456232-7-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: nVgFF2Y_xTo6E4M_Geqi21C8MZyyqQaI
X-Proofpoint-ORIG-GUID: nVgFF2Y_xTo6E4M_Geqi21C8MZyyqQaI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add the VHOST_BACKEND_F_IOTLB_REMAP backend capability, which indicates
that VHOST_IOTLB_REMAP is supported.

If VHOST_BACKEND_F_IOTLB_REMAP is advertised, then the user must call
VHOST_IOTLB_REMAP after ownership of a device is transferred to a new
process via VHOST_NEW_OWNER.  Disabling the feature during negotiation
does not negate this requirement.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vhost/vdpa.c             | 8 +++++++-
 include/uapi/linux/vhost_types.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 51f71c45c4a9..1ec1f1382fd7 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -826,7 +826,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
 				 BIT_ULL(VHOST_BACKEND_F_RESUME) |
 				 BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
-				 BIT_ULL(VHOST_BACKEND_F_NEW_OWNER)))
+				 BIT_ULL(VHOST_BACKEND_F_NEW_OWNER) |
+				 BIT_ULL(VHOST_BACKEND_F_IOTLB_REMAP)))
 			return -EOPNOTSUPP;
 		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
 		     !vhost_vdpa_can_suspend(v))
@@ -1267,11 +1268,16 @@ static int vhost_vdpa_process_iotlb_remap(struct vhost_vdpa *v,
 	u64 start = msg->iova;
 	u64 last = start + msg->size - 1;
 	struct vhost_iotlb_map *map;
+	u64 features;
 	int r = 0;
 
 	if (msg->perm || !msg->size)
 		return -EINVAL;
 
+	features = ops->get_backend_features(vdpa);
+	if (!(features & BIT_ULL(VHOST_BACKEND_F_IOTLB_REMAP)))
+		return -EOPNOTSUPP;
+
 	map = vhost_iotlb_itree_first(iotlb, start, last);
 	if (!map)
 		return -ENOENT;
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 35908315ff55..7e79e9bd0f7b 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -203,5 +203,7 @@ struct vhost_vdpa_iova_range {
 #define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
 /* Supports VHOST_NEW_OWNER */
 #define VHOST_BACKEND_F_NEW_OWNER  0x9
+/* Supports VHOST_IOTLB_REMAP */
+#define VHOST_BACKEND_F_IOTLB_REMAP  0xa
 
 #endif
-- 
2.39.3



Return-Path: <linux-kernel+bounces-250685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B67192FB27
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05F2CB22FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E286117107D;
	Fri, 12 Jul 2024 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oMAGvgJ1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACC616FF2A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790351; cv=none; b=AdnbJ/qYJeGi+nsYmPrLUFnJHKJ+qjduPqej4eHze8OW+1YyMNYwyteR5NiYeZXgHgUTn+AVy6jvA4WaabGIEpWG026jLm781Rb0L1Zc+UKqv3SqOPXI1j2oWp2/WDTIeQDSpjZhr598qdxB7pnnlnuDdYvHjy/4zx4ACR1EyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790351; c=relaxed/simple;
	bh=mpPEqNHUboHg5X4DuAYbZYtk5ez8+vBp8ZUbNSPbIkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=T7eYMotHora9Qc3047wu64bQjwnf7hmLyDCfCWgBdvmVbBOgNKueVKE6wnDRJLEwW4Z+xL29AR22S7Ia1Dqlx7jLLBaKGcS9nhXdOMFlXnxWieyNAFuS2fD9D36geSAnumAxHy7TULt7xFTxdunXNmo0kZiVO06PTlqcjYYyJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oMAGvgJ1; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDILjo023659;
	Fri, 12 Jul 2024 13:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=UoIL+vCtOh0fhA5lR3F1t22mJvNzXPZjXUGWRT0A8lY=; b=
	oMAGvgJ1av1S92KxLZpNDpMZ441JMOeBFZ5STUhmTN36ehXhmayNIRRrgnQH+F9r
	CSt/ihMS46oaumteLnb4bQkW43lKFTwc41pqKnZKHCSSAbUa/hwB08yyX5Tf+pPU
	vDkgsd+v4hNGhG2kv5OdJcvbRYx0o+gna+Ay8aXKbBM8RtpUZfqr98JwSa00SnjO
	0+DQBddO/SpznMe2pJVAr3LRh0b0SgkAwy4FFr3fCyDuzbBgq8OYPP0flPhQ31QP
	oRoctodnPVzcvb77kH64h8PT2TwklcUoCtsZZWNEsknywLDQSpZE3qaoHqjt6to9
	ewF1RPFV9NnNE/n5is05Bg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emt34yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46CCVnUM022018;
	Fri, 12 Jul 2024 13:18:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv3snpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 13:18:55 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CDIsD9029886;
	Fri, 12 Jul 2024 13:18:54 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 409vv3snp2-2;
	Fri, 12 Jul 2024 13:18:54 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 1/7] vhost-vdpa: count pinned memory
Date: Fri, 12 Jul 2024 06:18:47 -0700
Message-Id: <1720790333-456232-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: bbr0eCVG20NSa_bbxeF3aQ5F1lkneOWZ
X-Proofpoint-ORIG-GUID: bbr0eCVG20NSa_bbxeF3aQ5F1lkneOWZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Remember the count of pinned memory for the device.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vhost/vdpa.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 63a53680a85c..963f3704bc39 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -60,6 +60,7 @@ struct vhost_vdpa {
 	struct vdpa_iova_range range;
 	u32 batch_asid;
 	bool suspended;
+	long pinned_vm;
 };
 
 static DEFINE_IDA(vhost_vdpa_ida);
@@ -926,6 +927,7 @@ static void vhost_vdpa_pa_unmap(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 			unpin_user_page(page);
 		}
 		atomic64_sub(PFN_DOWN(map->size), &dev->mm->pinned_vm);
+		v->pinned_vm -= PFN_DOWN(map->size);
 		vhost_vdpa_general_unmap(v, map, asid);
 		vhost_iotlb_map_free(iotlb, map);
 	}
@@ -1009,9 +1011,10 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
 		return r;
 	}
 
-	if (!vdpa->use_va)
+	if (!vdpa->use_va) {
 		atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
-
+		v->pinned_vm += PFN_DOWN(size);
+	}
 	return 0;
 }
 
-- 
2.39.3



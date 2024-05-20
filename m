Return-Path: <linux-kernel+bounces-183898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC338C9F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D8C1C20EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75D7137903;
	Mon, 20 May 2024 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TVyLs57L"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1801136E3C
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218482; cv=none; b=sGHOAZFgcu7msOlawm4iVGHPsdeQYpNwfjhSvSHF/Lk2d1JKCoYMVLr8Cd+41SGY21jEARJ9nNSDEz+3flE8Jmai239rUjlfS5QYJyxS4id9ucJHfjlV+4b4fWb7rHcqZE79tAinoEso3sKYoru25MAVMLocZVdoyr/rRdKEJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218482; c=relaxed/simple;
	bh=1Ie0VYID0/xUJRKDRvyDar8Mu+/VDQvE4b530gQ8yB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=i1i3Q/l23fc2mcJUFlweIZqF2UcZ2d8cfX2C2goXGb4nEkGFUB0IlrrNMPrzNJS6yhRh5DK3aBcXhFrMfdYQzwVRO9AysV+gwzJvQoDqN9cFRBjPvq3X67D/8j/FF46ck3ZepdFEHEnEdIcyZOQ1GxPo2cIG5EwYEsQ7K3DoJHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TVyLs57L; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44KEEcdb007298;
	Mon, 20 May 2024 15:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=nfzq6tEmp2Q89g33znNEwGSUnngv4O1I4ljx3zbDuCk=;
 b=TVyLs57LoVyupW4SaJMUTok/AMfpqkF/kyP8ypBS4faFKnA3/Pl+s2RRDT6A5LoFUPrd
 PMrw57kg8Cz0CfzQDKjLVVA35V8OMfAP7YGNq9iXT5P/g0LpMYb9ytre3/LVhV557gZT
 fZ+kbH6Gxth6m35r9s3bd4CAoEepAprIwzPgAE9l6ig5vopSdmeSk9sWLxfeZs2T0oT+
 JgD0tFwIkMGwyrYlRtxQ/VnZljL3yQARFma4rgySLaHj5MNFkGNKyJ/4tGK1v8yzWP9t
 kNLUlaiPt2JQH6JpDM6Wa5ZmMKi9h/qdSDx/dTsELueF0GHkEKbeWSlEsqz72kSdRYUO fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mvv2wc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 15:21:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44KETIfg002745;
	Mon, 20 May 2024 15:21:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js6cyan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 May 2024 15:21:08 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44KFK19d038962;
	Mon, 20 May 2024 15:21:07 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js6cy5w-4;
	Mon, 20 May 2024 15:21:07 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Eugenio Perez Martin <eperezma@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 3/3] vdpa_sim: flush workers on suspend
Date: Mon, 20 May 2024 08:21:02 -0700
Message-Id: <1716218462-84587-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_05,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405200122
X-Proofpoint-ORIG-GUID: oP9sXgCGj8LQZwW0uhy1kNIupgTo22EF
X-Proofpoint-GUID: oP9sXgCGj8LQZwW0uhy1kNIupgTo22EF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Flush to guarantee no workers are running when suspend returns.
Add a lock to enforce ordering between clearing running, flushing,
and posting new work in vdpasim_kick_vq.  It must be a spin lock
because vdpasim_kick_vq may be reached va eventfd_write.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 16 ++++++++++++++--
 drivers/vdpa/vdpa_sim/vdpa_sim.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 8ffea8430f95..67ed49d95bf0 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -322,7 +322,7 @@ static u16 vdpasim_get_vq_size(struct vdpa_device *vdpa, u16 idx)
 		return VDPASIM_QUEUE_MAX;
 }
 
-static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
+static void vdpasim_do_kick_vq(struct vdpa_device *vdpa, u16 idx)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
@@ -337,6 +337,15 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
 		vdpasim_schedule_work(vdpasim);
 }
 
+static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	spin_lock(&vdpasim->kick_lock);
+	vdpasim_do_kick_vq(vdpa, idx);
+	spin_unlock(&vdpasim->kick_lock);
+}
+
 static void vdpasim_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
 			      struct vdpa_callback *cb)
 {
@@ -520,8 +529,11 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
 	mutex_lock(&vdpasim->mutex);
+	spin_lock(&vdpasim->kick_lock);
 	vdpasim->running = false;
+	spin_unlock(&vdpasim->kick_lock);
 	mutex_unlock(&vdpasim->mutex);
+	kthread_flush_work(&vdpasim->work);
 
 	return 0;
 }
@@ -537,7 +549,7 @@ static int vdpasim_resume(struct vdpa_device *vdpa)
 	if (vdpasim->pending_kick) {
 		/* Process pending descriptors */
 		for (i = 0; i < vdpasim->dev_attr.nvqs; ++i)
-			vdpasim_kick_vq(vdpa, i);
+			vdpasim_do_kick_vq(vdpa, i);
 
 		vdpasim->pending_kick = false;
 	}
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index bb137e479763..5eb6ca9c5ec5 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -75,6 +75,7 @@ struct vdpasim {
 	bool pending_kick;
 	/* spinlock to synchronize iommu table */
 	spinlock_t iommu_lock;
+	spinlock_t kick_lock;
 };
 
 struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
-- 
2.39.3


